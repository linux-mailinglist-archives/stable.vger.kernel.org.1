Return-Path: <stable+bounces-237728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL6sKqLc3WlwkQkAu9opvQ
	(envelope-from <stable+bounces-237728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:20:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B43F5E4D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA0C830143F0
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 06:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247543254AE;
	Tue, 14 Apr 2026 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/1zMhUi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C72FFF88
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776147597; cv=none; b=AHBPGzoVD9wsjmPaTq+Y6O7r60rO/4Mgi8vRa0UOT54QaLg/9x/MA6U0IRcH4AHmDBWyOsSSBzt4HU5K3XQaLXBNuyuR78DasaUsbRqveCCTMsBbb07Pu2+LWg0ZimWgvW203MuM7w6us0td8qit1MSLe6shj2IHTwTSOMyVxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776147597; c=relaxed/simple;
	bh=4Au1vWYJQM/cCNLFocF4rxkQ5SdzGdbWeMDXgvcfb0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uec9Kf3TXzNuCWg6dgOJrYrysWW474P6g2h0zhZCQP+MsMGAVa6a5HUvAZz2czVhfL6chSDSNkk7WTAPdbLCnoIHLv9VSqYf78EJbY/SQG7RJhzRZSP96aNM0OsoaJ5YEk9iNr+YXyx9q1lyO/Rk51uBwBGtqnLw8/s1sn9nDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/1zMhUi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so3301557f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776147594; x=1776752394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrvVMoJ7yb4IwANqTPw15SzHZNBEW/67dLCXkZ79KHk=;
        b=Z/1zMhUi7x9PI+YhaJoMwNXofl7okJyvWHd0oZvckkaqnM4TJYnSIZPz/5RNLUWpTE
         qIiyBnAbSXPCnsjSGiPnSF88rc1iy8sbIXMuBbo6nN6BFpJ6pnIRaZai5wXOzK+pWSwa
         416QvRANIGrXfVsqd8qLEy9WaRxHPQoisPPZu69q6zfGvO0uN1B4nlkbE7yewhWWS6SE
         5otGHyYfqzDh16Z8thsqlSSG77RqBZRagce2icvd/llY77s6BtJnIc9vbcYCwL+rXDQf
         DWkiRNA3FTHciyAH4ukSiKscBPGPh1J+MCmkxvBRtoVtwZBwQTTanhrVROagIT2I/Ftp
         LGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776147594; x=1776752394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrvVMoJ7yb4IwANqTPw15SzHZNBEW/67dLCXkZ79KHk=;
        b=Yuz5r3yNpaZ7dBRLSsqz8B0x3Yzzcw8NqXGjIJPPQ0v5KcKd6Ya2VrAoqWGASz6P2n
         JBYrJU4W4XVgeAtNAZztJjKMOybjSLM3bFOc8Zs/42ECo28eWxp+d+Ui586MT7izqFw1
         8KjiPNto9XAeKwzXkg04PE6p1uzJQJi07JdrWf5oC+E8XUTPP8lrx/Zc9WzPpCgkjWEz
         rjsBFqmTd59buLssVPdekD5d4k24pmcxKPPwBbWsxmtGCPK5pjs+z0TpxJZoHnsTrb9R
         g8JwMHEtHDXOyuI2Smqbld0kZoM7q2uTN2el9Uoy8KlfdUzU/UO+4coBz7OhT3uKLO2V
         g8ZA==
X-Forwarded-Encrypted: i=1; AFNElJ85+90K22mj9Q8Ltl8eZNjG6kRe6TPvz3mLgh+DsiffLH9nNTpfZFWajVpk/YxEKT0iTo/6nwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/Lx/GvcyGNAnTOptbCI+9F9h7aA2BzzjqnrRWhyKr1K4NghX
	CJycEUjWuyQAjkTC49NfCInTKnR1fWiWOdX4m7xLAoq30Dp/RFqhq7kV
X-Gm-Gg: AeBDiesipAQNsnJ7cruxFRPPJLQhJqxFLqHLAT3/0JwEsZqj1S1aAhs6lkehKYWZJvJ
	GcAf9NMk7KnvJNPkSwQeo7vgs1r1BGI25OxTriKNYpfY+WAuHUGLMYkCM3vdtzNG0RFfJ23MLOP
	RKvh6hi9UcKMH3hsTucl7RwJKJhJv9tNmWZlJjSEq76P2t+7dT+gfu8mt+0XdZ0OyEZWB4x81SO
	qZugkm6SwIbFKzzaQ0m0+5PMOJF5JoG2K4qSrb3hYrT5hoykg3wYmFBr+HBG9rdcBrnwE5kmMlc
	IR8ZBR+huFsFHclzM2HnnYCyt0gR0/tuRnmt/LPFAVLD5IfqY5bjc/bdzM3drt76DJj8SCzLxL7
	aGxx4vtKNSJY2MHAAnnvfA+OhV+r/JqLSUd1GeQMbwIUAbSo+eTW3Psygej1wp3wPlWv7ykxfzD
	Qfk3f4woBAFGnW7um5
X-Received: by 2002:a05:6000:40dd:b0:43d:7e5b:928c with SMTP id ffacd0b85a97d-43d7e5b9a32mr4274358f8f.47.1776147594334;
        Mon, 13 Apr 2026 23:19:54 -0700 (PDT)
Received: from localhost ([41.210.143.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7794cce5sm16097713f8f.9.2026.04.13.23.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 23:19:53 -0700 (PDT)
Date: Tue, 14 Apr 2026 09:19:47 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	hansg@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix heap overflow in OnAuthClient
 shared key path
Message-ID: <ad3cgzGxPVYLiJbe@stanley.mountain>
References: <20260413202824.740653-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413202824.740653-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237728-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 258B43F5E4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 10:28:24PM +0200, Alexandru Hossu wrote:
> rtw_get_ie() returns the raw IE length from the received frame, which
> can be up to 255. This length is used directly in memcpy() into
> chg_txt[128] with no bounds check, allowing a heap overflow of up to
> 127 bytes when a rogue AP sends an Auth seq=2 frame with a Challenge
> Text IE longer than 128 bytes.
> 
> IEEE 802.11 mandates the Challenge Text element carries exactly 128
> bytes of challenge data. Reject any element whose length field does not
> match sizeof(pmlmeinfo->chg_txt) (128).
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>

Looks good.

Reviewed-by: Dan Carpenter <error27@gmail.com>

> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 5f00fe282d1b..90f27665667a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -891,7 +891,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
>  			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
                                       ^^^^^^
Do we know that pframe has enough data?

KTODO: check if pframe is large enough in OnAuthClient()

regards,
dan carpenter

>  				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
>  
> -			if (!p)
> +			if (!p || len != sizeof(pmlmeinfo->chg_txt))
>  				goto authclnt_fail;


