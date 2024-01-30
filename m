Return-Path: <stable+bounces-17455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2976A842EC2
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 22:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB5F1F24D09
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 21:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537278B53;
	Tue, 30 Jan 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R08psta4"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F85125D5
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651114; cv=none; b=AIybrRl98viB1wBIOBFNT8rNuQJvPiFd5oq70sgNzbi7OKkIuOLRnh4/2G3H7VUPw55DhPfyR0PdX10LUnQUiS9P7V81jLMH69W86K2lYf+9oUptZulKVLtnVJlmRkbg56JSfH9F/WBCfEeoBUbTu5ZOPkbF50fsQxHQbV+2nvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651114; c=relaxed/simple;
	bh=54maFD7ddj4hxdtoQBD5NjvOYwej7R0VAobqu+hox2Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lCQZ5I0G1zykxMpvkP75EL90tuOpzeBOTUPewwM+YlWCRIqgV5IrZf//MwdM7hVSSHdY/mKhgHnhEeJcK9WYPcLdrsuKf5k0PR7KBvbJGK/U3hSyOcv0sPvOasZ8/jZnoaNgSx6F6s+e5EiCFlLR5diuV1CNPJpiz/urEz82yVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R08psta4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5fffb2798bfso74967487b3.2
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 13:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706651111; x=1707255911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zH6yChskb4iX5o2uc+gOu5S3Sl/hpe2ATDVyfiVFpcM=;
        b=R08psta4+sSGge7UhsjIYiGpr2o8hbq2PCTMEUM7Yrlt0guFjquDFn8jPOq/DEhsL0
         HdAMTfwUu1+ZqalA2n0IPtYKiu5Ef4kFcqhKZd1zLFurvsfHI9bvaRkKlsl2ds0xq0PI
         d9unxE8eYAyg89eALSIQkgIXMKJQPbb9XZwI6mCzBzRX4LISBpg6PdrpOZFT/kfzdLCh
         KcxY+rkSFcDxTZY0syTOzRF1YihrFhTj8q/APgHPNh/wXqE5rGs43f+Z19MUzGi5Q4mr
         tTj98IB9mhuH9TbDCahuHhj3TW4zFi/m1C65nCFaiDEpREXfrG+D5zP390ry7WmLMw6h
         YEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651111; x=1707255911;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zH6yChskb4iX5o2uc+gOu5S3Sl/hpe2ATDVyfiVFpcM=;
        b=B0n5ztGXXRJCFmk+A1/zvaL8zSrXhdGoi4Zmi/ef5LhoFGt3ZGPCRb4H9RwbrOEdrr
         YCgyXVXcbkMlkY6Cvs0XECRA4A4ShzI0Y1MG836/euTJoC7RynkqzXW0qEMS5wU8vq2w
         CT/rv7yi7QURnILq739+zMpUHoWQjyvo9iTTNCQvTQIihohycOOFZI0rdv9xa5cLlyXe
         tJnY6cM1WEBJvb0cvNa0/ympK9fHJse6MmJ7qiFxXDViHVV0EwYPZrsrVFSN89sHY/HJ
         xZpo8DB133n7IBFz//1KsB8RXjBKOTUQSLTrSILuhXA0/9a4/1i4L8p3F8+gcwFGBX5E
         pkHg==
X-Gm-Message-State: AOJu0YyKEaWQiTvWSTWW50Ht23LbiW5kDoKB757XArf0cK2zppk6/Bfd
	VVxHc8/8AvQdoeV+9HThRCsstWk0qcvFwkIjdrRui8TDVzL3vpJeu1Cfp6zeCQQd4xjV7y2Cjb5
	ACZjQGMlKDb5JWcHJBs3PevLDtbt9wA8IEJho0VGgi1077RsZ2IvTm+emu1aNFsGf3ILVJPYdBJ
	WE3b2a6d+Kx+dTu5J9ldUIKe4vZBNh0StbjaxE3kEst8ExMvaiRDMGMceNffPaM3Mh
X-Google-Smtp-Source: AGHT+IEBmquDkFYp+RkCMxtT3JHESfyqDAAcx16QCEsZeyu7nkqO+idywIzf7rzw5di7z7KxB10fELzT45T/ipcxSi8=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:60ac:f2db:8bd2:1c88])
 (user=pkaligineedi job=sendgmr) by 2002:a05:6902:2384:b0:dc2:48af:bef8 with
 SMTP id dp4-20020a056902238400b00dc248afbef8mr3281271ybb.10.1706651111578;
 Tue, 30 Jan 2024 13:45:11 -0800 (PST)
Date: Tue, 30 Jan 2024 13:45:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130214507.3391252-1-pkaligineedi@google.com>
Subject: [PATCH 5.15 6.1] gve: Fix use-after-free vulnerability
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Bailey Forrest <bcf@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Eric Dumazet <edumazet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Kevin DeCabooter <decabooter@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Bailey Forrest <bcf@google.com>

Call skb_shinfo() after gve_prep_tso() on DQO TX path.
gve_prep_tso() calls skb_cow_head(), which may reallocate
shinfo causing a use after free.

This bug was unintentionally fixed by 'a6fb8d5a8b69
("gve: Tx path for DQO-QPL")' while adding DQO-QPL format
support in 6.6. That patch is not appropriate for stable releases.

Fixes: a57e5de476be ("gve: DQO: Add TX path")
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Bailey Forrest <bcf@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Kevin DeCabooter <decabooter@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index ec394d991668..94e3b74a10f2 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -350,6 +350,7 @@ static void gve_tx_fill_pkt_desc_dqo(struct gve_tx_ring *tx, u32 *desc_idx,
 /* Validates and prepares `skb` for TSO.
  *
  * Returns header length, or < 0 if invalid.
+ * Warning : Might change skb->head (and thus skb_shinfo).
  */
 static int gve_prep_tso(struct sk_buff *skb)
 {
@@ -451,8 +452,8 @@ gve_tx_fill_general_ctx_desc(struct gve_tx_general_context_desc_dqo *desc,
 static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 				      struct sk_buff *skb)
 {
-	const struct skb_shared_info *shinfo = skb_shinfo(skb);
 	const bool is_gso = skb_is_gso(skb);
+	struct skb_shared_info *shinfo;
 	u32 desc_idx = tx->dqo_tx.tail;
 
 	struct gve_tx_pending_packet_dqo *pkt;
@@ -477,6 +478,8 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_ring *tx,
 		desc_idx = (desc_idx + 1) & tx->mask;
 	}
 
+	/* Must get after gve_prep_tso(), which can change shinfo. */
+	shinfo = skb_shinfo(skb);
 	gve_tx_fill_general_ctx_desc(&tx->dqo.tx_ring[desc_idx].general_ctx,
 				     &metadata);
 	desc_idx = (desc_idx + 1) & tx->mask;
-- 
2.43.0.429.g432eaa2c6b-goog


