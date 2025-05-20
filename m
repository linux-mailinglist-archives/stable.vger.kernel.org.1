Return-Path: <stable+bounces-145017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB3ABD0ED
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C08B1BA1572
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383F20E6E2;
	Tue, 20 May 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMBk/np0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B161DF75A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727539; cv=none; b=eC/nEkfCSd+huwVlAkAuAtQiN49nDJS/g8u4q8pvWKv0OiZyi5aDhVm+v8lXMoFPyCltZl60iQypgLZlA2CfnmxXK54N/aWUtVrIKwygfuZc4s7wmyIBQXME4B94ZtWcGLqrBd1iPd4yWPWHAIJ2wH/HAZp1Dfwo3zpXgwmqe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727539; c=relaxed/simple;
	bh=AmE+T4p5oHNal/YXv5k136XOKOS0mFIUyHWHGzldaKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfer3OMwS74LUMJ1ZoZ3uckcdunyvO/lIcpzpMXXIolBh44VIwFkcj9zSIgrBMDl1btYTkrSm0UMNopnX+b/rZG/VJsY62mhmP3GYuwldVtXcLYBLoQ5bwj0lTyFGVacAwi2kQbCUG6x2DXEUWp4DpvZILQmI3N26s+TC7DmKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMBk/np0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A46C4CEE9;
	Tue, 20 May 2025 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747727538;
	bh=AmE+T4p5oHNal/YXv5k136XOKOS0mFIUyHWHGzldaKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMBk/np0Q3SiDVeqdoJD0aVXbwwRNq3g3rWs/HuvRGaerOxGmYb6rQ5+H6d+gxwVz
	 5tRjMRzrSHj1m+5jklfAWsTnoVxgSIc1C6u9V6C4W4Mx3teQrCZhISrkDwOUfslmDU
	 lE3Ny0ikqu6yy96mhFSTaDLHlwc4ZgSYmi/pr4AYv9Ral8V7JIksQ9h9COgWrZbRp9
	 cSpnKl7nQ0dxlfUPUd9JY+0pNpOaBpX1XjEc6ng3I3odOri5oafATDLWTuDJdhWtDj
	 a7YFykrpUot+E6kgIyQIQaL3nfUAyOCYwpU4l38k4m9HO9nhBZvEP0TDjXs7O0B58I
	 wyaAqkTpNqMXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] powerpc/pseries: Fix scv instruction crash with kexec
Date: Tue, 20 May 2025 03:52:16 -0400
Message-Id: <20250519175359-df0230c17d7d5aa6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519012816.3659046-1-Feng.Liu3@windriver.com>
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

The upstream commit SHA1 provided is correct: 21a741eb75f80397e5f7d3739e24d7d75e619011

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Nicholas Piggin<npiggin@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d10e3c39001e)
6.1.y | Present (different SHA1: c550679d6047)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  21a741eb75f80 < -:  ------------- powerpc/pseries: Fix scv instruction crash with kexec
-:  ------------- > 1:  12501a36cead8 powerpc/pseries: Fix scv instruction crash with kexec
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

