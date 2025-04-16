Return-Path: <stable+bounces-132868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE081A9068B
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285C03B86CC
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7A1C68A6;
	Wed, 16 Apr 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtZQM7pE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284B1FA14E
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813698; cv=none; b=X08VNjazhS+dW5ZfRm0Afx8e8oXRCXbGar3ellQYFTKdCFpzYlmA91YCzFEYCVWWgA+ZfYkY7I+Lv+HtwaWjxxDWb51Ic4a7i77FKNkyGB8mbYS/ZzzGD0B5G0UpC+/TE3DtJeB+hj6XnGh/gAlGhGAsLnI0zp/0pFMIVas/Gro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813698; c=relaxed/simple;
	bh=H0+dV8sGLqh7CQftQLq6pszWsHvUILMEExASxSZhby0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhXCacDl43e6zOE1G6E0UNqbJbai1l3+T2zXJybZ0PKybnzLZa9kRvrjCrMHQU+ixyXe7nJTJmNF2P+mJfWkoHyfvsXC13hHFkMb+E+8gIukJpNzUXyuRt3MEFFcbqRUFoO/L0O2r5XtME8fT7QMcZo4cH+cAp1Hh2stT/8OJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtZQM7pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9181C4CEEE;
	Wed, 16 Apr 2025 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813698;
	bh=H0+dV8sGLqh7CQftQLq6pszWsHvUILMEExASxSZhby0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtZQM7pEn0aeVI+KPWaI05ZnDHbBaXTwaPRl5Ice1TN5XdNPOb4cfItsP+z6v5fiJ
	 2jDY+4m2A9xlL2dLXbKdsp7WtqwQSsnditZwa0Nf2zyz2ceZCxINU1HjPoAVCssGi0
	 X9ruRmTHzcWm1tWQ2zVix+ulMJksFgCcS1dnds36uLjfO1gEGSwboZ3i4WY9l+Yiub
	 A4d2a/PCnvv1qk7QKgWyQKmeLOsN+AS6tOyR4etUYZu+rNMLAbtLBLpR0oczJvbe8M
	 7Tx8i/xp43V5oNrdKk6bjvNGta+hQI6ZmK7FMbMdkCs0JdhmafWWKDpwJe4HR1dc4x
	 gXk2920NG0hYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()
Date: Wed, 16 Apr 2025 10:28:16 -0400
Message-Id: <20250416100037-9eb7a4bfdae2896a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416010839.388428-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 4e8771a3666c8f216eefd6bd2fd50121c6c437db

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: ChenXiaoSong<chenxiaosong@kylinos.cn>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 07f384c5be1f)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4e8771a3666c8 < -:  ------------- smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()
-:  ------------- > 1:  1039ccd22f9f2 smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

