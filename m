Return-Path: <stable+bounces-136747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B5A9DB10
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637159A0FDC
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9B014375D;
	Sat, 26 Apr 2025 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKRtNqyb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3833208
	for <stable@vger.kernel.org>; Sat, 26 Apr 2025 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745673775; cv=none; b=UuGgKVp0VbevwP4js4OCY+v2F6dLAcJuB905rZvp4MwU6/2CN+o0dqjHnGHlhBuM9TmrgpdAo3l3MD0RmMjQwiQaPNKxGkz+MkiYuPnzQfxm90cbtdCjYPrlb6jP0DufRnr0wr7qStNvAxwDNeUWs/GV2jQ6yrODWHzWBghJOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745673775; c=relaxed/simple;
	bh=ufxR0jemOvPy3ks1sRExsYnNDrKTENHcqF9mnnmWHOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwrpyaoqhRBPj3E+yTEVPFGss71nYRngL0NR0I0yvwOmjXK7HXpL5Shsb4TqlqAu1zGHK1/w8KykexVsa/1CpF2My7NMe8+iZQdFZgVuTl9hZZHZQul/OCirg9BGghxFZCqNMndCIHXoZVNwuGeOF4EhWEwNoRaXiIwIF9NlL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKRtNqyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AF4C4CEE2;
	Sat, 26 Apr 2025 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745673774;
	bh=ufxR0jemOvPy3ks1sRExsYnNDrKTENHcqF9mnnmWHOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKRtNqybuSpfKU4YwdDm+SghTZT/Kp9MQcj2MxAn1ich+gGX2dR1qWYgkp1EKxx7b
	 QpEvPI+yxnmoMCSzKLa4XT8ha1eUtK3Kmr4kFt/AJ+oBe3GEWpvcQabpgAETOrhY0f
	 /637q27xhJX3wt5oHmfW9rTltZyVr3k3VsTNmhTmMRVRk8XEOmcRvzqotFituh+zLH
	 5i9PwEcXTrAAW1euAmT52iRXjOGqi3itnYgHZaWD5Hng0NYwPGK9nVSXK+RVIXJVyy
	 0KAqUnr8FpE8rIpSK/9/kqCtz/LnJnkmDLF/u/UwitKEnt8o1y0F2nZ7+mOH3g3y+V
	 k2nFS8JrB0ETA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	david@redhat.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues
Date: Sat, 26 Apr 2025 09:22:52 -0400
Message-Id: <20250426040717-91bbf4a4f20e0c23@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250425155916.2160562-1-david@redhat.com>
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

Note: The patch differs from the upstream commit:
---
1:  2ccd42b959aaf ! 1:  cd826c933bdc0 s390/virtio_ccw: Don't allocate/assign airqs for non-existing queues
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
| stable/linux-6.6.y        |  Success    |  Success   |

