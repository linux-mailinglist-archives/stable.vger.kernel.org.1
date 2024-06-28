Return-Path: <stable+bounces-56056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD5A91B74F
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 08:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F9E2878C9
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD0313664E;
	Fri, 28 Jun 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CW8O+Ywc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IDqriNwh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S+V/gfO7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z3ce36HF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6C13212E;
	Fri, 28 Jun 2024 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557229; cv=none; b=nH3Z6NVPZenAlVblEKbB0RRyiH67/kUpjUTJ+1NmOqZrDfmu5nBzU9tfyLLcNY2pS9XXBeDrdl++IqHepgx8RuiUj1mduHvx87enOEW2qXJN/oCYYPzNGQK5fM4FLxdeZZm9BN75XIfDjgFrFY1RV0WZAakVZuBn8o/xcoxJUy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557229; c=relaxed/simple;
	bh=0J96qKAEDd/h8VrJnW4J277OL5HIXy7QqDMtTkoapoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gtxo4DvD6hN11KwY6ZPE8hmMh0onABo8sgNRDHWqillxlNJYOz6B+IBNIp+Q5bQur+/nISRwMhtqpMEanStQpCSrrH1Ay78R13MIa6KU4LduV/FUI1ltmwTYtr3V3RydaKWQMY+ZqN2RR2fc/WfYIPDIxVfh2pn2qG3p21WkGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CW8O+Ywc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IDqriNwh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S+V/gfO7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z3ce36HF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C35521BB1;
	Fri, 28 Jun 2024 06:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719557225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NyMKB4vbEkOX9JP/G0gqTNXDgdRRXPcyqgszdS/lb8=;
	b=CW8O+Ywc4p4Iez7o9OsIEadtdzPmuzki5Kq6EZjhFKhTPTqlGDRrSUF42L6+S7K7PkISAI
	P2dpGM+Ke0ZkdYECQwSCFW7LFnWvq1yJexOp7uXWvBqwWM5cSN4e65Y3C0jdt0RsHC7DJL
	2ZfXSJCgqNqengZshE8yptD8VuZW0LY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719557225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NyMKB4vbEkOX9JP/G0gqTNXDgdRRXPcyqgszdS/lb8=;
	b=IDqriNwhRcdj/dixZ33zW/IcX0Ss2vVwTrm2qS0vwGwmXmuD6mKX9lGlVHZKttxBGH++ix
	6pnBxRfSBQT5TPBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="S+V/gfO7";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z3ce36HF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719557224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NyMKB4vbEkOX9JP/G0gqTNXDgdRRXPcyqgszdS/lb8=;
	b=S+V/gfO7O8eSWnn+3JNfqgipivkSMKOy4uhTbWM1k1CskbyFn37hHUV9IwxyWuuJF5QJq8
	nVNDdNl0kCMlWWq6cMY9GnBuEQupWlPdxfiXzX+JO3xA6qA+a1UWw1kT1sWtDoLyIm2Ixo
	dpzk0HdxPPSS2g0LRagG4fRiZUekMjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719557224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NyMKB4vbEkOX9JP/G0gqTNXDgdRRXPcyqgszdS/lb8=;
	b=Z3ce36HFqUsoQ35cVZei+za8nUS7Ympl6d2TqE6OEIV2/ngrW2QP66M9Xrw/+2bZmsZSZs
	3KLArUt/04Fx3RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 961211373E;
	Fri, 28 Jun 2024 06:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +0/aIWdcfmY2AwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 28 Jun 2024 06:47:03 +0000
Message-ID: <0fbf1756-5b97-44fc-9802-d481190d2bd8@suse.de>
Date: Fri, 28 Jun 2024 08:47:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] ata: libata-scsi: Fix offsets for the fixed format
 sense data
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>, Igor Pylypiv <ipylypiv@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akshat Jain <akshatzen@google.com>, stable@vger.kernel.org
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-2-ipylypiv@google.com> <Zn1WUhmLglM4iais@ryzen.lan>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Zn1WUhmLglM4iais@ryzen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C35521BB1
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/27/24 14:08, Niklas Cassel wrote:
> Hello Igor, Hannes,
> 
> The changes in this patch looks good, however, there is still one thing that
> bothers me:
> https://github.com/torvalds/linux/blob/v6.10-rc5/drivers/ata/libata-scsi.c#L873-L877
> 
> Specifically the code in the else statement below:
> 
> 	if (qc->err_mask ||
> 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
> 				   &sense_key, &asc, &ascq);
> 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
> 	} else {
> 		/*
> 		 * ATA PASS-THROUGH INFORMATION AVAILABLE
> 		 * Always in descriptor format sense.
> 		 */
> 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> 	}
> 
> Looking at sat6r01, I see that this is table:
> Table 217 — ATA command results
> 
> And this text:
> No error, successful completion or command in progress. The SATL
> shall terminate the command with CHECK CONDITION status with
> the sense key set to RECOVERED ERROR with the additional
> sense code set to ATA PASS-THROUGH INFORMATION
> AVAILABLE (see SPC-5). Descriptor format sense data shall include
> the ATA Status Return sense data descriptor (see 12.2.2.7).
> 
> However, I don't see anything in this text that says that the
> sense key should always be in descriptor format sense.
> 
> In fact, what will happen if the user has not set the D_SENSE bit
> (libata will default not set it), is that:
> 
> The else statement above will be executed, filling in sense key in
> descriptor format, after this if/else, we will continue checking
> if the sense buffer is in descriptor format, or fixed format.
> 
> Since the scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> is called with (..., 1, ..., ..., ...) it will always generate
> the sense data in descriptor format, regardless of
> dev->flags ATA_DFLAG_D_SENSE being set or not.
> 
> Should perhaps the code in the else statement be:
> 
> } else {
> 	ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
> }
> 
> So that we actually respect the D_SENSE bit?
> 
> (We currently respect if when filling the sense data buffer with
> sense data from REQUEST SENSE EXT, so I'm not sure why we shouldn't
> respect it for successful ATA PASS-THROUGH commands.)
> 
I guess that we've misread the spec.

The sentence:

"Descriptor format sense data shall include the ATA Status Return
  Descriptor"

should be interpreted as:

  _If_ the sense code is formatted in descriptor format _then_ the
  ATA Status Return Descriptor should be included.

IE if the sense code is not in descriptor format then the ATA Status
Return Descriptor shouldn't be included (kinda obvious, really).
But of course the D_SENSE bit should be honoured.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


