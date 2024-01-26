Return-Path: <stable+bounces-15882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCEE83D7E2
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 11:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60D4283E02
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C63134DB;
	Fri, 26 Jan 2024 09:58:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805F2904
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263080; cv=none; b=dDw6EE2S/uCwEz1cGRfsJ32WUR1YC0QkfC3lADjCLVWb/OUclBdiS1bUw6tNTQu+XZnvWzzmpHCewf7swgrcxmVFQ4eHlP4fqZR+ZOyGfPjYSSrh4RBBjz9W1npfM5HuE+opt+/deTn4ViL7NdNiTlgUl51yMRC5R2Au8p7jIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263080; c=relaxed/simple;
	bh=DoWSj132qlLZibj8ratLUexxCCXJzaMLbG6Km1cF77k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dkVNoduBGpGTWbizR0nvE1VZUgF7FCyrVBrqJasj/1by7Ev98KnHGfIJrkbUP0l73fB5Lm02o8NXiCkN0SlxNGzyr2a5uk6MTEdwf+z8O5Z4p/3yMF3+LoJv96Y1VYzWeZN4PUrjhALrVQG53cyWKGLJhiKf/6SObMLMexBLc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.43])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id 96f08978 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jan 2024 20:51:12 +1100 (AEDT)
Received: from localhost (largo.jsg.id.au [local])
	by largo.jsg.id.au (OpenSMTPD) with ESMTPA id ffb24e39;
	Fri, 26 Jan 2024 20:51:11 +1100 (AEDT)
Date: Fri, 26 Jan 2024 20:51:11 +1100
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: mario.limonciello@amd.com, stable@vger.kernel.org
Subject: duplicate 'drm/amd: Enable PCIe PME from D3' in stable branches
Message-ID: <ZbOAj1fC5nfJEgoR@largo.jsg.id.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The latest releases of 6.1.y, 6.6.y and 6.7.y introduce a duplicate
commit of 'drm/amd: Enable PCIe PME from D3'.

For example on the 6.6.y branch:

commit 847e6947afd3c46623172d2eabcfc2481ee8668e
Author:     Mario Limonciello <mario.limonciello@amd.com>
AuthorDate: Fri Nov 24 09:56:32 2023 -0600
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Thu Jan 25 15:35:45 2024 -0800

    drm/amd: Enable PCIe PME from D3
    
    commit bd1f6a31e7762ebc99b97f3eda5e5ea3708fa792 upstream.
    
    When dGPU is put into BOCO it may be in D3cold but still able send
    PME on display hotplug event. For this to work it must be enabled
    as wake source from D3.
    
    When runpm is enabled use pci_wake_from_d3() to mark wakeup as
    enabled by default.
    
    Cc: stable@vger.kernel.org # 6.1+
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
    Acked-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2c35036e4ba2..635b58553583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2197,6 +2197,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 		pci_wake_from_d3(pdev, TRUE);
 
+		pci_wake_from_d3(pdev, TRUE);
+
 		/*
 		 * For runpm implemented via BACO, PMFW will handle the
 		 * timing for BACO in and out:

commit 49227bea27ebcd260f0c94a3055b14bbd8605c5e
Author:     Mario Limonciello <mario.limonciello@amd.com>
AuthorDate: Fri Nov 24 09:56:32 2023 -0600
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Fri Dec 8 08:52:17 2023 +0100

    drm/amd: Enable PCIe PME from D3
    
    commit 6967741d26c87300a51b5e50d4acd104bc1a9759 upstream.
    
    When dGPU is put into BOCO it may be in D3cold but still able send
    PME on display hotplug event. For this to work it must be enabled
    as wake source from D3.
    
    When runpm is enabled use pci_wake_from_d3() to mark wakeup as
    enabled by default.
    
    Cc: stable@vger.kernel.org # 6.1+
    Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
    Acked-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81edf66dbea8..2c35036e4ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2195,6 +2195,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
 
+		pci_wake_from_d3(pdev, TRUE);
+
 		/*
 		 * For runpm implemented via BACO, PMFW will handle the
 		 * timing for BACO in and out:

