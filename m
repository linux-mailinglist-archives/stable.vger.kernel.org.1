Return-Path: <stable+bounces-132168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F95FA84910
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C527B9C3B8E
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FDB1EB1B9;
	Thu, 10 Apr 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkf1dVFj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60E41EB1BC
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300588; cv=none; b=Gslq2FEdbuS19/oCiEYZvZOF5yX7L0Sm9AcfrgO7J934EWxDCkcP65mnSfFDBJsIOfwhLJZuP2VMir15ZU3tudJbxFjc7pOk4ud3HtXKg+UV2HaQp/35liyzx0a8lg+4ws7lOhFCfj18jeA+h9pqsB7SL/vGPzaMSbh5os7wW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300588; c=relaxed/simple;
	bh=wxIwcgFpX2wGDnJyYtni78UYgmqnp07LBKi0KmEfKLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fw2kko9W9/HUMY1L4i1MpqPZvOzvfwoTA2rkCA9B1WX/t4DlEHRUtDjXTkVGryYitTJxiMQK6iyvHYVZ9FUv5fkqKpxp7jcvVhDd4bLyWVXhmVbXbXpOQIMMeNgZtbE5OHHzBYZnHcwamtA1CnhNsSWEEVCgiZwLe/YvDAQIr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkf1dVFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22A2C4CEDD;
	Thu, 10 Apr 2025 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300588;
	bh=wxIwcgFpX2wGDnJyYtni78UYgmqnp07LBKi0KmEfKLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xkf1dVFjjH1/tnQ1LKe91amkB81x15dkQokyzCGPhM5swgfCfCihbW/sptSFp0iEH
	 gYZqyFiBMSh3Qe+e3U6V4mkJztubrDF6zXWgEZGCFVydfga8g0cGS8YCA4ToCq+Mpn
	 97EGmXnrjwEb/jf0ReM8a9LKQGgACtQ+0RPIeMrqvl1OmxMFu7dY8zfwIzWJvpPACF
	 b5BNfIyuAzs9ki5AsJ/ChMqU0GkJ1/V6dzWjtWMKR5Wjs5MFrJiDEVFoQbirQHN5Il
	 7qmEQJJ86i4AbLQd5eEcnTUpcIhF5Quc+OsRAwv1VYNtOId/YPMA5qvmbub4E035Hw
	 rn5yNN7k19Vyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
Date: Thu, 10 Apr 2025 11:56:26 -0400
Message-Id: <20250410091200-f1c4939cf214f624@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250410063234.3056912-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 63de35a8fcfca59ae8750d469a7eb220c7557baf

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: f01ddd589e16)
6.6.y | Present (different SHA1: 08ac5fdb9c6d)
6.1.y | Present (different SHA1: 5bd410c21037)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  63de35a8fcfca ! 1:  1007b7a59399e drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
    @@ Metadata
      ## Commit message ##
         drm/amd/display: Fix out-of-bounds access in 'dcn21_link_encoder_create'
     
    +    [ Upstream commit 63de35a8fcfca59ae8750d469a7eb220c7557baf ]
    +
         An issue was identified in the dcn21_link_encoder_create function where
         an out-of-bounds access could occur when the hpd_source index was used
         to reference the link_enc_hpd_regs array. This array has a fixed size
    @@ Commit message
         Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
         Reviewed-by: Roman Li <roman.li@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
    - ## drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c ##
    -@@ drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c: static struct link_encoder *dcn21_link_encoder_create(
    + ## drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c ##
    +@@ drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c: static struct link_encoder *dcn21_link_encoder_create(
      		kzalloc(sizeof(struct dcn21_link_encoder), GFP_KERNEL);
      	int link_regs_id;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

