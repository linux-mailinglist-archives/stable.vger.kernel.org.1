Return-Path: <stable+bounces-235941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLihECea3GkxUAkAu9opvQ
	(envelope-from <stable+bounces-235941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:24:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9393E82CB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32CCA3009F85
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA1392825;
	Mon, 13 Apr 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ULGSXsZe"
X-Original-To: stable@vger.kernel.org
Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005D3932C5
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065027; cv=none; b=TYK499UTSQLanj44v4HJNnyA0WS4Jeg71uvgEFErazwYFQbiTZ2OqeeylA8rYbW9buXK1uiL+4/pVCOOJAly5xserI0RHWI687CE3IJodNbvFWeB9BMUTMUn/XfK34pyZeSWzEXW8Pmeng+ZuySKxNozb0HJysqgiSMpaz+SK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065027; c=relaxed/simple;
	bh=0zZfHOOWFWw4+HC5cgC+7XSH/R0wjD1a138VWny+jHA=;
	h=Cc:From:Subject:Content-Type:To:Date:Message-Id:Mime-Version; b=Wfufbkyxsu+VUvZBcdCOr9LYEAUvhdMxnC5y1IkmNvo4G14PBXCFacXyqiZ0kH7uSrEUookhN3lf3EudGwdsch6MazThfO8JVidCZeN++d6wqr3jwaEUWy4EATlTpB142JUcc7KZfaLN5rJUiGo4FU81oLF7+U6/SBloLJE0bKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ULGSXsZe; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776065019; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=jP3ET5/NQK/iIZIBTGcvS9TsKHd5N6bf39hH0vZuuvw=;
 b=ULGSXsZeW6xQzUEpP1k8aHAryB5PWPQ6p4GKAaCNNrruM5qNpvWkFPfUN6CXUyRx89mU/R
 MCD0nNXzCgv8ejMYtcVv5TiLE+wYLTVmneMZgytg2Qhz/B7T/SEcXX0xNWln+SGe5I3Abx
 3UTRv1Fv+Wn7AFYT9uKk9lb9jeEeeaiM9MnqMOS2twn4Uzbu+RhUN43QiqXpR/azdKOuff
 9C82I28t0D0WB07YCyWpjoS9d9EfBFitRgLBqZyW4xiqaU4FMViRtW4BiJFBIs8G6l0xGr
 IQE2Kct7dkt1WgqQYkK1sqkV55mS4oAW6KvTLGxNUJV9CRAwlxX/t/cbRpEsEg==
Cc: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>, <stable@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave held in virtqueue_exec_admin_cmd()
X-Mailer: git-send-email 2.17.1
X-Lms-Return-Path: <lba+269dc99f9+728868+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	"Jason Wang" <jasowang@redhat.com>, 
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, 
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Jiri Pirko" <jiri@resnulli.us>
Date: Mon, 13 Apr 2026 15:22:49 +0800
Message-Id: <20260413072249.30433-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-235941-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF9393E82CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

virtqueue_exec_admin_cmd() holds admin_vq->lock with spin_lock_irqsave(),
which disables interrupts.  Using GFP_KERNEL inside this critical section
is unsafe because kmalloc() may sleep, leading to potential deadlocks or
scheduling violations.

Switch to GFP_ATOMIC to ensure the allocation is non-blocking.

Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 6d8ae2a6a8ca..db8e4f88b749 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -101,7 +101,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 		return -EIO;
 
 	spin_lock_irqsave(&admin_vq->lock, flags);
-	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
 			spin_unlock_irqrestore(&admin_vq->lock, flags);
-- 
2.20.1

