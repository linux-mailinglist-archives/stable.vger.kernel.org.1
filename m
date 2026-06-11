Return-Path: <stable+bounces-262787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r+fNDgPxKmoRzwMAu9opvQ
	(envelope-from <stable+bounces-262787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 19:31:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C4D673FFE
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 19:31:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=daZDmSNh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262787-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262787-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FEA73500A44
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181E494A1C;
	Thu, 11 Jun 2026 17:18:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA2E44D6A1
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 17:18:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198298; cv=none; b=ZfvmBOYQWNTdQp4vW6x4JOCNW2P7V8wBSTMtwWmstbx4extB+bsj7aBsBags90i66faMuPyz+6Wl/0dVUZAbMJNyrtmoXuawx9fShZT0cKKMaV8/atBsRBs9DatX02IG9vu9NEe5yH/uXHoi9BUk4JfplglPTRLkSfteHmIwcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198298; c=relaxed/simple;
	bh=MpwzlKCxNvprYG6nGm+I8C1iP9aryXlPg3HlDXV5TIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AzMFlzoZLkVsrpXBS79Ydis6FGr4KM/vfQmOAGPgOLuF+2FsqMXZXHnT+t0jqT+BGDx+XgfYY8n++gNNAIuiy0z7WafEScY5p18IaklcvU+r49AqmaKdUvFgDrdLtHMAxazaszLMKmSwCYEMcDF1Bbhb2ebVRlBTQddAXTWlx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daZDmSNh; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85d4b4245aso39387a12.1
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198291; x=1781803091; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwqBiB1V3FALHX4MUot7lj1fa4juan4nyiLVjCQIClc=;
        b=daZDmSNhMkePX4XxL+GvSa3/ghWAAD90qQU6FTE27QU9j8JgZZIv1Esw18cMi73Ewo
         ktx2+7GnZ7+41YuSanm/1n9FyG+mepcNmlox7xVXVuZrBRP5nPVf2YhpX+EEHoJunXkh
         RrDKbTm0A6QYgXhoVDXbYmsOrHt5ivFlYqaqlb6EsqrpaTG3OYl5UxPkBlMbXbc8Jl8h
         espvSIdobdwqGB1NncmzwAt+A0qO07JQ/ckcUE7DwW37kjAcawmNpiP2r7K+p5MK13kc
         yLCLTaJOLWg3tA1O6YGdRQkfZoTiT+4h+0nKfbFnTHnof4QIcLiuk5NmyKm+W6nSNytR
         i2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198291; x=1781803091;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwqBiB1V3FALHX4MUot7lj1fa4juan4nyiLVjCQIClc=;
        b=dNyP2yFdIdV74s5GUtbO6gvvWe4sxXm29D/deQOLbgfuS7++qHYONyLNK4KGQYZReZ
         6JhcPnk6BVT9OGLGeOe9qVKzMPg2podu2BpWhX25x89m6X/SiB3T2RwlWfJSeMFzw/IR
         ft57VJ+Bz8jowA47fy2c5v+EF9nPkCSn4iImQEcmQgY4K470IMzh3lKcSJq+KrOYsTxh
         4rBAaN97I0ua1TJcQg0EIDfU/l4RTZOPaX7/5X0Sau3yc/tDGx01bkColIyCi9+F8T8+
         daBWBPLVWKGLAZbQs5Ik/mMBHAM3/VzFWwapH7DikhNPFWCsKp8j7Zf+jYY0e1OQGGAH
         eJnw==
X-Forwarded-Encrypted: i=1; AFNElJ+QzmBVqY9jux/zWQDQihVQ88bsIzM8+6JFX2OAIMDlLvHA52Lkp22N/QMjzU/KBkSWBcsmJm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHzLl1PuT2ULbmqF1sFqneN0593UQDxNfGG1aeiAlxqMZTrzj
	soxpO1EGA7JYkZD0LsqB8UAr1rUy4SbhjacT33yUdsl+M7y5IsFnALx+
X-Gm-Gg: Acq92OFgAKtjRykSPYLy+qGUjw0xeCTzy+4wZZJqG2hrquTgF6jLjJ6nbYKj9YaKh0+
	SBpEwDi2PlKGPYqwdXfp2m7Q0/uLf0z4FkqJ+V3B92ugqZar1Ix2dKAA4d+N6PZcJfyku1xoZDT
	//zXLWOx37r43XX8yDF7DeOXajYDOTKF9CNE/S3dO7NtTRNs1Epfy0pLPCdjnHPjWbm2UXE+Gge
	f7D//HhnUlkDA1xtS7qTZH7OLM2G7jSucbNfw9x5MLgLhi4+DiouPr6MVWCoV6VOTtWzwCRZDla
	UrsqCkCWOy9wthApbU+lR6dhorUU+f0vL5CazYcDL7qwknIuZAkjTj/lGbamn0r2AIkcTEQQY6K
	SrHmOrbH2dbWLPNtX8LvCxEPXiRyhmQCgpiSpeGhX3ZYNIXtqoCh1dqCY9GCcws20jIGsJTCPUk
	MTSU5ivQV6cDqJVQWjfMssVBnYkcLFQfSsNav8xtLP
X-Received: by 2002:a05:6a00:a01:b0:842:459b:d61b with SMTP id d2e1a72fcca58-84336ba88b2mr3976561b3a.32.1781198290589;
        Thu, 11 Jun 2026 10:18:10 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([36.21.199.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8433831a89bsm2967346b3a.56.2026.06.11.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:18:09 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 12 Jun 2026 01:15:54 +0800
Subject: [PATCH] RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in
 rdma_write_sg
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-master-v1-1-70cde5c6fdc9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAErtKmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Mj3dzE4pLUIl3z5KRkQ1OzlETDNAsloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AexEWc2oAAAA=
X-Change-ID: 20260612-master-7cbc156da1f8
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, 
 Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781198286; l=2840;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=MpwzlKCxNvprYG6nGm+I8C1iP9aryXlPg3HlDXV5TIE=;
 b=ol0mkn6Z2NuzQW6U1P4SFHZoz7NQAV7dQugAAv2T/oUjuuQaWdhsvbax7JjJhlDZlkHfRm5ds
 tC0ADZLAkbbDbHtj2N8gN/w8zoO0cjfOs561TAYsi2VAyr53sPuBSIu
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262787-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cloud.ionos.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[whi4ed0g@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:danil.kipnis@cloud.ionos.com,m:jinpu.wang@cloud.ionos.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,m:whi4ed0g@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[whi4ed0g@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77C4D673FFE

When the server answers an RTRS READ, rdma_write_sg() builds the source
scatter/gather entry for the IB_WR_RDMA_WRITE that returns data to the
peer. Its length is taken directly from the wire descriptor:

  plist->length = le32_to_cpu(id->rd_msg->desc[0].len);

rd_msg points into the chunk buffer that the remote peer filled via
RDMA-WRITE-WITH-IMM (rtrs_srv_rdma_done() -> process_io_req() ->
process_read()), so desc[0].len is attacker-controlled and, before this
change, was only rejected when zero. The source address is the fixed
chunk start (dma_addr[msg_id]) and the source lkey is the PD-wide
local_dma_lkey, which is not tied to the chunk's MR mapping, so the verbs
layer does not constrain the transfer length to max_chunk_size. msg_id
and off are bounded against queue_depth and max_chunk_size in
rtrs_srv_rdma_done(), but desc[0].len is a separate field that was not
checked against the chunk size.

A peer that advertises desc[0].len larger than max_chunk_size can make
the posted RDMA write read past the chunk's mapped region. The resulting
behaviour depends on the IOMMU configuration: with no IOMMU or in
passthrough mode the read may extend into memory adjacent to the chunk
and be returned to the peer, which can disclose host memory; with a
translating IOMMU the out-of-range access is expected to fault and abort
the connection. In either case the transfer exceeds what the protocol
permits and is driven by a remote peer.

Reject a descriptor length above max_chunk_size, mirroring the existing
off >= max_chunk_size bound in rtrs_srv_rdma_done(). Legitimate clients
do not exceed it: the client sets desc[0].len to its MR length, which is
capped at the negotiated max_io_size (max_chunk_size - MAX_HDR_SIZE).

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6482ad859bd1..f81e122a3ccb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -225,8 +225,9 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	/* WR will fail with length error
 	 * if this is 0
 	 */
-	if (plist->length == 0) {
-		rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
+	if (plist->length == 0 || plist->length > max_chunk_size) {
+		rtrs_err(s, "Invalid RDMA-Write sg list length %u\n",
+			 plist->length);
 		return -EINVAL;
 	}
 

---
base-commit: a48671671df5158a0b8e564cd509e04a090a941b
change-id: 20260612-master-7cbc156da1f8

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>


