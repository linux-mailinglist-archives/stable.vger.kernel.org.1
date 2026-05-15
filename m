Return-Path: <stable+bounces-248272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNJyDkZOB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:48:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E9553F10
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DC6E30DAB51
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1F03F44E6;
	Fri, 15 May 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfTeDzHO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419243C9896;
	Fri, 15 May 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861309; cv=none; b=FVebDFRBQv6yeMuAagXW6z9DQbQkX3oWnfsFepcfcaCEA1r6zXBPKHeJ9TSitUacLLiAYtfUCC8HiawXhHLkKX5Agkv2NPkI/IVQnGV12aa+joHTFG82YuuA2n0JYL6ncsoyAOaUmNf8+eG0wjRLP73S+b/YAmmV49pBWuni8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861309; c=relaxed/simple;
	bh=JSWdLCsp+3Z3mvVIuYtIAES+Tv1tMcVJdWlcXm5RDL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AF41OS7QA+EJt6zK3ZnCEUB6ZU6byqrzkPj661aPvhIEQoo0azR9LRg1pmMQwqEGDRUtmQnlAqy9jLxDkBkA7kicR4fy5Edn6jU1GJkGRj3ZQLU3KOXB3EMPs3AYft4cNQkLMjGbLK/ITZG9J1OegbnRMzvkZknDadu8Zkglqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfTeDzHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC69FC2BCB0;
	Fri, 15 May 2026 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861309;
	bh=JSWdLCsp+3Z3mvVIuYtIAES+Tv1tMcVJdWlcXm5RDL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfTeDzHOCyrpxWZnXHaJbnI1f76ry1bUoSX3bfdMscGtdf5JT8AI93YG+RxQUdtn0
	 NkK99gDgquQm0ViVsDdgY5MhA7Qdq2/WxYhHAMK1vh+en1MogmiUaMAq1viTJYK6yQ
	 /Lg4p9411oLcztD4mKNtd9qSefqUfHQMEI6/Q5v4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.6 278/474] RDMA/mlx5: Fix error path fall-through in mlx5_ib_dev_res_srq_init()
Date: Fri, 15 May 2026 17:46:27 +0200
Message-ID: <20260515154721.016349678@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 434E9553F10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248272-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

commit c488df06bd552bb8b6e14fa0cfd5ad986c6e9525 upstream.

mlx5_ib_dev_res_srq_init() allocates two SRQs, s0 and s1. When
ib_create_srq() fails for s1, the error branch destroys s0 but falls
through and unconditionally assigns the freed s0 and the ERR_PTR s1 to
devr->s0 and devr->s1.

This leads to several problems: the lock-free fast path checks
"if (devr->s1) return 0;" and treats the ERR_PTR as already initialised;
users in mlx5_ib_create_qp() dereference the freed SRQ or ERR_PTR via
to_msrq(devr->s0)->msrq.srqn; and mlx5_ib_dev_res_cleanup() dereferences
the ERR_PTR and double-frees s0 on teardown.

Fix by adding the same `goto unlock` in the s1 failure path.

Cc: stable@vger.kernel.org
Fixes: 5895e70f2e6e ("IB/mlx5: Allocate resources just before first QP/SRQ is created")
Link: https://patch.msgid.link/r/SYBPR01MB7881E1E0970268BD69C0BA75AF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2924,6 +2924,7 @@ int mlx5_ib_dev_res_srq_init(struct mlx5
 		ret = PTR_ERR(s1);
 		mlx5_ib_err(dev, "Couldn't create SRQ 1 for res init, err=%d\n", ret);
 		ib_destroy_srq(s0);
+		goto unlock;
 	}
 
 	devr->s0 = s0;



