Return-Path: <stable+bounces-200015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230FCA3A2D
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 13:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1681C3031BB4
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692B932573E;
	Thu,  4 Dec 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qKr3Cw4L"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F12FBE05
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852038; cv=none; b=o5o++lEMhyD4iFAmLtz7g2JIuJtrCjaOc2enbVthBRBsdQPy/l/3qDBjCgbcO1sckzDp39mPRqXJpkzzYmn5aRrWvPGZPS7jUU3bnP85ntWgt130UxCBgHt9tiyefvG7k3e51bzueOkcka4DbIr9FIxconvpTPugXIhknNXNxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852038; c=relaxed/simple;
	bh=+hmYnb9ql2kAyx4q6u9lZVTl1YbBAt8USj35xxzHDa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHOO4sMrP4vGj69weYOZL09XzItO9RDUNzmAYliubHaeXvTsoHGJWWsxFlF8wkywdB0eIBn654yOA7GfE3fPq5b31ipVagei14guEUYGYCRvMNG2JWuL0RwG2uw6rdVb/1qeAvHyuoeJ/PGkbmzgg4qnO4l22PjgZ0yhSeKqrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qKr3Cw4L; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=UE
	x7xW//oNR8UqWBCzxV63YBbgyOpe1P59f2BMGg3XQ=; b=qKr3Cw4LsyqF5Su5tg
	6D1RQEhj2kbWOm4S7DU0S6dmaJ4Lu0DU93vzfdZ2pBjflj5VVNNmWWbHCA9khc0D
	kUKauggD9UvQ9DIEMkq9CakQf5phC4MB1OW+zQyPha3PNMkkJE+o7Qo8CHnC4J4f
	OlQLkX8VE+yuimVgSGXLkjif4=
Received: from ubuntu24.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnV6EGgTFpFM+HEQ--.43758S4;
	Thu, 04 Dec 2025 20:39:47 +0800 (CST)
From: jetlan9@163.com
To: stable@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 5.15.y] HID: core: Harden s32ton() against conversion to 0 bits
Date: Thu,  4 Dec 2025 12:39:01 +0000
Message-ID: <20251204123901.4101-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnV6EGgTFpFM+HEQ--.43758S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyfKrW5Wr45KFWDZr4Dtwb_yoW8Cw45pF
	s8Jrs0krWUKF1vk347KryUuryruas5GFy7WFWDGwn5Za15JFnxJr9avr42qr4UWrWkKaya
	yFyavFn5G3Z3Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR5l1hUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCwxUM1GkxgRXo5AAA3O

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
index a6c2c55daebb..d49a8c458206 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1349,7 +1349,12 @@ EXPORT_SYMBOL_GPL(hid_snto32);
 
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


