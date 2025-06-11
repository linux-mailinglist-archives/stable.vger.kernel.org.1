Return-Path: <stable+bounces-152436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A90AD5780
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D608318984F3
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81BD23BD1B;
	Wed, 11 Jun 2025 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CziRc8ci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B7A242930
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649732; cv=none; b=Q7iLv3oCeCiCQGrSlXtuLG9kCtH9UXVTDgdycmUcr7/1SONxkGp87z24hEfdtwDWPuX/MGYMOEiU1jkhW2ORNd1ayv8tpX5raTe+Tj0itZIBaPyAJHZywSAEq6S15GAOIt8WGPhDpyIZfzmNwuApfGIckINQEtonydmyq1XF31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649732; c=relaxed/simple;
	bh=a8j0XAeSD5mkXoCCa+APbpwHm8Ow0m4zCwyvlDrI168=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVDegDbsP3bEm/4X+2vOTm8QAb2RRK7oGkWjlgMynH+W05u+CyZEqSmSp0n6a2D9sqgoZ2exz0ACbgsdknjdnZT0xVrF0RPM38Jh8d/lxU8mHOgyi1KNiu7e0AyodEVg6y0um+3hMvUW/5zuTnl/SHTVqgWe0GYT5E1TQHCr3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CziRc8ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E9DC4CEE3;
	Wed, 11 Jun 2025 13:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649732;
	bh=a8j0XAeSD5mkXoCCa+APbpwHm8Ow0m4zCwyvlDrI168=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CziRc8ci1TMj3mF22ZRZbAKfhoS1wIkJCsxdMGLAs7WA6/BdWQGskb8Shi8eGtio8
	 S1BhT513CcUQ4crtto02s5yBjZfTUNObetOGOKDiWwwDspqTHkskTolY+I1N83pXs9
	 3bU+oWQijni4v8vXdIC4CPm4oW1pb+tAegUGkcOQFA4yPQkp81XGG72lsUeI6gxH3n
	 VErrA4UjMlaJsCoDmKdRyPiBT8O+OfQcAIB9t9eBr5h20cYexxGSTqtjqrXxrJHSXN
	 q5O+GwZyMkIQE0uz3UcHZbkWR+iyXIpw2wokMYKrUHP5tM8Ss7t6L9mZhdlHWgWzft
	 gWkyTQCX3DcAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Larry Bassel <larry.bassel@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create
Date: Wed, 11 Jun 2025 09:48:50 -0400
Message-Id: <20250610151937-c2a2eed5a50219d5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250609234832.2950719-1-larry.bassel@oracle.com>
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

The upstream commit SHA1 provided is correct: a9c10b5b3b67b3750a10c8b089b2e05f5e176e33

WARNING: Author mismatch between patch and upstream commit:
Backport author: Larry Bassel<larry.bassel@oracle.com>
Commit author: Dan Aloni<dan.aloni@vastdata.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 9921c866dc36)
5.10.y | Present (different SHA1: 1e7433fb95cc)

Note: The patch differs from the upstream commit:
---
1:  a9c10b5b3b67b < -:  ------------- xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create
-:  ------------- > 1:  119bab0681b20 xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

