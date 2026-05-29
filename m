Return-Path: <stable+bounces-256807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBzqAU0gGmqx1ggAu9opvQ
	(envelope-from <stable+bounces-256807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:25:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C9E609B8A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 01:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC9603049FD7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CA438A299;
	Fri, 29 May 2026 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX54Hvvb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF2388E57
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096977; cv=none; b=mchPWqR/zhgd1pzcgqVCcKi5Y0kxuRzQMD1QtMryjbb3jIMy92KZYr5SHw2zqjfo5Vjb4RPWUjjDmca7/q5pUqmNQiqzC9W95YRnsp3xZY/MkDvwsxIgzjL6uNMDhr1CMiuKGvpSZ4YKzPrdi8ceH6G6Uh493LkyiprhJ6X4doM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096977; c=relaxed/simple;
	bh=k5VVJVnW1M3JU3Vo+oL+JrXosN37i2xiGtyGT1ZCI6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWTRRYPk4ZXX3k5qlVtJHrtGeQwtASlcjptZ0j6H4lbCPd6QvzOR57n2OoeERh46EEJ6bUsZ54AF6af18ZJXTcymqjRQjets4YZ4IaI6bXgogn9OMso4NGRBBMUQYHVPDT8qpTGB1XoEkUbT2UD86tAmvKmu19ne9QWPgdGOCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX54Hvvb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DAF1F00893;
	Fri, 29 May 2026 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096976;
	bh=LvSjj6UrMTEk5wFI2j1plhV9NZ/iedLMEuc3Gwrr3Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EX54HvvbdfxGmtYuv0V3dB+Km4oUp1nGzNJVY80Y4dWo8MnmZ0kvwc8rTEIvwXKNf
	 PREBVdKVyFjw8pJVKST7RcbwGFqUTp/N2r7bXLiw+pEXlgQea1+jm7U/BPheUe+IvH
	 J6CaLsFcmMr++DRWqSuuml8zBc0lmOxudq0o07Txjl6Udpue1+YIJgYAc6oKCD1Zre
	 EXLQ5rQdn7uCrsGaOkH7BJIxC15DxsmGLxHhWyvBR3/RLwqUx7bpOdJkvnLP+G5Rue
	 CGgMaZk7+71o1tG22UQJ1K0NNYIThrXaO5TvNX+ETNAJQg8YL2QZb5wEyUsVn9Z5EC
	 n4IUmXUOIy92w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] net: devmem: reject dma-buf bind with non-page-aligned size or SG length
Date: Fri, 29 May 2026 19:22:54 -0400
Message-ID: <20260529232254.1877494-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052820-passing-subject-c656@gregkh>
References: <2026052820-passing-subject-c656@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,meta.com,fomichev.me,google.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256807-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 57C9E609B8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 4eb82ba543421e9e38cc14e4e82058b78850df50 ]

net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
PAGE_SIZE multiples without checking:

  - tx_vec is sized dmabuf->size / PAGE_SIZE, and
    net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->size
    before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =
    N*PAGE_SIZE + r (1 <= r < PAGE_SIZE), sendmsg() at iov_base =
    N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.

  - owner->area.num_niovs = len / PAGE_SIZE while gen_pool_add_owner()
    covers the full byte len, so a non-page-multiple non-final sg
    desyncs num_niovs from the gen_pool region for every later sg, on
    both RX and TX.

dma-buf does not require page-aligned sizes, so the bind path has to
enforce what its own indexing assumes. Reject both with -EINVAL.

The size check is TX-only (only tx_vec is sized off dmabuf->size); the
SG-length check covers both directions.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/20260519203530.66310-1-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/devmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 448f6582ac1ae..16ce197cb0faf 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -232,6 +232,11 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	if (direction == DMA_TO_DEVICE) {
+		if (!IS_ALIGNED(dmabuf->size, PAGE_SIZE)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "TX dma-buf size must be a multiple of PAGE_SIZE");
+			goto err_unmap;
+		}
 		binding->tx_vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
 						 sizeof(struct net_iov *),
 						 GFP_KERNEL);
@@ -259,6 +264,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		size_t len = sg_dma_len(sg);
 		struct net_iov *niov;
 
+		if (!IS_ALIGNED(len, PAGE_SIZE)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "dma-buf SG length must be PAGE_SIZE aligned");
+			goto err_free_chunks;
+		}
+
 		owner = kzalloc_node(sizeof(*owner), GFP_KERNEL,
 				     dev_to_node(&dev->dev));
 		if (!owner) {
-- 
2.53.0


