Return-Path: <stable+bounces-235348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH1rGptf12kCNAgAu9opvQ
	(envelope-from <stable+bounces-235348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B183C7936
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05BD2300460F
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D314396B6F;
	Thu,  9 Apr 2026 08:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="rBW5BdyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I97j+gXu"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659538C419;
	Thu,  9 Apr 2026 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722388; cv=none; b=kSEnQ4IY2ITzzmzqvN5UqTird3tlq4QfACorFe6uHB6y/L+31yW+InSrumn6Cdv8kZTG0jOSrVphUxWMVMNb8y4Th+Hssk498BuzB/OCSoyEtebaY/2Ha6Ox/E1BvTHdhSMyUsy5sNVn8R1UPJlzt3thoh1Pm1Kvu05XeUCyNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722388; c=relaxed/simple;
	bh=ET+NEjbpOE8DTaHkHgIdC9wA35aU9r8zRj8tf4/u/dE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F2pt8rwt9PLcJq22Z7vML8rU1B8u7X9IcMvM1zemZTQCvAWn77NfkdlVlsv/RwqTyEed5Jt0lPXm5Cgqwgeqx73BMepKwz4uu/aP1w/BTCaX8w0e4ChHe9mTEJRSJukXXcMPPFQRPpL4T4FFsjTr4rkNvBRd7sUGYI82ecjCyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=rBW5BdyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I97j+gXu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7C2A14001C1;
	Thu,  9 Apr 2026 04:13:04 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 04:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775722384;
	 x=1775808784; bh=MiJWI3OaSRq3EklEHaV9bVtb/wtL42WprWIEoJeLvdw=; b=
	rBW5BdySWfRVIwiIGiOL0JiPS1tkmVbvxx7iwymZTiPEIIlup3lLX7GmRNN7bKZs
	y0VfDYXpVhPCzcYH8l42o+vri7GDiXyRVfsM0Eal0Zvq3aMrJ+Enmdqu+PmTAB6e
	xIOFHLiZjGq+GlN1lOf2adjj0lH/OZNWvZcqNeN0PCR5FCjrfrdK/o0h8oC2WiWf
	1ff+2YpErQdc0O88e5wj3d6PzFPU7YYbZ+GmmyRu0wbNArP152SuQU73hJ1uDmUO
	O7afStE2yVOWHTiavLeBQanfw61HJCZDXXflrX4tIxJYCcMzr1Tx+Z2yOUz32xji
	sP550xmyvsVfKla2NG9Rnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775722384; x=
	1775808784; bh=MiJWI3OaSRq3EklEHaV9bVtb/wtL42WprWIEoJeLvdw=; b=I
	97j+gXuQA/eAR1p+/sbnWLQniHd7oSgO9T8uM7oit6e824DhmNq5PdkuKf/kTZu/
	iK6PtTJT0jKMAWaazT+6z0utXwAvRZqZvfAWIxqsGz1YPZKkD3cKA9ez4KbzaxDD
	mhAiY/w6jq1OJsvYmx5LLGegd0cEU7NiECVQAiZ+s/IMQCsHn9yS+5nGxjcKuWrm
	Q+d6VuGd1UewPUnQ0lSDwP+fDUx0nJxN9XYyRYed6amgkXzLEDBTcVMtbgki+Ddp
	4iYf3c3jwmjmtef+9vqFiPnCB8WjDWoqr28DsS9kA0ProNVOESeYwEqz2FZxDM2v
	J1mj5vNbMX96E6hila0jw==
X-ME-Sender: <xms:kF_XaZFi-NTUzCDqE0GBUwgSYnQ5GBpGff4mppL4-5kKMLOGDzJDag>
    <xme:kF_XaZIRi00tlHWQTTZZnksQm7rbo_I_jtXQhcBBkqPBNxnorG3iVDSmujC00twFA
    e70Fqg7KtwvyYEjpipG7_vY4m1heG9fcGn6rx_96jrK6S4K5383Ows>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggr
    rhhrvgdrshhhqeenucggtffrrghtthgvrhhnpeetgeeivdffhfeihedvkeefueekgeeivd
    ekheekjeeuieejiedtffdtjeetvdffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtph
    htthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushes
    tghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuug
    gvsgihthgvrdgtohhmpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhr
    tghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehsrghnuggvvghnsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:kF_XaR33RtkOjfuCDFzbpoTPjcRVC5E2sXErVKL9Jutvnsy3--Aw9g>
    <xmx:kF_Xaaolq2yOoR2SfvHRXItVuEhRnA14iQ2iF3zaTzSgjsAjESco7Q>
    <xmx:kF_XaViai7RVzH22w-JVWvi7XdRmC-VoIS0FSYgsl-4FFioaDHw5Pw>
    <xmx:kF_Xae98yPIaQYSKSdJAlr7tAd77809rTfZ46F8M4nSoicyPH5jp-g>
    <xmx:kF_XaUgGKgbX6HrWTkuZDSyy_I7mmoiIKaywz73OePIycyDf6xZUmkkr>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5C3C5B6006E; Thu,  9 Apr 2026 04:13:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7SXi_NfNDDB
Date: Thu, 09 Apr 2026 10:12:44 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus <asmadeus@codewreck.org>
Cc: "Christian Schoenebeck" <linux_oss@crudebyte.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sandeen@redhat.com
Message-Id: <f0f5bb7b-fcb9-4e63-ba17-4f937681d13c@app.fastmail.com>
In-Reply-To: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
References: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
Subject: Re: [PATCH] 9p: fix access mode flags being ORed instead of replaced
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[barre.sh:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235348-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[barre.sh:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[barre.sh];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre@barre.sh,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,barre.sh:dkim,barre.sh:email,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 39B183C7936
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Friendly ping on this, any thoughts or feedback?

Thanks!

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

