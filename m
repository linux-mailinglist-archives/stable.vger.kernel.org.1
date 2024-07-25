Return-Path: <stable+bounces-61338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B172793BB06
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 05:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CF11C21A40
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D341D15E9B;
	Thu, 25 Jul 2024 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7Kr44oc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128F4C6D
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 03:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721876472; cv=none; b=PMcx3MwgF1v5Pqh4pOb5WPKFWkTixfFpjs8haBaDE6D50bw/tvx/erNFe5Sjk732nGzaru21sfwtvztGymsWjkchoHnM4zMbfcqsaDaAFrAC1UINoByjujwYGp7SjST/XTk0ijWgZSmlcr0Lh//Fed0MBUAFtiElRBuucoU53DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721876472; c=relaxed/simple;
	bh=VF+PXS0cN4+7WGdSUdvB33v2NKJjsMSSiNKGb+niVEI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LTccKnrcoSbEh8fYyJLN18kVk82FMmVboixzeWJXd2ho8y42UFM5PNaDANo3uGCWPB4PdDbgpSuEjrJcLsO33zwxOoY542FIJXIZ+bL4gUvD20lts13LtQhBHjyGVpKVViSmQlb13B6pNlc/8DNQqOTyKLCka4yVKjCbKJ/3Wu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7Kr44oc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721876468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR4C1klarxsCcuevMDPpmoXX3IapIZL76EvSWY9IHig=;
	b=c7Kr44oclmiPCedjTDy5cvE5Al+XbVetQv9WXNqZxNqSQ+Lek/dD8Zw9r5PjJq899imFVY
	Q+PDwIkfyTsOs4CybCfSla4D1DCl+UHsX8jbStC6ZMrRSZs8dSvThQ4v7lLNQ4NGa0bnvb
	Chbxelwd4OUpbv+qbvCePvLRD2UX0Is=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-uIzRxzTVMW-pMXgIeFir3A-1; Wed, 24 Jul 2024 23:01:07 -0400
X-MC-Unique: uIzRxzTVMW-pMXgIeFir3A-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fc58790766so4350015ad.3
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 20:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721876466; x=1722481266;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WR4C1klarxsCcuevMDPpmoXX3IapIZL76EvSWY9IHig=;
        b=clJlB6srwdiIFe51ZJ/ISeRkkrtD5QdlQECyfpanheUXMtw9cftrzZ4pDOuZ1hxHq8
         EJbh7G6BpOA8dxgBiesUtPEXN3WMjX/EJinmkEEbBh8a3b49MqRtk+SjCCUoP/JRcF2o
         cWY2osdzfyvZWdXNQZl/4NBsNIpMWMViSgSE2SVLLIXsW64H1A2/jO6DYzUZlZwL1QTQ
         HXgRN15NejdM/OMD6YZCdQ/Q9e0mdFP+wtSruEG/vYLjwM27NHUDaMzgpfX21fMddTuf
         +donnEuy5N8O1mEDJDr7j9K6AGkc0Bh5B85lvBdB9Xbxtc7ZJZYtAQj2sdRPQQ4PlnXc
         u0hg==
X-Forwarded-Encrypted: i=1; AJvYcCVxup6nZkKBPkk1rWNK3Z76B0ZHDxowuycjsRfJOtHEfG2QxDS/3Czc/viXhwwRKCs++m9CslKbqjkvhnctIPNh9GQwwGpT
X-Gm-Message-State: AOJu0YyYcT0zK+NnfIL15AS5YmM5jzd6a5vfiXdNy5o6b5ivKaYlopVg
	9VaKi2/3QqA9oU+Up94NQamkMqGh+qQwn4nma5Cqb8DzMczTCckeX7ugAx0MRPyYFKJa+YkJze7
	pWrlgGHqgBPsdjfL5erRYfOGswgnF9bw5CfUUgNd9X2yDfWriIadNWw==
X-Received: by 2002:a17:902:ea02:b0:1fb:4fa4:d24 with SMTP id d9443c01a7336-1fed3aed403mr18867305ad.50.1721876466419;
        Wed, 24 Jul 2024 20:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdSwWHgKDpLoPuClxTWTLGgSR81gaWdx9VM+Y30/dTNbwfcdNrSvXE5T5oFpUbysdfWQq5Iw==
X-Received: by 2002:a17:902:ea02:b0:1fb:4fa4:d24 with SMTP id d9443c01a7336-1fed3aed403mr18867035ad.50.1721876466045;
        Wed, 24 Jul 2024 20:01:06 -0700 (PDT)
Received: from localhost ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fb1accsm2912335ad.261.2024.07.24.20.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 20:01:05 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:01:00 +0900 (JST)
Message-Id: <20240725.120100.2041590414991833213.syoshida@redhat.com>
To: make24@iscas.ac.cn
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, liujunliang_ljl@163.com, andrew@lunn.ch,
 horms@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: usb: sr9700: fix uninitialized variable
 use in sr_mdio_read
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20240725022942.1720199-1-make24@iscas.ac.cn>
References: <20240725022942.1720199-1-make24@iscas.ac.cn>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 10:29:42 +0800, Ma Ke wrote:
> It could lead to error happen because the variable res is not updated if
> the call to sr_share_read_word returns an error. In this particular case
> error code was returned and res stayed uninitialized. Same issue also
> applies to sr_read_reg.
> 
> This can be avoided by checking the return value of sr_share_read_word
> and sr_read_reg, and propagating the error if the read operation failed.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

I did a quick check for sr9700.c and there seems to be other
suspicious usage of sr_read_reg().  But, for sr_mdio_read(), I think
the patch is sufficient.

Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>

> ---
> Changes in v4:
> - added a check for sr_read_reg() as suggestions.
> Changes in v3:
> - added Cc stable line as suggestions.
> Changes in v2:
> - modified the subject as suggestions.
> ---
>  drivers/net/usb/sr9700.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
> index 0a662e42ed96..cb7d2f798fb4 100644
> --- a/drivers/net/usb/sr9700.c
> +++ b/drivers/net/usb/sr9700.c
> @@ -179,6 +179,7 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
>  	struct usbnet *dev = netdev_priv(netdev);
>  	__le16 res;
>  	int rc = 0;
> +	int err;
>  
>  	if (phy_id) {
>  		netdev_dbg(netdev, "Only internal phy supported\n");
> @@ -189,11 +190,17 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
>  	if (loc == MII_BMSR) {
>  		u8 value;
>  
> -		sr_read_reg(dev, SR_NSR, &value);
> +		err = sr_read_reg(dev, SR_NSR, &value);
> +		if (err < 0)
> +			return err;
> +
>  		if (value & NSR_LINKST)
>  			rc = 1;
>  	}
> -	sr_share_read_word(dev, 1, loc, &res);
> +	err = sr_share_read_word(dev, 1, loc, &res);
> +	if (err < 0)
> +		return err;
> +
>  	if (rc == 1)
>  		res = le16_to_cpu(res) | BMSR_LSTATUS;
>  	else
> -- 
> 2.25.1
> 


