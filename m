Return-Path: <stable+bounces-5357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9AD80CB5D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A2B1F21803
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544DF4777E;
	Mon, 11 Dec 2023 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiDVKv6G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063038DD0
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C94C433C7;
	Mon, 11 Dec 2023 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302712;
	bh=I+x4HFJYzeuO9JjMfAaQwpqHyc8BqsF1rrF2PgjyQB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiDVKv6GYETYFrTuxZwfibwaZubXxVjxUCO9KWFUyLeYGn+Z+VQgfI8FRphgJCjyX
	 PY3STbdCxKIdVmyki/raEcAJupxViRhTh9gpIZAHHclZ2qX22JJsEqAgaLj0p2vLFy
	 /491CTENZ5RTdJI+s9e0QDTysoVU7b089Yz3mi6+e26yDBe5dxEwkP/4B6FvVY6icD
	 BH0u7H8JsyyJ2uj8qeV/4eTqKa4V36MczeU6jSO8Q6yhHKabAVT9wG6+MUVrhNZ4OZ
	 eXQ+9PQsH2rVC2W+JZxZ01z4r0aGBMTSZ4BcPgQofnxu/3f39gM0e5IbE+BRYTuMaq
	 JypN4TbBmREJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.cameron@huawei.com,
	alexander.shishkin@linux.intel.com
Subject: [PATCH AUTOSEL 6.6 02/47] hwtracing: hisi_ptt: Don't try to attach a task
Date: Mon, 11 Dec 2023 08:50:03 -0500
Message-ID: <20231211135147.380223-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Yicong Yang <yangyicong@hisilicon.com>

[ Upstream commit aff787f64ad7cbb54614b51b82c682fe06411ef3 ]

PTT is an uncore PMU and shouldn't be attached to any task. Block
the usage in pmu::event_init().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20231010084731.30450-5-yangyicong@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index 7d2127d86c728..1d066ce8358f0 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -1000,6 +1000,9 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
 		return -EOPNOTSUPP;
 	}
 
+	if (event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
 	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
 		return -ENOENT;
 
-- 
2.42.0


