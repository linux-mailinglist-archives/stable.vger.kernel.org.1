Return-Path: <stable+bounces-238063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBSZLZBP32nLRgAAu9opvQ
	(envelope-from <stable+bounces-238063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:42:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DB4021A5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05E4C30649C7
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 08:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E55039BFE8;
	Wed, 15 Apr 2026 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/CpjCZ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B462D8378
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242311; cv=none; b=QucY2D4A9/CegopCm11/TDlnVSbxZWaa89nzBmZysu/DzCjn961oJjWa7ViWGRqlF7kx9i7JWIBYxRJHNkizAG5K6Iz76z1knP43F7rbHGzi5wqnESBp7cMmb++DAObRQbRU8yNEaii4IcyLmq2PRT+tDMKWSdG1pJIdUdjhQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242311; c=relaxed/simple;
	bh=KseX38j6qGyfEm6dYHV42UbUam62ys6G2hqrUCCrpoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLWsIZEDmSvvX6VOMXafNazTFX2j7ZHINhVgaGle3WKpBRoSf3i7Gebk9zAIKSRoKRqXekfIJ2F89eK5zBQ91SEiubRzgv7J248JoWZ7CFUpkJ8oIJWfB+Z8N43rZTI3PkfQYS1X+MEQ0Wv3XLU3SFxHzy+dKOAWDREkjFYhBCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/CpjCZ8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488c2690057so65282675e9.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 01:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776242308; x=1776847108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPSUp+sO6VcHLm7/luI38Bv83ZTw3gEBrD3agBPIf1I=;
        b=A/CpjCZ8FROALII9zz0V82f4745LqUvtIc6GL6eUTzp+NTkoAVWAVBwsHJ2h1zqlGh
         55nCFviyNCHuHEu8oApYvy5/tE8qyvIC1dTNH5EIt2MUnBbcBDY7dPOMeKXYc/5MBDVk
         b3lrCLGR4av+eVfGpDkyAwL86UhjaVhLMOdgqalPTbfZNvYdLoVvlJFSCcWSVcGuMxP/
         dgk4bv9Vpy+n2LEuH+KOAarAJJrSvOtIMl1bwjarCbmFlGKS8AZdVPzL4kkYcAZYvd9t
         AUPu3KV6MGZ+V9vIvHwFq4yajW1AqLoOVav5We5dSOlsQ4TGgkI9zJE8upFb+aR8QmDh
         UViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776242308; x=1776847108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPSUp+sO6VcHLm7/luI38Bv83ZTw3gEBrD3agBPIf1I=;
        b=BJ1BoLP+p/iHTh+VYI5hU3effNIwzI5wU6NkLQtWxqLGLC1hR3+PjOmpk8vyVoBjhE
         RvQXzf4Pbpimkm4LCq2/y1g6HxFCqRvaAHfdON/4mogGA8lh5fQJC99FpWsV0uOWGX5c
         WS0qjNiphSIPVeJ0/KBTyyWbjDcWDKjZXIzRhI0xBUXzUbqUuDnVqZG+xRDPQrbNVI9R
         8NJFLJtyXboa0FCAaPQ3jQ6T4hxuUcfOYHfZq8e/g0HOtVaX/rWL6nHatzeUIgN2ujsJ
         6/0lTifGmonMjiUebAt95irHDBgtbWpthS1EtOpmrRJMLqcQk5qvRtUpZF7zge7pekQ8
         ltpA==
X-Forwarded-Encrypted: i=1; AFNElJ9NOpBn6URJ6gH7L+Zc3xAGT6gtHhArk4pqo7zokiccHfA4dJJVjqP6ndNShrBYKieJoX4OyZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdDYaX6uvd8jhdJrTkgbs5dLAPbPDRnn8Fv2e58OadKWXU32u
	m+OFF/lwXXWhHDOn6ddxnkXvsMHOVwV96WmankUB0SevhoXOsGd8t0B6U3hp7Ep/DrM=
X-Gm-Gg: AeBDiesFI9YlZNgj5kMwmsbMdTLUqyxUVVzF2bZEt6AuAUaHBARH+MPjMBc9sBcqLa8
	wcVdHGcmP+UaFAapGw8+EBfhBEUfKCEyIOj1wdCV1QT+2VXl7L5jDBGwZcURjr327WgxCH/28RF
	Neah7imPmPzozlHPk7or15ECpfxJrHV7w5ZaNb5Prx4ktPvGGP8v+NUCw+Fc40zWayR6Kv4piez
	lBfyw9/aMfBL+UpkmsYBWjI8d4gC9dt4chkUiUkVhq4ZeWjCfykpmrmUEuChuCokqvf5v1q1k6G
	aHLQHjEqVtmT0xX3Ow8JlsKzpY6r3HEYdzMXO0mxGi2ZYH8MY/S4z8or99e6vcFqht2SfLXLz+e
	pdRYfJh6QkttrtSTHXKWOSO8PJ4pmDgeCotwB+Wjeupipfp/dd7wpoTdJzuyrVJsvX7YOpEUHZH
	zc7gezx2J6xrllWHCQQBc=
X-Received: by 2002:a05:600c:5249:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488d68057cdmr265756195e9.1.1776242307812;
        Wed, 15 Apr 2026 01:38:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee042f3dsm99109025e9.12.2026.04.15.01.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:38:26 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:38:23 +0300
From: Dan Carpenter <error27@gmail.com>
To: luka.gejak@linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix null pointer deref in
 rtw_check_bcn_info
Message-ID: <ad9Of-loRWcTmN3_@stanley.mountain>
References: <20260414205520.157861-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414205520.157861-1-luka.gejak@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238063-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 1B6DB4021A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 10:55:20PM +0200, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> When parsing beacon or probe response frames, if the ap does not provide
> a valid ssid ie, rtw_get_ie() returns NULL. The code then blindly
> performs a memcpy() using the returned NULL pointer (p + 2), resulting
> in a kernel oops or kernel panic due to a NULL pointer dereference.
> 
> Fix this by moving the memcpy() inside the if (p) block so it is only
> executed when a valid ssid ie is actually found.
> 
> Fixes: 370730894bec ("Staging: rtl8723bs: rtw_wlan_util: Add size check of SSID IE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
>  drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> index 6a7c09db4cd9..2a8aec37d9b0 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> @@ -1204,8 +1204,8 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
>  		ssid_len = *(p + 1);
>  		if (ssid_len > NDIS_802_11_LENGTH_SSID)
>  			ssid_len = 0;
> +		memcpy(bssid->ssid.ssid, (p + 2), ssid_len);
>  	}
> -	memcpy(bssid->ssid.ssid, (p + 2), ssid_len);

This isn't a bug.  Doing an memcpy() of zero bytes is a no-op.

I think there might be an issue in user space where some of these
functions functions are marked as not accepting NULL pointers.  It leads
to weirdness because the compiler starts making assumptions based on
that and, for example, strips away all the subsequent NULL checks.  But
in the kernel it's fine.

Still this change does make the code more readable.  Please, could you
send the patch again with a commit message that explains that it is
not a bugfix, only a cleanup and remove the Fixes tag.

regards,
dan carpenter


