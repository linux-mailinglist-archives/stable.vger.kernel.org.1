Return-Path: <stable+bounces-136753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B43A9DB16
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F2E9A1122
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0753313665A;
	Sat, 26 Apr 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihKS9oeh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B11AAC4
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673820; cv=none; b=e6kyJj7xeQbmq01yIKDiVfSXWqcgP0WZg/yDg9k1MQrCniwOvJNkVxvdr40+0tp5kdUjVyrkLjT4hIofHCCSFJMovd4dlr0+QezY+vhYe+7PSz5Nr7M0Q/aSVtneP6AbcLB4PRoRAhGpiaIhHseT4WlWSdaPw9dD3GGU0qM1yVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673820; c=relaxed/simple;
	bh=/7Wso0J5cqiV/r3jclVifkv69/Btcoc+At8AI20tN6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjXwkKEr9XoGFL4eQ/ukRqmJTpgP3DgowZoo6bbE2SiODAjY+FmwGpCDPVXVRuTUFU7kqe1EMI0fcdk2oxX8aHJfYIzgKWXjjQ5JCzyvC2x8EtK7CPK0S1bH6NW74uPHygTbcqItdFiWj5ojlDBoJSte7uo3U2ThZvrqH5zdQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihKS9oeh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB8AC4CEE2;
	Sat, 26 Apr 2025 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673819;
	bh=/7Wso0J5cqiV/r3jclVifkv69/Btcoc+At8AI20tN6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihKS9oeh70Yh8COab4XnA5GGkcyUurOh3dDYZ4KMLByWrhUUAfgkWsiMrDCHBKfyg
	 rkbI/4QMzU8xrH35VnzrFCPV+yuq6wxLi5OeAdhxOhZNgKGOUzjikTXNNhAEtGDsEH
	 ahtH7EPaaV816J/VAzINHaOCW911E6cQaUkLJuXN0IqCbDPPViAGy3jDAqMk1m3mmn
	 8jZpEts8irLTdmvchKj6HNlGNumURkUPKx6oj7M2TC0fo++/RnmnMnU9PgyeNy6EpD
	 cvvMcpIGSw365bN+G6tWWZUNdT2/Ave5NqjYHJHEWQZPTY41diApzdbNXNMRCO01Zi
	 rdmJ/B2DLt87w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 6.14 1/1] selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure
Date: Sat, 26 Apr 2025 09:23:37 -0400
Message-Id: <20250426014321-6221f94edd73f622@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250425055702.48973-1-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 5071a1e606b30c0c11278d3c6620cd6a24724cf6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Jakub Kicinski<kuba@kernel.org>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 8513411ec321)

Note: The patch differs from the upstream commit:
---
1:  5071a1e606b30 < -:  ------------- net: tls: explicitly disallow disconnect
-:  ------------- > 1:  ce5593c27c33f selftests/bpf: Mitigate sockmap_ktls disconnect_after_delete failure
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

