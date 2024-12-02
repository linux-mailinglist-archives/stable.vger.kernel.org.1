Return-Path: <stable+bounces-96127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494ED9E0B56
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 450C4B465AF
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB11D959E;
	Mon,  2 Dec 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9izgWYo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4413C8E8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158630; cv=none; b=EV+1kVg9VYGIqqKFDP8FAilTVebisGGMR07O14qKKG9bmzoXJoOAWN6+i6wDfdJjdCItXXjAIeypbhs3svAuIosTO8yrxaX5aBlKT8gYTjMgDnKtBiEfLzOn80JjO3ctG+LIQD9HJLFEdAEIh7SDmt628RDzZjYuY+4icZrkeBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158630; c=relaxed/simple;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuVw6F9m8H8OhuFlC3qhesp2xM9j9vvQ1+YP0TiqsuGio9QK0H2dqEgbODZeeVJRgQqbE2uEdA/K1gFbRbQmr9/Ebxbl/n0IUw+ubn/W9Vb58Y15kGBmDIBXPrdsEXJieLlY8e/j31zqOsNL7NQyltj7KytXyleb5/DJsqaqQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9izgWYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7C5C4CED1;
	Mon,  2 Dec 2024 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158628;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9izgWYon4T5SOK9Mb16XGR6Wd+laTjz5M5mI/Wof49mwB99x3AxI2xBJVhxccylk
	 phBRIz+u2AO+qztI9gaMU+uv7HttjIPVKSO0ERFI2Gwf2PggW++9ttETW016aRn+qX
	 X8hG7ekz6TlPdTh88qP+np0gzpRWQ8B5iniJVk7foo8gp4YMzJY69LfjP4K8GocZw1
	 7x623IsceLnPa6vXUyik45KDuJH+Tb2FXtQjEPIkoRJ2jgEh3BxqCGwXCXLqxFu/ln
	 J8gx6r5vW5dfYklxAgzDeIVi+XiPZ/PARyuBCq7N+9fKnkCEHhXZXJtL7IDTFM6aw6
	 zoZp9NZn6ETFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v2 3/3] net: fec: make PPS channel configurable
Date: Mon,  2 Dec 2024 11:57:06 -0500
Message-ID: <20241202114303-4545938812b5e611@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202131025.3465318-4-csokas.bence@prolan.hu>
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

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

