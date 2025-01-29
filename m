Return-Path: <stable+bounces-111236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9ADA225DD
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 22:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588DB3A1AD3
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7791E0DCC;
	Wed, 29 Jan 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IBsFidiR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144F22619
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186319; cv=none; b=mE51Bd2H2sRpk5mOjsQ5edS1f4tS1vr8NmO+LWTaLVS8vdk0gp+1v8pcRAp8A5iRlCIWAk4j9LNEaLLaCizIgBxszrKrZ5Hc2Dy4YzhJfXj9FNTEmF3Mk/bj4iy8Ad4CAs9aVEtJskyeBosO+5WdfMxeX5VyEQy8oixCdxOTgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186319; c=relaxed/simple;
	bh=XJziHGOCj5eKjY/DVLA9c0hF58UmkFmJt303gbhQN50=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=qlZOxQaUDvo5JbrkXUsCeoWiewZTBjFTXv/zSCWd9QP70lViDMtOhXQYfd8OOoYkW6av+jj2jyN5G2feaSPMB2UgqRisGwuJSQm6PgSU2+9IatvmOfh0EEVqceS2Rs1AYQjfdtifaYlnIGJOj86ZOWeQ4Rt2FfD+KcwiP/tomVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IBsFidiR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso328465e9.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 13:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1738186316; x=1738791116; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to
         :reply-to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mxRYzzqPEi81Yfzc+wDSZaiIM1NQOITOroGLR3jJeE=;
        b=IBsFidiRsXq4KllEuyQyKD+6nBq6LuQodkmgvmfmM8oDILY0DhZGs3BAL4ulmcqO/Q
         kMvp1nsBxgedow37K5yXxQslnc1+hpZ6UM3PCLSvJgMEy2H4S33r7m11lV/xIUItjSPf
         yXZwN3pJ0Z67FNc+oa6yc3r98VUiy/ZQ7p2MXiWn9TTdsCK/BlCQwdZbgdZ4Lz4WzGTe
         yKLzn8YhD6JymwDG+giRmaZoF3HbT0+Pbr3Oz/0q9bSyQf+EGxju8JdpnHGBIxPbqB6W
         SqHGCdrisevnSMABXzWyH5jJgRyn9zRrfm2MMN+Pcd4SxSxIJo/OBm6qKRk7ejqThymH
         nLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738186316; x=1738791116;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to
         :reply-to:from:subject:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mxRYzzqPEi81Yfzc+wDSZaiIM1NQOITOroGLR3jJeE=;
        b=exO47WbVMGvtWVQkaax3w5C+gnHZy5Yxar4rFnCXUJctJqMx4ZoqzFTd32sa1ElF8Y
         PlajBCLfPZBJ++CxX1RvtmfdAt2r1PtWtrK/EPyM5GqZXC4/GQiBqqDFe16tHV3imSyb
         Ifu2WF0oOyiafI+qRqgLRxfWr+4IWbFAM35WR0WpUnaSPqqjkatMbT/oTV86nCsx13CZ
         zjli4dkA5gnnxxdWGoZWpksqFyv8yElAuRFYscsNSEcseNSmFRg7stkLKpryiortD7yR
         bUf0LHDbGdLAghtVyzazuPoTD7klpJlaPZraD8batGm8755fxZFI1QTjcDkGDKqhQFbc
         IEdA==
X-Forwarded-Encrypted: i=1; AJvYcCVyUX+I3bcyH4fUXCon0xoB10DH0E+uXnpSywO/WJF4Yoe33nidA6U3ZANwnERsYwDQtsMnx1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0lMzl03JE06i2nMN8p1TK4/GBZUBfQGu1gkw2/35wknmmDYQ
	RjxDRXBwKqG3x6TUntiKPzYvL7RYSY5iWrXYnrTRCEOHNv+q8hwM
X-Gm-Gg: ASbGncsAfhs9uYHYfTGTlUMtKYyeM2GCfEm0/kItsZySQ3KrwHGRRVcwLFJEUvOGKNB
	Y+bYBPKnWqXsS4tdcUbXBrmi5eZDCV8KTiTNVQ57ee3un44wos4cDLVOH2YyTSGcAyjJbQXMhMp
	RqanXj+4rKwVALwZusUqvkrR47pU5AxJJqrSpqUBeGGGejpuwsYNBq6qMq01OslUQv894r5uTrq
	/wDU6PMlI/AyH6vl0b/YME+WBqqd0B7R8N7fJpgymrwwEPCDwI4LyUgu+KzQ0iDNLV3VNagiUve
	f2CAuzNthLymR8XeaedwGz2NF77GTw==
X-Google-Smtp-Source: AGHT+IGedQx8nJF0pB4rZnHrhu3PXTi+i9kN1ECPmuwLHVbiAK9j1q7WJRyCg7jJveT7M1cRft1Ahw==
X-Received: by 2002:a05:600c:4445:b0:436:e3ea:64dd with SMTP id 5b1f17b1804b1-438e1709453mr7299525e9.11.1738186316020;
        Wed, 29 Jan 2025 13:31:56 -0800 (PST)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc51672sm34892865e9.36.2025.01.29.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 13:31:53 -0800 (PST)
Message-ID: <b1266652fb64857246e8babdf268d0df8f0c36d9.camel@googlemail.com>
Subject: rk3399 fails to boot since v6.12.7
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Chen-Yu Tsai
	 <wens@csie.org>, KeverYang <kever.yang@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
 stable <stable@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>
Date: Wed, 29 Jan 2025 22:31:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Marc,

 since 773c05f417fa1 ("irqchip/gic-v3: Work around insecure GIC
integrations") landed in stable v6.12.7 as 0bf32f482887, here the
rk3399 fails to boot (~4 out of 10 times) because OP-TEE panics (gets a
secure interrupt that it cannot handle).

Setup is:
 - BL31 proprietary (since mainline TF-A has no DMA)
 - OP-TEE mainline version: 3.20
 - Kernel v6.12.7

<snip>
[    0.000000] GICv3: Broken GIC integration, security disabled
<snip>
E/TC:4 0 Panic 'Secure interrupt handler not defined' at core/kernel/interr=
upt.c:139 <itr_core_handler>
E/TC:4 0 TEE load address @ 0x30000000
E/TC:4 0 Call stack:
E/TC:4 0  0x300091f8
E/TC:4 0  0x30016664
E/TC:4 0  0x30015710
E/TC:4 0  0x30005714
[   26.087363] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   26.087925] rcu:     (detected by 2, t=3D21002 jiffies, g=3D2233, q=3D24=
16 ncpus=3D6)
[   26.088530] rcu: All QSes seen, last rcu_preempt kthread activity 21002 =
(4294693363-4294672361), jiffies_till_next_fqs=3D3, root ->qsmask 0x0
[   26.089623] rcu: rcu_preempt kthread timer wakeup didn't happen for 2099=
9 jiffies! g2233 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x200
[   26.090617] rcu:     Possible timer handling issue on cpu=3D4 timer-soft=
irq=3D293
[   26.091218] rcu: rcu_preempt kthread starved for 21002 jiffies! g2233 f0=
x2 RCU_GP_WAIT_FQS(5) ->state=3D0x200 ->cpu=3D4
[   26.092131] rcu:     Unless rcu_preempt kthread gets sufficient CPU time=
, OOM is now expected behavior.
[   26.092926] rcu: RCU grace-period kthread stack dump:
[   26.093369] task:rcu_preempt     state:R stack:0     pid:16    tgid:16  =
  ppid:2      flags:0x00000008
[   26.094192] Call trace:
[   26.094409]  __switch_to+0xf0/0x14c
[   26.094728]  __schedule+0x264/0xa90
[   26.095040]  schedule+0x34/0x104
[   26.095329]  schedule_timeout+0x80/0xf4
[   26.095672]  rcu_gp_fqs_loop+0x14c/0x4a4
[   26.096027]  rcu_gp_kthread+0x138/0x164
[   26.096369]  kthread+0x114/0x118
[   26.096661]  ret_from_fork+0x10/0x20
[   26.096982] rcu: Stack dump where RCU GP kthread last ran:
[   26.097463] Sending NMI from CPU 2 to CPUs 4:
[   46.276364] sched: DL replenish lagged too much

Is it too late for the kernel to disable the "security" since OP-TEE
assumes it is enabled?

Any ideas?

Thanks
  -- Christoph


