Return-Path: <stable+bounces-33015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BFC88EC98
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE111F32D28
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DB114E2C0;
	Wed, 27 Mar 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6ydIzrQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C1149DF5
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560397; cv=none; b=ohBx5gbPugwejJm5AblWDWTQBUwnCSAp2OYhDKWzKiQQv75z2YrtCHR3DNTW8V/oijvW/Ef5Ybx+RqxoeQwbxJhyQUPqRMt3Suo/EDEZ78QQu5E2NXWDnUgApGP0s2o3y+t/NdJFaSK5mEo6Csmg4E0dVDhifkPD7NsKgdWGEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560397; c=relaxed/simple;
	bh=KO68VCsBjC7YXYAlyG5RlT0YZwWtlqL82EO6khY7yOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nVSy6CX/0E7o7f1VxmqqCpk4bK02w9I0sSEOAwIIw8OJbHjobPraIxk2dpxDgThQYGDJVECznzTReXF4Z7tmdliuldARAiogJmBgG4aAJkPk2htZg/FMMPIxw0D0V0If5XjnBHIvEpG0ePvqTeDHlt1Ye648jiI1GHvNdgL2JI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G6ydIzrQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711560395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=/EOUB4d8qVh5umKC4okNLh+AeZuN4LrBRasgfUriSZs=;
	b=G6ydIzrQifORIn2zOgMnt2JARuokRL4EdFiPLRq1AdwHC8zuC6FykaKQeR/CDLpXTpeY45
	aB8U/y4gA25zAQLN+SJQuhAtC/M00drJhzJrMZNmQVcNdZNIV6pNecD9TTeqlFg7q4L77L
	zXkKxZBp00JpyMt9CcaxD/j16UUKzwY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-464YGPYGMiSQ6ujFqzXMCA-1; Wed, 27 Mar 2024 13:26:32 -0400
X-MC-Unique: 464YGPYGMiSQ6ujFqzXMCA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d491456df2so5634101fa.1
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 10:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711560391; x=1712165191;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EOUB4d8qVh5umKC4okNLh+AeZuN4LrBRasgfUriSZs=;
        b=oLCFfXzXtM8sQ92AjM0SmxZPIP7Hmihvdc8/VCFQtRXN1thb3VTqMww76+RTRagT6m
         EB3CBWPh1Ni/1DAeYvfCux8EJQJI8WhAmDLNKRmab15qyE850779GZRyNfZlN90E/9bp
         tqoTnx9FGm+XAdqOxEetIAFM/geISZfOiqdXYLux0nlP30ft6oZpUFEiakGIOPt8NWVc
         jCzf2VgNYQHQbYeSf8/bpmtxuHzEr4IfdRIVrQiYA+7oghwA1lrHGSt3j6+IOXtLJQ0L
         FwS9KLb8lxB6GegGqD4Kh4OWoasX89vWJSkAZh2NrJI1IzJXVCKmEKXY2nR+k5T8VSiu
         Whew==
X-Gm-Message-State: AOJu0Yw/zHUDN9hxFKc0d/hg/HxYGUZg/SXM7Vz8lwhfo83Def2Jmuft
	s2xkvj2RRXp+wlJJcDl43y424RPTQmChSmZPa3yhV6nvZhANP3MbmklGpFHMO5PQvkUhk2+Q/nH
	hUcM92TNoMTGN2J+3U4nbo2VpB+wqvnFf2K8QwScr5zXnQXm2qrwzJw==
X-Received: by 2002:a19:ca4b:0:b0:513:e69a:a1ff with SMTP id h11-20020a19ca4b000000b00513e69aa1ffmr72095lfj.33.1711560390552;
        Wed, 27 Mar 2024 10:26:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsrrH9Se2ailCE8t/vJCFLbo93g75ddmuCiDF++8BsJ7zx/RU+W9ujlWe6Cep9MzUutd5uVA==
X-Received: by 2002:a19:ca4b:0:b0:513:e69a:a1ff with SMTP id h11-20020a19ca4b000000b00513e69aa1ffmr72081lfj.33.1711560389862;
        Wed, 27 Mar 2024 10:26:29 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id e5-20020a196905000000b00515904f7ba3sm1947672lfc.198.2024.03.27.10.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 10:26:29 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:26:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
	Will Deacon <will@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: [PATCH untested] vhost: order avail ring reads after index updates
Message-ID: <f7be6f4ed4bc5405e9a6b848e5ac3dd1f9955c2a.1711560268.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

vhost_get_vq_desc (correctly) uses smp_rmb to order
avail ring reads after index reads.
However, over time we added two more places that read the
index and do not bother with barriers.
Since vhost_get_vq_desc when it was written assumed it is the
only reader when it sees a new index value is cached
it does not bother with a barrier either, as a result,
on the nvidia-gracehopper platform (arm64) available ring
entry reads have been observed bypassing ring reads, causing
a ring corruption.

To fix, factor out the correct index access code from vhost_get_vq_desc.
As a side benefit, we also validate the index on all paths now, which
will hopefully help catch future errors earlier.

Note: current code is inconsistent in how it handles errors:
some places treat it as an empty ring, others - non empty.
This patch does not attempt to change the existing behaviour.

Cc: stable@vger.kernel.org
Reported-by: Gavin Shan <gshan@redhat.com>
Reported-by: Will Deacon <will@kernel.org>
Suggested-by: Will Deacon <will@kernel.org>
Fixes: 275bf960ac69 ("vhost: better detection of available buffers")
Cc: "Jason Wang" <jasowang@redhat.com>
Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
Cc: "Stefano Garzarella" <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I think it's better to bite the bullet and clean up the code.
Note: this is still only built, not tested.
Gavin could you help test please?
Especially on the arm platform you have?

Will thanks so much for finding this race!


 drivers/vhost/vhost.c | 80 +++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 045f666b4f12..26b70b1fd9ff 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1290,10 +1290,38 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 		mutex_unlock(&d->vqs[i]->mutex);
 }
 
-static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
-				      __virtio16 *idx)
+static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 {
-	return vhost_get_avail(vq, *idx, &vq->avail->idx);
+	__virtio16 idx;
+	u16 avail_idx;
+	int r = vhost_get_avail(vq, idx, &vq->avail->idx);
+
+	if (unlikely(r < 0)) {
+		vq_err(vq, "Failed to access avail idx at %p: %d\n",
+		       &vq->avail->idx, r);
+		return -EFAULT;
+	}
+
+	avail_idx = vhost16_to_cpu(vq, idx);
+
+	/* Check it isn't doing very strange things with descriptor numbers. */
+	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
+		vq_err(vq, "Guest moved used index from %u to %u",
+		       vq->last_avail_idx, vq->avail_idx);
+		return -EFAULT;
+	}
+
+	/* Nothing new? We are done. */
+	if (avail_idx == vq->avail_idx)
+		return 0;
+
+	vq->avail_idx = avail_idx;
+
+	/* We updated vq->avail_idx so we need a memory barrier between
+	 * the index read above and the caller reading avail ring entries.
+	 */
+	smp_rmb();
+	return 1;
 }
 
 static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
@@ -2498,38 +2526,21 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 {
 	struct vring_desc desc;
 	unsigned int i, head, found = 0;
-	u16 last_avail_idx;
-	__virtio16 avail_idx;
+	u16 last_avail_idx = vq->last_avail_idx;
 	__virtio16 ring_head;
 	int ret, access;
 
-	/* Check it isn't doing very strange things with descriptor numbers. */
-	last_avail_idx = vq->last_avail_idx;
 
 	if (vq->avail_idx == vq->last_avail_idx) {
-		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
-			vq_err(vq, "Failed to access avail idx at %p\n",
-				&vq->avail->idx);
-			return -EFAULT;
-		}
-		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
-
-		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
-			vq_err(vq, "Guest moved used index from %u to %u",
-				last_avail_idx, vq->avail_idx);
-			return -EFAULT;
-		}
+		ret = vhost_get_avail_idx(vq);
+		if (unlikely(ret < 0))
+			return ret;
 
 		/* If there's nothing new since last we looked, return
 		 * invalid.
 		 */
-		if (vq->avail_idx == last_avail_idx)
+		if (!ret)
 			return vq->num;
-
-		/* Only get avail ring entries after they have been
-		 * exposed by guest.
-		 */
-		smp_rmb();
 	}
 
 	/* Grab the next descriptor number they're advertising, and increment
@@ -2790,25 +2801,21 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
 /* return true if we're sure that avaiable ring is empty */
 bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
-	__virtio16 avail_idx;
 	int r;
 
 	if (vq->avail_idx != vq->last_avail_idx)
 		return false;
 
-	r = vhost_get_avail_idx(vq, &avail_idx);
-	if (unlikely(r))
-		return false;
-	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
+	r = vhost_get_avail_idx(vq);
 
-	return vq->avail_idx == vq->last_avail_idx;
+	/* Note: we treat error as non-empty here */
+	return r == 0;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
 
 /* OK, now we need to know about added descriptors. */
 bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 {
-	__virtio16 avail_idx;
 	int r;
 
 	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
@@ -2832,13 +2839,10 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	/* They could have slipped one in as we were doing that: make
 	 * sure it's written, then check again. */
 	smp_mb();
-	r = vhost_get_avail_idx(vq, &avail_idx);
-	if (r) {
-		vq_err(vq, "Failed to check avail idx at %p: %d\n",
-		       &vq->avail->idx, r);
+	r = vhost_get_avail_idx(vq);
+	/* Note: we treat error as empty here */
+	if (r < 0)
 		return false;
-	}
-	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
 
 	return vq->avail_idx != vq->last_avail_idx;
 }
-- 
MST


