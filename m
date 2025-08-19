Return-Path: <stable+bounces-171785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E39E0B2C381
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782C2626B29
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E333A033;
	Tue, 19 Aug 2025 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JXoU2ZKv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m/2l2cO+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dV2bF2XG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KxoXrz/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745D3043A0
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605926; cv=none; b=EgDNNuodnB0FS+b5XfQ4azh34BMKWg/Yag0MoICxgilD6EzFa0xTgIRJDdXB9Gbt5LJBk5CCoT8MAvOg2WSvNjLfmZ/xR7Mu0hHCNKryC+5Di+JJMztkoTlUMXB0s3af3KqSIbhCgf1mZSnKRexC/DJkAPvH+mTYvfmiYMxpNYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605926; c=relaxed/simple;
	bh=xaBPVNaruFVXNeKO47R2zaa4hArCrbqiFLY55piiY+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2qBD/1aYXDqCgQVXwDGuGpjRRoJkkeQ8btonnLIIbn/Owhht3Klq2RqNSlSgmlkR9ZxMxYPnYs7E5ptVpdv8pzis2Zp1vnofMYmt1ZAZe5mYGmY6RZVJ+8tApPMPnchUxIl8PHHu/fEy7OTQTwVjshWH6awowwo4uaa/QvAZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JXoU2ZKv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m/2l2cO+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dV2bF2XG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KxoXrz/W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFDDA1F74C;
	Tue, 19 Aug 2025 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755605923;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l12tqlWlRGNaI7HUTjapwoVpWHe9CPQMvuig096uNfA=;
	b=JXoU2ZKvCXzsOAXQqRa1w16zwygyGbgOKfbK8yarTwwMbelkFPJR0pinj3GUyYMu9pDyl9
	xUft8P8GL6f8+fQejjNuwytJcmq2iaRGqJSl4XN+qokzi5EMFbtcCR5DNcanCLcnb2WmB5
	XyaY4fkq0VFYeBkA9Sw1J2R3eW/y6gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755605923;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l12tqlWlRGNaI7HUTjapwoVpWHe9CPQMvuig096uNfA=;
	b=m/2l2cO+62l8aMXmIomO2XDa4mJmbznLDXIUfVrGzDSwf4R2uGzAYWbkdtZXRXCv27Znvh
	owhi3Rt4svpe/nDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dV2bF2XG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="KxoXrz/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755605922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l12tqlWlRGNaI7HUTjapwoVpWHe9CPQMvuig096uNfA=;
	b=dV2bF2XGYKOL37vhWCI6wSJPoZqyljXEJ2WiXvGwy0oYVDB5h1plihb59URZ2NDIw4iTEd
	BFhAwIrbLPR9OmPRwBKRhK5B2ZZJyUdGlaeCisRy5KaMjTQY4YLSSAvgLnpOl5Zc5rtrRT
	/78ca0556NEEA3Rc+sHi5mlRyjUpC1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755605922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l12tqlWlRGNaI7HUTjapwoVpWHe9CPQMvuig096uNfA=;
	b=KxoXrz/Wya5PQdi6DtGbiqrKhWA2cdZNMH/S3AFfQmPrgdgSQYaogPLB6B2Lisf++/Nz2H
	9jKpzkfPW4myMHCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7D0E139B3;
	Tue, 19 Aug 2025 12:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hBmpLKJrpGiIeQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 19 Aug 2025 12:18:42 +0000
Date: Tue, 19 Aug 2025 14:18:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.6.y 2/2] btrfs: constify more pointer parameters
Message-ID: <20250819121837.GR22430@suse.cz>
Reply-To: dsterba@suse.cz
References: <2025081832-unearned-monopoly-13b1@gregkh>
 <20250819022753.281349-1-sashal@kernel.org>
 <20250819022753.281349-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819022753.281349-2-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: CFDDA1F74C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Mon, Aug 18, 2025 at 10:27:53PM -0400, Sasha Levin wrote:
> From: David Sterba <dsterba@suse.com>
> 
> [ Upstream commit ca283ea9920ac20ae23ed398b693db3121045019 ]
> 
> Continue adding const to parameters.  This is for clarity and minor
> addition to safety. There are some minor effects, in the assembly code
> and .ko measured on release config.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

What's the rationale for adding this to stable? Parameter constification
is for programmers and to have cleaner interfaces but there's hardly any
stability improvement.

