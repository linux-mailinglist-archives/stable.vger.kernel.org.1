Return-Path: <stable+bounces-233570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBALAPbq1GlPywcAu9opvQ
	(envelope-from <stable+bounces-233570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:31:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A73ADB8B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6837E3034C8B
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050223AE6FC;
	Tue,  7 Apr 2026 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Ox8/IkIN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ahokdZI2"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0883AE198;
	Tue,  7 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561415; cv=none; b=TkbImTulXmPHg2NAylZq7+OLchW4NSDszy4LIyAZndGSUNMdsfJ+Pa17L5lmmbsyXbDZeIBtHKhFeI6gRv/8Bjm7iTjkXBbb4zeHqvcBee1UoksxiatqemOMKak7gxKo202S4gq96rC9micOkVHQ8/eLwy1N19zbO6Y6GLQ+lGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561415; c=relaxed/simple;
	bh=zmKtGXvPPmowdh2mtbprU/pHgivD6gdZlQXXU41pyVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMQVJ8Z8dEZhnPD1B4sVHTyVDg05dhcpivdTs5/iAfH23w/JZ+9Da80sQRYrVjeX3diuqzlS90YLPaaWc780Rp/ksy3QezzGOApKCvIS5e7WAmcb7QdwfcAH8ePCyl2f9SCclPq9aUZ6o2vWgf0U1C+r1HIjS6/csUvGdm1PocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Ox8/IkIN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ahokdZI2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1DC57EC046B;
	Tue,  7 Apr 2026 07:30:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 07 Apr 2026 07:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775561411; x=
	1775647811; bh=gFXawp+CjNeAOKeG8AkV4oa72KSKeiCRRlIhnESJsY0=; b=O
	x8/IkINDomUK2DdnDZv92Tqe2fyR/rCFVna1Q+pd/gld0p0ocPRPSeTyB7Abtaa+
	+bZy6aVd14++osb9OYg6DwAJ1BjYXaKfFGmth6oijf6fIe8vgCNGPCW1CcitqPj8
	xd3WoLtj3unpMEFJ7v7Sb8tKiP+0HUOefr88+6zIPikE8HLGt70bXBIuz+l0jFm7
	u/re0vUqamR4hN4rHnpMNQ00KRCz5Z5RwXk3f/u+5jHedWzDbYm+RNF2ozHUcKMW
	7q+as5YP32gniEjkpEeI9GwKVEZQAFntw9bodgApidhT70O44YxNwakDLfoC+Tza
	v3RK13TkikHj4qmZVidsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775561411; x=1775647811; bh=gFXawp+CjNeAOKeG8AkV4oa72KSKeiCRRlI
	hnESJsY0=; b=ahokdZI2Twg3hSVUcTqIL37CfkP/XEzvyAjSPJEj8u3zr4USwqR
	enqP94rddA1T/bwy4hAzojq/M+2BJM11tP2Q6MXrRGdEm7VsF0tsRbFrcxKPresd
	CQvc8W2moY3tmoZxZIg/tbZD/vcwf29QFCc21RP3x482WDD3bUZQXcNZe76EOtD0
	WHiLpzGXt9XjUyLiyRWhmusTSFAgx9GpaXRmCUW7C6N2/XYALYzA6GW09Wyulcvh
	8BG/0HT512muWwRxNf+POIsjXasqnRJEMHpMqAD85/13ns8bjNMoVqgmKloztHOO
	KdfIYZPh9Bz26djbF7UgmdM6DUotFSBgTgQ==
X-ME-Sender: <xms:wurUaZn7dNQSk1_hbtq-SFY57811q7oeiBa5A4TDnVSgxQnsGXv6Ig>
    <xme:wurUaZxLczwv7v5tKM_aqYAOU5v9blze_hlMsN6_h4uXOq_4Ln8CMWshn9xBFe5Nj
    _v_SC1odU6Ghhrlg99JB56Eqc_KNJ7hw6H1FIvKysH2wpXbojZcsvM>
X-ME-Received: <xmr:wurUaT6JVdBzoDBc1qv8NTwgJsxBOgu4MiZp8LNLZ6w1yWlHwGwMOxGyfzAb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhguhhgrnhesshhtrghrlhgrsghsrdhsgh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehinhhf
    ohesshhtrghrlhgrsghsrdhsghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wurUaZXZguiCPhMPyfzR8Msu3om59RqM2TdPzzxbtKJ7aQSHVLG5fQ>
    <xmx:wurUabJ-lSOPRtSCwcBZ53g5pAYhXFeePv6xtYfQN2duKEFvjESXOQ>
    <xmx:wurUabvEXhbZftfpE0IRDTsigQK2Jdu6_uKvq8BrBzaQ5aQrgBbiSA>
    <xmx:wurUaYL-I6VIcBcnmEyd510PcNpLSnty0OQpAmfV83XrRKRj1I0gpA>
    <xmx:w-rUaXdw7I-wBLgB6prGxjjYuvQ2CyZQ1i07yBpNJ57AL7-4Or-2Mzct>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 07:30:09 -0400 (EDT)
Date: Tue, 7 Apr 2026 13:30:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, john.fastabend@gmail.com,
	info@starlabs.sg, stable@vger.kernel.org
Subject: Re: [PATCH] net/tls: fix use-after-free in -EBUSY error path of
 tls_do_encryption
Message-ID: <adTqwMD_GBUjZnkw@krikkit>
References: <20260403013617.2838875-1-ramdhan@starlabs.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403013617.2838875-1-ramdhan@starlabs.sg>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233570-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,gmail.com,starlabs.sg];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,queasysnail.net:email,messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starlabs.sg:email]
X-Rspamd-Queue-Id: 6B5A73ADB8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-03, 09:36:17 +0800, Muhammad Alifa Ramdhan wrote:
> The -EBUSY handling in tls_do_encryption(), introduced by commit
> 859054147318 ("net: tls: handle backlogging of crypto requests"), has
> a use-after-free due to double cleanup of encrypt_pending and the
> scatterlist entry.
> 
> When crypto_aead_encrypt() returns -EBUSY, the request is enqueued to
> the cryptd backlog and the async callback tls_encrypt_done() will be
> invoked upon completion. That callback unconditionally restores the
> scatterlist entry (sge->offset, sge->length) and decrements
> ctx->encrypt_pending. However, if tls_encrypt_async_wait() returns an
> error, the synchronous error path in tls_do_encryption() performs the
> same cleanup again, double-decrementing encrypt_pending and
> double-restoring the scatterlist.
> 
> The double-decrement corrupts the encrypt_pending sentinel (initialized
> to 1), making tls_encrypt_async_wait() permanently skip the wait for
> pending async callbacks. A subsequent sendmsg can then free the
> tls_rec via bpf_exec_tx_verdict() while a cryptd callback is still
> pending, resulting in a use-after-free when the callback fires on the
> freed record.
> 
> Fix this by skipping the synchronous cleanup when the -EBUSY async
> wait returns an error, since the callback has already handled
> encrypt_pending and sge restoration.
> 
> Fixes: 859054147318 ("net: tls: handle backlogging of crypto requests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
> ---
>  net/tls/tls_sw.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

