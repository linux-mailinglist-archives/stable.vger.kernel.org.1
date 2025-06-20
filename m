Return-Path: <stable+bounces-154849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA97AE1115
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECF219E24FE
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E913AA2E;
	Fri, 20 Jun 2025 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0S3tuKL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329E137C37
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750386298; cv=none; b=mAeUf0mJETUTVdO1nZC4Cy51hlGNZRS3TXk/mL2C+8mp6R8qTKJKgum+MogI7i4w1f40dR6PMu3JmH2ipcqoq/p2RsLS3SviQNfirdiSRaUZz4N1CUiL+p0th7dhiNCBfiOensdNje2HP5RAvs5xOxB/bO5zxrTTpf+WrQ/YOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750386298; c=relaxed/simple;
	bh=IO1tWWiLKyaKNa2/2eFNY4x4DfmWaOP82xKCxxBRdVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbU6RQJ+YD0Q2r03gBg5JzE0d7cy/AlUzu+PxQyjoordyMTlEIGrP9AfHL0SLyHmkPPmPumLDvwjOasyhSvwJ8sLcm65UrJnG9ZySxen0xI0L5dIJPWAY8v53080BY694ZrOYV5QmhiGgL9K1xomvRknAzB3yPql05oC2YA+kFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0S3tuKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5B3C4CEEA;
	Fri, 20 Jun 2025 02:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750386298;
	bh=IO1tWWiLKyaKNa2/2eFNY4x4DfmWaOP82xKCxxBRdVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0S3tuKLG0/OYwxnlG9PPNWRDN6YvZ4kEV975AuksG/B7uVQJjK1pppoatwwtWLoP
	 PRwT00FzJkNDlsL0cN+v3P26JiNu6o9tOwy1hlcDDYEAqRfr+rPIPoD7jsX+0UPG8N
	 nOUaFbhZyVWMwyAa1jIufgE93de/BctvDqWJbzWAf6JOj5QzLTZPm1KMByij6Qm2uh
	 n6zh54M43MDaqTTiEkJ3DPyJxfMJpzKAyDW/9mZravwMO6mnfNJCLFMQOIpstZUmVn
	 uIym1iUci2E2NUhIXmTxiYrCn6ZLRIVoim8i1KkMFhzEFfYZMJlLGPw33wGE6tiDRx
	 bGs+fp+5Scokg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gavin Guo <gavinguo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Thu, 19 Jun 2025 22:24:56 -0400
Message-Id: <20250619052203-ef765084c20512a6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250619053001.3295791-1-gavinguo@igalia.com>
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

The upstream commit SHA1 provided is correct: be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 6166c3cf4054)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  be6e843fc51a5 < -:  ------------- mm/huge_memory: fix dereferencing invalid pmd migration entry
-:  ------------- > 1:  7460a8c17e43b mm/huge_memory: fix dereferencing invalid pmd migration entry
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

