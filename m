Return-Path: <stable+bounces-165566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F4EB164B1
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5154B188D797
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECA92DCF46;
	Wed, 30 Jul 2025 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAE8Mo0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405362DEA7B
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892978; cv=none; b=rOa306bZ+deevGUwztJ6CtyvHtfaQAf6D/5VozrNh9II1XEKmbZ857OY326BXAJCCOMI7QgvgKTw28qxNdsZ7A+ROnYzr3jBh1ENO1PmZy3UIiw2PfOQGaLQY9FtQvDJ6BQqgT4aRFJjBd9/NrhJje3I2WzTea5mI7ozHRSXM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892978; c=relaxed/simple;
	bh=bFpY4Xcbg1+P6h71iP5kEzuDvomGFZbBEnVTieaqeFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8zXkJU352AByGpx05Ndr33HqWUIbbGm3BzV7u+i8eOGxIJaAvDr/qn/+m/xp85niNmPduXPg79SmynTCamzjfWT/uxAjHWo9H75E2XBMJtW8UMsBfhUpi1VFUQlRirbTn90xncO6IT8NNY4SFMwC9Q2kWK+A3A2UAcLLilYihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAE8Mo0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E45C4CEE3;
	Wed, 30 Jul 2025 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892977;
	bh=bFpY4Xcbg1+P6h71iP5kEzuDvomGFZbBEnVTieaqeFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAE8Mo0Vp0gSvhQGKnovaGAILpoeVobaUz1d1SJnuTsQeA4VcFmuoSXKqnhI5Dv1j
	 48k9r7uZjnZ9RXHG+sP6wiEKOWE/Pfi2AVTSOQslneUA0IL4Ij7iYFu/PCoeqAHL7M
	 rrc8ChJVzyJ4eAl6lXr9EorifzmpBLL5Szy1CS1JQlsL2+nYybJk1iKXTYYjgE/bBK
	 r5JtpG2PnjvI6AA/5TWjp4j87uHKTfVxDF0j7gdVy5EXziV5tswFUpPSY8G37RcslP
	 vtWqK6Za//jKZ2F/RNPN3SEu6UCl4nvXnck3SoikD+20vxV36onKLAGszON8d11WKR
	 J69tQWgS8oaww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 3/4] mm: reinstate ability to map write-sealed memfd mappings read-only
Date: Wed, 30 Jul 2025 12:29:35 -0400
Message-Id: <1753867269-9809aabb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015152.29758-4-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: 8ec396d05d1b737c87311fb7311f753b02c2a6b1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 464770df4609)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

