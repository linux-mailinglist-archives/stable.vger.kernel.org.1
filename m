Return-Path: <stable+bounces-95534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F579D9A5B
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 16:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C8316569F
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A21D47C1;
	Tue, 26 Nov 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNs4Sze4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45861C1F02
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634574; cv=none; b=VgVGZPuH01s82JzaR9t7LD7bFjVUwRY6WS685Zy+6Ee6oJDOydvP3JNDYkI5tvVXkXzU4r/BJABIF+xXEETlH4PYiGAeccN5ll/KQJQDBXRFgJzQieBG8ezoTSl60TdXlOd7En+3w5H/sr0y1tFlVUgrgraHuuFYTtodhIukoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634574; c=relaxed/simple;
	bh=/x/e3h2Uce0uUKwZfRqXwrJOUezn3r449YASgjfkvgM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=OyQb8MmOP2Z3duhLWJ3ZHmU3apBDSN7zmDlgX5hgEWX0092pzRQc83qKkWVe+uHf7nkGBKcmoVwm8MVT4Lt+xs5Dv/tvxh1nNWnpUjEJBoyd/8OTqv0/Q7wrF8q8hTdVCkPTOqhMlRXIGWzT+GVFlHl0HTvkYKmWon02lYjiANw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNs4Sze4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732634571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PSjHlnhEWEiU3QdATTDD7NFkQRILQhsOVxSB19RgeBY=;
	b=UNs4Sze46J7th5Aq6LvekCmqcTvZg8Lgsy4HY94ATWiwl4Dcc9SyFmSBgnVJhAJFhzClMq
	2ojpgbFGm4fFtuLoEn9EPAzV62l+dUkzXxvtVZ9Q9t7yoX9cAqJUe1DSrWTqjPBGcCltMq
	Mi2YJ6kDPSbgDp+3sHCuzXwm9J7Sv78=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-vcQtkgftOnmf3mUwMpSNIw-1; Tue,
 26 Nov 2024 10:22:48 -0500
X-MC-Unique: vcQtkgftOnmf3mUwMpSNIw-1
X-Mimecast-MFC-AGG-ID: vcQtkgftOnmf3mUwMpSNIw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26B181955BCF;
	Tue, 26 Nov 2024 15:22:47 +0000 (UTC)
Received: from [10.45.225.96] (unknown [10.45.225.96])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 761EB1955F40;
	Tue, 26 Nov 2024 15:22:45 +0000 (UTC)
Date: Tue, 26 Nov 2024 16:22:41 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sasha Levin <sashal@kernel.org>
cc: Matthew Sakai <msakai@redhat.com>, 
    Zdenek Kabelac <zdenek.kabelac@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] dm-bufio: fix warnings about duplicate slab caches
Message-ID: <6ccb6bf0-b5c8-5a61-85fe-37ff25453d4e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi

I submit this upstream patch for the stable branches 6.6 and 6.11.

Matthew Sakai from the DM-VDO team found out that there is a very narrow 
race condition in the slub sysfs code and it could cause crashes if caches 
with the same name are rapidly created and deleted. In order to work 
around these crashes, we need to have unique slab cache names.

Mikulas



commit 42964e4b5e3ac95090bdd23ed7da2a941ccd902c
Author: Mikulas Patocka <mpatocka@redhat.com>
Date:   Mon Nov 11 16:48:18 2024 +0100

    dm-bufio: fix warnings about duplicate slab caches
    
    The commit 4c39529663b9 adds a warning about duplicate cache names if
    CONFIG_DEBUG_VM is selected. These warnings are triggered by the dm-bufio
    code. The dm-bufio code allocates a slab cache with each client. It is
    not possible to preallocate the caches in the module init function
    because the size of auxiliary per-buffer data is not known at this point.
    
    So, this commit changes dm-bufio so that it appends a unique atomic value
    to the cache name, to avoid the warnings.
    
    Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
    Fixes: 4c39529663b9 ("slab: Warn on duplicate cache names when DEBUG_VM=y")

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index d478aafa02c9..23e0b71b991e 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -2471,7 +2471,8 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	int r;
 	unsigned int num_locks;
 	struct dm_bufio_client *c;
-	char slab_name[27];
+	char slab_name[64];
+	static atomic_t seqno = ATOMIC_INIT(0);
 
 	if (!block_size || block_size & ((1 << SECTOR_SHIFT) - 1)) {
 		DMERR("%s: block size not specified or is not multiple of 512b", __func__);
@@ -2522,7 +2523,8 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	    (block_size < PAGE_SIZE || !is_power_of_2(block_size))) {
 		unsigned int align = min(1U << __ffs(block_size), (unsigned int)PAGE_SIZE);
 
-		snprintf(slab_name, sizeof(slab_name), "dm_bufio_cache-%u", block_size);
+		snprintf(slab_name, sizeof(slab_name), "dm_bufio_cache-%u-%u",
+					block_size, atomic_inc_return(&seqno));
 		c->slab_cache = kmem_cache_create(slab_name, block_size, align,
 						  SLAB_RECLAIM_ACCOUNT, NULL);
 		if (!c->slab_cache) {
@@ -2531,9 +2533,11 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 		}
 	}
 	if (aux_size)
-		snprintf(slab_name, sizeof(slab_name), "dm_bufio_buffer-%u", aux_size);
+		snprintf(slab_name, sizeof(slab_name), "dm_bufio_buffer-%u-%u",
+					aux_size, atomic_inc_return(&seqno));
 	else
-		snprintf(slab_name, sizeof(slab_name), "dm_bufio_buffer");
+		snprintf(slab_name, sizeof(slab_name), "dm_bufio_buffer-%u",
+					atomic_inc_return(&seqno));
 	c->slab_buffer = kmem_cache_create(slab_name, sizeof(struct dm_buffer) + aux_size,
 					   0, SLAB_RECLAIM_ACCOUNT, NULL);
 	if (!c->slab_buffer) {


