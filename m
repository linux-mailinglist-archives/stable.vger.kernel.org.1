Return-Path: <stable+bounces-136754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03991A9DB17
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD98B7A5DF5
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5C413665A;
	Sat, 26 Apr 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f52oshPf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4E1AAC4
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673822; cv=none; b=CtU34tvfyq9ygdU0mZzHKPFtLLt7aOn3m11BiSl6ULw/UzSenCyQXtUxvrLC0bhxNWv4RUcMD7BrioVTkWTM0LC1JCLWFWekNMq4jgWbUimEnwH5RXEZ/SppmGEFy4tlf4rOeQhcz0GfXZgF6uMbkNr0g7elcWVBBbPuJvrWQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673822; c=relaxed/simple;
	bh=1kCp5rJvIThhs5RnQAGAMFhaKUUDZaVvQ46iDg2tPrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOsb7Xs/zBijN/G6n++iw3uLTNVyMwtWIh0pWzOAYERrJuy0TLg19/ps5YiqUYZPq79KXDR7WBy3w0IBipywbz1Noy1HyT55XUvmjELPU/1E3ZYhU+rFUwgaAGX8zBlS8VzStN9je/Ctbn/T5/cdI6IZ0e2LB7K5kzdGG/E7MFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f52oshPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED13C4CEEA;
	Sat, 26 Apr 2025 13:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673821;
	bh=1kCp5rJvIThhs5RnQAGAMFhaKUUDZaVvQ46iDg2tPrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f52oshPfj8LjK1MLYMd3DoBP8VBanfGXCy7sVdWq15cVVzyOXpexYXbC0QUTvpUJd
	 htK3E+mkDjHZZjkWwQG1OfMHthuI/w0pQZRWe1xPt9tPDhc6OIDe4TxvPPkTmwnaWl
	 /CiKYdhOHLVLHpcd0jtdrrjOGolnlzuexj7h3fs4oZLg6Hh+4V5cW7bBmRBEBa8EjE
	 G+H3juUwL9Cr/X8rWrTS5I9Sghb31iTNkdEBcCg/oJvuECta3+pc0+uC6TD04Uxfmf
	 11JuyNu9ouieW8R1x6lKwYXCWpxdCmKFyqvCPnCnhWFVM1ZkWr8WbDEPmBrCYZTiiD
	 2Gwn9z6rCCa5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	david@redhat.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues
Date: Sat, 26 Apr 2025 09:23:39 -0400
Message-Id: <20250426001623-d457ca43b392b0b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250425161512.2188405-1-david@redhat.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 2ccd42b959aaf490333dbd3b9b102eaf295c036a

Status in newer kernel trees:
6.14.y | Present (different SHA1: fc90e2379125)
6.12.y | Present (different SHA1: f268ee2fbb53)
6.6.y | Present (different SHA1: 3867566eb8a4)
6.1.y | Present (different SHA1: 355715264917)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2ccd42b959aaf ! 1:  8e0e5446dde75 s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues
    @@ Commit message
         Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
         Link: https://lore.kernel.org/r/20250402203621.940090-1-david@redhat.com
         Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
    +    (cherry picked from commit 2ccd42b959aaf490333dbd3b9b102eaf295c036a)
    +    Signed-off-by: David Hildenbrand <david@redhat.com>
     
      ## drivers/s390/virtio/virtio_ccw.c ##
     @@ drivers/s390/virtio/virtio_ccw.c: static struct airq_info *new_airq_info(int index)
    - static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
    - 					 u64 *first, void **airq_info)
    + static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
    + 					u64 *first, void **airq_info)
      {
     -	int i, j;
     +	int i, j, queue_idx, highest_queue_idx = -1;
      	struct airq_info *info;
    - 	unsigned long *indicator_addr = NULL;
    + 	unsigned long indicator_addr = 0;
      	unsigned long bit, flags;
      
     +	/* Array entries without an actual queue pointer must be ignored. */
    @@ drivers/s390/virtio/virtio_ccw.c: static struct airq_info *new_airq_info(int ind
      	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
      		mutex_lock(&airq_areas_lock);
      		if (!airq_areas[i])
    -@@ drivers/s390/virtio/virtio_ccw.c: static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
    +@@ drivers/s390/virtio/virtio_ccw.c: static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
      		if (!info)
    - 			return NULL;
    + 			return 0;
      		write_lock_irqsave(&info->lock, flags);
     -		bit = airq_iv_alloc(info->aiv, nvqs);
     +		bit = airq_iv_alloc(info->aiv, highest_queue_idx + 1);
      		if (bit == -1UL) {
      			/* Not enough vacancies. */
      			write_unlock_irqrestore(&info->lock, flags);
    -@@ drivers/s390/virtio/virtio_ccw.c: static unsigned long *get_airq_indicator(struct virtqueue *vqs[], int nvqs,
    +@@ drivers/s390/virtio/virtio_ccw.c: static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
      		*first = bit;
      		*airq_info = info;
    - 		indicator_addr = info->aiv->vector;
    + 		indicator_addr = (unsigned long)info->aiv->vector;
     -		for (j = 0; j < nvqs; j++) {
     -			airq_iv_set_ptr(info->aiv, bit + j,
     +		for (j = 0, queue_idx = 0; j < nvqs; j++) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

