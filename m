Return-Path: <stable+bounces-36776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FA389C1D3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEEEB2B69C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A67F7F8;
	Mon,  8 Apr 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vxXutDGK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7467C086;
	Mon,  8 Apr 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582312; cv=none; b=DH79u1ZbSUZLbq9F0Md1dQaW5Zr74uC3lxeOqautF5eGgXEcEPANeBRFM87L5fNy9OH5K5gTFFAr5vB8A7bennSzayiNzdq0RVD45aTTtxsoj/+RvQpMEDBCJCGFjCFyonD/dLtDzrESEmkMDqukd4m+rKM4QmHrOBHS3GuuTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582312; c=relaxed/simple;
	bh=gDV8cjyzf//e81wAI0HK/119f4vnprHu+X8sOWbjz+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc7rAS4fwLGnwYv6LsQHaWiF4tYPNNPIvUdG3lc4px1ZCE9Dul11JnvSNoFmGnQKvh0ZUkfd9Q54UB/ZldL5AO+kP5n1QBFikFTkSoLUjFYZtEWbdZd2CpFjDXqhg7LVYZ80AaDCiDQZBGAg9Oh9U5sCV0cnFpZR0xFbBk6vAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vxXutDGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2492C433C7;
	Mon,  8 Apr 2024 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582311;
	bh=gDV8cjyzf//e81wAI0HK/119f4vnprHu+X8sOWbjz+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vxXutDGK4LEeU5zmzxDw6dgiESpuoty8c391fblxoBCkUMDMFE3XJUZ2sfCDrrJTa
	 ANJqt1Cx27j0Z6lCpaPK5ufBFp1q6WvWHe6aKtupwNa76RFeBvzRNvY+K5vpfFEIT/
	 tFuw63hKfLcfNILQ8lk8o0XEc2h+/e6MbBXe5014=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Chao Song <chao.song@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 095/138] ASoC: rt711-sdw: fix locking sequence
Date: Mon,  8 Apr 2024 14:58:29 +0200
Message-ID: <20240408125259.187280915@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit aae86cfd8790bcc7693a5a0894df58de5cb5128c ]

The disable_irq_lock protects the 'disable_irq' value, we need to lock
before testing it.

Fixes: b69de265bd0e ("ASoC: rt711: fix for JD event handling in ClockStop Mode0")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Chao Song <chao.song@linux.intel.com>
Link: https://msgid.link/r/20240325221817.206465-4-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt711-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 9545b8a7eb192..af7a0ab5669f4 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -542,12 +542,12 @@ static int __maybe_unused rt711_dev_resume(struct device *dev)
 		return 0;
 
 	if (!slave->unattach_request) {
+		mutex_lock(&rt711->disable_irq_lock);
 		if (rt711->disable_irq == true) {
-			mutex_lock(&rt711->disable_irq_lock);
 			sdw_write_no_pm(slave, SDW_SCP_INTMASK1, SDW_SCP_INT1_IMPL_DEF);
 			rt711->disable_irq = false;
-			mutex_unlock(&rt711->disable_irq_lock);
 		}
+		mutex_unlock(&rt711->disable_irq_lock);
 		goto regmap_sync;
 	}
 
-- 
2.43.0




