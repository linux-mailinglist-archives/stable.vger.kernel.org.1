Return-Path: <stable+bounces-254403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEjpHk7bFWpzdQcAu9opvQ
	(envelope-from <stable+bounces-254403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:41:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F025DAD76
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDFF832504B7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3E40802E;
	Tue, 26 May 2026 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpzABgcD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpaYQsmP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C5405C44
	for <stable@vger.kernel.org>; Tue, 26 May 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815767; cv=none; b=soldenbdQu4oxcjc+OlwtXs16ihcfZTyxC+QK0xSengTF6knrbn9bGKyA9ltNupt3tGkSq6VICcNf1EWdkPTY64A4E6QzrlDYLH7KwvjyOWmNGYKGxTQh71bMRR4f/hdNzTKYABlLmAbbcFy8wgymTHC4Z9Mwk1UXkl5sLc6KUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815767; c=relaxed/simple;
	bh=RBEHuNsVmU6+ThSKJuEYBB7vzlMO2qvs/8iC6YpvH8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxyP9RbekRpGTUOTkImP1pSDe16VgmjDBZBIBYEg+HlbGODZgHI217bEmlzkcp+/BjxcxNCnbe7JLZz5vSHegT0Wdc3I7iaEaYxUTOVLMOlwIeJv/Zx/HIt+KsiOYYWMj2orfoubMwLZr0kMi+H/xZydWJpeKjcvlimS30LduS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpzABgcD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpaYQsmP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779815764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kbKjzg9bSmm9vRJLbDtl4q72jw2NHj5tbX6e2y5JU5I=;
	b=PpzABgcDRZIrfEJPO//hMFvsQVW+kYRynQ2+8VRGzT2jGrxi3czX5w85TNhswUCNWJ4vTv
	YNlcO3IHGvn02UJ8rFoSo4YQUX08YNFubBrQs6r2HMF5SSw1HR86Dw4brll8Sjt/bRbY5y
	Jth9GkFT0bSf8bzmSNHs2/xqV8RZkoA=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-2brKDuieOfKVKl55VXUnfA-1; Tue, 26 May 2026 13:16:03 -0400
X-MC-Unique: 2brKDuieOfKVKl55VXUnfA-1
X-Mimecast-MFC-AGG-ID: 2brKDuieOfKVKl55VXUnfA_1779815762
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-43b6f928e2eso3761158fac.3
        for <stable@vger.kernel.org>; Tue, 26 May 2026 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779815762; x=1780420562; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbKjzg9bSmm9vRJLbDtl4q72jw2NHj5tbX6e2y5JU5I=;
        b=bpaYQsmPZTYrJW3bFx4sy/T/D38qfWgs4jn1R8qAW7TgAzkxmjc1BDb1RY27TOyAyk
         mV+7pchi83hGye2NCxdUPs9lNAGBn/Fgm3x72cLN2pJ4diRbndkJkDKHcBScqH65LxaO
         DVP5TH25sh98xa+UrTiQijeyP2kLKtrkgkOpFeJyHFA1NbbHtqBImDpwOFYr+uz8+RKE
         fmInWGriAmL/xeEK73LJN9thPNqGJHbofsiJtt0ovDddjmmwPBz/NXyA/NSdXSdtjYis
         sAa078XcvE9QRbPCWJYHz3eYxLB/evcK6e9dEQdBWxfaPnBlPYhu1G8jedy4CF7E1wo8
         Zb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815762; x=1780420562;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbKjzg9bSmm9vRJLbDtl4q72jw2NHj5tbX6e2y5JU5I=;
        b=helk4FQ3Pq3rBD/2Wa2M1/p8zCaZCJ2UhMh29Fj2/1apOoObF0UF0P6SfCqSdk5YSP
         Lqmjd5CtCtPICOmAVBx98Wk26KSqNt3jVORk7njfPz5BrIJg3Vq8Uy7dj5xYXz3OpBZO
         YY3+03GWqlpskrPhxTYX5Jn7bXxHuCVcNIGD3Mg1Wp5kAVMgJV0jgfhwSnLBOf96Tqzb
         nvJDDA/lbfyqQIEUgf2JDcC8QQeDlYvaW3tYaglA2aFN2yJtmQ1VMDdgrLDNtsKdwbDi
         Re1fphTLT+2OBjzO0jPHdM8WYwqkN4+6v8WyX8OLxZw5yd5JXYN8Q3TKqp1ViHGBrd1u
         VNKA==
X-Forwarded-Encrypted: i=1; AFNElJ9UHyDZDrobefhorFbENcyi08Q9bNXN8zIJ2tqQSDdPY8akr3YHDU0CjwYRYOOHZJfa8Xssqpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxte9KXAElRo2H8Bhp9OigySKCd+E/Cc9ALn2DMG9RhZacd19sB
	hr1sHTVRcQzcsp1LhBtB1Z0/WQZqsVmpfLOQPWiKzt0m0Fell3/8GRb77B12cwYjHXDPxoB7VLy
	QUBMtDhTuqL+IUWGsBR5tDG3ouSPYZkQToinmGF13ZJjQHkCCPEWtVTzSeaFth3mpvQ==
X-Gm-Gg: Acq92OHeqAT9R8px6kD0D35dpyoUNViYOvePkYM6pMT/izic+jXv0EUNrFw2rQM19Oz
	Q31uD/9n6wHkh8DJPxh/3KTeRN0ZytOMWeWMIyqEPwvWEuqw2nFW97a67vFY7zHjjYIHYs573bS
	bvYxY6Grx+9wGdV5pKMPaY/RTnlFYp0kKIqlfaL6oIv7WSKvHUoV6GC+xUPneG8KFL7g4yZK6QR
	mikJbT1vH3sheLAzZ9cpsL33CF7y81Sb20xPFKYY4kNF+qti++FxbqfR+Sh2MJOIuQIS/g44bns
	0StkDA42y0n8wBANg87M71sMKf3t0TT721zDHN6IoMbr80Wpo1jiKU7SlDJllvDjf8XDv+opEE4
	ZmrVDEbGmG4g9XqRVRxj9ix6p35Ae1fzwBycamLHwd37AYGiYDElUpwXGPeSAj6dNLbo=
X-Received: by 2002:a05:6820:4b14:b0:69d:d9c5:9308 with SMTP id 006d021491bc7-69dd9c5938emr1142390eaf.16.1779815762420;
        Tue, 26 May 2026 10:16:02 -0700 (PDT)
X-Received: by 2002:a05:6820:4b14:b0:69d:d9c5:9308 with SMTP id 006d021491bc7-69dd9c5938emr1142352eaf.16.1779815761931;
        Tue, 26 May 2026 10:16:01 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e2018sm148514636d6.28.2026.05.26.10.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:16:00 -0700 (PDT)
Date: Tue, 26 May 2026 13:15:59 -0400
From: Brian Masney <bmasney@redhat.com>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, wenst@chromium.org,
	laura.nao@collabora.com, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: mediatek: mt8196: Select REGMAP_MMIO for vlpckgen
Message-ID: <ahXVT62JUZmliXfy@redhat.com>
References: <20260522133023.355404-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522133023.355404-1-akkun11.open@gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254403-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,collabora.com,chromium.org,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D4F025DAD76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:30:23PM +0900, Akari Tsuyukusa wrote:
> The MediaTek MT8196 vlpckgen clock driver uses
> __devm_regmap_init_mmio_clk() by devm_regmap_init_mmio(),
> which is defined in drivers/base/regmap/regmap-mmio.c.
> However, the driver's Kconfig entry does not select REGMAP_MMIO.
> This causes a linker error when REGMAP_MMIO is not enabled.
> 
> Fix this by selecting REGMAP_MMIO in the Kconfig entry.
> 
> Fixes: 2f8b3ae6f0cb ("clk: mediatek: Add MT8196 vlpckgen clock support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


