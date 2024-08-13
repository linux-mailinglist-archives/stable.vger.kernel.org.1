Return-Path: <stable+bounces-67426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CAF94FDF0
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 08:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F52C1F22D71
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 06:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CE84207D;
	Tue, 13 Aug 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GowQ6281";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NuvAkG0M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GowQ6281";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NuvAkG0M"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06C446AC;
	Tue, 13 Aug 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531067; cv=none; b=tVLS4bZRIO/8gcpNAvHReLaohbFlHnQ8Ybr3K24xoOa5cp4ZqULWxKVhN3/c74t9oviE7OUODn57/vi+Ie8Rx876QS9Og/Z7VVcWuhUxxymSStXsTPdRv7KPldExcmkJdhaAj7EGOVlAA2VNlfj0tvHpj79BjQj+mNBacIDk3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531067; c=relaxed/simple;
	bh=QHR9RFxhpBK0vD9dN13r8p1jl/KFtC86FRnfcArIgr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anewoiYDJcs8zYLcFZgc5b5rIL7hZ0Z6WpvVp/DbDGj0jo51j/ijC4ndMw1ywfs6eMaYs3sF9jzN0o5EFGK8wkYGJXuQSVqMiKcXCerXEhI37TOg+yLiPIF1s59quStvVjC/JbMwWWydDHuKNaITdbQOKDERj1Eo3STCO7yFxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GowQ6281; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NuvAkG0M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GowQ6281; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NuvAkG0M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A50292271D;
	Tue, 13 Aug 2024 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723531063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtcsQP50M+SyqiRobCTEbdbc8sXyaH7I1S6C1UBBr88=;
	b=GowQ6281RwEl7DBBHsoFTg+5l+tPwC1HU8DIVx0lgVJYdl5pH8X9t/nCR1G2QMtXFpc7uw
	6SLR10F0B+d8NJuvU58q+wRWp/BO8Rzw87WrLYtITHcqa9YOTzVdbycTT0DVE4UzksKBwO
	0CRVY2qgN0O8hAw4PIjRgXPeBnlI784=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723531063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtcsQP50M+SyqiRobCTEbdbc8sXyaH7I1S6C1UBBr88=;
	b=NuvAkG0MLyEeL5WK8AhRl+kHToAOgEPKq31Q3OadNDkfrNnCvZyfe2SPTL4QFlzmf4HR3m
	OrQoZX7/+yEvekDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723531063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtcsQP50M+SyqiRobCTEbdbc8sXyaH7I1S6C1UBBr88=;
	b=GowQ6281RwEl7DBBHsoFTg+5l+tPwC1HU8DIVx0lgVJYdl5pH8X9t/nCR1G2QMtXFpc7uw
	6SLR10F0B+d8NJuvU58q+wRWp/BO8Rzw87WrLYtITHcqa9YOTzVdbycTT0DVE4UzksKBwO
	0CRVY2qgN0O8hAw4PIjRgXPeBnlI784=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723531063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VtcsQP50M+SyqiRobCTEbdbc8sXyaH7I1S6C1UBBr88=;
	b=NuvAkG0MLyEeL5WK8AhRl+kHToAOgEPKq31Q3OadNDkfrNnCvZyfe2SPTL4QFlzmf4HR3m
	OrQoZX7/+yEvekDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68E4713983;
	Tue, 13 Aug 2024 06:37:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j3d0Fzf/umb0EwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Aug 2024 06:37:43 +0000
Message-ID: <3d3beb8d-4c93-4eef-b3ee-c92eb9df9009@suse.de>
Date: Tue, 13 Aug 2024 08:37:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Return sense data in descriptor format
 by default
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Igor Pylypiv <ipylypiv@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 stable@vger.kernel.org, Stephan Eisvogel <eisvogel@seitics.de>,
 Christian Heusel <christian@heusel.eu>, linux-ide@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20240812151517.1162241-2-cassel@kernel.org>
 <ZrpXu_vfI-wpCFVc@ryzen.lan>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZrpXu_vfI-wpCFVc@ryzen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/12/24 20:43, Niklas Cassel wrote:
> On Mon, Aug 12, 2024 at 05:15:18PM +0200, Niklas Cassel wrote:
>> Sense data can be in either fixed format or descriptor format.
>>
>> SAT-6 revision 1, 10.4.6 Control mode page, says that if the D_SENSE bit
>> is set to zero (i.e., fixed format sense data), then the SATL should
>> return fixed format sense data for ATA PASS-THROUGH commands.
>>
>> A lot of user space programs incorrectly assume that the sense data is in
>> descriptor format, without checking the RESPONSE CODE field of the
>> returned sense data (to see which format the sense data is in).
>>
>> The libata SATL has always kept D_SENSE set to zero by default.
>> (It is however possible to change the value using a MODE SELECT command.)
>>
>> For failed ATA PASS-THROUGH commands, we correctly generated sense data
>> according to the D_SENSE bit. However, because of a bug, sense data for
>> successful ATA PASS-THROUGH commands was always generated in the
>> descriptor format.
>>
>> This was fixed to consistently respect D_SENSE for both failed and
>> successful ATA PASS-THROUGH commands in commit 28ab9769117c ("ata:
>> libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error").
>>
>> After commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for
>> CK_COND=1 and no error"), we started receiving bug reports that we broke
>> these user space programs (these user space programs must never have
>> encountered a failing command, as the sense data for failing commands has
>> always correctly respected D_SENSE, which by default meant fixed format).
>>
>> Since a lot of user space programs seem to assume that the sense data is
>> in descriptor format (without checking the type), let's simply change the
>> default to have D_SENSE set to one by default.
>>
>> That way:
>> -Broken user space programs will see no regression.
>> -Both failed and successful ATA PASS-THROUGH commands will respect D_SENSE,
>>   as per SAT-6 revision 1.
>> -Apparently it seems way more common for user space applications to assume
>>   that the sense data is in descriptor format, rather than fixed format.
>>   (A user space program should of course support both, and check the
>>   RESPONSE CODE field to see which format the returned sense data is in.)
>>
>> Cc: stable@vger.kernel.org # 4.19+
>> Reported-by: Stephan Eisvogel <eisvogel@seitics.de>
>> Reported-by: Christian Heusel <christian@heusel.eu>
>> Closes: https://lore.kernel.org/linux-ide/0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu/
>> Fixes: 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>>   drivers/ata/libata-core.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index c7752dc80028..590bebe1354d 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -5368,6 +5368,13 @@ void ata_dev_init(struct ata_device *dev)
>>   	 */
>>   	spin_lock_irqsave(ap->lock, flags);
>>   	dev->flags &= ~ATA_DFLAG_INIT_MASK;
>> +
>> +	/*
>> +	 * A lot of user space programs incorrectly assume that the sense data
>> +	 * is in descriptor format, without checking the RESPONSE CODE field of
>> +	 * the returned sense data (to see which format the sense data is in).
>> +	 */
>> +	dev->flags |= ATA_DFLAG_D_SENSE;
>>   	dev->horkage = 0;
>>   	spin_unlock_irqrestore(ap->lock, flags);
>>   
>> -- 
>> 2.46.0
>>
> 
> This patch will change so that the sense data will be generated in descriptor
> format (by default) for passthrough (SG_IO) commands, not just SG_IO ATA
> PASS-THROUGH commands.
> 
> Non-passthrough (SG_IO) commands are not relavant, as they will go via
> scsi_finish_command(), which calls scsi_normalize_sense() before interpreting
> the sense data, and for non-passthrough commands, the sense data is not
> propagated to the user. (The SK/ASC/ASCQ is only printed to the log, and this
> print will be the same as before.)
> 
> However, it is possible to send any command as passthrough (SG_IO), not only
> ATA PASS-THROUGH (ATA-16 / ATA-12 commands).
> 
> So there will be a difference (by default) for SG_IO (passthrough) commands
> that are not ATA PASS-THROUGH commands (ATA-16 / ATA-12 commands).
> (E.g. if you send a regular SCSI read/write command via SG_IO to an ATA device,
> and if that command generates sense data, the default sense data format would
> be different.)
> 
> Is this a concern?
> 
> I have a feeling that some user space program that blindly assumes that the
> sense data will be in fixed format (for e.g. a command that does an invalid
> read) using SG_IO will start to complain because of a "regression".
> 
I really hate it when people start generalising which in fact was an 
occurrence with a single program, namely hdparm.

Which indeed is ancient, and I'm only slightly surprised that things
broke here.

But all other programs I know of do attempt to handle sense codes, so
really I don't have an issue with this change.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


