Return-Path: <stable+bounces-227867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGJoOFNywGmDHwQAu9opvQ
	(envelope-from <stable+bounces-227867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:50:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C22EB130
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D7B030137B0
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB85372EF7;
	Sun, 22 Mar 2026 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="qHpxKKTn"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227A37E2E9
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774219838; cv=none; b=FxQ+PEg3QhZY+Ayj2L2OCnzaJR+HoYAjQnovbbrn78RuReghDCUw0BbFcryMXcEpOu36jNLB5mYKklXe0WNWNvlQhxmUa2TR4z97FNBgU6ckRFPjBBUFYjhoQuDe0s6dgX5EF8pLEtQcJVTSgdYBzwMvux9fyCydGv0YYnnAzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774219838; c=relaxed/simple;
	bh=NKt2CmEWcZXfwziTA/rm+SpSsbUmPomDYqEGhX+nbPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnhEYT/A6WrwxVNIZdamioHb5iB/fiAlhpg4x9HrMLyXof4JOflE2Qy44tqbwGQqYlMFe6NZjRYoo4zLgRcCRL/oYWmSDmNpD2xGCOgaZa4YRGKOJmrJtqaFtGW4zU/fv1mbcw5v4YIbBgocLUOyok5YHWGMOChnxaK9v3KuToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=qHpxKKTn; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0bcd8f194so4085198eec.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774219836; x=1774824636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBcqWFVY3mntUXBUlKC2Ful/A4x09kKb7ZTmoHge9Jw=;
        b=qHpxKKTny7Ty4lMXmjMeLHOcAmQ54z37ZpyZaiOBrbR7v9fvjRLJR05E4FHZhO9/R0
         +7bJ3f7y054KkeEhXV0V1siJ8URhrInJCHZfDKoNyGXubwXj4Xf52HpQrBcGsEy5bLrK
         6HZIxCcpojx8tr9j8vLyEbskyN1c07N7wZi4feDnCJHgocX5fprW79d8+lolGU2gX9dI
         z+WM32wkRRCwYFoW1jxqzrQemAI2w5pW2J1Ez1ThGWah+Gn4gxu0p4TDUWg5Fe4EhA+M
         xR+2pkM1aPfnffQv9VvxxNoZ79Ec+Q79VtDZaWM0tqS7nJ24oqqATCF7GXh/QFzqPJ2L
         1Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774219836; x=1774824636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wBcqWFVY3mntUXBUlKC2Ful/A4x09kKb7ZTmoHge9Jw=;
        b=BJLUG1sKKWQOsmgtK3VeGGZgaKzZRFrAiPwAxxdS07vegGozZYRda6zOBLoUM02HIs
         /6YCwSkxGpZgIbZhfkEf4PAE+43ShS9FnqAY0Z3A1oSFVKgd6oYagZCSyarXodrNAS8c
         rSJ0oQskotstzeOjBvk7ep0tWsMp8TNVs2ewN5Ocqx4QNNmuaoY+SKVUEz+ucA4yGvRY
         6+sdja+7JV6DMz61SnGp/OXNzp65ftMW/rjs2RVxK0kzq/mV1+NnE3tx/Vt6N9qh9akt
         v4GmOHM9m4gj/LxCPJqkAY0S3h7QFXEVo9AmdkKNK8sbZFad8ryUAde30oq5oNBuJRhL
         Rdnw==
X-Forwarded-Encrypted: i=1; AJvYcCWaHiKMAyFNB2H2ARtdbDtw+XJzX8ddOF6mmJvAOcClx6uKvKTtoyR0zr7aOfvTP2N2UZr8GnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjxojs+V70SuBGLJrUX8duLHR8diyELa99A67XZgpjBJk8KAz
	IAFMvffs6zMFFpMIhIQXCbbQ11xIDWVYo+Ct2xYCu3LZrrvOn2Q4rXO+DQ12P36sBg==
X-Gm-Gg: ATEYQzx+0Nm5lrmcFhkMLbCdb1Twp+BfVh8DuDsvRdqi0PWQ/IWAaLhXesvulfQUF0p
	9DEzLckLjZMnNlSN0EfUxuiXEOHJHUbk6toFwA5sRLj1GwCnk+RQUJZwILoDuyb9LflZzcvWO+5
	sgBcss+eMzE8mfoFhn/XarpzzSZXgKuDOhDD7Wc8VRxI1BZlyjUk/LEJ6TF2XDPBz8RkQJq6riI
	f+HJo8nxPpPRhEOwLdb7sYixBFmxRaglbluj5NuEovvrEGN1Ubnl0v24Jpn8WsdjtR3LIxAkCry
	m2KZ5O2Mn4nkHRCa/lNSnsQcwJ2/BWuA9wi0TgApkXpnnkUOK2JMMWinOU0d+myb+znMq6jWhx0
	zhBow2HBbtZaZ6vcCOJlqtmK3lmYbT7pSR5h0M5n8MQ8TMSlQn8Tmn7MDALi5LgWETIu9DF7OyJ
	D+da4+bFaw
X-Received: by 2002:a05:7301:1406:b0:2c1:3f85:756 with SMTP id 5a478bee46e88-2c13f850ae6mr38940eec.11.1774219835785;
        Sun, 22 Mar 2026 15:50:35 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31ebd5sm10928052eec.27.2026.03.22.15.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:50:35 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	JP Hein <jp@jphein.com>
Subject: [PATCH v4 1/3] USB: core: add NO_LPM quirk for Razer Kiyo Pro webcam
Date: Sun, 22 Mar 2026 15:50:10 -0700
Message-ID: <20260322225012.1817920-2-jp@jphein.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322225012.1817920-1-jp@jphein.com>
References: <20260322225012.1817920-1-jp@jphein.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227867-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[jphein.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A88C22EB130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Razer Kiyo Pro (1532:0e05) is a USB 3.0 UVC webcam whose firmware
does not handle USB Link Power Management transitions reliably. When LPM
is active, the device can enter a state where it fails to respond to
control transfers, producing EPIPE (-32) errors on UVC probe control
SET_CUR requests. In the worst case, the stalled endpoint triggers an
xHCI stop-endpoint command that times out, causing the host controller
to be declared dead and every USB device on the bus to be disconnected.

This has been reported as Ubuntu Launchpad Bug #2061177. The failure
mode is:

  1. UVC probe control SET_CUR returns -32 (EPIPE)
  2. xHCI host not responding to stop endpoint command
  3. xHCI host controller not responding, assume dead
  4. All USB devices on the affected xHCI controller disconnect

Disabling LPM prevents the firmware from entering the problematic low-
power states that precede the stall. This is the same approach used for
other webcams with similar firmware issues (e.g., Logitech HD Webcam C270).

Cc: stable@vger.kernel.org
Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2061177
Signed-off-by: JP Hein <jp@jphein.com>
---
 drivers/usb/core/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 9e7e49712..7c4038a1e 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -480,6 +480,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Razer - Razer Blade Keyboard */
 	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
+	/* Razer - Razer Kiyo Pro Webcam */
+	{ USB_DEVICE(0x1532, 0x0e05), .driver_info = USB_QUIRK_NO_LPM },
 
 	/* Lenovo ThinkPad OneLink+ Dock twin hub controllers (VIA Labs VL812) */
 	{ USB_DEVICE(0x17ef, 0x1018), .driver_info = USB_QUIRK_RESET_RESUME },
-- 
2.43.0


