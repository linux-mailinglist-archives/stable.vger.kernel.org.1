Return-Path: <stable+bounces-274764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f76NN6xGV2rvIQEAu9opvQ
	(envelope-from <stable+bounces-274764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:37:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A37D75BF12
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:36:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=linux.dev header.s=key1 header.b=YgBrBjye;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274764-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274764-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=linux.dev (policy=none);
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1E93015706
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2033CBE9C;
	Wed, 15 Jul 2026 08:27:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA843C553B
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 08:27:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104057; cv=none; b=UxVofIdgAUPEPOMhKt4VRGftkgFn9SKm+QJMUHoi0jiNNBQ/SZRvSP4sP2sLmyk1+zTfn49xa1JnuH3c8QsggpiJpZHOsOBzQe1UOXCVBciyMPFdv5IfueafmGd+8fMn5bW0cxS2HW+o8GrEZbpKmgDtX3IT8zGK5qDrB1G1bng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104057; c=relaxed/simple;
	bh=nKd84V/9X2y89yu7OGQCN/8khagFxgbbCnrIv34xDZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D64iqurvEkmQ3WAUVQcWbwKHxZ5bMuDuu1EgSvtFDCb7FOXQySCTniGmaaCRbX5qHkOCLbZWgFZJMnDCEkzykDQN2MZMuh33szKuQcn7d9OBoBEdtF8AXNlAY3GNsiDGzBgYmKi30MheJYL0QhStECes0/yqmRQ2USE+mBfXq8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YgBrBjye; arc=none smtp.client-ip=95.215.58.183
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784104054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5zxSO+IiC/aaC3ze1Xp0Plh4QW43E7b/Q2x8rCpqKQ=;
	b=YgBrBjyeXwATe4y8fj92081fvgvxwEYXr5EgJazBct+C6+8lAewYvYoAXJOWa/67RO1E/U
	XFHtLTq6c95SQaNnMdqNiwrd7TG9YAN2c/pGTWMNny0zwJGHuQVSxDY7W0hbi/F9rUxk6l
	c5rGR08p01eKodOsqpIxEG1JJJJVg8M=
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jagielski@web.codeaurora.org, Jedrzej <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2 2/2] iavf: fix QoS capabilities memory leak
Date: Wed, 15 Jul 2026 16:25:48 +0800
Message-ID: <20260715082548.56687-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[linux.dev:s=key1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.dev : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:Jagielski@web.codeaurora.org,m:jedrzej.jagielski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:andrew+netdev@lunn.ch,m:mitch.a.williams@intel.com,m:gregory.v.rose@intel.com,m:sudheer.mogilappagari@intel.com,m:netdev@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274764-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A37D75BF12

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Commit 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
allocates adapter->qos_caps during probe, but iavf_remove() does not
free it. This leaks the allocation whenever an iavf device is removed.

Free adapter->qos_caps in iavf_remove().

Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
Cc: stable@vger.kernel.org
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403a066bc..c7f69a9040588 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5589,6 +5589,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
 	kfree(adapter->vf_res);
+	kfree(adapter->qos_caps);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
 	 * hanging out there that we need to get rid of.
-- 
2.43.0


