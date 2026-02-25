Return-Path: <stable+bounces-219605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMB2J1v3nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:21:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415C8197FAC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28B163027E0D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B8B3B8D48;
	Wed, 25 Feb 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxB6l9Gw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OK12alkZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812E13A244
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025685; cv=none; b=aDvwqtSSTnlwlyN/aewbLX/WMqnkA4bTcTZMpOBOUUaVlLdb1ekSQSrCnYwS9lG/Peww/7ms7IihJ4SbPotOcmpUlajsR6prFd9jePcA0hut6hc/J6HqzFe3IXzxhY7oKpraRSE279CDE0cZnhHTHp5aMhvff3c7gTT5W5w1iTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025685; c=relaxed/simple;
	bh=gPd6+PZcmUbTbkDvrJ11b6yWE2uDUvuPbL8XSCOXmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHiNsQ+F2g6NGJNpQ1wHz0V/wSxpfu5ghinE51508gpVD3Qf8zvL2WK14liwGYJtTWtr9ku9xt+ArL4hEw2O06f7XfVvlMJbfa/ZZd3c+diVCoPBTe7VaKOslxugXVPaXy7Z9bffBEeZLVCdoqyprViOYIviTvNaMzj3ZCakr0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxB6l9Gw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OK12alkZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772025684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9FXhwMMHFtDvmmN9O+r+h6L/Zassq9EP7jemgy3/40=;
	b=AxB6l9GwxoH9i7Eh/JWdMBOvBBl0pvLYs33Iaq88/iXNPZ9V/SbYJn4keG9iaFAxzvR/vt
	sg1soAiWrZ7yiP8IfqL0wfLXscdJ4lJCWfIGYKYCr52wb2jxyve8jaPSa1xCUWS7ECybrc
	Ys/HGSUSSfLUsvuRgcdwHOiDJCIBen8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-xZK-bFY2NRiT-eEQPJ9USw-1; Wed, 25 Feb 2026 08:21:22 -0500
X-MC-Unique: xZK-bFY2NRiT-eEQPJ9USw-1
X-Mimecast-MFC-AGG-ID: xZK-bFY2NRiT-eEQPJ9USw_1772025681
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4376b624589so4035681f8f.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 05:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772025681; x=1772630481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A9FXhwMMHFtDvmmN9O+r+h6L/Zassq9EP7jemgy3/40=;
        b=OK12alkZTJlEg2byMp7L8vec/l4RYh/iLnJcm1wCKjXuwldfczS1wJevya08eAGKfZ
         cf9XY/wf+gHZ/f3nKbL3e189ru+G1GkvKLjsjpXK+wPBjLGKsOtbd4YquY237PkzrBMe
         U8OoRIudaP2LnvC24yzd1ERlciOlu7AJ/UnWOnyl7J59peU+jYo4NHZt1sJUsE9/TKp0
         A2MinrgZjknHcDCZdjYpAiu2QMPP1e5AYAygrbcv+/1XsY1MAZfJEaWUI2Lx/CVeVzgU
         YmDObNUb2+TNDWTZObBi250Pf9iuKOpQ0Rcis7EKP8LfMC4EnM/qe2A8iRV/PZlqJ4he
         Zv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772025681; x=1772630481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9FXhwMMHFtDvmmN9O+r+h6L/Zassq9EP7jemgy3/40=;
        b=bpMc6yUevDpFrvFgco8omx4qhmwqXslbERAm9HQiUzOrbpda7/2zYuKh59EVyYArTh
         LlC9LJosLNxThfQmpnB88in47mnm4d3yFRRVzoUqRL3foK385e+28iGMkDkvhXaVgI/D
         kJwt3CMz52UiFHdg0Aby059MspbASX0/NCOzInpUEx+FhxjhfQTO/Wb2Sq83SZw5KOaB
         Jd3IjcwgG/lMpoI6zEWMePqm2AekHPpXJ7tD1TkkJXFKVoT9KfrLlsvmdXBeKDUt00h/
         ipCwHr+VJdlo0GW6MmFTjkwqivy1Z/eWEv+wJH0tUqGGblLDtzOM0nMVluNqJjXDNeLM
         GkHw==
X-Forwarded-Encrypted: i=1; AJvYcCV5EhgBa4ThD+AEMLYFmwCgEGyHemWjucck2UWzs8wF0HaiyalE4s+Pby+eXVtrBN7oyPSsQwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5AM07eRhgGVBELTfaIb9clymd/WiLhme9jID+JLJzJxqjZoRa
	FXbYVneJgKJJGRNWjsBn5HEEdoJdVpTw0/KM9kMaKxRIu0CBCmd/HLMWNcKz+ZTu/I4L4U86NR6
	3rsNW5zINy7dtFSMX1LRdkHsKj0HurlNli5oSOv/DRly+wdb97DPVo1rsWQ==
X-Gm-Gg: ATEYQzyPNaPKTVnT/ovX0fHUkr3PTEaMGCOVXgSLFlS5HL0EfDoQGHtflE5p1bVKEeC
	Vro7+d1SCRGF3qXx2/WQ2vT8dxkLE7mgBdOEoX8sT+Y/15V02joHnHxjUepLD9qCuFPQbiYf+eV
	CQyoEHlSyVtmivWPiSAQREsu8xYWERj2MlIlfUzM5NpDof1J00GdEhVu9q4CZrionBFWfFbTF9b
	RJsWg6aSEfat1dZPjThhRAUEuS7qOcIpKdH8nzHEeka/u/xAe4oNlGYyOG3usQwqJce7LH9ScDE
	mxFNTQLxlZUqJJKTvir2wECS/wCH6FcI/iJdOGiKiLWqKaX4jD9TwBBgI6gunMpLPGw4BxGusYI
	psQFZ06s7cRqdw1zhDmXTkhu5Dsr6UKz2edSJwGWl3727SA==
X-Received: by 2002:a05:6000:4009:b0:436:7ab:9290 with SMTP id ffacd0b85a97d-4396f16e345mr29973658f8f.1.1772025681009;
        Wed, 25 Feb 2026 05:21:21 -0800 (PST)
X-Received: by 2002:a05:6000:4009:b0:436:7ab:9290 with SMTP id ffacd0b85a97d-4396f16e345mr29973604f8f.1.1772025680520;
        Wed, 25 Feb 2026 05:21:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fdd0sm33025046f8f.19.2026.02.25.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:21:20 -0800 (PST)
Date: Wed, 25 Feb 2026 08:21:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225081735-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219605-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 415C8197FAC
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:56:19PM +0000, Srujana Challa wrote:
> > > > > > >
> > > > > > >
> > > > > > > So if device is powerful and supports a very big key size then...
> > > > > > > we disable the feature? how does this make sense?
> > > > > > The intent isn’t to disable the feature on capable devices, but
> > > > > > to ensure the driver never advertises support for RSS key sizes
> > > > > > larger than what the net device can actually handle. Even if a
> > > > > > device reports a very
> > > > > large key size, the driver is constrained by NETDEV_RSS_KEY_LEN,
> > > > > since
> > > > > netdev_rss_key_fill() enforces:
> > > > > > BUG_ON(len > sizeof(netdev_rss_key));
> > > > >
> > > > > so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear the
> > > feature?
> > > > Our device mandates that hash_key_length must be identical to
> > > > rss_max_key_size to guarantee symmetric bidirectional flow hashing.
> > > > If rss_max_key_size is larger than VIRTIO_NET_RSS_MAX_KEY_SIZE,
> > > > clamping
> > > the value is not feasible.
> > >
> > > I don't know what to tell you. rss_max_key_size is just the max device
> > > supports. driver should be free to use a smaller size.
> > My understanding is that this patch prevents the probe from failing by
> > disabling the feature instead.
> > Given the current implementation, the driver becomes unusable when this
> > condition is hit.
> 
> I understand that the driver is allowed to use a smaller RSS key than the device’s advertised rss_max_key_size.
> But, our hardware does not behave correctly in that configuration. For symmetric bidirectional hashing,
> the device requires that the hash_key_length match rss_max_key_size exactly.
> If the driver uses a smaller key, the hardware produces inconsistent hash values for forward vs reverse flows.
> Because of this device requirement, we cannot cap the key to NETDEV_RSS_KEY_LEN when the device advertises
> a larger rss_max_key_size.

Would you not say it's a buggy device then?

-- 
MST


