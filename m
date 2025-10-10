Return-Path: <stable+bounces-184006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A2BBCD5B9
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 15:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EB164FE4CA
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F82F5324;
	Fri, 10 Oct 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qMkkpxI2"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A351C5D44;
	Fri, 10 Oct 2025 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104481; cv=none; b=EB4ywIfynkOJ2TI9rg1LS02NBhk0tZ+1r6z66gwgfdDTRQlganhM2x1DohjD3ewqQ+rgljdNEQJXWhoSHrlpvNuIRGV/vXUHkvTxEwNUvYxrhwkw2j3udT6wehsHza/dxI9WuCEWth4tet9sqylSge5PLZ+b5GIo4a1CRKJ1ziI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104481; c=relaxed/simple;
	bh=9IuWddk7LpLFJWE/Lu4PlgA+yGUYwub9PkTzysf+218=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOPwnfy16fB6zpuX6gO6ikg4M/Flyi13sunAXg5t5AjF4xomqOPLJRBNCEnzN5I/70jr/SG92XixtTMNMkyi7OsnTZOj31XwnQyI96otEWDnxrLD1trEfsZ/Gr3mm6sSdGq0mlsqhxkf2rWbh4lZfbzeokcXw3dOHW8AKl/EsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qMkkpxI2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=okET9B2Eoj+NMe4MVpvuHZsiDFXZQtnPXPl9SeB8Pto=; b=qMkkpxI2i34p7jQD8viiOa1WJh
	RWgMSiIdPjZgeCv2qVvbuJGHZwl5zQDEmMTb0RCHmxucWHoSbya0fwG7oG6rcrchEubMksR9ZAZUu
	Z85kBbVzkQQ+Va+Wxd5leGy2PLauag/MXvsmbgt1gRDoUt0b2o7ksXDZWb4LBEIgykYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v7DZj-00Abl4-O7; Fri, 10 Oct 2025 15:54:27 +0200
Date: Fri, 10 Oct 2025 15:54:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	oneukum@suse.com, horms@kernel.org, kuba@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn, stable@vger.kernel.org
Subject: Re: [PATCH net v2] r8152: add error handling in rtl8152_driver_init
Message-ID: <f6cfb923-83ff-473d-a263-8d45933d8cd2@lunn.ch>
References: <20251010075949.337132-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010075949.337132-1-yicongsrfy@163.com>

> +
> +	ret = usb_register(&rtl8152_driver);
> +	if (ret) {
> +		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
> +		return ret;
> +	}
> +
> +	return ret;

Now look at this code and think about it.

    Andrew

---
pw-bot: cr

