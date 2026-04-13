Return-Path: <stable+bounces-235944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOe4HFCe3GkeUgkAu9opvQ
	(envelope-from <stable+bounces-235944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:42:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D93E861A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76CBD306B1A4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E65396579;
	Mon, 13 Apr 2026 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Iw8uUTFY"
X-Original-To: stable@vger.kernel.org
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9ED394492
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065799; cv=none; b=je7nsV3dn+D8TVHFnWs/5UqijSziVKbzNDYhwwSqyKdGMbbOsEhcEtrIfE3jVGnvbEYBa7hdi+ocGmlr0OcXZ34RTnLB53TITUIc0jyy+TqUY8uV8L19Q6T5awxPRcLqApXjvAX7ZHVb5bL144WI9stmF0toDsShVE1s4pZ7S4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065799; c=relaxed/simple;
	bh=udLn74JxhDF7Sr+0RcIAAIJPKdt0g6+Cyo54JAMtr2c=;
	h=Date:Content-Type:To:Cc:From:Subject:Message-Id:Mime-Version; b=AVUZAS8DAJb8szNxqKWffuZjzPASD+cAxo/GqRPrEEYWOj2BdKVV01jhc2QZhTl9Sj17nudr4DiCM4R/2Ltn3fRyRXlgJHRNvQ0KBo0Y5+UWSLOtmvhNwfN5sdy5NzliKhz+4SnxhODEL0thHk4ImkNLdezqhoybrJ0d8fobxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Iw8uUTFY; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776065789; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rhZEIiDegqUPaC2rLzO5r5Di1IByvlqQfj2KNidppxM=;
 b=Iw8uUTFYnZ2FIz3xH412JTtnCTT3a07t5m4OUEVKuo0W6L63oTrfCiwXfwz93tnRtqXIhe
 w6s8E8LrQz6Z5bhPifuSbtdKy3ZkLtstf8cWBoPzwVng4rHuXgfMbKYFEFHx0pi6usT1MT
 My3/QShXwhlMD9xvqd31rXnmeZdXxRS7LGPMSmUe9qaEajcTgnP/Mu61d41ET1SK0huxmy
 6T+uyLYLVhD0SOaS+tXdtPHrYmNKgAJ5Q0g0z/wi2+E04P9/vtc8Hq7OrHqu7hlw8YK7H0
 1v9xeg425XQ6rqgjj6XXp1ussarS1KfbQHLYBckP4fkf79N5m+5Tr37r5QRBYw==
Date: Mon, 13 Apr 2026 15:36:03 +0800
X-Lms-Return-Path: <lba+269dc9cfb+b71271+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Alex Williamson" <alex@shazbot.org>, "Jason Gunthorpe" <jgg@ziepe.ca>, 
	"Yishai Hadas" <yishaih@nvidia.com>, 
	"Shameer Kolothum" <skolothumtho@nvidia.com>, 
	"Kevin Tian" <kevin.tian@intel.com>
Cc: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>, <stable@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [RESEND PATCH] vfio/virtio: Fix lock/unlock mismatch in virtiovf_read_device_context_chunk()
Message-Id: <20260413073603.30538-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235944-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guojinhui.liam@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD2D93E861A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

virtiovf_read_device_context_chunk() takes migf->list_lock with
spin_lock() but releases it with spin_unlock_irq().  This mismatch
can incorrectly enable interrupts if they were already disabled
when the lock was acquired, leading to unbalanced IRQ state.

Fix by using spin_lock_irq() to match spin_unlock_irq().

Fixes: 0bbc82e4ec79 ("vfio/virtio: Add support for the basic live migration functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---

Hi,

Sorry for the noise. Resent with "Cc: stable@vger.kernel.org"";
no other changes.

Best regards,
Jinhui

 drivers/vfio/pci/virtio/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index 35fa2d6ed611..9fc24788fc04 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -621,7 +621,7 @@ virtiovf_read_device_context_chunk(struct virtiovf_migration_file *migf,
 
 	buf->start_pos = buf->migf->max_pos;
 	migf->max_pos += buf->length;
-	spin_lock(&migf->list_lock);
+	spin_lock_irq(&migf->list_lock);
 	list_add_tail(&buf->buf_elm, &migf->buf_list);
 	spin_unlock_irq(&migf->list_lock);
 	return 0;
-- 
2.20.1

