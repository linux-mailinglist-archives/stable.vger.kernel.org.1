Return-Path: <stable+bounces-70244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC1E95F5A4
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF43B283314
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC719308C;
	Mon, 26 Aug 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3VSiRJk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411849631
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687725; cv=none; b=dN03ehSD55f25QOEgxk+yvSHnCruSuVNpMJs8MucryAxA8KvK2cZVFC2kYAE8+FEWQF9L8pVomPuDARoIF0CXxYzgYN5MKlNPWR8pSDhsfbe53sVu2wUc79+nNoWlzaPuxZOViK9+qlLd3yzCdWZH7UTWGmT0tlm8VHgcdm1aSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687725; c=relaxed/simple;
	bh=5Foxm4LUjNBxiyhUC13TzQIP2psCLF2l2En0faqviN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qdeltwd0PqQLvOfoDuoDsYJJItItGBHsDwpo/WdCyoHYIA4gthqXEzeP1tvvzZZD7pBuSB7MlK6JWFheW97xQJiH/YCHr2WI/IXQCongD252gr2zGIEq3HQ+Kv15VPo5OmV5wbM1Kgn7P51kW2QiXjpTNzyUV7teU1OocXmNW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3VSiRJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C20C52FF5;
	Mon, 26 Aug 2024 15:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687725;
	bh=5Foxm4LUjNBxiyhUC13TzQIP2psCLF2l2En0faqviN8=;
	h=From:To:Cc:Subject:Date:From;
	b=m3VSiRJk1F47RGYQj+xQ+tbj0LsYgbhHlNfab1+B8/uHNvbEK7a9dnnKTBte0Bkg2
	 K6jQ8ORJYDB5DPoJsxC7EqkworYU4QXA1+fPS7QZX3TPfBM1KolHIke0K222HdT5P1
	 KHuEPXiT4RfOBDX84UIID+AxHDW/n4j1Tmr3mKcDz05gaiVbHOHJnuRVzPyfhiHCH+
	 QSmCSw4BPfYK3zzHoXn03SvFA/oLLYR6hRBxfIm4WW4glp7Tmga03KijMggz/Qp4cm
	 7RMcxNW1FOpHDOLgJ+pyfLFpeACHXfykETBHO2lj7dPpEPNmW1zgHPUkhOrNGbkyC8
	 HO97dqh6KirNA==
From: Mario Limonciello <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 0/2] VCN power saving improvements
Date: Mon, 26 Aug 2024 10:55:17 -0500
Message-ID: <20240826155519.2030932-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

This is a backport of patches from 6.11-rc1 that improve power savings
for VCN when hardware accelerated video playback is active.

Boyuan Zhang (2):
  drm/amdgpu/vcn: identify unified queue in sw init
  drm/amdgpu/vcn: not pause dpg for unified queue

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 53 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.43.0


