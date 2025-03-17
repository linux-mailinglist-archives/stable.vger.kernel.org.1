Return-Path: <stable+bounces-124659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685B2A65845
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE91719F2
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE421A9B40;
	Mon, 17 Mar 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxjvWwMA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C61A2381;
	Mon, 17 Mar 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229456; cv=none; b=lnSW2laqPqVWh44JC4/U1yooQ+0pnhrV2/+Ko3QTJCi7b21xz1liIXGwjZubI0KvJPxY5uE71P06eIhU2lHP1vs3cLSxGXgH6kJ+xDLuYEGoIylRkksLMoPa7jQFvTtL3NVdRXbhfQod2Xaj4hXm9x/Ayo/asctSzDb9xWoR78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229456; c=relaxed/simple;
	bh=UHnMipypBFOlF0gd2sNMGr5zIqqimLifnUwYHypE0cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLabKKqP3FImaA8iVohunF00tAObrQgvNVUn4NbMEQ7/cSs+sfFVhnHwAgUKmDxGQjTwOSFsTuds9qJp2KLz8RDePjdWXANxXyNjVMQ9rSc7RuNYn4+TclV50BrGYl3CmSwiY97up4cXCkgbsC2Ch73TA5EQz+mJdFQ3r4zcrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxjvWwMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC6EC4CEEC;
	Mon, 17 Mar 2025 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229456;
	bh=UHnMipypBFOlF0gd2sNMGr5zIqqimLifnUwYHypE0cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxjvWwMAne3I1z2UbMOll6WRU2UCc6gJ5JXCl7ypIv9T+p7CQeccsynKmoiCGOR0l
	 uFPE4L0jE0ZCqIsusbtwa8ROkpCRR91fLqmSIMrh0axPIoa0wD8ZmqMf3QUINed1lb
	 vWQK4drdHqNmHjlijHf5VdLShIDqjSqG2vcdVezM7crCe1WhY2Mo4kIpceVNc0T/mq
	 /TbyR9oDqUsd21SDkrIO29sG8r9DhSlJ+YmdFXfXddj+Dhv2YxEKewm0k850uOO4dg
	 XPN9Ipgy9y2jqnZj6Ni2GQ8lZydunW9mwVC+Fhp9LS+Ir0zb8msm0LUedOxilIdHnx
	 PcK0cLKJBBGlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Shuming Fan <shumingf@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 04/16] ASoC: rt1320: set wake_capable = 0 explicitly
Date: Mon, 17 Mar 2025 12:37:13 -0400
Message-Id: <20250317163725.1892824-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 927e6bec5cf3624665b0a2e9f64a1d32f3d22cdd ]

"generic_new_peripheral_assigned: invalid dev_num 1, wake supported 1"
is reported by our internal CI test.

Rt1320's wake feature is not used in Linux and that's why it is not in
the wake_capable_list[] list in intel_auxdevice.c.
However, BIOS may set it as wake-capable. Overwrite wake_capable to 0
in the codec driver to align with wake_capable_list[].

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Shuming Fan <shumingf@realtek.com>
Link: https://patch.msgid.link/20250305134113.201326-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt1320-sdw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 3510c3819074b..d83b236a04503 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -535,6 +535,9 @@ static int rt1320_read_prop(struct sdw_slave *slave)
 	/* set the timeout values */
 	prop->clk_stop_timeout = 64;
 
+	/* BIOS may set wake_capable. Make sure it is 0 as wake events are disabled. */
+	prop->wake_capable = 0;
+
 	return 0;
 }
 
-- 
2.39.5


