Return-Path: <stable+bounces-145962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E61AC020A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09B61B62F27
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B203435953;
	Thu, 22 May 2025 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS8C1YQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732601758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879469; cv=none; b=AupEZp8VNGzp1ek8utFSeNWLstjOVRnpuhIYHWWJTbBbl8KBvcIpYvZbWuczOoZ1ohWDWlYS64FQiVeisVCFjuh+x9HSdEknCu0DMbidXwnGRAucPX5puQ2Yccc69gOk46Tl/ICrHjJOJi1ngWGq6D8lDXDNJwHfyOmAh9jDVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879469; c=relaxed/simple;
	bh=35GuZ7KDXSZYPCvgIYXSs3TZsyf+hCNx50QwOhCVcYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQrFbKtzhtd6GlUzUXAxJsnXdK/8xnk+iep9mDBeJ07+6HUN0DQzvAYygem3tT9NsodOG7XcTd0wKyEgx/co8LbJP1po3IqfgAmg5Hy4JOZUQvDzMRFf0binaI4E4eflJkS8qG6J3l44naQQeYy/m/KoIvlXKBje8oWf3nD6yBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS8C1YQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED40C4CEE4;
	Thu, 22 May 2025 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879469;
	bh=35GuZ7KDXSZYPCvgIYXSs3TZsyf+hCNx50QwOhCVcYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LS8C1YQ/hivzAxUStYG7DY5d++dMzxQ4IdcIut7BZaUKsG7/NumzZgffZoOJNFZVr
	 1VEteViUW9AV6/fsRDdoeMjtuGXS3YWCFY2x1mvSctqDGYc9leObSF4ce1IWSCzkCV
	 Y7QCLsPTHEq8BRVzYrGoCVHXZpWFUBgnjRsxVfIqfGKW1QKFvNeIwFnNe2SlGQlBxL
	 /I/Az1GPGrg7exGfWyq2PZgMyhLtISMkq60j2IN8q803J22djjZORN5BmW9iYlHXaS
	 gyoKQz3sye2XpdY2pqenaApYvDpjBbgi+3YpNY2yKxd8jeEHYDb+qNanrIx8tdkHbK
	 MxVZRdgvrGejA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 25/26] af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
Date: Wed, 21 May 2025 22:04:25 -0400
Message-Id: <20250521184823-d63ded60b2caea0a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-26-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 041933a1ec7b4173a8e638cae4f8e394331d7e54

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Michal Luczaj<mhal@rbox.co>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  041933a1ec7b4 ! 1:  1d98e6545ee6f af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
    @@ Metadata
      ## Commit message ##
         af_unix: Fix garbage collection of embryos carrying OOB with SCM_RIGHTS
     
    +    [ Upstream commit 041933a1ec7b4173a8e638cae4f8e394331d7e54 ]
    +
         GC attempts to explicitly drop oob_skb's reference before purging the hit
         list.
     
    @@ Commit message
         Signed-off-by: Michal Luczaj <mhal@rbox.co>
         Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit 041933a1ec7b4173a8e638cae4f8e394331d7e54)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: enum unix_recv_queue_lock_class {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

