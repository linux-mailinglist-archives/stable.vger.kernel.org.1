Return-Path: <stable+bounces-227772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIVNKHiuvmmEWgMAu9opvQ
	(envelope-from <stable+bounces-227772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:43:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA42E5DC5
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 15:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E2130125EF
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4551D2DF6F6;
	Sat, 21 Mar 2026 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="snbMPCL8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1oKKQP//"
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A452E88BB
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774104105; cv=none; b=r2FHCFTAh25cJrIZ2Bx91XUiNVT9jsfBBNPZN5//GBB+Fjo/YO2+f6KDkzE5i4Vh6X2h6hdHQi7VpFLHRWj7OuJoQLG4kziodJMbm2HtB34rQsyZw1gzbVle60FSxV1/T/GVVGNl0Tc1y9VFxim3GKnYB5aTIDpY+KOrk5xlULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774104105; c=relaxed/simple;
	bh=iiZM9nn75YnDZ9jdNZeZvOd+xgAvVQjuyNGjxWUyglo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWrptmQqy9Nlvhk/c0eRD/efZzRM84VKwhmJtxWQ+clM98eqVqUDbXYVreEAIkLqE/YhjfQ05YD2g1iljQWz2926brj3im4/hNwiaRd3HYUXKNO7JIcX5KAx7h7cl6Qsbql5mMwefbuQ8DbDlNfqOrOKbRV+KXpxgRn710bX2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=snbMPCL8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1oKKQP//; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 06BDE1D00010;
	Sat, 21 Mar 2026 10:41:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 21 Mar 2026 10:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774104101; x=1774190501; bh=nrXblXiegA
	tOQBdvOQbz/uv3Jk5t5WraFHP9dtcADz8=; b=snbMPCL8EFWB10ECVZURKMnsQr
	hhGU25j9EgZiBT76ie+tKHqYyPgeY6jKcShTEWLGW6u7DRaxQyaD7IdTibA6z3eM
	Z09Nck2gaqJHOxP0WOrK2xCESarzuzbiPhIpjA8pDgdlamWVsjRF7otTw+45zKqm
	YXQrZV4oaxdHxqtUYLxi6hUx3tCMtLZdpTAo4jzfu8v0SW2DqqpcqAZtyLRdLADy
	ChIWLzj3Nnm9atWHeox1Sgy7vYjWvWAXDOP70R11VArZYNma66C3yUVOxeH6l6D0
	iCL1OCj3rAScFAN+UduLMgUQm2035WrCVQS2WK+qBHzyEUEplOPlrIPHyS1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774104101; x=1774190501; bh=nrXblXiegAtOQBdvOQbz/uv3Jk5t5WraFHP
	9dtcADz8=; b=1oKKQP//IlyR7Xyu6YdPpqnON6nGkHO9OSbujoQ44OBX3XJex8o
	c/sAsvj4md5Wb/jnvDb5u80FYziQVqlJ9ydPIsLOUjXkNzFQki0/zixTl+kerHUY
	TKsTEsgZgXnzGzVGRnYTlKmg8MD5UyrVuaxDxfkWjg1K2VmspYwUzmXq2MWuSb30
	3LzoHbYrm8ALR22HmGEl9mQe3yXrZ16BRhaAZkTxTNT+Z1XV6K4+8MzTnl9u1zt9
	kG4XShMyyPlwTQYGFn6pbPog2WkM1/E4hzcDqN2FBXwX7XdPJz2GfpvvvXvcRDF4
	Mi0LNhlksoqk/928IOYKAzmGf0t6d6TaGeg==
X-ME-Sender: <xms:Ja6-aeZ6cd0Wp5RL95lQ7cwQIaEczrhrcJDZ_hAFybej5Adj5xIwrQ>
    <xme:Ja6-abYVrXJ_e1erDfkB_FKAKTY4rWMphv6tYoJIWy__AMughJeoOiUsgVI-l5Lbi
    -Kjz6KkTCh83Mky9-pnxUnSZ07LOODLLvF4L9LLDWkDAEje>
X-ME-Received: <xmr:Ja6-aflQOlU5BOjDD6ddtrfClBYIQE6KSU-Yem5LwNgauTN-Aq4bz6j-m0CrZcMcJ71DgNM7_Qdx5GOf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehueehgf
    dtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghssh
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ja6-ae0t2CLlrcyWDpkaiNobpdGZOtRdyORqP6Mciv7FhQoWREmb-A>
    <xmx:Ja6-aX3MjW6MtcR_5Og77nIUI9-BxRStk5GImICCxtGfLP5HTeBXZQ>
    <xmx:Ja6-aYo_CJSwhbHu3d60ng87H670R2QGXWDUfKfLTd94go9gO3xE6Q>
    <xmx:Ja6-abje7ja80Qfh6EaBNX9_uy-QlM-AinQM8Bwv9f8Zjld7K6WmtQ>
    <xmx:Ja6-aTDk4bh4QwYbDcek3wFCMvMAfr3NxtYqUYpAZvOm2yp54SDP8tfD>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 10:41:40 -0400 (EDT)
Date: Sat, 21 Mar 2026 15:39:06 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] ata: libata-scsi: Return residual for
 emulated SCSI commands
Message-ID: <2026032154-malformed-muster-43bb@gregkh>
References: <2026032032-sludge-profanity-a10a@gregkh>
 <20260320215445.132838-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320215445.132838-1-sashal@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227772-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kroah.com:dkim,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 20EA42E5DC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 05:54:44PM -0400, Sasha Levin wrote:
> From: Damien Le Moal <dlemoal@kernel.org>
> 
> [ Upstream commit 5251ae224d8d3caa21b28d12408062b6e75cffad ]
> 
> The function ata_scsi_rbuf_fill() used to fill the reply buffer of
> emulated SCSI commands always copies the ATA reply buffer
> (ata_scsi_rbuf) up to the size of the SCSI command buffer (the transfer
> length for the command), even if the reply is shorter than the SCSI
> command buffer. This leads to issuers of the SCSI command to always get
> a result without any residual (resid is always 0) despite the
> potentially shorter reply for the command.
> 
> Modify all fill actors used by ata_scsi_rbuf_fill() to return the number
> of bytes filled for the reply and 0 in case of error. Using this value,
> add a call to scsi_set_resid() in ata_scsi_rbuf_fill() to set the
> correct residual for the SCSI command when the reply length is shorter
> than the command buffer.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Link: https://lore.kernel.org/r/20241022024537.251905-7-dlemoal@kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Stable-dep-of: e6d7eba23b66 ("ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 81 +++++++++++++++++++++++----------------
>  1 file changed, 47 insertions(+), 34 deletions(-)
> 

BOth of these don't apply :(

