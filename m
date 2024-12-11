Return-Path: <stable+bounces-100645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FAD9ED1D6
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0891883E63
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC65B1B6CF3;
	Wed, 11 Dec 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVNIg0/O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF2A38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934730; cv=none; b=aac7NukI0TJaK8c5MHD6euSbgJCzfgJEx7vJmQXNOQeaaidGf/LM+nQ+veOuzNen/cKS6h4Pk9eznhXgUpEyNX9T2l0yUIkUOi5hSGk8c7ydLfqNLdaHgtCU40jo09xRa4O1jz6ith5ZJXV1ayBUbK5MI1XwYGT5iCDVs4oZY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934730; c=relaxed/simple;
	bh=JCrePnPcVB6fqY1DGnc/iZL/X+UeqzZFuMUS+VwKTKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikVJNADYl1UJrPmoTYIicGiWO+E+Zp8xuPEz2bSCgXxU8D6srN8vSJuAZ5xrT4z5ebgIXzebQTgZmBPM0ZnZBd1/uGz+yGufxTcVShcGucGj5qB0tw0O86+JEhRXmPdWwNXnt6bJOFpLuGlUnyFMpiMnNo/FKyhyzG9oTy+cUG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVNIg0/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3324C4CEDD;
	Wed, 11 Dec 2024 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934730;
	bh=JCrePnPcVB6fqY1DGnc/iZL/X+UeqzZFuMUS+VwKTKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVNIg0/OMYraHc4TnPeg4K0Qs6XyQ3wKYnGCt6M6hU67lME16p35s2nTG/vDU0WL4
	 8WG8EmQcC9BD2hFHQQ4tMxswd+/wFwRJeUDFtpPI/F+Mc0dMXLs08z2jCyn9ZKXXnn
	 chdKZAMTrbv6XC0BAFANqX7gHsCLkg+NnNCh2YAJzBBiQqYeHijj0Z6w1exOikJ3CG
	 3ZGCAM5sjFBVxO7PX8qxg1f04WWoS5TIkEMnL4EVxjlXN1+v+2nwQVrszWrYaz1HPO
	 ieOkTHooaopPeCM7S+87AH7GEQOK5cBhwnTWya3/tyrGRaNU59JqZRoONYPvQSv9F0
	 dRmJR8huxh1FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Wang <hui.wang@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [stable-kernel][5.15.y][PATCH 2/5] serial: sc16is7xx: remove wasteful static buffer in sc16is7xx_regmap_name()
Date: Wed, 11 Dec 2024 11:32:08 -0500
Message-ID: <20241211105858-996b0ad7850e1a1f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211042545.202482-3-hui.wang@canonical.com>
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

The upstream commit SHA1 provided is correct: 6bcab3c8acc88e265c570dea969fd04f137c8a4c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hui Wang <hui.wang@canonical.com>
Commit author: Hugo Villeneuve <hvilleneuve@dimonoff.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: f769407d0194)
6.1.y | Present (different SHA1: 9bcb019aee47)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

