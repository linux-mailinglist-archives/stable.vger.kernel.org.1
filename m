Return-Path: <stable+bounces-241537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDgSBKqN8Gl4UwEAu9opvQ
	(envelope-from <stable+bounces-241537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:36:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC0E482BCB
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCD830A8E0E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A7E3EAC61;
	Tue, 28 Apr 2026 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="swHwywU9"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA33E929C
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777371488; cv=none; b=jsnEknx816eULHHiayjM2HP6aLZ9vQuwpF3LVeNYf9nWF6tY2dWbW5x0xwb9tHOLJxJoICz4+Tw5H8tPbqIuc+BNThEKXfXBySqo1n3SqlfsyCLuX43kv/Ap78z/4pZl8lkrbYh5taxNKV1OPqZXQlm9ixQs/P4X1kTeiq9U6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777371488; c=relaxed/simple;
	bh=/96AFtQ3AjYvodnokRLrLdJbnib/vOraiPwssWkAx3Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CY21EhAOtJXi3fM/CA9FCGkFylTJDQH0y6S5B73Ck2tVJlsTctHpxMkOnPmUNmxxrMelud4prZN5GmN2EgeY67BTwoqAl+3oUH1zM8G/e0fEZ7vQVQOz5rbhh1N5lNh/em/BwJ6l4zbN3RDnJXc19AAiYN7QNUaUa26elPAv/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=swHwywU9; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Apr 2026 12:17:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777371481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYLTZQNmY70dI4lwJn196u39RitunF/ihzdtxt+2TgE=;
	b=swHwywU9twHoJD+2loJyR0b6NpmQGwELylU47MBj0clzYd0E1AcPOfTlb9OrIYeozeEyCU
	l4PasK/ExWvPoGcj/i9NUQLWYESj71iMspZg0KwdyWc2EsOoA6e9+o3kb1Bglavb30of5R
	IIPoYqnE4aL+UemFPMATmnp33AXxj1U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Alexandru Hossu <hossu.alexandru@gmail.com>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
CC: error27@gmail.com, hossu.alexandru@gmail.com, stable@vger.kernel.org,
 luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/2=5D_staging=3A_rtl8723bs?=
 =?US-ASCII?Q?=3A_fix_OOB_read_in_OnAssocRsp=28=29_IE_loop?=
In-Reply-To: <20260428091621.739680-3-hossu.alexandru@gmail.com>
References: <20260428091621.739680-1-hossu.alexandru@gmail.com> <20260428091621.739680-3-hossu.alexandru@gmail.com>
Message-ID: <1E3772B0-8C58-4227-84E8-E9A4E9069B41@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5AC0E482BCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,lists.linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-241537-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

On April 28, 2026 11:16:21 AM GMT+02:00, Alexandru Hossu <hossu=2Ealexandru=
@gmail=2Ecom> wrote:
>The IE parsing loop in OnAssocRsp() advances by (pIE->length + 2) each
>iteration but only guards on i < pkt_len=2E When a malicious AP sends an
>AssocResponse whose last IE has only one byte remaining in the frame
>(the element_id byte lands at pkt_len-1), the loop reads pIE->length
>from pframe[pkt_len], which is one byte past the allocated receive buffer=
=2E
>
>Additionally, even when the header bytes are in bounds, pIE->length
>itself can extend the data window beyond pkt_len, silently passing a
>truncated IE to the handler functions=2E
>
>Add two guards at the top of the loop body:
>  1=2E Break if fewer than sizeof(*pIE) bytes remain (can't read header)=
=2E
>  2=2E Break if the IE's declared data extends past pkt_len=2E
>
>Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
>Cc: stable@vger=2Ekernel=2Eorg
>Signed-off-by: Alexandru Hossu <hossu=2Ealexandru@gmail=2Ecom>
>---
> drivers/staging/rtl8723bs/core/rtw_mlme_ext=2Ec | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext=2Ec b/drivers/st=
aging/rtl8723bs/core/rtw_mlme_ext=2Ec
>index c646dc2a1741=2E=2E68ce422305ed 100644
>--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext=2Ec
>+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext=2Ec
>@@ -1406,7 +1406,11 @@ unsigned int OnAssocRsp(struct adapter *padapter, =
union recv_frame *precv_frame)
> 	/* to handle HT, WMM, rate adaptive, update MAC reg */
> 	/* for not to handle the synchronous IO in the tasklet */
> 	for (i =3D (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
>+		if (i + sizeof(*pIE) > pkt_len)
>+			break;
> 		pIE =3D (struct ndis_80211_var_ie *)(pframe + i);
>+		if (i + sizeof(*pIE) + pIE->length > pkt_len)
>+			break;
>=20
> 		switch (pIE->element_id) {
> 		case WLAN_EID_VENDOR_SPECIFIC:

LGTM,

Reviewed-by: Luka Gejak <luka=2Egejak@linux=2Edev>

Best regards,
Luka Gejak

