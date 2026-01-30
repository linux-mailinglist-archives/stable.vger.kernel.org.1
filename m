Return-Path: <stable+bounces-212839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPN5Dcc8fGkXLgIAu9opvQ
	(envelope-from <stable+bounces-212839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 06:08:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9113B732B
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 06:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EF493014945
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 05:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4EB335564;
	Fri, 30 Jan 2026 05:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyqiHs3I"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC831355C
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749689; cv=none; b=Sa4OYxhcv+xB3tgbHG/vD2/rtlBuwmgo4PY9LCrtG95sra0djb2WZJul2WeE7QOp2ebh0i1XoK/aZ7M4Z1io40/zX+88i9AcpMkHxHa9m+bHseWOp9fWukJ5t126JVBQBDa1/p6bKyXaOjGnoj1LNDQIMVKlp4m1kCs96g8ty8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749689; c=relaxed/simple;
	bh=Jj+LXlJqQOlKkxRPXbwCJJTijkMOPwxHoRAkNl14xYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbFI0GI878wu+O/Xvfg2/hlrrUVDfy4CwiNyxhLmCUxAXzlARdYx+6zTTf6HC/K1cdU+9A34HQ9vJkIDRRmgmqvq1n16Rpj52H3N6KHVoF10vR5f/arW7Oi+Dr1wdeRRsSQyn4dCBu6gu9saQuME2VOI+qzvYBA9gjJkTjqI8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyqiHs3I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769749686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IMJwRxEHfAIl5OOD17eYG7N79bWeNFHiCLhK3OOmj9I=;
	b=UyqiHs3Ih9TQs15FSuDy7oZZc0PXNEbX+sKiOvBIOmvhNCTZGtvbD9Cft5VGss9Zwhntx1
	9GrcTSFD0XhspBYltahKZs+J4E7nqy4z65+LRFBF96VRWVyVLj3EZikOofcgV1fBmj4zYZ
	633kqc1AcfozJWl13Cxf5ygxegLP1qM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-kRpMC9QlMMCWjgSra_knDg-1; Fri,
 30 Jan 2026 00:08:01 -0500
X-MC-Unique: kRpMC9QlMMCWjgSra_knDg-1
X-Mimecast-MFC-AGG-ID: kRpMC9QlMMCWjgSra_knDg_1769749680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94B391954B14;
	Fri, 30 Jan 2026 05:07:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.11])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E7C31956056;
	Fri, 30 Jan 2026 05:07:53 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	xieyongji@bytedance.com,
	stable@vger.kernel.org
Subject: [PATCH] VDUSE: avoid leaking information to userspace
Date: Fri, 30 Jan 2026 13:07:50 +0800
Message-ID: <20260130050750.4050-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-212839-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9113B732B
X-Rspamd-Action: no action

The bounceing is not necessarily page aligned, so current VDUSE can
leak kernel information through mapping bounce pages to
userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
information to userspace.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 0a9f668467a8..ec743bed361c 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -124,7 +124,7 @@ static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 		if (!map->bounce_page) {
 			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_MAP_SHIFT];
 			if (!head_map->bounce_page) {
-				tmp_page = alloc_page(GFP_ATOMIC);
+				tmp_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 				if (!tmp_page)
 					return -ENOMEM;
 				if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 73d1d517dc6c..57a40a821c65 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -976,7 +976,7 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 	if (!token.group)
 		return NULL;
 
-	addr = alloc_pages_exact(size, flag);
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 
-- 
2.34.1


