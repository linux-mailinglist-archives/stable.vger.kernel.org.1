Return-Path: <stable+bounces-49903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C208B8FEF66
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22991C245A5
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257671993B4;
	Thu,  6 Jun 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="LS5qYWve"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ABF1A2FC8
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683878; cv=none; b=Nk07EV0xJA0qLxD/mva4+akYKxTDazNkcDFzd6x1mhas9C9QlLu7Wky7EIIJLxPhIMo9UwGGcTJQI8a/spWLq4rxJKdqItRxB1QiBX3oGZNhhr711SAw315bKFd2mAmMbFgM3dXTQaiYhxQ38nw7mhR31eC0KsOu1oXhXMe9kLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683878; c=relaxed/simple;
	bh=W70RagmsDGgtPDu/aaHWY/Mb0j+9B+i6xVMyeXyvsjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmqhYaZcQdNG33GGrbVLcq7N9VT9bRGTo7+S2cYcn3y8sa5HfCR7u2EbOq3mA6kFTAPz5YVvZKeGTnO9Lv0Jc2xqoEGNwFYkDIgrDinSfnnHAlRyBhiE46zFVIvUbhhiM3XbUbgss3TOr3j5urzCzEiuGrN2xMMNqJxIJ5I46iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=LS5qYWve; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1717683851; x=1718288651; i=christian@heusel.eu;
	bh=4TqXY4gy1E4TcZhTqo5vaPWzo6u3lyaqch1eF7C89Zg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LS5qYWveOGH+yBzPRbm1+oQHDJ16AgCMFsBPp6C1j8shoskRS9dBN2GXpGtzhDnP
	 iV8LBke4l/rki1onirYhKb/IJkjRUwbVCvaOnwm2W3FBVDKe6W6P4P0LtfaVeisi4
	 SyHjVF5SFCLFNZhVIhcN5Y0TSqZs5IboA9fcVasZ1J+si4NFIxuLlx0lQr2qFCfL3
	 5JJkMWlLE/5xiGtctBiCuADQDSxfQq+Z/CYJUDI+/W8Ya0uz08P34INs1NM1Jc5YB
	 RPgLqdO5tmSkKL/sc7WQm0to6GL44K/WnpueoAB2kbGM/eYOFIaLXXwnsNrT7LNTu
	 i3N9c/MD6/Dn5Amhng==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.chris.vpn.heusel.eu ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mi23L-1ssQbi1v73-00pY9E; Thu, 06 Jun 2024 16:24:11 +0200
From: Christian Heusel <christian@heusel.eu>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Tim Teichmann <teichmanntim@outlook.de>,
	Christian Heusel <christian@heusel.eu>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 6.9.y] x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only on family 0x17 and greater
Date: Thu,  6 Jun 2024 16:23:50 +0200
Message-ID: <20240606142350.24452-1-christian@heusel.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024060624-platinum-ladies-9214@gregkh>
References: <2024060624-platinum-ladies-9214@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:16J9dvDYI5uSFOXVE4MXAg1MnZr1oD2XTVcFUvwWEa+PZm3THm3
 rCp+au5Cw7le6AUy+b+8KMbeTDQyqiw2CwR2kjfl/8Frmqt4Ac/hL1zXDdPACjaM07SUis/
 pjDInN6dQCg3t5oLl0V++73ULjgxUpdC12KIvlZP97EIj9i+jmvIm2cNpVA6QTwnv8Y+pPx
 3enyhLEadkfg8nIJLlbkQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DZAOMHkbQW0=;8XkMPQW+0R7Jfi9Zb5syIQ/w8jh
 HL7AK/6nUUaGT6XgmwWV16D20Jf74vtRGnL8ThBJYDyxxWkIyFg7eqV5yqAifEpmaT+OfsXFW
 xOP7CzcuvJGqA4SMNMTCnDGYqpHbyDgx+wgPwEIXJNeRrNtBGz+XvHyomtMydQkaWRp6sij0l
 qVFE0QMedkJUbeLqVLuAHbGnxzvamnMax+dIKSITu31dHUVFOHKuQjYGivAEGTkKE/DnKGBI6
 FcvUIKQuvSfNg+3wEx1+qdvyt+b7owPg7a+9ZDrwWfZAaiHdCZ72Vq55Yy1h3URXXLoh3Bvo6
 bvSJz7TJPpCNjJTl2GMDp2+Nb8diUMEHfwos+kaGRy0n1RnMu1cl/Utuk7dwkhbQ4zi5T+EKm
 2j0DbcHXEPMmLQRdm2k9I8d5NsoJwL34T7H35VNwn2LoZTp9hQIf7bzzAz+xeVAiwNDTBWrmC
 LJ2zmuwdBg52izExpOqn3C+yJ5aRw6pX5+Mj6BVz9VjdXS3TFIo4a9J3fUutNrNcAN3i0kwAd
 X17bcW2K+xLSNThPFNrqB47+I8AjDLMHdLs7LPzPTuSjTCLWlYzSWSD3IC2ajqkFDBstmk6a1
 qlPnABF7is/UmJzUI67XNgu9RucSfJTzk63LPMbTl4B2QMAEMBLCfRsgteubzhfe+iyFzUBp4
 8rXjEyG/89ygHdkPij1SgcFyOLTtGCPZUfvE9QUzGrcT89kiRuenuWU3A/X8lmGTveSMgFUYn
 FJzJwiJu6L9hql1bx14lf57m0NrMiU7t0DvZWLpT/W/wdE52xFMVW0=

From: Thomas Gleixner <tglx@linutronix.de>

The new AMD/HYGON topology parser evaluates the SMT information in CPUID l=
eaf
0x8000001e unconditionally while the original code restricted it to CPUs w=
ith
family 0x17 and greater.

This breaks family 0x15 CPUs which advertise that leaf and have a non-zero
value in the SMT section. The machine boots, but the scheduler complains l=
oudly
about the mismatch of the core IDs:

  WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:6482 sched_cpu_starting+0x=
183/0x250
  WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:2408 build_sched_domai=
ns+0x76b/0x12b0

Add the condition back to cure it.

  [ bp: Make it actually build because grandpa is not concerned with
    trivial stuff. :-P ]

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology pars=
er")
Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/=
issues/56
Reported-by: Tim Teichmann <teichmanntim@outlook.de>
Reported-by: Christian Heusel <christian@heusel.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tim Teichmann <teichmanntim@outlook.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6=
g2jduf6c@7b5pvomauugk
(cherry picked from commit 34bf6bae3286a58762711cfbce2cf74ecd42e1b5)
Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
 arch/x86/kernel/cpu/topology_amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topo=
logy_amd.c
index ce2d507c3b07..5ee6373d4d92 100644
=2D-- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -84,9 +84,9 @@ static bool parse_8000_001e(struct topo_scan *tscan, boo=
l has_0xb)

 	/*
 	 * If leaf 0xb is available, then the domain shifts are set
-	 * already and nothing to do here.
+	 * already and nothing to do here. Only valid for family >=3D 0x17.
 	 */
-	if (!has_0xb) {
+	if (!has_0xb && tscan->c->x86 >=3D 0x17) {
 		/*
 		 * Leaf 0x80000008 set the CORE domain shift already.
 		 * Update the SMT domain, but do not propagate it.
=2D-
2.45.2


