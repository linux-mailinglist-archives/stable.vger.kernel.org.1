Return-Path: <stable+bounces-232969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKx0DFxBzmlQmQYAu9opvQ
	(envelope-from <stable+bounces-232969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:13:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8CD38789F
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C5D730AA1A1
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB83DD50B;
	Thu,  2 Apr 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="h6YBBQXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOf7cWci"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B69339658D;
	Thu,  2 Apr 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124631; cv=none; b=ULYb+PPiMxlbrB4X5wQjU6hMxSSTH3Q63QmvgMuoHjJB7fvruM7tASu9zLH59eLtUXTb9+vYMD4Dv/wLuONMv071H4gfCYqx49vGqOcmjZ9CT7YCwhYLo8BPMgEGVKeGF0Q5WrwwiZ9tjJbJBb7k2tDc8zMjjHvGDR48fXmv4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124631; c=relaxed/simple;
	bh=xVmuycfLwNQ3omqbTqjnro+8/vcCy2B12kgtgX0L4NA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=S0DCDyu5WwrO0tSQjN3hzV0lz8Kt56jYLmaTOOJMxg6xCY4uKLkm87zIR2E0lka208msbIufj5lZHO0Bbj4Z/qoHOnaEsiPB0ECESAmtl5wpoTP1THyYWtLmQXB0yZx1dY8GCSTr6NlNeCaNOUEZeOAt+0tvvendKy0SfAMiIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=h6YBBQXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOf7cWci; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5997E1400263;
	Thu,  2 Apr 2026 06:10:29 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 06:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775124629;
	 x=1775211029; bh=rwb3s0na1s2ywJgMpNsKHLX3L30KxLLtCh5OfR6KMk4=; b=
	h6YBBQXBTTDAS9ApX8flPbZrtidNKscqpwngIOaMvE5TgU9iwA0D7eQFZfq5jb98
	qRTuopiVXWNtIWrRFEikiFmqWm9Yh/glq6O0RGQOIkkHxI++jpwIMPXUYJvRaOiZ
	AmMyOaKCfafYWELV28paM5A+cqpHKJfhX6bvPiysbCCTh0AMaELmBoHEQPDE7SIC
	fjVlJgbC/mVJZpmNvbt/3jJSQDvmy47WtYvnmpiiNa6sCGcu3ecOwmQgPgAghaB7
	28KfpUA4tpRvN2CcyKg3rHfkSi/Eaah55eL/YHx1eVX7+HMyySGQ+57c4EVVHrml
	RzUAABGsMjI8Rs7meTVW9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775124629; x=
	1775211029; bh=rwb3s0na1s2ywJgMpNsKHLX3L30KxLLtCh5OfR6KMk4=; b=Z
	Of7cWciTKnisiIO3L+jHbMY2KJlkhQF5BSnX3VN/WDwltcZqtctjUpCkLqhb0YJC
	wOabT3VE3Ovw9CkvaVgKlDkHxx51J64RRagiGjVY44KAGVZ8rbDsVwhVXUNaqglK
	l9zl3HlYgi142ttsnjeyOJyAgvGsch73PtGf0MrNTn4dGlc33biZARaSGo7NXXu+
	oPqyMI4jewTZHwhTiei5smFWZIJByzGnKxRZYP4Yz8DPaSHixuevjMcgIgBiB/sf
	7hQAojeAHGudiL5oF+4OHezUECvOqaqRhbpIN9qoyX9TOtjpmCaioHG1pjGP7Y/y
	p5nHCjQsIRYQ0T9obZ7zg==
X-ME-Sender: <xms:lEDOadoQhealPPHbGXOcPE9Ex1L_kuVxIcbIKqiJaEX1-CEABZDnOQ>
    <xme:lEDOaafcUiSkr6V3Ys9VgDyYuwqkPQsRP-Mr3My6NRXflJTpw8QFEv3U9CZoHCoe-
    QnJUYa0wGlspplArdR2Zjqs15SjLuqL7Vk21G4mTWrS6TUgbBFGpaVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfrihgvrhhrvgcuuegrrhhrvgdfuceophhivghrrhgvsegsrghr
    rhgvrdhshheqnecuggftrfgrthhtvghrnhepteegiedvfffhieehvdekfeeukeegiedvke
    ehkeejueeijeeitdfftdejtedvffejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghrtghpth
    htohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghsmhgruggvuhhssegt
    ohguvgifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvg
    gshihtvgdrtghomhdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgt
    phhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhelfhhsse
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshgrnhguvggvnhesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:lEDOaUa6wZf2WeS_a0R5R6WZD5D2xefUEn6Trb-fw0SxHCw8PXTF4g>
    <xmx:lEDOaR8UE0oama8_Rf-zd4FfeyCYrWaRdbCPTdy0PT-IvtAGbwLY5w>
    <xmx:lEDOaSlA5aOLBriLI3U-TOlzelbi_w7HzvV8R9k1lYGPw615VdoDjw>
    <xmx:lEDOaezcmYHdRWNRdUSSPncSsrcXSatshlbd5U98uOK3OfOcGGbKZA>
    <xmx:lUDOaa0nGR1eoSSmzH3xnI2cZe_t0F4Cuw-c-oPoZC9P6o4xzXKcPwc5>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B0555B6006E; Thu,  2 Apr 2026 06:10:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7SXi_NfNDDB
Date: Thu, 02 Apr 2026 12:10:08 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus <asmadeus@codewreck.org>
Cc: "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sandeen@redhat.com
Message-Id: <e1802c64-3193-41de-ada6-625bee8fe8fb@app.fastmail.com>
In-Reply-To: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
References: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
Subject: Re: [PATCH] 9p: fix access mode flags being ORed instead of replaced
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[barre.sh:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232969-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[barre.sh:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[barre.sh];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre@barre.sh,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,barre.sh:dkim,barre.sh:email]
X-Rspamd-Queue-Id: AF8CD38789F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To reproduce: mount a 9P2000.L filesystem with access=user on kernel 6.19+:

# mount -t 9p -o trans=tcp,port=5564,version=9p2000.L,access=user 127.0.0.1 /mnt/9p

Then as root:

  touch /mnt/9p/test
  chown root:root /mnt/9p/test
  
# chown: changing ownership of '/mnt/9p/test': Operation not permitted

Tracing the server side confirms the attach arrives with uid=65534 (nobody) instead of 0 (root).

On Thu, Apr 2, 2026, at 12:03, Pierre Barre wrote:
> Since commit 1f3e4142c0eb ("9p: convert to the new mount API"),
> v9fs_apply_options() applies parsed mount flags with |= onto flags
> already set by v9fs_session_init(). For 9P2000.L, session_init sets
> V9FS_ACCESS_CLIENT as the default, so when the user mounts with
> "access=user", both bits end up set. Access mode checks compare
> against exact values, so having both bits set matches neither mode.
>
> This causes v9fs_fid_lookup() to fall through to the default switch
> case, using INVALID_UID (nobody/65534) instead of current_fsuid()
> for all fid lookups. Root is then unable to chown or perform other
> privileged operations.
>
> Fix by clearing the access mask before applying the user's choice.
>
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Signed-off-by: Pierre Barre <pierre@barre.sh>
> ---
>  fs/9p/v9fs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 057487efaaeb..05a5e1c4df35 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -413,7 +413,11 @@ static void v9fs_apply_options(struct 
> v9fs_session_info *v9ses,
>         /*
>          * Note that we must |= flags here as session_init already
>          * set basic flags. This adds in flags from parsed options.
> +        * Access flags are mutually exclusive, so clear any access
> +        * bits set by session_init before applying the user's choice.
>          */
> +       if (ctx->session_opts.flags & V9FS_ACCESS_MASK)
> +               v9ses->flags &= ~V9FS_ACCESS_MASK;
>         v9ses->flags |= ctx->session_opts.flags;
>  #ifdef CONFIG_9P_FSCACHE
>         v9ses->cachetag = ctx->session_opts.cachetag;
> --
> 2.51.0

