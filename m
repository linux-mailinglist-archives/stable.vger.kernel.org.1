Return-Path: <stable+bounces-96185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567849E11E3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 04:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C98B2823F4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD0183088;
	Tue,  3 Dec 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fg8Yjn4F"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE59168497
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197131; cv=none; b=t//eA9r5wIOhQZQVtpWpFLx0c7rV9odljVrzSFr4mM0t3urj5aw3fKCz0nSloWweCYDWujjwE5Eh5aVBkeNoFMlSB3vMEsWTFYd8ydVRCbBksdJNBVeaeN1itCSMNJVH3B1A6N1GQXkdFJN7IH320eRy+/Ys5MvGLGPc6VfOncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197131; c=relaxed/simple;
	bh=mQUjFYSbPJsdugtRaygePCyZNxgYO6OLr9YujVLTnyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEgBtCSw/0sxIvqNZ4OpQ3R+mtaUnNNX0HmyLVulwdCx7rEBYBvZkOSUXaAeH44Ou+drWAXvnYcKnga6Uwgki+vEq28gojMlRlo1qCF0bDc/3dyNnK+noSMcpeweNNM3Ew15xwf0QAT6jrZBnRrj2lq/fSj2+u3fZANGkdgTukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fg8Yjn4F; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BA3183FDB1
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 03:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733197119;
	bh=/1ELr/m1Bv2OGPjuOpiHnm1IVXq/mNpBWKXRMAF+/cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=fg8Yjn4FVVeMtIc8CMM6G6RGiYEKTKJTvFOuc1qe2AF1lnk3U9pgnnfiqL52Ls9bA
	 SHdOv9qDkWvtYEZEKJT35DRqW/z9kABp2brjF0kVMaxYxrAE9hm9LN+NdiXfzmYLN+
	 bEasJUjz/zTWk0q8wWRBE+CTPQ9srHrxi9tiugtkkjsY+s4JP2SkvQQ0dGC0W7OyWO
	 QB6pEwKOnDxCFs8x77h7UOYaDJN/OhIHFDaRP9TesqRWZvETOqQtSnW/PlV1xXOpsA
	 ky8uDOP84eks07nVigURv9B1cCwVMJJOn+g+GT/wRsT8cf6yVAQ71U5ZryaDwCyDoK
	 vYRvq3MYruQYw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2154e57189cso31764595ad.2
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 19:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733197118; x=1733801918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1ELr/m1Bv2OGPjuOpiHnm1IVXq/mNpBWKXRMAF+/cA=;
        b=fTSyanq/MgzmAHJNiRy3Yv7Bom3vxLkIIcm6aoAKWxvybOY7bTERDqeXMkylfUDGxp
         +A68E/V6VO9jP2azIj5InfLUV37AE4zYmY2JQJby0rr3EDXtg1RFkLduZ0ZWHo/QLrX6
         PwySlHiE7+k6RaN73dTd9HA4uuWdMhL5J0c/SYz6NfoKb4AUHDgoqX6zne8qUs7NCHX8
         1ZSJFFQF5NkB1dQwlc5caVbEawVVtPJjkRXclVIHOiIq+xbmquBdMMl+68PVbWdOfo+p
         5SyPQIKggkxE7FsUBNAY3P9ID+mNT+hzsh1DlDbvhijR8OQ2UGsGhgmuv/K37U2/R4wu
         v+uw==
X-Forwarded-Encrypted: i=1; AJvYcCU+CWrJ2agJUiAWnp3Dq6aNOwIQal0Gb3Xaz4mJTysRsGPu9be2Mxw7zu6rsISNjoeHDoygpMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyhSSOszAVevfNWmWZOOvVN6Px2Zr8zYCnetfGTi3F5Wtlv/T
	VCdm8QFsShuJabgQtEtDIfBiO5j4Qc4qASVy6/busRIzq1Tld4jc9LwMy1MdWpoA+OcjGXUb9jd
	ublW+H+Dw7V0emQxJh4HIkaGk1AE5gDxtCmOLBA/hEk2VdoQGw1GvUpRPxFtzxAPLq7HAug==
X-Gm-Gg: ASbGncvg6aZzcfQZ9NMjYz6nXcHtZ/fQPNZkMqn50LdpOVsI/dGN7kwckKmaQZIhgn6
	OSQ4QQtdtXQObsVlHffbaLY6wbhn1L+DqKmjBjIYwVLLNzpT1KD89Bwrx091l/9YhdPxMVx9alK
	ZSEXhZiKMseXbjPA1djcOYF3oYn7p8S5q+moH4ZP/njLHwiuYwcFaVQyPOswIRpv/fG6IJNfnK6
	RAgTRZ5pa5VDplj+5FO+HRGlhC59lFQCKXXOVn2oFb12YgWPyhF
X-Received: by 2002:a17:903:32c2:b0:215:5625:885b with SMTP id d9443c01a7336-215bd189d7cmr13412695ad.52.1733197118010;
        Mon, 02 Dec 2024 19:38:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiFXT/72acbiqUjNfZWjEnzEbxLtA1LUbxYQXxJZ1ukuWif4gI7XdthBZMTKX4TOQDY+6P+Q==
X-Received: by 2002:a17:903:32c2:b0:215:5625:885b with SMTP id d9443c01a7336-215bd189d7cmr13412525ad.52.1733197117737;
        Mon, 02 Dec 2024 19:38:37 -0800 (PST)
Received: from localhost ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905f4dsm84768005ad.78.2024.12.02.19.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:38:37 -0800 (PST)
Date: Tue, 3 Dec 2024 12:38:35 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: drop netdev_tx_reset_queue() from
 virtnet_enable_queue_pair()
Message-ID: <mwfore2i4ozfdue5ojq54o6bsjtr5y55eiemtwcl7ca6rb3hvi@k3kbcvrxw25l>
References: <20241130181744.3772632-1-koichiro.den@canonical.com>
 <CACGkMEtmH9ukthh+DGCP5cJDrR=o9ML_1tF8nfS-rFa+NrijdA@mail.gmail.com>
 <20241202181445.0da50076@kernel.org>
 <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs=A3tJHf3sFFN++Fb+VL=7P9bWGCynDAVFjtOT-0bYFQ@mail.gmail.com>

On Tue, Dec 03, 2024 at 10:25:14AM +0800, Jason Wang wrote:
> On Tue, Dec 3, 2024 at 10:14 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 2 Dec 2024 12:22:53 +0800 Jason Wang wrote:
> > > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > I see Tx skb flush in:
> >
> > virtnet_freeze() -> remove_vq_common() -> free_unused_bufs() -> virtnet_sq_free_unused_buf()
> >
> > do we need to reset the BQL state in that case?
> 
> Yes, I think so. And I spot another path which is:
> 
> virtnet_tx_resize() -> virtqueue_resize() -> virtnet_sq_free_unused_buf().
> 
> > Rule of thumb is netdev_tx_reset_queue() should follow any flush
> > (IOW skb freeing not followed by netdev_tx_completed_queue()).
> >
> 
> Right.
> 
> Koichiro, I think this fixes the problem of open/stop but may break
> freeze/restore(). Let's fix that.
> 
> For resizing, it's a path that has been buggy since the introduction of BQL.
> 
> Thanks
> 

It makes sense, I'll send v2 soon. Thanks for the review.
-Koichiro Den

