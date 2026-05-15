Return-Path: <stable+bounces-247630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAhpB7XpBmpKowIAu9opvQ
	(envelope-from <stable+bounces-247630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:39:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A554C94D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EAB630FEFFC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DD43CEE4;
	Fri, 15 May 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cPamcTzp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a76gKWAL"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA543C051;
	Fri, 15 May 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836982; cv=none; b=mz49hZb+pJisf8HEiI3GY7oRrPC0Z1YQwzk60Np9KfLTKfDJc9YkUGYTUMiII5bsu3zzFMfcuJ6YyKu8eQMCHAkfT/ehqY6vWFLVSLztTKuZgtE2uT+j3KfjdNK/V/ubRV6lH6dr4Mi/VzwdBYB+yKUFFqsX9pzmSASqJTBUnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836982; c=relaxed/simple;
	bh=2RawwmkVBXDwBk1ISsvfjcJewyE1qgHJGFnhYrJ5dzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeapMqHXwb1RT+evCmGAs4I9rblA8ZBG4HHNtNsztG18SVAUDfiHYaVUrTN6iXvrsY6gbk6H0uxZqEyiMJsQ+K3SWhIyV/INqg2L4DYCpJOQ6BdpfUZHxhKPxMgWj6IbHThSpmn9VhNVKdxUtj1XEdWLkpwYu3TL0y73eIEIJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cPamcTzp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a76gKWAL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 99BEAEC0174;
	Fri, 15 May 2026 05:22:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 15 May 2026 05:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778836977; x=1778923377; bh=q96tmKAn+e
	bcJPtQWPTeFfc3MZ0hJxJazaZMbMSIg4U=; b=cPamcTzph60rCmRg1gGzUdEehg
	bWTgQdOgiNzQpwrQ7laObJij13+vfBqhN5uT+Bj6x07D3Yttf7hlYnm6zzBh/MCc
	i5xswumWg95MYtA82I5fZNeR737QuVKwRahS5YSytlFn9AfTj6A3UghCWlQ/cTuj
	9+L9YsOKmuKohBHx9RCTzsmKpPdtHDf9h+tZc+7xi/6mzQQFJwg3Ncaz0NxKe0Oj
	0GjkMgaimiYzbUZ8WxolxteZ6FpCSNjVI8pC7c0G56vBR2E+0xrJLU0zzJbe+dH6
	acv/bFF9thlI8BRoW7hk8ZHsX0oz3bKfuQG5zx9GbwkNf/lDjMC6A5fnjgdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778836977; x=1778923377; bh=q96tmKAn+ebcJPtQWPTeFfc3MZ0hJxJazaZ
	MbMSIg4U=; b=a76gKWALpkdauPoNet+pvvxSWD1jkvVEPd1YXmQxLDFdmPGlIZo
	FELJ57nBIGxMull08N33C4X91aXizZlHIB2sJ9pwslIn1ym3erEhCCddjKdEfNiE
	oFPBzFscoLehwfrQfaVNT4hb2Cqb7wERVyxP/vW9tgW5ZX23reXWiM5QJb8JuK5O
	yt/qkafqCAfT8CLD18GPcphBHP80aeW2Q/9ATtnH3pcK/xAjZDu43cZxqDi5/zjN
	xFJ1wxDIxpb8PIQjxg6vlqE999ue6YjEz+FlDXBSFdqrXRPNwyFrGt7DhTCjoGXJ
	ExBDkJu64KJVeuPQjSGfdKT58f3NaI2ee9A==
X-ME-Sender: <xms:8eUGap-ePxLbraJpxg_B-MRdxlYdPULF20eR4lfLs-EArg8Y0wE-0w>
    <xme:8eUGailXfgzExjfD9P_50-uBpgY1xsrV5Boi_FJjni65YGOGzu-c-JcKQ-YDv0PHi
    q9DLsE3DCw1FO28Yse4LhJ11O5y2nK4WOc2y-0G6SVfKbmD>
X-ME-Received: <xmr:8eUGakkDEhQVMSv2z4M0azJByqeEyZxjx43nGU6kP6-TjUC7RiMDrvSRjZDUfJUv5YKHZ22Y1xyu7qIeKwS8i3H5kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhoohhnfihonhhkrghnghesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrsh
    hhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjrghsshhishhinhhghhgsrhgrrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsuhguvggvphdrhhholhhlrgesrghrmhdrtghomhdp
    rhgtphhtthhopehthhhivghrrhihrdhrvgguihhnghesghhmrghilhdrtghomhdprhgtph
    htthhopehjohhnrghthhgrnhhhsehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8eUGavjLjRxboZzCjs_70phyWBq1aKL4lYsaEW62gtgVAwV0MaWy8w>
    <xmx:8eUGatUBiUITBvyXES_fPRRxb3FHnc5fNwa08dCx9cMUkrbw5XSyDg>
    <xmx:8eUGahhtgaCVgs2HQ2M3R-yzqmk5qdql2Wbrcst6iawhMWGr-3DOrA>
    <xmx:8eUGah5D_EnlWnUyNq4Cf9IWraFg3aBEaiypGWXjcSci784aC6Za5Q>
    <xmx:8eUGapVYJ_kcUOvtzzWx0PLS49evdgqncvs8ioSG3ho-tT4y3H8K2el5>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 05:22:56 -0400 (EDT)
Date: Fri, 15 May 2026 11:23:02 +0200
From: Greg KH <greg@kroah.com>
To: Joonwon Kang <joonwonkang@google.com>
Cc: sashal@kernel.org, stable@vger.kernel.org, jassisinghbrar@gmail.com,
	sudeep.holla@arm.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org,
	dianders@chromium.org
Subject: Re: [PATCH v2 v6.18.y] mailbox: Fix NULL message support in
 mbox_send_message()
Message-ID: <2026051523-mud-darling-2bc6@gregkh>
References: <20260510055810.796976-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510055810.796976-1-joonwonkang@google.com>
X-Rspamd-Queue-Id: 874A554C94D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,arm.com,nvidia.com,chromium.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-247630-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 05:58:10AM +0000, Joonwon Kang wrote:
> From: Jassi Brar <jassisinghbrar@gmail.com>
> 
> commit c58e9456e30c ("mailbox: Fix NULL message support in mbox_send_message()") upstream.

What about 7.0?  We need that one too, right?

Please submit patches for all relevant branches.

Now dropping these backports from our review queues, please resend them
all.

thanks,

greg k-h

