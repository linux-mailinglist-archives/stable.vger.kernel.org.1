Return-Path: <stable+bounces-247245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K9KFPP6BWrFdwIAu9opvQ
	(envelope-from <stable+bounces-247245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:40:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EA544D50
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5B9230607FD
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBFE34404F;
	Thu, 14 May 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="d7lnJk2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qqu3YbnI"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB60433F5B2
	for <stable@vger.kernel.org>; Thu, 14 May 2026 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776759; cv=none; b=gSyfw+fAPMJnoRql3zs79B/3popi0Et+VWARwJGmz8bN9xTYEq/QjemA2TUcqWsNVkZG4Jg1UGk9RtBDcN0dHJALwIcXd/tRyKkwfKx7JL+/Jxv2zLBaEXboHMXj/rXA/YCoxKtQC0Rzpz8eQDjfHIdRvMawJAzcLKG/osNqdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776759; c=relaxed/simple;
	bh=INrt8s0CKGfj6W3gPHpH95fX3oPT2o5rfO1VhlwmEno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKVdoV+4N7DljT43VTE/zYhTtJbyoGzG96e6saQfrjG/OGzze9C/niIlZtY4OGsKMtCRiubn3y6KvKt4vCNH0t3dDmmi6AwIh6iP8RM69nq7cBSHm3Jkcry6MLN7q4noU7zU5YcImUKu9uuILELRrA4cYp0OPkeSscDLFFFcLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=d7lnJk2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qqu3YbnI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 220181400149;
	Thu, 14 May 2026 12:39:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 14 May 2026 12:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778776757;
	 x=1778863157; bh=/B2VOMd8WUDO1qjGjs9XvPJ8pfWrh1Z7mrnbexpzPcc=; b=
	d7lnJk2QalIYN7p76eMNJ18gr4bydm/R2MQucXTCYIYjd+9NroAIN3X1g/v/Qhqh
	uP/qC+8U+errCWem1WlOIqlE0dXOlbg7s6O1tOtQj57hdVK6ZwazptDfWs/LyosF
	ccriVOkI+fz/LBAB48Y16b1Vv+GWEOf5qcSOTHiAzPnzxmkw5aCurZILtZ5CXCy9
	5KGcdW3tsUtoEETIkhzqF7sOLZ6Nylz2cibuIpT6fS0Au3RzO7ccr/PBeGbR0Hbo
	dDPF3Pd/59rieS9FmX/FaOh2t959zXyyU4sOwBIraMS7cGXyGsFG38K7R7nwJyUY
	cecw5PAc/uSEjdsV31RGgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778776757; x=
	1778863157; bh=/B2VOMd8WUDO1qjGjs9XvPJ8pfWrh1Z7mrnbexpzPcc=; b=Q
	qu3YbnIadvN9ZBmT2ro6qC/4HpbQUZnP5XaLyWH76y2tq+EWpQnbprlci9scwSt2
	cWD2vdmUAQY6qVCHKDpdwjnC7qpNi8gpxYW0pjTYJupG0DA5piwvSqm5SRXqN0Wd
	S060EQSC0XwbqJEzuaUOinHWXrkqFLipcd2O8bABgMBXopdEM9Cx8HUgG5lzoHBS
	hcwefr7uOHgRmuTXqWeblLN7NBMAWbMy3xUFR/yLOxgfQffm3/s7knoH5NN5Sn67
	JsxMfYM3bMG4/rbNiW3R8zij5Q7Aqx0B4pJTgEuqUZgDqSNZ0jip0ZEJlPWAK+jL
	IAs7IZyLdX9EVViilnwZg==
X-ME-Sender: <xms:tPoFajECME_VKvSLfR7QWAu_xoAzWzum41mV-ntijq8YDW-l-35izg>
    <xme:tPoFaul6Db9PTjuUnVCogdyhsJ0hL1mcAIRkv9PjrCsqMHCChH8li72I9vnKe0NQS
    KdlJUFdNbFvRSAtkw6bUbbC7WyVlTn8hWM8-11OiAwcPVaL0OST8w>
X-ME-Received: <xmr:tPoFaufuRMlo2oYrWyFUArsbygdjQeJcTHwSbk_oDsTpTC1MrlfupSfecp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdektddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpeetuefgleefhfdvueegffdtffevhfffgfffiedutdetgffhheejtdekfeek
    ieehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhrtghpthhtohepkhhvmhesvhhkghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdifihhllhhirghmshhonhesnhhvih
    guihgrrdgtohhmpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkvghvihhnrdhtihgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopegthhhrih
    hsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopegtlhhophgviies
    shhushgvrdguvgdprhgtphhtthhopehmrghtthgvvhesmhgvthgrrdgtohhmpdhrtghpth
    htohepjhhgghesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:tPoFakEV1ibzC5gVZ4q-DF-Ln8TbDE0q76n8lplOMEIuL3sfwiWP6A>
    <xmx:tPoFasiN9qXn2cLCFxhktIDmjL0S0709z90EwTHr-ov9rqEsNTfSbg>
    <xmx:tPoFag157Q6x_zma1Y8X5qyewEEoAR_GoFpCI-fkQr8Lx77kG2hwJA>
    <xmx:tPoFavdxK1xaZaKvGydxyBcfS6Lx81pW0hTi77VNOmK4Q1Pzq9yzUA>
    <xmx:tfoFarDi1bYlPtrvjA4DCdPhRmtDR8ISHIvqnlwp7VlKYq06Tr9lCZDd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 12:39:15 -0400 (EDT)
Date: Thu, 14 May 2026 10:38:14 -0600
From: Alex Williamson <alex@shazbot.org>
To: alex@shazbot.org, kvm@vkger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Carlos =?UTF-8?B?TMOz?=
 =?UTF-8?B?cGV6?= <clopez@suse.de>, Matt Evans <mattev@meta.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Joonas =?UTF-8?B?S3lsbcOkbMOk?=
 <joonas.kylmala@netum.fi>, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: fix dma-buf kref underflow after revoke
Message-ID: <20260514103814.4da538b5@shazbot.org>
In-Reply-To: <20260507143548.1018405-1-alex.williamson@nvidia.com>
References: <20260507143548.1018405-1-alex.williamson@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9D4EA544D50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247245-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:mid,shazbot.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,messagingengine.com:dkim,netum.fi:email]
X-Rspamd-Action: no action

On Thu,  7 May 2026 08:35:46 -0600
Alex Williamson <alex.williamson@nvidia.com> wrote:

> vfio_pci_dma_buf_move(revoked=3Dtrue) and vfio_pci_dma_buf_cleanup()
> ran the same drain sequence: set priv->revoked, invalidate mappings,
> wait for fences, drop the registered kref, wait for completion.
> When the VFIO device fd was closed after PCI_COMMAND_MEMORY had been
> cleared, both ran in turn -- the second kref_put underflowed and the
> subsequent wait_for_completion() blocked on a completion that the
> first run had already consumed:
>=20
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
>   Call Trace:
>    vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]
>    vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]
>    vfio_df_close+0x4c/0x80 [vfio]
>    vfio_df_group_close+0x36/0x80 [vfio]
>    vfio_device_fops_release+0x21/0x40 [vfio]
>    __fput+0xe6/0x2b0
>    __x64_sys_close+0x3d/0x80
>=20
> Collapse the duplication: vfio_pci_dma_buf_cleanup() now delegates
> the drain to vfio_pci_dma_buf_move(true), which is idempotent for
> already-revoked dma-bufs.  cleanup retains only list removal and
> the device registration drop; the dma_resv_lock that bracketed
> those is dropped along with the in-line drain that required it,
> memory_lock continues to protect them.
>=20
> Re-arm the kref and the completion at the end of move()'s revoke
> branch so post-revoke state matches post-creation (kref =3D=3D 1,
> completion ready).  This keeps cleanup's call into move() a no-op
> when revoke already ran, and replaces the explicit kref_init() that
> the un-revoke branch used to perform for the un-revoke -> remap
> path.
>=20
> Fixes: 1a8a5227f229 ("vfio: Wait for dma-buf invalidation to complete")
> Reported-by: Joonas Kylm=C3=A4l=C3=A4 <joonas.kylmala@netum.fi>
> Closes: https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB3=
72@GVXPR02MB12019.eurprd02.prod.outlook.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Reviewed-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> ---
>=20
> Multiple fixes were proposed[1][2][3] to resolve this issue, thank you
> all!  This is the solution the Leon supported, therefore I'm posting it
> on its own for a clean reference and visibility.  I'll intend to push
> this for v7.1-rc.
>=20
> [1]https://lore.kernel.org/all/20260416131815.2729131-2-mattev@meta.com
> [2]https://lore.kernel.org/all/20260429182736.409323-2-clopez@suse.de/
> [3]https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/
>=20
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 36 +++++++++++++++---------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Applied to vfio for-linus branch for v7.1-rc.  Thanks,

Alex

