Return-Path: <stable+bounces-198191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F350FC9EDA2
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F1B3A6060
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2442F3C39;
	Wed,  3 Dec 2025 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X4ntlmj7"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC9278161
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761751; cv=none; b=N6HNo5P1uEBqzsK2RXlcs+PzUUemNX/5FJbMXID9ls49fyKdKAd2zEYuQ1sxU8ghGmqQ3kTDWBMJCNGrCkq/vY+rLpD8eo20OBjaD6Lf/M17UxaA34HjLJrZ4r11ii1576UACjOB1imI4NvYEB23fFtnDVxafp+7VGLr7gnEh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761751; c=relaxed/simple;
	bh=ihDwiZJdkab5PrrlCLCTIEN7z83GYgkXdV1/u9FcJDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kK8JAJZUFmncAywVtXlTFd6PYUYFmsJUQmBopPWoWsLC3q/uRLq8AoB5/MD292xjNXNjMuUMSXEcMlkiMQwM8MYnD9routtC16PSLP6GRS49Ri629uP+yoT7qByKuP5w4m0swXgw+ZL+apCxvJ1CsL4WyIci1FWkgbAf4uqs8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X4ntlmj7; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=y7
	CgB7qJpEzR/35qS0l7nMX4H1RxSNftD60L8UtGQxQ=; b=X4ntlmj7kk9KojYU1W
	r81bIRwWSGGVoFSZXcYrqU8IYTkd2HwUZWzcfqV6NMrCelavoR8+QrSbupWsKFOH
	iuk9X7dlJZ9G2zNt04vnwGaYQUx+eRCOY3TCb+thBjEnuePo+EF5D9t96PcQbZwG
	XAvvbmqfDVPtdVpZUhRalwESU=
Received: from ubuntu24.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCXAt4DHjBp5cdYFw--.28792S4;
	Wed, 03 Dec 2025 19:25:01 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] HID: core: Harden s32ton() against conversion to 0 bits
Date: Wed,  3 Dec 2025 11:24:50 +0000
Message-ID: <20251203112450.4314-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCXAt4DHjBp5cdYFw--.28792S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyfKrW5Wr45KFWDZr4Dtwb_yoW8Cw45pF
	s8Jrs0krWUKFn2k39FgryUuryruas5GFyxWFWDWw1rZF4rGFnxJr9avr42qr4UurWkKayY
	yFyIqF95Ga13Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRoUD9UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiOgcZyGkwFWbQIAAAs2

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit a6b87bfc2ab5bccb7ad953693c85d9062aef3fdd ]

Testing by the syzbot fuzzer showed that the HID core gets a
shift-out-of-bounds exception when it tries to convert a 32-bit
quantity to a 0-bit quantity.  Ideally this should never occur, but
there are buggy devices and some might have a report field with size
set to zero; we shouldn't reject the report or the device just because
of that.

Instead, harden the s32ton() routine so that it returns a reasonable
result instead of crashing when it is called with the number of bits
set to 0 -- the same as what snto32() does.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/68753a08.050a0220.33d347.0008.GAE@google.com/
Tested-by: syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com
Fixes: dde5845a529f ("[PATCH] Generic HID layer - code split")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/613a66cd-4309-4bce-a4f7-2905f9bce0c9@rowland.harvard.edu
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
[ s32ton() was moved by c653ffc28340 ("HID: stop exporting hid_snto32()").
  Minor context change fixed. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/hid/hid-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ed65523d77c2..c8cca0c7ec67 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1354,7 +1354,12 @@ EXPORT_SYMBOL_GPL(hid_snto32);
 
 static u32 s32ton(__s32 value, unsigned n)
 {
-	s32 a = value >> (n - 1);
+	s32 a;
+	if (!value || !n)
+		return 0;
+
+	a = value >> (n - 1);
+
 	if (a && a != -1)
 		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
 	return value & ((1 << n) - 1);
-- 
2.43.0


