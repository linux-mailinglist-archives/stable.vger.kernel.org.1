Return-Path: <stable+bounces-236907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJS8Jucd3WlhaAkAu9opvQ
	(envelope-from <stable+bounces-236907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:46:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF483EFC0B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A12B307C4A3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76202F362B;
	Mon, 13 Apr 2026 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnVVr/CM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933229BD87;
	Mon, 13 Apr 2026 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098099; cv=none; b=gTNZk0dSU4P1JDhfH8Vhk4eZk/56JAXt2WZ31ZVx0eE4gzqg9CIMN77zxSYZnZomohwyNJc1uIGV+4rOvZ1Yvb/Ea+oMlAvuRQj9CNI31ixByfA/ef4Ef+GUAICW2IK4E9pCiaQx3xOPFv0pKZtexQUp6zKY5cXaudcYwvvmY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098099; c=relaxed/simple;
	bh=TjJe/6HQCXOCYlxRNQRrz2XRtAKfaE9Sio+sWsGM1VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5o/HC6ceX+/nuuDW27ZzxWgwbz4J35LzZ9YwO5fRkUufftTRO5b5B5nkV9ug9yV314QJg1uJg0j2bIA/qhTnTwS4u/DC5E3qX8K5dmrljePmRqYeja2L2qxD0gMfpQDvk5ZJXRhUBeeYUBu2P/RNUwCfCT9PvAaVxECqb1McDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnVVr/CM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4018FC2BCAF;
	Mon, 13 Apr 2026 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098099;
	bh=TjJe/6HQCXOCYlxRNQRrz2XRtAKfaE9Sio+sWsGM1VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wnVVr/CMwLXpo2hE8wgAWWGe+bPv3aIHIGUoEjcf0CouXGUG+jFEO6gRk7lZzMYA3
	 rn0u79RvYf/jfoy1G2FIzejZSNK4Pz45GDcLFShqCdBbqv0piD8bCfJ13YyCsMka58
	 AdLp7Vf29y7n+r37NCiRkr5ob+q1NLQgPkLJCouM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Lijun Pan <lijun.pan@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 393/570] dmaengine: idxd: Remove usage of the deprecated ida_simple_xx() API
Date: Mon, 13 Apr 2026 17:58:44 +0200
Message-ID: <20260413155845.196120684@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wanadoo.fr,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-236907-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email]
X-Rspamd-Queue-Id: 2AF483EFC0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 1075ee66a8c19bfa375b19c236fd6a22a867f138 ]

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. Sothis change allows one more device.

MINORMASK is ((1U << MINORBITS) - 1), so allowing MINORMASK as a maximum value
makes sense. It is also consistent with other "ida_.*MINORMASK" and
"ida_*MINOR()" usages.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Lijun Pan <lijun.pan@intel.com>
Link: https://lore.kernel.org/r/ac991f5f42112fa782a881d391d447529cbc4a23.1702967302.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: c311f5e92484 ("dmaengine: idxd: Fix freeing the allocated ida too late")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 033df43db0cec..8172c3f1f782e 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -46,7 +46,7 @@ static void idxd_cdev_dev_release(struct device *dev)
 	struct idxd_wq *wq = idxd_cdev->wq;
 
 	cdev_ctx = &ictx[wq->idxd->data->type];
-	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
+	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
 
@@ -260,7 +260,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 	cdev = &idxd_cdev->cdev;
 	dev = cdev_dev(idxd_cdev);
 	cdev_ctx = &ictx[wq->idxd->data->type];
-	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
+	minor = ida_alloc_max(&cdev_ctx->minor_ida, MINORMASK, GFP_KERNEL);
 	if (minor < 0) {
 		kfree(idxd_cdev);
 		return minor;
-- 
2.53.0




