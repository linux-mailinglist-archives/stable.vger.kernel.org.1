Return-Path: <stable+bounces-227576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLBUCECAvWk4+gIAu9opvQ
	(envelope-from <stable+bounces-227576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:13:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 432382DE630
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D052303F8BD
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB3E3CCFBD;
	Fri, 20 Mar 2026 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KevBL8ch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1H+pZls"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416323CCFD7
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026158; cv=none; b=rxjkTRJgqjcVN4iJIdZjpKEhcJChNWSM3NLVGL5I3vTyzKE8GVrMY44fbCApKVQBY/MJ3lp3iXw1YfkDQTMpijkZKplKTPc7MjlopB+EbL0ingn1SpsEKY1IQ/060CmV7n84UEVFxOF8Aix7fgLWUS40GpzoKbcyu9N3VhdRtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026158; c=relaxed/simple;
	bh=RcvsgIPLCHEAa1IAeRBGU7vMCeMM7aKEpfYYufTMY0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPsuvpfSuSqNJIzV2zlfY2u50Xs9L36/imxwWncoYOZxyaZZk8LGWjK+RASa+M1J7jRPngrVXaq8omWIbeKgGerKvtvoAM+dU2GluMgoO4vYSyhDUhois5eEJt6szpAYS39yx0ZHYUiUQkipK2pzf53sNNd+a0FbZ3bW5Esd6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KevBL8ch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1H+pZls; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D876EC0091;
	Fri, 20 Mar 2026 13:02:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 20 Mar 2026 13:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774026156; x=1774112556; bh=6rlETsoHcc
	IvcFbM0FlgghkfYDku/JrzqMRX368k+bI=; b=KevBL8chXrxjFzXmQymBmCJL6q
	E8DAWGs6nYr0TxA4a3fzxzhM3Nc3xxZb3vUVBx82uEaagM5A5nIomExsDb1apbB+
	SnmUEc1sbZyd63WI/SKbexRu4fP2LMV0w1Z47w2JQSTIRRg05sCcpdqccaA/Undu
	DxiYvcH+LEnDCp54eNoseTjlJxQv6aX/kLvTcu+EGB/sSOhDc943TUD1s4PKYsAm
	ipUL0z/zpPbwYNLaKrVe2Fubc74SUOiPWd5dWl8RWjWFD9ZOHcgbMjjTmq3LTX0R
	YZsTScznMFH/W1uPNkEo+VjIqKlrB9oV/NqNhYN8X3hixLmx90y6Y5sK7FTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774026156; x=1774112556; bh=6rlETsoHccIvcFbM0FlgghkfYDku/JrzqMR
	X368k+bI=; b=V1H+pZls0ruIV/P9NOy45ndQ9ZndzxAJ7EyVwLcNe7/Wr7n8CQb
	l57tIu6nbL/t4txa2daU9csWwih+eEUeCPUT2NX/2E3A8tfTL4U95DJHUmbAlx5O
	e0hKDaSWuvOlNxsrV8ZD72Kpm1DetBdcqPZl98HWqZzQhoFacg3Id25kpPJ7na6f
	9geX/uJYRBRg/xgzuYyKnHG8YhGBxvOGKjkuAsyb/HmiZ+lHTyZ69u/Oatb13ekC
	260SID1ArvQpBtBlsBDydHU139nuZr0lUXK5C03x3IwopqVhzxZnnfuFv1Ha6KbA
	qL1gqcOvxUVEYERxDddWmFIX6PyRXQfIvJg==
X-ME-Sender: <xms:rH29aex-tAmtdfpkm7QCHdjMcvrfvew5LfPrEkwsOVRYAiS-5-7_2Q>
    <xme:rH29aYEgks6Hn9TUxR2Z0Rk4O7lA2MPKK1cHABTxcgHGvdQLMDesXMl4152C8sa45
    iBrs9wE8vvvT_RoBCs9ozjN8aRXH-Oc0U8pMAsEi7q1htk>
X-ME-Received: <xmr:rH29aazymL-tLjY5MIbfZCgy04s2VqVMHyyGkXQhk1jJ7lGT77v24sKOGG8Lu-1NUAnYym0vlb7GeEFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rH29aRspTCupqOC-vnJ7kl3nl8aorRq1sfCuNlVj5IOolndXuSBdOw>
    <xmx:rH29af3VKrPHy7M1Tq-EgaAddH6P6AQA8VOJe6rsA4syDWp9nGb6uw>
    <xmx:rH29aU9R54v8fyYsvY_sF2aUyOnE9to4h8opo5n0KaOmaByJ-7n4lw>
    <xmx:rH29aYMrcX6Z3-vRbTblD2-AI_mykl4ZWo5aCH4dx7Ea2l_Jwtn9hA>
    <xmx:rH29aYpIifub_QTQpzCl-CI6dq2nJbYM0oTV5yrALU6JNX4hleCMCNwF>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 13:02:35 -0400 (EDT)
Date: Fri, 20 Mar 2026 18:01:10 +0100
From: Greg KH <greg@kroah.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.19.y] HID: appletb-kbd: add .resume method in PM
Message-ID: <2026032002-steadying-phoney-bc43@gregkh>
References: <2026032048-canal-smell-2ad1@gregkh>
 <20260320085628.1274-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320085628.1274-1-gargaditya08@live.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[live.com];
	TAGGED_FROM(0.00)[bounces-227576-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,kroah.com:dkim,live.com:email]
X-Rspamd-Queue-Id: 432382DE630
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 08:56:34AM +0000, Aditya Garg wrote:
> Upon resuming from suspend, the Touch Bar driver was missing a resume
> method in order to restore the original mode the Touch Bar was on before
> suspending. It is the same as the reset_resume method.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  drivers/hid/hid-appletb-kbd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
> index b00687e67..0b10cff46 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c
> @@ -477,7 +477,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
>  	return 0;
>  }
>  
> -static int appletb_kbd_reset_resume(struct hid_device *hdev)
> +static int appletb_kbd_resume(struct hid_device *hdev)
>  {
>  	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
>  
> @@ -503,7 +503,8 @@ static struct hid_driver appletb_kbd_hid_driver = {
>  	.input_configured = appletb_kbd_input_configured,
>  #ifdef CONFIG_PM
>  	.suspend = appletb_kbd_suspend,
> -	.reset_resume = appletb_kbd_reset_resume,
> +	.resume = appletb_kbd_resume,
> +	.reset_resume = appletb_kbd_resume,
>  #endif
>  	.driver.dev_groups = appletb_kbd_groups,
>  };
> -- 
> 2.52.0
> 
> 

What is the git id of this change?

thanks,

greg k-h

