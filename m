Return-Path: <stable+bounces-238456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KZ8Mozs4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:17:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3014187B2
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C29D53002F52
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F29339B974;
	Fri, 17 Apr 2026 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcRClTFE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSbI1Sox"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E70396D10
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413474; cv=none; b=dyznZDv25a3Vo2z6Z6yC01yQBzJpRbYj7xfdgAGMsA9iHw7MKFj12WKPCapQAr1y7hOxbX1M4p5WQl9xjC/7ty4hjk+iB+m8hlYxhE4Cxcv/xRbKwHkm9EZOJYYVYPwepUXLeqaXfxD0FMf0Pr62Cc6GGgks5Y2XrCpf+BTbkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413474; c=relaxed/simple;
	bh=KaCpviZPSmkiF4jmKYcWq3DzQZ2+p6j12ROyja2bfaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxnxowRwJZ/foH6p2mtMu/1jEzSaqNAypulsYjvo0P4c0TFFocVvOV435Dnkdf1Jk9nChtWXP8iActT6sGT9Zleh07rFWr8PvhgYwhfRYHa7M8v0NffGcFryMMurz/CKh4ol93mMbrtomjPGKqEgTY1o/phsjRTVp+rtY1IVRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcRClTFE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSbI1Sox; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776413471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KQAofqZYzRAetGSFBCfd2UZ3jU4AYAQOO1zS3D2btb4=;
	b=JcRClTFEVfGmISpUkkZQLKl2p7UTvg81kSJsLWKWszcVUvPTtdbJLuPbeCJbfw/04DD1Wy
	RO/tubgzPxZO2nSVHMWxO2HDaMq+HfIBhVpWRpazewnKrcOqwm2b+n1zwWHdM4fmLzDE51
	Gh8420KxQXxlAdC0paDueglNCCNCtGo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-0OZC8QbOMruNQcNlU-SFLQ-1; Fri, 17 Apr 2026 04:11:10 -0400
X-MC-Unique: 0OZC8QbOMruNQcNlU-SFLQ-1
X-Mimecast-MFC-AGG-ID: 0OZC8QbOMruNQcNlU-SFLQ_1776413469
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d121c4271so275027f8f.3
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 01:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776413469; x=1777018269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQAofqZYzRAetGSFBCfd2UZ3jU4AYAQOO1zS3D2btb4=;
        b=YSbI1SoxcM/EUyQYLWXfLfXB8dM2Yv0jrh9h3pUDwxDwagq1HIEBpXuMbkj74tb92o
         5sNDmFiXD4ZBX3bT8qfpOLNuvqeOBLHJvjZseAP8FCA/8FH3VEpCthzeF9H6brtFQNAS
         1xP80HXE09j36/vLkerK4Wi5p6tbOKs+dB09U8pgZUyjoLBDx+BJD35zPKOpG9g8yAt5
         dH11r+Xq+reLAwXd60IKsXafHDR8z/5xCpxftxL+kFDctO0/EwULR5QLOrmy1FQDQBQ3
         l9xRuVTXOffRm6+hOPCr58TmVX0X0pfmKrbV0p2LNG50mop6lQeZrTZrC1oAsEmaKp6C
         BzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776413469; x=1777018269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQAofqZYzRAetGSFBCfd2UZ3jU4AYAQOO1zS3D2btb4=;
        b=INEFXOMLU617d/ITvLNRSns+uaTO4tkZmrdL8VPRGX+lqs2s4ZCP+Fu61NOyMYwyem
         9jhIBj5reeZGrNWy8SFH6nZMNud7fuzjaDSm1Yk6bhGV1RHi54iUVfKwfK34hdvopN80
         8DU+ozCBx7/8M7UGgk1rzXbUjzfxcgZi4fID6GxD8rKBWNUDogUFKWkg3jAF9xE6qXMe
         mWWYqBgtzfacaBRtbgobzgRrzXbTw3kmoSXAc+Km9zDvke5rwpJi50/X3Olq7RIfkKSh
         L5q+qiVuL8iE+uhWS5hJ0athXZbWwn+XdyF+uQYoG17MpJG0YmOLY9g94bNCcQS5Mhaj
         BnoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9T82CbL1BZnvIiCWmpx9+TvIgIWOpxwQXT/VIscrqU16SesdtVO1fxQGRPJGY+Z6SpsgZGS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/yJshJcU1kKymu3pWbA4pvtQ5fvm2G+uqRmBbKq/bHa/I9rn
	pRkppJtX2rVKmmFYiJV3r35yrdBkPWbFRKMeelA8N3wu9PSVTqo0YcgxbhLQhAgNFRdCMztA6iO
	be+2hNpNIkFaThY23ACDIkhOjL18tFc/iU1D0lNSuwhEhWstlXlS1DWBsYw==
X-Gm-Gg: AeBDiestzDwBFo86Z8Fsl+1EKdukVIQo2AHDvS95J1PdU5TJLR/sA7EaKVZX7hGDprY
	xz37dvm2p7zhJAesgSM3hHsK6fR8gyIN1fSVzcAY2tjgewD8QJzpUbkQZtF4kljnYV2Hi/UQFRW
	IKxz81+zBwn2yAmaBPcHL0cJm8NCg9PzT0Xgl52h7fOczIXqws+qbEsKaTnSD40r2Fr2UaWFHZU
	AILyI+tYMDX0fcD50z6ndl8o/m6UoXtR8AzOsC/NWpqvIdDOlW9qzicFuEzpkBSoRqgF1om2rAZ
	AzMiJaOV5bhGbLPHdUN7cUrAnpv5GKX8S0jtJnO23Wkn+tPvpgb8BJOSZ55K+GpBQEQpz+tNit1
	gc9PdhZJgruohFGd6kP3KXmcyTcqK6yYq0ZFuBF+Ud6FqwKSNmRzRW8FYEjCiicDsFuuELK/kbs
	EyzsScLg==
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr2356261f8f.36.1776413468907;
        Fri, 17 Apr 2026 01:11:08 -0700 (PDT)
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr2356185f8f.36.1776413468277;
        Fri, 17 Apr 2026 01:11:08 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a381sm2920727f8f.21.2026.04.17.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:11:07 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:11:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	longli@microsoft.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, niuxuewei.nxw@antgroup.com, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ben Hillis <Ben.Hillis@microsoft.com>, 
	Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO for FIN
Message-ID: <aeHor6IpXUDyMtnW@sgarzare-redhat>
References: <20260416191433.840637-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260416191433.840637-1-decui@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238456-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A3014187B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 12:14:33PM -0700, Dexuan Cui wrote:
>Commit f0c5827d07cb unluckily causes a regression for the FIN packet,
>and the final read syscall gets an error rather than 0.
>
>Ideally, we would want to fix hvs_channel_readable_payload() so that it
>could return 0 in the FIN scenario, but it's not good for the hv_sock
>driver to use the VMBus ringbuffer's cached priv_read_index, which is
>internal data in the VMBus driver.
>
>Fix the regression in hv_sock by returning 0 rather than -EIO.
>
>Fixes: f0c5827d07cb ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
>Cc: stable@vger.kernel.org
>Reported-by: Ben Hillis <Ben.Hillis@microsoft.com>
>Reported-by: Mitchell Levy <levymitchell0@gmail.com>
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
>
>Changes since v1:
>    Removed the local variable 'need_refill' to make the code more
>    readable. Stefano, thanks!

Thanks for the fix!

>
>    No other change.
>
> net/vmw_vsock/hyperv_transport.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


