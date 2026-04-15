Return-Path: <stable+bounces-238014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLZbEHr93mlINQAAu9opvQ
	(envelope-from <stable+bounces-238014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:52:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A63FFDA1
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33EE304B2A6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C73128C6;
	Wed, 15 Apr 2026 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="tBTq3uwi"
X-Original-To: stable@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0E313532
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221558; cv=none; b=VCrXUjXKwsC0G4iXNv13tlTijXhZeQM3rzE6SHRRZUpoxC+4qDMGpFObskSJ8AeG4hEgMvvaeobQpDsiD9XyM46P0KPPefuvifsMhcylDggz1KL9MPhE8Lve9JE24KimQl3wxIDI+hfu/rsVDU7c+2LKPSyMfuitWAKs/WmRuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221558; c=relaxed/simple;
	bh=haA4kYFbvqtiqFuCHUW5iCmkV1x3Oma+LWqgQLmvkUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pArS0yWPUPJNv1SrWv5+9pqgDh5774aSFakWwUs8LlckTp0REw3fMpeTLdsdTa7+T8T5IUYGyqvIBYZsTgEiol4OwSgaRumi8XFMKXg3srDgat5+87Hbb2Q2oIGg+9OXw4ouwBWyGHaipq+X1u15KYe7Mxj6ZUsNctXLqWNlMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=tBTq3uwi; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (92.192.13.160.dy.iij4u.or.jp [160.13.192.92])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63F2qSsp035194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Apr 2026 11:52:28 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=3+5pFTC9L4TcAgd/RnB8ZvQWCS/U/+fZRKbBPq/6RR8=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776221548; v=1;
        b=tBTq3uwiwD5z03dO8vqZL864WNI/kPy8x1eH0MmgDZvWKMwbMaoArTJhH5akHj6G
         h9MxXMI8bXFLK0LoRSQ2y2SG1CSrfoDeWBKqQ5/VuRdyxDXoAqOKWOb8u/UkoASl
         5egcH5Wzpcth3LEeVwSQNetM7QoUip/zexFeGD6UuyDEiae69wzl0FB6op7GRmnV
         zZIKS0lYc4SNbXwOhcpBqYw6rMH57ISlnWrH7YjWkSMeBtVs1xanAcKBGzdAUo5/
         W0LEIhjWVXIbd80x8mC1UGUPZITzlv9kxqVCvwqWv4DASI9i5VWMtO2J4t7wIgx5
         AKIyR5dHuxP2fz++0I7h7g==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>,
        stable@vger.kernel.org
Subject: [PATCH iwl-net v2] igc: fix potential skb leak in igc_fpe_xmit_smd_frame()
Date: Wed, 15 Apr 2026 02:52:18 +0000
Message-ID: <20260415025226.114115-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
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
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,gmail.com,enjuk.jp,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-238014-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid]
X-Rspamd-Queue-Id: 9B6A63FFDA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When igc_fpe_init_tx_descriptor() fails, no one takes care of an
allocated skb, leaking it. [1]
Use dev_kfree_skb_any() on failure.

Tested on an I226 adapter with the following command, while injecting
faults in igc_fpe_init_tx_descriptor() to trigger the error path.
 # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on

[1]
unreferenced object 0xffff888113c6cdc0 (size 224):
...
  backtrace (crc be3d3fda):
    kmem_cache_alloc_node_noprof+0x3b1/0x410
    __alloc_skb+0xde/0x830
    igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
    igc_fpe_send_mpacket+0x37/0x90
    ethtool_mmsv_verify_timer+0x15e/0x300

Cc: stable@vger.kernel.org
Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
Changes:
  v2:
    - change to idiomatic style with goto (Simon)
    - add Cc to stable (Alex)
    - add reprodunction steps (Alex)
  v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 8a110145bfee..02dd9f0290a3 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -109,10 +109,16 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
 	__netif_tx_lock(nq, cpu);
 
 	err = igc_fpe_init_tx_descriptor(ring, skb, type);
-	igc_flush_tx_descriptors(ring);
+	if (err)
+		goto err_free_skb_any;
 
+	igc_flush_tx_descriptors(ring);
 	__netif_tx_unlock(nq);
+	return 0;
 
+err_free_skb_any:
+	__netif_tx_unlock(nq);
+	dev_kfree_skb_any(skb);
 	return err;
 }
 
-- 
2.51.0


