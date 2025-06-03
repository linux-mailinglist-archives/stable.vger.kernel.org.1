Return-Path: <stable+bounces-150755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA09ACCD29
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B88D7A8C22
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FDE24DCED;
	Tue,  3 Jun 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCoYNpTd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD6BA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975767; cv=none; b=TKJ98FUqGlLO5QAT5P3uk3MNcgJBClOHtebuWO9SwW2wDdGb3OfPKc1mgiQ6QwktytJ1A4QmecFUdBpDHwIPKEBM1gNpUutkpUsfcFvNV+WhDf+1TCS8X0kW3RO+YpgOjJBeAAjRuPoAoBtqjb1XFfhHK+w8y7RwG4+F5DNtv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975767; c=relaxed/simple;
	bh=qKBPcwGyI9gzLBJ+is3yFI/R+Npk8AgjBadoVIjbbo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9JHcor0F466XjViLUbnS6ykdKjddVHqeIrMX41lQCBxhCuBVCE5VX0uVf+Uj7O8eCgEr1xnT+HOWvzp1W88gAs3d7gSGc5G9kC3HX2YSOZfuUuuyArC1YAnsOKc+X+yEf/ErRcfSbUHpPWUEEMKoP9McpXSF1Y8zPCyKlx7EVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCoYNpTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D9DC4CEED;
	Tue,  3 Jun 2025 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975767;
	bh=qKBPcwGyI9gzLBJ+is3yFI/R+Npk8AgjBadoVIjbbo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCoYNpTdHZQZgM7B4HUvzTZjPWnmx9r35nrXHiOzzCuXf3VuSNFZK1bvByc3GUZDB
	 4MTELuuKC4M2XMIPFiyq7Dj2QY/gT+PHUmKNIcemSBFCSDNv7ek9cAlBYAL/5cC/Ra
	 FJXGKgh8Erz8tfDjy5D0IDZ/1xtswM5mZ9GEkALLcF8cQT3h7u4+ksM/gZchWV6gty
	 qDTE/ddP8JUAavBATGmIaL4Rpq+FVi6RbvPvz91LKrlJNhs9uGn77FVSRBSX+5JXFd
	 iXooHKZ6kOv76eoqrnX97TjI46gOLQwqowY0SpQ13OBlPa61dHMgasQez6CpghUp4F
	 gZYq7yDYCENWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jm@ti.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
Date: Tue,  3 Jun 2025 14:36:05 -0400
Message-Id: <20250603141244-5e908caa343af6f6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250602222827.86162-1-jm@ti.com>
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

Found matching upstream commit: f55c9f087cc2e2252d44ffd9d58def2066fc176e

Status in newer kernel trees:
6.15.y | Present (different SHA1: 4f35dcb075c0)
6.14.y | Present (different SHA1: 4a4594de75b5)
6.12.y | Present (different SHA1: 084b88703921)

Note: The patch differs from the upstream commit:
---
1:  f55c9f087cc2e < -:  ------------- arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
-:  ------------- > 1:  5e2bddac471cd arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

