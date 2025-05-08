Return-Path: <stable+bounces-142896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF1AB0027
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22561C20B75
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D99628032C;
	Thu,  8 May 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9jikWvW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAB27F4E5
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721123; cv=none; b=pgA00evGO1br8kIMWjEP/PMKzr71mXtu4EtAecqOpgFhu4+aswun6OPggPjM/Sx/ll9wfH0100w7fcpWCNAXHd8lb9FZSLBdXxfXvdFCbuTcu+Gp8mkh8mQBVWOcbD+33nPag7NWqQjcdc6aU7Ce0x2wKUT8rMOUpPVO+9sZOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721123; c=relaxed/simple;
	bh=o+v2ywjqlV2qVAYPTQfVj3pDHdBVrNtxuSt0rYYPnwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXQYiPxf4YdLCjWgueAO0pHf+zUAo3ExbYK7d2hAtw50zQSG8aFZlWQg+YqyTexwsHDgbHWryF6ga82CnCX33UP6C8AloVAxqGJheoyE/RBEx3c6dsf9N4pJBLru89g/Na0z9+pqMGp1wFqEqj0RyZNzKSMmRq75gckcSV7IKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9jikWvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87190C4CEE7;
	Thu,  8 May 2025 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721123;
	bh=o+v2ywjqlV2qVAYPTQfVj3pDHdBVrNtxuSt0rYYPnwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9jikWvW3rcbQmtxscQS/xHQnOlUUi7D8N2vLpqw3DbcNppV10fCIKzCUty+2dzmr
	 nw+/0dFl/+nIdOPYANKfwKiBUbFrnITCEN71pUjsrP8mlUXMdeyiOmAdfXTbkisAYu
	 5Xr786p9fn6NpsHiSAmI/3YAV1FnI3RoT5JY8OkC8LY8Vd5Y9RF1iLwV2V0iKzb7do
	 e2ZK+sBh8CXuwIQmICDKtje6X/WHFbbalTxLxKYd1mulXWEC7DMXmsyLOnUqREbr/H
	 PjTIa7kF/15ThF9BWaeuRtbJOrc7Sf4yksef3+uWU/Bx0LK+QCGuhVN87XDsiY2UKg
	 uvSEGnZ2CQIQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6/7] accel/ivpu: Fix locking order in ivpu_job_submit
Date: Thu,  8 May 2025 12:18:38 -0400
Message-Id: <20250507121354-21a765b6e0c6c4fe@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505103334.79027-7-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: ab680dc6c78aa035e944ecc8c48a1caab9f39924

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  ab680dc6c78aa < -:  ------------- accel/ivpu: Fix locking order in ivpu_job_submit
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

