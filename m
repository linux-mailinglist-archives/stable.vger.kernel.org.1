Return-Path: <stable+bounces-254832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD4QJ8cUGGrKbggAu9opvQ
	(envelope-from <stable+bounces-254832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:11:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 503385F043B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B00DB3013009
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B1C3783B5;
	Thu, 28 May 2026 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UIgtBDsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88967352005
	for <stable@vger.kernel.org>; Thu, 28 May 2026 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962751; cv=none; b=lHlGdL2/8mv+HuEkYs9xxxSYBXqRK+DOtrCDS+qXWSYIzokL60WbM2D3Lb8cJMQgl+SSf3XoAMKDSbFy31Nz4DQszMgS6co8Uh0W8SNU7Esr/EGCHeTqmQ6EKLuiEzqB9+6ZYkzWjHOREwCtjv+qtkjoPCx2os3ebEKv/YDqKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962751; c=relaxed/simple;
	bh=Xx0dtHq7IhR0idKYvPrUEMHtpOk3i0epGuCbpsSoIEY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hGu5psAOO/kMlRLH6868vLIz76ysms35BuLtPqGjktbpI38vKtrZq5/uW6phaPFrFnm/wYPT9eLvwJUXcy4DfwwujpOM/H8ZAgDHnitBik2SNjZiwqYIaaBjPkddDdDvWCbwygOdaLy+nW0nNFY7NYKgHgNsW8lvita5TGmF2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UIgtBDsM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED481F000E9;
	Thu, 28 May 2026 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962750;
	bh=Qgn6ZupZoX9yVVuyHHHK/ONYzbLD7OhU2k8S0XRegw8=;
	h=Subject:To:Cc:From:Date;
	b=UIgtBDsMRf2YlTOVSR1FgJ81mkm+T02XzLu8fGPGOT+ztySOm/gQJjy2oQlYn2k0+
	 bYh9VH5/ZiMyPzdDOxt92EyV0Wainb+XgmjiN6wY3uSzgbceeQnHUp6p0luCWr4vAr
	 lkJg5I2LegoHXyKuZMHtXvCsBB91WAqya2J8JIec=
Subject: FAILED: patch "[PATCH] octeontx2-pf: avoid double free of pool->stack on AQ init" failed to apply to 5.15-stable tree
To: dawei.feng@seu.edu.cn,horms@kernel.org,kuba@kernel.org,zilin@seu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 12:04:46 +0200
Message-ID: <2026052845-shush-commuting-ee9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254832-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,seu.edu.cn:email,linuxfoundation.org:dkim,gregkh:email,msgid.link:url]
X-Rspamd-Queue-Id: 503385F043B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9b244c242bec48b37e82b89787afd6a4c43457e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052845-shush-commuting-ee9c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b244c242bec48b37e82b89787afd6a4c43457e1 Mon Sep 17 00:00:00 2001
From: Dawei Feng <dawei.feng@seu.edu.cn>
Date: Fri, 15 May 2026 23:18:26 +0800
Subject: [PATCH] octeontx2-pf: avoid double free of pool->stack on AQ init
 failure

otx2_pool_aq_init() frees pool->stack when mailbox sync or retry
allocation fails, but leaves the pointer unchanged. Later,
otx2_sq_aura_pool_init() unwinds the partial setup through
otx2_aura_pool_free(), which frees pool->stack again. The CN20K-specific
cn20k_pool_aq_init() implementation has the same bug in
its corresponding error path.

Set pool->stack to NULL immediately after the local free so the shared
cleanup path does not free the same stack again while cleaning up
partially initialized pool state.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc3.

Runtime validation was not performed because reproducing this path
requires OcteonTX2/CN20K hardware.

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Fixes: d322fbd17203 ("octeontx2-pf: Initialize cn20k specific aura and pool contexts")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260515151826.1005397-1-dawei.feng@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index a5a8f4558717..dbf173196608 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -619,11 +619,13 @@ static int cn20k_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 		err = otx2_sync_mbox_msg(&pfvf->mbox);
 		if (err) {
 			qmem_free(pfvf->dev, pool->stack);
+			pool->stack = NULL;
 			return err;
 		}
 		aq = otx2_mbox_alloc_msg_npa_cn20k_aq_enq(&pfvf->mbox);
 		if (!aq) {
 			qmem_free(pfvf->dev, pool->stack);
+			pool->stack = NULL;
 			return -ENOMEM;
 		}
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 971fcab1c248..3d253132a17f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1482,11 +1482,13 @@ int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 		err = otx2_sync_mbox_msg(&pfvf->mbox);
 		if (err) {
 			qmem_free(pfvf->dev, pool->stack);
+			pool->stack = NULL;
 			return err;
 		}
 		aq = otx2_mbox_alloc_msg_npa_aq_enq(&pfvf->mbox);
 		if (!aq) {
 			qmem_free(pfvf->dev, pool->stack);
+			pool->stack = NULL;
 			return -ENOMEM;
 		}
 	}


