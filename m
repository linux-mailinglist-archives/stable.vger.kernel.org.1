Return-Path: <stable+bounces-240035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBYnMJz/5mmc2gEAu9opvQ
	(envelope-from <stable+bounces-240035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:39:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C6436458
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 06:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6C130103A4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 04:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105A23BD17;
	Tue, 21 Apr 2026 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCpmkgfd"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A0A175A6D
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776746391; cv=pass; b=erQGJtLZYG4/+1lyLimaW9HeSuwPOLGPeTeNZ9OXcbumG4ZF1QaZ0TcrzUTlxmVVfwHQyyeqy5vIrTWzcM9a3BpUw7R7EfewhoT7xyTL4rkcJYEhJQ5fn5KK6BD47i1ASs7rLSfMGkd8zAP7AMJ7xPNJ6RZaYnxgvJv6zl0YNVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776746391; c=relaxed/simple;
	bh=fNc9PP48rb/p3kbZuICJh6jvyBnmgHOkeuc8DMe5vNA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VgVEWeEb2c4OziRnAdiDg2vZuPKXyM6UJLcbxLiB8r2E/TUlbDkdmxDpfhgWcP6XLzDfJIjx8j0YZE3v1VpMTe9wdigB6QHQoxOT9aktSuro4cxLqd1ATdGsOPy8ouGtJrKheukJ2X+vF78GNDq+ATtgmmeed7OC7VtLkDJlBfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCpmkgfd; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651b4d09141so4977968d50.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 21:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776746389; cv=none;
        d=google.com; s=arc-20240605;
        b=AsUgF5D86h5zxd6ZyKA4E8mmvBW8AWcTYJGhwG+OqJMDYFmFrjQw6Ci+Q6DZn6oGZE
         2BSru38dot58XNQ6Vos82oBEDQswIELBZqlnala5fAhTJmC9W/mcYXu1/OG0zLkyijky
         NuxDlDZCWxWXGYLPAHlALcd7pac/pqJZUUIHQHeUDNu5ss4DrxYdZQOQTVN2GU1ie5GU
         QLhsN7Vvt9EH3MnFwei7rJ/3GTVO2C9biOmvsHpEJbRljVAnUN0TmMefvKL8T4v3TaNK
         Mhf//O9/nPKn/1s81tY9QFedXgicibvG8QKsI5X+4WCYulciF57s8Y4xO0BKuBWS4hnA
         oC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=y51xfasLAUqf8MCfdNI73Q85tETGdNLw+euC2Btgiyo=;
        fh=6pcEuJ9pBuo/GEVksU0OBrD8OsOuKykylkN5JVQtBdw=;
        b=lE9Xk7Cw5plXLZ6Z5bEQELb6sDAJL9ylqk0LEKkhoXsFLFo5EBTwToQnP1pGDRL5Sj
         cstZAzlLH1LFnZPM2Xj00SWiDabMkcif3UClt/6Ecgz3vTPYRDFLotyfpdbrrlZBdsyN
         2bG6/PSVJblx7LK70VW48CCf1/zya9T+Kzl7Dp2wzwgwCEgbtJ1NTAtLURgAbaS7Zany
         BYKa3GSZkhPmfqWJzV9JZaFQJ1/dqrkV9uD/r4/O9qrSGpflIBv+JSj3IZ8WeX8ZyCJl
         7NKmHR/OeLw9GQn6RnWexQbLJ87O6Eqa5NoosMW60zdI4UByeqbdRc601BK1cL6gNaI9
         HL5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776746389; x=1777351189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y51xfasLAUqf8MCfdNI73Q85tETGdNLw+euC2Btgiyo=;
        b=gCpmkgfd05ptFtjJVfhBk8G9dWBJp+KeoO7aJzEZA2BymKms8K+vdC2AvTSzGO0czO
         nXvVG/Ok5i2ZMmLEmBV6Zl8N1KisVhp/xG3ceaXViVqHCsubrY+91LvPOh2ahPjrB/pw
         m82fsW3fHHHjLR8IJuWTnQnBe61+spuIOt/ECRxHCrqDgH2encSftK3/NxqK//J/bIs2
         fkfR9Rum+3l+lK7K0RYFaQCirWm94Ode7SWuH9FdWEMTONfsM+FkjRJ4HoliL/TFjKq2
         k+u8hAOWkILQJPpzZemyOEQ6bunzuZXsS3bRvMrP7SMj0dJfuW23z7pnuekdqxCdWxyp
         DwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776746389; x=1777351189;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y51xfasLAUqf8MCfdNI73Q85tETGdNLw+euC2Btgiyo=;
        b=WFQ3tWFJyMXH7zFFpMxbhPEVOeb3c/u9cJ5aR4ZzWD2vqfJt/jtGhR6Iu23vW8AjTP
         CgFxaT/lDXYi0yCQJH5erxrJoSS5UbV2Uqap+8JmXgUFEBRLMFWAbKyJtD65nmC1diND
         idhA+d+q0k12gf0dKbTD+QRPdZrvnMt94oouFo510dpo/pxRZx1KTjgichHMTAAg158d
         b41TKEF2JsfbdaNk82RbSJd4MGzNmcsNsTqEPDvMGAmXuNGrEj4VSlOLnsthMeIXGvJ6
         mItLRfVWD1l39eR6GeJRW7gkLCc+xsnO0+JDF2BWfd6o/m9mvK05L2Le1zhmIDLDgAa5
         v9jA==
X-Forwarded-Encrypted: i=1; AFNElJ9KlEII7tnI4wDjIgGOKeKMZfpSnLL3UVwkcAT3/P5Y2vp//A2nahxFQ10rHfJmDtvHJm8tiOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRFo94UGYXpdborFjg5+uoyi9c/e/przArc1/gd5Oz3xBqylOf
	//96cI0M9OSuZ6uyuMhFWGY3k2EvDGZ+HhCnUzg2ObrBIg5SmOqYDYi4ESMaYnQChyeL8lZfJfx
	W9LnkN6UvC574oOaPLVh2cdmsQtzm73M=
X-Gm-Gg: AeBDieuz69DZgiZLVUw6/8HnTgp0t6jo6N1HjXPQZVEubwJzVs7dgpDxA6+28zNC7Yk
	gQYMR9ADceBU1VQeias+cU1J1OoNkx6xjrDlfxvJkadJbzuV8UIva6wpnfXOH0PxzM+o54EIJ4C
	5bK8AsOnsL7YxheIFbpvR0HDanMDMv/sxAo8YYgO1WLffpgo+WEGPzBCu/gEq6DSpEVhjD9aEv8
	O7m6mfUz03hX5TMOmxAIFJGnA2v2eJJ7YIJGXhldjx7W/mi8ZnawTKUAM7P09Oha7mj82dBFrMK
	NRQtjsZJgR7moo1X9WwTA6tIdeyalu+iVoCtbxGs89yd+11ZrRJGKVysRIV20PGvOVw6lHFif4/
	peocexg8r0wslmqmHQLlvkXkeU2lDSQqE9ob1Yj5ZcZ/5XC7IzQhdKgNX11lSGg==
X-Received: by 2002:a05:690e:484c:b0:654:447e:1be3 with SMTP id
 956f58d0204a3-654447e23d8mr149983d50.0.1776746389340; Mon, 20 Apr 2026
 21:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 20 Apr 2026 21:39:38 -0700
X-Gm-Features: AQROBzCYmvtyOhr0yXSJHqJXknBG3-g2a7HwL9emxQchFyxySjXNgemP0IWS_M8
Message-ID: <CAE5sdEjY9vJeiMXV7=SsUi=TZbjGZs_OwADzDiUnMD2NXUN7pQ@mail.gmail.com>
Subject: [Regression 6.12] ima: define and call ima_alloc_kexec_file_buf()
To: sashal@kernel.org
Cc: apais@microsoft.com, stable@vger.kernel.org, ongchris@microsoft.com, 
	rachelmenge@microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240035-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidchintamaneni@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C1C6436458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey Sasha,

We are seeing a kernel regression in the latest stable 6.12 kernels
while running kdump service.

I've provided the stackdump at the end for your reference.

During backporting I think a patch is missed  -
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/security/integrity/ima/ima_kexec.c?id=fe3aebf27dc1875b2a0d13431e2e8cf3cf350cca
I've cherry-picked the patch and I don't see the issue anymore.

also this patch looks benign and avoids double free's if there are
multiple loads -
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/security/integrity/ima/ima_kexec.c?h=linux-6.18.y&id=d0a00ce470e3ea19ba3b9f1c390aee739570a44a

I've tested both the patches and I don't see this issue anymore.

Stack dump -

 ------------[ cut here ]------------
[  156.762329] Trying to vfree() nonexistent vm area (00000000a65532bf)
[  156.768859] WARNING: CPU: 143 PID: 18534 at mm/vmalloc.c:3378
vfree+0x2d0/0x320
[  156.768874] Modules linked in: nvidia_uvm(O) svcrdma(O) ib_umad(O)
rpcrdma(O) xprtrdma(O) rdma_ucm(O) rdma_cm(O) iw_cm(O) ib_iser(O)
ib_ipoib(O) ib_cm(O) mlx5_fwctl(O) fwctl(O) xt_tcpudp xt_conntrack
nft_compat xt_LOG nf_log_syslog nft_fib_ipv6 nft_masq nft_nat
nft_fib_ipv4 nft_fib nft_chain_nat nf_tables nvidia_drm(O)
nvidia_modeset(FO) input_leds led_class hid_generic nvidia(FO) usbkbd
usbmouse usbhid video cdc_ether drm_ttm_helper hid usbnet ttm mgag200
nvidia_cspmu i2c_algo_bit ipmi_ssif dax_hmem mana arm_cspmu_module
coresight_trbe arm_spe_pmu stm_p_basic coresight_stm spi_nor cfg80211
coresight_tmc coresight_funnel stm_core coresight_etm4x coresight
cppc_cpufreq acpi_tad mlx5_ib(O) ib_uverbs(O) ib_core(O) sch_fq_codel
efi_pstore nfnetlink dmi_sysfs mlx5_core(O) crct10dif_ce ghash_ce
sm4_ce_cipher sm4 psample sm3_ce sm3 mlxdevm(O) sha3_ce mlxfw(O)
sha2_ce mlx_compat(O) sha256_arm64 sha1_ce xhci_pci_renesas tls
acpi_power_meter i2c_tegra acpi_ipmi ipmi_devintf ipmi_msghandler
dm_multipath ebt_ip ip6table_nat
[  156.768995]  ip6table_mangle ip6table_filter ip6_tables
iptable_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 iptable_mangle iptable_filter ip_tables x_tables
autofs4 aes_neon_bs aes_neon_blk aes_ce_blk aes_ce_cipher
[  156.769023] CPU: 143 UID: 0 PID: 18534 Comm: kexec Tainted: GF
 W  O       6.12.78.2-1.azl3 #1
[  156.769027] Tainted: [F]=FORCED_MODULE, [W]=WARN, [O]=OOT_MODULE
[  156.769028] Hardware name: Microsoft C4A14/C4A14  , BIOS
C4A14.0.BS.1C05.GN.3 04/17/2025
[  156.769030] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  156.769032] pc : vfree+0x2d0/0x320
[  156.769034] lr : vfree+0x2d0/0x320
[  156.769035] sp : ffff8002c1f4fb10
[  156.769036] x29: ffff8002c1f4fb10 x28: ffffd05f6d199a20 x27: 0000000000000195
[  156.769039] x26: 0000000000000003 x25: ffffd05f6f3f8000 x24: 0000000000010000
[  156.769041] x23: ffffd05f6f481000 x22: ffffd05f6f3f8000 x21: 0000000000000000
[  156.769043] x20: ffff8000e4740000 x19: 0000000000000000 x18: 0000000000000006
[  156.769045] x17: 2072656e6972614d x16: ffffd05f6d12d8c0 x15: ffff8002c1f4f550
[  156.769048] x14: 0000000000000000 x13: 2966623233353536 x12: ffff106f974c0000
[  156.769050] x11: 0000000000000001 x10: 0000000000000001 x9 : ffffd05f6bf4745c
[  156.769052] x8 : c0000000ffff7fff x7 : ffffd05f6f3b49d0 x6 : 00000000002bffa8
[  156.769054] x5 : ffff106f9a753488 x4 : 0000000000000000 x3 : 0000000000000000
[  156.769056] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff10032e997600
[  156.769058] Call trace:
[  156.769061]  vfree+0x2d0/0x320
[  156.769063]  ima_add_kexec_buffer+0xe4/0x288
[  156.769074]  __arm64_sys_kexec_file_load+0x3f0/0x5c0
[  156.769081]  invoke_syscall+0x70/0x100
[  156.769088]  el0_svc_common.constprop.0+0xc8/0xf0
[  156.769090]  do_el0_svc+0x24/0x38
[  156.769092]  el0_svc+0x3c/0x170
[  156.769101]  el0t_64_sync_handler+0x120/0x130
[  156.769104]  el0t_64_sync+0x1a8/0x1b0
[  156.769107] ---[ end trace 0000000000000000 ]---

Siddharth

