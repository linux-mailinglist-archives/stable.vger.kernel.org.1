Return-Path: <stable+bounces-142882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0940AB0010
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB019C16F7
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89DE280325;
	Thu,  8 May 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJbtm2QV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828822422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721064; cv=none; b=qGB3ByCaB+sI6S0FKt98HQL69B3jslwpBM7CbXCabKhZ3hUH8UbGpXNUHqGWBrW1bKXPGwve1qEzFshlL9lqX0ic5sJ6G2reG7TEQ2pXez+GyCRZDD4tyulfPKU6DXrbKlOskb7NhrO+Q4PnEIHROOuhgwR+sdaBZa9q7DAMQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721064; c=relaxed/simple;
	bh=pZYF+RPI76MpkNA9bn6TEg6n74OFp50aILAJ4n8Wp1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnjlwbbZHz0bXNkPXB10iyGo0cO2nTxa61mIIhc/M136YIq1/HLAsV9Uu+RvcmKthWKrnd1P/KPhWhvVxOOricjOcZZBA+aO8QLhqaT0RTdfAPBoj3KumzNqGjOlCiYlxxiO8A9qTQa2nUEFu3skWFiZWAVGoTMRN1x7z3ZCZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJbtm2QV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3079C4CEE7;
	Thu,  8 May 2025 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721064;
	bh=pZYF+RPI76MpkNA9bn6TEg6n74OFp50aILAJ4n8Wp1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJbtm2QVdxTQrrziDxvEZYsMx5Ntim2ocbcXAAbjDA3L+61yTCi/jk3LRHph+tglp
	 w4jdZB/cDQJxQwu0CQIoL/BesAZj2y83SFKoL4L0vJ8zHhzyDLPwR6t/rsZ0f/mvnd
	 t6LUNRrCyipFT/peWPe0uzk0Yu1ZBKuIeSumIfijwyNRRX7JwjaVFaG4F66e5ur0X4
	 TkULam3z2mfrdLH/kamta5ZHpRUm4uJ8X2G3QX18q/mg5tdUM3SFEwXPmHi1MMyANC
	 0shmxqVpoIDnXri/4XXI7UPAInDkl+EnoKN2HVZm67MbnuLTBTsp5e4ThxAKgER1ze
	 28n5AnRFwYFlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5/7] accel/ivpu: Abort all jobs after command queue unregister
Date: Thu,  8 May 2025 12:17:40 -0400
Message-Id: <20250507121025-2d640e872dfdd4b3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505103334.79027-6-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 5bbccadaf33eea2b879d8326ad59ae0663be47d1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  5bbccadaf33ee < -:  ------------- accel/ivpu: Abort all jobs after command queue unregister
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

