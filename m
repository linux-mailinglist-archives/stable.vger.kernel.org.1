Return-Path: <stable+bounces-139345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12695AA631E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C929A1BC3887
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA5E1EDA2B;
	Thu,  1 May 2025 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0v25WLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1F1C1F22
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125458; cv=none; b=BJYKEaxrgjo0BEUkYG/Jpd8G9fSphoAsIwlrVDzGTozm0fCQAeUvCQGqJmIQQEQ5uUY2YVd9UWEm4oR6wC9lxpHC8QtLT6qJykoxdcCUWYw+rc1CtajdvZCPvi0cV7fV/MQZHRpp6fSspCcW/s+h5McMwbo7pjwe3O+10fxjRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125458; c=relaxed/simple;
	bh=YrGv9MMAmhkoAuooot4vufTYejUaoBYG0b5rCHjZhFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eg8O8gQvT9SbdR1ERUiC3CO5gyJwbRJCA5nj5Y4I/pb+hNoUIKxkdQfYuk+QoiEUMpTA/Aqda5Z7wZttZ7Bfh+e7oM0bZPI0r9DJfCasotyKBONuS5mDzflQ6s80ACiJjTOfceSLeQMFny/yn+KPTIqftIRa00hLuLun+PK7Yro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0v25WLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AB9C4CEE3;
	Thu,  1 May 2025 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125457;
	bh=YrGv9MMAmhkoAuooot4vufTYejUaoBYG0b5rCHjZhFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0v25WLB/i93mfvTruGOth5fPCsGuBUKfrkM7lrYaqPhxKVGeXOKJbJXkswZri2F+
	 ffaH9okaU9eMsV0aVm9P1u9xw/g7djk64O6GmKT3hkqtIPOWw8uVmn7ldwW26VUJ8N
	 6zDiddiYkKVsI60tqG7hDTWhlYTul3XpNNl+qZrBe6MkKonmnuTV6m7lhz5lSW0g7q
	 9oixHaEZMI6Ydhvdbffo1kmQy7IXyIhnzCe3m6HrC20Z1xsm7G9IeHAk9zrpOejieb
	 ohY+v3x9G/N8RWosR80hfoTF7Vh9IQG9Gl+m5QakM0GqUwGjLDgieYa5yQnK7zpcgD
	 RuH254fhMInpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 11/16] xfs: convert delayed extents to unwritten when zeroing post eof blocks
Date: Thu,  1 May 2025 14:50:53 -0400
Message-Id: <20250501130117-09008a31e7709130@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-12-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 5ce5674187c345dc31534d2024c09ad8ef29b7ba

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Zhang Yi<yi.zhang@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 4c99f3026cf2)

Note: The patch differs from the upstream commit:
---
1:  5ce5674187c34 ! 1:  05bb9e0eda29d xfs: convert delayed extents to unwritten when zeroing post eof blocks
    @@ Metadata
      ## Commit message ##
         xfs: convert delayed extents to unwritten when zeroing post eof blocks
     
    +    [ Upstream commit 5ce5674187c345dc31534d2024c09ad8ef29b7ba ]
    +
         Current clone operation could be non-atomic if the destination of a file
         is beyond EOF, user could get a file with corrupted (zeroed) data on
         crash.
    @@ Commit message
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/xfs_iomap.c ##
     @@ fs/xfs/xfs_iomap.c: xfs_buffered_write_iomap_begin(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

