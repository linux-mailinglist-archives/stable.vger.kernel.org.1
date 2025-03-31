Return-Path: <stable+bounces-127140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E02A76916
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F2F188C956
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65641218E99;
	Mon, 31 Mar 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd7RMOTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E982222BF
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432503; cv=none; b=EfMO2iymnhHhDIOKjkiR1XpWjdmxu4w8oqhTq+hC9EtEqHvSxFvW18ulJZBdRCRe2uY3kDLPAk7z1p+Uxca7CGOVJtDqOjoNEDtOrveyvPAUiaHtQD4LwTjKTQli/PJ4w75Lt14IpxeeBOROU+Uqe3JMpbNFV0SEeTUUohj65pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432503; c=relaxed/simple;
	bh=0YRcTzVd/5LMyL5gGfTDjeQei0Tz9SIz9N5zWXHpTsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSSWqIbkA3jTVC9foFChUzj/n3auCzjfZ8iavKOjU0zn/9WlUNvHoBIjmGiW7uTVOH00AYnYUT/D+AzmmwxHXWdtvLdQxkdD5xZ3ZJGDQ/4WTE+hqscsim/sHgNIX7BXqmgj95rWcN8isexeR9p4PM0mm138cPOfDbzs073XTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd7RMOTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2833CC4CEE3;
	Mon, 31 Mar 2025 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432502;
	bh=0YRcTzVd/5LMyL5gGfTDjeQei0Tz9SIz9N5zWXHpTsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wd7RMOTr4gGDW/8peB0efaX2OHWbXY7Mo3WURusYrJJdZKQY0DXf+DdPS8U5maxI6
	 sXnVmQbfO+I7iql1d1Tp+EnQkbJZ1QkKA5DKk5I0fg9wtYzGm5xueH32ciVPclP9VX
	 fMUm47EzuT2dggNmuCacOz/NiVoE9VgCq6XbhIuZZK6FKZ/vEWPHGv1fTcZSd6PjlR
	 t+swStgGnlZjbCVmZ6J3GMrimMUJgsM6MrxyoKvaUw9ymCFWMYGqYZt8fPQTEem0Iz
	 GI5PKTDnwD7CSOn5zIsHCnT3BFYov5xRqcpdNHkXFrKjbmOqKgnfMcvo9zTj9UcE9w
	 2DVYsOXtJ9syg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	eichest@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6
Date: Mon, 31 Mar 2025 10:48:20 -0400
Message-Id: <20250331101810-8de593b37ed0466c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250331073350.12287-1-eichest@gmail.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 83964a29379cb08929a39172780a4c2992bc7c93

WARNING: Author mismatch between patch and found commit:
Backport author: Stefan Eichenberger<eichest@gmail.com>
Commit author: Stefan Eichenberger<stefan.eichenberger@toradex.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 6cf5ac324f87)
6.12.y | Present (different SHA1: bfd4ce01a59f)
6.6.y | Present (different SHA1: 0508efe54ae5)

Note: The patch differs from the upstream commit:
---
1:  83964a29379cb ! 1:  14d3ef9e68a5f ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6
    @@ Commit message
         Fixes: 4eb56e26f92e ("ARM: dts: imx6q-apalis: Command pmic to standby for poweroff")
         Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
         Signed-off-by: Shawn Guo <shawnguo@kernel.org>
    +    (cherry picked from commit 83964a29379cb08929a39172780a4c2992bc7c93)
    +    Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
     
    - ## arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi ##
    -@@ arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi: lvds_panel_in: endpoint {
    + ## arch/arm/boot/dts/imx6qdl-apalis.dtsi ##
    +@@ arch/arm/boot/dts/imx6qdl-apalis.dtsi: lvds_panel_in: endpoint {
      		};
      	};
      
    @@ arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi: lvds_panel_in: endpoint {
      	reg_module_3v3: regulator-module-3v3 {
      		compatible = "regulator-fixed";
      		regulator-always-on;
    -@@ arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi: &can2 {
    +@@ arch/arm/boot/dts/imx6qdl-apalis.dtsi: &can2 {
      	status = "disabled";
      };
      
    @@ arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi: &can2 {
      /* Apalis SPI1 */
      &ecspi1 {
      	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
    -@@ arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi: &i2c2 {
    +@@ arch/arm/boot/dts/imx6qdl-apalis.dtsi: &i2c2 {
      
      	pmic: pmic@8 {
      		compatible = "fsl,pfuze100";
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

