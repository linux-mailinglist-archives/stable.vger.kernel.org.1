Return-Path: <stable+bounces-221150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIXwOd9No2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6699F1C8382
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44F24316E791
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F2342146;
	Sat, 28 Feb 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTi4GZmZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318937312B;
	Sat, 28 Feb 2026 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301504; cv=none; b=E/l5EZMiobX2SymUYumUObSry6BTd7T43UQPHUM2Zg+z4sTh0k18sY+4MtrBWI/bW7FK31QqcDIq0fUye2Pg8Ztv+r9J+BhC1nL6AhZ7H0JOFoFV+M/md2vjNnddwtSHJ03VqGbuBuMoQiaNw0gIxY72SlO0lmIjvyGU8sRBnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301504; c=relaxed/simple;
	bh=+QmB+On8mef2rFA1QxU+2uPtpps85pIbmRUMtawkgk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBr/G7vOIjp9zd4yriPAoCx/t5vFZDM0F02ZLUkOIuzA8ohAUC6V9xJ3mqEd71uA+Txq8G1Vlu65mG7D4IP+hOLKxAUPyITIZ1Pr9mjGa/6pl/UirKFQZuWOaI8Ogt2qP11UJ0jCDd+8WMi+EVHr8GViXttH2O8kVBmnMz9rv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTi4GZmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5346BC19424;
	Sat, 28 Feb 2026 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301503;
	bh=+QmB+On8mef2rFA1QxU+2uPtpps85pIbmRUMtawkgk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTi4GZmZgC2udkTIYAkZpVgD6Z1sb2OgaQmir1uKhviKfgZj9W90l0YEFVJtDp4pT
	 qBSGlEQaAMzdJ5iNd4aF6tY1bNA26HDsrlY0GAqv4LjRvXqi1mXrmcI4ZTk2t8BLSH
	 wxy+mXPj2/WNzVPb9RR8KWLYpvy9YVZPa79YCJaXf3iyKn0sa1+LP0+htoFRcWRjX1
	 K7z91NIOo0ZxCSmxmEku+LurCsOQkx7AyufKHSCg5mwcXpMUPcYPJTVhMKemfCF+RW
	 AM3+gZZaG7TVzGj2zefxkSUDKzyfU3UelBauokgHjb629t3e1i+auMqb/PoYqWHylL
	 C606ZJMy6HDyA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 688/752] LoongArch: Prefer top-down allocation after arch_mem_init()
Date: Sat, 28 Feb 2026 12:46:39 -0500
Message-ID: <20260228174750.1542406-688-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221150-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: 6699F1C8382
X-Rspamd-Action: no action

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 2172d6ebac9372eb01fe4505a53e18cb061e103b ]

Currently we use bottom-up allocation after sparse_init(), the reason is
sparse_init() need a lot of memory, and bottom-up allocation may exhaust
precious low memory (below 4GB). On the other hand, SWIOTLB and CMA need
low memories for DMA32, so swiotlb_init() and dma_contiguous_reserve()
need bottom-up allocation.

Since swiotlb_init() and dma_contiguous_reserve() are both called in
arch_mem_init(), we no longer need bottom-up allocation after that. So
we set the allocation policy to top-down at the end of arch_mem_init(),
in order to avoid later memory allocations (such as KASAN) exhaust low
memory.

This solve at least two problems:
1. Some buggy BIOSes use 0xfd000000~0xfe000000 for secondary CPUs, but
   didn't reserve this range, which causes smpboot failures.
2. Some DMA32 devices, such as Loongson-DRM and OHCI, cannot work with
   KASAN enabled.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 20cb6f3064568..2b260d15b2e25 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -421,6 +421,7 @@ static void __init arch_mem_init(char **cmdline_p)
 				   PFN_UP(__pa_symbol(&__nosave_end)));
 
 	memblock_dump_all();
+	memblock_set_bottom_up(false);
 
 	early_memtest(PFN_PHYS(ARCH_PFN_OFFSET), PFN_PHYS(max_low_pfn));
 }
-- 
2.51.0


