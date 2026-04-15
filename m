Return-Path: <stable+bounces-238099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEe9InFy32mFTAAAu9opvQ
	(envelope-from <stable+bounces-238099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:11:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A034039BB
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E228030B5A9D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF58F3659F6;
	Wed, 15 Apr 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m2O5hojG"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F661DDC37
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251431; cv=none; b=jqoqB24yKntHzzT2YwUUIvi+oHbPT/GHWJnlck6qh903i3GuTZnlVxgA6u1C5HS9bz68E9rWe168KyV1xJGdYm68M/R8eCiXT2jKym+MQ8ZRH+yfUb5taEXQU3iETFKzwhlfDU0gky+adR9r8pFSjLd9/xNig4sfdXdQF3bcq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251431; c=relaxed/simple;
	bh=8er+gTBwZ36ynJPRrHyMd0ut0wFbVbXvajAWpf2ejOA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Awv8RFQ7agZddlUZ0URhPTNzirFCyHwUDLns8dVabLQbLO/X/gzwrZXaT5LhFolbayVDq+AMi2Ir04MsRwAvQPunKoPkBRuzEq4oZ3jHONohlYA6E3aretc8+W+Ip5D2/4cqm6R2JCyhSvDPSFa9A4Vdb2rdHScIvQW2gOrLHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m2O5hojG; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776251418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tex46EAOolLu+S909IVM19QvVWWM/IxWtbPZBOkUGK4=;
	b=m2O5hojG419frKZTArcQEnwNypIzIp6ZQoJcPlFwPkl/Q5uqW7wadS+gVsAbYboaDfSY4N
	yztodXW4Qw2s6FlNx46lgrWGO6k4quEiO9p2L15ciy/u/hrD1aRhewGrT7bDx9kNNLWtUf
	v0coxZLUp7AJlHEGlvuU3HQJWLRJCiw=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 13:09:57 +0200
Message-Id: <DHTOKJ7E4RQY.3LOBNWLK5XORQ@linux.dev>
Cc: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <error27@gmail.com>, <stable@vger.kernel.org>, <luka.gejak@linux.dev>,
 <hansg@kernel.org>
Subject: Re: [PATCH v6 1/2] staging: rtl8723bs: fix heap overflow in
 OnAuthClient shared key path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Alexandru Hossu" <hossu.alexandru@gmail.com>,
 <gregkh@linuxfoundation.org>
References: <20260415094505.1115208-1-hossu.alexandru@gmail.com>
In-Reply-To: <20260415094505.1115208-1-hossu.alexandru@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238099-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: E8A034039BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 15, 2026 at 11:45 AM CEST, Alexandru Hossu wrote:
> rtw_get_ie() returns the raw IE length from the received frame, which
> can be up to 255. This length is used directly in memcpy() into
> chg_txt[128] with no bounds check, allowing a heap overflow of up to
> 127 bytes when a rogue AP sends an Auth seq=3D2 frame with a Challenge
> Text IE longer than 128 bytes.
>
> IEEE 802.11 mandates the Challenge Text element carries exactly 128
> bytes of challenge data. Reject any element whose length field does not
> match sizeof(pmlmeinfo->chg_txt) (128).
>
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Cc: hansg@kernel.org
> Reviewed-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---
> Apologies for the version numbering confusion across previous iterations.
>
> Changes in v6:
> - Add hansg@kernel.org to Cc (original driver author; accidentally
>   omitted from the v5 series)
> - Patch content unchanged from initial submission
>
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/stag=
ing/rtl8723bs/core/rtw_mlme_ext.c
> index 5f00fe282d1b..90f27665667a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -891,7 +891,7 @@ unsigned int OnAuthClient(struct adapter *padapter, u=
nion recv_frame *precv_fram
>  			p =3D rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EI=
D_CHALLENGE, (int *)&len,
>  				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
> =20
> -			if (!p)
> +			if (!p || len !=3D sizeof(pmlmeinfo->chg_txt))
>  				goto authclnt_fail;
> =20
>  			memcpy(pmlmeinfo->chg_txt, p + 2, len);

LGTM.

Reviewed-by: Luka Gejak <luka.gejak@linux.dev>

Best regards,
Luka Gejak

