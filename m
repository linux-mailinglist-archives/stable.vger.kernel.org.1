Return-Path: <stable+bounces-84496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598799D07A
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446ED1C215B2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CEB1AAE0C;
	Mon, 14 Oct 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RE/RIPA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FEE1A76CC;
	Mon, 14 Oct 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918210; cv=none; b=dzCghwVx4AwbFSfrShMlY62M0cHJk+I71n1MqtgQY3WGMdChWLSZ8evhanBiV+XegUvfgFWk+sXYH5YG9If13zSZsS0VsBVpjLeWsCI+ZizlQNXrlp275yXWUtE6g3KpIOMwMb/N2XJGCN6kBvNF0w/3a1lLlZYcYi8IjeTG/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918210; c=relaxed/simple;
	bh=vcgu011KVNFNFOJERvFOGmORqWFHPQihA4ZSqnoVffk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfbiiXeKrdWBbtMzNEVUyusxI7EPUdkzluy6KBN+T1G6hG3YZAWl1ekYk0ngJKi2A/pUmWE2FWJ0R0EXjfdU2QkRCavn1tL6qtQdTt4nZLSr85okMpJm6OJc80b96u0XBTtOgG9vNRyC6culpno4xVs2+twEZwKWeJzOBXTTkqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RE/RIPA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22001C4CEC3;
	Mon, 14 Oct 2024 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918209;
	bh=vcgu011KVNFNFOJERvFOGmORqWFHPQihA4ZSqnoVffk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RE/RIPA/1a78SEiSWRUZfcQIooCuKT+BvYQ2DpN1piauFQi51g9L5K2qcXen1e+99
	 dvVwmK+OmIm03dMBjNUboQ5DniKX+mgao61FZvrGZd2PTl6T88Y4wY2K9TXNuI1Di+
	 cPFCEVeXIWZE/JefKnadgZ35h123L57jW2+q8K94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 254/798] coresight: tmc: sg: Do not leak sg_table
Date: Mon, 14 Oct 2024 16:13:28 +0200
Message-ID: <20241014141227.914046163@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit c58dc5a1f886f2fcc1133746d0cbaa1fe7fd44ff ]

Running perf with cs_etm on Juno triggers the following kmemleak warning !

:~# cat /sys/kernel/debug/kmemleak
 unreferenced object 0xffffff8806b6d720 (size 96):
 comm "perf", pid 562, jiffies 4297810960
 hex dump (first 32 bytes):
 38 d8 13 07 88 ff ff ff 00 d0 9e 85 c0 ff ff ff  8...............
 00 10 00 88 c0 ff ff ff 00 f0 ff f7 ff 00 00 00  ................
 backtrace (crc 1dbf6e00):
 [<ffffffc08107381c>] kmemleak_alloc+0xbc/0xd8
 [<ffffffc0802f9798>] kmalloc_trace_noprof+0x220/0x2e8
 [<ffffffc07bb71948>] tmc_alloc_sg_table+0x48/0x208 [coresight_tmc]
 [<ffffffc07bb71cbc>] tmc_etr_alloc_sg_buf+0xac/0x240 [coresight_tmc]
 [<ffffffc07bb72538>] tmc_alloc_etr_buf.constprop.0+0x1f0/0x260 [coresight_tmc]
 [<ffffffc07bb7280c>] alloc_etr_buf.constprop.0.isra.0+0x74/0xa8 [coresight_tmc]
 [<ffffffc07bb72950>] tmc_alloc_etr_buffer+0x110/0x260 [coresight_tmc]
 [<ffffffc07bb38afc>] etm_setup_aux+0x204/0x3b0 [coresight]
 [<ffffffc08025837c>] rb_alloc_aux+0x20c/0x318
 [<ffffffc08024dd84>] perf_mmap+0x2e4/0x7a0
 [<ffffffc0802cceb0>] mmap_region+0x3b0/0xa08
 [<ffffffc0802cd8a8>] do_mmap+0x3a0/0x500
 [<ffffffc080295328>] vm_mmap_pgoff+0x100/0x1d0
 [<ffffffc0802cadf8>] ksys_mmap_pgoff+0xb8/0x110
 [<ffffffc080020688>] __arm64_sys_mmap+0x38/0x58
 [<ffffffc080028fc0>] invoke_syscall.constprop.0+0x58/0x100

This due to the fact that we do not free the "sg_table" itself while
freeing up  the SG table and data pages. Fix this by freeing the sg_table
in tmc_free_sg_table().

Fixes: 99443ea19e8b ("coresight: Add generic TMC sg table framework")
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20240702132846.1677261-1-suzuki.poulose@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index c88a6afb29512..74e8b7632305a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -255,6 +255,7 @@ void tmc_free_sg_table(struct tmc_sg_table *sg_table)
 {
 	tmc_free_table_pages(sg_table);
 	tmc_free_data_pages(sg_table);
+	kfree(sg_table);
 }
 EXPORT_SYMBOL_GPL(tmc_free_sg_table);
 
@@ -336,7 +337,6 @@ struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
 		rc = tmc_alloc_table_pages(sg_table);
 	if (rc) {
 		tmc_free_sg_table(sg_table);
-		kfree(sg_table);
 		return ERR_PTR(rc);
 	}
 
-- 
2.43.0




