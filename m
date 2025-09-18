Return-Path: <stable+bounces-176291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29733B36B83
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458327BAD7A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51CB352060;
	Tue, 26 Aug 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DvNpHzds"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E403568FB;
	Tue, 26 Aug 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219274; cv=none; b=VFRd8yT9g8UeRHZpx7DVII1LTsSM992gumQteCQ5pnoX7+zAwihfGoWFHmcnv8H61cA9B+dOObZ0V7/GbaGy1CNZ52uvGe0LasiZ0KfrmMfatHg0nqamLTqg38P2hTwXYyKDy/hjDup/B0LBixF3zbtyCYd3dPdY0bqEJxPgB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219274; c=relaxed/simple;
	bh=nbFuEM22kyThgSQCfI2u3KQ9hsu6WIt7M1/ZbhzABDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdXXlpvICnSug/nuDtEZczF1N2+fUkdsQoBXmeSfZ+spdx2gfllGR6tapexoGBhiQ1KjStus0PaAWFz3+CovlA79M6EwHYZyGecCDt+raoaqiedOX5LyKNVaXtpTJkfRCzbSfpGO31Mv7MXWBORpBFfUPokaCKbZAAGCjPPDJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DvNpHzds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E41C4CEF1;
	Tue, 26 Aug 2025 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219274;
	bh=nbFuEM22kyThgSQCfI2u3KQ9hsu6WIt7M1/ZbhzABDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvNpHzdshNhpCxOVTBj4Z+iBaKcbPL6GUSYvd+hmmB5EEE83ECRpZEKksSs9kNZ9e
	 IqGXTJkC9vAQnlu1T/fCCVWFMyXHALHOLReJoBol0r96RT+aVr9P0EE43hOEvBCpRR
	 HpMJume8kqNPO7rmhY9jjKcQdVcwidiVZUQhhg7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	stable <stable@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 5.4 288/403] vt: keyboard: Dont process Unicode characters in K_OFF mode
Date: Tue, 26 Aug 2025 13:10:14 +0200
Message-ID: <20250826110914.768864113@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1460,7 +1460,7 @@ static void kbd_keycode(unsigned int key
 		rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 						KBD_UNICODE, &param);
 		if (rc != NOTIFY_STOP)
-			if (down && !raw_mode)
+			if (down && !(raw_mode || kbd->kbdmode == VC_OFF))
 				k_unicode(vc, keysym, !down);
 		return;
 	}



