Return-Path: <stable+bounces-51957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73511907262
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16036281AB5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A414374F;
	Thu, 13 Jun 2024 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VhO321EZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610E142658;
	Thu, 13 Jun 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282813; cv=none; b=gRsxoDGchV5Js4yShN7sZBv+XgOE+66wsukcvcZc5VcGWTehpapMFItcZfq1ZK0ok4a/eIHSZCq9S2bB8lOST+gpg+0UvCXMDigsj2IvCA2uht6F10XSPt4KH4+Saxq6FU7B/aoBGAcV9qOefHlNaex3LMsCeHf4JCVAjwVmVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282813; c=relaxed/simple;
	bh=ASmOep0ouQHl19LHG5i8ieE50+mIZiwfgqSqXTOzo8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gny07z/FdVu6oRcVi4zh8BXI00uq0QZ2015RkIx+dUFw3dBeEq6UMJXAoqncVYOa5c/LX/DhvGiD2DBw0eUcXRQaQDkNu7n+WxBzEVDb7xYAGW8RQlaQnRVk54U6rnU7G1FvdMByh+vvPlXKgt0xUgu7d0fQcdnSHRj/6N+GsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VhO321EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2B2C2BBFC;
	Thu, 13 Jun 2024 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282813;
	bh=ASmOep0ouQHl19LHG5i8ieE50+mIZiwfgqSqXTOzo8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhO321EZYbDmvXZK83EgGRwQwz1m4E+RocoV4GpLb66g7qTcvEUhaCLl1LztLZLyc
	 J4PNETA/t45u1CmfeKk+9nElbDEhPazh0td9sP+ixL/hmAkYhLudiETvbFxFvqWzhL
	 JaFygubEUxlFFFa5iF38IR/1UzMe99kONmaVXK9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Stitt <justinstitt@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 5.15 386/402] kdb: Fix buffer overflow during tab-complete
Date: Thu, 13 Jun 2024 13:35:43 +0200
Message-ID: <20240613113317.202038979@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Thompson <daniel.thompson@linaro.org>

commit e9730744bf3af04cda23799029342aa3cddbc454 upstream.

Currently, when the user attempts symbol completion with the Tab key, kdb
will use strncpy() to insert the completed symbol into the command buffer.
Unfortunately it passes the size of the source buffer rather than the
destination to strncpy() with predictably horrible results. Most obviously
if the command buffer is already full but cp, the cursor position, is in
the middle of the buffer, then we will write past the end of the supplied
buffer.

Fix this by replacing the dubious strncpy() calls with memmove()/memcpy()
calls plus explicit boundary checks to make sure we have enough space
before we start moving characters around.

Reported-by: Justin Stitt <justinstitt@google.com>
Closes: https://lore.kernel.org/all/CAFhGd8qESuuifuHsNjFPR-Va3P80bxrw+LqvC8deA8GziUJLpw@mail.gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Tested-by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/r/20240424-kgdb_read_refactor-v3-1-f236dbe9828d@linaro.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/debug/kdb/kdb_io.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -354,14 +354,19 @@ poll_again:
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
 		} else if (tab != 2 && count > 0) {
-			len_tmp = strlen(p_tmp);
-			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
-			len_tmp = strlen(p_tmp);
-			strncpy(cp, p_tmp+len, len_tmp-len + 1);
-			len = len_tmp - len;
-			kdb_printf("%s", cp);
-			cp += len;
-			lastchar += len;
+			/* How many new characters do we want from tmpbuffer? */
+			len_tmp = strlen(p_tmp) - len;
+			if (lastchar + len_tmp >= bufend)
+				len_tmp = bufend - lastchar;
+
+			if (len_tmp) {
+				/* + 1 ensures the '\0' is memmove'd */
+				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
+				memcpy(cp, p_tmp+len, len_tmp);
+				kdb_printf("%s", cp);
+				cp += len_tmp;
+				lastchar += len_tmp;
+			}
 		}
 		kdb_nextline = 1; /* reset output line number */
 		break;



