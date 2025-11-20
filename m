Return-Path: <stable+bounces-195228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DA5C72978
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 08:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41FF4E44C1
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64F42BE051;
	Thu, 20 Nov 2025 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tHKKggg7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aHVyoi6T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q01t0840";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u7bSIMeG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466A228CB0
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623461; cv=none; b=N3yF/l2w0Oe296ccm0Dsfkax6HU+FTs9IH7ZAoz+EPIwQ9k8RPsIP/EIh22iUr2p5th0QcwSS/8qn8qMVybFHYa6kOPI9s84YZLo2R9Uqw4fca7Klvz1FpZTdgwJGIlyMInEG7uW9v6b0NpDTW/mzM6sQIc5txZCUp5VdTWKyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623461; c=relaxed/simple;
	bh=0SeQZzeaIU8gmBSQ1IytuvsxLqEm8+RCJJ8WznubkNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CP7OdoZttus8tS8Foi0g00hsYc/dCiPWC3N7he3rTWmko5FicqMxNvDiBf5vCa2vxwvxdLt6y+XLr7T6vDP9n5+qm0bT2WCbYL8zpEqGbZh+NGOcG4yHI5X3OI3Y1rgG8TKPxNdm0dhGb+3JXYuZ2Ei/fksWtP5cwBv0rt57+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tHKKggg7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aHVyoi6T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q01t0840; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u7bSIMeG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CAB521278;
	Thu, 20 Nov 2025 07:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763623457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t35grRHi9H+MFIcJYZ6KGp9wOmKAiFmDReWxNMQjZCk=;
	b=tHKKggg7h/fb1YEeqUdk50wbPzJtCaEn8sN405flhnGYGa2ok+My+TsO71g5lDZ8shCB72
	DbztzuN+lMUFVNGfZXWjtgs2TsYt2YabOwgsy36S9PRyWEv1w4xcJKBSkhgcoGqtz4oOzB
	peW1s/QfyAKwhwvjaZYZ/D5ispAW2SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763623457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t35grRHi9H+MFIcJYZ6KGp9wOmKAiFmDReWxNMQjZCk=;
	b=aHVyoi6T7hJHWh2YSmUjQ1vGsE1AMBkPuEduK7lDi4BGe0WnR0NIkYD54cb5rJfAtZYFPv
	7y7jRT6cVCCF+UBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q01t0840;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u7bSIMeG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763623456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t35grRHi9H+MFIcJYZ6KGp9wOmKAiFmDReWxNMQjZCk=;
	b=Q01t0840+PqPTPs7GyCve1BK3ixZ1CqMiEVz5eHsw7uxgV6TClL5TFmyqzN5YSV70TNfRa
	kzUeNHp0y7oY2mrjt1+jD0IjT4AgY/p5Z44vSw0DASgDSTVvYOqXTXD6JuVLqwslhZD2uY
	NigSMh73oxymjL+cnqtNy79kjs25rTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763623456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t35grRHi9H+MFIcJYZ6KGp9wOmKAiFmDReWxNMQjZCk=;
	b=u7bSIMeGCr2fvxOgjnyW0FczhkC4LWoW0ga5nAoHoVi0tVYD38S+WvKtrOCxEg4k6lhdQ6
	CX8EshP+u0t/vKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31D823EA61;
	Thu, 20 Nov 2025 07:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jTfLCSDCHmk6KAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 20 Nov 2025 07:24:16 +0000
Message-ID: <282f7d53-bec9-47b7-8ba8-4efe3248a94f@suse.de>
Date: Thu, 20 Nov 2025 08:24:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-scsi: Fix system suspend for a security
 locked drive
To: Niklas Cassel <cassel@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: Ilia Baryshnikov <qwelias@gmail.com>, stable@vger.kernel.org,
 linux-ide@vger.kernel.org
References: <20251119141313.2220084-3-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251119141313.2220084-3-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7CAB521278
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 11/19/25 15:13, Niklas Cassel wrote:
> Commit cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error() status
> handling") fixed ata_to_sense_error() to properly generate sense key
> ABORTED COMMAND (without any additional sense code), instead of the
> previous bogus sense key ILLEGAL REQUEST with the additional sense code
> UNALIGNED WRITE COMMAND, for a failed command.
> 
> However, this broke suspend for Security locked drives (drives that have
> Security enabled, and have not been Security unlocked by boot firmware).
> 
> The reason for this is that the SCSI disk driver, for the Synchronize
> Cache command only, treats any sense data with sense key ILLEGAL REQUEST
> as a successful command (regardless of ASC / ASCQ).
> 
> After commit cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error()
> status handling") the code that treats any sense data with sense key
> ILLEGAL REQUEST as a successful command is no longer applicable, so the
> command fails, which causes the system suspend to be aborted:
> 
>    sd 1:0:0:0: PM: dpm_run_callback(): scsi_bus_suspend returns -5
>    sd 1:0:0:0: PM: failed to suspend async: error -5
>    PM: Some devices failed to suspend, or early wake event detected
> 
> To make suspend work once again, for a Security locked device only,
> return sense data LOGICAL UNIT ACCESS NOT AUTHORIZED, the actual sense
> data which a real SCSI device would have returned if locked.
> The SCSI disk driver treats this sense data as a successful command.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Ilia Baryshnikov <qwelias@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220704
> Fixes: cf3fc037623c ("ata: libata-scsi: Fix ata_to_sense_error() status handling")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 7 +++++++
>   include/linux/ata.h       | 1 +
>   2 files changed, 8 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

