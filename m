Return-Path: <stable+bounces-182059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F23BAC608
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 775257A1DCD
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 09:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46B2F7475;
	Tue, 30 Sep 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoZnNigI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F762F5335
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226235; cv=none; b=gvFHu4yABaJ++8vXsgH9/363z6JKO+7OXrnw2CREbCYEJkNwfao8RqUPnoaD+6/OwlZd6TaNfEjJ4IaWk1xTq5JRSytv9rImLtaeg5SfxRCyp8e+fXdClLutPbIiNAn2n0gcwFv1auExVgh3tsjE4VUpTe0nh2IDKKexdWNNalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226235; c=relaxed/simple;
	bh=Iby0dCV1k5FoMaSlf23PqKFSrLsu46FnHbptNvkg3QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um6oEgGwdwPrHaujCoicZKdzXfvDugPr2SzHANbQbmjId33hDn+4BCnTWMZ72szI6pg5eIngj3U6Ot3YePvLFsZzDDpDCTRA9uUoIH3n6QylGN+ErGt4EszmL/QN006Rd6DlYyUOEXfU4AsWokGT6hUjn/L9GsUnMYDkh5NKKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoZnNigI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759226232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srAu9efQeLkOrSNZBhuxJ9qVZjhUw1Qf2FT+xE0jzg8=;
	b=WoZnNigIx7hI+z5mdBPkrjlB/PRC1MhFZ6OebiAyMBCjIFuCWoIfcjtci4OPsDDXkxssMF
	d9qdh11eV6T+hCCNOzoH6eLMjsCtc0yGMMQ+NH7QWOBCm2o2LCnIaOVwJT5odXYx401ZkX
	Jvi79o9Cj9mCIbFyWyK0gD4tL9vXfz4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-tc6Re3i8N1W5qb79nNt0gQ-1; Tue, 30 Sep 2025 05:57:11 -0400
X-MC-Unique: tc6Re3i8N1W5qb79nNt0gQ-1
X-Mimecast-MFC-AGG-ID: tc6Re3i8N1W5qb79nNt0gQ_1759226230
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ed9557f976so3769783f8f.3
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 02:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226229; x=1759831029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srAu9efQeLkOrSNZBhuxJ9qVZjhUw1Qf2FT+xE0jzg8=;
        b=nzY87lP1FyeRUBZYP+1JROdnvFwhOtFroU5gYeXSq9TKohk8dAtZ7mdoYyuBhOqk6p
         YFW4/ZT/ImxN9zOk/J3ywCmb4oRJt80ouOTEycz5ESMtT3qOo5+dnOwPo/4tyzkWprYg
         PQmNomznR7y8fx/g83ydxIrbvGy/Id/TGViPSCRz0MCWpN+iap8YrvxsU8k3SsvW1K3L
         E0giO7bhnM3IfwF6PSbq3gjH0sLdFDF0o4WH8ENQbspI834VoMHLpPbegSm/Y0Pz+bsv
         lTLQ/cobROuTAUUH1puop5GyEusbPsCHTMATvrHx+bKhVF6kXiSs7J/XqrAC8WrvzBDU
         wOOA==
X-Gm-Message-State: AOJu0Yzqt6uahLNJIQVAlTrL92zjW0G3nEIU42e1VIaddLBnMmsq00TK
	RhJ61I7GG+RQi6d7Veg5BdCIWPNua+QmATnCBIIsxGLwd6n5iXp1gfX6800kD77P10VDBfcJXc4
	0iOwTbGmVohmPV2EZwjHqjDSpu5TanNNtGOFj0GzUS/SOa4ID6jYKBXTjuQ==
X-Gm-Gg: ASbGnctLODyUpDlloCHEb4fewl9MgNdNsuGM7o8p4Dw6TTzgQZRS1so/cFwXnaxD3Xo
	tnGvzb03RWGFuP56sMov+Nlgn2KJKiCNmSvNb52/9TID7p43G7zwLENahaWpy0QZMrSuuz+9Ksx
	EBtLyXc8FupFDQ+abZDkjvWQUILR3tDoEab+eHVNCZx/wWQ6G41trjZ2anekH9+XsFMaatn55xZ
	kHGYlvekNShUOrnqam0mHXkPQV2fMhuIa8hlUByOkyqoccyDvoDrC1sc2i02G7Dm298OC1dKyf+
	vKV04v0iaesvz+GobVnD6vFT6I/CN7J2ml/QWb+H1+ICXLW3VfRTTLJJHM5YUpPlhrSzFStz4HC
	i9bLzOzkqzD8d3y8WHA==
X-Received: by 2002:adf:eb8f:0:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-41358755409mr11327884f8f.22.1759226229589;
        Tue, 30 Sep 2025 02:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRvdEuxPGd1K1hL6v0AssJUCVO28oQVmR6eHnpL1I8WvLYCEWr5PTILGebhv46wh47Za/SKg==
X-Received: by 2002:adf:eb8f:0:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-41358755409mr11327863f8f.22.1759226229159;
        Tue, 30 Sep 2025 02:57:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb8811946sm21856303f8f.18.2025.09.30.02.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:57:08 -0700 (PDT)
Message-ID: <65e53548-2d68-464a-87bd-909f360cdb1c@redhat.com>
Date: Tue, 30 Sep 2025 11:57:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wan: hd64572: validate RX length before skb
 allocation and copy
To: Guangshuo Li <lgs201920130244@gmail.com>, Krzysztof Halasa
 <khc@pm.waw.pl>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250926104941.1990062-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250926104941.1990062-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/26/25 12:49 PM, Guangshuo Li wrote:
> The driver trusts the RX descriptor length and uses it directly for
> dev_alloc_skb(), memcpy_fromio(), and skb_put() without any bounds
> checking. If the descriptor gets corrupted or otherwise contains an
> invalid value, 

Why/how? Is the H/W known to corrupt the descriptors? If so please point
that out in the commit message.
Otherwise, if this is intended to protect vs generic memory corruption
inside the kernel caused by S/W bug, please look for such corruption
root cause instead.

Thanks,

Paolo


