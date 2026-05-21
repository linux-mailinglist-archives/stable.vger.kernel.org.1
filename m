Return-Path: <stable+bounces-253631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKB2EZlgD2ojJwYAu9opvQ
	(envelope-from <stable+bounces-253631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 21:44:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7055AB866
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 21:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F7AF303A64A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D243839AC;
	Thu, 21 May 2026 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Gk/0lcBy"
X-Original-To: stable@vger.kernel.org
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E63E16B1
	for <stable@vger.kernel.org>; Thu, 21 May 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392659; cv=none; b=QOFtkIgdbvOeWi/Eh67OozlF64a7COtkdZ5xu/EXEDQbx6Eh1zNFi1b7d/ZOx33+Es1mpFjK6ypcauJWxvEk+Dvo8zN2Uy+za7K2Fj1Ir9bXcjd1DnVRLanfXPjwTrLUt2pWHkaWtWUo4K+WMAxGK2Rf2PWQJuUGOO2siYB1z3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392659; c=relaxed/simple;
	bh=/jVx6DgJWdmFRCpDe1p1tUHTZzQJF37r/8KThwnzvbQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqeSoX6pBdHfncEfVx2GJDYWxl1qn/k5dkEUvdQJbHGuGmG5trTJZxBMlef0EknM8SrwQgeG3JtIjEv6Sbky8VbQH00BLvkbbPbBV3iVDzk6H2uWxjy3Q3My2IC/jCPUp0Irp+nqjJlLN8uzP0/4lukfVFEx8HtUcI8IMq+/nvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Gk/0lcBy; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779392653; x=1779651853;
	bh=n4hrv0Ymlp2Uanz+ze7k7ucGfOqgi1atWwF61pMB24U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Gk/0lcBy03tsgsY/Q2MNuMd9COM755k8+CcrNqopmsBvyXbMUiqIpSe5xUjUc8x47
	 HRtRJq7wBZ72p5Gk7OAJwhDt8+/fIIO/4/eQN53LbSguEAHZ6/9/jUt3o5f/ESadCE
	 bZDKv9msbR6JfhkrEL9dzpOVxOy1D29c4I6b4tvXD2SYgKdGyiwcdA/1ChpgzqV9sq
	 JkCG5QIWx/JX5w+9ZuFCctoskxXnoSD5zTSBDnJ8ORsv7hbaLM5abgYIwbxm5V2dK6
	 oeEo3x+6BdUiH0dxGYKuSfOtvKEaHyUWG2L3MeWjQhTdkzfVAucEzzjrXofL/d8eO0
	 +bX79UhNRI8hQ==
Date: Thu, 21 May 2026 19:44:08 +0000
To: linux-rdma@vger.kernel.org
From: Tymbark7372 <tymbark7372@proton.me>
Cc: zyjzyj2000@gmail.com, jgg@nvidia.com, leonro@nvidia.com, stable@vger.kernel.org, Tymbark7372 <tymbark7372@proton.me>
Subject: [PATCH 1/4] RDMA/rxe: Fix u64 iova+length overflow in mr_check_range
Message-ID: <20260521194402.811-2-tymbark7372@proton.me>
In-Reply-To: <20260521194402.811-1-tymbark7372@proton.me>
References: <20260521194402.811-1-tymbark7372@proton.me>
Feedback-ID: 184352754:user:proton
X-Pm-Message-ID: 557a0e50bb990c1a0c06b03a9bd96850fae6fa84
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org,proton.me];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253631-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,proton.me:mid,proton.me:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE7055AB866
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mr_check_range(), the IB_MR_TYPE_USER and IB_MR_TYPE_MEM_REG case
computes both iova + length and mr->ibmr.iova + mr->ibmr.length without
overflow check.  Both iova (u64) and length (size_t) are 64-bit on
64-bit platforms.  An attacker setting iova =3D 0xFFFFFFFFFFFFFC00 and
length =3D 0x400 wraps the sum to 0, so the bound check
"iova + length > mr->ibmr.iova + mr->ibmr.length" passes.

After the bypass, rxe_mr_iova_to_index() computes a huge index value;
WARN_ON(idx >=3D mr->nbuf) fires but does not abort, and
rxe_mr_copy_xarray() then dereferences page_info[huge_idx], an
attacker-controlled out-of-bounds slot.  In the RXE_TO_MR_OBJ
direction this becomes an OOB write of attacker payload bytes through
info->page + info->offset.

Use check_add_overflow() on both ends to reject any iova/length pair
that wraps.  Also explicitly scope the local declarations introduced
by the helper variables.

Reachable from any unprivileged local process with
/dev/infiniband/uverbs0 open (world-rw on distros that ship the
rdma-core udev rules) and from an unauthenticated remote peer over
UDP/4791 (RoCEv2) when the target rkey/QPN are known.  Reproduced on
v7.1.0-rc3 + KASAN with a single ibv_post_send(IBV_WR_RDMA_WRITE) and
the wrap iova above; the kernel oopses in rxe_mr_copy+0x20d after
WARN at rxe_mr_iova_to_index+0x135.

Site A in rxe_resp.c (check_rkey()) reaches mr_check_range() with
attacker iova as well, so this patch also closes that path; Site B
(duplicate_request, also in rxe_resp.c) has an independent inline
check that wraps and is fixed in patch 3 of this series.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org # v4.8+
Reported-by: Tymbark7372 <tymbark7372@proton.me>
Signed-off-by: Tymbark7372 <tymbark7372@proton.me>
Assisted-by: Claude:claude-opus-4-7
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe=
/rxe_mr.c
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -30,13 +30,19 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t =
length)
 =09=09return 0;

 =09case IB_MR_TYPE_USER:
-=09case IB_MR_TYPE_MEM_REG:
-=09=09if (iova < mr->ibmr.iova ||
-=09=09    iova + length > mr->ibmr.iova + mr->ibmr.length) {
+=09case IB_MR_TYPE_MEM_REG: {
+=09=09u64 iova_end, mr_end;
+
+=09=09if (check_add_overflow(iova, length, &iova_end) ||
+=09=09    check_add_overflow(mr->ibmr.iova, mr->ibmr.length,
+=09=09=09=09       &mr_end) ||
+=09=09    iova < mr->ibmr.iova ||
+=09=09    iova_end > mr_end) {
 =09=09=09rxe_dbg_mr(mr, "iova/length out of range\n");
 =09=09=09return -EINVAL;
 =09=09}
 =09=09return 0;
+=09}

 =09default:
 =09=09rxe_dbg_mr(mr, "mr type not supported\n");
--
2.43.0


