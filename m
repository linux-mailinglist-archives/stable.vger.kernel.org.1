Return-Path: <stable+bounces-264779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O54cNxZ9MWqzkgUAu9opvQ
	(envelope-from <stable+bounces-264779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:43:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D5669260D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:43:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Xm3sqQ+B;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264779-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264779-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C0830247EA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666A47799E;
	Tue, 16 Jun 2026 16:37:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26817466B4B;
	Tue, 16 Jun 2026 16:37:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627846; cv=none; b=MKJbORL3ZKY1Uy03aNus9cdJI/zvzIUJcIvlSU/1uA/g11duDlbKkSXjLKGuTsACNl4Fpe9hC50GeknUioGRD+3WkIW8cjHwmTg+UgID3yJ5nG5XS22viR+X/u3EPZexvquf6v+8MlHV1mP6zUKRhG26bhFjYH14KNArpM9noVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627846; c=relaxed/simple;
	bh=pHz2TJSCVDBvgvYyIwAoxlgFOAVJ5So282TF+YoxJO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBFx2NxEi7EvftZq5vVli0/fqg0bisJDz4RSRTifp2meFyjsCItstV39fHTsiS9ggCwYlNPxthcHafo48HjsFYUmPBk7dN8Mdva2n2Pwtan75nvGnxpa/jgSz1Q5GUis8Wke/ZI3hLNlvO+IxYLCir5SmWuKoiPS6UOC8yIts+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xm3sqQ+B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C201F000E9;
	Tue, 16 Jun 2026 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627845;
	bh=zC6aF6r7vgI2xg2My5C8cCPBtJQCWPRdnlBsrCT2Mik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xm3sqQ+Bea4OHIQfZK5XjJGEViwdDm+OYLj2WcrVZxrogqdhyBhE2Wp7IX/uE3oUo
	 5hmsI0ehNp1t+gdOdlNDbQqNS8oN2Xj1Xhkx4b/L6mQU2/szOZe5X4gssJzaMRW9nd
	 p37ctPKZqtnixaH44jKCgo5Pv1JS2R5fdnxv5vEY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 238/261] RDMA/umem: Add helpers for umem dmabuf revoke lock
Date: Tue, 16 Jun 2026 20:31:16 +0530
Message-ID: <20260616145056.100420502@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-264779-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44D5669260D

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 3a0b171302eea1732a168e26db3b8461f51cc1f9 ]

Added helpers to acquire and release the umem dmabuf revoke
lock. The intent is to avoid the need for drivers to peek
into the ib_umem_dmabuf internals to get the dma_resv_lock
and bring us one step closer to abstracting ib_umem_dmabuf
away from drivers in general.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260305170826.3803155-5-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: badad6fad60d ("RDMA: During rereg_mr ensure that REREG_ACCESS is compatible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/umem_dmabuf.c |   16 ++++++++++++++++
 include/rdma/ib_umem.h                |    4 ++++
 2 files changed, 20 insertions(+)

--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -276,6 +276,22 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_ge
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_get_pinned);
 
+void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_revoke_lock);
+
+void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
+
+	dma_resv_unlock(dmabuf->resv);
+}
+EXPORT_SYMBOL(ib_umem_dmabuf_revoke_unlock);
+
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf)
 {
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -159,6 +159,8 @@ ib_umem_dmabuf_get_pinned_with_dma_devic
 int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf);
+void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf);
 void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf);
 
 #else /* CONFIG_INFINIBAND_USER_MEM */
@@ -219,6 +221,8 @@ static inline int ib_umem_dmabuf_map_pag
 }
 static inline void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf) { }
 static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf) { }
+static inline void ib_umem_dmabuf_revoke_lock(struct ib_umem_dmabuf *umem_dmabuf) {}
+static inline void ib_umem_dmabuf_revoke_unlock(struct ib_umem_dmabuf *umem_dmabuf) {}
 static inline void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf) {}
 
 #endif /* CONFIG_INFINIBAND_USER_MEM */



