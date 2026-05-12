Return-Path: <stable+bounces-246558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBLAJ/10A2oV6AEAu9opvQ
	(envelope-from <stable+bounces-246558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:44:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180A5280A2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5599F32C4C28
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276FB366831;
	Tue, 12 May 2026 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o3DDluCU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9A3EDE57;
	Tue, 12 May 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609535; cv=none; b=HgpbhNKqXr036uYbrA6hjoN1T7e1SkT1qx8McrWOL6FLAHpuY41Nrj8uKu8Ya32tA5Px+JZxx+iW6DXoxR1JKhTm3EZj/wAYAnZzWPLjYGHWpqYAFqxPhegyv+8N8Da8FV3cUEZdhK9LN6CAx07WO4F0IqinQvQ02LFBvoNeBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609535; c=relaxed/simple;
	bh=lwbNDNk911T8nGL8M6OMeFRhs7gDx1DUdM7shVyyMaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VChpF8QdSJ+9lsS0cjXJBsYYurGCMassp9oKXVuEJSA/SDAJj/BvFG925lm42kyM6X4gTCXCj2fT/dPc9LwFEO9wuGO3FmMcRWyuQbQrPRg6J5aBNj/ziK7lGt/TawVtKnylvE3vJvNABIB7BRp1xtkkM8Bm5YZz+aAO/bwdH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o3DDluCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33472C2BCB0;
	Tue, 12 May 2026 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609535;
	bh=lwbNDNk911T8nGL8M6OMeFRhs7gDx1DUdM7shVyyMaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3DDluCUfoyx0f9fRQaf5hoF2WnQYaS3I48U7dazCkQegq5OduusQqQN/zxq4eDPk
	 KMVgy7t4I/nyULAmdvfFGHrCqlAj71GJurwYQbgVfD+A8pzTC3NYCiJpDQ9OGh/ZLL
	 AxMZID6UOStz/DaaX8s7C4hw+iJhDL16Z3bY7aEU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brad Spengler <brad.spengler@opensrcsec.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 7.0 232/307] RDMA/ionic: Fix typo in format string
Date: Tue, 12 May 2026 19:40:27 +0200
Message-ID: <20260512173945.017207466@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3180A5280A2
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246558-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit 70f780edcd1e86350202d8a409de026b2d2e2067 upstream.

Applying the corrupted patch by hand mangled the format string, put the s
in the right place.

Cc: stable@vger.kernel.org
Fixes: 654a27f25530 ("RDMA/ionic: bound node_desc sysfs read with %.64s")
Link: https://patch.msgid.link/r/1-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Reported-by: Brad Spengler <brad.spengler@opensrcsec.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -185,7 +185,7 @@ static ssize_t hca_type_show(struct devi
 	struct ionic_ibdev *dev =
 		rdma_device_to_drv_device(device, struct ionic_ibdev, ibdev);
 
-	return sysfs_emit(buf, "%s.64\n", dev->ibdev.node_desc);
+	return sysfs_emit(buf, "%.64s\n", dev->ibdev.node_desc);
 }
 static DEVICE_ATTR_RO(hca_type);
 



