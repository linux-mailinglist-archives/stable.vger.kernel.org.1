Return-Path: <stable+bounces-144430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E78DAB768B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5914C75EE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2751295503;
	Wed, 14 May 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krPsGE77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312A1F866B
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253633; cv=none; b=PBCEjMc2TepxAjgvAIZVGAS3LSlsKJX4GuSFixUpo7BNVqWHCQhjnTww1Hl28jCGOjhiBvNS8q7gfL7E6Hp0hkq8A1srcn3NeFb1ATAZ4QIBggJpXm2o/bFoGW+QlHAprQ3pz3QW+Kq4Eq7FmeyS+iYeSGkO0w5X1Y4t6ccwBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253633; c=relaxed/simple;
	bh=6dXHNA673Ywuk9zqxPpBMFKAeKlztD0G+PPMUTpwQmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQ23BiYYcm6QexIpFhXh1Eg+3pteLUiVTakXpL0ZfYnxOTK/vSlau07d4nh1pHiZ8/Ur1daPES0YhQpboBfuE6gSnD7QLK/K5nCkqCl2E2oywh6yroxH/ysVqXo1Y4DKEOOcIYWJJYPS/RGF2pQOJ/x8rRcg01gbYeYKmFy/w0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krPsGE77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECF5C4CEE3;
	Wed, 14 May 2025 20:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253633;
	bh=6dXHNA673Ywuk9zqxPpBMFKAeKlztD0G+PPMUTpwQmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krPsGE77lhmZVJoT1ntxpqGAtOF6i3XFwyMn6Cv0feGopQ3C+9Vb751N4JxI4Cxa+
	 b0Hq+jv6EkfFHpLtgcxWuAbJC+4lF1025JW7KLagPscEum52GilJiT7Yv3KITuVqE5
	 luHKWwIaU8QiytmFXqSvSZs/0EP0t1495e3KY+dfF9K2K0OCRlfnqyv87rq0a736BT
	 6cU3HFwLJ8NDL1g8zTMKoqHf3KifCVmBE4Gl4SnvUjpRDLsPGTypmgg4X8+wO7XKdA
	 ZWDMR4qDM16mCcWOanvZKC/Zkz9ENYgDY4Kln2sZqREnoyK3iLqEAvrDJZSe5BgIeQ
	 MgMmehKWaIacw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14] x86/its: Fix build errors when CONFIG_MODULES=n
Date: Wed, 14 May 2025 16:13:49 -0400
Message-Id: <20250514102325-42e0d05b3bf8ddc5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-fixes-6-14-v1-1-4c9a36e80c78@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Eric Biggers<ebiggers@google.com>

Note: The patch differs from the upstream commit:
---
1:  9f35e33144ae5 < -:  ------------- x86/its: Fix build errors when CONFIG_MODULES=n
-:  ------------- > 1:  e2d3e1fdb5301 Linux 6.14.6
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

