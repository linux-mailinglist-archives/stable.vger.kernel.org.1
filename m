Return-Path: <stable+bounces-234106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LJ+Niib1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:15:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B83C042E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95862300F1BE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B048F3D8917;
	Wed,  8 Apr 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KcUCIBKi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DBA3D8134;
	Wed,  8 Apr 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672000; cv=none; b=RY60iyrTdYRbdVEWyyUExsQBquOlK/J4VwOP605kqoK7uNW5W2He3Y/uZNaCJg/mfC3cuygJ1o8m3R2+RGvucoqryxoKcdJHM3O+ZYnUXzf4yQf+ppH8JBiupWFh2WYYOxZJ9ZwvctHSl9YoYRDD/hJiA9QlYMZWYRSEDG5UToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672000; c=relaxed/simple;
	bh=5TL52fJ8RaqjcEpVPv4w2nM0EzIcUBHxb63flmTSCH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkNKUc74ywF2gVbR/Nv1FChnuzA0nV2XU4VPurSz+IehkUmk8e7ICiPBRIkNdwPH9QAppACYggKUUvwpRXi9KVz46YliLvQGxLl6z4KF6AfkgeIUq1EV+UQ9XX5fyJxdXgZXfo7NfhmDodOTPn82W/+11/D+oWzsDr4RJ6i8rA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KcUCIBKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3BAC19421;
	Wed,  8 Apr 2026 18:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672000;
	bh=5TL52fJ8RaqjcEpVPv4w2nM0EzIcUBHxb63flmTSCH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcUCIBKiKJzrfQPPKzqKYGvuLqV9K48omdaZcQdYhCcfM2xyJGZN5mMHFAiCkJOB/
	 5dzIidZNXD2W1iRDJUTeG6mL4gu96VgPA0DqECMJF5amN6JQ5oOjwr4AGCxTYgwJS3
	 dUt2AxU9nUGz0xC4IJrh3qS1Nbzp1qfA5qviYYQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 123/312] dmaengine: idxd: Fix memory leak when a wq is reset
Date: Wed,  8 Apr 2026 20:00:40 +0200
Message-ID: <20260408175938.362048524@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234106-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 6A2B83C042E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit d9cfb5193a047a92a4d3c0e91ea4cc87c8f7c478 ]

idxd_wq_disable_cleanup() which is called from the reset path for a
workqueue, sets the wq type to NONE, which for other parts of the
driver mean that the wq is empty (all its resources were released).

Only set the wq type to NONE after its resources are released.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-8-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 188f6b8625f78..8b72e26640084 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -174,6 +174,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 	free_descs(wq);
 	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
 	sbitmap_queue_free(&wq->sbq);
+	wq->type = IDXD_WQT_NONE;
 }
 
 int idxd_wq_enable(struct idxd_wq *wq)
@@ -381,7 +382,6 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	lockdep_assert_held(&wq->wq_lock);
 	wq->state = IDXD_WQ_DISABLED;
 	memset(wq->wqcfg, 0, idxd->wqcfg_size);
-	wq->type = IDXD_WQT_NONE;
 	wq->threshold = 0;
 	wq->priority = 0;
 	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
@@ -1426,7 +1426,6 @@ void drv_disable_wq(struct idxd_wq *wq)
 	idxd_wq_reset(wq);
 	idxd_wq_free_resources(wq);
 	percpu_ref_exit(&wq->wq_active);
-	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
 
-- 
2.53.0




