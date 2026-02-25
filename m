Return-Path: <stable+bounces-219601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJOOOO3wnmnoXwQAu9opvQ
	(envelope-from <stable+bounces-219601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:54:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B3197AA4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D71930CE87B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5323ACF10;
	Wed, 25 Feb 2026 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/jnmIp9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+AVtEuv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E500F3A0EA2
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023956; cv=none; b=NC+c0lp0MotOiP0/t0GVkOCQwcGuBd9fOdPk82rRazaluQVn5J8R7lY2lIRLcU4bC1aeQH6AMv9uUoIvgZooMnhYrG9ZP1IDgpfBE/OuJXfbig+eKZd48z1VFYbmy8tBpp4FPLCq9t4NVSgArC/1qCkb7o1uYYPMRk6/Zo9ZMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023956; c=relaxed/simple;
	bh=sbLghi1wvhV55htoTSopKocdqh5GgtgNJsPIzD/S08U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCjlYU+kXaJgp7YY+ID67qdIQy1ISKFqt1Ap/mKbSHJwxU/qVZupMKrZfoK90K3Ye3NRpcyGtrUsvwwGKxWVvOgZE2CFqU9E1Ojlzd60/myFlzlaJeefC/VoMdZYB8Ksba0CRzbwW1vqXQxTy+hkbH5hbROn6/cnf2f4gbKijyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/jnmIp9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+AVtEuv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772023954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sbLghi1wvhV55htoTSopKocdqh5GgtgNJsPIzD/S08U=;
	b=H/jnmIp9KWXJF1hoRqr/6qY9Yi35DdkLCtUnOb9ML0NBRX2rh6i/cIHVxEpH+EhFN3jzUn
	XvnxufnaVkrvg/bIL3L02PdmeTYhSrwRincTHLDHzGx64nhNawCkT52DxBfVmo1LHmviql
	brQzqNMujfA4SiQNKjDRzgpu51+MCcc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Nl5M6c1JOVyK_bMQTn3rrg-1; Wed, 25 Feb 2026 07:52:32 -0500
X-MC-Unique: Nl5M6c1JOVyK_bMQTn3rrg-1
X-Mimecast-MFC-AGG-ID: Nl5M6c1JOVyK_bMQTn3rrg_1772023951
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4398e939290so537578f8f.3
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 04:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772023951; x=1772628751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbLghi1wvhV55htoTSopKocdqh5GgtgNJsPIzD/S08U=;
        b=C+AVtEuvhN/yqV+KCJ0c9eKDkXPwdZiBspYhJqIw1WvaFABClB+3h0bRrAHAXK+qpw
         ZKft9xaQtkAv9qNVW9wtx5sNPAxv1stodw/LEL01HWowkiVJi6WbxPxVs9CjzbZukUZw
         7z5RouNRB0iXqURt46VG/isCeJsEhRyGZFyd2rBoTg0G8CwnsIPCrWBedU2aSxnFsl/s
         pL8q0ocy4zNHV4hwENDWOc0jJt2l7LsGwNofaWAHfE5crnpTRcxSXuEjQJUPdEx/OGRe
         TLYSsOj11ks8d3PiOYLIhcfX42Ora5Db1bNVB3DBBdhwSu3vxeyP4nyYQDxsTRMMCStm
         fcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772023951; x=1772628751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbLghi1wvhV55htoTSopKocdqh5GgtgNJsPIzD/S08U=;
        b=rS2bo6hCoVQ9uHgmTRfYlA0hX0nugzvRoKM5Qlrby5zrkryTc6Q7+orjCzXAioGh48
         L0QF1ohvXcaVlNTOazAkDBVvPW5mWyfy1DjdIu1yufY1GJBvgnDogFcgB8SCCu1ZJzOE
         I5hWxZzQVw0wtmKfLz6Zat5MIy5mr69Q7IjhaFXF9npRrLx24/jwpfTqhtxCs0TBfyMJ
         DA3KARuh9sl/4rFEZNg+xZtF5OIXhNexuAdNHrXU9AfTsJsd8bOyFwxGZx4TMYrDyCuf
         LJieHoHNFMqRDuHbhkD98sqqZ6GiGV0eIMAuNtN/bbWHp93whmn6C35+arnx6HoSifuh
         otOw==
X-Forwarded-Encrypted: i=1; AJvYcCVUMGSw+GMpHOm3gaB5KouWFiTiwOWdKugclYl0lI67SrLOQ1HJ88AL7fKjCVigdNtiWHpAGQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SswCmAuNnN0wSpZJBaddlQCfKNCcYfQ7FOElj9C6MKQyU4If
	MjuP5IrwLjHGxKc1dp496Usea+vJLW258vnHBJcdiTU5/1JYlnCvBF/fiakHkhtK0xz1oFUuBMI
	xq8EpoF9kzi+cQMyxn5tZjPbKNxroYtaZKQApd4NHl3cix7/X63o7GFxVuQ==
X-Gm-Gg: ATEYQzy/kGShneQKV05Va5Ldzm1rhIDdEMHQR8bGzzcvUDOrdHqaY2hlQEGFBp26XPt
	uoZXrXRFU+I/Xwe37tWZkJ+owTazZBItpEkaZMNo/y4wouefPaMji6WzcE9dgJR397cEXrFVJh3
	Jv0vjwgFpNDN5t8ufk8Lajq2mP+WDe9B4usUwqzMTwigcwdDVeMLO6IoYitNfxp8qbqklZM2I9F
	p7z+hTEZCejvrwVTArfsPRFuBtw37Fz7H/i3O1uF+kKAx1hYNaoi5q9lIaPZX9vcHzBYOzcLZ0t
	vLtR66ILM04nbfhDFlvUquaX9LrOuEIpoQwxkum1LL9Ep32fTq20h+/qa3DegiOaP5//wfPH+jY
	ZVGDX9TeDYgfe0hn0eTLMh1+Jtv6i8dtiX0LLXA9vEgxX6Q==
X-Received: by 2002:a05:6000:2489:b0:437:6d3f:a04c with SMTP id ffacd0b85a97d-439942f9b28mr660651f8f.39.1772023951400;
        Wed, 25 Feb 2026 04:52:31 -0800 (PST)
X-Received: by 2002:a05:6000:2489:b0:437:6d3f:a04c with SMTP id ffacd0b85a97d-439942f9b28mr660608f8f.39.1772023950927;
        Wed, 25 Feb 2026 04:52:30 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439899da8dbsm10508920f8f.18.2026.02.25.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:52:30 -0800 (PST)
Date: Wed, 25 Feb 2026 07:52:27 -0500
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
Message-ID: <20260225075144-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219601-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 797B3197AA4
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:47:02PM +0000, Srujana Challa wrote:
> > I don't know what to tell you. rss_max_key_size is just the max device
> > supports. driver should be free to use a smaller size.
> My understanding is that this patch prevents the probe from failing by disabling the feature instead.
> Given the current implementation, the driver becomes unusable when this condition is hit.

current implementation even more broken. but the real fix is to
intepret max key size as max.


