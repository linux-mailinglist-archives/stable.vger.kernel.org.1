Return-Path: <stable+bounces-223140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE0UAo2kqGnywAAAu9opvQ
	(envelope-from <stable+bounces-223140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 22:30:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98137208006
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 22:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D46EB3046018
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF56388E4F;
	Wed,  4 Mar 2026 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="EH9xGzUi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FC3845C2
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659837; cv=none; b=bWS9AAlJn2nVOG8E+YzNBLjlq7VxdChsYf2KjH+r3iRLdOz4wg/cbSI0C2SvnsyWWhH4fW2NZmMXJ/ezJ088e8Mw3y2gd8K0DDqQYeA9vFKNg5+PcNzuCOxxaxVzTuj5Ey7y19FA6kIVkkTxRpQJ97kqO00CmiwO7gk8QqLLlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659837; c=relaxed/simple;
	bh=3c6quBI7XKemYPlN0GskGbNjt6avnY6lfsxgp6Bz4Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9KPU0+XCbo977kd223Vo/YXRsWHmNIl0Sfud3dC2kdCRonZ88EBYolcnKI4qGjSqqGrG12vppw+RmzDjmPG92igBvBSQLzI8hT0+junX05NDwGp1MIeHMB5thpgVLNdaC7E+KTh2p5DBRkV8UV9vcx+U1CncuxmBoXevQVDW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=EH9xGzUi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8ca01dc7d40so755493485a.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 13:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1772659834; x=1773264634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSYjaX5A2f3fgxWLqUioHt5Z6vX3IWJb5py3eGwR73M=;
        b=EH9xGzUiDPZym6bgre+wwGDAa/w+CkEOE7HIumNYtHqXUCGvGs+Ci4kSaJkKeIdZkJ
         AEBAEi4xlxMTDg67I4owIWa9tvRP+NV6fGtV34yCM2EUeCbDv36LHIT9ZU+r4DjX6aGs
         pzTpT9W4uP4aUcSAkcGcnUxmNvyXE9vANgNVmiQpx/kmpKeLw9nf0m9E8EdoqTcd/DZB
         Fk5oEiunel84z1T8JDWCKFoFwBojlu4cnoVEKA41bFm3zZiOe7qF6ylSeF85ncwKwy+e
         SF/DSqk101uaMFT6qksjC1HyVcndjV/g5YwATRAQQHwhtToO7DetFnI/tb8JM5L0pk4F
         cVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772659834; x=1773264634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSYjaX5A2f3fgxWLqUioHt5Z6vX3IWJb5py3eGwR73M=;
        b=kUKUccmJxgKysQzgNgSJsKFtRbdgplREKpOcgkg+F2e5VFJPH7eGNljFbCRsrbVdLd
         S2qL7RgJR50T4/x9yx6kB5THkQWSL6mpmHxAE21fQP6n5fvt678CpyLGkNpNiGmc24wf
         t02wXMzqCR8dd1jneIBunaKVNQu0OZKZp5WYJpQyT1NAaI6hA2rCouMlvb058nt4uLUd
         6iNcdNG1UnRKSa7VDfCOwc4pnIQ/pXYAMXoP86hdIaHKGF/RMPS3DkW/xYuS9Eh3uY7Y
         EMridTf2nYnxZvhyCwsg17xfCsl+mYtxNQpG6edb5cjbbaUxDAjuWk+9JOPZba2yR9Fb
         EU4w==
X-Gm-Message-State: AOJu0YzBWTdlHiqeozfzNFvsagx3fd7KrOGDNp3kSmV7bRGQ6TPry0W8
	kaWoMn3bS5dpWFCWcio9BqbyuSn519Ddrg0reBRxCW5/L3feD7LIhzeBlqsrwWAoGf8=
X-Gm-Gg: ATEYQzxN/mIriz0m9IsJAy3T41a3PZJuz4xjIO28eKeAbQRmf6NVP7jZpGumzPtraiU
	Lkdvow8d25Qpd5oLnnQ43fE8SpzRJGauhzc0S4m6DCyQ2g6VMgtKAwf+FOhtpGeWNSmLBzGO/8B
	GbsMk63+MiruCGOGNWEuevrGPico25r0Kkhp3K7Eta0uk3v1HFeSwTPnHjgjzjBpeb2R4iWNSlp
	Vbj/6+R+F8jHhQ2QaAviNMPEqwtS0GE0Q3nyH3i4CzqVpqzQkmeVcrxwEJYVd1e1B4BfZ2K7mvk
	CjzsWOJYcicpvxsne/EdXtEBZwKOHprJIxGx5m01j71L+c95+KTvlJFzK4E1kgYfpi7Tr0pB/QT
	EFFeaSR1yrFhan1DQUKosbWVew5i/KISA42dGUV61QhP0hfoAVO875YRiBYps8FauQ4zbEPAR02
	FKWq2QyxfzmtaJLfSKcfQ8SS3utLkc3ELCHt/a
X-Received: by 2002:a05:620a:370a:b0:8cb:baea:89c4 with SMTP id af79cd13be357-8cd5aef2c3bmr477281285a.24.1772659834084;
        Wed, 04 Mar 2026 13:30:34 -0800 (PST)
Received: from localhost ([2603:6080:7702:ce00:96ef:dc7e:bb84:bc5a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6869f5sm1998144785a.20.2026.03.04.13.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:30:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] amd/iommu: do not split domain flushes when flushing the entire range
Date: Wed,  4 Mar 2026 16:30:03 -0500
Message-ID: <ad8652c5e9f8aeee05e2103f4987589cdd4a3fd0.1772659768.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98137208006
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[toxicpanda.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223140-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[toxicpanda.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[toxicpanda.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[josef@toxicpanda.com,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:dkim,toxicpanda.com:email,toxicpanda.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

We are hitting the following soft lockup in production on v6.6 and
v6.12, but the bug exists in all versions

watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:1274919]
CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS Google 10/25/2025
RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
Call Trace:
 <TASK>
 amd_iommu_attach_device+0x69/0x450
 __iommu_device_set_domain+0x7b/0x190
 __iommu_group_set_core_domain+0x61/0xd0
 iommu_detatch_group+0x27/0x40
 vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
 vfio_group_detach_container+0x59/0x160 [vfio]
 vfio_group_fops_release+0x4d/0x90 [vfio]
 __fput+0x95/0x2a0
 task_work_run+0x93/0xc0
 do_exit+0x321/0x950
 do_group_exit+0x7f/0xa0
 get_signal_0x77d/0x780
 </TASK>

This occurs because we're a VM and we're splitting up the size
CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes. These
trap into the host on each flush, all while holding the domain lock with
IRQs disabled.

Fix this by not splitting up this special size amount and sending the
whole command in, so perhaps the host will decide to be gracious and not
spend 7 business years to do a flush.

cc: stable@vger.kernel.org
Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..f0d3e06734ef 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1769,7 +1769,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 {
 	lockdep_assert_held(&domain->lock);
 
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+	    size == CMD_INV_IOMMU_ALL_PAGES_ADDRESS) {
 		__domain_flush_pages(domain, address, size);
 
 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
-- 
2.53.0


