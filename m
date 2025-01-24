Return-Path: <stable+bounces-110340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37714A1AE27
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 02:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A60418882FE
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 01:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2122075;
	Fri, 24 Jan 2025 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b="ULA9+KCD"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED96FB9
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737681803; cv=none; b=pIEpg/VciOmMFVCmJFtZUZjoC969Vz8hWveLimhi8gBR6BEh9WCq8x9iMY2rjPYphth8CWJxjh1VmvLCHjnF0SPRDJsiKW6tA+O2R5rVcYChYdCITePrmM4a8rp+EHrOuzGaFuZy9v3YL/iLvo9mn9l2gALocrl99zCtohH5VIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737681803; c=relaxed/simple;
	bh=HgulRjWp0FbMY1sWGInZ89Or+EvMoIQzvVn7Bw9tcAk=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=ZSaMWOrtIf2fM4Vc/gp8c6ToVHIELVoBLRxOwQ8XKBA6S3fwSlo9JG0RRZcDfow6aHIKRkBcYb50/JHX8EmMyWUYxXBpsN4wloTc3nlDtCibbucfaItJ8mN2/JVKB2lWRTe0D8pCijXxq3zxeBBwxeBrfHV+8T/Q8RP0Zjobr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com; spf=pass smtp.mailfrom=engineer.com; dkim=pass (2048-bit key) header.d=engineer.com header.i=rajanikantha@engineer.com header.b=ULA9+KCD; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=engineer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engineer.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=engineer.com;
	s=s1089575; t=1737681797; x=1738286597;
	i=rajanikantha@engineer.com;
	bh=Z2tF4s6uDEopQT6bLOfZ+NEmhp+ZV9g9P6XEZwiu7HY=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ULA9+KCD4d/VALbW7OFrWfCXWnQJvZyVZyliTVwtReRlRdXwIvTsRuvrS0BTlavC
	 MQP6x0XCvBXhSvdpm+iYCTEchLkWcqAr+ui4dDr9tQWlwMgnI3GbJ+j4Nqj3BhfJc
	 mRb3r1dR01J09B7ymTnuqYcFaEfSu5IoBv/9cN9WJEYxws9N5fNJSzPWfYIcsjkny
	 VZ6jsqNmGShIA0UZ6/olTB4srcvypzVOFV5nLxB30el0DUY5UCwfrxbF9NESf+JfD
	 8XyYZIz7l1MKZbzN3uUuF+6rxWJ1yekj3JLawaMyqDScGmixd1wMMUlNmNrzFHdR+
	 Wo5iCFf8gNezzMdOhw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [60.247.85.88] ([60.247.85.88]) by web-mail.mail.com
 (3c-app-mailcom-lxa10.server.lan [10.76.45.11]) (via HTTP); Fri, 24 Jan
 2025 02:23:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-9fdb9995-866f-4221-8e4b-f08e3d33894b-1737681797536@3c-app-mailcom-lxa10>
From: Rajani kantha <rajanikantha@engineer.com>
To: lizhi.xu@windriver.com, tytso@mit.edu, stable@vger.kernel.org
Subject: [PATCH 6.6.y] ext4: filesystems without casefold feature cannot be
 mounted with siphash
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 02:23:17 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:0kJ7HAHm1OjLJCnH38boIn3oHhRsGbZGG29vfXkM2GQ6GJMlxWGTNk8AsUqF5AoIDUPp8
 4ERmi3PGSyZlKyKGMYB6bfeB72LETKf8JQ7iKbz1OnklM71unBEUq4O5YDauemA7g3r8l7ViRaKA
 V+L32s4PpgP2K/opbB23JZfD32bKpvZfyd389BoWd+a4VkdNMWd6DDGTZtPAlgFoJbhDrhNvcuBD
 418tEvT5pcn+3uoj+DN+DQvfTIxqgVIOTjnH06/TQPr20t0h3pO9t7bRfbNpi/hPDSSbzE0NqryZ
 8k=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/ob3tWQuYUA=;lwDRnOBQSwe+GAxSX2XiHXPoEZl
 /Bml1NMoSr02/nkxombtKE0F9pMVjARIl4IGJ0DHzbliOlerdCpyUfTx2leeIzGzBHTtE9l5n
 HxnHPPZozfmprnf5XNA1flEtmLHRTRY8tzouobWOzPmQthZjTJQOVdhBgnTJNC7vSgw5qlovt
 +YSd2KZeegKD/dYsBzurz269MbtawNOaRtcU8x7a065kKYtVHXSCEfW2puX/f5PwbmJms0aCa
 JJuplyLncElPSa0ectPYmB0aNixuahWZmhS52I27/UAnaEO5OdGWyzWDMZXZQS4T6cX/U76ny
 f3cI7EIyMR/ulEARttt3BPHzqOvy08Q2h34QDzHyiNkTBW/QW9xwSyLT6LYh+RMjtoF1XXUKD
 toBdfkvBt/KRRmOqINNAp/0r9WzmNmm7bsePkGsf0bShw3qP5o/3R9rWzgLBdtTiVgu4DXASa
 fiiP3WwM8b42vTLhTrZ1yc3lirT9T/U9PE2vEmw1oqKXNiW4L0UglRRY899oJZrfciF5liys+
 mWgBnyI6JLcZYHayhP4qVi/5MIlyQTASwhXDVZvBkcB0SCHhznApB94fBO+3R1nGprmY2hFw0
 jPBo3YOri5uLUs1xtoAkn5LdG36mAQUXjFJSOQhQT9qUOZBTIGTZs/yuK7WpoSF3dODveAg8J
 ZFFrFJeGBylis+ucLbVT1wVmnS+gidMvtujogCMfPK9Kt9oxy7BrQ0hR0gIyCGuex+XUQUsZp
 CUWrFVar0aQygPqfxzNPE6flOjd+eazWNWNzgm5tCia/tf0vAH6qZ+iec90Ed9jMuyDdHOTLG
 meXGo3NBlNCh4yUN2CwhANfSzWzQ+xvcyulYkYYuDo+duboPWmGoJhaTDWI4HQoFSkKE0kXDz
 t1k7t6GCTldIFaIUUXAos6uyIYDpPqxxn+BnCMnx8LTuTsbhkS/wrxElhdtLBED7vGaVF1eh4
 pYmLhqGGXg6xVgrjY95fBsl9+IY9US1JUP6ZOrItGqEwC7+NC/xbyzoDM9+PGYVIzeTGF8IHA
 VXv/SC8X/IOu0ywTXo=
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
index 71ced0ada9a2..7522bd019639 100644
=2D-- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3626,6 +3626,13 @@ int ext4_feature_set_ok(struct super_block *sb, int=
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

