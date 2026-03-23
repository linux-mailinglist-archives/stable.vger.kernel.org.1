Return-Path: <stable+bounces-229020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QESvCHFVwWlTSQQAu9opvQ
	(envelope-from <stable+bounces-229020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:00:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D032F59B9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A9AA3035EE6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC4D387599;
	Mon, 23 Mar 2026 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rp4uISwd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF791DE4E0;
	Mon, 23 Mar 2026 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277803; cv=none; b=LgEs8kEl2WHsZBzDAkVRAkgu+2EEBCeUcMbP2+Gqd4QdiVlbOcFn2T6b7rNMWJ0UH6ljsJ7eieDYgbticmNYlgsoS6coOzq9ddTVsiQsIKBa7MtD3JAVsgubHlvB50G93BQVODlTZyCb1+M2106+XM3m9ckNmZolJq4TOXXC3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277803; c=relaxed/simple;
	bh=WSQDUqbSv1cVh5P1+qT1KN1LcegKkU0YFwwH2WyBOUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftDUe3vJYcZvlrYk5qEHvpnIwFVqNNallrl4heh7F/HWv4faez/KdmY+hM+rMWTq0qqHQSOdhUOvMJNai5pDs+IjwTykNheJFXso4xDbnozCK1CGiDl2SFIVMaMZEit5hDR54XxR1T3Yay843HCP63tXR7o7DFgiedJ1TNikf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rp4uISwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1820DC4CEF7;
	Mon, 23 Mar 2026 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277803;
	bh=WSQDUqbSv1cVh5P1+qT1KN1LcegKkU0YFwwH2WyBOUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rp4uISwdEUk8fe3iEguysL/XhVKIbKWJzFGL6YPZOpjAkXCvnFSwPq9fto5ZCoxgA
	 xOj1Bhc3p5/Iyh9AMVua8Mn50NLnP5DAqu2ewb8TbQzYUHveWJvx95MURtX5cCEd7c
	 SdeDqcmWepCUmh4RJiXvjPjxsjvZsvaKNd4MvCug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.6 109/567] RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()
Date: Mon, 23 Mar 2026 14:40:29 +0100
Message-ID: <20260323134536.513695775@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229020-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E5D032F59B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit 74586c6da9ea222a61c98394f2fc0a604748438c upstream.

struct irdma_create_ah_resp {  // 8 bytes, no padding
    __u32 ah_id;               // offset 0 - SET (uresp.ah_id = ah->sc_ah.ah_info.ah_idx)
    __u8  rsvd[4];             // offset 4 - NEVER SET <- LEAK
};

rsvd[4]: 4 bytes of stack memory leaked unconditionally. Only ah_id is assigned before ib_respond_udata().

The reserved members of the structure were not zeroed.

Cc: stable@vger.kernel.org
Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://patch.msgid.link/3-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/irdma/verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4588,7 +4588,7 @@ static int irdma_create_user_ah(struct i
 #define IRDMA_CREATE_AH_MIN_RESP_LEN offsetofend(struct irdma_create_ah_resp, rsvd)
 	struct irdma_ah *ah = container_of(ibah, struct irdma_ah, ibah);
 	struct irdma_device *iwdev = to_iwdev(ibah->pd->device);
-	struct irdma_create_ah_resp uresp;
+	struct irdma_create_ah_resp uresp = {};
 	struct irdma_ah *parent_ah;
 	int err;
 



