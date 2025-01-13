Return-Path: <stable+bounces-108543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB925A0C534
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44413A7A83
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816571FA147;
	Mon, 13 Jan 2025 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THFJFrjW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E11CACF6
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809751; cv=none; b=hs+w26GMka9Dnl6flbnub37TD5EA/J1QGkeiHtAJJ31GHyMmIeDAHwvOkScwnrWrxULSxfO+fgY4TgL5BIuOuUJXSkbhUNDWq5zRe9LHEUQ9VcSGWAuzOjx5+jKXMfK9UBVPW7nBF2GlSxrI7JkcxQMF4D0iopYtkoI7Y1FuWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809751; c=relaxed/simple;
	bh=ZSg45hhosZdi7agWOebolwfjwvNtpZN7kpI6xX83i6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/OOVmbwZk1ttzpzHrnV4ZlnlhCpL1l379MmABecX1oFIrvgN8zyFyF/gg1aSJ9wgdjPTuSfUw0IPkitaiMHmZhKumchWWoQNOZcajSvs78uTEPNC2HYSnRkic04HyQRcFpJGQLZY1iw//h4IiM1qtrJR/e6h0ZxwXq0h1uQ5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THFJFrjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C75AC4CEE2;
	Mon, 13 Jan 2025 23:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809751;
	bh=ZSg45hhosZdi7agWOebolwfjwvNtpZN7kpI6xX83i6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THFJFrjWRnOumwHsXTPbxn4O0qRUt5SKWECypLG5Ml9j8jqsMJPfAyiKcWlyLQ7Ms
	 Bi/7FEUlTg1BlEXzLf4oNVzWIfwBmiODyxQy2ZfysUJkh+KxO18Ra8xqTP9awV8NHd
	 KQmvFszTCCBMS/wqpcpyxJu/d1Ffbq2MUm2z1eMgZCgd+3Aoh2bA0lhIbO+4xghpsA
	 w5sOY9pDUaCiwQeHkjM5i0Vcc8wxGAVW8GzuigJffpbxF9BryESw7gTE28PyBnh/GN
	 zHEJLPIOiwsGyVKe4tGUh/3RzQg4RmO9UdRuNGwhm6/xMRrW0JjbAFe8/WWH/lppTx
	 8NNFxlW8yjjnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
Date: Mon, 13 Jan 2025 18:09:09 -0500
Message-Id: <20250113162946-e89b4dfce4f5603f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113152746.728135-1-inv.git-commit@tdk.com>
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

Found matching upstream commit: 65a60a590142c54a3f3be11ff162db2d5b0e1e06

WARNING: Author mismatch between patch and found commit:
Backport author: inv.git-commit@tdk.com
Commit author: Jean-Baptiste Maneyrol<jean-baptiste.maneyrol@tdk.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 7982d8f24a9b)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  65a60a590142 < -:  ------------ iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
-:  ------------ > 1:  27f366f362c9 iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

