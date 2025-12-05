Return-Path: <stable+bounces-200130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B99CA6FB1
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 10:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0E8E3617878
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8719D2F3614;
	Fri,  5 Dec 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=a1.net header.i=@a1.net header.b="BFuvLn75"
X-Original-To: stable@vger.kernel.org
Received: from smtpfallback03.a1.net (smtpfallback03.a1.net [194.48.128.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3031618B
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.48.128.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921823; cv=none; b=DqyycMwI1J47QjBCtGCkVASEr9saLKxOZ8vRhkzYX4TQvk6fdbGmLeBLRacGVgES1qE4sFfGh585bAq+ERdyAd/GLRRKbfbLsjolVL6y20vfqJ6I685TJQfVzgkLHrzERmsSGjmF4Ql3Mxf9AEwyBPb0lMzLx6gSVc8a0UUkci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921823; c=relaxed/simple;
	bh=bzrSIiK1BB2smhU9mULi9rvULw5WTpDBnZNcdF4ZsjQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vdx9xBx77wID2ZD8WL9kxbIUGGabF/Sql4dkcSVP5NB2tx7C4ZrVgSMhgb+/Uz0OeRYR/J0sT2dLAK2fM2Uq5yP60g5Zvf10UCxNhGEjDRSzvXSygPUSUu2xfUA223bSxzjfyqsr/TSKYk75obxCKQvbiGA4PDvpcobEOUOi1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a1.net; spf=pass smtp.mailfrom=a1.net; dkim=pass (4096-bit key) header.d=a1.net header.i=@a1.net header.b=BFuvLn75; arc=none smtp.client-ip=194.48.128.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=a1.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a1.net
Received: from smtpout05.a1.net (unknown [10.247.84.27])
	by smtpfallback03.a1.net (Postfix) with ESMTPS id 4dN3Y81zxWzYkm9X
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 08:54:04 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	by smtpout05.a1.net (Postfix) with ESMTPSA id 4dN3Xx6gbPzGrqnr
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 08:53:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a1.net; s=resmail1;
	t=1764921233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bzrSIiK1BB2smhU9mULi9rvULw5WTpDBnZNcdF4ZsjQ=;
	b=BFuvLn75kl8R5rypnkLON78CX/Sjqs3dSIafA1J4C0EJxkXr69+d+o5dHvKrihtAQ7koVn
	eRRaBoHU8vRD2r9af6zGEzIjM2CDfBQ8V/Fj6e+DA6eQonVQcinuC8ko7vq5iKNwbETVtn
	H2r8zA9Zy4fYswsCw/8FXplpvfGDEye4WrtmfoudVXxIRYonxj7geTqimJxebh3JVv+jan
	AMnBEHmVQyLuoWdsP5yJ7JMtDyaPmtQdruL/+9J9WaDN2TLx48lToKXrdh2zfM3SBi+NbW
	tlpjNiWyG5UgXOj7d3AgGYtFp8TQ5QRbzEa4d5z47m0hjDHE44KRN9iLqUT2bT/H7uEsjV
	Tro/fATQD/ewRavX12LDDpiqkRkkaXDljl4UtND29O0wHeIwni45O6eA1DtOQ3E4NfghAl
	+g3r9CDjGmQ+4vr8WtF7PlRtJUkWin4xx2tirbNMrCBi7k3Mj9ymR5qDr3NMngsxdkqDVa
	GjO62xEOmY4pJ7ZPLRn4POOWl87ZYUvfyGVq4I4vnqmDStakEt+vrCOaVlIqy7JodX87oJ
	dqRtGdIJzmpdkxvNX7iWpkR4aQ8Ladjoy+ekWkVv6z1rOB6VCCHzPMjvKB7ONUzSVncFS4
	tyiHVOiKZm8bv+Ip7kjj//Y/iw3CqM+r3ofi2vDbKFuGkP6NOeSz0=
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso2636107a12.3
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 23:53:53 -0800 (PST)
X-Gm-Message-State: AOJu0YzvUAIamtyemjKOKklnVXsrXpRE2KxXhNT0XLh3Kal3PYtaI4AB
	oRPAKRcAUuJb0twH5mGriLpT1mSbt/QVcujx4MsMu2KVZM485l1cFd4S6jj+LIjSDsjtfmcn7yW
	H4Wmyv14aFxqJ9Q6QBmyg0erEpyxwNn8=
X-Google-Smtp-Source: AGHT+IHoK7V0lg8D3HbLI9Vn3mw0EcBCkqAFC9znciOdXLSY03oXntBa8lBM451+ZBQwLY4e25DHvdAx4eY2fZYGCak=
X-Received: by 2002:a05:6402:46c6:b0:647:a570:b75f with SMTP id
 4fb4d7f45d1cf-647a570ba30mr6146735a12.16.1764921233389; Thu, 04 Dec 2025
 23:53:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Neil Gammie <mkpyc9@a1.net>
Date: Fri, 5 Dec 2025 08:53:42 +0100
X-Gmail-Original-Message-ID: <CAFNokafrb+OaqZcPjCdzkLiR7rFoZXjhY9ifdqTNoLhDRmooFA@mail.gmail.com>
X-Gm-Features: AQt7F2ruGh0IQc05mo3e8PidGMnsdytyWm8sn-DYQsCbREEwUGymfYPcrkilrTo
Message-ID: <CAFNokafrb+OaqZcPjCdzkLiR7rFoZXjhY9ifdqTNoLhDRmooFA@mail.gmail.com>
Subject: 6.17.9 / 6.18 AMDGPU DMCUB Error
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, 
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 

Hello all,

please forgive me if this issue is already known, but I couldn't find
any reference to it with regard to the 6.17.9 kernel. Anyway, when
updating from 6.17.8 to 6.17.9, the following error is raised on every
boot:

Dec 04 14:44:20 P14s kernel: amdgpu: Topology: Add dGPU node [0x1638:0x1002=
]
Dec 04 14:44:20 P14s kernel: kfd kfd: amdgpu: added device 1002:1638
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: SE 1, SH per
SE 1, CU per SH 8, active_cu_number 8
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring gfx
uses VM inv eng 0 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.0.0 uses VM inv eng 1 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.1.0 uses VM inv eng 4 on hub 0

Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.2.0 uses VM inv eng 5 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.3.0 uses VM inv eng 6 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.0.1 uses VM inv eng 7 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.1.1 uses VM inv eng 8 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.2.1 uses VM inv eng 9 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
comp_1.3.1 uses VM inv eng 10 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
kiq_0.2.1.0 uses VM inv eng 11 on hub 0
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring sdma0
uses VM inv eng 0 on hub 8
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring vcn_dec
uses VM inv eng 1 on hub 8
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
vcn_enc0 uses VM inv eng 4 on hub 8
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
vcn_enc1 uses VM inv eng 5 on hub 8
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: ring
jpeg_dec uses VM inv eng 6 on hub 8
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: Runtime PM
not available
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: amdgpu: [drm] Using
custom brightness curve
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: [drm] Registered 4
planes with drm panic
Dec 04 14:44:20 P14s kernel: [drm] Initialized amdgpu 3.64.0 for
0000:07:00.0 on minor 1
Dec 04 14:44:20 P14s kernel: fbcon: amdgpudrmfb (fb0) is primary device
Dec 04 14:44:20 P14s kernel: amdgpu 0000:07:00.0: [drm] *ERROR*
dc_dmub_srv_log_diagnostic_data: DMCUB error - collecting diagnostic
data
Dec 04 14:44:21 P14s kernel: amdgpu 0000:07:00.0: [drm] fb0:
amdgpudrmfb frame buffer device

Setup is as follows:

Hardware: ThinkPad P14s Gen 2 AMD
Processor: AMD Ryzen=E2=84=A2 7 PRO 5850U
OS: Arch Linux
AMD Firmware: linux-firmware-amdgpu 20251125

Running a bisection gives the following:

git bisect start
# status: waiting for both good and bad commits
# good: [8ac42a63c561a8b4cccfe84ed8b97bb057e6ffae] Linux 6.17.8
git bisect good 8ac42a63c561a8b4cccfe84ed8b97bb057e6ffae
# status: waiting for bad commit, 1 good commit known
# bad: [1bfd0faa78d09eb41b81b002e0292db0f3e75de0] Linux 6.17.9
git bisect bad 1bfd0faa78d09eb41b81b002e0292db0f3e75de0
# bad: [92ef36a75fbb56a02a16b141fe684f64fb2b1cb9] lib/crypto:
arm/curve25519: Disable on CPU_BIG_ENDIAN
git bisect bad 92ef36a75fbb56a02a16b141fe684f64fb2b1cb9
# bad: [aaba523dd7b6106526c24b1fd9b5fc35e5aaa88d] sctp: prevent
possible shift-out-of-bounds in sctp_transport_update_rto
git bisect bad aaba523dd7b6106526c24b1fd9b5fc35e5aaa88d
# bad: [b3b288206a1ea7e21472f8d1c7834ebface9bb33] drm/amdkfd: fix
suspend/resume all calls in mes based eviction path
git bisect bad b3b288206a1ea7e21472f8d1c7834ebface9bb33
# good: [ac486718d6cc96e07bc67094221e682ba5ea6f76] drm/amd/pm: Use
pm_display_cfg in legacy DPM (v2)
git bisect good ac486718d6cc96e07bc67094221e682ba5ea6f76
# bad: [1009f007b3afba93082599e263b3807d05177d53] RISC-V: clear
hot-unplugged cores from all task mm_cpumasks to avoid rfence errors
git bisect bad 1009f007b3afba93082599e263b3807d05177d53
# bad: [ccd8af579101ca68f1fba8c9e055554202381cab] drm/amd: Disable ASPM on =
SI
git bisect bad ccd8af579101ca68f1fba8c9e055554202381cab
# bad: [e95425b6df29cc88fac7d0d77aa38a5a131dbf45] drm/amd/pm: Disable
MCLK switching on SI at high pixel clocks
git bisect bad e95425b6df29cc88fac7d0d77aa38a5a131dbf45
# bad: [5ee434b55134c24df7ad426d40fe28c6542fab4d] drm/amd/display:
Disable fastboot on DCE 6 too
git bisect bad 5ee434b55134c24df7ad426d40fe28c6542fab4d
# first bad commit: [5ee434b55134c24df7ad426d40fe28c6542fab4d]
drm/amd/display: Disable fastboot on DCE 6 too

The error still occurs in 6.18, but reverting the above bad commit removes =
it.

Although an error is reported, the system still boots to the graphical
interface and appears to function normally, although I have neither
benchmarked graphics performance or used the system for an extended
period after the error has been flagged.

Yours faithfully,

Neil Gammie

