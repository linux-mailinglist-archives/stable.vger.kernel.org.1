Return-Path: <stable+bounces-98800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9159E55DD
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406DC288C53
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18D218AC6;
	Thu,  5 Dec 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="V8tgxnuV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56F1773A
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403238; cv=none; b=riTStb+OUccKueA6YHdktG6YOBeoA9l2sIjIbUcjz8x2dFXgIu8A3y6+R0jqeXT9W2nf0BynwObGtdaixRoAp7sZcAjVDFwqVCVRMlfmCA11xxEWjCxBkQpdb9zSQmmX2tr4ebDS+EQlRceO9dE+8PX20uuGKOSHL3ZGoqmNYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403238; c=relaxed/simple;
	bh=JZWxDg6kLZ0bFvcAVD+a3fOTrGu99x0LQws4omTlL0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPZffSZ6nmVffb+exqeghlYXsUAPTDh9eqF6mDY0MdqCHCPrMHX0z1Inc06bv7pQW5D+fCNkGkouMyOEKNkHfIJi0mTW0dXdG7WGINm+NYppzy5ao1lG4EBLIUsr2VcExYUm36hq3RR5BTANqYlWIMjzCWjzRJskct9casD/eH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=V8tgxnuV; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA86040CE4
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 12:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733403232;
	bh=FUPqE51TLvEDtsqOtCI9i9XXbeFVSmPyWNWK1a6nR9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=V8tgxnuVMGhqBI7cS51lH9AOTzm58sThQ4pWSkjdvgwxDz7LKMI7auV4NFxhDqnAH
	 OnaOXDcqkqQbf7WOpihH/XIe8wAf6FcArXpRgbC99RsMnXg9kJxr1vbd3drfto4Q3y
	 JZMse6qpdowiLZn5zPMJuezZY5JeAOcUsKp48RE5xqOcnWERlyeQEA4dAdDxGfj+Ub
	 Kc8xaVgSMi0hKYVGzKiV+ByhHOA/5dYZjKkJ85n4QM7dKevV0p6+/XlbU1ePLisn1E
	 ND5h3rCSe0wxiBB3gBaKa8vMZPKcBOuAagVABlEQ3E8S5LvHlqsYbybTqbqKKUOKwT
	 I3Ania1gGZOhA==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7f80959f894so1756143a12.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 04:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733403231; x=1734008031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUPqE51TLvEDtsqOtCI9i9XXbeFVSmPyWNWK1a6nR9k=;
        b=l4Ar79odamdQtqYWo+Jc6p2SffW6hLuyvNFpBDWbXckgwrs/gt7kFi4sJLPsGGCx55
         42t5hpcxHGy81mYQj7vSAwi6RrFmIDwJot4PGQH2nTxawJD48S11OEb5L6aVmTKVjhOq
         ldEr07ua0PPetjVViXz/b1bh5xtFSSWnzYeOS/wtPtthv1HYQAL4TKaSW91ajKbH2hca
         3653brjFP83oD7pV35B95mKjBgy9dh4/ylgayM0reDJjExoHuqjDmmywbhZXvVpODIUP
         0IXX1vI1TmoTjQWpn+g73mdJD4E+/sJyg57chHufiwUF6my+H2FOgeCzBEeWp5qT4LBg
         ijDA==
X-Forwarded-Encrypted: i=1; AJvYcCVypyPaHzQxY5psPchftWK+F4KvX7sXgxmIPMzqJ8zLdFXKHlRX6RZyTmntWN3VoFQttQGoLi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsb/lltSwQycAbhZTeJi7CPeIoN6dvd0bt6l3IjrdSwQmPxXy4
	iv3buK2DpsI+7PgfSl77w+2geVg0mbo7B1cOJIA/c1EA+v6zCKgNQRKEHRXwrq3hC5qT4BKpS1I
	7hz/0Cm7JvSgpiN43AQ0WrFGdAo3JlCD/Vl4MdnkRVcaIG6gvVVyDxm1fmcJ+bTI6iU/3vg==
X-Gm-Gg: ASbGncsmGs2vOwZMKZISGFenq+dzH7y06UQnKp83o0FsgAsnvneRpvZGDH4OeVTlzdj
	vwv4D904G44OZcF69v/ITy4m+AXfQ4Uh3ZtvoFPmG6HL6fR7f27N05K3A03dG7aYV67jO8uXeL0
	QAzcv87t0a+Q0ZfP93AjBQq2RyWvOY1CEW9tOKTe5dPu+Z9Ed+6g3ImroYY12J9TbWMic8znpNC
	ZXbBCK0rMhhgTQy63UiGUeLfaQ0LtObkoTvCTJ68DzfyI3ieKY=
X-Received: by 2002:a05:6a20:9186:b0:1d9:ec2:c87b with SMTP id adf61e73a8af0-1e17d3841f3mr4662272637.9.1733403231230;
        Thu, 05 Dec 2024 04:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNoiRxBOlLsxc22EXT6uQ0ZpleA21ZKP6ZYanOZreHBwMPSzZzR3LFylnFh324PSe+sabHw==
X-Received: by 2002:a05:6a20:9186:b0:1d9:ec2:c87b with SMTP id adf61e73a8af0-1e17d3841f3mr4662236637.9.1733403230902;
        Thu, 05 Dec 2024 04:53:50 -0800 (PST)
Received: from localhost ([240f:74:7be:1:d88b:a41e:6f7b:abf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156b7964sm1080721a12.18.2024.12.05.04.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:53:50 -0800 (PST)
Date: Thu, 5 Dec 2024 21:53:49 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce
 virtnet_sq_free_unused_buf_done()
Message-ID: <42s4swjiewp7fv2st6i6vzs5dlcah5r5rupl57s75hiqeds7hl@fu4oqhjm7cxc>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-4-koichiro.den@canonical.com>
 <20241205054009-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205054009-mutt-send-email-mst@kernel.org>

On Thu, Dec 05, 2024 at 05:40:33AM -0500, Michael S. Tsirkin wrote:
> On Wed, Dec 04, 2024 at 02:07:20PM +0900, Koichiro Den wrote:
> > This will be used in the following commits, to ensure DQL reset occurs
> > iff. all unused buffers are actually recycled.
> > 
> > Cc: <stable@vger.kernel.org> # v6.11+
> > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> 
> to avoid adding an unused function, squash with a patch that uses it.

I originally seperated this out because some were supposed to land stable
tree while others not, and this was the common prerequisite. However, this
can be squahsed with [5/7] regardless of that, and should be done so as you
pointed out.

I'll do so and send v4 later, thanks for the review.

> 
> 
> > ---
> >  drivers/net/virtio_net.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1b7a85e75e14..b3cbbd8052e4 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
> >  static struct virtio_net_common_hdr xsk_hdr;
> >  
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> > +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
> >  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
> >  			       struct net_device *dev,
> >  			       unsigned int *xdp_xmit,
> > @@ -6233,6 +6234,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
> >  	}
> >  }
> >  
> > +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
> > +{
> > +	struct virtnet_info *vi = vq->vdev->priv;
> > +	int i = vq2txq(vq);
> > +
> > +	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
> > +}
> > +
> >  static void free_unused_bufs(struct virtnet_info *vi)
> >  {
> >  	void *buf;
> > -- 
> > 2.43.0
> 

