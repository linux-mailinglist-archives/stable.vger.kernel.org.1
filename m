Return-Path: <stable+bounces-233891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHlNMYVQ1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:56:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CA33BC752
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E51304F2FF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616383B8D41;
	Wed,  8 Apr 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="tyVw3OAR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oODNAWMx"
X-Original-To: stable@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46AB3612F6;
	Wed,  8 Apr 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652815; cv=none; b=dOCkk8fSnLtTj0bxtjXNJrn0G+eJRwb3zg44wLpy9+IysU8AFIk4IKmHT9Vc+6xjCzhW6EFg2ih2Mr7pUveJttT7kChzdVHBFmwJlJiKCbYTv/sEXp0QuvWcaoY0IFP9IP2GAgw31kX5ITtWZbpvzLMtFkUWGxwbIKewQCINqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652815; c=relaxed/simple;
	bh=TkOUTrGxS7kZdeUZF7S7eFApD2tQzGqfkbKut5+kaqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4Y938Nyyq2Zvv+3qAzu9RDrLz9fLiPF1Cpkn57fjOcHsGmFbGp7UhnAe74KHmd1jkxxgNoUNaenuCcsQhBZmH+38tkI0wMI9vLAPimhNAMJoUK6TN0pQHWzkBYmU3H4t/R6ckkMhTjH9DPA1s5t93iML9BlhuQBVzLr8ffLBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=tyVw3OAR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oODNAWMx; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C9FCF1D0018F;
	Wed,  8 Apr 2026 08:53:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 08:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775652812; x=1775739212; bh=hM4qnehjj9
	VC+DL6/Kp1nCjKBwSAUtvlNxH2nFZR+U0=; b=tyVw3OARXhWog6PhZaA+3b3wm2
	zszsNWlnpuKrSYC8DaZ6Dekxl2QsDCMZ4gb0bP4ZaZKViTDU/hY9OqyT3t96b+G1
	QvdIQRnEUIJUlGxucEjic1ON5LsrmVcIi3K5/7W7F9kkkVEoY1/xmV2J5IJVYQ24
	wBdNA6zl7umenpx/25xJaWb2taDwx5GMn4d+Es8p5oLoh2MifDQGL7goMVXaHOge
	bDYCsiw82uOAjuarsBONv2GbSlUAClZKErK8fY3b31mvTPyQv9vyv7g/p/NaYQhx
	sncPm0Mf8XgzRRQW/Pe2qtoH3j12oXVu+aKDR17u0+IdnG7DE98RJc1rt8ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775652812; x=1775739212; bh=hM4qnehjj9VC+DL6/Kp1nCjKBwSAUtvlNxH
	2nFZR+U0=; b=oODNAWMxD29RxVoma07GYyb/f1p6+8RCz5ZXx9PP88y4iv48WsQ
	l9E4FfjzMikQQH4oLQVgApypQxjpduUCRXz8ArpibJQPz+9d7kAeYBuPMIq2ln56
	iye1P7WsV41mgqH0iwmVoiJYNfnKhUs+UZfPiy2QfUpHSZ8bRHci6oDyhJWNddcQ
	nDpCUCiKuQKSYSXQg6VEnvathiSsjT1Rgl+KADnYa9/JIw4ACfSOYZL2SAsABd9d
	b4NGJgMTeReQUyurRO/Xwg9AakALxFdkB2lr5VEkT7QXDkMd8g6QY8uGzvNz7lwW
	OBblISrVh6fnGqXlM6xjWalaVr+S2f5mYFg==
X-ME-Sender: <xms:zE_WaeCDLYhfWojfNV_TGp3B5w3TGw8z5kySaVpzYgqaTTWvd9aYCA>
    <xme:zE_WaeeHTC80I7C2IQ5e5Si1XXLYXwki2wpOTtO-CCsq4Q1STxFU12ujbgMy8KEvQ
    xDX0iMPYk3ZWFKT4Glb2TxmioM3Kub3JjSPp4-epEqWuo3qsA>
X-ME-Received: <xmr:zE_WaesGEeb95sRfYwS_26kwnvrfEfFOAMJEFrXWqPLPXP0UX9-bKLTP95EKeM3Co5uZ1-HmKO0BU7SY9ExcvsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhefgtd
    eluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrshgtrghrughosehighgrlhhirg
    drtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsthgrsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgs
    ohgrrhgurdgtohhmpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgthhgvhhgrsgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zE_WadgeBQVu5TLiKkHMn-DFiNhPefV3tOo3vCD6e6wWG3KuLIaIAg>
    <xmx:zE_Waet9ronwt93EY7BU0oEIfXeABpI8v6iRUhpsMokjMaoAMDYnNg>
    <xmx:zE_WaQ-i_rwWtg4zwt5WNhxdzEyKAFhXbomG-jp50DiiyVA0c1HHcA>
    <xmx:zE_WacZtnkMEUmxWVObkLHJDLd3YN88KkZSt78JL5hhVHetPrDR3Fg>
    <xmx:zE_WadsGoU0-sIO8Uxfogx5jI42jK-DNv3Y3Wqz4gsOwjgOTWKJXbkoI>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 08:53:31 -0400 (EDT)
Date: Wed, 8 Apr 2026 14:53:30 +0200
From: Greg KH <greg@kroah.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: Patch "media: uvcvideo: Mark invalid entities with id
 UVC_INVALID_ENTITY_ID" has been added to the 5.15-stable tree
Message-ID: <2026040823-statistic-jarring-4d0c@gregkh>
References: <20260408105235.947173-1-sashal@kernel.org>
 <adY9gSh3LHAL3zj5@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adY9gSh3LHAL3zj5@quatroqueijos.cascardo.eti.br>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233891-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,kroah.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28CA33BC752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:35:29AM -0300, Thadeu Lima de Souza Cascardo wrote:
> On Wed, Apr 08, 2026 at 06:52:35AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID
> > 
> > to the 5.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      media-uvcvideo-mark-invalid-entities-with-id-uvc_inv.patch
> > and it can be found in the queue-5.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> 
> This has not been added to the 6.1 tree yet and there is a missing followup
> fix. This has a chance of regressing a few devices.
> 
> I suggest this is dropped and wait for a proper submission to both 6.1 and
> 5.15 containing the followup fix as well.

Now dropped, thanks.

greg k-h

