Return-Path: <stable+bounces-198189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D02E6C9ED57
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32D2334948C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B42F3629;
	Wed,  3 Dec 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IHRb+ENL"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD936D4FC
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761068; cv=none; b=TSTGiDK0b8uha20Cw6ntnyynn3CA7VWUMItJseBiS7EcEzTqFBhMPthudjdOibOuX4pglTT9pH2VDWYKSRNczMyMXLdODzgo7E/XIXzfQ80Q6Jxl8kuJH7qdGh90sU4pk1OFd35iY4tsBWbwc2RP5xB5OtSPe9x7bHjBsKsTYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761068; c=relaxed/simple;
	bh=Lg3wqiOfr2DHne+SBeeaQ51mM8pa2txTU8qLceHJSok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FG6UbdJmhPnzMkkm1TDvfSfh1cMPp6p4AhSuOAUffG7NISPHP++Q7BDAh3B5/I23DKeUB3Qxot6TIDjkHtmASy4e1Ln7I37uQR6TzvmFzJa1/5R1o6Z4XJreMBFGzNc8zVNcPhRHg/O698EnUkSKeRQjs/gqXD7E0kK4ZbFAd0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IHRb+ENL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cj
	ZPu3YdwtjFpdGhJSF8S2cRXusmPK93f2PO4XDlBnk=; b=IHRb+ENLMQJR7BzXvN
	YrIU1stQBC+Gimp+aKNknAABoq15igOaGIb7Ul886vdXiDyjy50pqcuWCLzT8l/l
	pFFm56kECbxB4YZnRHwjbGvQMPnCpsha75go7GTttDIm+attn7dJbkgmxjRGud1C
	dZDjuGwREPXrWl7K2lMzuqaYo=
Received: from ubuntu24.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXVIKtHTBp8hXQDg--.56228S4;
	Wed, 03 Dec 2025 19:23:35 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y] HID: core: Harden s32ton() against conversion to 0 bits
Date: Wed,  3 Dec 2025 11:23:18 +0000
Message-ID: <20251203112318.4289-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXVIKtHTBp8hXQDg--.56228S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyfKrW5Wr45KFWDZr4Dtwb_yoW8Cw45pF
	s8Jrs0krW5KFn2k3y7Kr1j9ryruas5GFy7uFWDWw1rZa15AFnxJr9avr42qr4UWrWvkayY
	yFy2v3Z5G3ZxZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR5l1hUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxBnbpGkwHbmY4wAA3k

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
index 266cd56dec50..d8fda282d049 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1351,7 +1351,12 @@ EXPORT_SYMBOL_GPL(hid_snto32);
 
 static u32 s32ton(__s32 value, unsigned n)
 {
-	s32 a = value >> (n - 1);
+	s32 a;
+
+	if (!value || !n)
+		return 0;
+
+	a = value >> (n - 1);
 	if (a && a != -1)
 		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
 	return value & ((1 << n) - 1);
-- 
2.43.0


