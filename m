Return-Path: <stable+bounces-246047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECvHOc1rA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33693526B1B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 563EB30A6A36
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BDA3BB115;
	Tue, 12 May 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWjMIh4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69743955DC;
	Tue, 12 May 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608222; cv=none; b=SlrCEOhy0jHCgzT4yAvwP4/Tbv5z1wRIZk9TpZH4ILN4TQLaKYi+XCQgsqXDsUenFL78V8Y/Sp1b05VZQoZLMmM+Cz47Psr7t+FcsZ4UweFLpwhzo8QxAbWJ4KzRvw0Les5O8gX3aWS/Vhlqzo9haxgatEdt12A0p7QL0e3x0ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608222; c=relaxed/simple;
	bh=gqwqurhEIot5LbjwJ5XTTkDAMzNtI7kLIFuBGzfok88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d050Fjfe4NSvqxC7ev9tb8IW7jwjPJm/GaY9iQXLSXxhf9Bxe5cZK0trQxUwi2uXIzbTEdxdT5MhDrehJ2NdiUmAS5g/CteimM+b08tC2gtsfAvaN51ugS+wSYeHZpFSuAjoPU/+SXWt7LVD6oBEAKWzXPpoRTifKvTowTfx2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nWjMIh4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E936C2BCB0;
	Tue, 12 May 2026 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608221;
	bh=gqwqurhEIot5LbjwJ5XTTkDAMzNtI7kLIFuBGzfok88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWjMIh4nT8hi0bmtdSEwMKIsyTt1kM3qi20tEqD/6mOmQkWfi3R+155O2gsRI/b/C
	 AazcXwh7Of3mV46r+cPscReIf3KfvTgjLcnqnFx9AmVI68zwcmfU3HHANKrnqJ7mmG
	 FI0LXVRhKG5egpWCp7mdPWXRm3N+QYx8sVn7o+A4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <longli@microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.12 149/206] RDMA/mana: Fix mana_destroy_wq_obj() cleanup in mana_ib_create_qp_rss()
Date: Tue, 12 May 2026 19:40:01 +0200
Message-ID: <20260512173936.018113848@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 33693526B1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246047-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,nvidia.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit 34ecf795692ee57c393109f4a24ccc313091e137 upstream.

Sashiko points out there are two bugs here in the error unwind flow, both
related to how the WQ table is unwound.

First there is a double i-- on the first failure path due to the while loop
having a i--, remove it.

Second if mana_ib_install_cq_cb() fails then mana_create_wq_obj() is not
undone due to the above i--.

Cc: stable@vger.kernel.org
Fixes: c15d7802a424 ("RDMA/mana_ib: Add CQ interrupt support for RAW QP")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=1
Link: https://patch.msgid.link/r/6-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mana/qp.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -194,11 +194,8 @@ static int mana_ib_create_qp_rss(struct
 
 		ret = mana_create_wq_obj(mpc, mpc->port_handle, GDMA_RQ,
 					 &wq_spec, &cq_spec, &wq->rx_object);
-		if (ret) {
-			/* Do cleanup starting with index i-1 */
-			i--;
+		if (ret)
 			goto fail;
-		}
 
 		/* The GDMA regions are now owned by the WQ object */
 		wq->queue.gdma_region = GDMA_INVALID_DMA_REGION;
@@ -218,8 +215,10 @@ static int mana_ib_create_qp_rss(struct
 
 		/* Create CQ table entry */
 		ret = mana_ib_install_cq_cb(mdev, cq);
-		if (ret)
+		if (ret) {
+			mana_destroy_wq_obj(mpc, GDMA_RQ, wq->rx_object);
 			goto fail;
+		}
 	}
 	resp.num_entries = i;
 



