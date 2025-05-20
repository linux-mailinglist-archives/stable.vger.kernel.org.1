Return-Path: <stable+bounces-145081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4BCABD998
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD99188AEE8
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE362417F8;
	Tue, 20 May 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFcGBqT5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1D1C4609
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748208; cv=none; b=sCjVHgSfYPvO0LBi5on/tQ3LAB3xh49XTb1CQOuSc4CFA/W1TgE+ZTVlM9vF2MSu5mSJXQRXU0EK3i4uXYmVIMzZIW33c9ww0Dc1Qbj+jRugOM6l3fOi0cCGDqEpAd1PkOtvZ+eSYe3x2U0KWzS0qjIMFU4mkTgQn40i1Ni4xM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748208; c=relaxed/simple;
	bh=jCFALPVWAm3vbdfgm3p6rwmwjWgOTPuXzS0HkJgVPA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUtGxmSZ/5yGTpj0x8RUkr77SKfrumSTyz7b5920efjHRSYlWESA4W3K2UgjcPvhxxHJbVvJXgIMy4CLpQt8JS3d0Frg+yWjsr8V7glXXZ8dqDSNTgiP7spzmn3FENZcgtk7N+2J7AdeiWeTJ7Tj33yX6mb/NxwcD861UCO2HKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFcGBqT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EA4C4CEE9;
	Tue, 20 May 2025 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748208;
	bh=jCFALPVWAm3vbdfgm3p6rwmwjWgOTPuXzS0HkJgVPA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFcGBqT5hOHToeg3bCg9CqrsWmsmRdzSpEcK3xeeHztOTS7TF1FmlPZx+54qmOnyt
	 91i6axB7MqOeJ6ts8T5pN6bQAbdU4wljELRsbXG4Fx/MQwgFhUsOYqCW5aWgBTURMq
	 Cj0w+6KcbQGA/kmlyrXS3Sny+vnTz+DkT7Vhs6Y2Vckuw5TzUjVSNoGU6HmYQIrcer
	 1Trw3Myov1FDwpWeWlfC5pT9eL6PeS8htcrbTM4UQ8M25hvW7GQth/rIXR2whUAse6
	 ot06WJsoPTECc3UsWiaUI+YYrkfzHIZKg7aAJaHa5v27MOQyaZaOYpGiqh//rV/4ce
	 ACcq75m1lp5Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] mm/page_alloc: fix race condition in unaccepted memory handling
Date: Tue, 20 May 2025 09:36:46 -0400
Message-Id: <20250520044456-a96f40179bf4ca7a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520080039.679077-1-kirill.shutemov@linux.intel.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: fefc075182275057ce607effaa3daa9e6e3bdc73

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fefc075182275 < -:  ------------- mm/page_alloc: fix race condition in unaccepted memory handling
-:  ------------- > 1:  791f7aab91700 mm/page_alloc: fix race condition in unaccepted memory handling
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

