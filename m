Return-Path: <stable+bounces-157908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC75AAE562A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039E94C5E8B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4A223DE8;
	Mon, 23 Jun 2025 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NCfR4UTw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBB1F7580;
	Mon, 23 Jun 2025 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717014; cv=none; b=YFeY/jxzHy282rWmz2r9oJQbC4tpxuCD+IOg11d2HDLEq/g5zleO7RXBev6Wo35EmgXXfyPBIU/70Dy8i5LPWRXzLGomM7Roa0GY8j91EjAUjXFxCroaWUBfW5Ta54q4YjlcbufhW72GCN23fyjPz+biqeqeKqHHB0XssxCGTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717014; c=relaxed/simple;
	bh=ssJ6LJd4ZUkc6S/HIGL4Bbm83Z1TXWPVo1fP2CUzLI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+Bso2ZBHFTNuhFOa4aPWyPZA0TigT9r1OfEDaR8fI6UECtReRKYzoOumOgf87GcpNO8sxdp1dnyjeTEroFjPbQ+uqg8fmel4Ju0YMN4bpyXxUTTLPOBFIwW6daeWiurREJbRRQf8GpqbaiDMZHB/JBO6qrll+nnMJRrATXg4ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NCfR4UTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75706C4CEEA;
	Mon, 23 Jun 2025 22:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717013;
	bh=ssJ6LJd4ZUkc6S/HIGL4Bbm83Z1TXWPVo1fP2CUzLI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCfR4UTw/IY76tKQ5skf5iKg8lp70oyAwm9khP6Qw7zD4Cv1kklMMBnhlpDKwDKT4
	 /Vq2BxP03eLbrbYzX7bxB3ryN7H4liukQK17CGe8w0E9s48LanI8b/eqlIW8Na/qKN
	 CoDZo69hRbxZXHJrT3oRbRNUsoPxRMgoCeOJKYQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 5.15 387/411] Revert "cpufreq: tegra186: Share policy per cluster"
Date: Mon, 23 Jun 2025 15:08:51 +0200
Message-ID: <20250623130643.402275592@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

This reverts commit 89172666228de1cefcacf5bc6f61c6281751d2ed which is
upstream commit be4ae8c19492cd6d5de61ccb34ffb3f5ede5eec8.

This commit is causing a suspend regression on Tegra186 Jetson TX2 with
Linux v6.12.y kernels. This is not seen with Linux v6.15 that includes
this change but indicates that there are there changes missing.
Therefore, revert this change.

Link: https://lore.kernel.org/linux-tegra/bf1dabf7-0337-40e9-8b8e-4e93a0ffd4cc@nvidia.com/
Fixes: 89172666228d ("cpufreq: tegra186: Share policy per cluster")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/tegra186-cpufreq.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -73,18 +73,11 @@ static int tegra186_cpufreq_init(struct
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
-	u32 cpu;
 
 	policy->freq_table = data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency = 300 * 1000;
 	policy->driver_data = NULL;
 
-	/* set same policy for all cpus in a cluster */
-	for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
-		if (data->cpus[cpu].bpmp_cluster_id == cluster)
-			cpumask_set_cpu(cpu, policy->cpus);
-	}
-
 	return 0;
 }
 



