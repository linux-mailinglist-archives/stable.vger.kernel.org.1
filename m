Return-Path: <stable+bounces-137084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A521CAA0C20
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27AD843E68
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C82C2AC2;
	Tue, 29 Apr 2025 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df93rJNN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43342701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931053; cv=none; b=bO9aQLetkMIvMv3H0jOhVAygxIRZvXqe++4tkXLj8PsodYti32xg0TYm7H3xzljRXjDqCwDtLhi4blwyCYzSrIMjCZP+QIycy4gvBLpJl5c+uFMsKiFtjH7PVopTLl74nx126RQ8Vqln8HoZOv9QiIiFh1+w2XSggIfCbjXz/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931053; c=relaxed/simple;
	bh=Prf29Pi4uJ4cwckT+ndKxPzK2ymmCU1CtTFuZVbJZv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrDkXqCk26fHI422c3nHi2nZ/vf6S7LzJTjKM5okpHXNkPpIWUCaexFsWCpWl0Mpi5lK/AXMsSYRvsl07cAUR9WazX3TLnYUjkb4/S5jnMSHxRpAFxjpitSAz7ogpk7vzYMJkRHHGCHkCuvk6+fIj6w+qi0Ud16J3xr4lAfi6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df93rJNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3771CC4CEE3;
	Tue, 29 Apr 2025 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931053;
	bh=Prf29Pi4uJ4cwckT+ndKxPzK2ymmCU1CtTFuZVbJZv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Df93rJNNp+haS6hMWZRYuDdYG6wIV3cPcuwgEE9uqsYnU2057phpDfeyrnIN4+nLc
	 gm/UH8X6+bgNxv4sq5rk1g2PSJwG7KrzoT5kfIs9T4uD0qJpSPmUMIVUKcKqZnlgfL
	 LERGnsGm3AvedrRZTyMxKfEBQRHNWauhth7vYxcK4+P+vIEDkx/e0D0DXMT2wKe3xU
	 6vCfPuKpS2JyHsqZG/4FhcSXWALHMKm8ZGyBBufzgki5BpZJCNdMF+pKtvkTiN7ZYX
	 SZgshm02TuLxHQEQPDJeHRSHWaXSq2wtrMaz60Cnm/IU5/CSyW4NyiPJqeS7cBKgDz
	 Cf5nnJf+gd52g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4/4] xfs: flush inodegc before swapon
Date: Tue, 29 Apr 2025 08:50:49 -0400
Message-Id: <20250429002613-1c634c5091253ecf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <174586545460.480536.4621928282923794223.stgit@frogsfrogsfrogs>
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

The upstream commit SHA1 provided is correct: 2d873efd174bae9005776937d5ac6a96050266db

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Darrick J. Wong"<djwong@kernel.org>
Commit author: Christoph Hellwig<hch@lst.de>

Note: The patch differs from the upstream commit:
---
1:  2d873efd174ba < -:  ------------- xfs: flush inodegc before swapon
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

