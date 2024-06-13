Return-Path: <stable+bounces-50722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1D906C2F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497441C20BF0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9C1448CD;
	Thu, 13 Jun 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVswZtWd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904A143C7A;
	Thu, 13 Jun 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279195; cv=none; b=fl8XPzHckvJqgV9ibBLWbOeKb63Xp/3sG/CB8g52gLtI0b/e8ToHwfx78cHJs/7M/TPPNxWpdsAiLJxkaeXPSO40OOCu4voWKbOm5okWSLCuOmMRFt4wCWjheBbPDb9TuYWmOItKmXyVlSDC8v5Zak7QXIG7bGkDwSuBEqFkHMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279195; c=relaxed/simple;
	bh=0oJND+ZqKBLlAni9PamumLLIDLPU9p7w9LoW6FRHZQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7NstaXV8Y0XxFqO5hAflKGYOpA/rZDAxKQVqcJLPu3KD2/fALbXoRo/ZsrTLHG9nTL/aBWYd1o+VvIGp6DoHwJMii+81EpbNYi/WGWyzy1buGaEci7G6p5l1ZVk/Jj27iZUUquDQN4Q6cTBuLhdHtlDcMxF9ad+FJy5qNI5kcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVswZtWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F30EC2BBFC;
	Thu, 13 Jun 2024 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279195;
	bh=0oJND+ZqKBLlAni9PamumLLIDLPU9p7w9LoW6FRHZQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVswZtWdKOh9zncx3rNs705jMTmhwfM22ZRVu5sV8iQY2Gnvwa6AxmoByjsxMQ5ts
	 4CmC4VDzrXJrfOJ/1TBg/5qFoWQv69t4l2CTRgah/ZvYfUpflmXLZxwWl6uDEeT4wC
	 h7ClDlWwYaZ12QsnlLRTSriWOGxwewhlv/MwvVi8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.19 207/213] kdb: Merge identical case statements in kdb_read()
Date: Thu, 13 Jun 2024 13:34:15 +0200
Message-ID: <20240613113235.968082488@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Thompson <daniel.thompson@linaro.org>

commit 6244917f377bf64719551b58592a02a0336a7439 upstream.

The code that handles case 14 (down) and case 16 (up) has been copy and
pasted despite being byte-for-byte identical. Combine them.

Cc: stable@vger.kernel.org # Not a bug fix but it is needed for later bug fixes
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Justin Stitt <justinstitt@google.com>
Link: https://lore.kernel.org/r/20240424-kgdb_read_refactor-v3-4-f236dbe9828d@linaro.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/debug/kdb/kdb_io.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -314,6 +314,7 @@ poll_again:
 		}
 		break;
 	case 14: /* Down */
+	case 16: /* Up */
 		memset(tmpbuffer, ' ',
 		       strlen(kdb_prompt_str) + (lastchar-buffer));
 		*(tmpbuffer+strlen(kdb_prompt_str) +
@@ -328,15 +329,6 @@ poll_again:
 			++cp;
 		}
 		break;
-	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
-		*lastchar = (char)key;
-		*(lastchar+1) = '\0';
-		return lastchar;
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;



