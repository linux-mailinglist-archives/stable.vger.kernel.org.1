Return-Path: <stable+bounces-50997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5273906DDB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7FDB262DD
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E051459F5;
	Thu, 13 Jun 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DrTdz2hp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511014535E;
	Thu, 13 Jun 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280003; cv=none; b=N1LSfGDIbSqo//g7ItXNrn3CybG+OFla5LAOD/d0CHK9Cuv63T4Gh6hfZ45mKnx0iGB9ErTFzKTIEPOZrP0DKFrug/Q4hwwMn4ymmMYY/NDttI7MaeanvN7Dsx0eBzc7nxtPJSofAxf14L4hXibZsLsCj6JwVKPwb5Rji63ZwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280003; c=relaxed/simple;
	bh=3lBH3T9N0t31nWtq79rR725RKwWPT5qOQTUhLoBd4pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRG4A7e9M4zj/tvauZUbtsflfkV07KQUZBHbaC65EzFp+8mY82WhN9ve9to51Cl8HGZyXiuQJZtC2pIRQH80yi41eda5sq1mF1hDX4UtT9DdVHIOjq+59muhW/WuinG2YduqQvUYRQykWoS7NB9RZpNo+WPpklwOfOssM2Lrmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DrTdz2hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7BFC2BBFC;
	Thu, 13 Jun 2024 12:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280002;
	bh=3lBH3T9N0t31nWtq79rR725RKwWPT5qOQTUhLoBd4pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrTdz2hpEyLhk5Ej+SJ2jx5RIx9cJJ8mHxRMim36x+nsNeh/SEphBTObWf3Umr7O3
	 JpxNiXbWlStHl4Yi0tClbjUU04lN2EQlLW7zu2jOJEEOT2TEiHMparL81dOeArTHhp
	 KvprjC0S/AFq0Sbe0FNyWodQX+4LMxjw+kfqMc1Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 109/202] microblaze: Remove early printk call from cpuinfo-static.c
Date: Thu, 13 Jun 2024 13:33:27 +0200
Message-ID: <20240613113231.969390694@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Simek <michal.simek@amd.com>

[ Upstream commit 58d647506c92ccd3cfa0c453c68ddd14f40bf06f ]

Early printk has been removed already that's why also remove calling it.
Similar change has been done in cpuinfo-pvr-full.c by commit cfbd8d1979af
("microblaze: Remove early printk setup").

Fixes: 96f0e6fcc9ad ("microblaze: remove redundant early_printk support")
Signed-off-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/r/2f10db506be8188fa07b6ec331caca01af1b10f8.1712824039.git.michal.simek@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/microblaze/kernel/cpu/cpuinfo-static.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/cpu/cpuinfo-static.c b/arch/microblaze/kernel/cpu/cpuinfo-static.c
index 85dbda4a08a81..03da36dc6d9c9 100644
--- a/arch/microblaze/kernel/cpu/cpuinfo-static.c
+++ b/arch/microblaze/kernel/cpu/cpuinfo-static.c
@@ -18,7 +18,7 @@ static const char family_string[] = CONFIG_XILINX_MICROBLAZE0_FAMILY;
 static const char cpu_ver_string[] = CONFIG_XILINX_MICROBLAZE0_HW_VER;
 
 #define err_printk(x) \
-	early_printk("ERROR: Microblaze " x "-different for kernel and DTS\n");
+	pr_err("ERROR: Microblaze " x "-different for kernel and DTS\n");
 
 void __init set_cpuinfo_static(struct cpuinfo *ci, struct device_node *cpu)
 {
-- 
2.43.0




