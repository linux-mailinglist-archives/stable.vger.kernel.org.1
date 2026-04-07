Return-Path: <stable+bounces-233503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NDRLNmp1GmkwAcAu9opvQ
	(envelope-from <stable+bounces-233503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:53:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C77F3AA7FB
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 08:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D1FA302B23D
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 06:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DAB38B151;
	Tue,  7 Apr 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nd3SQWNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YtgfRD8R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mcm9l5Ub";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8GJ41VGg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD26538C409
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544780; cv=none; b=VVHs3sXDQOh3JlOUl6XsGoFYUagkgGNtBm5/xRPE5BFInesD1jI4Y4ZD5bISLbk4TV/j29WYF1RVxIlblrKpRMt5EzUJRhjbZbXAC8k2oDYnufDvTzwbJsTdPew+YfMYF4lS/JbfD7B+a8lnWaFM+pZO3ByG5rRHpe7lWks18wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544780; c=relaxed/simple;
	bh=RNGcZgd3URzXt1D740LRT+h43STai320ZejueQi8ejw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeO7cPJogPnLkt7L5pflk2kxqX+4PpmQjjobxKVz/h6QH20/AR3vrP+4cXhx586XlJTXXsXzHhiEL/D7r7Fq1xvjns8yNwt+odSu7DCxZRYCcq6d6FHnl8W0o3zr4Kx6v2NmA7pFixmaMRtzeSgJH9XuzQCmYn8z2xnHRJ8egGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nd3SQWNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YtgfRD8R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mcm9l5Ub; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8GJ41VGg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C15F5BD52;
	Tue,  7 Apr 2026 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775544777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKMmF32OPlhGw1MWQ6jVYLjMf8gxmtWKr0GcqhLCB1k=;
	b=nd3SQWNw0D/+nUnSfXiOCWHUviMm1Kkl+wm6lMl/miy4KGcNlBto4+vokMGAES3N2NpPQF
	kAnu0iatdpBYeZuM4sTWWJGXUMrEttA4TsTiMJmYVDHUc8mY7r0K4M0J3kM76/NGAf6339
	WQSVfgLq88xlFOWCL1lEktuz8TQ5B74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775544777;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKMmF32OPlhGw1MWQ6jVYLjMf8gxmtWKr0GcqhLCB1k=;
	b=YtgfRD8Rh16UUlj1oE++0mL6IMFxz/hEKN461HVysMfpXsa02B0wuRWU5ZRID/P5laidCv
	TetKBU1X/hPxwADA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775544776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKMmF32OPlhGw1MWQ6jVYLjMf8gxmtWKr0GcqhLCB1k=;
	b=mcm9l5UbeGirttA76UGspVFeco90FkVsj0bTEbUuoYsrB002/+zmVvvW27HXqKWeAKRj2O
	1kELWQDO8Slbpt6UNzp2oaNyT7+D0B4t2UTcrbBqlGz4n5fCTdBUe/zZB5TPPcxLcZtJFT
	GyAEXhG6oW1GtBYcG+Qp4C3ldU1FE+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775544776;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKMmF32OPlhGw1MWQ6jVYLjMf8gxmtWKr0GcqhLCB1k=;
	b=8GJ41VGgVuiccqbM8/8EmIB31DbO/gYUUfNwcs98lvJwa3RiQwhABmoeP6Q+ywW55BuwYh
	wgOt4AqNsyvhr2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD9314A0B0;
	Tue,  7 Apr 2026 06:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9mzwNMep1GlcNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 Apr 2026 06:52:55 +0000
Date: Tue, 07 Apr 2026 08:52:55 +0200
Message-ID: <878qazntx4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Nathan Rebello <nathan.c.rebello@gmail.com>
Cc: gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tiwai@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: skip connector validation before init
In-Reply-To: <20260407063958.863-1-nathan.c.rebello@gmail.com>
References: <20260407063958.863-1-nathan.c.rebello@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233503-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 2C77F3AA7FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 07 Apr 2026 08:39:58 +0200,
Nathan Rebello wrote:
> 
> Notifications can arrive before ucsi_init() has populated
> ucsi->cap.num_connectors via GET_CAPABILITY. At that point
> num_connectors is still 0, causing all valid connector numbers to be
> incorrectly rejected as bogus.
> 
> Skip the bounds check when num_connectors is 0 (not yet initialized).
> Pre-init notifications are already handled safely by the early-event
> guard in ucsi_connector_change().
> 
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Fixes: d2d8c17ac01a ("usb: typec: ucsi: validate connector number in ucsi_notify_common()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index b77910152399..7df3a7b94a40 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -43,7 +43,8 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
>  		return;
>  
>  	if (UCSI_CCI_CONNECTOR(cci)) {
> -		if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
> +		if (!ucsi->cap.num_connectors ||
> +		    UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
>  			ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
>  		else
>  			dev_err(ucsi->dev, "bogus connector number in CCI: %lu\n",

Confirmed that it fixes my case.

Tested-by: Takashi Iwai <tiwai@suse.de>


Thanks!

Takashi

