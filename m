Return-Path: <stable+bounces-76583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714097AFF2
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 14:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9817DB21A1F
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D72166F25;
	Tue, 17 Sep 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="gbn9zA6E"
X-Original-To: stable@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1589443;
	Tue, 17 Sep 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726574769; cv=none; b=oNSRSb62qGrdL3BLJBQk/icSH3s69mciXDTtsk7WSaIvsHCn8BCcuvpSgm+WMzc89LWf2gwnHPEszC3XoOXQt0evLAE8P11llfXjHH8O0r99OO86s2yy4/8QSlsPCFeVJoOJxE4UqI0m3VmBccz6ZF0fhzMhdAm5q0/+ZdftcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726574769; c=relaxed/simple;
	bh=o6hYOLeoa/Sx7lR6EIClYOPPTMnOrp2j7gjYf8s69qE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EM04+ue27y/GOCx03IbBrf9Odb5uTgZzDY+w6+jpbKUlFVvEzk7xG13kUcgod1xKByOd8kF+zHEPNrGiEX1De+3ipDeNzIDRglZH//kuQqGodHYz3yuKsCQQXWV8qZqRB3Mg7I5PziAWgj11gJqOr3YC8hztdeZkmxLuApCViWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=gbn9zA6E; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 970642EE6ED1;
	Tue, 17 Sep 2024 15:05:56 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id PEgLqGpJE8Wv; Tue, 17 Sep 2024 15:05:56 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 6CE7D2EE6ECF;
	Tue, 17 Sep 2024 15:05:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 6CE7D2EE6ECF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1726574756;
	bh=MKMKD12s9d5/QwwYAPNDbi40GcfdBs0O5ArdecVS9pw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=gbn9zA6EUP5vBno/ErsXJD1LiBF5sjLsTiP+T7bigx45Vv3cg55TkGFxf+RPOa1c/
	 frVzjONsMEtes3r+bEavtSUsie+4s1cU2Nq84+L9oU4qodVKzSVVv1eO+1gH+Q1HUh
	 LE/1Gs8WIwehjHA1pUfqLNHCajDfbqjRYFivvQbwEypF2QDdFaECAqvDDHimtrn/oB
	 0E4UE0jrOUQYjmLQQXBuEjcuvNfFJCru32pSP3fharicidAFL7OjaUomp7fn0Xdjbo
	 t5kDcuOd9gp7xtxiWBeZE9J7+ekhadTJ5q3DyFy58oou/rvZf2Z7oxFy/TWt5jgsh4
	 ueVYCthHpueNg==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AL_lSQ8dyBgp; Tue, 17 Sep 2024 15:05:56 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 2D8672EE6ECD;
	Tue, 17 Sep 2024 15:05:56 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	lvc-patches@linuxtesting.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 6.1] platform/x86: android-platform: deref after free in x86_android_tablet_init() fix
Date: Tue, 17 Sep 2024 15:04:58 +0300
Message-Id: <20240917120458.7300-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No upstream commit exists for this commit.

Pointer '&pdevs[i]' is dereferenced at x86_android_tablet_init()
after the referenced memory was deallocated by calling function
'x86_android_tablet_cleanup()'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5eba0141206e ("platform/x86: x86-android-tablets: Add support for =
instantiating platform-devs")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
 drivers/platform/x86/x86-android-tablets.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platfor=
m/x86/x86-android-tablets.c
index 9178076d9d7d..9838c5332201 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -1853,8 +1853,9 @@ static __init int x86_android_tablet_init(void)
 	for (i =3D 0; i < pdev_count; i++) {
 		pdevs[i] =3D platform_device_register_full(&dev_info->pdev_info[i]);
 		if (IS_ERR(pdevs[i])) {
+			int ret =3D PTR_ERR(pdevs[i]);
 			x86_android_tablet_cleanup();
-			return PTR_ERR(pdevs[i]);
+			return ret;
 		}
 	}
=20
--=20
2.25.1


