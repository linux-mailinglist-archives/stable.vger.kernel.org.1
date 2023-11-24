Return-Path: <stable+bounces-1247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4297F7EBA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F5DB21112
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC6F28DA1;
	Fri, 24 Nov 2023 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nLK9m08s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFE33CCA;
	Fri, 24 Nov 2023 18:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF6FC433C8;
	Fri, 24 Nov 2023 18:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850926;
	bh=AI0AUamkZbpCXTOtIBPx1nVptdoYLedLsag6Qp2Iql4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLK9m08s/VEe8zLVGAoh/xlWNH0TrCzOin60MUJ+27vWcoBkCXbiqOvRBsoBxOzSa
	 euMyEtsuI71/ZiOc5kmCDmxWpOsvaMj9t8RwBqMqiGPeokXqhaVO8cyJhrH/4NFiL+
	 VXg5m/QOJdyoC6kjxjYjLdiBdXnYereBQHB1v1Qo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Yu <yu.c.chen@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 219/491] tools/power/turbostat: Enable the C-state Pre-wake printing
Date: Fri, 24 Nov 2023 17:47:35 +0000
Message-ID: <20231124172031.129802745@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit b61b7d8c4c22c4298a50ae5d0ee88facb85ce665 ]

Currently the C-state Pre-wake will not be printed due to the
probe has not been invoked. Invoke the probe function accordingly.

Fixes: aeb01e6d71ff ("tools/power turbostat: Print the C-state Pre-wake settings")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a938699ca2419..ce9860e388bd4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5790,6 +5790,7 @@ void process_cpuid()
 	rapl_probe(family, model);
 	perf_limit_reasons_probe(family, model);
 	automatic_cstate_conversion_probe(family, model);
+	prewake_cstate_probe(family, model);
 
 	check_tcc_offset(model_orig);
 
-- 
2.42.0




