Return-Path: <stable+bounces-254081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMQ/EiHlE2rhHAcAu9opvQ
	(envelope-from <stable+bounces-254081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:58:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 938475C6206
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 07:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59393300337C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBEC22FF22;
	Mon, 25 May 2026 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kDINA1Nb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TdEfcPMX"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9063D2D9481
	for <stable@vger.kernel.org>; Mon, 25 May 2026 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688732; cv=none; b=bTFrKymZfuSxIPqHHXoS1LkUHaUIOrWZz0Tv4whApTQ5rPJe/UySyQ1mQpfuLwkZtp+Dn5USUvjIu7XBNFR1/mDlegYBkdz2+JPIleX07xkLgrCn20a4Ma1IX1jAh18mdIc25G0bSSQ4RPaOYoAypjljmCfGFXyrg4JzkVK2QzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688732; c=relaxed/simple;
	bh=arO74wFFWnL6/MRHW4x/AGiyr23jZiaIhcY0zVX7Eds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvJZQ8Looc/QT3ebzVQeVPxEPxZC7P59cVK7saLlfNp0FiWBIiW8Fp3lm0HVZcjNIb2BzMOlQQCvndEQl0kkmM6wEbGqfTMJMlIX4RfDYbtgJk8owWmkd1skitewAv9R/9ethsX9yl/W1OsZKU2qUhevPuKSreDCz0w2CT1TXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=kDINA1Nb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TdEfcPMX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C4F507A00E1;
	Mon, 25 May 2026 01:58:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 May 2026 01:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779688728; x=1779775128; bh=3vMT6TN53p
	T/h7+W6oD4uuwvZAfaZD4eH3IKPCLL0Hg=; b=kDINA1Nbj9H+V4/c5kkCvgBKLn
	pIrnWfYDSkQwDM93hB4RM2uQYDS2aFfkrpCZKBjUXmGNQ8Byg8yvm9aJPzMcbrvE
	XDG2WwCeHZ4TkX2+6S7Sk5G/TW6B9uJFrB1wAbRbzwg+qxH9yRNH7/GfwttYgdbz
	si5NCkY+o5oKnjQhQ2Xxs/zY4wSUml6xWi5hXqaq9gCfRw8GZeLxwQOJUg4PkBy+
	GsXmEdTc2/OCDlEropeKP+49cZ67NH9G8She4iBKvOKNWhEQz8ZVHUI+zqIr8ZAI
	umt5Lhy36lbDCGSKvHOdMfK9pLfjCy8I9OhK80mTdeVcgY01pHrUWSZcqDWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779688728; x=1779775128; bh=3vMT6TN53pT/h7+W6oD4uuwvZAfaZD4eH3I
	KPCLL0Hg=; b=TdEfcPMXTwV7jEGGBUbRSMqKlZ3OwGg0nch6w5z1GqNmjdZ7Ia5
	dbgvMxmeQKCtMLceb1VN7BZvt7AbIaQCvAJIUiwtIVZ6Lk6TsUChYsSfw1yYwWdH
	Xwl+Di6PrUpBl/iP/8TjJDhliblTQSTOIMrZktjl6mDgRNQVCNgIPGbRnwDan9rR
	xmas6CA6Oa94esOVuCKQtiocf9qlRRoIYbixqeGSzdcKjSKd2JNHW8XImuF6TgFO
	jDN9OGDU0LUd8FdxfwKB+F4Pv1znjF9kSmnZSjy3sP5ggCDEPsJNdpy4Kt2Lcjzn
	+tayR64uVjKlMFYTrSM2wmF31bbQCUOKSQQ==
X-ME-Sender: <xms:F-UTapAbJ1LJTJ7tb7SawUQz8xadDHpgY0dqU1CDOofLvJ6ivMFMzQ>
    <xme:F-UTasYPe2hfJJWwxqyRT4Dybesz4gXEPAAncjv8a6B9Df7L0iPxfvWBQUGRtRHcj
    F1JYRrsHWVGsiHfOKVyDIbQ_IcqNmT4_qGQoHhTFEImA0Q>
X-ME-Received: <xmr:F-UTaiKsRaNIadgqAn_Nh9InJLua4ptv2DIh3SWHrIPZbXGIccXHAKiVFHt7tyPNUdELFC_izQIBw1fS7vAjvKJG8g>
X-ME-Proxy-Cause: dmFkZTGPtZCCjSuCRPr1JIE3p+TVwYadB5AqdFRUtwP98N64tVpwXxffihBba5Yy/PxEB6
    81MrKg/GpJfaIXgZv+qS81cEeEOwI5GlH9lSbvAQeSzv2ayEFPCsfjg2aa+3HS2V1JafGx
    XCR69u43szMOgZ+79DlO9QfPZsWoVNhSsVt4oNgwatkYmds6p47N04rIzqfXj1nw0r3WSv
    sCqst2pdStIYGqgDuqMLCWXCW+gvXWTNbPiF2Elk/Byz+wwMUDZn5eHyVC0ygH3U8lI+X2
    erNaB+YTJldcf0NNat3eHA+EZt22vp9DmVIkXwjmhm8BlyUXVXOyX4d2iCThBjp7vhYqAO
    50xP0ODRg0Sjhj5rcic0n5GPtj5Or3I4G5HOCjTRGzblXi7qBzlsK13oNKEYSKAxNhm3EJ
    ITk+Sz41GpFDM03Jr6mfxg3FunRTwfUwRhJwSZxemKF7KHHHoYWF5wdlfKH8IIuoT88mNe
    9BkZF56/abRGRj5Ywb4w6kQvf4fj+b0raMrhwOnaQtREKRf2lwLCdMw5fLD7mOe1zuzmUU
    pkVdrSOPbeIVjQVZNIdjfntpE2z5tnod9JEr+lPLk0c6qic47+aLfV/VTnYB49+U2tNjcV
    9wwm2P0AOj2Zt+cK5KodwjMJ7+TTpD3QZIIOU2ZuCHqKluvzuzXEvB+pxscg
X-ME-Proxy: <xmx:F-UTal2mS1U0WJz8BP2xwOt3SDoSuSh_BgMSkShiHfY4a1UyhKpzUw>
    <xmx:F-UTata8segEeDfOHuXU2_-Nw_AjqzNDYtVZalmBuLhAobg-DCrJcw>
    <xmx:F-UTaoXyxzobEUv-PJO16nHYA4-d_oW3bgshA79aA1Gz8O5mZQiRAw>
    <xmx:F-UTaocAX9zBovQ3cI1AnrvMErnbv3jXVvf3CX3lreWQICLqA9W-dA>
    <xmx:GOUTain2FvzKxgxgC7lQLqjpC-sq2FA1qwFLg3gzLN3ojgb40U-tpJzl>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 01:58:46 -0400 (EDT)
Date: Mon, 25 May 2026 07:57:56 +0200
From: Greg KH <greg@kroah.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: patchwork@huawei.com, kernel@openeuler.org, linhongye@h-partners.com,
	Balbir Singh <balbirs@nvidia.com>, stable@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH OLK-6.6 4/4] iommu/arm-smmu-v3: Fix pgsize_bit for sva
 domains
Message-ID: <2026052547-delusion-entrench-8185@gregkh>
References: <20260525023539.3587618-1-xiaqinxin@huawei.com>
 <20260525023539.3587618-5-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525023539.3587618-5-xiaqinxin@huawei.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254081-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,atomgit.com:url]
X-Rspamd-Queue-Id: 938475C6206
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:35:39AM +0800, Qinxin Xia wrote:
> From: Balbir Singh <balbirs@nvidia.com>
> 
> mainline inclusion
> from mainline-v6.15-rc5
> commit 12f78021973ae422564b234136c702a305932d73
> category: bugfix
> bugzilla: https://atomgit.com/openeuler/kernel/issues/9215
> CVE: NA
> 
> Reference: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12f78021973ae422564b234136c702a305932d73

What is this for?

confused,

greg k-h

