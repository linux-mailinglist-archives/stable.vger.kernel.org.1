Return-Path: <stable+bounces-128808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C874A7F312
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 05:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A271754B8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACAE1A83FB;
	Tue,  8 Apr 2025 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuC/UlJ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5623ED6E
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081769; cv=none; b=C5QQ5ZJNgd5rBdxST11dcF9rafd0jZPAmCeUG0c8IMHX90up7BzN+tnzjfo1GeR6T5ivIPx0Co6K8d9xW0J4W+2SLJVnBcXRRi7kQ004YhTx869z2XIx+nZKulBI05bYvSeMoG/nP36V/MoTmHet/oGt4Urc6GGVe2uxja5vMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081769; c=relaxed/simple;
	bh=7RkrrxatRTbXJ9neco5//FHMMUhkDh2DSSb99P43xX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q64HQzsFAddqys2tra7CN57vgu7UUEEnlp6zvr3xxOADkWOKRMa8jrLTjzTo6gDaFVcPlHRkx+QM/oRXMEYi2eRyxQSFCP6Vy2NYg4RE0oeF30Frj2ApjS8h/3cxBhDYiRm79a7ooes870Unyh2lIb1W5H6uF5LgEOkDZW/ZhCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuC/UlJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EC2C4CEE7;
	Tue,  8 Apr 2025 03:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744081769;
	bh=7RkrrxatRTbXJ9neco5//FHMMUhkDh2DSSb99P43xX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PuC/UlJ6wph1Vp9XiTj5i8UhldsJRXMOr2EawCaPVXsCgBEUa2xc0lFxBE6WF+sfS
	 jFHEURFLrQ4G49GRm3Y1SwQFxHBBgzGrbnW268gu7896N5BWgivJD53XyKIva8yvXu
	 JririBWvttScNi8acvJ/ASjrFlbSP62B/387FyP8+eBrqI9nLjNFlcBt9B7KuCgWtN
	 EiUC6GO9v6Z+GtJvIeSiAs4BcmsyaP6GzNvSDjT8np336sbvBP19awzt12FweGbjVo
	 DhrJt0aWkdx3mKIbFTjyHxKAHQt1QcozO5Zu3dXRl2eUtyyEtoklh881F71nkTzmHJ
	 iclAnednOFk1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
Date: Mon,  7 Apr 2025 23:09:25 -0400
Message-Id: <20250407212950-0116e26de319e974@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250408004359.3361615-1-jianqi.ren.cn@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: a54f7e866cc73a4cb71b8b24bb568ba35c8969df

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Hersen Wu<hersenxs.wu@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 8406158a5464)
6.1.y | Present (different SHA1: 3300a039caf8)

Note: The patch differs from the upstream commit:
---
1:  a54f7e866cc73 < -:  ------------- drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
-:  ------------- > 1:  5791f5818e634 drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

