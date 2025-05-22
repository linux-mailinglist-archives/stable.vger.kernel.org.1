Return-Path: <stable+bounces-145983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC13AC0224
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300F7A22B46
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C5F3FBA7;
	Thu, 22 May 2025 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYxx8JZc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33A18E3F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879558; cv=none; b=fLrG9WRiCmpQ7AnGoJmZmwLN4YSY1TGxOf6xZlf1CYfQYUrKQbjRRYHdeJFLrq8cC5qpWkOGRyLYA6oW41fJI8fW51hm7tTzz4SduRfhZcGRogiwa81QZQ6vjslm856e66723p+lVoeMe6uaEsDgEDLNiZA6+BgBIlfbzF7bNug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879558; c=relaxed/simple;
	bh=QY2GzLVMLRyI2PFhbDjuCudzQkm3Xg6e/XjqfuDlD/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zu3EgP7txji2AOmWVRKbe0pWaZ17gPX7mCfCdCP7susL5o5tFVNHwoOjQC6mxOWH88BB/fp8V8QXP7e34trmrKVjvoz8p5WHZqYsmadDr6FDrnTKDgFkXcNpto0AQ128M00qpRoQbgxRkPZ2hT3kA0GPYypFp9b8Oujo/vBwiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYxx8JZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009DAC4CEEF;
	Thu, 22 May 2025 02:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879557;
	bh=QY2GzLVMLRyI2PFhbDjuCudzQkm3Xg6e/XjqfuDlD/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYxx8JZca1FAt5cFfuTOUV9W8MlMtSHmBfkKuChBmFkcFaOTtCMghr10uC+vsTkEz
	 82MkC5imBiJcZoGnwVScDRgZRMMv4WOJcTodKB2jTXYEF8RBYgbPpjpCnlwOS1AXKZ
	 T63IqVFC71fQHZFQ94pSblfSgTzHqbPXjSfpErLSAhQK/0t2C4oxll29wk00vym0m8
	 Xwu203ds1sOhaj3yMbJisXybteUtsYycDcAyF5GoPc5JTiRD/5jdNENWbsI2CPJdzf
	 CGkRBNOY5wvcuscLv+v8XSwuPe9+zuevfRP7g6PVBBNDzPbeg1IqVO8TEuaCqo4KLj
	 kNDuY/c5Rm5dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 09/26] af_unix: Link struct unix_edge when queuing skb.
Date: Wed, 21 May 2025 22:05:53 -0400
Message-Id: <20250521172608-932f3f01338a0d09@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-10-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 42f298c06b30bfe0a8cbee5d38644e618699e26e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  42f298c06b30b < -:  ------------- af_unix: Link struct unix_edge when queuing skb.
-:  ------------- > 1:  615b9e10e3377 Linux 6.6.91
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

