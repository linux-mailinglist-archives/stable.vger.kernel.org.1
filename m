Return-Path: <stable+bounces-158597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49614AE85D9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD646A6258
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D4F265606;
	Wed, 25 Jun 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxHHw9O0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03687265288
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860549; cv=none; b=E0oDVEfxIas0XdfzIDKZ7sUurpyyIOAisyOpAp4lvR6dblUpwBr+t0vQacbSoNWkhNd6L+NvzjX3ooEedJCu+rX8g8Qi31YLpNqUBHN6rCh+zhI0fNzVsirDk8Z6LzrvutZKIu37MtQHSFwnVt5wim6WwA6qoOBkFUlDsBM3GHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860549; c=relaxed/simple;
	bh=BnqTa8DaVDGR9ARe79ZnUXrS2LTZ/3LIC+0T6a06geg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fSlGXpDePR4F+gmZ7Mag9HkejrfiB7s+HK69aVq1kbsH2+J+hbwNGu/fzPbKwJnGpbQRTq4/H09KkfFkfDK8tBzUq5ibI65XWgoIUdqhos/U5VU2WR55AOmkyereCh8wMHzLbJJhgntfqqONiLm7xJT6vXrUxXz4ZU9KA6iH168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxHHw9O0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58CAC4CEEB;
	Wed, 25 Jun 2025 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860548;
	bh=BnqTa8DaVDGR9ARe79ZnUXrS2LTZ/3LIC+0T6a06geg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxHHw9O0yTe8lVRtZ7GZMyMvB9xlFFzunAEEuR9bZqmHkQllKb2QWXeBbGeP1wOnr
	 VPXDv82VnqGPQKRWFxdXXKodLPk+CNBzZ+WTil4hg7ZSv/pkW6zxjPrRZzE5XTEqVu
	 8eoRKXHRJuU/54pe7cQAh7sUR5LZw2XOhBRr7bbyt6uCzNJqzY3lSYbSkKI9j3Vf0M
	 kDYLO2O3AQ+0p31FiqqRGtcK883n8YHee0TGmTp3xdodt9yfDRXavRoYgXzNo2wS4x
	 WYjUBMey8BI4w2dGDO50z1BBlq8TDKOVN8li2hkUUlegURMSuz2ZYTW5LBEyzNKnqW
	 Ar96h9FXSHniw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Lyakas <alex@zadara.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] btrfs: check delayed refs when we're checking if a ref exists
Date: Wed, 25 Jun 2025 10:09:08 -0400
Message-Id: <20250624203746-71479a2b81409e77@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <1750694311-28848-1-git-send-email-alex@zadara.com>
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

The upstream commit SHA1 provided is correct: 42fac187b5c746227c92d024f1caf33bc1d337e4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alex Lyakas<alex@zadara.com>
Commit author: Josef Bacik<josef@toxicpanda.com>

Note: The patch differs from the upstream commit:
---
1:  42fac187b5c74 < -:  ------------- btrfs: check delayed refs when we're checking if a ref exists
-:  ------------- > 1:  a2b47f77e740a Linux 6.15.3
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

