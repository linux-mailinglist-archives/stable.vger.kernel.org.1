Return-Path: <stable+bounces-48307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F348FE81C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF981C25F58
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6A19643D;
	Thu,  6 Jun 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="NMDHs2n4"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD58195B10
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681493; cv=none; b=Lq+dFWKcuQSZvvFhYvxzBVCX+tF0tQ/4Qzyd/3iLgkrl6ux2CsBJpFHr5fUM2ggAjCSElNZmVdUPcfj4bGT9bNKkj8nIO6dYcv5dScPFTgz4w97Lifhmf7Ig+fF5K648M7Hg+oq/WaNajfb8Swn1OXHydu3ed6/Zek5UYgMCCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681493; c=relaxed/simple;
	bh=W70RagmsDGgtPDu/aaHWY/Mb0j+9B+i6xVMyeXyvsjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isM0uq4Rwbi7sZ/o/3HMg72nz/b2DczwuF41O1WOLm/UJVLzi/6LFqcrj5soR08Y4EYtFs3U90tRtN7uzY4Dc+0XnGEnA7rCkGXuIgCLIY3OBnRRfBjVtPMD0BbwHZPX996Kiabi5PfENuzFY1KDL1j00q0cr2nM6W5zr6F52cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=NMDHs2n4; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1717681468; x=1718286268; i=christian@heusel.eu;
	bh=4TqXY4gy1E4TcZhTqo5vaPWzo6u3lyaqch1eF7C89Zg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NMDHs2n4KEPCmKEE65Ot4Rsy0pqHg4nE8vZbpAWH9lNMnX9wVs4HRcQy05FcUmjF
	 yNlcd4261A7kzFC8SjZwEe+ciAKYVaSLUtNVf1ylWJycytHbI9wcSevG1X0wUXn3D
	 z4JvR71MczIz6A0nE5sOAiSi5B2HJHdi78m8Od0dhmBKNiaPSYt3YkxkioKczcxXh
	 XsVu19dZKjQZNKVoACHVs7ALmXK61WnVvuUBkNcZzE88dTFqbAvUCuidM0XGSsVvF
	 zw+2Pn2sFPxsleaqV0cs89AFqGaSBhM6zdx6xxCk7TGkwZJVIMVg6WIyJdrPBSkDI
	 tHn5fyQbk7D4TLGlEw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.chris.vpn.heusel.eu ([141.70.80.5]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUGyh-1rp7yZ1xlT-00KvfM; Thu, 06 Jun 2024 15:44:28 +0200
From: Christian Heusel <christian@heusel.eu>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Tim Teichmann <teichmanntim@outlook.de>,
	Christian Heusel <christian@heusel.eu>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only on family 0x17 and greater
Date: Thu,  6 Jun 2024 15:44:07 +0200
Message-ID: <20240606134407.4333-1-christian@heusel.eu>
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
X-Provags-ID: V03:K1:tfdTK9TbXL/4Jd+V/6yGK2PVc5p0Q65g5KGq1KzWIbwEpbehHee
 MiNEVNCadI/AqFXvs+cIPx89hMfgwGSiP/VFeWZ+vkeR8NjdkCkUdmvzFGtCXe0axw0ybjz
 rlOk3U7c12DPI2AX7V2+ivE463MvoL6saKWIAACko9GPvZr/KMmGAmpiZqQ5TX8UcCSNKE4
 xUodZeWhUv6c/nWQTpr+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zLxrzGtCbgg=;WB+U1y9GgeKmuT0FeL3k6PieDX7
 PImbvr1KZBTfrB8BlWLB+xYyax7oUiv6hJhhMsbrYrjY4YifPtZAY09tlSh4dUIUR/053ufJ4
 P/L97xFr23TBiKi0eefAxRST40dyvDXieOx7z4Ro/V1+cB856OoqEEoD6u0tlgAKVTaL9h7JC
 3xr5bGUmzeKzEJNFIA5GYTLdZAIME4gQnyCppBn8gsbdak4US7F61njJ82sf1KCI4ELjgC0pV
 SHyAjs+43+6i1Z/6xnIK/+exLQeGBrE57/cd219UZwfdSzcoksj9mDo0MGGjXfSYCL6CjRS3u
 32n5SPUPuBivrmfFVo+A9deswRCMetHI0k9fn0IMv7s1tGgZh7Iu3UktsS/rMha6rAPPP76+u
 r4eVvxM0MlGKvztNLBWuGZPKVECQMTPeJO3xTNSjitBBfTf8R6pWMvBfNEhPSQyDfaqmXPggL
 1Ylwd15bONZ2Inpt51W7Am0gPIGLID2etXAFX776VpeGyxTtPSegA6YCTSA749WLCvdqql92C
 Uc3ZjHkNmXJLotqe1rIZWUZb+mjzRcVoXtDKzitnpa/cMFQP1lGgIVmq/aLQPkxbthPaw/4At
 kEApZTH0cxvxqqUyIjwPmPKrCZd0Wc+Sc0A7hI+qlm2cYV4QE42T5noMmdS5U6ZNfhjFKFa7l
 7BEv+/9QCI/CY1mTLhwZwSKpsdSYGsZJaV+m3M4WMht28w5D51BXVRhiFc8G5SkXWaE85BfIu
 Z8QKzG+3UxZ/ES0abaQ1HjImKvyxKaiRYlzpu3sthDfamtR4p1gEzI=

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


