Return-Path: <stable+bounces-192564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E4C38BAB
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 02:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621641A238F8
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 01:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E25223705;
	Thu,  6 Nov 2025 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lowElG/X"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5D18C031
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 01:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393488; cv=none; b=Sfmch1uwdSSp8lIEIh/GDLlQ/i2sa1D8i+dWzLc5Udye60S+gjGKsojdpxSJ27pyJsjoFLUMsTUPFLjrlEKU/PRVWuc5OJdc6Yeq9TKEhSN2li4vBt2PKNy4y7Pz6Xfs6ij5FsByrZHxZqCpVAvYv06LyMcy8LWM0ZI1wuWejvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393488; c=relaxed/simple;
	bh=uXggKOOg8qY5wpScmPa1g6Myeb/kXJkE+8C71CpzpD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8sI2vglVfb3OENKWrBBbBO48u1dzAEsqnpkJsyf8udCWCmxTXXZAZ1/IGKMepMkh6XjYNv92dF/Nee8X/k+zx0UJfPuCeefbvS90agRslG5AIgOCqJgj/n0txjI0nPUDdLWijWAsm/xVZagZWP/5ok4s6mWvqNu/lZz+CmiDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lowElG/X; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7200568b13so77777266b.1
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 17:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762393485; x=1762998285; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEEJ+LqV/J689MN97nUNzHTLqbjLFvnlgtqVatgdXXs=;
        b=lowElG/XMm4J7fCNhqLN5fd4fShzCa4IvCWlO8HJfAJrXngl3Z+kLu7m6hpgMfr0A0
         k7wIYTXWJmCg8S6lT551R8oxMUH8Q0JhcLTnLVm0+X8XJJX6d9USG+2zfmlmaLsyqUJl
         oAyZuB6gYS7ixOBZmAcvbG04w3FqJC/BtJBZvpQZg0no9Yb8yddfdgj/6HQ2AU5Gvn09
         gcO+tAT2T/JGacorBo4YYJs40tuy1td88BzdYTZ+Qc+Uu+v99xUTD2ar6j+O0rHGhdIo
         rJR7RVViNwEp3h3LD831sEUvVZPTjlqMBzjnCwOPEQ1tNxl8aUhDgP+5jKudrcyZQqia
         oEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762393485; x=1762998285;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rEEJ+LqV/J689MN97nUNzHTLqbjLFvnlgtqVatgdXXs=;
        b=fKpKNtvw6ujPDqjRO6TxuaKo4W84B8eChVoynzKO06guyWk2sojyM4tdrm79aglIYD
         CzpCg56wVHl5RDc9Qh6NqGTicA3s2NIdiGcth/UuEsc8ZYLD3KR50GSyd4qBWsKvv8jO
         U3CYgf5cbk2LF89VAuAISYOb1nsnhtk3CHh6JvpBf95Tq7HraSaOGj3l9LWhoAa0TchO
         CpWXo365232GD4rLYFdlb/4WTzffSSXDsPMPXmG0WfLfOdS9i2KsFJlPy9xfhU+2CEkW
         3r0glTu+4qDDdWnrNOp2vsZCCiinKJYcVDbQfPm545z9f1P7rK9ZE9PyTo6dpoZSWQfT
         fqdg==
X-Forwarded-Encrypted: i=1; AJvYcCXJke9bW0Uoui1X2m/VzxMLz/mnNLdvObi5ALbayT1kX88vuCsmmvLfCe12xsLT127iVtJkG0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYUXeYTq97MRXUBW2ms6rEnbqx++ii0HIIBiRfvq7rqMy9vTR
	og2aq+H+kezj0I851+PLSLgYE5XxmJd277mW4ZU/sHeu+fObKsROzsBY
X-Gm-Gg: ASbGncu0WPQY9ey5n6l57GZu2OktGPJradXktrxjDRI0AH5jajR+kMnsVSybcVfZVj4
	/QZINv22b14XwXm936Eo5OycVbUcoRru20wDn2esM3vkjuV+F8gUa7uRuIpP29V2MrJEAjctWzK
	SI5jqJuq1CY5vT0qB4h7g/qrWWJOvd0xb7ocU+EY64rT4KIMucQP4p9w7bo2TPhLInmQ8G2fOb5
	3OMHb3spXjKoTnOE3ztCzG9rWgPukeyxP8NbcKSKFZDqkRWytvpn8KxS+07MkbAL2mFa5COIzUE
	SCGGqJSN6e+bcpMRnk8SdOUyHaUbUl2QhznBX+MnD1fLnRwI9Y+B/8/wgMZQwSkeBADynVRh3QW
	Gg60RxXPPpJtjZAAJ81EwBab1Vo3rXO8tCmWgQ2ePS0Zms0U5grHUcNRLPgZKO/Xfp45XIxHkUl
	c0vIaGZw9HrQ==
X-Google-Smtp-Source: AGHT+IHJEYTNNMqTgGZ5Z19ASHC1/aHl2q87qeR2t0TYHvehAhnbl1q6Hr7yQiLOC3CnEXe8R0EkYA==
X-Received: by 2002:a17:907:7241:b0:b6d:5914:30c with SMTP id a640c23a62f3a-b7265588257mr472200766b.34.1762393484633;
        Wed, 05 Nov 2025 17:44:44 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72896c93b6sm94181466b.69.2025.11.05.17.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Nov 2025 17:44:44 -0800 (PST)
Date: Thu, 6 Nov 2025 01:44:43 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix folio split check for anon folios in
 swapcache.
Message-ID: <20251106014443.wkurq6p7ofhsffkn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251105162910.752266-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105162910.752266-1-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Nov 05, 2025 at 11:29:10AM -0500, Zi Yan wrote:
>Both uniform and non uniform split check missed the check to prevent
>splitting anon folios in swapcache to non-zero order. Fix the check.
>
>Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uniform) folio_split()")
>Reported-by: "David Hildenbrand (Red Hat)" <david@kernel.org>
>Closes: https://lore.kernel.org/all/dc0ecc2c-4089-484f-917f-920fdca4c898@kernel.org/
>Cc: stable@vger.kernel.org
>Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

