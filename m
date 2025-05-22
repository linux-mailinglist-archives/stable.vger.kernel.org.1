Return-Path: <stable+bounces-145997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FAFAC0236
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF377B2F61
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4948BEC;
	Thu, 22 May 2025 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiSODB8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48906FBF
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879651; cv=none; b=RCn/9U5RFtvR0YAjVrwcDS2aj+l6+POJS+MAlhyph6cJQokN9WqQrmA30SAAJSW1+E5+hWGdEPSXqBO6ouOpNv2k15fLxRS9rhQhdlasZ+dPaz8UVWG/BVEdJ9xOYgq6nHHyMrFwaO+/zwezaSVXJ5yLEoF3Pf5wiv5xG00hUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879651; c=relaxed/simple;
	bh=lP/jrXEWXmfTZ6uFLZsq9npbkXmLc+kcZuwSUqhSzuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlJUv7aMC4z+6Nrzvhj9FfdwL9N5Lx2HsiVcPUx/AraYjHjosHWfQ5DBry378p9E7CRBR/6JnjNHQ82Rg49NDY7XTCg/beWzDax1pGvgXNeqg5g9YfvOsMjNZbihS7VmJ0x0ORL3X5U86VgJOUwq9NGRzPO/a0s0EilMtDCTfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiSODB8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25DDC4CEE4;
	Thu, 22 May 2025 02:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879650;
	bh=lP/jrXEWXmfTZ6uFLZsq9npbkXmLc+kcZuwSUqhSzuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OiSODB8bvCrZbM6TdAyLIH27rhP/VJebQ7VySqglTEy6ai7rDLBAT7kTFKiyBYO7s
	 FrZAP+pjsSvEalLFQ9wsVdFZTxrgA7ZGST48A8jlsI25P/wlQxepMBkouxJu9/1c6T
	 FwcYR3NeSLE2wwErz1SHzNk3nz3YpahPS4Yhr/GzliRm0ZOUbZf472ZELTNVEpOBBD
	 QZoimUI5sxrc6Os2FMt0kJkFNgc4snu6e4g3mcksEfGLWRnkzzYmusjWzXIDGGlvO8
	 OeSu9MrKlg72qZKB6/WylQIAlPMCbfFI1QdBTQa1DBAwEOR+kCU5WbdBJ0XtFjEhQ6
	 9yYzB4zFPwNJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qingfang Deng <dqfext@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 1/5] kernfs: add a revision to identify directory node changes
Date: Wed, 21 May 2025 22:07:28 -0400
Message-Id: <20250521153013-255373cb29c075e6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521015336.3450911-2-dqfext@gmail.com>
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

The upstream commit SHA1 provided is correct: 895adbec302e92086359e6fd92611ac3be6d92c3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Qingfang Deng<dqfext@gmail.com>
Commit author: Ian Kent<raven@themaw.net>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  895adbec302e9 ! 1:  384581c600ad7 kernfs: add a revision to identify directory node changes
    @@ Metadata
      ## Commit message ##
         kernfs: add a revision to identify directory node changes
     
    +    Commit 895adbec302e92086359e6fd92611ac3be6d92c3 upstream.
    +
         Add a revision counter to kernfs directory nodes so it can be used
         to detect if a directory node has changed during negative dentry
         revalidation.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

