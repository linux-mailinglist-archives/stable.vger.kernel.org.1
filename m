Return-Path: <stable+bounces-253635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO5pFqxgD2ojJwYAu9opvQ
	(envelope-from <stable+bounces-253635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 21:44:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C15AB896
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 21:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5B423008FDF
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FAE3E5578;
	Thu, 21 May 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MnOdIZCf"
X-Original-To: stable@vger.kernel.org
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E93537C8
	for <stable@vger.kernel.org>; Thu, 21 May 2026 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392671; cv=none; b=kiy8njB2JOPMvYPf5/GccZDsoXB3D4mF2pGOBqGboczequ/EX41Mth5FkqU/k2cOksB6yqsiiQaQH2ILL/LxHhVsUAO9IyWH9qvsgs7u7CF1IjzyV7zuR1FfBavfGr7+z+NipnSQbQDFLg6LJbZ1lDc/EvFCHjhT8P5q9GgKnvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392671; c=relaxed/simple;
	bh=PO5H7A7GY/fG/fRRal98HMNANgyBmt/NZClfqJL1hdM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0fvAZFKur9F89Pv1xg6ZtIjS6BcWt7k7vC+tpGUmRE3ZioRp5HD5q7qzVVKVUy8uYMl8SWGAc7j8/hc7BULbONo81Al6l7BdSQed6bw9Ux+Egoi3ufY0SwP3QHpojZKQXKiE7mQtJ8JZkHlr5VGxarlxsJwotec8Oa5pJ8ysSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MnOdIZCf; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779392661; x=1779651861;
	bh=ZJHv8R9q5MyjuxyrEgiewYR3zKPoFohXYTB44wNpPCo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MnOdIZCfB4Om3/T53rzCCRIVIBKCeu1XeE7QFB9d08goSHC+x6h/eSZfolBfwB0Fs
	 N3iH8zelr18bGlWC1noJMgfwVGKbzYgnpVZ/tP3Tp8yizWvV2k0OswSCWOKVyfr8XC
	 yILfvxVgk1HHFacmtaVr3LxN6TJWeTqyJcJPh9d3Hr50VKdsJ8CQX5V8IQAwhWfWfu
	 ZBQavQGRVw0Y7oHox8K8Mr6yvEiJ0LXnS7bh+tW0PaDJbdLw5swPJ0s+dxxTifZRu/
	 LUbZNTD7aInqdLU5lt+XqsFCPFR/02TbXE5kDURE263NI2iKLmDQOy7zfNpJJKQjTz
	 uCBV5gJ/vvRag==
Date: Thu, 21 May 2026 19:44:15 +0000
To: linux-rdma@vger.kernel.org
From: Tymbark7372 <tymbark7372@proton.me>
Cc: zyjzyj2000@gmail.com, jgg@nvidia.com, leonro@nvidia.com, stable@vger.kernel.org, Tymbark7372 <tymbark7372@proton.me>
Subject: [PATCH 3/4] RDMA/rxe: Fix u64 iova+resid overflow in duplicate_request
Message-ID: <20260521194402.811-4-tymbark7372@proton.me>
In-Reply-To: <20260521194402.811-1-tymbark7372@proton.me>
References: <20260521194402.811-1-tymbark7372@proton.me>
Feedback-ID: 184352754:user:proton
X-Pm-Message-ID: 99b9af42d1d3ebfdda41cc8de5ad3be5c38adf4d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,proton.me];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253635-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tymbark7372@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,proton.me:email,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: A62C15AB896
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the duplicate-READ handling of duplicate_request(), the third
clause of the bound check computes (iova + resid) and compares it
with (res->read.va_org + res->read.length).  iova is u64, resid is
u32 promoted to u64; the addition wraps modulo 2^64.  An attacker
setting reth_va =3D 0xFFFFFFFFFFFFFC00 and reth_len =3D 0x400 causes the
left-hand sum to wrap to 0 while the right-hand sum stays small, so
the check passes and res->read.va is later set to the wrap address on
replay.

Downstream of either bound check site in rxe_resp.c, read_reply
calls rxe_mr_copy() with the wrap iova, which re-traverses
mr_check_range() and rxe_mr_iova_to_index(), and rxe_mr_copy_xarray()
OOB-derefs page_info[huge_idx].  The primitive is the same as patch
1 of this series, reached via the RDMA_READ path on a duplicate
(retransmitted) request.

Use check_add_overflow() on both sides of the comparison.

Reproduced on v7.1.0-rc3 + KASAN with a single
ibv_post_send(IBV_WR_RDMA_READ) followed by a retransmit of the
identical packet, with the wrap iova above.  WARN at
rxe_mr_iova_to_index+0x135 followed by page-fault Oops in
rxe_mr_copy+0x20d on the READ path (rxe_receiver+0x3c70, distinct
from the WRITE offset rxe_receiver+0x6aa8 that the patch 1 trigger
reaches).

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org # v4.8+
Reported-by: Tymbark7372 <tymbark7372@proton.me>
Signed-off-by: Tymbark7372 <tymbark7372@proton.me>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/r=
xe/rxe_resp.c
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1356,11 +1356,16 @@ static enum resp_states duplicate_request(struct rx=
e_qp *qp,
 =09=09=09 */
 =09=09=09u64 iova =3D reth_va(pkt);
 =09=09=09u32 resid =3D reth_len(pkt);
+=09=09=09u64 va_end_orig, va_end_new;

-=09=09=09if (iova < res->read.va_org ||
+=09=09=09if (check_add_overflow(res->read.va_org,
+=09=09=09=09=09       (u64)res->read.length,
+=09=09=09=09=09       &va_end_orig) ||
+=09=09=09    check_add_overflow(iova, (u64)resid,
+=09=09=09=09=09       &va_end_new) ||
+=09=09=09    iova < res->read.va_org ||
 =09=09=09    resid > res->read.length ||
-=09=09=09    (iova + resid) > (res->read.va_org +
-=09=09=09=09=09      res->read.length)) {
+=09=09=09    va_end_new > va_end_orig) {
 =09=09=09=09rc =3D RESPST_CLEANUP;
 =09=09=09=09goto out;
 =09=09=09}
--
2.43.0


