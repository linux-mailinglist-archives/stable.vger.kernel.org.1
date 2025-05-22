Return-Path: <stable+bounces-145989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51122AC022A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140FF4A7720
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB6B2B9B7;
	Thu, 22 May 2025 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThTp4o8o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8881758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879583; cv=none; b=cjzaaOvhoUrolVCOAcy3TKiC/0oFwY0R5r136dPn86YMmGjwxmxKiQUTU+nSDeJ5pHccti62EzVCHDlay8srKddV4lromyrHhzwkXDSGqA0DToX3zK0QKswdAQOStLMFp279LtGSUvFNvsOxq6Ql4iz+w4Eqit6MVMMkwDMiiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879583; c=relaxed/simple;
	bh=NY+DVzvPtQ96bBcE8gMJL8biQUIsE52JZ2lnV98l60k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azmz7b/D5qCUAtA9+HmLAZNPwgJPBqIEN2KViFuU6QPyEtsmELyUVZq0dFyYIg7h6HXHurd9FBHDjYYaj6HTlRPjBkDdZXVhjEVpm4AMUiuSAM9/c9MVId/A51rkIjKQhPqQemDoUdPGHEuKQJySV4a2lYd+qMXI6eUqum/Mec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThTp4o8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1FBC4CEE4;
	Thu, 22 May 2025 02:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879583;
	bh=NY+DVzvPtQ96bBcE8gMJL8biQUIsE52JZ2lnV98l60k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThTp4o8ouQiWJbvboriAtsw060SeoJHmNAc+QG89D9zKD0iKkrKTfY6kNERaGcB8H
	 Fz4SH0lj8AcmDbg50tPU9UdxOHBfwj7NLySGPuCnAZRTSP96aUJse4107iNQhAM7/J
	 4l5LWEs2g3NJvMK58mxuvteEnneS+4B1wcVdl8XOFOvKwIEFPPn2rDUCDoFBsDOJep
	 OwRyU8CmQeAdbXlvOhT89Wsbf8yaLKndiuNKaZU08mfSqc2lz/9BZ4aGENOGtrwf/+
	 cTg6ZpY7DnhAETjcMnBj8Z3w+aor3ok0w2zN6z1sQgVBGGmXQG4Hce/7Hjs/Fx32E7
	 gRA/a0WF2v67A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 20/27] af_unix: Detect dead SCC.
Date: Wed, 21 May 2025 22:06:18 -0400
Message-Id: <20250521211513-b5fb9275abe85e4b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-21-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: a15702d8b3aad8ce5268c565bd29f0e02fd2db83

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a15702d8b3aad ! 1:  cf7e2580a8d3f af_unix: Detect dead SCC.
    @@ Metadata
      ## Commit message ##
         af_unix: Detect dead SCC.
     
    +    [ Upstream commit a15702d8b3aad8ce5268c565bd29f0e02fd2db83 ]
    +
         When iterating SCC, we call unix_vertex_dead() for each vertex
         to check if the vertex is close()d and has no bridge to another
         SCC.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-14-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit a15702d8b3aad8ce5268c565bd29f0e02fd2db83)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: void unix_destroy_fpl(struct scm_fp_list *fpl)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

