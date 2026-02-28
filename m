Return-Path: <stable+bounces-220570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ox7Naw9o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:10:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA3A1C6AB0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF8D8312774F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122A33DC66E;
	Sat, 28 Feb 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWfspa2E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D23DC665;
	Sat, 28 Feb 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300451; cv=none; b=EdOgbE8bj5BewFI7attPcoa7jZLSewaUq8uJMRKdzGzED3M8RD6dDDtp8dwn2XCnMUagXwPU1OgPF2L/PQkVcyCKG/EKheQ5bdNkJ+0QzDwYzlSQaP/Ci9VZZO2GgyCOt2kWZtzT4RU9YM5vgMAEclVPGFE+5BLCD8IdFDORuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300451; c=relaxed/simple;
	bh=cA0iyVRujC2xfGltGqfFBfS7ZxxYDuTQ0L0yzi6eVWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCVV2rv7nw0Gcz5nslOmMnIl62g1GWBHyKvBYeZyxOOv0/mR1MrKsox0ctpfLWifvcGckz0koMrbXgpGMt0IRwYuz/LLa/okn/HpAtpj5R1XsEbmuxC/aIl5F9GC3uUcmy+TqfKvv+4rGk6fXOPtc1e3f0yWutOYsuOxpImPLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWfspa2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0608C116D0;
	Sat, 28 Feb 2026 17:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300451;
	bh=cA0iyVRujC2xfGltGqfFBfS7ZxxYDuTQ0L0yzi6eVWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWfspa2EhiYJuNoBWw+ZANwbtlD/wTlA3KkyF0TMBxuz117nk8ZdI8FcknRryWifS
	 aBksxWrvfq/mGv8m9rBbFNAsFFDW+MV5tLNboGgZjfZlSjQoJyDrf8aIux37KYAFyT
	 sTj7cC8RR5mg/7WBTbNAVjT6AcQtsVTGgJmXuh89Lv6wVRjOyZtnFqKA0e1JKMaL/2
	 LnXJJVSnXcRCxtp/bFP8HpbVeM/V6SupP83MVukrfdUSsHLMDyxDgI6WSGSvr5WK0O
	 SZTH1bhg+O5VAXPFfCQnrfkvLZGhpmzM3p34Cv8sL7RVMlK5oOFiWeA5N+Iy/RIpAu
	 J+7Dpi+GG0seg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 491/844] RDMA/umem: Fix double dma_buf_unpin in failure path
Date: Sat, 28 Feb 2026 12:26:44 -0500
Message-ID: <20260228173244.1509663-492-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220570-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4FA3A1C6AB0
X-Rspamd-Action: no action

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 104016eb671e19709721c1b0048dd912dc2e96be ]

In ib_umem_dmabuf_get_pinned_with_dma_device(), the call to
ib_umem_dmabuf_map_pages() can fail. If this occurs, the dmabuf
is immediately unpinned but the umem_dmabuf->pinned flag is still
set. Then, when ib_umem_release() is called, it calls
ib_umem_dmabuf_revoke() which will call dma_buf_unpin() again.

Fix this by removing the immediate unpin upon failure and just let
the ib_umem_release/revoke path handle it. This also ensures the
proper unmap-unpin unwind ordering if the dmabuf_map_pages call
happened to fail due to dma_resv_wait_timeout (and therefore has
a non-NULL umem_dmabuf->sgt).

Fixes: 1e4df4a21c5a ("RDMA/umem: Allow pinned dmabuf umem usage")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260224234153.1207849-1-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/umem_dmabuf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 0ec2e4120cc94..17b16fe0e49d9 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -221,13 +221,11 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 
 	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
 	if (err)
-		goto err_unpin;
+		goto err_release;
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 
 	return umem_dmabuf;
 
-err_unpin:
-	dma_buf_unpin(umem_dmabuf->attach);
 err_release:
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 	ib_umem_release(&umem_dmabuf->umem);
-- 
2.51.0


