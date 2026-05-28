Return-Path: <stable+bounces-255056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGbeH01vGGp6kAgAu9opvQ
	(envelope-from <stable+bounces-255056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:37:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF635F514B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83F5F3375D77
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D384218A3;
	Thu, 28 May 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgioBIqj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B630E0E4
	for <stable@vger.kernel.org>; Thu, 28 May 2026 16:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984010; cv=none; b=UVhyuLs9tIx69tpg1mc5bBrMZaKOeNr74nbiTRdvJiudPwb8b7qksvZL0ENdMEA3gv0C/lmFrHOhrDQyFa4cJeBQ+o4uZMnqXvPNgXkt6ARq4hTrLdkBpAF+GfMRlmuE7PZDfWeo7iTED3XOuxbczHezmGrkrMv7v5xkb3IA6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984010; c=relaxed/simple;
	bh=k10mRhLr6t76p4jkzZqe4TGLVfCDjV4dlalSEfzSMXc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UPmoLNkLKJQO8RhsRQiHNeYLkX4QOn5ejlr2PdrWOS0D51LjdYFh5LWcp63NXLJx655TtHVXMddB1SUFRV3TV6ujfsgkRfTFDUe+ADI+4+HUwndaR/JLIumlu2Ud87ktVRz100m1MoCupSvyUR4CLf+eCflfoNtsydBhXue9iL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgioBIqj; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-516ceea1984so139117011cf.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779984007; x=1780588807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MmPFy91yuYd+9nLUOi1wu2JWcf7o4ksos6H5oNntzCU=;
        b=BgioBIqjikS5YWrDib6V0VNppkXf1Q7CZEs+tgvrtcBff8sU2VM8hWbG0GCpggJcTs
         6SnoRbyV09kp9pyQ7Pso8s8POhbUKJCPI9i51EgYibG0ANjDyQ1iIpkgWabXVdshsSrF
         LcuScN4sBZpYnr/aRxbTFiP84JqmmAmI5ogQbbtnj0VMFIZmZL1nRQ6ezBTM0QF36Pno
         ErL9zO7OnzhNmi8d9QTVWgL8PWjRIt1a8PR6+0unKisPSDrDB4npy9a//SgYofAPL692
         XxA9dYdD2jDbhSoSmJ+zYeRGYKJCl+kWNnAshbHr5pr+RiW7ozeE+cGCqecGWjIeIXBJ
         HGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984007; x=1780588807;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmPFy91yuYd+9nLUOi1wu2JWcf7o4ksos6H5oNntzCU=;
        b=GsO3QubvWrwcu1zRPkqcxBaB5o2FUDlN/oESFqf4d/vYiRPBZO768S9P5lsM4ER36o
         K/IUYAN6HkmhoafVyu3hrqi50mBFhc7ijXF520Gw3U7+E20HQ8y0bAT+XaYJ80QhR+S1
         DVzk59PFQcv3RhOlZJiZDeHsuCOnOXcNWkAPe44133g51Gyif0FbTza+Mu0aUTNMX4wI
         uZNNe+cTi1QNcjoPWKgJx7JYS9lX999LY0WlfHZPxJUDGuYzDjhpp4hNoCEo9NSBI/zE
         palMKvHLaunmJrp+aSGSM42i9aVpi7kubzrCslni/MV+ao9ZoVmddXKioYc9Igobttkp
         eagg==
X-Forwarded-Encrypted: i=1; AFNElJ/ngSHU9GuUiK8X8KSZ2sIT30JsyjDxU2eReR0cTjuq5ABwNfLsJk7LYt6i3E8dKPKtKLJTD3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4LadnfO6ClFdKjEg2pmFliEvbKPW+3fc55i6I0EgoOqJgfD9Y
	1EKesss+v+e7QXwrOJpmPr1kVi581RdLSwTNu+O1lmCZwVKCuJ1xn9qj3rLZmLFYEziVmz4XJ7x
	RSzJ1Rlh9ZsXG
X-Received: from qtxy12.prod.google.com ([2002:a05:622a:120c:b0:516:373e:a942])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1488:b0:516:d6a4:fd69 with SMTP id d75a77b69052e-516d6a4fe46mr371616761cf.12.1779984005890;
 Thu, 28 May 2026 09:00:05 -0700 (PDT)
Date: Thu, 28 May 2026 16:00:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260528160004.2452461-1-xuehaohu@google.com>
Subject: [PATCH v3] dma-buf: Fix silent overflow for phys vec to sgt
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, jmoroni@google.com, praan@google.com, 
	David Hu <xuehaohu@google.com>, stable@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255056-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuehaohu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 1DF635F514B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In case MMIO size is bigger than 4G and peer2peer DMA goes
through host bridge, we trigger a code path that assigns the
total linked IOVA (which is greater than 4G) to mapped_len.

Previously, `mapped_len` was declared as 32-bit `unsigned int`.
When accumulating `size_t` lengths, this leads to a silent wrap-around.
This truncation causes truncated lengths to be passed to functions
like `fill_sg_entry()`.

Fix this by changing `mapped_len` to `size_t` (64-bit). While
at it, fix similar potential overflow issues in `calc_sg_nents`
by using `size_t` for `nents` and checking against `UINT_MAX`
and using `unsigned int` for the loop iterator in `fill_sg_entry`
to match.

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux.dev
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Hu <xuehaohu@google.com>
---
Changes in v3:
 - Removed leftover sentence fragment from the commit message.
 - Kept `nents = 0` initialization (previously stated as removed in the
   v2 changelog) as it is strictly required for the `+=` accumulation
   loop in `calc_sg_nents()`.

Changes in v2:
 - Fixed 'IVOA' -> 'IOVA' typo and expanded commit message (Claude Bot).
 - Added Reverse Xmas tree formatting (Pranjal).
 - Folded in extra bounds checking for calc_sg_nents() (Pranjal).
 - Folded in type consistency fix for fill_sg_entry() (Pranjal).

 drivers/dma-buf/dma-buf-mapping.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..5bc769fc42ea 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -10,7 +10,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
 	unsigned int len, nents;
-	int i;
+	unsigned int i;
 
 	nents = DIV_ROUND_UP(length, UINT_MAX);
 	for (i = 0; i < nents; i++) {
@@ -36,7 +36,7 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 				  struct phys_vec *phys_vec, size_t nr_ranges,
 				  size_t size)
 {
-	unsigned int nents = 0;
+	size_t nents = 0;
 	size_t i;
 
 	if (!state || !dma_use_iova(state)) {
@@ -51,6 +51,9 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 		nents = DIV_ROUND_UP(size, UINT_MAX);
 	}
 
+	if (nents > UINT_MAX)
+		return 0;
+
 	return nents;
 }
 
@@ -95,9 +98,10 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 					 size_t nr_ranges, size_t size,
 					 enum dma_data_direction dir)
 {
-	unsigned int nents, mapped_len = 0;
 	struct dma_buf_dma *dma;
 	struct scatterlist *sgl;
+	size_t mapped_len = 0;
+	unsigned int nents;
 	dma_addr_t addr;
 	size_t i;
 	int ret;
-- 
2.54.0.794.g4f17f83d09-goog


