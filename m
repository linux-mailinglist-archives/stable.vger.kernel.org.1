Return-Path: <stable+bounces-200536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C342BCB20A3
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 06:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49273302A968
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939D7311955;
	Wed, 10 Dec 2025 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9XEo5rx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3727B32D
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765346206; cv=none; b=AbYKYoEYBQJYCT4NTZ0pZw61T3nlVkwoGF9rRvbn0RR/BqNgROOF6YAjF5zKl8BEEy7IzH1lKHm+OTfQPDxPIc/m/rYQTBFNYctjrcXMbdIWdeky52OuIf6wvWISdeWldnJSX4xNLtkrivF3A/uwhwB+mR4CU9yednbGfKFtgiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765346206; c=relaxed/simple;
	bh=3VrvE79aK98YEd8Nk0OCa9UWFkNGSHnO3fUoP8RMrCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QwP/DkpL7gCoqrio+ovwJPObAbMJwCCO5kPzfkThC3WHtoQPMc1U/3dFUanbGo3y+E3CYYjnTmPxVjB2WuI3g+1yvxS5EFpZ6uoinsP8FfDzyogoYVEZbfOQ6PR8Rsn93LpxO4380jJ08qiadgiKL6SHIVsiTSsRWDZKFSnvOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9XEo5rx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29e93ab7ff5so19281115ad.3
        for <stable@vger.kernel.org>; Tue, 09 Dec 2025 21:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765346204; x=1765951004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IDQig3y5Ta7nqnpRczp5de7VIJ3mi4WA81mEUrsxxk=;
        b=J9XEo5rxGF5KFgzMmyvWeFzuicpLzrz6pNdV5F0NnRrGHYJCLGTud/I5SUGaxRWL3K
         rJKc7+N1XKm/TOWeaKOb1c9rnGSF8XRPhCmwxJlM1onwHvQKvHyb2gWIXQ9ndnNThaUk
         wpFmNN2Qw0/5FeZnEKN2nFC5CvFWecpuyuaKv18iqyACUZJv9J8edRuej6uZQWI81gbn
         391EBV1IvidZrrGlDgzVgaFCrdVlEB8R8npGfxjY1w33lzPv4yG+oMfJZO3zdYTNOR3z
         LeEmmaHd+wdYzOgemIno7p3Y9CUR7VTiWGlCh9VrBXeqomDeGjP3F7nqzr1+3Y76qWP/
         674g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765346204; x=1765951004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IDQig3y5Ta7nqnpRczp5de7VIJ3mi4WA81mEUrsxxk=;
        b=oF4v5zsHcU31OXxHcc+0aTJ0b1LxCrsHQFxa+XMGaOw+lg6mFH/RXLdaLE/DKrUXN4
         wKkjIewqUS8+q7EypUU2lB20noUJBL2VfQ2gjMAyiFCnxYzSZlrrNcY9c8b6TY9j5oCu
         Clknzv8rFFh7nAW8Gt9tLwJQdw8XvN8IwwXK1fWqmbGSdq5zOAWYuYHtRLA7KP41Hvhx
         i9eN3g8q9PBygxO+7lb//vd/eHupXfHjmKe8ew0jxRX5Ez3JTK0NEDtQjrl6bkae4jSd
         C7JNvFBBB9sfePFJyFKEJ9tObKXuPWcTwt+yT9qX/5bpw+FmjWLiyUqI3aBLcSKedaC1
         tUuA==
X-Forwarded-Encrypted: i=1; AJvYcCUztJQvnBOqv493YNn4uMPDinWlS4zmuWcHd+dOo6DmFRVkvwASofGTGTnPoD2MdtOao/qUSrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEqQgHkgQui4qDY5z/JGAMO76UGiKeKyunB5GZ/kQdIh6VgoT
	yxgDxOl+F/U7Q2ax0n5evjhVSvnkfjs8wjz+rNem/oTh+/xqLA0D3CWSBinRRiWv
X-Gm-Gg: AY/fxX7XWjXFTNwTp7gfvFwPHh8DlJca8Ro5MvlkpURbem7YSTy8FKJTiYQEj8llhAh
	IXhXhF2rUSBstT2TppnPgwlqVZLiGqxdJNJ27GXVU0nCVrIWH+X0OC6UOSREqySs1rUYPBx41tW
	07VI1TZQdXkeLpROZGM1RNT92Y+mYH50whcT9bXCmbmaq0KHtKCkv05i9ddrp3QHuCSR7Kk2bBT
	nenpN4fSiFftUQNkBAQhG/JKAkt9jJqNejDZDpGF/JtpxbT4JMxv3szVGAomQhTbvE3H+Rj5JWb
	FtHkhyLRp0UqegVyAk09UHvHQVORODhDVsUWG53ofbNjGEW4R6WEoT/paasaNybdUzBgkBTdx+b
	iEgxoqqt/FRJFAXuCKmD2y5qdfw0El925dPEyCAJm8blacYiXaUIU2ew6k9UI0RjcJ6I0Fs+gsj
	N5F4laFi9PajvSI1jXzQiY3JlzRcSMrbuY
X-Google-Smtp-Source: AGHT+IEt5LhlIKtAeP5QvPrTGN2SDdkW9Yk6hicFPvLxo0MckItbfuwnVdzVsDPTVn7BhFWCHNsR5A==
X-Received: by 2002:a17:903:2347:b0:295:395c:ebf9 with SMTP id d9443c01a7336-29ec27f1742mr12787495ad.55.1765346204228;
        Tue, 09 Dec 2025 21:56:44 -0800 (PST)
Received: from localhost.localdomain ([38.134.139.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49caa4sm173741385ad.15.2025.12.09.21.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 21:56:43 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	micha@freedict.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+d99f3a288cc7d8ef60fb@syzkaller.appspotmail.com,
	dharanitharan725@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] media: dw2102: validate I2C messages in su3000_i2c_transfer()
Date: Wed, 10 Dec 2025 05:55:33 +0000
Message-ID: <20251210055532.25737-2-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

syzbot reports a general protection fault caused by su3000_i2c_transfer()
dereferencing msg->buf without validating the message length or buffer
pointer. Although i2c-dev blocks zero-length messages, malformed I²C
messages can still reach the driver through the DVB USB subsystem.

Add strict validation of each message to prevent NULL-pointer
dereferences.

Reported-by: syzbot+d99f3a288cc7d8ef60fb@syzkaller.appspotmail.com
Fixes: 0e148a522b84 ("media: dw2102: Don't translate i2c read into write")
Closes: https://syzkaller.appspot.com/bug?extid=d99f3a288cc7d8ef60fb
Cc: stable@vger.kernel.org
Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 drivers/media/usb/dvb-usb/dw2102.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 4fecf2f965e9..0dd210ea16f3 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -733,6 +733,36 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		return -EAGAIN;
 	}
 
+	/* Validate incoming I²C messages */
+	if (!msg || num <= 0) {
+		mutex_unlock(&d->data_mutex);
+        	mutex_unlock(&d->i2c_mutex);
+		return -EINVAL;
+	}
+
+	for (j = 0; j < num; j++) {
+		/* msg buffer must exist */
+		if (!msg[j].buf) {
+			mutex_unlock(&d->data_mutex);
+            		mutex_unlock(&d->i2c_mutex);
+			return -EINVAL;
+		}
+
+		/* zero or negative length is invalid */
+		if (msg[j].len <= 0) {
+			mutex_unlock(&d->data_mutex);
+            		mutex_unlock(&d->i2c_mutex);
+			return -EINVAL;
+		}
+
+		/* protect against unreasonable sizes */
+		if (msg[j].len > 256) {
+			mutex_unlock(&d->data_mutex);
+            		mutex_unlock(&d->i2c_mutex);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	j = 0;
 	while (j < num) {
 		switch (msg[j].addr) {
-- 
2.43.0


