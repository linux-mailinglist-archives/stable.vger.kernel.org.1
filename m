Return-Path: <stable+bounces-164377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB1B0E9A2
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7776C5AFB
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A961DFE0B;
	Wed, 23 Jul 2025 04:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riZQBSuL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8855464E
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245250; cv=none; b=C3ZEhkX3PvHgwhr+9pGQTf/4zAyD4shBPAg8PS5u9E8p4ihlQ/lQwdup0lePm3npxFgdcQgMUAHt9T+E11IOWeEN6B37wIyWHZfo2djVqB+EY2g3dkITUwd/KmnhWsgBdBbpvnnY29J5w6WKh7KhvGlbumZuZvrrPbLf7EZYtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245250; c=relaxed/simple;
	bh=17FKfyRDSa7GH0Cv/d4bg1PHPpKloSny3EatsRyA3Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVwHfc9QeNgG3Jtln16Q1PeeGGbPBuZgImYfE41i3olk+TmQHUp4PRZnBAml2hNepoEcXRfICaVjnpmEh1wl6f0znDPz5u0tiaxCCtHh3WTQ50XB/yFs5jOUdYQIEhd1iXD+JIlOEo6GeP1VhJpP+L7Q7CZ8ipY8nIXVLOAYe7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riZQBSuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4B7C4CEE7;
	Wed, 23 Jul 2025 04:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245249;
	bh=17FKfyRDSa7GH0Cv/d4bg1PHPpKloSny3EatsRyA3Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=riZQBSuLHL/4tojHhIjwWA0qMtT6k3PEhRORfi9AKlp7l93BV+qdp9g+8WC/CVa+I
	 wZ7mOd4iUoZWjr1stLfJNO4OvwkXA7VFsX8vyD/Olp7tnPOmvHojSQc6bPwF48kGqu
	 GNO7HD649hoIV7A860yLqhTSsQBTisvdX1Km5AhJ3BIif9faN4Xvd91K1rR40sAfYA
	 gI+Ri3jFmKTMD7Rk0a+0LlMPtl7LgCiGKqb0L6DKHYfIUfSnKVCvl9KCp9u6OoAqQm
	 x7KsdNRVgq7eZTfG6az5hx4lTG9Fj+adrJORUcSP/1WyL2HrJxJ129Zfy5qJ/eJU5S
	 lqztp/Yv/EWVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 3/5] erofs: drop z_erofs_page_mark_eio()
Date: Wed, 23 Jul 2025 00:34:06 -0400
Message-Id: <1753229192-582e5253@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722100029.3052177-4-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 9a05c6a8bc26138d34e87b39e6a815603bc2a66c

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

