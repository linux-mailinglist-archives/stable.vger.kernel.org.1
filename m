Return-Path: <stable+bounces-159247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDC7AF5B0A
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E533F3BF69D
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2DD2F5320;
	Wed,  2 Jul 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="dByuurFW"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4E284B59;
	Wed,  2 Jul 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751466281; cv=none; b=OjrWkWB3tTezCO5toHA7YpRCFoAz0q7EDsAsN9G+rpF0fLls8MsG8lxPBtj4rJ2HFYikLgS8YKMIgkQrXxTaBi0FyRML7/H/h5CTPISj7mYIzDmuSRTzILF0mvIL9dHCTwO6xGjwahDRydEKrvHAy7A9yaYl5eMGwmapBvURUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751466281; c=relaxed/simple;
	bh=42enfHLG6cfNiaEjJHnbblEVWFwvWh66a7kEyLQuBf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcsPD23koNDjRGV7vHQrK8Ec2jfr1MdT/eVxvQBxBBvLyuLjYpUjIMuNzTDyLL1M1VyZNvV77xGD0X2YG8Yh5r7JUCJnDqAcSXNcq1lA33mOWCFARSGbL7itVmH+JwR6NT/R9i/ZCZOfZZnbNVVSSmMXUDy46hm3m5y/HgcyBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=dByuurFW; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1751465890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jW7B+eDhvtKXFGV2Da40CWXDKxHSIJi1LBifNkbEzM=;
	b=dByuurFWZFdoUIzP4jdcRSW0vj9OxrKlJvOI7l3sxb93CpelirKOJ1n1mdSJwcaZfqa8i8
	UuMFaHt0jNvtY8Fpxi4LsYmb1+CgHGnQb5TJRnfuH5/J5iSS2Fuzo9lfCxIvMT536YELro
	4orX7uu4jC9A0sIhXLTnKNQiVa+mvd5hl06x55qw4P2G9WiENRzbp2qw7/jENUsYPmHW2Q
	ZOAUJBBeEex28Gp2i8EuKtE7y6bWsZdc3TA/yu8qBxW3SPkYlf/uZDuysVza/Mg6BH3Q44
	zt8GNb2wzA0DjMu68lbgNZtqRf4moJoH+VM3sTIDy+hhP5+MUnOQy1i1S8hiLg==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Wed, 02 Jul 2025 21:17:57 +0700
Subject: [PATCH 1/2] vt: keyboard: Don't process Unicode characters in
 K_OFF mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-vt-misc-unicode-fixes-v1-1-c27e143cc2eb@qtmlabs.xyz>
References: <20250702-vt-misc-unicode-fixes-v1-0-c27e143cc2eb@qtmlabs.xyz>
In-Reply-To: <20250702-vt-misc-unicode-fixes-v1-0-c27e143cc2eb@qtmlabs.xyz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Arthur Taylor <art@ified.ca>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, stable@vger.kernel.org
X-Spamd-Bar: -------

We don't process Unicode characters if the virtual terminal is in raw
mode, so there's no reason why we shouldn't do the same for K_OFF
(especially since people would expect K_OFF to actually turn off all VT
key processing).

Fixes: 9fc3de9c8356 ("vt: Add virtual console keyboard mode OFF")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Cc: stable@vger.kernel.org
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dc585079c2fb8c92d37284701f15905a24161768..ee1d9c448c7ebf2f1456f6bd18e55a9681b036c2 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1487,7 +1487,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 						KBD_UNICODE, &param);
 		if (rc != NOTIFY_STOP)
-			if (down && !raw_mode)
+			if (down && !(raw_mode || kbd->kbdmode == VC_OFF))
 				k_unicode(vc, keysym, !down);
 		return;
 	}

-- 
2.50.0


