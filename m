Return-Path: <stable+bounces-83048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD8995300
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D032CB29E0D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B81E0B89;
	Tue,  8 Oct 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o10LyVCs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S4QMRaW7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o10LyVCs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S4QMRaW7"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0971E04B3
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399488; cv=none; b=KWxnJM+PwS1SDS8TFwOEaQBZnVerNOb3v2dKT6apt/M20oNZ8IA+P0rqK96TJHkplm85xVyITqkYG6mgzcDRs1WY23Zw0yJWOgX7gfn9NXq6C4utOeVsDil3lRr5AykgAVIcJ/9FKnS67PGJO/WCwWEHfdooObB7ksWijzM+f60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399488; c=relaxed/simple;
	bh=ZQ2ps8Aaf4cbofqhWEGleNDN7gUBl0m4AxMGGcGsa8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXBGTCQtBXRWPpp2jBQbXgLqq5H43rXQfDXhZHRv0QiQoSsoYpnXrm0Ht9OyWkYGEt1DF5rqR9oleaSPkFq4QYzj2JRkM2JcfpfMNd+hywV7NQruIhfpGBjipPYAMEcF5yP19OeYGPI8Rp3Q42YuwSqp8zHZXGq9j0teUT3gCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o10LyVCs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S4QMRaW7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o10LyVCs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S4QMRaW7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C58C21FB60;
	Tue,  8 Oct 2024 14:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728399483;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FP5B8J4zXqvpaVmfft3bQ8ph205SEpSOD6R97ZrYfG4=;
	b=o10LyVCsRUbMmIskz2Vc4v1CVEAG1hKTY4bHoBd7OZ/XRy0hwNdonN1gffAQm6Mx9pzxLe
	vEXt9VBhgFwO1kyk1/IPQ5uu9b8BWTW4233ro53Xe083cK2AcvkBQLHFver1ky1/6qsXM3
	+3D9CljwcCoEXaw4lnyEi2nDmrShlb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728399483;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FP5B8J4zXqvpaVmfft3bQ8ph205SEpSOD6R97ZrYfG4=;
	b=S4QMRaW75fqPTFAsyTErNXjwn0OEHfbjq+63LOgpNUuCRlfDH4EtHpK9aZyd/eW+Sma6Va
	yENmNw3jBfdCuwCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728399483;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FP5B8J4zXqvpaVmfft3bQ8ph205SEpSOD6R97ZrYfG4=;
	b=o10LyVCsRUbMmIskz2Vc4v1CVEAG1hKTY4bHoBd7OZ/XRy0hwNdonN1gffAQm6Mx9pzxLe
	vEXt9VBhgFwO1kyk1/IPQ5uu9b8BWTW4233ro53Xe083cK2AcvkBQLHFver1ky1/6qsXM3
	+3D9CljwcCoEXaw4lnyEi2nDmrShlb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728399483;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FP5B8J4zXqvpaVmfft3bQ8ph205SEpSOD6R97ZrYfG4=;
	b=S4QMRaW75fqPTFAsyTErNXjwn0OEHfbjq+63LOgpNUuCRlfDH4EtHpK9aZyd/eW+Sma6Va
	yENmNw3jBfdCuwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6377137CF;
	Tue,  8 Oct 2024 14:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RUrEJ3tIBWchKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 14:58:03 +0000
Date: Tue, 8 Oct 2024 16:58:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: hsimeliere.opensource@witekio.com, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>, Omar Sandoval <osandov@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5.10-v5.4] btrfs: get rid of warning on transaction
 commit when using flushoncommit
Message-ID: <20241008145802.GA1609@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241008105834.152591-1-hsimeliere.opensource@witekio.com>
 <2024100801-antics-bacterium-408d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100801-antics-bacterium-408d@gregkh>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.99
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.973];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Oct 08, 2024 at 01:06:10PM +0200, Greg KH wrote:
> On Tue, Oct 08, 2024 at 12:58:34PM +0200, hsimeliere.opensource@witekio.com wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > commit a0f0cf8341e34e5d2265bfd3a7ad68342da1e2aa upstream.
> 
> Now queued up, thanks.

I haven't sent this patch to backport for < 5.15 because IIRC there were
some other changes needed. I'm not sure this patch is on itself is
sufficient to fix the warning and correct regarding the flushing logic.
So this needs an analysis first, if someobdy really wants to get i to
stable trees < 5.10. For now I suggest not to add it.

(For completeness, 5.15.27 and anything newer has the fix).

