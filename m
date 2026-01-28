Return-Path: <stable+bounces-212022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG42JLIremnz3gEAu9opvQ
	(envelope-from <stable+bounces-212022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:30:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72472A3E24
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C69283017245
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E0E36C0B9;
	Wed, 28 Jan 2026 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o70vQZh3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E410218592;
	Wed, 28 Jan 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614138; cv=none; b=Vgyo419YOT8HRZU9o1ekTDmOFj9Lp4SmQZ59rvb/qfKrkWTa2OyKlaQpgSXy1O7IkO07WDsjE+qG9JWckYkVcEuJa8Y2x700DbD0YcXbKj9otBjvQcK015JM34aJSt6Hiveh8NWILWpMnCh4sWdbXI5qeka8FOT6JXVtk64wOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614138; c=relaxed/simple;
	bh=czq14PS591YnJZC6piXbIPoeJp6ZSD2aDOTi30Lk5CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+I7Vo7F3zKk4xo88xoBRNjywRoQRhwWOjuTl39KsUEC/+5s1xgx7yPSGu7ZzoAiwADNZqW31ANPRPKZMweHQ2SRCbU5Sj3J3Km2xPodFTQxBWDFsKf9EsvNiucl9np4C2W8JPvF6uN9bGdQMJ09uEjGCh+koSNpnkGEKU96x1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o70vQZh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC84C16AAE;
	Wed, 28 Jan 2026 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614137;
	bh=czq14PS591YnJZC6piXbIPoeJp6ZSD2aDOTi30Lk5CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o70vQZh3Zd23RDR87IPjPkr7qA5jPjA7hQ7cLLRYWVioku2+4vUfYObCEKz3WuSYJ
	 JUC2steeIh56/2aLdECaL2pU4ux7bcYtt4IBsrVs85Lrlo/SbUvgmfLEyML5PD7vCj
	 DD3tgCuKfkRVTscRrytHK9RuJP0QSyfmLv+ODvDM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 047/254] null_blk: fix kmemleak by releasing references to fault configfs items
Date: Wed, 28 Jan 2026 16:20:23 +0100
Message-ID: <20260128145346.395220249@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[kernel.dk:query timed out];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-212022-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[kch.nvidia.com:server fail,axboe.kernel.dk:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nvidia.com:email,kernel.dk:email]
X-Rspamd-Queue-Id: 72472A3E24
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nilay Shroff <nilay@linux.ibm.com>

commit 40b94ec7edbbb867c4e26a1a43d2b898f04b93c5 upstream.

When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, the null-blk
driver sets up fault injection support by creating the timeout_inject,
requeue_inject, and init_hctx_fault_inject configfs items as children
of the top-level nullbX configfs group.

However, when the nullbX device is removed, the references taken to
these fault-config configfs items are not released. As a result,
kmemleak reports a memory leak, for example:

unreferenced object 0xc00000021ff25c40 (size 32):
  comm "mkdir", pid 10665, jiffies 4322121578
  hex dump (first 32 bytes):
    69 6e 69 74 5f 68 63 74 78 5f 66 61 75 6c 74 5f  init_hctx_fault_
    69 6e 6a 65 63 74 00 88 00 00 00 00 00 00 00 00  inject..........
  backtrace (crc 1a018c86):
    __kmalloc_node_track_caller_noprof+0x494/0xbd8
    kvasprintf+0x74/0xf4
    config_item_set_name+0xf0/0x104
    config_group_init_type_name+0x48/0xfc
    fault_config_init+0x48/0xf0
    0xc0080000180559e4
    configfs_mkdir+0x304/0x814
    vfs_mkdir+0x49c/0x604
    do_mkdirat+0x314/0x3d0
    sys_mkdir+0xa0/0xd8
    system_call_exception+0x1b0/0x4f0
    system_call_vectored_common+0x15c/0x2ec

Fix this by explicitly releasing the references to the fault-config
configfs items when dropping the reference to the top-level nullbX
configfs group.

Cc: stable@vger.kernel.org
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Fixes: bb4c19e030f4 ("block: null_blk: make fault-injection dynamically configurable per device")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/null_blk/main.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -622,12 +622,22 @@ static void nullb_add_fault_config(struc
 	configfs_add_default_group(&dev->init_hctx_fault_config.group, &dev->group);
 }
 
+static void nullb_del_fault_config(struct nullb_device *dev)
+{
+	config_item_put(&dev->init_hctx_fault_config.group.cg_item);
+	config_item_put(&dev->requeue_config.group.cg_item);
+	config_item_put(&dev->timeout_config.group.cg_item);
+}
+
 #else
 
 static void nullb_add_fault_config(struct nullb_device *dev)
 {
 }
 
+static void nullb_del_fault_config(struct nullb_device *dev)
+{
+}
 #endif
 
 static struct
@@ -659,7 +669,7 @@ nullb_group_drop_item(struct config_grou
 		null_del_dev(dev->nullb);
 		mutex_unlock(&lock);
 	}
-
+	nullb_del_fault_config(dev);
 	config_item_put(item);
 }
 



