Return-Path: <stable+bounces-126035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC6A6F459
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA1D166B8C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1D2561AC;
	Tue, 25 Mar 2025 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evuyrwxx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1375D19F111
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902693; cv=none; b=l+veLyocdeKpoNJ6TGEWWzgteqshwCwGzq1XuqD7qRg6Q+B7x0HDSJrW9yY6gGu5Hnn9/N/FfZa+pZWhrzjfrCIgTHWgPXiJhmeouz5/jBiIZi5SWJ2B3JYX3zt5srcucjxL4AOuAJiOf6agkcprbHhJoOS7DqtHvGu0DSfYziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902693; c=relaxed/simple;
	bh=XrH6D5AVLTry0eBUyC3tGJJXd0S3KO201Gllkbj0Hb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNzy6Do5oDz7NaTd7/3RNlkZY48Y8TQocAffZoSYYDe9hGko030wY2GdmNMeVpLqRvJBE8Pa8sDaa7VYVIOvxAwu+18zJrhd9T6ZVKJ/cpBnV9Byf+Gq9xe8PF1qepyD0NmJe4WlSKx4aLDuEPdNjcmuhv7m1GS+/4I444uqCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evuyrwxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191DCC4CEE8;
	Tue, 25 Mar 2025 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902692;
	bh=XrH6D5AVLTry0eBUyC3tGJJXd0S3KO201Gllkbj0Hb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evuyrwxxuqNTdJfF8B78tvlpx6gpxmMh+ju+0pywDCsVayoS6JHPvTrgA35Mf6VKz
	 dJDgYMCKDqCzdHTA2dXgk1n4LFCBdXbWseJBaMGY1v1SNLw1ME2x7frCO1iv3F4Kdj
	 cnWOkzv2q3GUV+8f4jC5tTkzRSsPlF2fh/WkKrZsrSNO9gGcwXd+s9fJgL2XsdOiDQ
	 ktZDSdDlC1rjPwh6GN3SV03B8hMqYDw0SsBZmJ8bhQlD2C6w1ZVQgiKulV25O1FLK9
	 hE06sI+3tEnSV/1DnSnQrV4gOOkpgkMyGMmwR5IabOzk4GReVHj7LM7Nz5ET3SURLH
	 BAxiJOYfLBiIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] smb: client: fix potential UAF in cifs_dump_full_key()
Date: Tue, 25 Mar 2025 07:38:10 -0400
Message-Id: <20250324204921-67c70fea9df986f6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324070725.3795964-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 58acd1f497162e7d282077f816faa519487be045

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 10e17ca4000e)
6.1.y | Present (different SHA1: 405c7b7970e0)

Note: The patch differs from the upstream commit:
---
1:  58acd1f497162 < -:  ------------- smb: client: fix potential UAF in cifs_dump_full_key()
-:  ------------- > 1:  9a0e9999a34a7 smb: client: fix potential UAF in cifs_dump_full_key()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

