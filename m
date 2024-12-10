Return-Path: <stable+bounces-100481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5332A9EBA19
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3802283C2C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E325214237;
	Tue, 10 Dec 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/BxJOq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EB214227
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858711; cv=none; b=OnqQme/JVep85T8AN48rg/41CHJkmWDPBDNT8ooeIVUmlngDzsO8ljwlP4ZSy2huaqrVhiacRbEG7jgafhEAGnOisPFj5IR5kuCD9jEt31JfjABTjEzWf7+3a0xY2nVEkeG+wsvknJwkS8R2WzDRYYY7k1v7fPUxbmCQitDnL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858711; c=relaxed/simple;
	bh=BqOkU8QY2B/dU+T8UdgZNLAKtmo/AKl2IaImVZpbwG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thPGyFiVms2UQiRlxuqCnk+4SZbn/ydla8/KFPFw6RQsQ/OSybVcYW0r3f3gtZn1FkvlcI87lGoSF7aSCpmw2ulGSOFa0ib5qbfCNR1xkVUwZAYGeeEdsXQgGzvUVdj0p6KAwkpDBa/ehWkn1h0R5vffgOYm1z4yrQ+3ZqbmFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/BxJOq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379ADC4CED6;
	Tue, 10 Dec 2024 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858710;
	bh=BqOkU8QY2B/dU+T8UdgZNLAKtmo/AKl2IaImVZpbwG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/BxJOq8pDcyX5r66Xt23lk3pLacIj8zniriVBJGhyIDOTjz9AUFPooHjK+HWIS5A
	 czZvJxtYNxdYrZbbBAEuPjrmSbCD25+dFa50X0VdRWnPwxZX5L1HgPGFcCWJULWCIF
	 jDPPSqwOHp7xPy+WflNOlGD7s8a6idnTTJTZKr2DMvLLq+4MsgtXM9qsW4zBWa8EBr
	 J9YpR3KW6KCIVRgX7+4rZy/alyGcFN5c0U9vjaWIvd40aqqytqlsh+xr5n7Skt5eAS
	 Rug6ddX2o9DvYtlslShBcIwO9jx7VpwD74aHSGiXAj6s2PHQVUzY9nhE+kQGIF1fsQ
	 6S8SwQ+RYRGmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2] net: dsa: microchip: correct KSZ8795 static MAC table access
Date: Tue, 10 Dec 2024 14:25:08 -0500
Message-ID: <20241210135618-f16800a30a827b76@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <8d4be70022292e9db1980a2527c2e5d927643f42.1733849214.git.joerg@jo-so.de>
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

Found matching upstream commit: 4bdf79d686b49ac49373b36466acfb93972c7d7c

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
Commit author: Tristram Ha <Tristram.Ha@microchip.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

