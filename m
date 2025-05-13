Return-Path: <stable+bounces-144182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739FEAB58DA
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3068B3A7247
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48142BE0F3;
	Tue, 13 May 2025 15:39:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E762BE0E2;
	Tue, 13 May 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150751; cv=none; b=W23Dc3wK318PCU4VK6iqPgCzWD6TCT415HW07QRh1UKCyy0DvFV/53iMZEWvAoYV2p1/gyZQ+JY4gsx+H85DZtYljKZxkIrrIYcqE3BibJ6xzUK5iuwCIesn5v/EDUfKAbOAnMj6DSR08ZpiD/xOdo2HuNo3BNInkx0Iwwf3EYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150751; c=relaxed/simple;
	bh=+mvxEdljvYKFdu7xFTT6kJOMomVTUjxJexBsebQBDfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3qAjxvmL85b6h52GRs9k2hifoLx3jfy2c+ZNoHCPTyNEOImuk/LycRQVnV8z1kCeG31jALTBWGBSAfqTZAfNAS/GWbOegBAvOL/iS2No4aKXtJWQRDw3XOI9UwYdFQ/FlQKEGCqZdfCTKGvjpMqALZox5Cy59fBmlbU8v2rUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 100571688;
	Tue, 13 May 2025 08:38:58 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE8953F63F;
	Tue, 13 May 2025 08:39:07 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	allen.wang@hj-micro.com,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com,
	stable@vger.kernel.org
Subject: [PATCH 1/3] perf/arm-ni: Set initial IRQ affinity
Date: Tue, 13 May 2025 16:38:58 +0100
Message-Id: <614ced9149ee8324e58930862bd82cbf46228d27.1747149165.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1747149165.git.robin.murphy@arm.com>
References: <cover.1747149165.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While we do request our IRQs with the right flags to stop their affinity
changing unexpectedly, we forgot to actually set it to start with. Oops.

Cc: stable@vger.kernel.org
Fixes: 4d5a7680f2b4 ("perf: Add driver for Arm NI-700 interconnect PMU")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-ni.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index de7b6cce4d68..9396d243415f 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -544,6 +544,8 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 		return err;
 
 	cd->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
+	irq_set_affinity(cd->irq, cpumask_of(cd->cpu));
+
 	cd->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.parent = ni->dev,
-- 
2.39.2.101.g768bb238c484.dirty


