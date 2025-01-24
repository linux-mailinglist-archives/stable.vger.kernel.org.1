Return-Path: <stable+bounces-110341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57631A1AE29
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 02:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09BD16B87D
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEF22075;
	Fri, 24 Jan 2025 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b="TzI72Sht"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7B6FB9
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737681890; cv=none; b=RF4rAtgI4+Or5jeA8fCvWNEuSWduPcT36MmhTiJYqdYpF+uEVG9Kj1iSz9sBrvV925WEQDSIpqG+Kd0BSkdtCgxQ0QbkpQH8Q2ZAJK8KgzwhuGyDQ/rp0SSdQfaYdjBarNxXuvVfjVv9fDC41E/u0ZqoA8SBCmKRe/98Ko/ZQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737681890; c=relaxed/simple;
	bh=7aLkB85GLbo+iyA+14a2T34f0UhJh4aw2TeDpO/deNY=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=gjXS2QDX22wttCOg83bFZbCz5mU+sbTtdwXErvFXSyKTufQP7D8VvvQTcKUqUXxWYxKUzZ6rpx5XTFGSaRLVQHwb31V2VjucArMwVff0uT3fsrSjuS16c/gN7ASx5ETsAS1u8ME86bK1z6LfFROb2wl7/ec44xoGp+t4IhbFEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com; spf=pass smtp.mailfrom=engineer.com; dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b=TzI72Sht; arc=none smtp.client-ip=74.208.4.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engineer.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engineer.com;
	s=s1089575; t=1737681886; x=1738286686;
	i=rajanikantha@engineer.com;
	bh=rfjnR3xgtafaBCmAfxjigSmDr4EkNzwqddykpknV21c=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TzI72ShtdzEAo/uTp5a9jmrftEeqKfMH7/bmPOVkmsqym3bgv2JMkF8xpSBJy/Yy
	 G68ZP9SSJvGIbmBNbEylW7py7nE+UufYxesLk8N4nlw8/kxeKr6q4NHvPR6Yfbvgz
	 L4DfgGQ42FQiyHo+UrLeLV96/7o8N4TChQ8LcNaaXXD/sF5eFKsBaQIPEsAtqvHQB
	 sm7fGuTRzfN4xgNh1GI1Oum+GXQBTkO4+CoFCa2BJH2semknaxZTX71cBv1gXFTP6
	 4NaZvtfgEkBq12YiAqvIY3TYiJ0jujbvFD9mdUl30+gNAMrj8pFZau2svuAYE1G4E
	 AdnoCs1T96VP8mauXg==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [60.247.85.88] ([60.247.85.88]) by web-mail.mail.com
 (3c-app-mailcom-lxa10.server.lan [10.76.45.11]) (via HTTP); Fri, 24 Jan
 2025 02:24:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-ef20cab5-c436-4547-967c-6751277b8964-1737681886348@3c-app-mailcom-lxa10>
From: Rajani kantha <rajanikantha@engineer.com>
To: lizhi.xu@windriver.com, tytso@mit.edu, stable@vger.kernel.org
Subject: [PATCH 6.1.y] ext4: filesystems without casefold feature cannot be
 mounted with siphash
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 02:24:46 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:VViNxXIQxA9mU+a1CoRRsDeYEAbZZXnjIB/jI+dvbcwJ4jGe7COwS5fveX81Lv/QifF2y
 PF1Ur7kRfDPPJwVGIzB1/Aj+ep/sxhbKb4bsUVALIvMq4TO80sWfDr5Gw5wAaRTZAQWSV1004JJI
 Xrkj6enDGNgKFbCwG1svmJ33cDetcizXt9I0qu2FPiqDhorYzGKEK2mSiQjdQ+z71WmoAjF9D/q8
 IQuQWs1NYnqfIJPKdlUZ+QbHVG8qoMJ+VECcH3DS3tzDKCj/Wb1NriTcRfIgE2rdyOXzx3ebZpl/
 x0=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8PbbdYFBu5M=;HZZJLtCDDdd1FZAe15QUZTjEa6F
 0i7LBdfl4bh6LCX5DZKTMCCq9I5inIZHz000zv3R+Iw1BorYmz8WcseNaqGJo+o8wWWj2Sz7e
 mOJsN5jpyEUEs+TCi2TM9WhxmKpvjYfaluQSnTrHvp3fmkIwTqs2SwCy6yrnUQCVOQJTCQCBj
 ThNgtVIXv0nl4F4TeNyWVqOqHDfKaDblyLd2TZ2TdtojgyBhokwVVV3b6Syj/rN1fuwbeqBtr
 ZsgVB7QvQDEOd7ZbixpyOtqEi4DMA+OYGY4Qw06WOfwkyLyO8aIGkb4lzSNu1E0IhKWSH4JMH
 21U7Idp8Llk1HYahKgr5vVZn3rfNw+8KWmIewPr6PE4kyL0ewVdKA2jiOiZWXV+LF5giXJwF1
 X0u9/on99XWd1FLCPNIp5jWcL2Otyh8h2A5TJPGchnIoCa/wp0XR/BRYrbEW/UMyqDsUQm6Il
 jjUYry/rKrqesy0Uh1IGrozf6CyYsFBpEDMwse5BEpiOPoXBnc5qscYyelH2CJzhnprmkHGbX
 8J9ayWc6CtLNY39nKa5Df2u/BmULdB47el5JUAIgOLd2BbmX+juhx2zirvFZ9DSx02LrCMXGa
 2SsWkDcZrkXuS4IzosY3WkWiFz67cCSH+vm1+lp6CXQFueKYQ2vagsHx7xYhUoYxiLeddVQml
 NvD+08PFDLwHfUv4soDITH8cLl3mk8/1JFT4tEkvtYTUxBeXohknO5XYrldaw1PDAE2t5H0I8
 avrkl98UwSfc0zHBr2yzoZD+/WDM9t1Ig4Z+qpd0rv1hqswVxd92JSJKbJUCKgEHAjS57eYsO
 e5G+LYX0TylPHV6+tuN56/HT+6iSbw0R3r+4Wf+V+hn10Zk9wEdoJgaWWjsPDoglqwqY1HNJR
 KuHhcU0KCjXDYHCluRMxVMy42BzzfEb/hx8PVd1zqO6RgrNP4uKVofNm6+xA4Bh9sWewlyLee
 mRNYsF9FemHNgcSEo98XpSwH+xVZGjYL88XhJSkeJgkPzyH7WsVHQa8gullErelgqcHo1inse
 rapwzY7nlMGUVlgWtxZloXkvt8jKyDgYksTRxiVmqIYtIwB6gknD8c1vAwOaTyFDeJ312qndH
 seAAl0AyZotjB4+GxYe9L5Xoj6MpzmzFO8OybSHk/U5BRwCwJ68/YbbYHYL0UKi9JTZyV/42M
 ISOeCZIeZnoLbnXyh8tnE
Content-Transfer-Encoding: quoted-printable

From: Lizhi Xu <lizhi.xu@windriver.com>

[ upstream commit 985b67cd86392310d9e9326de941c22fc9340eec ]

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.c=
om
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Rajani Kantha <rajanikantha@engineer.com>
=2D--
 fs/ext4/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0b2591c07166..2e9c14e2370f 100644
=2D-- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3546,6 +3546,13 @@ int ext4_feature_set_ok(struct super_block *sb, int=
 readonly)
 		return 0;
 	}
 #endif
+	if (EXT4_SB(sb)->s_es->s_def_hash_version =3D=3D DX_HASH_SIPHASH &&
+	    !ext4_has_feature_casefold(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Filesystem without casefold feature cannot be "
+			 "mounted with siphash");
+		return 0;
+	}

 	if (readonly)
 		return 1;
=2D-
2.35.3

