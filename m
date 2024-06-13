Return-Path: <stable+bounces-51195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02016906EBE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8141F215C5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E722214374B;
	Thu, 13 Jun 2024 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ph0fCp2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF86EB56;
	Thu, 13 Jun 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280586; cv=none; b=fjx6o5R3Ue/5GUV0XtHQgV9pIp8RcVsQ0TNQ7vDEBFHeeSAzOk3HBRQ29lVQrbpXoMRUN5SRmmMIL2YPXuF10Nov1MS8olBhMb6q/DludEbCJLyBXi/5Gife+d7ucsokTzbaQq3mSsYphyblOmwhttYjejAayqfWR+h3iaFjnvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280586; c=relaxed/simple;
	bh=obCPeF1UoSTYHgwSfwWJvWgbFN6xIFRbgLBR1KhUYds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AahMetMUcICj9FPJZVEoKy5lN9sx4NJI/EGrjvUmJkr8leVS4vHnSO3HzoV+djt9EroRjvgxZx4WTtoyVHucWznCm+q9p5Xm4ZIzYfhnBMtGZGv726peioFzWafrB4V482ZnlxpozKrrkW6eS8SY2S5qN6R/L+FaPPHJ0Z+wdrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ph0fCp2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB2FC4AF1A;
	Thu, 13 Jun 2024 12:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280585;
	bh=obCPeF1UoSTYHgwSfwWJvWgbFN6xIFRbgLBR1KhUYds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ph0fCp2em8kvGrGj6SFB0ZlX3AIbW2Kg51wPRRnM3ot1UU6orDu9hM++RaeR7+9JS
	 VTobZ2vJ222uW/zhu2bSRrHYZJRzDAKAQ7bowAGhdLwsRtX6OXEVKvRy94Ybx3HPva
	 XelZo/Ht1BJeZonjTTy4WESQ2Y4O+cno/Mn8xQSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 6.6 102/137] kdb: Use format-specifiers rather than memset() for padding in kdb_read()
Date: Thu, 13 Jun 2024 13:34:42 +0200
Message-ID: <20240613113227.254956294@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Thompson <daniel.thompson@linaro.org>

commit c9b51ddb66b1d96e4d364c088da0f1dfb004c574 upstream.

Currently when the current line should be removed from the display
kdb_read() uses memset() to fill a temporary buffer with spaces.
The problem is not that this could be trivially implemented using a
format string rather than open coding it. The real problem is that
it is possible, on systems with a long kdb_prompt_str, to write past
the end of the tmpbuffer.

Happily, as mentioned above, this can be trivially implemented using a
format string. Make it so!

Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/r/20240424-kgdb_read_refactor-v3-5-f236dbe9828d@linaro.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/debug/kdb/kdb_io.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -318,11 +318,9 @@ poll_again:
 		break;
 	case 14: /* Down */
 	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
+		kdb_printf("\r%*c\r",
+			   (int)(strlen(kdb_prompt_str) + (lastchar - buffer)),
+			   ' ');
 		*lastchar = (char)key;
 		*(lastchar+1) = '\0';
 		return lastchar;



