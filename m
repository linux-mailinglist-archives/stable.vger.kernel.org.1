Return-Path: <stable+bounces-139366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0BDAA637E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C581BA73A5
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CDF224AEF;
	Thu,  1 May 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1Z19Swh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AD215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126583; cv=none; b=mGqPIYBnbuCycTmJXI3DzRISZuM6ERspyccrdjbJW5nyGqDJgarfxVSTNR6yF7vDQZzjfUCeOqmTTvYWXovLJ41/EhfeAEGcV91S63E9E2+7PZf8D7dNQwc0hweUapGeFT2tqJSDTi55to/nWU09C/5AYGvM9Rcov0DHzpDpx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126583; c=relaxed/simple;
	bh=G+sc3/Kb4iz5TvhJtOhOg2Yq0b31oH3vba3QVbasH84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBLIvAjak7lijd+EFnfujGjDFvzHG8w3AOQpW3/xHbyCmDJpntnnJrX69M1UIZqcpAfJJdqBcSlYQBTjIBjQhGYsi6XuGaGTuvy121uV6zQftHUhQaDRx4JCB5qFLBUsQMyo9oc7LFOXqQLK/mXWqYS+uSZz9e9yjdQCFbLmTAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1Z19Swh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D69C4CEE3;
	Thu,  1 May 2025 19:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126582;
	bh=G+sc3/Kb4iz5TvhJtOhOg2Yq0b31oH3vba3QVbasH84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1Z19SwhKlkMx9ZOtBTFCAmfGS4TrTuLBL8mJ0a9adfVeOeclwUzhXj00OKhzUIyN
	 SRgbATcUeHbOwHbnagVcdfh+SVmXq75bl5IVGib/WuVsNDrj/cMs/S00luweKacgxx
	 OONUQk0ghFIzdMf06ZtUve1qOn8tCRHXb+GftxKngq4HS4unsn9DPKWGQIiSpmp5oG
	 jdqmkjrug7sGFBEHa8CFUQ80KyN3plOI5ZOA8YbqpSaPkQ1Y/gSTYWP483il0k2qK9
	 WK941towICgyygEbwEaDHZ1UDM61UEAV4oQCXnyOLm2oc+FmGCUcF6f7hy2z4mgCws
	 ZTyEFq3AjneEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/7] accel/ivpu: Use xa_alloc_cyclic() instead of custom function
Date: Thu,  1 May 2025 15:09:38 -0400
Message-Id: <20250501114716-051bc5f6ed9b0d83@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430124819.3761263-3-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: ae7af7d8dc2a13a427aa90d003fe4fb2c168342a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  ae7af7d8dc2a1 < -:  ------------- accel/ivpu: Use xa_alloc_cyclic() instead of custom function
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

