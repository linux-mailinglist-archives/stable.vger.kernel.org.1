Return-Path: <stable+bounces-45973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD68CD92A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 19:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26BDB2141F
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8A31170F;
	Thu, 23 May 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OZEMrSjp"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3E17556
	for <stable@vger.kernel.org>; Thu, 23 May 2024 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485468; cv=none; b=LcM3Vu0hkQK98wPlvR8Zrz20T3vqwdniXmdHSljPghu9M5I7MZVrp5+xHi7+BKBhChhZ4HTMVIAvLiNOMhSNmbCY/tZ2CnieveOKxteX0Ik+jL8TR2WZzL/D4/bgBxY3znjdfz/KxX4+E4EbWlKm0GqVE3d5xoQRTGw3vuohTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485468; c=relaxed/simple;
	bh=/4Xtk9VApKgTGxfRm/biR72Ywmf5F0ikP+F+Og2SnEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BxzGSG1en3AALYAasVUXLgiWOn5PPi4+XfR/yUHnkyjy44LSoQKbGvWuqrjJITL6byOD3W9lWPRv6XJGG4SHLL+LT8vxyyjqEIRPJQiLlt0IZpaf5WKoeZj0tv5ThRrBAn/6uJ6IfzDR4nQrp4J0gqniTP9NHzc6iHpFOLgcmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OZEMrSjp; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716485453; x=1717090253; i=w_armin@gmx.de;
	bh=ml1OIk1ADGSN0Bv7BhxFFCfB6DaSzESeZqgOlINQEik=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OZEMrSjpRCpZNHtDzlmr0mM8Z76qBOA47wRnpJmk2+GZMBHSY6dP+E6IS3bEoTr2
	 cs+oUuQy6G/5SvY5rTw8Y4m4iXXGV6BByaWCGWeZc1RDfIyYW60ml8hUXkBJuuWbR
	 2eN02l2UPaMHeIxBNBZdsLPCIBXuqaDAa44rc9aHt1ZvsYQQ+BwwG3DCLd9GCm5Pm
	 /uxmdfHru1oAYwc2U0wyv1Ncu0C9Ob3cogxQe9ivAHrnSuP1JrV4+STZBeD5jkpdm
	 Z9fIYxGnB6mkMUrCADchMsYPBnFJG/ZcZeXjzw5ZT1cphv1sTax4iraSdQLg3pNO+
	 /nzBoUi8mnC8osS14w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MMXQF-1rqbKE2jRP-00Jbrc; Thu, 23 May 2024 19:30:53 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	bkauler@gmail.com,
	yifan1.zhang@amd.com,
	Prike.Liang@amd.com,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: init iommu after amdkfd device init"
Date: Thu, 23 May 2024 19:30:31 +0200
Message-Id: <20240523173031.4212-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0V9lwu73H77PqAdjA+YQOQLM2+3KzTTl9zrsb6I30uhUOPxiA1p
 JLJxYqkyMKgStNVIay7ID6KI216ZNz3ubM8XYpSGnu66EzUxT8sXLASfudxjjdwKULpb7VC
 +Y+O7sbY7kIa+IPrB1Bw1Am+litWkoWWTdhMITaXxEbvfBMPo2yyoGSwkhR1eikF9FRkxYj
 COK97gWxEtIP+rgPugzrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MEiYmEz3rHs=;s9mwmp1yHhBowpawx+LtT7SZ6Xc
 Ns4RuJiZEs1nwVj7+WoUd9e+kWZr+Q0o40l2gyQyVx+Pl2AhW7RyQm/C0NZkNySFBi16uJnV/
 BemqPt4r78N5j8CraYadRR6IObRjM6HL2dE8/YKrMW+CklnchL769R8NeiXfL2iXv+rCx2r+Y
 XTVhHXx8okDrATK3JQ3OC3H/roKRKle+RiTf1okUL6bVDnpHel803nNn1ICSfmdIWhT321T0B
 XA2ml4Ju8vSBABVVh1Gwglv9bKYenJQO8bJmG5ysh25OG7bHVeAEdrrYSVEjESKfjZhs7Nq1n
 sPlYgVJva9HRzdjlHxWUWpOjdoqBIYq8KiWPznMcS3Ter+lVQZxW6kUBL9lTbcilBF1R/f/J4
 HCv6Ju9Kxt2jADK6R6SiBLGaN2H2oKuSWJLDdG0nSrWRuNt6eiJKETz9CANksjBxd9FFeXNA/
 PodgJ2iVj4FG6GPNapewroNC/tnPTe/aMOVQ9w+eol7juR8TRHXQpkUl9bQ8hgdoIJdUGa58v
 9mOxJkLta5cIil4bx4+1UcJn7ECpCDU8yes3PgS77R+aCbyOdD2cJjBMEdf7tJuDstRUkcmz5
 Uodv4dP8MOVzqailVNOE/Ho92XCj8tq6f3szvD0/vl29vB55RvqEiONdDAE1DOMpCZNKgoUq8
 zjqbjpkAoU8KZSpZgVJrT4a09iftR3uezi6AZwgO3s5I7lpelCfl8MQ4mjS+h30cN0kT7P+8P
 dNTWt0CfmaiIJX0Kf7BbjwEGtAD5/cYSl1pE2k7K+m0VJe5ofQkupObwyW33SuVq3VqdJVIhe
 eX3Ipoz8hnS2ekmUIwv8izc9Jv9clbiX5TyCloDiFll7g=

This reverts commit 56b522f4668167096a50c39446d6263c96219f5f.

A user reported that this commit breaks the integrated gpu of his
notebook, causing a black screen. He was able to bisect the problematic
commit and verified that by reverting it the notebook works again.
He also confirmed that kernel 6.8.1 also works on his device, so the
upstream commit itself seems to be ok.

An amdgpu developer (Alex Deucher) confirmed that this patch should
have never been ported to 5.15 in the first place, so revert this
commit from the 5.15 stable series.

Reported-by: Barry Kauler <bkauler@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_device.c
index 222a1d9ecf16..5f6c32ec674d 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2487,6 +2487,10 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
 	if (r)
 		goto init_failed;

+	r =3D amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	r =3D amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
@@ -2525,10 +2529,6 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);

-	r =3D amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	amdgpu_fru_get_product_info(adev);

 init_failed:
=2D-
2.39.2


