Return-Path: <stable+bounces-223227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLeoONeiqWl5BQEAu9opvQ
	(envelope-from <stable+bounces-223227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:35:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DCD2149F7
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C882A30C692F
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA943C1996;
	Thu,  5 Mar 2026 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x5HxRSh+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sVb14N8i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x5HxRSh+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sVb14N8i"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67A3C277B
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724906; cv=none; b=i+7bdV4fnESIIOvZnOMlYZOysEF5kDV5CFaD8POTBV4GOTgr1muUb6OFka00Fef2NqDWJUC7TdtKpjZm4C8OgX+QQkrzezSwD+geseku0+f2ZdygN2Zz+FhYBARo3I4hWfaa2O2fJLCiXrrmloYng99olHmYGrUewLYdq5ULjxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724906; c=relaxed/simple;
	bh=iPMsiVLWbKvFZDcIjAnjNJDRTfm5+W1JxTz7elaDtdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oM/8EF/a48E7XW1EWgEyn8w7TItwu0+aNLMxUWFaDQiFDNXAeVIWn29IX184qdjzyeFLmd7MyKGqJdHO0KcuqhgdXS7cyFrNkpyFqaB4K4RGG0Gxbajbp5GSo6YWped0xH7D7Soe83diM2crrTq5PbWZC6RX5V4Hnk9DCyqWK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x5HxRSh+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sVb14N8i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x5HxRSh+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sVb14N8i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A19ED5BCF7;
	Thu,  5 Mar 2026 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772724901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTaBFZvMdyBZN0Q1KNvkXqRaPXfXE5I6oYxLEYEJ/qA=;
	b=x5HxRSh+LfUNmGRcT7/jACy8M26QIbS/dks7yNWiYcuPfgMXHSDubr1Vj7jtQZmOH88d9j
	kYMAwjXl7iRKGGmrFmUcDsZtnuxIGHQxxiUP83PjU8dieXkTisWAUGo2ZYDCvwxtzayXWu
	z5RvVMPg0NJEJ1n3D/W3AeUBCxfAxP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772724901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTaBFZvMdyBZN0Q1KNvkXqRaPXfXE5I6oYxLEYEJ/qA=;
	b=sVb14N8ix5T6/3MwAtgpstG52+GwmIGo3ihBxf0pOopUYdZKtIb+BEeHjnSevp2C5Z/NZI
	rhQcdF3IC9doU+DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772724901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTaBFZvMdyBZN0Q1KNvkXqRaPXfXE5I6oYxLEYEJ/qA=;
	b=x5HxRSh+LfUNmGRcT7/jACy8M26QIbS/dks7yNWiYcuPfgMXHSDubr1Vj7jtQZmOH88d9j
	kYMAwjXl7iRKGGmrFmUcDsZtnuxIGHQxxiUP83PjU8dieXkTisWAUGo2ZYDCvwxtzayXWu
	z5RvVMPg0NJEJ1n3D/W3AeUBCxfAxP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772724901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTaBFZvMdyBZN0Q1KNvkXqRaPXfXE5I6oYxLEYEJ/qA=;
	b=sVb14N8ix5T6/3MwAtgpstG52+GwmIGo3ihBxf0pOopUYdZKtIb+BEeHjnSevp2C5Z/NZI
	rhQcdF3IC9doU+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B16A3EA68;
	Thu,  5 Mar 2026 15:35:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 17c2IaWiqWn5OwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 05 Mar 2026 15:35:01 +0000
Message-ID: <300ae0df-304b-45cc-9553-5a0735134a32@suse.de>
Date: Thu, 5 Mar 2026 16:35:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata-core: Add BRIDGE_OK quirk for QEMU drives
To: Pedro Falcato <pfalcato@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260305145312.1081112-1-pfalcato@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260305145312.1081112-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -8.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 57DCD2149F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223227-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

On 3/5/26 15:53, Pedro Falcato wrote:
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
> ---
>   drivers/ata/libata-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d61846f03edc..c57e35ccc092 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4231,6 +4231,7 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
>   	/* Devices that do not need bridging limits applied */
>   	{ "MTRON MSP-SATA*",		NULL,	ATA_QUIRK_BRIDGE_OK },
>   	{ "BUFFALO HD-QSU2/R5",		NULL,	ATA_QUIRK_BRIDGE_OK },
> +	{ "QEMU HARDDISK",		"2.5+",	ATA_QUIRK_BRIDGE_OK },
>   
>   	/* Devices which aren't very happy with higher link speeds */
>   	{ "WD My Book",			NULL,	ATA_QUIRK_1_5_GBPS },

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

