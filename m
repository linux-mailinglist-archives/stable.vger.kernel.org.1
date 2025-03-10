Return-Path: <stable+bounces-122803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED796A5A147
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D9016B3A1
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25723371B;
	Mon, 10 Mar 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pfFS1jK3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9D22E418;
	Mon, 10 Mar 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629542; cv=none; b=sUJ/N/UD6BXHOurIS9ZZvQJp1mMOJoRq0k+C0na9n4KW3AEaMf1iHuGzLGnnoiRoq32sUpqEHEYM38O/EmEElmOtUzZfyvbWqbk0gJq/2eyGukgzlv+pUClPm2y6i5KU/cujpEyBVs2EYZmIBSkb1QqF/s2bglUtU510Ncz1+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629542; c=relaxed/simple;
	bh=+lcOHe6kl83+54wZGowrtSXFMR467VKu5slrHBMtcBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibR0nBIY3qbx/JMNbYrpTQeEtxzFYLQytpEpEdx4m1a23tnxfFefbw19wG381RSrJt1UWF6lND1jaJckgBfH48x03mGtvIlOrg/ei2oldgJ8wATvWEtOfYNN3SNhXSrLLHlQ5BySTQCu9p4GXIA1QDvz59E7xqP895W5D1am9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pfFS1jK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BFEC4CEE5;
	Mon, 10 Mar 2025 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629542;
	bh=+lcOHe6kl83+54wZGowrtSXFMR467VKu5slrHBMtcBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pfFS1jK3aOtCGv7ZGrVQwFt1YJlY+cU0w4T6f4MvH+wmQrlrG7PtNaTDbkG1XCB08
	 20llZM+cenlBzbxhKVzf4WnDO+AYsiGjAOLvZ0RPe64daqXZSWvwdsFU7LPfz346YG
	 oaq+2ne5z+bFql/pHr1ooDmhjfnbJs9H+Qehcu0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Osipenko <digetx@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 5.15 331/620] memory: tegra20-emc: Correct memory device mask
Date: Mon, 10 Mar 2025 18:02:57 +0100
Message-ID: <20250310170558.668157612@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

From: Dmitry Osipenko <digetx@gmail.com>

commit 9ff684342ee7d3ea2755c6e9b60bc43085baa3ad upstream.

Memory chip select is swapped when we read mode register, correct it.
We didn't have devices that use a single LPDDR chip and both chips are
always identical, hence this change is just a minor improvement.

Fixes: 131dd9a436d8 ("memory: tegra20-emc: Support matching timings by LPDDR2 configuration")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20211222043215.28237-2-digetx@gmail.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/memory/tegra/tegra20-emc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -540,7 +540,7 @@ static int emc_read_lpddr_mode_register(
 					unsigned int register_addr,
 					unsigned int *register_data)
 {
-	u32 memory_dev = emem_dev + 1;
+	u32 memory_dev = emem_dev ? 1 : 2;
 	u32 val, mr_mask = 0xff;
 	int err;
 



