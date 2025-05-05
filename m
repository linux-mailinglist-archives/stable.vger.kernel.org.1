Return-Path: <stable+bounces-139690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93ACAA94B4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7C3B3AC4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A81F9F70;
	Mon,  5 May 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="st52Cb+6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xKO+yn3o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="st52Cb+6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xKO+yn3o"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FA13AA53
	for <stable@vger.kernel.org>; Mon,  5 May 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452459; cv=none; b=dyyL8HHuQWJUaYukQyLTlqvFK5y+2QZgr7ZZxEXdqov0glmOvkZVsZ1hS0sPewwx3yt+ORFDuRPPxb8op8G8F8k2ZZJJ3ChWRLsgyLWcWRLH9z3ZZTd8xEVxSZFlI301yexBusNfZAfzOLMrjsAvi6E5cOgtX6fZHCpU4M+gqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452459; c=relaxed/simple;
	bh=fptT5s+3jjeFOZFDp5XvTyQN7JgaAOKGGeRSMRbkeko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC2ivMafoM3v5+iNiKUV5LG2dZxm3EtkQaPUyTCZrpneiLoXN/kSzEFkq3TuOpkQNqVadE9Fq1LYtAdmqmFO3rMW1AOvCzwc4o+aGFb/wDZgK9x9LWaOBmTR2oZUZCrYmcXvutZNE1QnTPxgd+7D9G+3PhW4I5EMY3/T9Y8tCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=st52Cb+6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xKO+yn3o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=st52Cb+6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xKO+yn3o; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0AA861F79C;
	Mon,  5 May 2025 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746452456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6GSB4jaihrfwBzrlZtThaUnsppYlK1tmAOIJ2NsHG00=;
	b=st52Cb+6xShSGfGmMPUZqjy16qYC8IlghadeBa/OXY+NlHd7zdqtuIqEnMDg7K37z9ax/m
	AH+G4OOLjevwhcpRUhKlpfZev3zEF1h5aNptpIk0qo44vS7CosFg3VMc+FF5N4sMUqh0Ti
	e4BMvrPoKXZQXBNm0V/rbyNXWjG+rII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746452456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6GSB4jaihrfwBzrlZtThaUnsppYlK1tmAOIJ2NsHG00=;
	b=xKO+yn3oGKqyGPRTUECci6xItglY33XjC8aFPQ5izfAIaflU4Vg5gJi6QmTv7Q9HbUDThy
	/XWk6TlNk2ZQBvCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746452456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6GSB4jaihrfwBzrlZtThaUnsppYlK1tmAOIJ2NsHG00=;
	b=st52Cb+6xShSGfGmMPUZqjy16qYC8IlghadeBa/OXY+NlHd7zdqtuIqEnMDg7K37z9ax/m
	AH+G4OOLjevwhcpRUhKlpfZev3zEF1h5aNptpIk0qo44vS7CosFg3VMc+FF5N4sMUqh0Ti
	e4BMvrPoKXZQXBNm0V/rbyNXWjG+rII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746452456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6GSB4jaihrfwBzrlZtThaUnsppYlK1tmAOIJ2NsHG00=;
	b=xKO+yn3oGKqyGPRTUECci6xItglY33XjC8aFPQ5izfAIaflU4Vg5gJi6QmTv7Q9HbUDThy
	/XWk6TlNk2ZQBvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1CE113883;
	Mon,  5 May 2025 13:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R+8RNee/GGgxOAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 05 May 2025 13:40:55 +0000
Date: Mon, 5 May 2025 15:40:51 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jack Wang <jinpu.wang@ionos.com>, Wang Yugui <wangyugui@e16-tech.com>, 
	stable@vger.kernel.org, wagi@kernel.org
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90
 blk_mq_map_hw_queues+0xcf/0xe0
Message-ID: <6f78e096-cb32-4056-a65a-50c27825d0e1@flourine.local>
References: <2025050500-unchain-tricking-a90e@gregkh>
 <6818a2d5.170a0220.c6e7d.da1c@mx.google.com>
 <2025050554-reply-surging-929d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025050554-reply-surging-929d@gregkh>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, May 05, 2025 at 03:28:22PM +0200, Greg KH wrote:
> On Mon, May 05, 2025 at 01:36:52PM +0200, Jack Wang wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > In linux-6.12.y, commit 5e8438fd7f11 ("scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues")
> > was pulled in as depandency, the fix a9ae6fe1c319 ("blk-mq: create correct map for fallback case")
> > should have just used 1452e9b470c9 ("blk-mq: introduce blk_mq_map_hw_queues")
> > as Fixes, not the other conversion IMO.
> 
> What "other conversion"?  Sorry, I do not understand, did we take a
> patch we shouldn't have, or did we miss a patch we should have applied?

If I understand the situation correctly, the problem is that v6.14.25
ships commit 5e8438fd7f11 ("scsi: replace blk_mq_pci_map_queues with
blk_mq_map_hw_queues") which introduced a regression for certain virtio
configurations. The fixup patch is:

a9ae6fe1c319 ("blk-mq: create correct map for fallback case")

