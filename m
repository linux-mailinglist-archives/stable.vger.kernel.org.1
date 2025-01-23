Return-Path: <stable+bounces-110332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6BA1ABA2
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 21:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 071C07A3F86
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 20:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55C1C4A13;
	Thu, 23 Jan 2025 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdVbZf+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5061C07DC
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737665848; cv=none; b=kGD2IJc/n88Jpu4b9FYiqZ3LHLB0lHXI6KYQvmRNSmU0r6ATVHTYtx9fW3/NWwpElnP/BL2r2qcEfOJMy0NpqjpWehs2tyHc/mAgtLjvJ+jVfVY0jrvw3Uj5folfp2T7wzLvygI5Zwh8VPuz0cU5/Iiflt4zh0GVXgEK05ZWuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737665848; c=relaxed/simple;
	bh=LGcHFQeHRvgmZZPbyyb/8FRVtHwMtkyC0+SPZzPwajA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXZo2PctsnwRoma8WMw3nb1uzaPrbPIJCO1MCJwSmTN/FpfRAkyWqWpfpPuGcaHWvL7jsMgBHshy8Nr6Z0H3QTqioMLkYPbq0SdUI6XDoLeq/5Nuuu5R+LKPtVLueyimQjXEsIcmS8mL5GSDFPy+jxFCIQttOqcfOSxZPGBHfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdVbZf+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1274FC4CED3;
	Thu, 23 Jan 2025 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737665848;
	bh=LGcHFQeHRvgmZZPbyyb/8FRVtHwMtkyC0+SPZzPwajA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TdVbZf+hc8kUW7CTPZMWVTVBHa6C0FIPLpn+h0A66QVwRpKippT88uae5pvXU6mD4
	 sf466N/U3RYnYBknEiURVllJo0ZQuDhCZ1M6anLXAvYXPHKxXGgEkKEhxU8B6P82J9
	 Gw3j+F1zT++OXlKjd7tMjbLMJY4CIUgouMa34h6QJN/XMlgzRsYw5Tw/CxmLLp/rFF
	 HdRtBA12auDKxm64UAatCMBVsoIhwhmHry+G2EYyyC90cYewewkg7tYga9gPzUad06
	 dNFuX89xRL0RPr0RkE7/EXAzdesX9ynLvo/l2bk+JlOfrfqPf7XFIdU3UolwWLa2y4
	 f90Bh7/xAZqjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laura Nao <laura.nao@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] platform/chrome: cros_ec_typec: Check for EC driver
Date: Thu, 23 Jan 2025 15:57:26 -0500
Message-Id: <20250123151818-5082786a5c1895fc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250123171529.597031-1-laura.nao@collabora.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 7464ff8bf2d762251b9537863db0e1caf9b0e402

WARNING: Author mismatch between patch and found commit:
Backport author: Laura Nao<laura.nao@collabora.com>
Commit author: Akihiko Odaki<akihiko.odaki@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7464ff8bf2d76 ! 1:  134ad6ddcdeb5 platform/chrome: cros_ec_typec: Check for EC driver
    @@ Metadata
      ## Commit message ##
         platform/chrome: cros_ec_typec: Check for EC driver
     
    +    [ upstream commit 7464ff8bf2d762251b9537863db0e1caf9b0e402 ]
    +
         The EC driver may not be initialized when cros_typec_probe is called,
         particulary when CONFIG_CROS_EC_CHARDEV=m.
     
    @@ Commit message
         Reviewed-by: Guenter Roeck <groeck@chromium.org>
         Link: https://lore.kernel.org/r/20220404041101.6276-1-akihiko.odaki@gmail.com
         Signed-off-by: Prashant Malani <pmalani@chromium.org>
    +    Signed-off-by: Laura Nao <laura.nao@collabora.com>
     
      ## drivers/platform/chrome/cros_ec_typec.c ##
     @@ drivers/platform/chrome/cros_ec_typec.c: static int cros_typec_probe(struct platform_device *pdev)
    @@ drivers/platform/chrome/cros_ec_typec.c: static int cros_typec_probe(struct plat
     +	if (!ec_dev)
     +		return -EPROBE_DEFER;
     +
    - 	typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
    - 	typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
    - 
    + 	typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
    + 	typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
    + 							EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

