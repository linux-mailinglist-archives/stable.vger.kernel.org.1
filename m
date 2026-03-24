Return-Path: <stable+bounces-230042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAMtCQXwwWkgYAQAu9opvQ
	(envelope-from <stable+bounces-230042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 02:59:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97381300D13
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 02:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 832503080F96
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 01:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B09E37C0EC;
	Tue, 24 Mar 2026 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4XLOaHu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9937B022
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317351; cv=none; b=koLyHUwZbwiWoVGYeCByOK7Y2y/4lZqLc6grgPPR9dv95kG+JfoJrtFtq8QyNhAJljgAO0L9JSPnKJLvhYB+fzeNvF27/hg8HFXDBZ9ktX/Y4cK1LIm/6A33LqgwSKTB4IMeJQjwTVBhxQDo8o/KX7E4cYmEayZZUHHwbGsSJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317351; c=relaxed/simple;
	bh=JAmtHZt+i8fAEau+uDnuiufAN/CVFZtpCZ5Dsp1wVvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4WZ6YaspWnzeEoLejGR8p2Y8FJrtJKLsugVoThdw81BHFrdYhQbTK9aa/NsGeP8zA0dgTusZJyWo7plhF8mL86Gtag+3WiuWrwxbA2q+39G8uZgopBxiGzwhG3Ja0Rqvo7vAhTaXKV2QDRXYf+nrq7wgHDspmtDoku2YDRKVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4XLOaHu; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c73a5473bbdso1475758a12.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774317346; x=1774922146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLM6YKJgxLhPQDfQX2m4g/wult9s4kqFfxzN0AZd8EI=;
        b=j4XLOaHuhZ2iTswdI9GuXJ9IKVneqnM9QgyaYLvukmWdRwQJTM7uisKuy1sjEs4DlD
         P2Te6ClQiLOqIaIejfv67VTzB6Qgz018iat3DOljC1DU4QagGm2hq2ZAa65ka3Hrp69u
         FBh5FcmB4Nt4T18XBZzM2nD2qg7NeZA9qe3sbKS0D2OVlTNm9kEor/ooVr6LSUjeKIx0
         FBNocZrTwYStQOcKFYcKNCjHRcHddsadljs2mSSV5jfqwb46tCC5ELZNQBZrB1y7c9BV
         9xLB1N3UhXofCFiAJ0hM/KIvy1S60pGqxqL535mmOy2aIYrLO7Go0ccSFCt5dk0thWMC
         E9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774317346; x=1774922146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLM6YKJgxLhPQDfQX2m4g/wult9s4kqFfxzN0AZd8EI=;
        b=Nv27gg+iq8qIR7xbwC91WTJe/o7XY2u4Bg+6B38/70C7Up0ua5kkfReRn6ZmOdvp3U
         fiKjc3bC2bSa+FqwQLu1MLT9IWFwD2bMt/e8W0J0PnOAbA4PYxlP2M1ljRmjU0N1cgNi
         AH/Bx8B7PC7qDX9h9tCBOoUN1Uj2CQwBGz/z33/DhOiBaAVsSGYtkdoMfu/x63bRWtuJ
         2EqY0vM90dyu0nG5I9LajSu66hSJzeKoSSPHqzm6JpMJEqb1Id5wf8pZr+UewHm7UfLZ
         8xE8Q+SLg8y2dyLNqNhFgIEPvP5fToPIPPtp306YgBxZVkWAZOW+d6wux19XY3FaEZGv
         /b3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBOgIy/HGYwvxFm2FcGeK6IyRhBhx+LscU6vht6oKbwxShPjuwWtlXkXwK4DTQ8VdfzknD72c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRrtwJ/V2uvqU1aCQU59EDu08qPEY4Okxc6eKsqVD6L0vu3qhY
	dRiikTQUYh/8DZpo+xtlEynEYgSeMMuxaDkxhlAp4xg3SAYKJHLB3ih+
X-Gm-Gg: ATEYQzy7knMPaNtN1QxIJuZaQcdzxdog1NUUx1JKQpk2jYqtEDi80fc+d7nxyU1WgpT
	bqHdoNm3FOqMt5rgxAFN7nB4Ul04FHJWpYbrdBls7Ks5OwwZ1Qlx1tLOkOnft5QHGpWvPUT5vjW
	HLaJXtGMMOqk+7+dfppGizhyzqGPbINTLirSswfNqYPPw/QNchFSKS3u8wKvG9xY8mtHKmqqAGg
	QKkLvzjLDaqx2GlFiGDb5iBU7Zlt+PL7tP4vcMrUdbRoqcqlAdJIw1i3xBdXf4NID3pBmd3mXVe
	Duy7jfleFVY62ZXhpu7Lpv2OKjtfiLQfMECyOj4kyUvpRt+FZ/rszbghqYedHdR9+dwAThn8Ymd
	VMNQ692SEXrly4TCNNr+DNbbNAokQ/LmfoO6LCvUhAsXhnXphvALvjUSC/3LzTrrJvSiZrt2AZh
	Xki9FV0hYGoEsPulRwfe0l9+lMPu6F1XFZC78p+X4MP8NzNCtDirZLHBtfqO20hLgCgTPvmUBza
	recZw==
X-Received: by 2002:a17:903:b0e:b0:2b0:4b3a:9b49 with SMTP id d9443c01a7336-2b082820d55mr126297125ad.51.1774317346318;
        Mon, 23 Mar 2026 18:55:46 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:62d5:79a:7a92:c774])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083527f90sm121657735ad.19.2026.03.23.18.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 18:55:45 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mchehab@kernel.org
Cc: harperchen1110@gmail.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org,
	syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
Subject: [PATCH v2] media: ec168: fix slab-out-of-bounds in ec168_i2c_xfer
Date: Tue, 24 Mar 2026 07:25:39 +0530
Message-ID: <20260324015539.1451660-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-230042-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,64485d3659c4c07111b4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 97381300D13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The WRITE_DEMOD path in ec168_i2c_xfer() checks msg[i].len < 1
before accessing the buffer, but then reads both buf[0] (register)
and buf[1] (value). If userspace supplies a 1-byte I2C message,
the read of buf[1] goes out of bounds, triggering a KASAN
slab-out-of-bounds error.

Fix by checking msg[i].len < 2 and returning -EOPNOTSUPP if the
buffer is too short to contain both register and value bytes.

Fixes: a6dcefcc08ec ("media: dvb-usb-v2: ec168: fix null-ptr-deref in ec168_i2c_xfer()")
Cc: stable@vger.kernel.org
Reported-by: syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=64485d3659c4c07111b4
Tested-by: syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
  - Fix author email case (Kartikey406 -> kartikey406)
  - Add Cc: stable@vger.kernel.org as the Fixes tag points
    to a commit present in the stable tree
---
 drivers/media/usb/dvb-usb-v2/ec168.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb-usb-v2/ec168.c
index 973b32356b17..ebfb02826b20 100644
--- a/drivers/media/usb/dvb-usb-v2/ec168.c
+++ b/drivers/media/usb/dvb-usb-v2/ec168.c
@@ -135,7 +135,7 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 		} else {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
-				if (msg[i].len < 1) {
+				if (msg[i].len < 2) {
 					i = -EOPNOTSUPP;
 					break;
 				}
-- 
2.43.0


