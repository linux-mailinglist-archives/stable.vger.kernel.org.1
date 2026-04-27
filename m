Return-Path: <stable+bounces-241273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJKdNV8r72mb8wAAu9opvQ
	(envelope-from <stable+bounces-241273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:24:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93F46FDE2
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D265E3022566
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55E3B27D3;
	Mon, 27 Apr 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIwzIoYp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2F3B19D9
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281459; cv=none; b=hIWVHwvywgOiEs6ynxhqUbdfCqLbj8lONf0rAPQYglIugsNa0XIhwL6iftf2GI4gblphEr4KE9aJuibaBJuBgc4ZD7FtLZ/ABiAqCa2hfbO0BPzHP0MHSyt30/L8fdwv+QFNUd9CkFiI80Rx+y1O6TgSy2yhlPbLQD7lNGQUNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281459; c=relaxed/simple;
	bh=AK5Nr9EoN5hOrQTMs6gBN4bUgtVt4eaQKkUfxTX/NVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWqtNhO43rwyd2Jm1WujotxIwSTUSx5NOw8VCkjZHr6GFwzUZEd/vBCVSWNDJf0HxMV70PRPpeQxH0/q+2Dq34ihL0H8DTn5rc8ygRg1A50Tb9grrtqXmjvTEaYibvKB3Dejd1/EOzSlx+wf+GT86Y3Mmngf+zpeFWJSPMaDNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIwzIoYp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso6003517f8f.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777281456; x=1777886256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3BZLzJKc7teyfIfzvCeVwe77Ber/OGeCZ9vw2twToE=;
        b=aIwzIoYpvp48/zEbfcgtoZOHvoTrP6qcbjIgTfBtitimVjkfIxK3CItaDKYAOe6K/u
         n462KxOsLPnPX381tWZw9GYkQe9jO8lcbk9x4QsrfhM8G/IQhbCWgdbx6mwUGdO99jy4
         trlwMmNYElWb1usdrWU78kl7RRihcuYicZw3RQxmSKI+8yc4UCp2X9KvrwLORfY9Qd+R
         AT1/zigb8vqObhgui/Sq/f4XznNxXaVFQ/Kdn4FVPvwE/XGTVH3gKYrwsnLPP9QylBAt
         6hIYZP3J4sRq6dlrzqHwhJG3ib1r3Tp4Y+fzU73AF82Bc9BG1lC0VbxXTgfnyoEoM8d5
         8I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281456; x=1777886256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3BZLzJKc7teyfIfzvCeVwe77Ber/OGeCZ9vw2twToE=;
        b=JdHO8r5aXH24zw+wJLJEmJgV49XzLolE2JdevB2LSWfha0SimHUT+Dv9gaR0tIddim
         3OBIua9je4LDKBzYGjd1SHTfXVb1vTVdozzSvwgX3ou2R/h7S7TPNQ9Nwq+HHiebBfm2
         uueH3GaHfcO6mTaz2HvfcjKNj80Wt5L5X+9DcsMhyw7ed81n9Tcd1ttZMtUS92B1AF/B
         6YMPzWml6ZrUekTntVCsAVOJfcBnu3SmVrE9fX63NAmPoMtTeQgexs1peXZSoL+kclEw
         hO5ERPC3MjENIsX7SZQc7vy/YXMEs+Hyf74AezU28si0UEgQ73CgyTRgBPU4k0+mphzX
         xgAg==
X-Forwarded-Encrypted: i=1; AFNElJ/5yR4EXp26Dn2DEg+7GibITBsYoQca7rD6teCC0yYwjRAxxJZo9I2S3io7//x8qbpjyWb0j3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFKDquLciBJKQ/AwjofdHCIyK1pOgV+7K8IAD+FRSIygqlI24
	Wn6B+laII7h3CzdX57iFyXXXZEXRgBeHKy6CMFffVV0jnoEFHEvnN9WJ
X-Gm-Gg: AeBDiesMy3HbnweN6mWYgBeV8mtFVauXDUmOwn5DveAjarZwzN43mOCIPZ8hfNirXkB
	8ptimQ1wIpKcm28WegRO+kwVXUv2KtNFuyA0rbz9M2uVCewbL8XAwzVVm4tDyQp3o+WqyTDp8MG
	otOqzgqzsv/fVMYpoEunIjUgMrhsDyWh5F0lTvE7FGQGA0cHbiwrPmilwAFBjdFnFNPQDbbiWH3
	hXTOCmpLhBdRyczzZCse9Zye6Tt+qgBCxqdhGRFkQ9oklQrQmYA9dRBx/2ChVCLqoFZ9HpM28Bz
	aoh5YZx1c7BUhQtjBv9uw4l+akYk6aJdboib5EqryOBVLLSoNYkT0/7gUxtY8FB9vKMbNC97La8
	8L4hC6W2AptYWGDZoWgpiBFwnz4iOTTiEwc+yjFvKpTpWRKc99ppHInUNIMUx/Ea0xM10TeVFYD
	KcwXYbSgrGc5tfZq4uxnJ8L9yUpkpYBg==
X-Received: by 2002:a05:6000:2303:b0:43d:73d4:b34 with SMTP id ffacd0b85a97d-43fe3dcb1e9mr64195158f8f.16.1777281455511;
        Mon, 27 Apr 2026 02:17:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm107033148f8f.36.2026.04.27.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:17:34 -0700 (PDT)
Date: Mon, 27 Apr 2026 12:17:31 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, luka.gejak@linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8723bs: fix OOB write in
 HT_caps_handler()
Message-ID: <ae8pq5YzEe2wTJmx@stanley.mountain>
References: <20260427081748.3407939-1-hossu.alexandru@gmail.com>
 <20260427081748.3407939-2-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427081748.3407939-2-hossu.alexandru@gmail.com>
X-Rspamd-Queue-Id: 4F93F46FDE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241273-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 10:17:47AM +0200, Alexandru Hossu wrote:
> HT_caps_handler() iterates pIE->length bytes and writes into
> HT_caps.u.HT_cap[], which is a fixed 26-byte array (sizeof struct
> HT_caps_element). Because pIE->length is a raw u8 from an over-the-air
> 802.11 AssocResponse frame and is never validated, a malicious AP can set
> it up to 255, causing up to 229 bytes of out-of-bounds writes into
> adjacent fields of struct mlme_ext_info.
> 
> Truncate the iteration count to the size of HT_caps.u.HT_cap using
> min_t() so that data from a longer-than-expected IE is silently ignored
> rather than written out of bounds, preserving interoperability with APs
> that pad the element.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---

We need a little change log here.  I was hoping you would provide
a link to the AI review in the changelog.

I feel like the AI review is probabl wrong.  In this case the
original code corrupted memory so the code didn't "work" before, it
corrupted memory.  But I'm interested to see the AI review.

regards,
dan carpenter


