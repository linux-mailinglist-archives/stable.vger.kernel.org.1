Return-Path: <stable+bounces-110858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2169A1D547
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C35166B71
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B01FE46D;
	Mon, 27 Jan 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEnxf/2Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC725A646
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977123; cv=none; b=u4WijRooZ0xfWFasMmiskx26SflF+1M9DHAsuHcQj+jh+NuwadEzL6eqRYpJ5AD3tRVt3YyoHbaC/It3MT4cAVMCuBrRr+aIjlNSDYB0Nmxp+8WLBHaGTFWBBz4aTo9YviPkBeTqeLk0Vs6HeFQzHSqYTJ1yo+RhzH9vuwzlKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977123; c=relaxed/simple;
	bh=MC7AB7DoWTMmtpB5KTG+KljWkqThfg4l+4dlAJpuiMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWC0ACUUFrkXDDqg+kQbu9cY2akNLExuly7ilPLbkgC+4Ky2KvPZF2Ksb5+ogTF43K+OBRq1IAbKlUnGSLE6MXDkZFYh9eT4ZBbt4DKgutt2XvU1vUFe+LZPNO3ByozvjFESvtqHPmS8IPPM1Bes4+9cRoA+Y3HZrP4NrH7QjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEnxf/2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48DDC4CED2;
	Mon, 27 Jan 2025 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737977123;
	bh=MC7AB7DoWTMmtpB5KTG+KljWkqThfg4l+4dlAJpuiMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sEnxf/2Zvdr8LhnMO1kHWd2ttr3PECSwZihXgYupSvS5ZTfJrmAazJI8Q5zhBqQwJ
	 qBfieVokn4DPMKiQ+isXOlmBFvs+YQW7revkWzatdCwDTjD57SprBuiVseEuYomc83
	 zz+24evIAcM8Fcv0Jwz0Hzy/uodk8rpWfTSxAGxHIkEmzMjzDs6/yVNqMt7LIcDoEC
	 E+UWGAjh/9cM8bCHaRR8GxabDipYX9RtidMjshxdl4cEzG+T2KCKS5ZgNr2B8btRU6
	 kv//YMF9JK9ML9YDBKCzlsGNysp9bj1rgkYVAZn6KBLzF48Vt+YovKCadT68wmrcGm
	 aK6kY96mOBgpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 1/5] md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
Date: Mon, 27 Jan 2025 06:25:21 -0500
Message-Id: <20250127041848-c7457d3d9d9f4ace@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127085214.3197761-2-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 08c50142a128dcb2d7060aa3b4c5db8837f7a46a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Yu Kuai<yukuai3@huawei.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  08c50142a128d ! 1:  d81dc3d1913b5 md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
    @@ Metadata
      ## Commit message ##
         md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
     
    +    commit 08c50142a128dcb2d7060aa3b4c5db8837f7a46a upstream.
    +
         behind_write is only used in raid1, prepare to refactor
         bitmap_{start/end}write(), there are no functional changes.
     
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

