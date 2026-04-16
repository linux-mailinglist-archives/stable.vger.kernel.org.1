Return-Path: <stable+bounces-238335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IDCAGwS4WnoogAAu9opvQ
	(envelope-from <stable+bounces-238335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:46:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69411411F2B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 18:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5636F3063C50
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B5F317163;
	Thu, 16 Apr 2026 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxPv6n5w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D18026159E
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357991; cv=none; b=FQvE7pb37pCEbnQ6aYhzGlyxyauJjTZwXPJUfau5/wfSvLyrXdlYGvLseUnkw0raqSo8Ihe86SJSyfF3s4QZ3NvktnFJfoUsaQTeodBqiRb0t0kK/DEQdOArU3u5jzksS/Hcc4gmHh3oiCFwmUuPHU5nRTi+f0bSTP6YaJCck1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357991; c=relaxed/simple;
	bh=rem8kgb3AqU5fIvtvZXdN3Z05fPs8+9yW+ACN+9nAGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0TnFpUMDspXHjs/xVyoH7z0WimWEbWcKWgvHPOxkI0FKgdzCyaJCgZMp/2jjt1ZwP7V9Zkq6lRvy3v9FI2PfFm1GgHKSMKfxpxlsOVQHuw1bkmyvSNdGUuLPpbSioxnTD6ourDk5Th6Z05MjtHQzUDJdCi7e8Z7KEikMo72W9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxPv6n5w; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so108673535e9.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357987; x=1776962787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yx+tk5XR/nKhfzFOweyHScYa0wnstAD5I5LHNHccNpo=;
        b=hxPv6n5wqWuXLcfu4tXLaoESOCF2mcOdesU87WFYkK4oKOL1NCDfAjLibtz5cu/Ai4
         yGMEkLIlfEVm+HnHPumKzl419F4udciMlHZiC6S/DV4Az1tZaNth3CyVqc5HjfkwX3WB
         OEwVgE9OxEOkti/IrMc9mrqhXejJsYxTpvap06WkNsBOQi845778bR69UnCOaNK1J5MR
         kxGKa51tAhohvKBPhWDqi7NRW8FoxI+4/X7O5AB+0nByvj8MZm1lDJLGK2mgtrvWoW4d
         8z3g9r14Nlx/RG6TuN/WJR5KYXpSm4k6+powEPchkSAGK2AZz/kT0sVGVKv7labPo6+m
         K7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357987; x=1776962787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx+tk5XR/nKhfzFOweyHScYa0wnstAD5I5LHNHccNpo=;
        b=lWB9Vh8PHaCFDInGBw8hahIhQnnLTrcgTEEeQjTO50pur/oWY9EhRWqT2OhRiWQ1vm
         cU/bZl9jxjzO1NmPoqh8EmQlhWXousTeWL9M6mnkRIi1xBHloodB9LEbe9TNL/J6tmpM
         8z1OawCOQSz6d7DMO+a6EqxJ6Yvr3iOd5CkeBxsQeufxxxe1D5qz1r+eRn6QAdUF7Wng
         cDa0w3Sok6Zu1niXsmYPxZ4AuWHWhIA2Q/r0wIwQu7deTYGlYj1Nbl7OmLxF8dlvDPnq
         4yTjRYEtWzQEYEUV92a2ShQoC9Qui4NHhD7aXpyAYw5tLdGPtCSGT5PE1FZ4yM6QARL4
         shCQ==
X-Forwarded-Encrypted: i=1; AFNElJ//dnjHEi0ysi1PwsTt0/ZcJzg/9cDwjXvtpjnh3D967RUvZHjHyvPV4Tp59CYGb/EcvC86hMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTbzwMpf37Ep1EnJIorzT24bxCVluwvh06/Hkv2oLOubYygsU
	CJBpYQsbqNScN86+AvrHZEmV6WrDBkDW+8jIizNZq1Il9CL3ba7wfVY7
X-Gm-Gg: AeBDietBJE8Ptw603AaKWRxH4PTFzalaS/MmjpCLOSN5G/drIacJFuE32yuTfPiA4r+
	J81NvBraCjuXcPGOXI8rT+YP3w4PurRDeeAk5/oEv9GMFaJbEqNkn8p4SsOgjFYj73xf5QquM1K
	/xYffnqDQn55jL7tHSl9yEVcjqhP6jzhOibbsUmz8SNs2kJVfSlnRyh8LuI19pBWUmqFp1HMKid
	fh7KiIZ9HG+M9/Rv87989IvGcC7p6G43QN1sMXLTKx/qVShech56nu7mTo3EA0m8tfUIJVYHh89
	WSf4ca1/h8zK7ZTM63V5DPz4X9EekZBVzmccn+blscVNlLRLfRJAAQUnuFSsuffyJlPWhnXp7rb
	zuTTJtUv/hgtoI3kHQH5VhBRANrVArt7hEDalVaBOe+B3EzhFAL98wsRP1+0xlDnrpgVg9kqoOh
	58QPhiONnXcHp+xVzgrNI=
X-Received: by 2002:a05:600c:4504:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-488d68684fdmr378438015e9.19.1776357987380;
        Thu, 16 Apr 2026 09:46:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f581b9fbsm63217285e9.5.2026.04.16.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:46:26 -0700 (PDT)
Date: Thu, 16 Apr 2026 19:46:23 +0300
From: Dan Carpenter <error27@gmail.com>
To: Delene Tchio Romuald <delenetchior1@gmail.com>
Cc: gregkh@linuxfoundation.org, dan.carpenter@linaro.org,
	luka.gejak@linux.dev, hansg@kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 5/5] staging: rtl8723bs: fix negative length in WEP
 decryption
Message-ID: <aeESXxJwPm95vcWk@stanley.mountain>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
 <20260415185501.440492-6-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415185501.440492-6-delenetchior1@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238335-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid,get_maintainer.pl:url]
X-Rspamd-Queue-Id: 69411411F2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 07:55:01PM +0100, Delene Tchio Romuald wrote:
> In rtw_wep_decrypt(), the payload length is computed as:
> 
>     length = frame->len - prxattrib->hdrlen - prxattrib->iv_len;
> 
> All operands are unsigned. If the frame is shorter than the sum of
> the header length and the IV length, this subtraction wraps around
> and length becomes a huge unsigned value. That value is then used
> to drive an arc4_crypt() call that reads and writes past the end
> of the receive buffer.
> 
> An attacker within WiFi radio range can exploit this by sending a
> crafted short WEP-encrypted frame. No authentication is required.
> 
> Validate that the frame is large enough to contain a WEP payload
> before computing length.
> 
> Found by reviewing length arithmetic in the WEP decrypt path.
> Not tested on hardware.
> 
> Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
> ---
> v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry Luka Gejak's
>     Reviewed-by.
> v3: rebased on staging-next; sent as numbered series with proper
>     Cc from get_maintainer.pl.
> v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
>     apply).
> 
>  drivers/staging/rtl8723bs/core/rtw_security.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index a00504ff29109..f3bc2240749a4 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -113,6 +113,12 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  		memcpy(&wepkey[0], iv, 3);
>  		/* memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength); */
>  		memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[keyindex].skey[0], keylength);
> +
> +		/* Ensure the frame is long enough for WEP decryption */
> +		if (((union recv_frame *)precvframe)->u.hdr.len <=
> +		    prxattrib->hdrlen + prxattrib->iv_len)
> +			return;

LGTM.  Thanks!

regards,
dan carpenter


