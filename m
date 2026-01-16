Return-Path: <stable+bounces-210069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DD2D3343B
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E142302AE28
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C74F33B6CA;
	Fri, 16 Jan 2026 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXuoiNOf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JD4OfqkN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814126E165
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578022; cv=none; b=ksGXzE4cednBGbD7MRcyqXiUaT0HENhPAIaN4cPatoh+K/8scrMDvgkBTquGeR3IH3joQvwYPJ5HnMskoWONc+kqnQ3biwe8UPuLs0swy7Dpm6j23V3lyIwXXtGhJP5AAp/Lp0KU/PKwSRkcgPeOZDt6qVLBgmzbIuJDdK/f+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578022; c=relaxed/simple;
	bh=cztxYVIqjL0oW7JOzUXBiK+cA4OYKlVjC85SzzUB6sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz5g2fLdk213H6c9uypgdq/h3Zu5geieNazQARSXIztJCYfXqozIl2sGaxBfRItwqqHFLItRnZpx2RHPEXtw0r+cG5YJJgaFJeGyJZK81pmBnCFdWIXFEatPvGJ+Kx1eYN5axbLNJshpX84GfGB/rT909/VfBX3PbasHgHFTc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXuoiNOf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JD4OfqkN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768578020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UrIyizG4iGXof9Dj2XjOXJtNOGOenafithbTMq20cmg=;
	b=LXuoiNOf+ZTTiv8H9tHzK8nBpnFZqLH7TjBvTWugAFz/ait66vfkP7TyX1HPlR01Kz8GbX
	87+Zx/H4gDPFfJzE4CP+bp9yx/3m5sV39dy+0zGufE0/fUyJxqJNOUqjVGtY2k8iEiXICA
	km/FyaDUw13/fp2538qSuePMibRnOUk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-F9_CGot1NpS8edHs-FGf5w-1; Fri, 16 Jan 2026 10:40:19 -0500
X-MC-Unique: F9_CGot1NpS8edHs-FGf5w-1
X-Mimecast-MFC-AGG-ID: F9_CGot1NpS8edHs-FGf5w_1768578019
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-502a4aca949so32166691cf.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768578019; x=1769182819; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrIyizG4iGXof9Dj2XjOXJtNOGOenafithbTMq20cmg=;
        b=JD4OfqkNLWy0J0cW+Ku/x+cNgpxaybGCC+QJZHLBKEWNhCoICLQ/o+Cj5u9AlFv9WC
         6kYYxj/rzJaMdOUCExXc2HX9yhn2lON1IWSwv4CYxJO9X9hC1LW2FAPEVF4pcg28nQTF
         PWvjhEH6H4F8gQcEh4rBPfx/SUkpmfO5TPkmGWZ9yh7lU0Uw8hByhRsslTgGnq6H6kNc
         tZHIL4oDKz9ixmlFG04BKY6pxp//QIoK5Rm8VM9YdN8chpr9d0uLFjt6rmdILXHvZmOt
         N5dmNs8f307rf437Uq8HPVnhhTAPI+OPsVuivhOeZf9x7nVNvpIisvT48Xjbe5TUO2qS
         T7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768578019; x=1769182819;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrIyizG4iGXof9Dj2XjOXJtNOGOenafithbTMq20cmg=;
        b=Wr5AvjitT6SiveNcAfDuMMZQOnMLrgh+n4qrQ7MgTHSue/nr2jIJPBLxmxSNLErUu4
         PYcr6nCJOIe7XlmnwKWBaARzt2FE0bvm89FYB77bY74B4cDDTIJqRDdae6stp/BvDazm
         +KQaflw/HqTdSZ2fiwcYGVS6oGNkt5pqsd1Yk7yFfKYXO3y0GEWRn7aoBUMTImhikV0h
         O+/3GLD2wpvnpaMjoKf7kB4IExS4BcciQmIShlU4X/AivneB8dGKF1BDomuJN5CXTGs5
         9c7Ts6GkNFy7/9P2aL1+Oe1PA+nuU+uFO02eKFPICfKY9Si4HSC+DKssBP4B1aoVqnf7
         brUw==
X-Forwarded-Encrypted: i=1; AJvYcCW1JoB3V8RJHx2FLXFPN9g75KbVsesabaBSpuPBqdl0zCbNQ5CCFwIxFGWwh4JWputzfmpts84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHVGg4a0zf3Ro8/J6mgQYZAzX8IZM2x+2pQAi5/sxvA4P0Z0nQ
	eIqrDRi2piOqF+cjxMxrawhxdugtZghlv8ukIAP7PovtwAfxgIkjrtZQS9HOcoi3Jan2zTJ+2jQ
	ukz0iRGd2Pj0wlQ5n7COCun/UPLgTpKtXigW/StdC9RsliG6XB4U7FGAmYg==
X-Gm-Gg: AY/fxX5MWHhzsGegxq+nuMqgJo38ERDqfxlvhilLA4FXnRxHHAVynUEiTPAsU4OOH9E
	K211Hin8nHLFJ+m+uS0Vco4FqqrSolu9UCTtnJMZMX6mCinaUTd23r9MElXwh4x9+9EukIb9uV6
	Dz5EEVXazXMGyIuVBFEHjPpr7Vf69+CxjRg8gq5HISI+nGAsGXesDi8j4GR5R/Cqq7RmjGUNaE2
	0I0XaBnQXv88MlFgJLVZ45wpWxk1IsSncYzkqFmlBrkFYCn5HkRxWJ6yPzf6S3fvi0sGTUZQtyQ
	kzntgueSFw9f2muDoPNkdyta+9kTW19opXoHC7goJ0QT3UmeERtHojBfm6q5i4REw/ZQc9GknnF
	FFvP86uIkbzcUsxZ0EK4u0Nzht61vkLnw6NH2be71EnWC
X-Received: by 2002:a05:622a:549:b0:4ff:c273:c1b6 with SMTP id d75a77b69052e-502a1fd897bmr42263131cf.83.1768578018555;
        Fri, 16 Jan 2026 07:40:18 -0800 (PST)
X-Received: by 2002:a05:622a:549:b0:4ff:c273:c1b6 with SMTP id d75a77b69052e-502a1fd897bmr42262711cf.83.1768578018022;
        Fri, 16 Jan 2026 07:40:18 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a725eb16sm250590885a.36.2026.01.16.07.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:40:17 -0800 (PST)
Date: Fri, 16 Jan 2026 10:40:16 -0500
From: Brian Masney <bmasney@redhat.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/7] clk: st: clkgen-pll: Add iounmap() in
 clkgen_c32_pll_setup()
Message-ID: <aWpb4KPmlTXqHZWU@redhat.com>
References: <20260116113847.1827694-1-lihaoxiang@isrc.iscas.ac.cn>
 <20260116113847.1827694-5-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116113847.1827694-5-lihaoxiang@isrc.iscas.ac.cn>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Jan 16, 2026 at 07:38:44PM +0800, Haoxiang Li wrote:
> Add a iounmap() to release the memory allocated by
> clkgen_get_register_base() in error path.
> 
> Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Reviewed-by: Brian Masney <bmasney@redhat.com>


