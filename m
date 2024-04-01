Return-Path: <stable+bounces-34813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2045F8940FE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B576DB20A36
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C82482DF;
	Mon,  1 Apr 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kFU8++yX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EFD4CE04;
	Mon,  1 Apr 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989385; cv=none; b=PetN5tVX4Za2MSpEpuSkv3j/KGS6OuhoYykwpe1TLotKiS+6hW4JdPDq5a4v8TY/slQAa6yVPHA2M0Ge3cS7HeQEapQg9vl0p+trcNc2i+MRStBfp5g4A5ASJXg4QRuNtUJA++6aWyJNRjL58OzXQicBTZQWQGXvStlISIdG3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989385; c=relaxed/simple;
	bh=Oz0bAzu6GjcYOSKTU/8IpPh0vYfnoA6wyLbCkZWX4hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b//x3GLfHs1utdMazoXamGIqGqdFShnbNiy+dMB36T1dQPWhLCO6Ct8XPlPNPAAOjPFlBPJJCk9imJsKMLsqRX1ZR+YQHRzCnjL6aW7QUoeigzbHtLGyl2WTxEFOdgFAfRwJBai7BJydcRbMF5+X7zMhjB9g+d9z3XaWjBdE2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kFU8++yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4370DC43394;
	Mon,  1 Apr 2024 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989384;
	bh=Oz0bAzu6GjcYOSKTU/8IpPh0vYfnoA6wyLbCkZWX4hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFU8++yXkSm+PI1eLGspPCVmFJ0fl4vfN+45159EjGoznOL3dEymHdFT2NEUEugHl
	 Rbrb2rbIYkEGlTD2BDaV2leCHyAm4REZuZt8RTOcr1b/NY8HiZJw17pJMJD6FEfpEa
	 losg+t6aJo88t2mS+Dg36tvrTf2IwQxRkSqUNoyY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 033/396] powercap: intel_rapl_tpmi: Fix a register bug
Date: Mon,  1 Apr 2024 17:41:22 +0200
Message-ID: <20240401152548.914531990@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit faa9130ce716b286d786d59032bacfd9052c2094 ]

Add the missing Domain Info register. This also fixes the bogus
definition of the Interrupt register.

Neither of these two registers was used previously.

Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Cc: 6.5+ <stable@vger.kernel.org> # 6.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_tpmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 891c90fefd8b7..f1c734ac3c349 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -40,6 +40,7 @@ enum tpmi_rapl_register {
 	TPMI_RAPL_REG_ENERGY_STATUS,
 	TPMI_RAPL_REG_PERF_STATUS,
 	TPMI_RAPL_REG_POWER_INFO,
+	TPMI_RAPL_REG_DOMAIN_INFO,
 	TPMI_RAPL_REG_INTERRUPT,
 	TPMI_RAPL_REG_MAX = 15,
 };
-- 
2.43.0




