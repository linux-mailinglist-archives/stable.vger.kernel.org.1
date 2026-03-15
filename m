Return-Path: <stable+bounces-225471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAjdEOC/tmkWHwEAu9opvQ
	(envelope-from <stable+bounces-225471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:19:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 230CF290F7B
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E567D3015115
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 14:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B825C366DA1;
	Sun, 15 Mar 2026 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openresty.com header.i=@openresty.com header.b="KzoB8J6b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00136605C
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584305; cv=none; b=gw5RkscjzCU5fI/gki0+IRcNEaiAOmtLMu1rFrLOS7aOvAhLB6W5qilrtCGWNGQ9qHhsqx2EVhvkISj9nGsqkrsP8bw1JFAgUYcHMhrtrB3DD7uoUEi9W3WcD/uMc0kOhPBO/vPkoz7UpPmQCei1lapWpF4ydZ0xs2uhTeRdgdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584305; c=relaxed/simple;
	bh=Y8fUBbvyzMQviIAW9sd4PkX24w/Vd0VYkVpKNberqqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LrmBWOzeMh3TovSii8KH8Eqpnm9MRHU7M8118iphw9u7L72to52/t++tStzUmB46Epr7D3iLs6i7XdvHyGThOZtOwP3jiuBiGJATirP0lDAFX9ys3JlsnPF51G4EFcpnQ6hO8npuYs86jdGVzfrvEXSEHpQQ+DOOFh6pb0DhFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openresty.com; spf=pass smtp.mailfrom=openresty.com; dkim=pass (2048-bit key) header.d=openresty.com header.i=@openresty.com header.b=KzoB8J6b; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openresty.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openresty.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829759ca646so2210062b3a.2
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openresty.com; s=google; t=1773584303; x=1774189103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEVg49IYI7HJLp/yxY4lgc89fYbkbBOZ6L8Tars9Cg=;
        b=KzoB8J6blozUzsEDo8eXBOEtawkea/XAev3d4QP0R9SwFhQRSmYNLSvQXiWPzIL39D
         trSaNuqMKDtwBuQSeM/XGObATfMZyXDW8u5fkxzpofr2w2TX/BUMCzQSNlod5qlYRDfc
         8P+GOP4NXFtxIVF5Gnay1V3I4w/5C6MbQ5yZbg+R/Dsgwdd1GBcLqFQ6X/tU1sxsUmCC
         z1loUkd8G2LIweijsQP2DQaQiyAtbxDU7Uq5jQt01wn0pZ3BpC6HsvRoEBHyArGQFyD2
         CHe4QJvJ/lt4PZHtqNLu/7AKfllupfFPatn7+KrveXJGfSmS7SNh7GFkwuoy/zd3bnen
         tUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584303; x=1774189103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnEVg49IYI7HJLp/yxY4lgc89fYbkbBOZ6L8Tars9Cg=;
        b=KHtiIfARXeKSzu+QQi081Gj0jPrk/hhXzeA5nEWTX5oEWcZT2/KjBBoFN1uT76XNJh
         8TLPg495N4ZwMuGLbDRTxZUor0/b1PL3pVQWXWtlS4LjcBcmKPyy0X3SydwRO1RL5Cy3
         9dx7PFc3Ny4tuWf30u4CpS20miJvSO30ic+SCjrzKG5ZYrEhZMY8uUb7X20jdQdTmkfb
         hirFzLTSpzTexRRyGZCpwnYh9dLbliNCa8DI7Z0hhMwCsnFUfx4/JATjbW5CyL2wrFy8
         UURc8deQ6xSrQxtq6yRZPLEsjgWyG25VJ+YyI6iTEaxfmPdzelN2yz+MnyYNmY6a8bGo
         qHHw==
X-Forwarded-Encrypted: i=1; AJvYcCWaP3hTegit+MtNzCQ0VMabMWENkljPBr6fwSyZzUbs3HSF8s5p7UQVmq0tMT3jcEPZyYuTTW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75errQUSP9i8naGTMQ6ZJGspLQrWOuruGzQkVZOE5yiEZQ999
	+cPxKuKgo1xzqF2S+VzDIEaEStQHISBUdK7qepakk/tlvkwMp/eN2apxNeSuzDldyNs=
X-Gm-Gg: ATEYQzz6wNgjvNMTRnl9wRlxIY0eLkziBizpOfLo6u4BlkwXUIr6gsAS39fDOULZPVh
	+1X8zbrzoGTJHzJKkQovh2hs2P7yxgU5owWbAfRVAbxZA7B7KW1ppqDAXRrV/wMUGIxMfsDojQ0
	fUMigYaVW+R5/AQH8Vyr5a3uaLQVmGHxjbbwbVl744mMLRG88ofdqmm6tyEIAB0iUg68zcGky3y
	OhWF/MGB5vS7myFTFW2gp81l4TLRGh3Ne4s+Txca3eUVzZZgtqXUH+aORBTO9Z/8U1b3hflDCsc
	RcNE0lQIozP14Xx2rYnnYkw/G8m91wdFt3KFEbw94uNKyRej9BtRSIqoh6/o6Ydn71MXF1/eG4X
	aZfuC8YXgweLVMNU4krPyyMG6OH6FzIGDH1JUbVrhhnPDksVsQLMyK4Gw/2F3QJU3UZm77Kr5YU
	PG3T3ZICjFZVyX1Rco5HHUbMFiC/3l5jaBRrQV0cTLNS3G0hU=
X-Received: by 2002:a05:6a00:4196:b0:82a:ea3:c172 with SMTP id d2e1a72fcca58-82a198f68f3mr8174011b3a.46.1773584303210;
        Sun, 15 Mar 2026 07:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:8780:1329:fe1:ca3e:1abc:522f:35d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725e0cdsm10871428b3a.16.2026.03.15.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:18:22 -0700 (PDT)
From: Ammar Faizi <ammarfaizi2@openresty.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Ammar Faizi <ammarfaizi2@openresty.com>,
	Yichun Zhang <yichun@openresty.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Yuka <yuka@umeyashiki.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	gwml@gnuweeb.org,
	stable@vger.kernel.org
Subject: [PATCH] virtio_pci: fix vq info pointer lookup via wrong index
Date: Sun, 15 Mar 2026 21:18:08 +0700
Message-Id: <20260315141808.547081-1-ammarfaizi2@openresty.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openresty.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[openresty.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[openresty.com,nvidia.com,umeyashiki.org,kernel.org,gmail.com,google.com,resnulli.us,lists.linux.dev,vger.kernel.org,gnuweeb.org];
	TAGGED_FROM(0.00)[bounces-225471-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	URIBL_MULTI_FAIL(0.00)[nvidia.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ammarfaizi2@openresty.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[openresty.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,lkml];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,openresty.com:dkim,openresty.com:email,openresty.com:mid,nvidia.com:email,umeyashiki.org:email]
X-Rspamd-Queue-Id: 230CF290F7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unbinding a virtio balloon device:

    echo virtio0 > /sys/bus/virtio/drivers/virtio_balloon/unbind

triggers a NULL pointer dereference. The dmesg says:

    BUG: kernel NULL pointer dereference, address: 0000000000000008
    [...]
    RIP: 0010:__list_del_entry_valid_or_report+0x5/0xf0
    Call Trace:
    <TASK>
    vp_del_vqs+0x121/0x230
    remove_common+0x135/0x150
    virtballoon_remove+0xee/0x100
    virtio_dev_remove+0x3b/0x80
    device_release_driver_internal+0x187/0x2c0
    unbind_store+0xb9/0xe0
    kernfs_fop_write_iter.llvm.11660790530567441834+0xf6/0x180
    vfs_write+0x2a9/0x3b0
    ksys_write+0x5c/0xd0
    do_syscall_64+0x54/0x230
    entry_SYSCALL_64_after_hwframe+0x29/0x31
    [...]
    </TASK>

The virtio_balloon device registers 5 queues (inflate, deflate, stats,
free_page, reporting) but only the first two are unconditional. The
stats, free_page and reporting queues are each conditional on their
respective feature bits. When any of these features are absent, the
corresponding vqs_info entry has name == NULL, creating holes in the
array.

The root cause is an indexing mismatch introduced when vq info storage
was changed to be passed as an argument. vp_find_vqs_msix() and
vp_find_vqs_intx() store the info pointer at vp_dev->vqs[i], where 'i'
is the caller's sparse array index. However, the virtqueue itself gets
vq->index assigned from queue_idx, a dense index that skips NULL
entries. When holes exist, 'i' and queue_idx diverge. Later,
vp_del_vqs() looks up info via vp_dev->vqs[vq->index] using the dense
index into the sparsely-populated array, and hits NULL.

Fix this by storing info at vp_dev->vqs[queue_idx] instead of
vp_dev->vqs[i], so the store index matches the lookup index
(vq->index). Apply the fix to both the MSIX and INTX paths.

Cc: Yichun Zhang <yichun@openresty.com>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: stable@vger.kernel.org # v6.11+
Tested-by: Yuka <yuka@umeyashiki.org>
Fixes: 89a1c435aec2 ("virtio_pci: pass vq info as an argument to vp_setup_vq()")
Signed-off-by: Ammar Faizi <ammarfaizi2@openresty.com>
---
 drivers/virtio/virtio_pci_common.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index da97b6a988de..164f480b18a6 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -414,28 +414,29 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors, desc);
 	if (err)
 		goto error_find;
 
 	vp_dev->per_vq_vectors = per_vq_vectors;
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
 		vqi = &vqs_info[i];
 		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx, vqi->callback,
 					     vqi->name, vqi->ctx, false,
 					     &allocated_vectors, vector_policy,
-					     &vp_dev->vqs[i]);
+					     &vp_dev->vqs[queue_idx]);
+		queue_idx++;
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
 	}
 
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
 	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
 				 avq->name, false, true, &allocated_vectors,
 				 vector_policy, &vp_dev->admin_vq.info);
@@ -476,27 +477,28 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	if (err)
 		goto out_del_vqs;
 
 	vp_dev->intx_enabled = 1;
 	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
 		struct virtqueue_info *vqi = &vqs_info[i];
 
 		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_setup_vq(vdev, queue_idx, vqi->callback,
 				     vqi->name, vqi->ctx,
-				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[i]);
+				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[queue_idx]);
+		queue_idx++;
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_del_vqs;
 		}
 	}
 
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
 	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
 			 false, VIRTIO_MSI_NO_VECTOR,
 			 &vp_dev->admin_vq.info);
-- 
Ammar Faizi


