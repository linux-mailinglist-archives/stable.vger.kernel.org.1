Return-Path: <stable+bounces-119997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF335A4A884
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133123BA1C6
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7BF16F858;
	Sat,  1 Mar 2025 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUKb9foL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0002C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802877; cv=none; b=AcmEn7FHKFB2wtYzROH9d8lktnSy0cc5TGKZE8jFfsAaOaAakimPTy7AWzygXvvhgA8hUrXFtbt+SuQ/Mmoucf0gHzG4XuuYZYYYi5MxrDpgi/K6zs94nfJLC9gh5LSUyr7K4NJNbFAS06f9nxcpMDD5HndV50NvVhmWIOlGrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802877; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PL9xP4r90g8X5dI4IoBs55oL1LYugYvK6OsJsR8W+o2FexI1QcPLAttz+9abC1yrXWIGMV77BALjKNf+RMB8GvUUosISYOKmjVoAdqNACXso0MQaYvARB4UbgA/HVfj/ERH88monuZZ7CZx6/Hm3oLCQ36Ualc5n6gsj8PgIl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUKb9foL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E90C4CEF3;
	Sat,  1 Mar 2025 04:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802877;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUKb9foLGhtStKl8J8a7C/Ssp55QSVrSjS3hpDey5tAuNhn7b2Zakx+FqcJsHBCQA
	 ec1vz+UHH/ktVsdbJ4q8F9N7+/ghSp5b4GCqcHfQDTo6zqtz44tEh30A0vAvLqXwCX
	 aBEznMAAseg05u/LXR82sGuCNnMrYQODJnILaJJ80V4+2GWbhAV6lBfAU7MVTsi+HL
	 rdNfF2irhzWo4AhOq9PDKpN/a9dRPYIwWxBYNwxBUSzhiZsUpGnt2pSemUf+BrBF6s
	 bWC+iuTxgSiWAVMOSpakpP4sxLZ7t4AvkVwHIUCwFXOcOZL5i8r8numqdnmVFDOVpe
	 nh1s/5IaNlWPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tglozar@redhat.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/4] Revert "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads"
Date: Fri, 28 Feb 2025 23:20:54 -0500
Message-Id: <20250228190602-fb8202ca174f2640@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228135708.604410-2-tglozar@redhat.com>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

