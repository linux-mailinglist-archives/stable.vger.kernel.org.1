Return-Path: <stable+bounces-124674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF33A65895
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DB217E723
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ACA1FCD09;
	Mon, 17 Mar 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM5a9CKP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FB1FBC89;
	Mon, 17 Mar 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229508; cv=none; b=Eu8VCcGvgvrYIqFs7bwzRUAQM4+cAna/pBUuYKTTIKtmKTllDR2L7JLvpx+qxLzO3k/Y7L+Bl3xTE27yTPHPOQAtmcoj/Orm4Wd5iyNED+ILy2vSxAoy4Q+ItNpv2pi0nRTunR8ACkYAGtefqMIX1B72f0hZ/gyb2AQudo009tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229508; c=relaxed/simple;
	bh=tknfATxtlDvV74HAu8TQq9rWQmvqAefTlLTNa+fVVAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRqMGmXfZEx27PdWdvUo+pCLmNpyyMRsvySj9aiCSimEwknDW0Nt35fsWbPd/5IEty6diu4pvNlPHxHd2e0tNR6mH2Y0+OdLWrKu4t0ZBIMEraQ0PpBXx8TiOKpX9rRvIB+ovSHsBcSHzMKTZFMofRXULdDW2jbOkJOSgwj//lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM5a9CKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CA3C4CEF3;
	Mon, 17 Mar 2025 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229507;
	bh=tknfATxtlDvV74HAu8TQq9rWQmvqAefTlLTNa+fVVAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VM5a9CKPAo2tAWc9e4XPw9Dk9h+ddMiEb5w6prXHYdl1hB+GduXNLeY1KN9e5zJh3
	 iX16Jsg8fX2z3qdhtD02yTPGJ3m2HCDjrZAcCvGA3go+Co666r+2xxdtFok7lgWkyD
	 9/Mdrq9thPR2KEGBtdQIzEmPJpmQnlAI26iS/2m1JfBVzhFV/k/PCKnKQYATbXCqNI
	 lkt0A66bPZox8dLTa9uwehQ6a4EJcNTrdmpiIRi8pNB+a4EqtqCW//hXuzcVoUk+MC
	 W4IgPpQt8cretjQEDe6XP/K0u0N75kKtUQMcdcCjNjtKhwBfKKnkwurXq6D00TQbgP
	 0XxUeCjkQDo+g==
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
Subject: [PATCH AUTOSEL 6.12 03/13] ASoC: rt1320: set wake_capable = 0 explicitly
Date: Mon, 17 Mar 2025 12:38:08 -0400
Message-Id: <20250317163818.1893102-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163818.1893102-1-sashal@kernel.org>
References: <20250317163818.1893102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.19
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
index f4e1ea29c2651..f2d194e76a947 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -3705,6 +3705,9 @@ static int rt1320_read_prop(struct sdw_slave *slave)
 	/* set the timeout values */
 	prop->clk_stop_timeout = 64;
 
+	/* BIOS may set wake_capable. Make sure it is 0 as wake events are disabled. */
+	prop->wake_capable = 0;
+
 	return 0;
 }
 
-- 
2.39.5


