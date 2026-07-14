Return-Path: <stable+bounces-274161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6FgfHQvaVWppuQAAu9opvQ
	(envelope-from <stable+bounces-274161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:41:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B985C751947
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 08:41:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=pd9eBGIO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274161-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274161-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EBD7302351E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEB63DB310;
	Tue, 14 Jul 2026 06:41:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F299DF76
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:41:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011272; cv=none; b=XWfRQw+iG4S0tzMGIiHWNnw42coij1SYXu8gjFCn97WRPN5Uiqabo6eGuJMqHtdfj+4lmUG9QnOvLEJPb4tWc678WchNR0zX3HfnQogv4eR8vTU9kQFcGxfqocjzFcemnPeL37vt52AofPL59xgM2gnCUq2FnMMj2fJe+IiFVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011272; c=relaxed/simple;
	bh=6lyQRXk18+WT1H4J1CXUAaPIS2gpTnwnEN3m9wrS7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpFlLuQS+G3TTWQXIosiVQlLfjlUSNxJ7Kh62QjSCS1mjFZIhv9d7OVSDeMw015bJ9Rj7/m5z/Dj7liKorFadSkI7tbrL1C3x5cAEhp709eLNRwZQqzyAVWTM9kQP+OkJhgWNS36D7aVwkXCd+X1Uio2crQC7zsRGXbibYlhnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pd9eBGIO; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784011269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9x4DvNuH+C01RfbWzeGiOhrWxg912eJrBFFwtdhEQP8=;
	b=pd9eBGIOrIfwNQ6qzTN6LRyVyiIqOBiW8O3vTY2F64eYmxRBU7Ayr/UIFH11UL2NzRrPVc
	KdX49WQjcJHPPKxSlraoRAqBegvJ/+cXgZNWDQf9bfVBYAaMLEuRUiJOs4RDyGIZVlQ79J
	aZQQH+6f+AoBUq50qOcJS+e1taCGKIw=
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com,
	piotr.raczynski@intel.com,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v1] ice: fix use-after-free in dynamic port cleanup
Date: Tue, 14 Jul 2026 14:39:37 +0800
Message-ID: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274161-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:sridhar.samudrala@intel.com,m:wojciech.drewek@intel.com,m:piotr.raczynski@intel.com,m:michal.swiatkowski@linux.intel.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B985C751947

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
port from pf->dyn_ports. However, it frees the VSI before reading the
index for the erase, resulting in a use-after-free.

Follow the reverse of the allocation order in ice_alloc_dynamic_port()
by erasing the xarray entry before freeing the VSI.

Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
index 2a2e56777f9f7..3ede246490027 100644
--- a/drivers/net/ethernet/intel/ice/devlink/port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
 	ice_eswitch_detach_sf(pf, dyn_port);
-	ice_vsi_free(dyn_port->vsi);
 	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
+	ice_vsi_free(dyn_port->vsi);
 	kfree(dyn_port);
 }
 
-- 
2.43.0


