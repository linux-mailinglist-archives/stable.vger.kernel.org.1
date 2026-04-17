Return-Path: <stable+bounces-238406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOwxK8LG4WllyAAAu9opvQ
	(envelope-from <stable+bounces-238406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:36:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B484171ED
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFFF430201AE
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7EC21CC59;
	Fri, 17 Apr 2026 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2HGT7QD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55882DCF55
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776404153; cv=none; b=EbnEmO2bnlsvvOe+3WjM6UcyL/g048shyPZVYZrJKa+oiLd/+YKNzHO3X4EhXAtmDTO6kb7R2G61n82vmxqxgqamwvs+c1m0KzGBhXgLUDnez7coLmTW8Wj56/E4ZfLN58b7S98H1JvuVZpQgFyxNlA6JYYexwH18n2gd03MNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776404153; c=relaxed/simple;
	bh=H7Xq2K5I8hzgnXyhrf2co5G5yOb2ZO9zyuH3/e/iFYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYMt/qMwDNAfzQJFkZ9GxEmFuJxcb70ryALGZJV9GQkVY7wdOYH3vdsl2iNmWEsF5reFNPS3COMPDgLGXAuo28Fi3woI+z79zm34BNsgn5fBkxjK1VAJof5G2+PubzhXPDcWUBRW7vKqIdbKW/HFvlal9Z1Z2rvnhI86pX9+u1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2HGT7QD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe608cb92so26876f8f.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776404150; x=1777008950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Te/LO0MnsMHbXYIyZUpJ0thN+bRfr4i4+FjbbQ/Rk7k=;
        b=U2HGT7QD0wTihvJMQvdglvJxK0rx62dJepP3dJ1eCcvrWf3VN0vo7Zramtcg2ktsXf
         jYhRh9Z9MTsM1yax99rNT+rUT65MG4zCuRHAu14rlypMhQLQuSRzf8V/dw7oLFh/SmHF
         eveT8SOgP8OfcblXNFYwlgUWYXReHXGrWL3E24ljf+MEqgsFLlbeqkIRko1nE+S+Z+2X
         9c7+m0a+owajuHhkoEA5vlDVr7bRJ01DFcYLCWEb3v2HbHRJfWABEKaN2RuiadnnTVIR
         VJ+s00AMQU2+GL1cPeyydoldC6PNiAQ7oOmkERdme5cNjr3SCXX3QEOzWCGTApFOadcZ
         AqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776404150; x=1777008950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te/LO0MnsMHbXYIyZUpJ0thN+bRfr4i4+FjbbQ/Rk7k=;
        b=JfYpgGTkMXjo2jtqtGy2WhTkbGCP/7UbGF4J6q6y8vCznp4qA4vFXrF4IckJKXRSl6
         iu1zLEBsFvqCgz8sojAYoQ6HZlPOYnmoQXFN1pn9hjNseOV6Hxrl7u9tsKXGNdFZuTi6
         BfulYL0oCEMj/9IwM2uEO9PB0A8HshoyE1hf8zFL1AAMCGxJoaM7uIlk5k3Nu8Zb3F/d
         kvMDqtATq536IXMuL+0qCbQ0H5+x5Hd2qFqfBwV8mCMb/e0jjrcKgZGUTigqC83B4DUI
         O7czSZkjIh/5O/cMhPbQAD1HzFRUgKCl4/6Isxf4XV44C1MqhLovrq3JaGo+royFxEus
         mfGA==
X-Forwarded-Encrypted: i=1; AFNElJ/MXWQZpwP3J5I3viGKVxjGk0TE4JCnwQTPc8R5JNl3xlH0t4c3mEbFiLVg91Ah1JqsMG48Amk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFFrGrmyviB2vKYiytxULsWeDhQNwaITmKH60rV0B99vwPl1r
	PEqqz4zvzZEsJLxUJK7aOBD4SW/2O6XM3JAe5OIsVJA5O2ySfcH9X0GK
X-Gm-Gg: AeBDieukrwNhTxASQflf8Y/6mCLXbVJTjaRmMCl3xKQH7Ru85+brtDABv7LmHZQnBwh
	Efxa3OHAOr+N3T/pP5nc6INqAaotaOqs6gxXx08cYPnqu1xAw5760roA/vP+o+lvbqAzW02kUyr
	0/7Ct+WVXjDkkH7yQ1IvyJtTRPihUNkqbbepDSQFF7obD+xYIM9O1w7Ch+3KKL1LaNjoiCw3LKP
	jd1+y+QYKpxHDkOj5vEyLniqrKhJJsM91h0tkz8f7DxgRBwylnO2It93M8wbEOlZBsX+SnsmG5T
	dCwwLOv5xaR0sV4qfv7NRnN4Oucw9idQUtLGFYzeNICEatIi75ZOvPOtu9Xuc5kJWHXECZCpDby
	eVW/jnqCIaTXALqKYz7XG5w4OG9YX2/CNg1ExZMWOdTj1ZLNKe8YO4j9F6o9quEv2jLMn1sYYJV
	DYIoi5WUTn8UHfZUuzC87+BRC7m00Y5Q==
X-Received: by 2002:a05:6000:1ac9:b0:43d:2f94:3b40 with SMTP id ffacd0b85a97d-43fe3db343dmr1761578f8f.6.1776404150220;
        Thu, 16 Apr 2026 22:35:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a397sm1875966f8f.23.2026.04.16.22.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 22:35:49 -0700 (PDT)
Date: Fri, 17 Apr 2026 08:35:46 +0300
From: Dan Carpenter <error27@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, luka.gejak@linux.dev, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 3/5] staging: rtl8723bs: fix out-of-bounds read in
 portctrl()
Message-ID: <aeHGsjwV5_qIuT5U@stanley.mountain>
References: <20260417030110.42991-1-delenetchior1@gmail.com>
 <20260417030110.42991-4-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417030110.42991-4-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238406-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 81B484171ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 04:01:08AM +0100, Delene Tchio Romuald wrote:
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 40884788a30d6..b11982fbe7e1f 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -537,20 +537,25 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
>  			/* blocked */
>  			/* only accept EAPOL frame */
>  
> -			prtnframe = precv_frame;
> +			/* Ensure frame has LLC header and ether_type */
> +			if (pfhdr->len < pattrib->hdrlen +
> +			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
> +				rtw_free_recvframe(precv_frame,
> +						   &adapter->recvpriv.free_recv_queue);
> +				return NULL;
> +			}
>  
>  			/* get ether_type */
> -			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;
> +			ptr += pattrib->hdrlen + pattrib->iv_len + LLC_HEADER_LENGTH;

Don't do this unrelated cleanup.

>  			memcpy(&be_tmp, ptr, 2);
>  			ether_type = ntohs(be_tmp);
>  
> -			if (ether_type == eapol_type)
> -				prtnframe = precv_frame;
> -			else {
> -				/* free this frame */
> -				rtw_free_recvframe(precv_frame, &adapter->recvpriv.free_recv_queue);
> -				prtnframe = NULL;
> +			if (ether_type != eapol_type) {
> +				rtw_free_recvframe(precv_frame,
> +						   &adapter->recvpriv.free_recv_queue);
> +				return NULL;
>  			}
> +			prtnframe = precv_frame;

Same.  If you really want to do it, it has to be in a separate patch.

regards,
dan carpenter

>  		} else {
>  			/* allowed */
>  			/* check decryption status, and decrypt the frame if needed */


