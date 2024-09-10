Return-Path: <stable+bounces-74130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24142972B1C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556281C21EB9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756C313BADF;
	Tue, 10 Sep 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6uobnvd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8F175D2D
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954359; cv=none; b=EpabgckibbwdoRt0OwFAj4+boLRUFHfkhXWjV1ALe4Oe7yy87Y9jpGHYFJI9tqpL25huN/jJluF3TvMFQNDHbMZccAaXBe7ogOAYpMSDjde7lQlxj/Xk3nzGDSfcZZnUmijvy8EnENVc+COP/ibd67GaTYqryrwoAu5m/vTsKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954359; c=relaxed/simple;
	bh=BSBTo4ruxRQfsE2JUenc5J/p7HtHgNTGSCLLNZSwTz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJhFjOru28r6WygWCD2rmBQy+EiONducgmRhGGWFiYWIpOFuLDwTsiPnXbzEuxm859PHlEk3jv6BLR2Wzqam0y9B3ghf5jPtu/MSr91BQjSqWhGvZBH4kxEN786qBtLKqPAGn6mV6ejDHCVxGcc9j+Awv1mgT19fE9ZPoVbP/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6uobnvd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725954357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1ptadxHiiKdmGz9IKu4jMvaoo9HDB+LtCmpi6lUqv0=;
	b=E6uobnvdnk98DZEzQ5eSgXfHoesrgma2154nS2GuP2cE3FDq4NvfMcBFrRd3OWkrBPuxIl
	Mq/HEXHp3Or9luy9RemZkzgYva5feQh9eYn3DePcusoy1pW1ABlNxL1/Dsc0lFfkUYcIWU
	AaC2Qekm3VjSQiRLMWgsBa5X5d6CTE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-Fatdi0eNPv2P7wLE3pkUkw-1; Tue, 10 Sep 2024 03:45:55 -0400
X-MC-Unique: Fatdi0eNPv2P7wLE3pkUkw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374cd315c68so3103971f8f.0
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 00:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954354; x=1726559154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1ptadxHiiKdmGz9IKu4jMvaoo9HDB+LtCmpi6lUqv0=;
        b=Os/lRwP4/CzVhovQXOgrbGpG6ffXDlrT4YeXGPTAgxNgq8hgA0+UhdgQyfkNTA4h+u
         1d0ogp0Dcf4vAbdGE139B0bUB4gHD8eH11xW/LMyfXfcIvIVxjvA8TtGJ/3h1SYpLF84
         PiE6d9lS5GnLubgeldbz5v6NRDCJ3W6TOatTF/CziuCQ3l2zTa4UEq8dimd3MSU/mwdb
         QKfHC6DtRaInq/mLMnN1y+zRnsCl1U45LQafkccGYbd+VoQSJ8W7xzWjWIWnU7OCgi5A
         AcC+X0r2KzqmoHzX8DGjvdmCCq/t2YxzNj+jEGtZxiu6i16yPtnxL2rOeiIa5OfWLmzR
         Z/pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4e5dtUcZqZTaS1GTjERQXsoTF7yEYybY3WYr5Er2Ubn/WI+lLiVWYN2eMlN2i0Pgqr2nLX0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFxU5liedOlJ4S8cVAtO49MEr0s4YkK4wstgeNR5vs/4a/CPu
	RExXwAqjmJyy7TYJOTo/w0RHgv2jwfjwI6COP4mgNOaYQnRYZIiLlnJi1Zd/tfxY0vSvEUFF+Cm
	K8J7pRICxDt7iwDFv0GM6AiGkq2X5hxWPiF+oRgz8qNFhHNMEjHIKag==
X-Received: by 2002:a5d:5189:0:b0:374:c1de:7e64 with SMTP id ffacd0b85a97d-37894a53e29mr6312366f8f.42.1725954354495;
        Tue, 10 Sep 2024 00:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9eqnCzkfR0lqOtecKe4bXDoEjo/2YzitM9RhwvABaO8GszgGfierpU0ZN4F8nrv2k7nraKw==
X-Received: by 2002:a5d:5189:0:b0:374:c1de:7e64 with SMTP id ffacd0b85a97d-37894a53e29mr6312336f8f.42.1725954353854;
        Tue, 10 Sep 2024 00:45:53 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb815f4sm103050505e9.30.2024.09.10.00.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:45:52 -0700 (PDT)
Date: Tue, 10 Sep 2024 03:45:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, stable@vger.kernel.org,
	nsz@port70.net, jasowang@redhat.com, yury.khrustalev@arm.com,
	broonie@kernel.org, sudeep.holla@arm.com,
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.net
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in
 virtio_net_hdr
Message-ID: <20240910034529-mutt-send-email-mst@kernel.org>
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
 <2024091024-gratitude-challenge-c4c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091024-gratitude-challenge-c4c3@gregkh>

On Tue, Sep 10, 2024 at 06:34:46AM +0200, Greg KH wrote:
> On Mon, Sep 09, 2024 at 08:38:52PM -0400, Willem de Bruijn wrote:
> > Cc: <stable@vger.kernel.net>
> 
> This is not a correct email address :(

I think netdev does its own stable thing, no need to CC stable at all.


