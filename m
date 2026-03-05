Return-Path: <stable+bounces-223217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIG+BU2dqWnGAwEAu9opvQ
	(envelope-from <stable+bounces-223217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:12:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D4B2143EC
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CF5E3032DD2
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4403BA238;
	Thu,  5 Mar 2026 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HHF6rwun";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEx1cRz8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HHF6rwun";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nEx1cRz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E039E6C0
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723188; cv=none; b=Pu/DiiNAZ7ATc9Tuyr7EbCYLvrPmJjFPdjnq9TqdV0xwIjp18GClWEvOlG89fhSl4S+jPGAYzdC/2qksK66hkRHaR9/H5kt0pk5VWNl/m7OcrHI8U8IWN13OK93rHrmRq7sMZtvpUAtLQGQomsRxelaS2o7k6/YQ0IYl9ZJQXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723188; c=relaxed/simple;
	bh=z4AHrGvw81ANUPukkGX+dgl7hXSQilMVx+iXO8GsSB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+CRb5nh6nvqzNHoAYzCiPT1HeUCJlZ1m8ivGFv5FQTqzUDyxEuLJXMGU4QZRdvhGbHE/6MTuwYAkNEoi0RpVBChQFW4igd4SW/BcPt7mMLfgrd7d7Q7RRTyfTaWbs1b168ASCBobATML2lRa0uT1vd8cYisRSpXVwy68Lbr1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HHF6rwun; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nEx1cRz8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HHF6rwun; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nEx1cRz8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FB883F26F;
	Thu,  5 Mar 2026 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772723185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKOkmoCvv3CEkHY2UPn5Y8n+3bq113EX2+oHYyLm0wU=;
	b=HHF6rwunxvP9PQu2O3IDzVyt/xD5B7K6WToJZO0BrOXn5gWHXu3m0np/77rZ+BXKqt0yKT
	IEEvfRdGTTbLn/13utde7kNc3Unq8UWlpHEK/u65g4h+IRfqacDU1dwfGjY19CF+JMK6hQ
	GNmGtwqxgjPnS5icKG4emtd7Pwm564s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772723185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKOkmoCvv3CEkHY2UPn5Y8n+3bq113EX2+oHYyLm0wU=;
	b=nEx1cRz8l0ArCARScynOQ5PZLtur9dIQIt2UNxkv/tnJu0MC6elEx/mOeaA6PiT/772hT6
	1/zisBg7b1lIjuBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772723185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKOkmoCvv3CEkHY2UPn5Y8n+3bq113EX2+oHYyLm0wU=;
	b=HHF6rwunxvP9PQu2O3IDzVyt/xD5B7K6WToJZO0BrOXn5gWHXu3m0np/77rZ+BXKqt0yKT
	IEEvfRdGTTbLn/13utde7kNc3Unq8UWlpHEK/u65g4h+IRfqacDU1dwfGjY19CF+JMK6hQ
	GNmGtwqxgjPnS5icKG4emtd7Pwm564s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772723185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKOkmoCvv3CEkHY2UPn5Y8n+3bq113EX2+oHYyLm0wU=;
	b=nEx1cRz8l0ArCARScynOQ5PZLtur9dIQIt2UNxkv/tnJu0MC6elEx/mOeaA6PiT/772hT6
	1/zisBg7b1lIjuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E068A3EA68;
	Thu,  5 Mar 2026 15:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h/uAM/CbqWnQHQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 05 Mar 2026 15:06:24 +0000
Date: Thu, 5 Mar 2026 15:06:23 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
Message-ID: <ltqoseouwid7bfbntwr2e7tfquw7ypojit74hem6ccuzttgqh2@n2agw3lgdnh6>
References: <20260305145312.1081112-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305145312.1081112-1-pfalcato@suse.de>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 84D4B2143EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223217-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 02:53:12PM +0000, Pedro Falcato wrote:
> Currently, whenever you boot with a QEMU drive over an AHCI interface,
> you get:
> [    1.632121] ata1.00: applying bridge limits
> 
> This happens due to the kernel not believing the given drive is SATA,
> since word 93 of IDENTIFY (ATA_ID_HW_CONFIG) is non-zero. The result is
> a pretty severe limit in max_hw_sectors_kb, which limits our IO sizes.
> 
> QEMU has set word 93 erroneously for SATA drives but does not, in any
> way, emulate any of these real hardware details. There is no PATA
> drive and no SATA cable.
> 
> As such, add a BRIDGE_OK quirk for QEMU HARDDISK. Special care is taken
> to limit this quirk to "2.5+", to allow for fixed future versions.
> 
> This results in the max_hw_sectors being limited solely by the
> controller interface's limits. Which, for AHCI controllers, takes it
> from 128KB to 32767KB.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Ugh, just noticed I forgot to pick up Damien's Rb, please add it when
applying, thanks!

-- 
Pedro

