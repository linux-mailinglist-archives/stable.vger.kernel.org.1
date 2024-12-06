Return-Path: <stable+bounces-100001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59879E7C47
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A504C28281F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FF5212FA1;
	Fri,  6 Dec 2024 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sfz9Zltj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F2C1C3F34
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526710; cv=none; b=hqUrJSjly4R4GVqi2ahKU8AiDIA5ORXgeyv5QOlyUNjlB5ad9cSsXBCPy3OFF5cQiMReoWPXfmQea//UBz1vKTBJwt5BPf2zVPO8LO0ClGMGOG7qUqILVF2b46LEJwa+pXflyl68/KZF2iFtIJpnWSwxVVLwvgo2KEHjhEeXmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526710; c=relaxed/simple;
	bh=xCjcGgxCDz+2Zg3Qo7oUPKWaSNsNvEHk37sGf/HXE2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ado+zVmZknQ9B0Vf9bfT2uT0V6DvsnvXaHGrTH06+Ug9FAQJw5u/0dxHvBlOP0oIm8zCRzirHj7NWYRUtlC3eZLAdI5cDQQfq61q267n9mrOjA04+m32N8+W0y0/ZrAD7fk99LoVt7C8r4VN250J84sAvWTINMEG3I+WM5PI2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sfz9Zltj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083FEC4CED1;
	Fri,  6 Dec 2024 23:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733526709;
	bh=xCjcGgxCDz+2Zg3Qo7oUPKWaSNsNvEHk37sGf/HXE2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sfz9Zltjtsas//ELtedkCwRkWN15WxBeG24jBaJajDDEyaBCiNMX4x9d9iwlJFMWP
	 IFmiam5YCIVGgpBohrAQ4tAxY9pTxs+sPps9BFad8oWGHKGDniWVWr2fTyzCnQSWZJ
	 VYaq027GPmpvBq808brqirC2bJe794n8r7B/RZVSuWeTEkOC6Az41yhAuVWfUJbIe4
	 EZakfAeT4uT05YO8HjGCaGsG+Nt5yOVO8ofdfeFQk8XP/wsoTWfuWwKDOSaq4FCU+O
	 L8sVwrAHpk2F/UlmMZbhcZ8r6ISoB8iHOvgKzubBvWlk5tUtG13bpup/reXm1b3nJF
	 ftPbGt33aehgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1 2/3] bpf: Fix dev's rx stats for bpf_redirect_peer traffic
Date: Fri,  6 Dec 2024 18:11:47 -0500
Message-ID: <20241206131011-30524061c58273be@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206153403.273068-2-daniel@iogearbox.net>
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

The upstream commit SHA1 provided is correct: 024ee930cb3c9ae49e4266aee89cfde0ebb407e1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Daniel Borkmann <daniel@iogearbox.net>
Commit author: Peilin Ye <peilin.ye@bytedance.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 959f301635dc)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

