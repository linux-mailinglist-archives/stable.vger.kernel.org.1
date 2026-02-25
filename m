Return-Path: <stable+bounces-218751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNapEBZVnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B295218FED7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A38CB311F85A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C9268690;
	Wed, 25 Feb 2026 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mroqL37w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAB1E2834;
	Wed, 25 Feb 2026 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983619; cv=none; b=CpATXOgECa4wKuGPs+XH3Gf+NVvaQ6rugJQY9ZjDWLeFp6wJCiGIdTjwQoqaPGcqn8I+L1k8IJ2W7LXgOGvEKuLWlKxNzYpkPjI0LT6Cj1dHm66RbLJP7N3PRmMMfirILUEltYLkNnm3zGi3E6oqZPQ3dHLJIGWl3njA4Cek9eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983619; c=relaxed/simple;
	bh=c/Niyh7Y89BXUusXTtKbgxDX9H1tTkcKRltKuq/ICZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvC7SCIsCKNA7cuxr6t9ZfN1o34GxExGZ/zhMrikMBJlB30ZGlPQ8YLncNQBNm3VXV3nqwxgptNZEzUDS+JIsyd2mcswtVtDs8SkT+GO2Db74kdwQou5dK8897xyrhox6ChCtruq3jo2x5dzgP5OKARSfRJj2JCvmzMxNYBIbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mroqL37w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D91C116D0;
	Wed, 25 Feb 2026 01:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983619;
	bh=c/Niyh7Y89BXUusXTtKbgxDX9H1tTkcKRltKuq/ICZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mroqL37wS2ht1VFGSNM0IQK9eY2HiOzE/jUavACFzDSUZQPcJdRWMHivu3MafY/fL
	 MIE6i4X0ROAV3trjcA6PRGEhdeg5wgt6svYa5Pn5H6mtSLbwg/FJtJurGpbLIVVqGT
	 1ECVEEG1D53stF5pq8OlgVX5SBV0ux4kPhT2LnDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li RongQing <lirongqing@baidu.com>,
	"Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 713/781] mshv: fix SRCU protection in irqfd resampler ack handler
Date: Tue, 24 Feb 2026 17:23:42 -0800
Message-ID: <20260225012417.233910107@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218751-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B295218FED7
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 2e7577cd5ddc1f86d1b6c48caf3cfa87dbb14e34 ]

Replace hlist_for_each_entry_rcu() with hlist_for_each_entry_srcu()
in mshv_irqfd_resampler_ack() to correctly handle SRCU-protected
linked list traversal.

The function uses SRCU (sleepable RCU) synchronization via
partition->pt_irq_srcu, but was incorrectly using the RCU variant
for list iteration. This could lead to race conditions when the
list is modified concurrently.

Also add srcu_read_lock_held() assertion as required by
hlist_for_each_entry_srcu() to ensure we're in the proper
read-side critical section.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/mshv_eventfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 0b75ff1edb735..6d176ed8ae516 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -87,8 +87,9 @@ static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
 
 	idx = srcu_read_lock(&partition->pt_irq_srcu);
 
-	hlist_for_each_entry_rcu(irqfd, &resampler->rsmplr_irqfd_list,
-				 irqfd_resampler_hnode) {
+	hlist_for_each_entry_srcu(irqfd, &resampler->rsmplr_irqfd_list,
+				 irqfd_resampler_hnode,
+				 srcu_read_lock_held(&partition->pt_irq_srcu)) {
 		if (hv_should_clear_interrupt(irqfd->irqfd_lapic_irq.lapic_control.interrupt_type))
 			hv_call_clear_virtual_interrupt(partition->pt_id);
 
-- 
2.51.0




