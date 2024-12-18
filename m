Return-Path: <stable+bounces-105092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D779F5C33
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 02:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98691623F4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C758635947;
	Wed, 18 Dec 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxuX7HU3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843711EA80
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734485010; cv=none; b=XgZ/2U4A38lglgJQoK1XLnhl266aOlt+Bijrm0fJRMDvZv2xHt4+R3XFKYcT/eSGtUJ6tY7EfllcLl6kHx2x68xbZvj0sDSFe0RgwqmlrHci4HtsNa+SuHq+KnEl0WSXjOMwHo/PWNtPWyM9x/FtrhgX25LTNKzyT7rJ/pVgRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734485010; c=relaxed/simple;
	bh=hOLbkSHmRzKIW0m1RNWAJdeE7W04znxxUnOu0JYowTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKBpgvr7eqdjEiH5DyI9iJDalqXafMqWQIHeN3zfEdXDKF+XHkoeDcIdzRQ8qez8k5ZjzjAb8vXh7n6hUYfAIZTxPHNxhp9rqt+6DedhSHEd3EOLA0ZbPWMC1MVT+wDIG7GTtMqUzY6ORpMokJct+wvZtM8FpdHivoPm39aca3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxuX7HU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EF9C4CED3;
	Wed, 18 Dec 2024 01:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734485009;
	bh=hOLbkSHmRzKIW0m1RNWAJdeE7W04znxxUnOu0JYowTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxuX7HU3Nk1BfcYaUup11GQfOF11jFMVlbSb+CTgL/uDkRzDKFNe+K5oSMCuEfUZ0
	 ziV5UddHerRZyAi8GQOn+n/tq1oUkyH9ENf1Gj0hL0PG03QF7pi5UDJ2rUlK8FtyHw
	 Rggx5sNI/tXUyNyZ1d4VzagoMGBW6hot+x+tbjN5VPKKrLO5bZOARqa1QGIudtDdf5
	 XC8E15MasKmyuSb0U1C/mDu4iX5zutHVRFPWcgwsbzEMw9HGa69KE2q2KU7dKR1/iC
	 p1CBjmi27zb7T2/Q1FNzYJ74bO5RSfClt9ZvPWnWugaw9Q2baae0YIw6XD4+Jon6dR
	 yE43tnJplFd7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] drm/i915: Fix memory leak by correcting cache object name in error handler
Date: Tue, 17 Dec 2024 20:23:27 -0500
Message-Id: <20241217201222-6ed3b88d01db7f28@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217210051.36137-1-jiashengjiangcool@gmail.com>
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

Found matching upstream commit: 2828e5808bcd5aae7fdcd169cac1efa2701fa2dd

WARNING: Author mismatch between patch and found commit:
Backport author: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Commit author: Jiasheng Jiang <jiashengjiangcool@outlook.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: b91167d74a0d)
6.6.y | Present (different SHA1: 5cc1c29d5d4e)
6.1.y | Present (different SHA1: 386978fcf9c9)
5.15.y | Present (different SHA1: 5ff57824c3d2)
5.10.y | Present (different SHA1: 4e02296a6d82)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2828e5808bcd < -:  ------------ drm/i915: Fix memory leak by correcting cache object name in error handler
-:  ------------ > 1:  54eb00b9f2f8 drm/i915: Fix memory leak by correcting cache object name in error handler
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

