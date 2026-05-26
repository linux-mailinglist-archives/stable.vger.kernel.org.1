Return-Path: <stable+bounces-254247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDlkJOU/FWrJTwcAu9opvQ
	(envelope-from <stable+bounces-254247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:38:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D315D1383
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32BEA30344E9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA03C3798;
	Tue, 26 May 2026 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="a7FFnqWK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a4cqtYVE"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BC382283
	for <stable@vger.kernel.org>; Tue, 26 May 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777457; cv=none; b=C9JA/hqNoqtSKVbQeMa6pTw27sppoV2QcpG+98pmh6tbvivuiEiH0HhQXLKNd1mNoXjTHWqIRDS/baHUAi5OwVAQ476JvQwKTL/CSSTZHB8buWmZZ78jZ/yx7OCEMpbJ5zUVy0utYyNnuXozfnJ6q0pr4XftvC71C90xYumt88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777457; c=relaxed/simple;
	bh=ibxeCrDPuBde02kpTCoMG0zhwiyTz/A6GQgWkqUPPAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dliRCzUK1wbldG8sd0PC7TDuBmJJ1EDnD24KP074bjCTCY0ZS+tW5TZKq26+Pzk9UCa3crW7K4vVKDOPUadW/sBOqti9AiLjt7G5/JMzzb7pxHGbk5brmcInvPL0QOgwGr/nQRTQusDPZzcXvzrBYWeawuoX4Plq585il/ygdeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=a7FFnqWK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a4cqtYVE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A9FD140008B;
	Tue, 26 May 2026 02:37:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 26 May 2026 02:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779777455; x=1779863855; bh=ibxeCrDPuB
	de02kpTCoMG0zhwiyTz/A6GQgWkqUPPAo=; b=a7FFnqWKZttHy1z0yKCrN8kum0
	Z6bG1awgKcEHqmJNJOCVRmLBY8b6H2DeTGY2sfo9xmEyKkbtrQMkcQG3N4Z+4oTl
	ZjOoSJIEjCeyzzUlxNKo/oNILIGBX2eCPBBQkqXGtVFCGMPVd1qCuQ0GGL3jEkrF
	Uver2+jGBncMnuGnE+a+YTLLSLTgZkwZcq2tEDK1XJ6yx2QKjBMI2a8pQx/i1IWv
	281dkroQUCltouFD2510B41R6/+6k2B7dgAzTMWggyvduyB+/OGbUz35Evx57WE0
	G7qfiryxSYZ+Oeg9F2fphKBP0blGDsZi5nWD28kagcecjRgRzeaHoSj9e+Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779777455; x=1779863855; bh=ibxeCrDPuBde02kpTCoMG0zhwiyTz/A6GQg
	WkqUPPAo=; b=a4cqtYVE8OeNeKXIv+IAhGIIJRqcYTcD5CAyK+loewY9XSHu6P1
	kpMHjQHXudoDBuSPRK68vHPHkeLnU2kffITbRql0igRxD4eFc3GOzSnmRZ9pyri+
	zI4mpG5hv9bq6gxi+fqQ9wZIgXDs4jr9kdQs4IeymbqoQHWgpWDykUySd3TovKtp
	t5dfTxkB7rn/KJpp3FmiGpn9uCp35GYqaZE0sgw1Wz9D3zmT1MOV2BVGHSGdRxKL
	IZ+7L/aYnNgxmByVqzhufA5rS6Q6rvPooVchvwneJMPgv1dH9FEJYnHq0X558JGN
	iv21DIipp4O7hO0hJ6M7DAhA8UVh0VbTtUw==
X-ME-Sender: <xms:rz8VajosGEfp2lLmBq1bEr_I8ntFXAZLUZrbO6mdH8c2k88TMJjWOw>
    <xme:rz8Vam9gbPK7Rgs6M06Eo7hdsFsMQmablzdPsoHuXo_Ip11mpVmfiKsll1wu8Ed10
    XqAOCgLKLYppmEqy4TEu71ls9o-8brqrUWp1ZBkChei_IXqJQ>
X-ME-Received: <xmr:rz8VaneYkiVSdvkgeYYLooGAPVD3QXj3qA_POYOrn5QMpgFQP--05-U2syOUEmOuGhFpnkrvZEibc11UOlw>
X-ME-Proxy-Cause: dmFkZTEuVOgIKI0NgrD/Sxi/0XCk40tGmFd2sAsGlmMBrichEHXo5QRsFoijmIsbbwnGTW
    hFoDXlJfjuzssJMdAc4Zp4/dDoX73I08DkliKe0H5aUvJYnGNSsamA9/g64U1pi7r4KGk/
    fwz5jla5NitJdgNcjSscVNVAsHCq0iG8tHBitEGp/MVJrTsUwGSyWIzdLH3PQUBpLcmBoj
    DQ8tzcpFmAxGGsdtKi1q/oUhRZYm8/as4m3aJxXsCZsjsiPnAyGVhMsmE+H8XdrK66dqd7
    E9Le8i77jKQIY/1mMBw0pXQbzRrsCSg+I2Xf8cbNeycmKhCzW972aWlGwP5Q44HdR1TJBe
    Se6a/3MTXKfmHm25iffa5O9oDekh/FHsQnYx1n/2UQejDqTBgGxCYZlbZeyh9ML0BnT56o
    xotzFzHGv/m4h7DMNx5NHTjgGn/hWiefSnZ6mn7waNhlPpNfiaVr+8HPQw/SNWV9U4+B3a
    Qxr6MaGSu71RCD2GxUtFyKAvASwe5l/Jua5TlkTgJfoTqwFkWl9osC7z0ISXrwrBthxaQq
    QsoN+VGNCSAGJjX6zFw/tTGkhhimLrcrvtonTzFQhH1zw7YzGGjqPnU7AyGAAbr6YHIypp
    5xwTqjah2uMlbfUH0foB6GKZggTM7ZzoCn8VoffQpcH/2KYnRACGHCcQQETQ
X-ME-Proxy: <xmx:rz8VaoLzSQNYaA6sLN77s6juIfNZ2DaEpBpsRdpIdgsKGi1JGmmOBw>
    <xmx:rz8VavjwIx3TZO4gzxdxDHJkpdVv0P6OTCWFm3Snv6sqXAFwAmcHXA>
    <xmx:rz8VauRtOuY16u6KTP5IFv60pLTQaUkdw_9TVQbEUUy730KARVEGKA>
    <xmx:rz8VahV-D3drPCoCGFymolp1R2MGY5iotg8aazTsXdRT7fBTP-phtw>
    <xmx:rz8Vas1jg1qBP49w99sD9_gaytWqCRJnQQwhjuswL03OZe9A6-qUZP2E>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 02:37:34 -0400 (EDT)
Date: Tue, 26 May 2026 08:36:36 +0200
From: Greg KH <greg@kroah.com>
To: IM <grayhat@foxmail.com>
Cc: security <security@kernel.org>, stable <stable@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1NFQ1VSSVRZ?= =?utf-8?Q?=5D?= userfaultfd
 ioctl bypass and ksmbd FSCTL permission bypass
Message-ID: <2026052641-flinch-diary-c5ad@gregkh>
References: <tencent_DEF21A96480ED4822654DC73A74623394C09@qq.com>
 <tencent_AE575EFF92D5814710A0CA476EDFA82E0706@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AE575EFF92D5814710A0CA476EDFA82E0706@qq.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254247-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kroah.com:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 80D315D1383
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 08:40:11AM +0800, IM wrote:
> I accidentally sent my previous email to this list by mistake. It wasn't meant to be public.
> Could you please help remove it from the archives (like lore.kernel.org)?

Sorry, but that is not how public mailing lists work, once sent, the
information is public, for obvious reasons.

Again, please submit working patches for these issues to the normal
subsystem mailing lists so that the issues, if they are real, can be
fixed.

thanks,

greg k-h

