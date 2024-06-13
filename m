Return-Path: <stable+bounces-51097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB60906E53
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D6E1F21344
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE31448C4;
	Thu, 13 Jun 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CoKay+ZW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D9143759;
	Thu, 13 Jun 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280300; cv=none; b=QkukzmYmnOQXLOocop/ezAz7fn+w3xVV3qg9aHbMR1SlaK3r1YYG9tPyQg1a7fiQyHDJd/6ajHDAc/qlD4EaRFthpK47n4al6vz/VSV/EergljwqSp29iK9fqPEmzWpUvupn4gmJ1wKulD5XHFi5eR4aV/EePbXpgTiH6ghz9mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280300; c=relaxed/simple;
	bh=nKw5HRci6a/pmEGokY+7nShtI4tXi8RJtB2tAePqmIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8fogZeTwcxBaFvtQV/gZg/3P3NdYmWeZ15wZDx0aOC5l63GCV8+kHdPCa+pfWkp+GveCJw90grt9Rv+Lg1AKYseD1JXpSMHTeIFSM8nMijQcWYyazJBQ6TyGhrSkQ1hZblaOeUcNvP3Ql4crmBUbkGlr3usXFH9m01V0CZxhl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CoKay+ZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C16C2BBFC;
	Thu, 13 Jun 2024 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280299;
	bh=nKw5HRci6a/pmEGokY+7nShtI4tXi8RJtB2tAePqmIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoKay+ZWycqe4ZftjhY3CESEFMW0TkpUnDzPS/7ZKGpYqO5+pQHG3PeuwZIL+yFO2
	 IoWtS76tE0JLk4RHMCAhH5ltjGvg6/cqgtyGj2snPEcRcyAnxh0l/vgFIy3fytjtoW
	 wZxuV/lGUWRpMxXh5oUlVQFWEbq3Lnf7XnHZKl8o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 5.4 194/202] kdb: Fix console handling when editing and tab-completing commands
Date: Thu, 13 Jun 2024 13:34:52 +0200
Message-ID: <20240613113235.228126769@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Thompson <daniel.thompson@linaro.org>

commit db2f9c7dc29114f531df4a425d0867d01e1f1e28 upstream.

Currently, if the cursor position is not at the end of the command buffer
and the user uses the Tab-complete functions, then the console does not
leave the cursor in the correct position.

For example consider the following buffer with the cursor positioned
at the ^:

md kdb_pro 10
          ^

Pressing tab should result in:

md kdb_prompt_str 10
                 ^

However this does not happen. Instead the cursor is placed at the end
(after then 10) and further cursor movement redraws incorrectly. The
same problem exists when we double-Tab but in a different part of the
code.

Fix this by sending a carriage return and then redisplaying the text to
the left of the cursor.

Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/r/20240424-kgdb_read_refactor-v3-3-f236dbe9828d@linaro.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/debug/kdb/kdb_io.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -380,6 +380,8 @@ poll_again:
 			kdb_printf("\n");
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
+			if (cp != lastchar)
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
 			/* How many new characters do we want from tmpbuffer? */
 			len_tmp = strlen(p_tmp) - len;
@@ -393,6 +395,9 @@ poll_again:
 				kdb_printf("%s", cp);
 				cp += len_tmp;
 				lastchar += len_tmp;
+				if (cp != lastchar)
+					kdb_position_cursor(kdb_prompt_str,
+							    buffer, cp);
 			}
 		}
 		kdb_nextline = 1; /* reset output line number */



