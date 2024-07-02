Return-Path: <stable+bounces-56314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A091EEB5
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 08:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A022847C5
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 06:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4F74CB23;
	Tue,  2 Jul 2024 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ia6Wdthh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QNbMJsVZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ia6Wdthh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QNbMJsVZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6066A342;
	Tue,  2 Jul 2024 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719900156; cv=none; b=e+uK60TUSCIGztcHPQDjBDQRdJ0ETBuhJCcybxze/+9l7y6UKNsfeEUVRFnMJJ1vLybOcEV5V8bcRPP6Sn2kxHeiyHli2aFhYhmw9wNvjHZ89O4bNVltZkiOBlMowF01PTWEMmKnwKwxMsnRyWVqQtPY1hOaJT2ItNhsLSwYmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719900156; c=relaxed/simple;
	bh=kGvkyIJchibKQwsRixensZtOji8fEHU+wBr15WUN4rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlV8JLXaiZj9PUKgTGS19olg00dKPmfYy5crQAgx72aC84PYNRViA7071i+/wari104GqIgZiJEKOa898NG+Pa0C9xgZLkabqMVzXKjPZ7jadA6SIKKQzrXAsLICHD+ds3jVhzEAGoiae3N7uu4T4NPP+kwb73zfzgiDOBIi8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ia6Wdthh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QNbMJsVZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ia6Wdthh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QNbMJsVZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA1A11FB84;
	Tue,  2 Jul 2024 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719900136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCyFo7qTaIUmUWUVVm7e2zEuFe/h+LUUA4eXNYgfnWE=;
	b=ia6WdthhZxnuf0zzE8iw3tHplSmY+zsIsUR/hgKA+vxPH2FNKAYOrC9yX0M+YIj5/cJ18t
	8zGyXziKILCqOCTpQxIUSbfw/o+7pzMhe2XyQhXzekK7WyUxCdJRknSCBr1hPyQzOA12Kf
	nXLdtdcpCN7ey+xvOj3sv2Xg4P2wRrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719900136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCyFo7qTaIUmUWUVVm7e2zEuFe/h+LUUA4eXNYgfnWE=;
	b=QNbMJsVZnqU3O+ZLbWky7BRI6nwiOkQZl5v1Zo6N6/E+VRKAio3/JuRt+00nMeaKT7OlSq
	MGxyg5sAkwWoJkAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ia6Wdthh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QNbMJsVZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719900136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCyFo7qTaIUmUWUVVm7e2zEuFe/h+LUUA4eXNYgfnWE=;
	b=ia6WdthhZxnuf0zzE8iw3tHplSmY+zsIsUR/hgKA+vxPH2FNKAYOrC9yX0M+YIj5/cJ18t
	8zGyXziKILCqOCTpQxIUSbfw/o+7pzMhe2XyQhXzekK7WyUxCdJRknSCBr1hPyQzOA12Kf
	nXLdtdcpCN7ey+xvOj3sv2Xg4P2wRrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719900136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCyFo7qTaIUmUWUVVm7e2zEuFe/h+LUUA4eXNYgfnWE=;
	b=QNbMJsVZnqU3O+ZLbWky7BRI6nwiOkQZl5v1Zo6N6/E+VRKAio3/JuRt+00nMeaKT7OlSq
	MGxyg5sAkwWoJkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12ACA13A9A;
	Tue,  2 Jul 2024 06:02:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gl/fN+eXg2YmagAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Jul 2024 06:02:15 +0000
Message-ID: <a78246f8-635f-4718-8190-5147a03495ea@suse.de>
Date: Tue, 2 Jul 2024 08:02:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] ata: libata-scsi: Honor the D_SENSE bit for
 CK_COND=1 and no error
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240702024735.1152293-1-ipylypiv@google.com>
 <20240702024735.1152293-4-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240702024735.1152293-4-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AA1A11FB84
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 7/2/24 04:47, Igor Pylypiv wrote:
> SAT-5 revision 8 specification removed the text about the ANSI INCITS
> 431-2007 compliance which was requiring SCSI/ATA Translation (SAT) to
> return descriptor format sense data for the ATA PASS-THROUGH commands
> regardless of the setting of the D_SENSE bit.
> 
> Let's honor the D_SENSE bit for ATA PASS-THROUGH commands while
> generating the "ATA PASS-THROUGH INFORMATION AVAILABLE" sense data.
> 
> SAT-5 revision 7
> ================
> 
> 12.2.2.8 Fixed format sense data
> 
> Table 212 shows the fields returned in the fixed format sense data
> (see SPC-5) for ATA PASS-THROUGH commands. SATLs compliant with ANSI
> INCITS 431-2007, SCSI/ATA Translation (SAT) return descriptor format
> sense data for the ATA PASS-THROUGH commands regardless of the setting
> of the D_SENSE bit.
> 
> SAT-5 revision 8
> ================
> 
> 12.2.2.8 Fixed format sense data
> 
> Table 211 shows the fields returned in the fixed format sense data
> (see SPC-5) for ATA PASS-THROUGH commands.
> 
> Cc: stable@vger.kernel.org # 4.19+
> Reported-by: Niklas Cassel <cassel@kernel.org>
> Closes: https://lore.kernel.org/linux-ide/Zn1WUhmLglM4iais@ryzen.lan
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libata-scsi.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index b59cbb5ce5a6..076fbeadce01 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -941,11 +941,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
>   				   &sense_key, &asc, &ascq);
>   		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
>   	} else {
> -		/*
> -		 * ATA PASS-THROUGH INFORMATION AVAILABLE
> -		 * Always in descriptor format sense.
> -		 */
> -		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
> +		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
> +		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
>   	}
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


