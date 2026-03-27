Return-Path: <stable+bounces-230700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DLwIju/xmnoNwUAu9opvQ
	(envelope-from <stable+bounces-230700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:32:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD2348624
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1283D30182A5
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058EA3750A7;
	Fri, 27 Mar 2026 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="dFCfU872";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbKS5g8l"
X-Original-To: stable@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9737883C;
	Fri, 27 Mar 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632394; cv=none; b=JMl6tXCdZQLuWH7HzAIHoS9R+bAsAoKVrV45KV3IvvWV0Zhd7WyHtmORnV1oTPlVMnvmhMVT/Hkj/sosHtPhXUqum7j9NsCX0eciwtamkKsHC+O5lbZu3HJIxssKKmQ+CjsMUZnvh72T2o1tx3hE+26sAec5z62vsoFu0e/8tJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632394; c=relaxed/simple;
	bh=slqj/gMe0JT2XYj80Rxxl+YCupD0fkpnvugZX5CYxKg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EEAXRJbjstketue3cUw80DHIgTge0xpeSAq5Rz5lMQHFsthcHzyySKRdZp6A1bdMUlFynnzFk3B7vumW3xG2RRJLDz/qDWWarLM2pmtQiwkFG+DcJ0hbwztHSOOVgSErz+GMKXiR2TPc+XECfk+JgaKFuRfs6yxBhR4RrWV3l9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=dFCfU872; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbKS5g8l; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 544321D00042;
	Fri, 27 Mar 2026 13:26:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 27 Mar 2026 13:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774632392; x=1774718792; bh=Ml/tkinoAv
	mq/yJy+HQar/jPlJErmg7TF1THacdUdgM=; b=dFCfU872PkHjOxgKfSmDOoKZEJ
	4ywqwM4MuB6lGPG8lw8VdwLDwcjAEKaGGI5PXIv7m0/CjtvppUlbD7Vvv9iMg4oI
	qkzZ4aePB+hIhpmgwpahUx9p2W8PlCUyM2hf31x80Id5RcQjqZCZm7PQXdySTp7G
	J2lns/Y+DB1JiD+D8DY1sXAC+f1t6ikugEh2E0byDuoS0J34N1KB5al0HfmjYvtX
	yYksbdrxEyBtC0oKXh+0ibbUjbpKnBb/ng0hiWNarG+30V3SukfdtY5WMnwQ3deK
	0QMicakrpNWNOEQLhH1/IANkzyvxjrI3kEB5eTAErk42vUvPhMoe4OLuoBoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774632392; x=1774718792; bh=Ml/tkinoAvmq/yJy+HQar/jPlJErmg7TF1T
	HacdUdgM=; b=HbKS5g8lF/yj2V1DJ0C9AYm5VR1jfxQBUmeJGu0YS01FBDF4AQR
	9cEsAOUL2vYt6MviNgEZE5PMXlrLOve11XrDoqrIZGDyEc4GP5d4EJSmHWaWDQES
	if8RFrFCZGN6Jq4XwJwadCVeUNjL9yZhjV68FfMGqDacvvhTxBjGRl5vG+p4Wstk
	nvPyrV7B6x1sAwM6PH3OsO8z9Eoblm63PdteCR2j8PG0PSK0klnvq4YML4+SEcIx
	yENGfKx+Cl9jGoS9MBKsqp6PLBro6VZgZrKyGdFzAlHeMzmSwoCH0lGEXnvTB6DC
	h1hyryz7S09lekCFLaFMmq/Or2qRnqWfskA==
X-ME-Sender: <xms:yL3Gae69XVdnk-ruwtQ3uB-irR3MgKqwIZgob_uRl0fHh-D85eN_rw>
    <xme:yL3GaVvAFcAFiEvzvRs3TVQFqV_rx9jGwnt-HjmBetTv7dBXjwXsrfY4-nW733_94
    iHTgT1qZqgpVjm8Ww_GZ3KR_akAsWe0DcvLCNaAbdk7fBy62BvEOsQ>
X-ME-Received: <xmr:yL3GaX7eOT9g4OKX7rVlZys5rUTOPyBSQ9rzq_ImVC5_CNZOSeZSczAfO8ILbdwFnP4sXfg_M0GsFhqTjSWw2tacX6WbITip0uFjDs4p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefpihgtohhlrghs
    ucfrihhtrhgvuceonhhitghosehflhhugihnihgtrdhnvghtqeenucggtffrrghtthgvrh
    hnpefgvedvhfefueejgefggfefhfelffeiieduvdehffduheduffekkefhgeffhfefveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihgtoh
    esfhhluhignhhitgdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhirghvmhhorhguohhutghhsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yL3GaYU9R5jMKEbZQ8CbZZMQqdTlkdgt_puEYXTADU5La4UkRJ4PlA>
    <xmx:yL3GaR_DIWyRWBrmhQ1lX38B_-hJm3vj0cyOsXwjy3gcB9s1hxv7AA>
    <xmx:yL3GacnUbj2RoAmIsnZlzNOYNKx9QTyN75zgDXcgDg_d76RBwbAMEA>
    <xmx:yL3GaXXCu9WGqNLb37_aag4vGZ2ZahRLRq-3JJdsaK9BHiHmc06Vyw>
    <xmx:yL3Gad9whgNkIcn88dRMSziipq54-HDU2DUhpT8KKt8SE0m30u7jlYch>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 13:26:31 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 358A315AC5D6;
	Fri, 27 Mar 2026 13:26:31 -0400 (EDT)
Date: Fri, 27 Mar 2026 13:26:31 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Liav Mordouch <liavmordouch@gmail.com>
cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: discard stale unicode buffer on alt screen exit
 after resize
In-Reply-To: <20260327170204.29706-1-liavmordouch@gmail.com>
Message-ID: <23o42n41-n8r2-p878-sorq-4oo3396q99r2@syhkavp.arg>
References: <20260327160050.31631-1-liavmordouch@gmail.com> <20260327170204.29706-1-liavmordouch@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fluxnic.net,none];
	R_DKIM_ALLOW(-0.20)[fluxnic.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230700-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,fluxnic.net:dkim,fluxnic.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syhkavp.arg:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fluxnic.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nico@fluxnic.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 02FD2348624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026, Liav Mordouch wrote:

> When enter_alt_screen() saves vc_uni_lines into vc_saved_uni_lines and
> sets vc_uni_lines to NULL, a subsequent console resize via vc_do_resize()
> skips reallocating the unicode buffer because vc_uni_lines is NULL.
> However, vc_saved_uni_lines still points to the old buffer allocated for
> the original dimensions.
> 
> When leave_alt_screen() later restores vc_saved_uni_lines, the buffer
> dimensions no longer match vc_rows/vc_cols. Any operation that iterates
> over the unicode buffer using the current dimensions (e.g. csi_J clearing
> the screen) will access memory out of bounds, causing a kernel oops:
> 
>   BUG: unable to handle page fault for address: 0x0000002000000020
>   RIP: 0010:csi_J+0x133/0x2d0
> 
> The faulting address 0x0000002000000020 is two adjacent u32 space
> characters (0x20) interpreted as a pointer, read from the row data area
> past the end of the 25-entry pointer array in a buffer allocated for
> 80x25 but accessed with 240x67 dimensions.
> 
> Fix this by checking whether the console dimensions changed while in the
> alternate screen. If they did, free the stale saved buffer instead of
> restoring it. The unicode screen will be lazily rebuilt via
> vc_uniscr_check() when next needed.
> 
> Fixes: 5eb608319bb5 ("vt: save/restore unicode screen buffer for alternate screen")
> Cc: stable@vger.kernel.org
> Tested-by: Liav Mordouch <liavmordouch@gmail.com>
> Signed-off-by: Liav Mordouch <liavmordouch@gmail.com>

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>


> ---
> v1 -> v2: Reformatted as a proper patch with commit message, Fixes tag,
>           and Signed-off-by. v1 was sent as an inline analysis + diff.
> 
> Note: writing of this patch and analysis was assisted by AI for grammar
> and flow. Apologies in advance if anything reads off.
> 
>  drivers/tty/vt/vt.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1907,6 +1907,7 @@
>  	unsigned int rows = min(vc->vc_saved_rows, vc->vc_rows);
>  	unsigned int cols = min(vc->vc_saved_cols, vc->vc_cols);
>  	u16 *src, *dest;
> +	bool uni_lines_stale;
>  
>  	if (vc->vc_saved_screen == NULL)
>  		return; /* Not inside an alt-screen */
> @@ -1915,7 +1916,18 @@
>  		dest = ((u16 *)vc->vc_origin) + r * vc->vc_cols;
>  		memcpy(dest, src, 2 * cols);
>  	}
> -	vc_uniscr_set(vc, vc->vc_saved_uni_lines);
> +	/*
> +	 * If the console was resized while in the alternate screen,
> +	 * vc_saved_uni_lines was allocated for the old dimensions.
> +	 * Restoring it would cause out-of-bounds accesses. Discard it
> +	 * and let the unicode screen be lazily rebuilt.
> +	 */
> +	uni_lines_stale = vc->vc_saved_rows != vc->vc_rows ||
> +			  vc->vc_saved_cols != vc->vc_cols;
> +	if (uni_lines_stale)
> +		vc_uniscr_free(vc->vc_saved_uni_lines);
> +	else
> +		vc_uniscr_set(vc, vc->vc_saved_uni_lines);
>  	vc->vc_saved_uni_lines = NULL;
>  	restore_cur(vc);
>  	/* Update the entire screen */
> 

