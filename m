Return-Path: <stable+bounces-240056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBJEMocl52nV4QEAu9opvQ
	(envelope-from <stable+bounces-240056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:21:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D94437761
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CA6302BA57
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191834753F;
	Tue, 21 Apr 2026 07:18:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [125.88.204.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5617DE36;
	Tue, 21 Apr 2026 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.88.204.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755935; cv=none; b=oiG7nMZrDAySafiRPp80Ad7GJRLX/uWJyu0QeXoNT+RJeaE1pCl6GQ7CzaqeP6R5ebafDWfKDFn0eb1N35d2nqSxY517qXcY2PriqUd+9YJmYp1duzyBeZryKAelKtBIpsNIsWEh5lwyGGpJ0NtpRCbq9DhPMxXFf9sPqq1dYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755935; c=relaxed/simple;
	bh=zb7gnNolOhgRvEvY+KVXH3ZcA+WgSzlM590cj3hH7Bc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aZu4CnF6b3tzF5xQnCTg9ufB2J58ltbmbD5pixBwY3HINNx+28h0Qxn4eOaXNx0BcyY5vBhHnWjMnb0Tbfrxod44rZHe99Q2D9hrvLzz34ZCCjIKcAEywCbFvUXx2SUL/Fg4rQDjc5xqk+f5k8H6x5q99UcZpmgbewYz4gj+xIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=125.88.204.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.1498820815
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-223.104.44.125 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 1AEB1400083;
	Tue, 21 Apr 2026 15:18:39 +0800 (CST)
Received: from  ([223.104.44.125])
	by gateway-153622-dep-76cc7bc9cd-r45x9 with ESMTP id 460328a3dd2645d881ad4c010de65c55 for tglx@kernel.org;
	Tue, 21 Apr 2026 15:18:42 CST
X-Transaction-ID: 460328a3dd2645d881ad4c010de65c55
X-Real-From: charles_xu@189.cn
X-Receive-IP: 223.104.44.125
X-MEDUSA-Status: 0
Sender: charles_xu@189.cn
From: charles_xu@189.cn
To: tglx@kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	joe@dama.to,
	aleksandr.loktionov@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] i40e: Fix preempt count leak in napi poll tracepoint
Date: Tue, 21 Apr 2026 15:18:38 +0800
Message-Id: <20260421071838.3878-1-charles_xu@189.cn>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[charles_xu@189.cn,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-240056-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[189.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[189.cn];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,189.cn:mid,189.cn:email]
X-Rspamd-Queue-Id: 27D94437761
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit 4b3d54a85bd37ebf2d9836f0d0de775c0ff21af9 ]

Using get_cpu() in the tracepoint assignment causes an obvious preempt
count leak because nothing invokes put_cpu() to undo it:

  softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?

This clearly has seen a lot of testing in the last 3+ years...

Use smp_processor_id() instead.

Fixes: 6d4d584a7ea8 ("i40e: Add i40e_napi_poll tracepoint")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Charles Xu <charles_xu@189.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index 33b4e30f5e00..9b735a9e2114 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -88,7 +88,7 @@ TRACE_EVENT(i40e_napi_poll,
 		__entry->rx_clean_complete = rx_clean_complete;
 		__entry->tx_clean_complete = tx_clean_complete;
 		__entry->irq_num = q->irq_num;
-		__entry->curr_cpu = get_cpu();
+		__entry->curr_cpu = smp_processor_id();
 		__assign_str(qname, q->name);
 		__assign_str(dev_name, napi->dev ? napi->dev->name : NO_DEV);
 		__assign_bitmask(irq_affinity, cpumask_bits(&q->affinity_mask),
-- 
2.35.3


