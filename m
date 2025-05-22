Return-Path: <stable+bounces-145949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B9AC01FD
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F049E0FC2
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62CC2B9B7;
	Thu, 22 May 2025 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X82pV0nf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F491758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879418; cv=none; b=m9IBA2Uf9YYYomTY+LASESP8du+L+NHlySTPcyHhrExLGXpzqRzz1Mu6acvg+gmC0hpxuDA/I8QEFjwJjNlVx0WofyWwr4cp+DOKaFisdoH6ubjG068h95hD2Ix8iQeLwohL3aujTpG0mthQZBN+xpHrRHs6rtgHou0Xl5jNT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879418; c=relaxed/simple;
	bh=0d+tkEv3E9PS0KrjIyGmQ3FtFN1/q9AEDFef2HTYBOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jschVuWFVvnSzQ+rP9VieVBW74sirgSHDy0KgrFL8F+3qjcPtgccUC7RAF7ETfDMsYroiLaANNO2aS3WUGajAhfvGQJL5c17HjsywgEzRUVDC8XvkBjvSEjJWF7WI5Rnlv65lLChh3rKSLx7XPQ/1Uhifg+YnnpUhHy4DZ/huz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X82pV0nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F42EC4CEE4;
	Thu, 22 May 2025 02:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879418;
	bh=0d+tkEv3E9PS0KrjIyGmQ3FtFN1/q9AEDFef2HTYBOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X82pV0nfIC7Ee6dRPir4NsffhHeiXwqlNWLguA7ViDr50i6m8VIMgwKxopJkbgXy0
	 GX+2s8D6HowZWpsL5k8JAI1gnzyFoTf3CituU8x6kr7Af5FdbKrmz4o6rPqk8cloci
	 7KCZtZMLAdMvxItXkDPVJoP5r/b2JuiqTVY+i52XWps7nYDMIf6awbcLbPxUVbsFxD
	 lLFsBlT4j7rik6cadGuNYRUXxTF1wuG8JMJvh2regATJrFfk614mABMFC5bLpPXRDQ
	 fi0dPLfTrR5O5jDTqtUO5w+UITwTrbgPcGLZUlucAt7LSaT0Dfe5nU0YkZorbPUf2v
	 AIQhKW7Qpw0Ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] btrfs: check folio mapping after unlock in relocate_one_folio()
Date: Wed, 21 May 2025 22:03:31 -0400
Message-Id: <20250521123937-2da3bd3ff246e8b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521014758.532799-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: 3e74859ee35edc33a022c3f3971df066ea0ca6b9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Boris Burkov<boris@bur.io>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: d508e5627038)

Note: The patch differs from the upstream commit:
---
1:  3e74859ee35ed < -:  ------------- btrfs: check folio mapping after unlock in relocate_one_folio()
-:  ------------- > 1:  3381f0a428658 btrfs: check folio mapping after unlock in relocate_one_folio()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

