Return-Path: <stable+bounces-137080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D67AA0C1A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092F3463A16
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344942C2585;
	Tue, 29 Apr 2025 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/N8hj8i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C792701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931036; cv=none; b=XlaS6UMTANWoD+Rb5FZSnqtk8RNjDfzpDRfDJi/2QQyXP/0gtVThDp66RIiTFby6TqOTTtEtu/Ok0byvBE5RCNGfqFiTSJxYnwQXBq5aJkeIpWxLV3uP5OKFSzYrFIXnLIPxg+ByijR4Je9dzbdPtX+gQ++XLDcBuqDItHN6ix4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931036; c=relaxed/simple;
	bh=6P1wO3AzCGo0AMGYYGjlFBNkm5T7RBTlxtV64ogESmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1Tw/yVvukg2Q592sSut5XiXoqdvMhgC4TkOEKA8dWeh844fCzYeskl+yMABzVWxFAhM/h4ctCIP2wuO5znBgvDTPrJ6D7CN14MwR9S+hrmS7avfzCObm49PyVhnVyCjFj9/nafBUIwnxc5uqGo6I5zzNZHMfvltKBfpAcQLH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/N8hj8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A66C4CEE3;
	Tue, 29 Apr 2025 12:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931035;
	bh=6P1wO3AzCGo0AMGYYGjlFBNkm5T7RBTlxtV64ogESmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/N8hj8iMwfPkUHugqIq0Ckpd22x/R+LvQ/rUTh+/wGmg2TaJf4a+GBwQnMYkruod
	 dWulUJTt9zQsROJd6y22hPE/Tej0K2TmoGCPsBmk/+71kK4myV91QjnHG1FgOFp/q4
	 vsaLjox14lwfvnplSLukI+3Wyiy8ECuhvLNBmiv1DOFMeABNbZSNEB1w0n8+0uhdoE
	 EgXSlKjXqoEW/cOT5eXXWRMRLt9KlGPBpKIAC0sXV+nNlphtVkTjiZBzuBFv640QsU
	 trBPP74mxx4H0KAUm6xxSOyd37MnMYyHjuZD6XVTs/49Lsi0l0211Dmkphn/E7yWH9
	 zWCUgmqrRqwbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/4] xfs: rename xfs_iomap_swapfile_activate to xfs_vm_swap_activate
Date: Tue, 29 Apr 2025 08:50:31 -0400
Message-Id: <20250429002304-39ea40b9085e82f4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <174586545440.480536.11026423037943384392.stgit@frogsfrogsfrogs>
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

The upstream commit SHA1 provided is correct: 3cd6a8056f5a2e794c42fc2114ee2611e358b357

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Darrick J. Wong"<djwong@kernel.org>
Commit author: Christoph Hellwig<hch@lst.de>

Note: The patch differs from the upstream commit:
---
1:  3cd6a8056f5a2 < -:  ------------- xfs: rename xfs_iomap_swapfile_activate to xfs_vm_swap_activate
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

