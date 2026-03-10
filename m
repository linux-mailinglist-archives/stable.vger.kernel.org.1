Return-Path: <stable+bounces-224350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ARlGlUDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:41:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA0924B4C6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C46FD30D51DB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05D740F8DD;
	Tue, 10 Mar 2026 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdnY350o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311B388364;
	Tue, 10 Mar 2026 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142043; cv=none; b=aOhO2nqA7Vk/iHitvml33aTDdR1JFDtUBtyyQ0f0hSvxfACa7tJDKFLu/B6TRMwnJR9oWCPBqgidhkkW6IHcKlPZXE+XeOaHjhMnCOs8w4KV/Z3nP7sI638UYhO+85/1lmOGdOunPUsKn2zY811/CvYaJIKSuHd+q41A/4BityU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142043; c=relaxed/simple;
	bh=Pn5BGJbcgfzC6g35oA/yN9XarwmBoWfno7+j+YQGA/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCSy3BvDZA6VtlWoBw2FWKiNxleVLKLuBFOuZ+npMGOT1b3tP8Xj5dHSX16/lFaibsySVlJQF0VYIuGRVJSNUb1O7vhJIUTKlwWDZfZcF5CW/k9PsxTLCRQzlMNaOI7trOyMjvDewRQXQwnokqyfK85E7MYlhYpHnOG6YzKVy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdnY350o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D391AC19423;
	Tue, 10 Mar 2026 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142043;
	bh=Pn5BGJbcgfzC6g35oA/yN9XarwmBoWfno7+j+YQGA/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdnY350oYzhGpnmmC9ngZi6JFebQrSS/V+EEQ7AOcAfmsmPKz/eeMm61rwfkhvLCX
	 GqjErBI83uzBClGNcKU7bNjo+qTWuxwzyjH0yLpxmVEBp6H7YubCQz3gv8jHfO+g18
	 m0VUfuazd+DWgq818jp/K3Lne537KAZhd48XycMiiVCylc6oAp0XDdXlAXSnkTPqAh
	 JdFOcVhEF3eUycuyhq7x2WVwkTldXhpTmS4NiyLkSuXQxiZmwTgBzun+/jVLZxMYFr
	 25ZGnYQ+ZUzomKXg/l6srcVYRTRc4uVnl8HbTnI4omzcueow4Eoi+3dswZcF6tWFWA
	 E7ZTrNcVenAww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 171/314] RDMA/ionic: Fix kernel stack leak in ionic_create_cq()
Date: Tue, 10 Mar 2026 07:17:10 -0400
Message-ID: <ec236cf1aca2dbac690a50f61f56f0f2d8078a00.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FA0924B4C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224350-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,amd.com:email,linuxfoundation.org:email,nvidia.com:email]
X-Rspamd-Action: no action

From: Jason Gunthorpe <jgg@nvidia.com>

commit faa72102b178c7ae6c6afea23879e7c84fc59b4e upstream.

struct ionic_cq_resp resp {
    __u32 cqid[2];         // offset 0 - PARTIALLY SET (see below)
    __u8  udma_mask;       // offset 8 - SET (resp.udma_mask = vcq->udma_mask)
    __u8  rsvd[7];         // offset 9 - NEVER SET <- LEAK
};

rsvd[7]: 7 bytes of stack memory leaked unconditionally.

cqid[2]: The loop at line 1256 iterates over udma_idx but skips indices
where !(vcq->udma_mask & BIT(udma_idx)). The array has 2 entries but
udma_count could be 1, meaning cqid[1] might never be written via
ionic_create_cq_common(). If udma_mask only has bit 0 set, cqid[1] (4
bytes) is also leaked. So potentially 11 bytes leaked.

Cc: stable@vger.kernel.org
Fixes: e8521822c733 ("RDMA/ionic: Register device ops for control path")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://patch.msgid.link/4-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com
Acked-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index ea12d9b8e125f..83573721af2c0 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -1218,7 +1218,7 @@ int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		rdma_udata_to_drv_context(udata, struct ionic_ctx, ibctx);
 	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
 	struct ionic_tbl_buf buf = {};
-	struct ionic_cq_resp resp;
+	struct ionic_cq_resp resp = {};
 	struct ionic_cq_req req;
 	int udma_idx = 0, rc;
 
-- 
2.51.0


