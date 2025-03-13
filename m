Return-Path: <stable+bounces-124241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE20A5EF17
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F517DC02
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C5326562A;
	Thu, 13 Mar 2025 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfzx64gg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B49E26561E
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856915; cv=none; b=YxyuZkQ7gbeQqp9kjiA8bgoVyk2uyGhY5sQBcyVyDcOzcrwcYxO/UlJOzYZ0l6t46kJ0Trk4+YJWUpLO6nb8C2hjyV6isFNuEXrKAH3xPABhxlf0Dp/EU03LnOiung0jW7NcOTwd5jswruDdjcKDcojwi63HDyx40Qt45GngVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856915; c=relaxed/simple;
	bh=YuMHYa2CkfLCUuQ4Q4QHObthxws3RSWHIHwVgKb32DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlaPChnIzgmmR8gQfzbDqnRjexWik1JbVZW789mfSW3lSzItauLB4KLJjrt9JkVAjEiJh+km2M2+B2cMMSqFjKgrsgiYU/fPC4xkWlMcazOu1/IgOR6EN2h0ykMfvFuAtxc9eRwcr9BeEEdjoaFe8NL5+6ssBiDO3/mWLd70PU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfzx64gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B278C4CEF5;
	Thu, 13 Mar 2025 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856914;
	bh=YuMHYa2CkfLCUuQ4Q4QHObthxws3RSWHIHwVgKb32DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jfzx64ggUL1PP9p8wSfKsw7mRUDTx5QogWlwwpnmW8SxDBK8vsb+ho0agQ0nhjOoy
	 0K/vya0BeBindDyErYnPcY+XYDfE4BCOoJKy8Gz+aFRXfNUEQCqPr+9JRcwDDQAPkO
	 Db9AXdv/2U3chkEgSDkvmdhAjbZykt18wSbBLjBl/OMP8Bq8bJdrT9TcV2mB0hHjZq
	 MH1ZoJik8iquih4GUkuQ9sbKL0SEQ8ZkQkj3W1Vg4hjXMlk6JPqqutOekqDzq6nTkz
	 ItyO//snkl0UoSfvSQScV4Jc5d5SQaC9lYFtAFmv+blLY6eISzdXy561I4BPI7QiT1
	 9hjxEwA0zB15Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RFC 5.15] smb: client: fix potential UAF in cifs_stats_proc_write()
Date: Thu, 13 Mar 2025 05:08:33 -0400
Message-Id: <20250312232106-6b48ce51979f992a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250310014114.3430531-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: d3da25c5ac84430f89875ca7485a3828150a7e0a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: cf03020c56d3)
6.1.y | Present (different SHA1: 8fefd166fcb3)

Note: The patch differs from the upstream commit:
---
1:  d3da25c5ac844 < -:  ------------- smb: client: fix potential UAF in cifs_stats_proc_write()
-:  ------------- > 1:  b543f15d675d5 smb: client: fix potential UAF in cifs_stats_proc_write()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

