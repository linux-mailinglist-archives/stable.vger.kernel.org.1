Return-Path: <stable+bounces-94602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC79D6000
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9442928336C
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A913635C;
	Fri, 22 Nov 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucWcEF+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538912BEBB
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283504; cv=none; b=MY36u4gQN5nTXRRlGptVo56dqsRUDu6bi94fZ1l8m0VoEIB03xdxJsVDFUUtN2bTgNjwtTtuoNz6XsbOM6i4G6eqg94xsVuF93cWjhyMHfzVHKjJeV3CWuJA+73Qy/XYF5lh1eflBJCiYoufGwhKr0pwMfQlizGZxb6T5zdLGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283504; c=relaxed/simple;
	bh=WYIMf7qbkVQ60u5ZjVc9iuaXWeHoOy48ueQRg0enpT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrUKvRjKq/yCZihXYp4sfAp3jCLrf0zO162M2Q1WjWwb6f/UpyAYm4hMYYP4408YJ+Lacrh/GKksqQteY0wLS1cWltoEU7Mv2VfWyU+a2TxWOoxosR5ajfjSvnsWVqjZvzV8VKOoZIyZcfsp9VM8np9asoD1piM4JaJ7PKXxvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucWcEF+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2B2C4CED0;
	Fri, 22 Nov 2024 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732283504;
	bh=WYIMf7qbkVQ60u5ZjVc9iuaXWeHoOy48ueQRg0enpT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucWcEF+EUSnsH1xZKpjP1QAIX/Fs5/NJJ3h0zgvi2qjumztSB3IHIofEineskJyTA
	 owBk3fiI2H9yjcnhkdPPPgz0btER5FL2mLgCRr9Cq7WjhZWRpEjH0LOD+m5Y+aPSP6
	 E2fa8lK79+9OgZQ3YyTjKVP8eNYASXBRplRh9zU0B5yxQRhNRUPCZ2wUKO8NO9y17x
	 HWoUv1dy5TX98GqhSvBEeUWnTOmlVU7/aidNnVfme43r85rnOzpCXMknLEkg0c+cu/
	 OtQD99KQwueQJNIyx4vX6/5g8FlNt21l5NrkA7wtLGjIKvK821jb4VNKo88YKYLaLU
	 KGjiuOgiZTDqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/3] net: fec: Move `fec_ptp_read()` to the top of the file
Date: Fri, 22 Nov 2024 08:51:44 -0500
Message-ID: <20241122083920-54de22158a92c75d@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241016080156.265251-1-csokas.bence@prolan.hu>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 4374a1fe580a14f6152752390c678d90311df247

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Csókás, Bence <csokas.bence@prolan.hu>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 97f35652e0e8)
6.6.y | Present (different SHA1: 1e1eb62c40e1)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 08:39:00.262357742 -0500
+++ /tmp/tmp.2jyCFuEVB2	2024-11-22 08:39:00.254181034 -0500
@@ -1,19 +1,16 @@
-This function is used in `fec_ptp_enable_pps()` through
-struct cyclecounter read(). Moving the declaration makes
-it clearer, what's happening.
-
 Suggested-by: Frank Li <Frank.li@nxp.com>
 Link: https://lore.kernel.org/netdev/20240805144754.2384663-1-csokas.bence@prolan.hu/T/#ma6c21ad264016c24612048b1483769eaff8cdf20
 Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
 Reviewed-by: Andrew Lunn <andrew@lunn.ch>
 Link: https://patch.msgid.link/20240812094713.2883476-1-csokas.bence@prolan.hu
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+(cherry picked from commit 4374a1fe580a14f6152752390c678d90311df247)
 ---
  drivers/net/ethernet/freescale/fec_ptp.c | 50 ++++++++++++------------
  1 file changed, 25 insertions(+), 25 deletions(-)
 
 diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
-index 2e4f3e1782a25..7f4ccd1ade5b1 100644
+index 2e4f3e1782a2..7f4ccd1ade5b 100644
 --- a/drivers/net/ethernet/freescale/fec_ptp.c
 +++ b/drivers/net/ethernet/freescale/fec_ptp.c
 @@ -90,6 +90,30 @@
@@ -87,3 +84,7 @@
  /**
   * fec_ptp_start_cyclecounter - create the cycle counter from hw
   * @ndev: network device
+-- 
+2.34.1
+
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |

