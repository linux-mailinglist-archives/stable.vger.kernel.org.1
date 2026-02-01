Return-Path: <stable+bounces-212975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJyJHnidfmkJbgIAu9opvQ
	(envelope-from <stable+bounces-212975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 01:25:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB838C47F0
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 01:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DC293017BC5
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 00:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875D1A08BC;
	Sun,  1 Feb 2026 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Wrv/ky33"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2429405;
	Sun,  1 Feb 2026 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769905524; cv=none; b=MLgahgUqCMnc4MEEIhqSLDWAnhGEVjfvGjaJ42yPJ4zQrgwKo2BnQMZriUgye5GVXcu3/b9+1jAq9+x4GT2AGp+M8Y+/ICm50TZtIymT119NMGNyNLht+h+JPwK7zPRIPTQPStS9mmAG/LER4MSJ49rbElAvUPNEVDMdluRT6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769905524; c=relaxed/simple;
	bh=PZtxJfmdOPtRZwLhvDvV8HeLjdPhsDGOn/NbKAs4ui8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxwyRZ38CtALk5EHfcKHfV/vj/pfOXXEEYe5M74UaLJPm1+SSMoDLeCM13zfE6DpWtUuSYdmsHt19hEJ7d5rGm2em+rk8Y/xaEHScmUOSpgrYaRdbBR8DrTgaFIE3vVw6iK62N272G34wNz/+l1N4leXoAxR4Lu/AbIU1U1eeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Wrv/ky33; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769905511; x=1770510311; i=spasswolf@web.de;
	bh=d6RYlx3yK4P+6jd/5Dgx/Cn1UsWZNBAbdIwOfCNrkiM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wrv/ky33+cxtxmn/0lxWgytAxFt4NLKpeGuagb7/ERzGZo2j2ryxfQkcWKmJBUol
	 HLhGJhbtLi/IVHUYnd8Qc1bVZc1G02jLqt2ewjGlAPVpgCis5Yk1ECCbCIJnz61xH
	 CvD2SAsmB8HQFhOoMdeutiIehxUIRehh7yc6j67WMs7+UZQlu8ofctOtHcWSH7Sou
	 aUdLLa+DBWGB06maYVbZjIodZUt0hpEEXjBImH3fhfoA6zNN4iR01l1sFBc35B3KM
	 cRlj9yxD1oUfM1gzCEBmWvvBsaFIsx1+/bJupGlgugNCPdmC02YCM68n91yCRljuV
	 mOfO2HabSIEOhLNp1Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MxHYK-1vxFOR2bt2-013256; Sun, 01 Feb 2026 01:25:11 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	stable@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.18.8] Revert "drm/amd: Check if ASPM is enabled from PCIe subsystem"
Date: Sun,  1 Feb 2026 01:25:06 +0100
Message-ID: <20260201002508.1293510-1-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kkjx055O66fHG9mySxQvFWsbp905osS4cpb77/CuMdx4sMVBqsY
 XQeU5h7om42I93gOtTaJbVlwu8tokQuw2xCtLQYBwnSK7bCEeZC9cD+7Yb+k60SFAfI+ul7
 hvKBJV2yfi8bxe1U2sdyQ/C5/DzbyhFdy1LjqKIKWx1cEU548hHVJDnVWvMldZWrk7onEfl
 2qL9pjBbYFKAIMEIxj8sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NPTQ6chlcsQ=;SoZF6uygBJcWsVoUMftlDbkCkSf
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[web.de,vger.kernel.org,lists.freedesktop.org,amd.com];
	TAGGED_FROM(0.00)[bounces-212975-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spasswolf@web.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[web.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB838C47F0
X-Rspamd-Action: no action

This reverts commit 7294863a6f01248d72b61d38478978d638641bee.

This commit was erroneously applied again after commit 0ab5d711ec74=20
("drm/amd: Refactor `amdgpu_aspm` to be evaluated per device")
removed it, leading to very hard to debug crashes, when used with a system=
 with two
AMD GPUs of which only one supports ASPM.

Link: https://lore.kernel.org/linux-acpi/20251006120944.7880-1-spasswolf@w=
eb.de/
Link: https://github.com/acpica/acpica/issues/1060
Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated per =
device")

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_drv.c
index 7333e19291cf..ec9516d6ae97 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2334,9 +2334,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			return -ENODEV;
 	}
=20
-	if (amdgpu_aspm =3D=3D -1 && !pcie_aspm_enabled(pdev))
-		amdgpu_aspm =3D 0;
-
 	if (amdgpu_virtual_display ||
 	    amdgpu_device_asic_has_dc_support(pdev, flags & AMD_ASIC_MASK))
 		supports_atomic =3D true;
=2D-=20
2.47.3


