Return-Path: <stable+bounces-231795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEyxKNr7y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C636D4E5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A928B30F3D87
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321AF426EA0;
	Tue, 31 Mar 2026 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ocZ/LcdH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCA425CE1;
	Tue, 31 Mar 2026 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975089; cv=none; b=KMDdPhNrFZn/agCwlgyGPcXiw8fvdUJM7/nxCalk6J0tIhABdfr9mkoi7HGqGkoEmsd+xRsWFJldRduYsA2gZmDyUquhDZEX3u5HSyv99/qrEzScYLnZlK3wNF7gW5NOrlbG0KlOR63DNGQWHnBbhOZtbcx20/sPOYA8zj3t09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975089; c=relaxed/simple;
	bh=18wu+5D1y3uYqHZoOx6sC6OvfM7VBkzgPINw2qBkx24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvN+Kaq5SdGWoHxwBIziRUO3i3DV6NaH0Iiku7Q9Xs5bCliUI3jDsSdtsM5UvV2L8OoAuPjyC+2W+KibRUcRrlSkYvPnF6b+qLdTpt2sO2LjPRyGuigTWGT+QgED9jrX5l2Dy4MbjZHZ1yWMv/EirWzYDEWuUn+pR5DKl5buKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ocZ/LcdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC70C19423;
	Tue, 31 Mar 2026 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975088;
	bh=18wu+5D1y3uYqHZoOx6sC6OvfM7VBkzgPINw2qBkx24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocZ/LcdHwGR6bvEcKDR0PiACTjcImGTkrQhvo+UnudppEVjFYWS4WJdUGdohWgDHl
	 RfAxIKxcJRrc+9Ya1zvbg2r/4Ed4wsN6tvuA+QG5Bp0YE5Debu5C4JAi4TdDiGKRgJ
	 EtsIZ/XiOBNuBpJZvpSiZ90AVxx37omlJkm5NDWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 158/342] RDMA/irdma: Remove a NOP wait_event() in irdma_modify_qp_roce()
Date: Tue, 31 Mar 2026 18:19:51 +0200
Message-ID: <20260331161804.824087955@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231795-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 507C636D4E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

[ Upstream commit 5e8f0239731a83753473b7aa91bda67bbdff5053 ]

Remove a NOP wait_event() in irdma_modify_qp_roce() which is relevant
for iWARP and likely a copy and paste artifact for RoCEv2. The wait event
is for sending a reset on a TCP connection, after the reset has been
requested in irdma_modify_qp(), which occurs only in iWarp mode.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c34188e322085..ac3a8f3f95b7f 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1462,8 +1462,6 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				ctx_info->remote_atomics_en = true;
 	}
 
-	wait_event(iwqp->mod_qp_waitq, !atomic_read(&iwqp->hw_mod_qp_pend));
-
 	ibdev_dbg(&iwdev->ibdev,
 		  "VERBS: caller: %pS qp_id=%d to_ibqpstate=%d ibqpstate=%d irdma_qpstate=%d attr_mask=0x%x\n",
 		  __builtin_return_address(0), ibqp->qp_num, attr->qp_state,
-- 
2.53.0




