Return-Path: <stable+bounces-238028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH2JC4EY32n+OgAAu9opvQ
	(envelope-from <stable+bounces-238028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:48:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0F74003EE
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F25301F5EE
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FB35BDCA;
	Wed, 15 Apr 2026 04:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DV5ve2dW"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092B2D5926
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776228477; cv=none; b=JVfjxTvP7xYDreiN8aSGE5JAFGfBuriU56ieehaQxX71e98HOxaNnq6lDrHV8PCkEBBSAmr1eNMOdxSx9wwdJqzH5+hnHCG2wTxo4DfnohN0RBKqUR8QtpAGXlcXg5VO+XdC9lg8zKFmPMncR5M3HkJKNk9TIBJZfq1BhzUmdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776228477; c=relaxed/simple;
	bh=V4tWRgfrZHqFRIp8Iloxse17iPng/gnEL8wg0RiELes=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qlNBx57aCcCqJqibKmUrd9yFfaZqUoZvZGX0BQ6Bi2fQIzTqWOmWED4rJta0fHTlRqjnpHAYVW1GjJ5LbgjAsDrfm0M5ASWXs6aRxaI4cQcZTNMmtXFpS3mt8KN28h8rZF9q7/kZQaVj74keRo8U8Rmuz04RHYtFdTmTeyKS7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DV5ve2dW; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776228463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cr4IcaatDSq2o82btypoJMqcFwPBKgoNsLuXtTkdZ1M=;
	b=DV5ve2dWahbmepJavofCzLXOiUSwlEZidf/R2s7+wgflEKOfJ/nK9Il6BFzhCm+MgZMpqa
	zeb8wWZi+RTbsShSgLiyIgzfB2S9sSD++ogWD5RNU8ngCN404ejb+yXk74CtVNesa3NMQC
	k1Eq7/a1krkfSEC981mNLf82d2BV3EE=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 06:47:35 +0200
Message-Id: <DHTGFRNBOT79.2SLRPIN3GFMMV@linux.dev>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix missing frame length checks
 in OnAuthClient
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luka Gejak" <luka.gejak@linux.dev>
To: "Alexandru Hossu" <hossu.alexandru@gmail.com>,
 <gregkh@linuxfoundation.org>
Cc: <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <error27@gmail.com>, <stable@vger.kernel.org>
References: <20260414213959.1028301-1-hossu.alexandru@gmail.com>
In-Reply-To: <20260414213959.1028301-1-hossu.alexandru@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238028-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D0F74003EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Apr 14, 2026 at 11:39 PM CEST, Alexandru Hossu wrote:
> OnAuthClient() accesses pframe without first verifying that pkt_len is
> large enough to contain a valid 802.11 management frame header:
>
> - get_da(pframe) reads bytes 4-9, requiring pkt_len >=3D 10
> - GetPrivacy(pframe) reads the FC field at bytes 0-1
>
> Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
> unsigned subtraction passed to rtw_get_ie() wraps around, causing it
> to scan well past the end of the buffer.
>
> Add an early check against WLAN_HDR_A3_LEN before any pframe access,
> and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
> offset to guard the seq/status reads and the rtw_get_ie() call.
>
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---
> Changes in v2:
> - Replace incorrect Reported-by tag with Suggested-by: Dan spotted the
>   missing length check during code review of the heap overflow fix; he
>   did not file a separate bug report
> - Add missing version changelog (the initial submission was incorrectly
>   labeled v2; no v1 was ever sent to the list)
>
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/stag=
ing/rtl8723bs/core/rtw_mlme_ext.c
> index 90f27665667a..884cd39ec756 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -860,6 +860,9 @@ unsigned int OnAuthClient(struct adapter *padapter, u=
nion recv_frame *precv_fram
>  	u8 *pframe =3D precv_frame->u.hdr.rx_data;
>  	uint pkt_len =3D precv_frame->u.hdr.len;
> =20
> +	if (pkt_len < WLAN_HDR_A3_LEN)
> +		goto authclnt_fail;
> +
>  	/* check A1 matches or not */
>  	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
>  		return _SUCCESS;
> @@ -869,6 +872,9 @@ unsigned int OnAuthClient(struct adapter *padapter, u=
nion recv_frame *precv_fram
> =20
>  	offset =3D (GetPrivacy(pframe)) ? 4 : 0;
> =20
> +	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
> +		goto authclnt_fail;
> +
>  	seq	=3D le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + of=
fset + 2));
>  	status	=3D le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN +=
 offset + 4));
> =20

LGTM.
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Best regards,
Luka Gejak

