Return-Path: <stable+bounces-270051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r9YVNAg5RGoSqwoAu9opvQ
	(envelope-from <stable+bounces-270051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 23:45:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 337976E832B
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 23:45:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Rtp+SoEp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270051-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270051-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E929630D8B84
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9232FA1B;
	Tue, 30 Jun 2026 21:44:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69932470F;
	Tue, 30 Jun 2026 21:44:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855855; cv=none; b=MXLcEUc4ycBUyDauXrrtODelu+1ufSqpZYY1AwqgzEVUjwVvWjCLoaLLVbNS0N7AftcKO9R5U35XQ37YsPqdbHtq95ofzteCAvxvtq7qdqjZxwg0lsT3SDyKtTUnR/GNyZ4WRoyppoyY5kyG3P1GXtakBQJ34WL1OyxVKitk1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855855; c=relaxed/simple;
	bh=G/PLgmaK3kxxzBp27zaYyBgT8fvnJmd2/em1RlD7Tdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTrEZlkFI0w1dfWjq1yUV9dEYRxyFJy8JCtvJBlMeRwxSDFhS3r0vdXfezr9RRTZKnuT9KedaDd7WvqGkAx9qfouWlBj+XvozzWDzNwrnRBSSGUvAj9MRJ3bBFEPec04vQ2GdLmrY19IRUykrK0gusdXCWHbU27jFC+CWySDYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rtp+SoEp; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782855854; x=1814391854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G/PLgmaK3kxxzBp27zaYyBgT8fvnJmd2/em1RlD7Tdo=;
  b=Rtp+SoEpmKW+4yLIINS2TaQniJBa+fL00qS/AVZIqbb8EDRnnn5h+31v
   Sd1fti5Jr2wtuOZyA9qKl65YcQ1ZM6XgK87iw7R4TdSvBrAxl/8YfFdSv
   yzgcMh8JI6NCCfHalzwUMtbGfSmCWg+Ly8rJEIPULLV+UY29N/VdxZ7Vk
   TwXQOpH5URI9dx5ckwbVXkU72BPTZt3lZ9Ymgog+1v8HolYUmFdzalHVg
   xODfEZFMqypcbfokdvXRdp0aZpyYHPqbc679DLkMsKJMO/oOOuqPPl2kR
   34TV7zrNdEtRCF31PM3vQM125MQJeZo+d8/oPb6xqBjDCMSiAFIJQU34V
   A==;
X-CSE-ConnectionGUID: spQO8sLyQmmZgZA/zk2pOQ==
X-CSE-MsgGUID: r8vg7g5QTyWgfqdPdR/P0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83637587"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83637587"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 14:44:12 -0700
X-CSE-ConnectionGUID: WlP11Wf/Rse5tBY0idnBrA==
X-CSE-MsgGUID: gfiMpvHgRaa6sDvbDyF3rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="254296595"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jun 2026 14:44:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	anthony.l.nguyen@intel.com,
	tatyana.e.nikolova@intel.com,
	joshua.a.hay@intel.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jakub Andrysiak <jakub.andrysiak@intel.com>
Subject: [PATCH net 3/4] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
Date: Tue, 30 Jun 2026 14:44:01 -0700
Message-ID: <20260630214404.930923-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
References: <20260630214404.930923-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270051-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:devnexen@gmail.com,m:anthony.l.nguyen@intel.com,m:tatyana.e.nikolova@intel.com,m:joshua.a.hay@intel.com,m:horms@kernel.org,m:stable@vger.kernel.org,m:aleksandr.loktionov@intel.com,m:jakub.andrysiak@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 337976E832B

From: David Carlier <devnexen@gmail.com>

idpf_idc_vport_dev_ctrl(adapter, false) clears vport->vdev_info->adev
to NULL but keeps vport->vdev_info itself. An MTU change after that
calls idpf_idc_vdev_mtu_event(), which dereferences vdev_info->adev for
device_lock() before reaching the (!adev || ...) check.

Cache vdev_info->adev once with READ_ONCE() and bail out if NULL before
locking. Use the cached pointer on both the lock and unlock paths so
the unlock matches the device actually acquired and cannot re-fetch a
NULL slot.

Fixes: ed6e1c8796a4 ("idpf: implement IDC vport aux driver MTU change handler")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Jakub Andrysiak <jakub.andrysiak@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b7d6b08fc89e..9f764135507c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 
 	set_bit(event_type, event.type);
 
-	device_lock(&vdev_info->adev->dev);
-	adev = vdev_info->adev;
-	if (!adev || !adev->dev.driver)
+	adev = READ_ONCE(vdev_info->adev);
+	if (!adev)
+		return;
+
+	device_lock(&adev->dev);
+	if (!adev->dev.driver)
 		goto unlock;
 	iadrv = container_of(adev->dev.driver,
 			     struct iidc_rdma_vport_auxiliary_drv,
@@ -172,7 +175,7 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
 	if (iadrv->event_handler)
 		iadrv->event_handler(vdev_info, &event);
 unlock:
-	device_unlock(&vdev_info->adev->dev);
+	device_unlock(&adev->dev);
 }
 
 /**
-- 
2.47.1


