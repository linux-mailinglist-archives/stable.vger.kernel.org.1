Return-Path: <stable+bounces-240556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLosJHfg6mkNFAAAu9opvQ
	(envelope-from <stable+bounces-240556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 05:16:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A9459661
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 05:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686563005D06
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 03:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95DF303C9C;
	Fri, 24 Apr 2026 03:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVvUQUVs"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFFD531
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000473; cv=pass; b=OeKhi8QdpSi5XekZe7kyhZcfm5qtbm3dvpCBMndRWpMjUBBbvLfvNR/JN4r15R6nDtt7cjmUsa5wiraUe1kkLeA77pY9N83Jj6EOpsFwxBlrUq5JqPay1OjT4gys1KVl69/YQL4BDXW53OAlw9W99NF0a3SfzkFyUJY4CTe9DD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000473; c=relaxed/simple;
	bh=zBapVJPklVtbwGQx+QM1x+AmrbhtwJmrdN+kavM2RPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTVjI80o8WeDzwPQCqket/X2KfI0l2574JZKZCsNGmbBP4L+w8o0Ni6U/sqvmxV4jrxdjg8C/gula8OwCUCTTngsTkB1ouHztGUPH358Wb2k/lIQIXj98c1UEaWegduDTkCUWAKtAKpiXS7mlbZpOVEzaU4Ub3EBMVbkBHossak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVvUQUVs; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6501547d7edso6786823d50.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 20:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777000471; cv=none;
        d=google.com; s=arc-20240605;
        b=GKBKGAsaKZt9gsb18LhSVknXtz8hb0beBwuaFOtVkOJb4oQhHqzEvscBUfE8ngIu4j
         pLLlhZagj5P6EDW+yrvHm/Lfhsclb4ey8uAv22UbXsQHhuoxK8WV0YNtVX8lpiTYzEHf
         uCFNbWjoNloBA+T9IGSDkPnNSAp1tflYI/WrXuV8zLKc/GQBHziM3Sm5iH6dsLd5VEHF
         LkbhLY1RSKmFpwn5rRLUxrB8R7qbFOfImaLjZRU+qfvt+vH8fpkGoABjP5N4BGSyqNbz
         95/tCmPjLzHqdq3IZ8N+7SDXTd1rhSzy7n7fiaOtTL65CkVlIcjreoBoylvAemABaIHH
         P/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zBapVJPklVtbwGQx+QM1x+AmrbhtwJmrdN+kavM2RPU=;
        fh=/6+XJevZasmTqfqCPeXdCteowqdT8d0fQYE5UGHZR6Y=;
        b=XluzJzUdAzuSY99mN+A5htVhZiAuGowSnA4AXtY460HAszvwKBRYomcODNIZWe3GtW
         ltu8GfWlcskdNcrTD+pYtZT5grmqf9Ow2yeCt6q3rj8n+e+/VUZinfoHZBJYROZdztOt
         J6YD7PNXyKnKSPjcFZ4NsfiOcmXt3KaQ0ybFBJwjemgIWNbkQYCIGh/5Mvc4koUpwwFf
         MQy8NKdwdAC+tgmcwu0DZ6HjcS4GuyTFCGWmYevbWjG2SRLfydEe9k6toUAGkHbblNkW
         gDXHd6TEgxj61a+022V8qa+xZCrfMAWk7sF9hiRr+NPHbm72g8A2tqPsNUuImIKFh4d4
         D/Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777000471; x=1777605271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zBapVJPklVtbwGQx+QM1x+AmrbhtwJmrdN+kavM2RPU=;
        b=dVvUQUVs41nK3qQ1/LNjnk+QlAz/MKHMZ/i1txgvwDNurhThyEn8TCMBwpcOpsr2PH
         YK+PyMkD0yZyksqA73pmYv54Gw8hIWCrGifdU3MRVhjqbAZ7hoS8tKPPnnSJyYzkhk7S
         paukSPEzMszBMmQoWwT5icIQzaw6pvbmmxo3rfYsE+d+rXMtPSXhA0Y/4AAUPXb5CU3t
         HYTIdJBHWlxM2rtXRMKMl+6M3toqc4V06nKf+/SgbeEdLiJBr2mqoE4FcKe2mr13mkp7
         2LxpHNyjk24tg1/HorncPN5pvuFFR2mK1IwzTEwJQRhhOapggmp8bSzd3SP9rEWk6XQt
         vWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777000471; x=1777605271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBapVJPklVtbwGQx+QM1x+AmrbhtwJmrdN+kavM2RPU=;
        b=AJVDWVi7jtlC7LfdhsTwzksM2/wI8CatDcM9Xzzre2DcnN4nV8fuBXFDnYb5T3Gu/W
         b7p5OiQJEPxmYYBNH/rJCSYFyQtXkXc3gve2PNESYfK2W/P4uCJIElrg0A2wcV8NcxRG
         KA99xsjr/CmyhIU9/FUOdK4LbAlBoBnaYVwrdMICEMwzX6XHhlQo7qLXbN9scJtTV0U5
         m5Nr45elGAlAYep3Quq5qyWw/V5GsFUWJ4YzSrb7LRKjtkvdlmYYzV81iM2Ih8hUOuNQ
         4Xx59VxvtEx+8GFqF/u5tto8YiwZOTnJh5Rqpyp0CNAnoax/idQsipFY/FjIZXXnzmDM
         GYRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IISZnMteNnHOjUAm2PA1ZHnLciVFwsxayMDH2+6P98dNghjmtQxptqEO0NqcwBt5XXHjvHtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitrEsIQ6fK1gf67clrvzwqi9SWAp0XCOzCVMLF/D6mmvNmovk
	6ePhgjNuu5UxjUNShX4FFijr4MoI8P9VuJnGs6u72Ntn7Qx9ux4ZhPwVWu8kTnNf6/3yhiXpkqD
	CiUoIeavFvQvIitkeI6xSl8oo3NxX5So=
X-Gm-Gg: AeBDiesrVACwkV1U90w3px/WbFZb71rXH76jOakLh5li7vOza8Tne9DOfpNgnpANbXl
	It21rotnDSenNLd88WUcpIPweu5hfFsGjzauqTUtm/dn2SKYgBXwV/8mrH0OdQ1JsIFhV6b3wY2
	tvLwzx7ElFUhGhYjEwRRdZtH2yim8Goi1iKNjMWvDEQCr6Q0jagGgDObdrKRwWLk+X/K/zQUHKb
	eQOXneGmn/kuq4dntkHgf3jVbEir+CyRQGM4JnxSTe6Oq3irg2szfJKsqgE/38qVULYLndg7HYW
	ZTsItHSDsRQK/PMwX8Q1
X-Received: by 2002:a53:dad2:0:b0:64c:f395:c19 with SMTP id
 956f58d0204a3-65310bb4980mr21401458d50.64.1777000471270; Thu, 23 Apr 2026
 20:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
 <177645836617.906013.5675762942401997007.b4-ty@b4> <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
 <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk>
In-Reply-To: <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 11:14:17 +0800
X-Gm-Features: AQROBzCjis2FGx9xMR9_OK9MG4iG5DCEoaPMwiGenSDi9BetnMmD33B6U1yLaEs
Message-ID: <CANUHTR8W7tz0me90GDci97ee6N+3MpB7uVYYFN0dtTf9u_Ui2g@mail.gmail.com>
Subject: Re: [PATCH v2] floppy: fix reference leak on platform_device_register()
 failure
To: Jens Axboe <axboe@kernel.dk>
Cc: Jiri Slaby <jirislaby@kernel.org>, Denis Efremov <efremov@linux.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 385A9459661
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240556-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Jiri, Jens,

Thanks for the review and for catching this.

On Thu, 23 Apr 2026 at 19:06, Jens Axboe <axboe@kernel.dk> wrote:
>
> > The patch is likely wrong. Given the pdev is static, the struct device
> > has no ->release, so releasing it will trigger a warning. AFAIR, the
> > consensus was to fix platform_device_register() proper.
>
> Thanks for letting me know, I'll revert this change for now.
>

You are right that this fix is not appropriate for this case. Since the
platform device is static and the embedded struct device has no release
callback, calling platform_device_put() / releasing it here is wrong and
can trigger warnings.

Please disregard this patch. I will drop it and not pursue it further in
its current form.

Sorry for the noise, and thanks again for the clarification.

Best regards,
Guangshuo Li

