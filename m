Return-Path: <stable+bounces-114319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE44A2D0F0
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD46188F609
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ABA1C5F1D;
	Fri,  7 Feb 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Xb/Zov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A381AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968647; cv=none; b=eGF1SmC0k0CmgsY/hzSl6A80MscOeg/vG358iFbek6oYSN/ga+uW4kAO1vIxY+X/dbaESOOPFjrLMff2jFXKfbdbuTZUymWzO9iyb7DxqA/feBMU0sGTIFA4iKHXhKFo77TFYqiv1L7N7/CFJ3BvmNzojXjcVdR4G03KEf3AO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968647; c=relaxed/simple;
	bh=abKjSA7mNQe8Tamd4titQcNGQ06pptiNNZWJVrBXzxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BsBx/c7za3DrylhSJq2ac3WehgFanZB1J3WLP3/6Zsa+LYQn4MNEer9uheisQZtYK2L7Vc5sXhT7ZYnlp04VxhT9FdYNXuXFue3W8Un6TonSd85qviSZBQRx1bzEvoBoYtRjFQ5yqFCaQCr+1uyd53TqDCIbDLxWXTfFK0s1oWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Xb/Zov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29877C4CED1;
	Fri,  7 Feb 2025 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968646;
	bh=abKjSA7mNQe8Tamd4titQcNGQ06pptiNNZWJVrBXzxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8Xb/Zovr4iHeoNQj3cdJPLmJdyw9Me5R8xclO261gTkE0Pwxgwzqd+RpP29bYt8m
	 340ut0TuaO9bZsxq3bK32L5YiOgIIH+FakVBqJP7yco0ZjpZzZtPKN6CdVfXoCPYpU
	 LPxeoQA/sIbWAVt1V3plzqkYMsldsHPFMfAhGsJCTiYNhLAmay094RbL1UAagztdqt
	 j+2znGN+s/VBmfirECy1NJBh2QmE45aN87J+IXPTdXCHudqFfHyjjnIh1bEHhftiL2
	 pOb19eZI6bGwlbrXX+VbMxyfoBlA3y3chAOKu1X5pWJlD9nQ1Y/gAber3ov/oRiiJI
	 1FirCyx92zbGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: vgiraud.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Fri,  7 Feb 2025 17:50:44 -0500
Message-Id: <20250207162100-e89711bfcf43067a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250207113703.2444446-1-vgiraud.opensource@witekio.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 985b67cd86392310d9e9326de941c=
22fc9340eec

WARNING: Author mismatch between patch and upstream commit:
Backport author: vgiraud.opensource@witekio.com
Commit author: Lizhi Xu<lizhi.xu@windriver.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  985b67cd86392 < -:  ------------- ext4: filesystems without casefold fe=
ature cannot be mounted with siphash
-:  ------------- > 1:  e8a78ebe11154 ext4: filesystems without casefold fe=
ature cannot be mounted with siphash
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.6.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

