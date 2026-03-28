Return-Path: <stable+bounces-230795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APG3AYn9x2ntfwUAu9opvQ
	(envelope-from <stable+bounces-230795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:10:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1F34F1E0
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED55302D971
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 16:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61D28DB46;
	Sat, 28 Mar 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b="Z/5vnVBm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PKIbgnba"
X-Original-To: stable@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E630DEB2;
	Sat, 28 Mar 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714166; cv=none; b=pW5SmdCtVlkhlY4imRhOZCcehkz0Cml3B5wrEq1/4IEjBQNzXl2teWBibyKQQJNv1SRyWVlYLKhkEJ5XQ3vsYfM4UYOlI21mzorFZtwR3OOGuqP8f7xtN//BDHDI2szj+eYbhV0gJfaHavamg6dYyIfuN8QVfrHFNEutrKxP+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714166; c=relaxed/simple;
	bh=O1ZVJ882aQOG6gi2ck3j4OiKAASpPDZpDC6CVsyIAhQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CvAqj4TOpEmXUSwdpbkvS5qqHjb5CY4DwhPSzj9aAWFemikTgqV3ebm4Zj3UYiWbqx7KhXwnPoQGrQmlDeVEAPXhhE89osB1Kn/yh9NwuZgxgXGBfS0hHOYDL+iy+tDLyobKBcl+zIwdpHa7Yf8Nm4YC1W8+60pinjr0s/jEDI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu; spf=none smtp.mailfrom=firefly.nu; dkim=pass (2048-bit key) header.d=firefly.nu header.i=@firefly.nu header.b=Z/5vnVBm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PKIbgnba; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firefly.nu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=firefly.nu
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 934271D00111;
	Sat, 28 Mar 2026 12:09:23 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-01.internal (MEProxy); Sat, 28 Mar 2026 12:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firefly.nu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774714163;
	 x=1774800563; bh=O1ZVJ882aQOG6gi2ck3j4OiKAASpPDZpDC6CVsyIAhQ=; b=
	Z/5vnVBm2xzJUW8pwAVrwt7GTCiM0LbnaUhAAbjFWe/+GKQFlv2aI54ULc1zO4iu
	dqChzkF2eAmyyyNsB2y+SMBd7zCHqwRu/cIi6Bp6Vg9GXKG7NHt8DsKH7pk3AfjI
	7yKY+yIS09GU28XGH+hfcqhEJPutgzi20EygUxv9T+AVb3EgvDzDc809KqAOlahZ
	fWTYMUlTgIubZS651pN1gfZeWPyaGqQuJoFiTH7vKbfeSk+kw8YrF507BEJmnRMV
	qP9Z5OyCrDpweH06j8o/DhHGQ/G7hmCRHojKWomzZkRU76bGFOMg1jZ+Tig1OZRp
	NpXC6b9rR+rWbi6IN+aa/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774714163; x=
	1774800563; bh=O1ZVJ882aQOG6gi2ck3j4OiKAASpPDZpDC6CVsyIAhQ=; b=P
	KIbgnbaep3p2C5h1Gm0MtCpN/fihD49uW6nhgcGBT9uNdwMsYBin8BPsCCkMlJIy
	vsFEpWXzmys9epTKx9xgBwNU9Oo0aOE0dLH+v9vcbOt0E2EAh6CJZIUWD3Ir7kdU
	WqZt42hF9Z2uaTZyJpChOrBb+kHR7chGzblUbYhABnpUOU9qyzgHZNxG36zotDJO
	94kRbqSnsW35D8LfPNoChcn+sIeTqKoIn9yjdPfvtQyB/r6PJZmGZYz3geaS/jrF
	L7cd+sCD8Hiz4Lgqvjpk1B2CswVnybJTOI9Ghjzu+5Lj09RbikrFhZM5T71iFa/Z
	Fuv19Qxy8W7bFa/yCFtLQ==
X-ME-Sender: <xms:Mv3Hafmm7pJdI9wAZ6EaurZ0RGc6mKQWo-_5JdGsJRFt1sTPFs7vXw>
    <xme:Mv3Hadqhu7AtEb4LIPD5uVzqMcadqI16j5a5rpgHbXnu_2tzdtfg7cAs8QF788w8i
    pZCFYta07zzu_5lGsgoeE8TTSLUqys9RtjwwJrlUPrpfnrX6dOHkl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeefieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredtjeenucfhrhhomheplfhonhgrshcujfpnghhluhhnugcuoehfihhrvghflhihsehf
    ihhrvghflhihrdhnuheqnecuggftrfgrthhtvghrnhephedtgfegvddukefgleefgfegke
    ffieeftddvjeetudfgfedvgfevjeduhefftdeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepfhhirhgvfhhlhiesfhhirhgvfhhlhidrnhhupd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrvghg
    rhgvshhsihhonhhssehlvggvmhhhuhhishdrihhnfhhopdhrtghpthhtoheprhgvghhrvg
    hsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhig
    qdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M_3HaRSyGr0QiIyD4dNPXS9OvcJAo8EkXhEYsH3TNPZNQG34HYcB6w>
    <xmx:M_3HaRqx-B0FRwPNDohq6L4f5LX4cm_6lc1_71lqVR7dgCBZS4m7Tw>
    <xmx:M_3HafJWC6UkKC6BFh7r1LmT5XvRZH3QhFgl_ROsS-U4tkMjW74UHw>
    <xmx:M_3HaUqbqv4BHooOA3nbX2YA4Gxf7b5Y2KEdDOBwfLd2VizLNYvN5g>
    <xmx:M_3HaYlWShVDtKdGGjjja2v8M7FNDtpn0_AhYRoZ0RwAdg_fjed_K_Ml>
Feedback-ID: i8f9147e2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DAC75216008A; Sat, 28 Mar 2026 12:09:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAr4zjfPh1Rc
Date: Sat, 28 Mar 2026 16:09:02 +0000
From: =?UTF-8?Q?Jonas_H=C3=B6glund?= <firefly@firefly.nu>
To: "Thorsten Leemhuis" <regressions@leemhuis.info>
Cc: linux-pci@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Message-Id: <f4d006e0-42cf-4843-a2ec-f04077eb0791@app.fastmail.com>
In-Reply-To: <5fb8c589-60cd-4ab6-a305-abefc6e5c043@leemhuis.info>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com>
 <5fb8c589-60cd-4ab6-a305-abefc6e5c043@leemhuis.info>
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since new bridge
 window alignment calculation code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[firefly.nu:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[firefly.nu];
	TAGGED_FROM(0.00)[bounces-230795-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[firefly.nu:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[firefly@firefly.nu,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DB1F34F1E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026, at 08:46, Thorsten Leemhuis wrote:
> Thx for the report. One important information is missing afaics: Does
> the problem happen with latest mainline (say 7.0-rc5) as well? The
> answer determines how this will be dealt with.

My bad! I've tested against 7.0.0-rc5 now, and it seems the problem
persists there.

Thanks,
Jonas

