Return-Path: <stable+bounces-139699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01EAAA9509
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06711179523
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64152586E8;
	Mon,  5 May 2025 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FKLlFcco";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="co89EOuH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FKLlFcco";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="co89EOuH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B59258CF0
	for <stable@vger.kernel.org>; Mon,  5 May 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453967; cv=none; b=Ux9dFYD6ulskrB500Y6uvc4DeLox2uS/tQQxqlIoLLOfwfOhmMfXro9ugzF4S+RdfRXypsMPH8YUEqAMt/PvY8C98VyDbw3wQhKjE5+FapV1DrBooDR+EurQvTtWMGIVnbo3tNJ/KHMTLzmLVMQx9d9Dg1yJcSaqR+4CTdTJQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453967; c=relaxed/simple;
	bh=/Xsn6maS+Wdmweg3hJXk0ZRFNY7V0DKtfrgIHocDUBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmqFrrvBBYdFRdY0ERtw6UIAMQkRT+JQvOdYl4z5NkmcF27+ceClE1eIEWsHdWX+XaTZ9eh6QFq441j0Asn2GTZ35CG4fPhXOTJ/O2pHL46EXlVhY4gYYuVGN4hX6zvBXyiqjE+YCjFpfHqZXLS0PQqarLBXLfr7AzOfu25HZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FKLlFcco; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=co89EOuH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FKLlFcco; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=co89EOuH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FDC91F7A1;
	Mon,  5 May 2025 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746453963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSmK4+cD5xKoGrQb0tbSYN8WdkeFgB17gf4xQ9Ku1nQ=;
	b=FKLlFccoVDhTBtlYnzVV3VfF8YY/tRzZpFrjMke7HxBeiEQUl1hXyMG2nuBtR0YX2gnCkB
	ap3oM5HxjJ8WvKBjLvQ9pyVdb+UyBY5LFCWT5j/bznrUskNMFJoskaahr7ZBdw3V5G4Hi2
	t0H23S9PggsNCJ9QyhovHqj2cQoN3W8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746453963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSmK4+cD5xKoGrQb0tbSYN8WdkeFgB17gf4xQ9Ku1nQ=;
	b=co89EOuHgTE+5dzN2Sk9auyV5ridw/8Y18FTsYKfF46HV8xvGOY9WOuV2BOLIo4XTQdGDR
	Fysc/cg+mUmUsjCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746453963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSmK4+cD5xKoGrQb0tbSYN8WdkeFgB17gf4xQ9Ku1nQ=;
	b=FKLlFccoVDhTBtlYnzVV3VfF8YY/tRzZpFrjMke7HxBeiEQUl1hXyMG2nuBtR0YX2gnCkB
	ap3oM5HxjJ8WvKBjLvQ9pyVdb+UyBY5LFCWT5j/bznrUskNMFJoskaahr7ZBdw3V5G4Hi2
	t0H23S9PggsNCJ9QyhovHqj2cQoN3W8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746453963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oSmK4+cD5xKoGrQb0tbSYN8WdkeFgB17gf4xQ9Ku1nQ=;
	b=co89EOuHgTE+5dzN2Sk9auyV5ridw/8Y18FTsYKfF46HV8xvGOY9WOuV2BOLIo4XTQdGDR
	Fysc/cg+mUmUsjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4345513883;
	Mon,  5 May 2025 14:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rj4GDsvFGGiDPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 05 May 2025 14:06:03 +0000
Date: Mon, 5 May 2025 16:05:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jack Wang <jinpu.wang@ionos.com>, Wang Yugui <wangyugui@e16-tech.com>, 
	stable@vger.kernel.org, wagi@kernel.org
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90
 blk_mq_map_hw_queues+0xcf/0xe0
Message-ID: <98959a8c-67d7-49f0-bb65-80169b32b70c@flourine.local>
References: <2025050500-unchain-tricking-a90e@gregkh>
 <6818a2d5.170a0220.c6e7d.da1c@mx.google.com>
 <2025050554-reply-surging-929d@gregkh>
 <6f78e096-cb32-4056-a65a-50c27825d0e1@flourine.local>
 <2025050555-overhung-jiffy-6b63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025050555-overhung-jiffy-6b63@gregkh>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, May 05, 2025 at 03:52:38PM +0200, Greg KH wrote:
> But commit a9ae6fe1c319 ("blk-mq: create correct map for fallback case")
> says it fixes commit a5665c3d150c ("virtio: blk/scsi: replace
> blk_mq_virtio_map_queues with blk_mq_map_hw_queues"), which is ONLY in
> the 6.14 tree.
> 
> Which is why we didn't pull it into the stable tree here.  Is that
> commit just not marked properly?  Will it cause problems if it is
> backported?

The stack trace for this report is from a system which has a
megaraid_sas HBA. I did some testing with this HBA but somehow I
didn't run into the problem. Thus the Fixes is just not complete, it
misses

Fixes: bd326a5ad639 ("scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues")

Sorry about that.

