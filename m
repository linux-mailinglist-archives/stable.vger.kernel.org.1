Return-Path: <stable+bounces-140043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867C4AAA440
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927AA163D24
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0BE28C031;
	Mon,  5 May 2025 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUoEh3om"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E528C026;
	Mon,  5 May 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483967; cv=none; b=npivn/c6p7FNwpmxmW2/OgKEvNpCNLNtio3apqM0MXJfgHYIIa2reDvj0Fonu9d78RXQStg+YOAJodbI49lnr//NYdrGcA9QZ/1A18AARyyXWdkkzkLIvOEan0zbCYAhSlhRkO9pkw03hJlittX4+so7QiXm/YQwbF2B7gdSBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483967; c=relaxed/simple;
	bh=cPpXnFjPAzYupv5JW6H48Za2AGfwdIzDn04kP4CkeI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzFPmZQ1X+iZV6jirJdfbmdwqFwdXDQesYiD8aZcMq7J+Kp/eouu7P9MBkra80pVtGpbucYosMJk3rj+LC1jO+RN5DtlzSXgXReBaQI+KHskG9Qq/tIBY+VwpgdSKPGivbBGDgUtggY+aDR7du5MdaeYbtya4KKhKfZwGeQdDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUoEh3om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D69C4CEEE;
	Mon,  5 May 2025 22:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483966;
	bh=cPpXnFjPAzYupv5JW6H48Za2AGfwdIzDn04kP4CkeI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUoEh3om4SGO7Ja+qYsQTQZxgn9/QaiWHmr9XjNi0pIebXs6eg7AoZCLGbfzDm5Wn
	 OLvyKUNGsxC7/6nQgKjBocIKdiQJuRTMBj//bWIemUY6qNXNM9X2An9KyVe1b2lLqT
	 R+vKTWHguUoW5Zx4uCFeXinCK+9+3kqpUU07ZtD9iJGxuxqvQG31rZjNF6flxsOngO
	 V1Hygj8VlYDgO9CHwRVBeKsAeNjqF6uBzQen36dtwmjgMHlNMyzqu93Y5gvd1/m57g
	 vjMUqBYsnC1uYmlHh0nzUzVlsuOz71NgHbsodutX5LUsUlCxEC34OzleeO0GgR0IsV
	 GgIylt5FenS8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 296/642] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Mon,  5 May 2025 18:08:32 -0400
Message-Id: <20250505221419.2672473-296-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit cc0aac7ca17e0ea3ca84b552fc79f3e86fd07f53 ]

Set dma_mask for FFA devices, otherwise DMA allocation using the device pointer
lead to following warning:

WARNING: CPU: 1 PID: 1 at kernel/dma/mapping.c:597 dma_alloc_attrs+0xe0/0x124

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index fa09a82b44921..eacde92802f58 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -213,6 +213,7 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
-- 
2.39.5


