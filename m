Return-Path: <stable+bounces-237762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGiTAuT73WkRmAkAu9opvQ
	(envelope-from <stable+bounces-237762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:33:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8D3F7601
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD439304C965
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF643A4507;
	Tue, 14 Apr 2026 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmcWsDwX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34783A3834;
	Tue, 14 Apr 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155337; cv=none; b=Yp2Yqv6ltnaqALmc3zG+w2NzNcD0JMxsvKLMNO1uPtd1vhaHlduvZGgTAwAQo/cYQgtrxa1pcRZCXzxbBZAJqnIug3+QBaLib5OgannlY8LGrjJEX/+R2EYhfcqXk6XS5cy1hXMve55TC2gbUuMw4+Lr8OoEHQh8upDt6M7HCYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155337; c=relaxed/simple;
	bh=isuVJ+2p1Ky02D8Qn8ZqwTlLh+QlZkggmqC1YpiB5+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV3OJsNwQlhSt87dYy6slr+4otZJECUU9dRKotcnRyEIgITJCn5Mz4wACZ8VeE71egxnNxIh2ElZ6U/B5H5E5LOwpmgVEQPrpIGmZZHINMSot5qFD+zw/K7wAiu85kl3FPd0JNDqnP2eJR6pCefRk9HlJrdZJ0zb2aZhSos8lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmcWsDwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0C6C19425;
	Tue, 14 Apr 2026 08:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776155337;
	bh=isuVJ+2p1Ky02D8Qn8ZqwTlLh+QlZkggmqC1YpiB5+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmcWsDwX6VEGc0BQxd2wzobutq75Ym7abdUe0jyBWPaH0IqQ+qiy8PtIGuRmJap1B
	 q7rtnYotkVqL/y70dLqUesMW0sTxARvd64/J1+mgCTvvKYAP+bpen9bvpTxxkyahCk
	 xfQBDSjQepJheB8tYwurH6RWQ2XT/r9crLXyeDn9PRFbc1Vnt2OgGiDookdVOaUBoi
	 uUhoSlRt4ZFOXu+JCI9pMwm8SvKyebp8h5nUgQhW1w62y5Qpk10zY/9waFtrgAzlej
	 BydiblL3VKXzOlPr8ovd84H6SdGSiUhWdCUXTZUC2WAPWAeejiFTSCWkeTlCEEcnF1
	 5X6lIJfKulr2w==
Date: Tue, 14 Apr 2026 09:28:53 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-nfc@lists.01.org,
	stable@vger.kernel.org,
	=?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
Subject: Re: [PATCH net v2 1/3] nfc: nci: fix u8 underflow in
 nci_store_general_bytes_nfc_dep
Message-ID: <20260414082853.GV469338@kernel.org>
References: <20260409164129.GO469338@kernel.org>
 <20260409185958.1821242-1-snowwlake@icloud.com>
 <20260409185958.1821242-2-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409185958.1821242-2-snowwlake@icloud.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237762-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lists.01.org,outlook.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[icloud.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 75F8D3F7601
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 08:59:56PM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nci_store_general_bytes_nfc_dep() computes the number of General Bytes
> to copy from an ATR_RES or ATR_REQ frame by subtracting a fixed header
> offset from the peer-supplied length field:
> 
>   ndev->remote_gb_len = min_t(__u8,
>       (atr_res_len - NFC_ATR_RES_GT_OFFSET),   /* offset = 15 */
>       NFC_ATR_RES_GB_MAXSIZE);
> 
> Both length fields are __u8.  When a malicious NFC-DEP target (POLL mode)
> or initiator (LISTEN mode) sends an ATR_RES/ATR_REQ whose length field is
> smaller than the fixed offset (< 15 or < 14 respectively), the subtraction
> wraps in unsigned u8 arithmetic:
> 
>   e.g. atr_res_len = 0 -> (u8)(0 - 15) = 241
> 
> min_t(__u8, 241, 47) then yields 47, so the subsequent memcpy reads
> 47 bytes from beyond the end of the valid activation parameter data into
> ndev->remote_gb[].  This buffer is later passed to nfc_llcp_parse_gb_tlv()
> as a TLV array, feeding directly into the TLV parser hardened by the
> companion patch.
> 
> Fix: add an explicit lower-bound check on each length field before the
> subtraction.  If the length is smaller than the required offset the frame
> is malformed; leave remote_gb_len at zero and skip the memcpy.
> 
> Both the POLL (atr_res_len / NFC_ATR_RES_GT_OFFSET = 15) and the LISTEN
> (atr_req_len / NFC_ATR_REQ_GT_OFFSET = 14) paths are affected; both are
> fixed symmetrically.
> 
> Reachability: the ATR_RES is sent by an NFC-DEP target during RF
> activation, before any authentication or pairing.  The bug is therefore
> reachable from any NFC peer within ~4 cm.
> 
> Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")

The above commit seems to move rather than add the logic in question.
It seems to me that the following would be the fixes tag corresponding
to the commit that introduced this problem.

Fixes: 767f19ae698e ("NFC: Implement NCI dep_link_up and dep_link_down")

> Cc: stable@vger.kernel.org
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
> ---
>  net/nfc/nci/ntf.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index c96512bb8..8eb295580 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -631,25 +631,31 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
>  	switch (ntf->activation_rf_tech_and_mode) {
>  	case NCI_NFC_A_PASSIVE_POLL_MODE:
>  	case NCI_NFC_F_PASSIVE_POLL_MODE:
> +		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
> +		    NFC_ATR_RES_GT_OFFSET)
> +			break;
>  		ndev->remote_gb_len = min_t(__u8,
> -			(ntf->activation_params.poll_nfc_dep.atr_res_len
> -						- NFC_ATR_RES_GT_OFFSET),
> +			ntf->activation_params.poll_nfc_dep.atr_res_len
> +						- NFC_ATR_RES_GT_OFFSET,
>  			NFC_ATR_RES_GB_MAXSIZE);

I'm not suggesting changing this, at least not as part of this bug fix, so
this comment is FTR: As NFC_ATR_RES_GB_MAXSIZE is a compile time constant,
and the condition added by this patch ensures that the result of the
subtraction is not negative, I strongly suspect that using min() here
sufficient and thus more appropriate than min_t().

>  		memcpy(ndev->remote_gb,
> -		       (ntf->activation_params.poll_nfc_dep.atr_res
> -						+ NFC_ATR_RES_GT_OFFSET),
> +		       ntf->activation_params.poll_nfc_dep.atr_res
> +						+ NFC_ATR_RES_GT_OFFSET,
>  		       ndev->remote_gb_len);
>  		break;
>  
>  	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
>  	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
> +		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
> +		    NFC_ATR_REQ_GT_OFFSET)
> +			break;
>  		ndev->remote_gb_len = min_t(__u8,
> -			(ntf->activation_params.listen_nfc_dep.atr_req_len
> -						- NFC_ATR_REQ_GT_OFFSET),
> +			ntf->activation_params.listen_nfc_dep.atr_req_len
> +						- NFC_ATR_REQ_GT_OFFSET,
>  			NFC_ATR_REQ_GB_MAXSIZE);
>  		memcpy(ndev->remote_gb,
> -		       (ntf->activation_params.listen_nfc_dep.atr_req
> -						+ NFC_ATR_REQ_GT_OFFSET),
> +		       ntf->activation_params.listen_nfc_dep.atr_req
> +						+ NFC_ATR_REQ_GT_OFFSET,
>  		       ndev->remote_gb_len);
>  		break;
>  
> -- 
> 2.51.0
> 

