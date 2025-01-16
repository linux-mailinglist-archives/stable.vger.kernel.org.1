Return-Path: <stable+bounces-109187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D760A12FA0
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A85163070
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E638C1E;
	Thu, 16 Jan 2025 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxH8vCbE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDF79EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987127; cv=none; b=qC6khnisGWV1lrCXJiuMZn/DfcnbOg5ff/ikktplbsC/YZyvOzTiWC+z+HbiVDJsyVCi0HLH1FfzZ40fQSw4SHCRFJhvOLeze5npV5YA+F0sZeoIq8YtuEmP1yaBL/dSyOb1N3a1UE0JlfmMhGaZSO2VHqnfC3ZYToRGLr3Jqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987127; c=relaxed/simple;
	bh=7Yz73/n5klhUGNZL9/oVG1DlnOxmMaxWP9PthEsszdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rn3L3CudTxp4jYIslr2oyVXgLVPRI0mYMrfkFIeT1rMRa6bx4HX5D+JcR81yGReNUyM7/5MiC/fZ1JznGjiHeCxm/iw5SPFOHlAOnto5G78TsLysAqYwa7WSD41dIWty9DkOqiZ2SOj780F+R58X4wTPP8tOXJxDRQiWyI3zJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxH8vCbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D456AC4CED1;
	Thu, 16 Jan 2025 00:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987127;
	bh=7Yz73/n5klhUGNZL9/oVG1DlnOxmMaxWP9PthEsszdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxH8vCbEoZzYDsR39lu6CEj3p+AAtnGeNrIB2Y0FYpTbK+oqM6mY/GG4hDF/9hHpE
	 OuNtxR0zZaiDQs+hys6xVNEQt2ArRiKYUnUQ6PWFF4jjHC5+DW+r7qipTu+uCOwltD
	 lbbhtfisZCCfCBbMtaZxRXTWP+rXk/FmmS7AqiX6ZZAo0m4lCXX5uDIt43s3Ktsmun
	 vMXsJXu2CGCT+Q9n782E0jAHJAGTWqJdjwyuRYoR7/QLuTEuzVE8JAu9SwngMosp+z
	 TaphTEBv2qMSVhHqcKXiYSaqeuufFgpqHu5UL4YO2OYO0ZcdjzLhMzn/UkxDJnOWbm
	 NdptFddt3s1Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Youzhong Yang <youzhong@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] nfsd: add list_head nf_gc to struct nfsd_file
Date: Wed, 15 Jan 2025 19:25:23 -0500
Message-Id: <20250115165819-36c4d51ebfe190c9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20240710144122.61685-1-youzhong@gmail.com>
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

Found matching upstream commit: 8e6e2ffa6569a205f1805cbaeca143b556581da6


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

