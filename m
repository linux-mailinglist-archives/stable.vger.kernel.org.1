Return-Path: <stable+bounces-264524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wfoRBCl5MWr1kAUAu9opvQ
	(envelope-from <stable+bounces-264524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:26:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A875692125
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:26:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="YV6HW/Gr";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264524-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264524-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF3A3182BD1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC24508F2;
	Tue, 16 Jun 2026 16:13:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065944CAF5;
	Tue, 16 Jun 2026 16:13:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626383; cv=none; b=qcOYHltTL38gRlwkvYuGTNkvf5gmvnz3mouRD14YqI4DOoux9rIl8YUGCJZLhv+98bp3ypKRSyi8MjYcSg5Mr4dz69qMmd2MAMitIIQT0kAohz05iUW8r5RBI8iyAMMt5ypu0mUhH5EYg6yVgD/3i4b9xHHZNw/fWETp3ipUQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626383; c=relaxed/simple;
	bh=iHyOJ69a+ELdi4Po8tVxhbrFX4GuDvNS/T6U768kHow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xbl0MdtU7qL160M3Z0/MEvYwa9xB1D7Fq1FqKrWdl6VSgVDXNt61XaeW4ro/eKugME7M6IlAEtA5wlW5nRuas1U54aIYFetvPYTylk+o56EHGCEkuf0e4se+qKXz2GshfADNDqUv8wSmMa789H1tN2EH3CJa6WZFahfrs1/azDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YV6HW/Gr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A931C1F000E9;
	Tue, 16 Jun 2026 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626382;
	bh=zBqFQoWXpLdFi5SY5FGVO5waDG6qucpiX3ynt8b85eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YV6HW/GrH0B6H4LRuyNXWziwuOL6PBBh1PFR5DL/NgR02knfZ3i/yDsS2q11+B2jI
	 6/ph6tQrQGKhq8lAIaoLfRgeJ2ESVxhgY911PBjNXWiIwChK7A/LP2ALyYFkt9UUac
	 5okzKmFRM8/PEt0/kKg93BNCMj6hrtkdVfKTYaBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 310/325] RDMA/umem: Move umem dmabuf revoke logic into helper function
Date: Tue, 16 Jun 2026 20:31:46 +0530
Message-ID: <20260616145114.467720743@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264524-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jmoroni@google.com,m:leon@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A875692125

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 797291a66ce346c96114b72222fc290d402da005 ]

This same logic will eventually be reused from within the
invalidate_mappings callback which already has the dma_resv_lock
held, so break it out into a separate function so it can be reused.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260305170826.3803155-3-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: badad6fad60d ("RDMA: During rereg_mr ensure that REREG_ACCESS is compatible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/umem_dmabuf.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -198,6 +198,22 @@ static struct dma_buf_attach_ops ib_umem
 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
 };
 
+static void ib_umem_dmabuf_revoke_locked(struct dma_buf_attachment *attach)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
+
+	dma_resv_assert_held(attach->dmabuf->resv);
+
+	if (umem_dmabuf->revoked)
+		return;
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+	if (umem_dmabuf->pinned) {
+		dma_buf_unpin(umem_dmabuf->attach);
+		umem_dmabuf->pinned = 0;
+	}
+	umem_dmabuf->revoked = 1;
+}
+
 static struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_and_lock(struct ib_device *device,
 				   struct device *dma_device,
@@ -265,15 +281,7 @@ void ib_umem_dmabuf_revoke(struct ib_ume
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
 
 	dma_resv_lock(dmabuf->resv, NULL);
-	if (umem_dmabuf->revoked)
-		goto end;
-	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
-	if (umem_dmabuf->pinned) {
-		dma_buf_unpin(umem_dmabuf->attach);
-		umem_dmabuf->pinned = 0;
-	}
-	umem_dmabuf->revoked = 1;
-end:
+	ib_umem_dmabuf_revoke_locked(umem_dmabuf->attach);
 	dma_resv_unlock(dmabuf->resv);
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_revoke);



