Return-Path: <stable+bounces-132351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E9A872AF
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8AB16D698
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8514A0A8;
	Sun, 13 Apr 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geFXR23o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36C1DD9AB
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562827; cv=none; b=RzrElW/y7hWucP5OqL/NCD3nKTqVbvGgqXpxd164RG4+/CoeqeyZt0jDMPpVDGJ9mRhOwG4tpCOpdjxjDtF6PbD+aBHyUm2/WE1c9EMVJI/wZeNnSoqT3doDtdhiAzJal7Hymx2oaYs4WA9blnwGZCdg+oZHQpjFYjBqK9uIviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562827; c=relaxed/simple;
	bh=D71yNlD/gyab1l9zgH3iDzrDfOy2jD1Oz2qWKoko+U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFIkojTCGu37IefDXUi5UU13G6rr1WkAwrIyc4VsrQbacpabETQ+lfHrBd1thRy69ZR3tMjDf9stMonZZPiX6V6iL+5EjA5j+NsVWAkJTefShsVyazjXCkxv0D8HKh0rkflLsGkTUYdXHrsnHEstmHaWIXIPc1sK8LlpVNOjpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geFXR23o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3708CC4CEDD;
	Sun, 13 Apr 2025 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562826;
	bh=D71yNlD/gyab1l9zgH3iDzrDfOy2jD1Oz2qWKoko+U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=geFXR23opVWCpKchWMfbUcfw5pyZZVdGA4xqdoOTE7wR/kG3Yn6BBrj5bzWVEiiCk
	 UTMn9eBSsBLZKRxVbr8Ku7kEDW6NdHJLq4l4PhmGS1j9xbTkvrydg29x+E03QVzf2J
	 hqmF2i4InJsKyn7YxNRmSC6WE5WDi9rYMbWxVCCsVxGLovCYZLLR6yqIj2hrH3S3Mh
	 s8Qw5gjV7PJtB5yHX4kP7kzj9CO79iOVNPaEvbHa8K5PCjONs3DfkMiub6EaQ1xHmi
	 X5gkZS1MhwVPTq3TCnPh1oukGFyslR7+k7y1Toqvn4O8NOnDe4X1q58vIr6WtSf+wq
	 IgnxGurnAmf1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] x86/xen: move xen_reserve_extra_memory()
Date: Sun, 13 Apr 2025 12:47:04 -0400
Message-Id: <20250412122501-c369a62fdc5c5069@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411165122.18587-2-jason.andryuk@amd.com>
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

The upstream commit SHA1 provided is correct: fc05ea89c9ab45e70cb73e70bc0b9cdd403e0ee1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jason Andryuk<jason.andryuk@amd.com>
Commit author: Roger Pau Monne<roger.pau@citrix.com>

Note: The patch differs from the upstream commit:
---
1:  fc05ea89c9ab4 < -:  ------------- x86/xen: move xen_reserve_extra_memory()
-:  ------------- > 1:  9bc5c94e278f7 Linux 6.14.2
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

