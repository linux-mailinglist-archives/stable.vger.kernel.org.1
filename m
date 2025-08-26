Return-Path: <stable+bounces-172991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE53B35B43
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2282E188CDEE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A78934573B;
	Tue, 26 Aug 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1sKF2OVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAF3451DE;
	Tue, 26 Aug 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207091; cv=none; b=fd/79/YleNADhOTquK8C8Fom32b0tdpVDnOZ++Jrhyuuz2Agx8Nz2akgNGckGMJ2KgkyT1rJG1yG4wazfR2YPxZOmdjUfSmuT/8Gle7ulfqQlWEv8jUFQ+MK7S7YROZyY+xs3ovVNW2RbeyfuiGeOv+lI0GFthJG3M7CP67LPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207091; c=relaxed/simple;
	bh=qNu+2n6pKxTX7CrSNizuKRlK3J3vzLqUKC7YnTypEsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNVZarqs+K7PJcVpOoo+14E7GcGRvziUDA3RikL07NY/uN70I0wF8bw7OPlkQpFwVhBbYOMCiXzCEpk5r5Sw4M1KIwD2JEcMMA5iWn0aOdglzvkO+CIqo3WlkHh65j8lzrA3hu1wTHD7ONn+MSdEasHamUYfwUjD6o69X04Kte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1sKF2OVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE8CC4CEF1;
	Tue, 26 Aug 2025 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207091;
	bh=qNu+2n6pKxTX7CrSNizuKRlK3J3vzLqUKC7YnTypEsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1sKF2OVbmo4EAYBTYu9BjXbKi2irFXBxLfJWis9VL1llYYeITC7eYMeqSUKbrrwI5
	 jy/8lrFadYDWKB9oiYhcCgyfCbYxl4HmCo2sHmT1IEP8/q2YEI4FNV7gR9cF0EJHzc
	 gS6seV15Vh8E9j9YqsFbRarZjM9lNkuTkN8PWCnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 6.16 017/457] vt: keyboard: Dont process Unicode characters in K_OFF mode
Date: Tue, 26 Aug 2025 13:05:01 +0200
Message-ID: <20250826110937.750585206@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>

commit b1cc2092ea7a52e2c435aee6d2b1bcb773202663 upstream.

We don't process Unicode characters if the virtual terminal is in raw
mode, so there's no reason why we shouldn't do the same for K_OFF
(especially since people would expect K_OFF to actually turn off all VT
key processing).

Fixes: 9fc3de9c8356 ("vt: Add virtual console keyboard mode OFF")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: stable <stable@kernel.org>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20250702-vt-misc-unicode-fixes-v1-1-c27e143cc2eb@qtmlabs.xyz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/keyboard.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1487,7 +1487,7 @@ static void kbd_keycode(unsigned int key
 		rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 						KBD_UNICODE, &param);
 		if (rc != NOTIFY_STOP)
-			if (down && !raw_mode)
+			if (down && !(raw_mode || kbd->kbdmode == VC_OFF))
 				k_unicode(vc, keysym, !down);
 		return;
 	}



