Return-Path: <stable+bounces-188417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C0ABF83B2
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458033A428A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509934A3A8;
	Tue, 21 Oct 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHG6pFSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9A338903
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074548; cv=none; b=Rc3yJgUqdD/WrMH/1hWixnpxh/5c7orY00b/4C/i4/eqG7vsh6WFZeKSNL5om9CovK8li5jupFl3hHzT1V9O4Enl6lIXSog1jaVQESePyiIGbmc+qlZi2W/eUa13O2ujkaWZva2l8InLaDbIP+xDclht5/1PASLsl9w/RHLLdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074548; c=relaxed/simple;
	bh=lYiLOSIv41E66nSgKgtX032B2kkuG+mtkwEQCSxWM3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3SbZU3nanslhVCXXl9Vc8QqRN2InMLp9Nm3Y3E1hWcTdo6GR41ARIfNvm+X69d6v11TfWI3G45TyLCFFA1iqdurAt7j0xy2b+VXWi4uONF69W7lCZ9NLhAeMye74y9M0k0L5Ux7CCMF8oEQmlpF7FK4KphH1LkiUPAPtF4h8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHG6pFSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65764C4CEF1;
	Tue, 21 Oct 2025 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761074547;
	bh=lYiLOSIv41E66nSgKgtX032B2kkuG+mtkwEQCSxWM3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHG6pFSohoGUV8Q6Ztnf+tIxMpkxgj8wQJwa1Ozp4HUuMJy0cSu2K0MAL6Z5OFSNf
	 ATy+0UVmsEmVTl5vVurv3JtfyJRDc75s7dBO3aefwkmiXRJsFn7Rw+FMNXtZNaF0fX
	 VVV3jsKr8tOA4W5JZ68xevfHoCBS1euWB5cF7WIubDB/8ck4vQuW1xmVcucneF7sdn
	 qdTkGFuBo8eH5CRp/RtGSPhbemIo+UbvWizx17nnnF+2hiseD+6HTHuhAFueQux1lc
	 2+MYWTNSh1wocKnUUO8zj1Lt9bQZcBZVCIkV+6vMrArkcX9o2OZSGkj6ruI6B+9MRB
	 i5JimIfQJ+iQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] PM: EM: Drop unused parameter from em_adjust_new_capacity()
Date: Tue, 21 Oct 2025 15:22:22 -0400
Message-ID: <20251021192225.2899605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101616-gigahertz-profane-b22c@gregkh>
References: <2025101616-gigahertz-profane-b22c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 5fad775d432c6c9158ea12e7e00d8922ef8d3dfc ]

The max_cap parameter is never used in em_adjust_new_capacity(), so
drop it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/2369979.ElGaqSPkdT@rjwysocki.net
Stable-dep-of: 1ebe8f7e7825 ("PM: EM: Fix late boot with holes in CPU topology")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/energy_model.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 1c9fe741fe6d5..8ee72c6c1daf3 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -723,8 +723,7 @@ static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
  * are correctly calculated.
  */
 static void em_adjust_new_capacity(struct device *dev,
-				   struct em_perf_domain *pd,
-				   u64 max_cap)
+				   struct em_perf_domain *pd)
 {
 	struct em_perf_table *em_table;
 
@@ -795,7 +794,7 @@ static void em_check_capacity_update(void)
 			 cpu, cpu_capacity, em_max_perf);
 
 		dev = get_cpu_device(cpu);
-		em_adjust_new_capacity(dev, pd, cpu_capacity);
+		em_adjust_new_capacity(dev, pd);
 	}
 
 	free_cpumask_var(cpu_done_mask);
-- 
2.51.0


