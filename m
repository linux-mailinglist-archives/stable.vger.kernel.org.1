Return-Path: <stable+bounces-245807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF70M0o9A2oq2AEAu9opvQ
	(envelope-from <stable+bounces-245807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:46:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A07E522DB3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36E4A30AE3EB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173CB3CC30F;
	Tue, 12 May 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NBFy0jiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C83CB90B
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596627; cv=none; b=UgjeureZBAJeFxdAmotN8QozrUAJ35FX8WBHK2AwTpXFWnA9IAuR7jf3zBKiZlfkLVK22m3DP95TNTKJfNQrhpiBRBcjkzoxNIckBZs1ErESP3H5DFxYjg/1BsKHgcLeK7uZ+e2eHaPKbrI4RzZ6uvP60tUnleq7iezAhk3Rztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596627; c=relaxed/simple;
	bh=4m/emz5raelQ8BsJNGdhWY763eVtnwUqFiVbh8VbN+I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XTkg2mnSj7o3X7dYmxmjP1d0uBbnDkS10oAFtxLacIQfL270TuzX6wRInOzTq/S85pbZ/UptrCBY9G9Y+/xlTBam2Hd45ZCi12W98T3hiqOJ0jr0hPJDix8eFj/MdhTHZ0tzFNclFIwwl/aAh7OI4/8+sDu9MRsh8ldag38lom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NBFy0jiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFF4C2BCB0;
	Tue, 12 May 2026 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778596627;
	bh=4m/emz5raelQ8BsJNGdhWY763eVtnwUqFiVbh8VbN+I=;
	h=Subject:To:Cc:From:Date:From;
	b=NBFy0jiLg3ycRNHTuJSKEehaXwU//G0E14ohVzUMpcFF3rMMWzRePQ8VhOkbflFpL
	 jFo+dcu+vCXC0LoELd8T0ee53kyrpaIN2OtmdY7DTbyBWgPaCxLj5c4LJbKLiX3DLD
	 s0piVUIth1SfH9I8b4jEwFj8jqBh1clqIkoCDPUk=
Subject: FAILED: patch "[PATCH] RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()" failed to apply to 6.6-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com,longli@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:30:32 +0200
Message-ID: <2026051232-unwilling-overhear-52b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A07E522DB3
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-245807-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,nvidia.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,ziepe.ca:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6aaa978c6b6218cfac15fe1dab17c76fe229ce3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051232-unwilling-overhear-52b1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6aaa978c6b6218cfac15fe1dab17c76fe229ce3f Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 28 Apr 2026 13:17:40 -0300
Subject: [PATCH] RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()

Sashiko points out that mana_ib_cfg_vport_steering() is leaked, the normal
destroy path cleans it up.

Cc: stable@vger.kernel.org
Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Link: https://patch.msgid.link/r/7-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index 8e1f052d0ec9..0fbcf449c134 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -217,13 +217,15 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
 		ibdev_dbg(&mdev->ib_dev,
 			  "Failed to copy to udata create rss-qp, %d\n",
 			  ret);
-		goto fail;
+		goto err_disable_vport_rx;
 	}
 
 	kfree(mana_ind_table);
 
 	return 0;
 
+err_disable_vport_rx:
+	mana_disable_vport_rx(mpc);
 fail:
 	while (i-- > 0) {
 		ibwq = ind_tbl->ind_tbl[i];


