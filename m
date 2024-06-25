Return-Path: <stable+bounces-55140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBFC915ECB
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034F91F230CB
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 06:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE7C145FE4;
	Tue, 25 Jun 2024 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="akwTeQPT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="prVLv3hW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="akwTeQPT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="prVLv3hW"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF713A416;
	Tue, 25 Jun 2024 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296380; cv=none; b=HEIxub3bdK1PQw9i+n7Vz/JHkvbPfjLg1px7x4jmR3ZOK+r0yWPy4KqNKJaWWWXpBcrVmCr3uwESgadzpSnAgVWyLblrjxrxq881xrfl8jZg7aFE2JcLggfZb5oZCLfaIbsBneApz2np4FCn3fbAY55I9OJD/kKSZ9+dlVlAlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296380; c=relaxed/simple;
	bh=msRoBibW4fqIvLPDck5BFgKWyJm9F3UElLNz3bzP4i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiak84dvh2p2Dp5ZXLHGDQou6N5SgVtpXI3dNtNyPNfN2fPLJGWD09BlZbiZHBIOpGOG7pBWCVwQma3P0KdKegzJaAK4+LBJZ3o88jg2xh3ADrIdKw2FfaXU5UxmdUEj4l8dRGUAUNAD8yXuA2ISvnDtrWLtaovBLolg5ZYl5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=akwTeQPT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=prVLv3hW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=akwTeQPT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=prVLv3hW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1FF01F84F;
	Tue, 25 Jun 2024 06:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5e0/4cJzzROCJLbTOZ3ywMCSw35ZD3sbRO990xPbywI=;
	b=akwTeQPTuw7/0gPxtBUnfRppm1J/2br1+zBSU9XcCeb9OrJ9eFHnT81AxAoOflaEB+VV3U
	oqtF3rrFjDGP3ncezN1aLUT8FbsMGsDBesPA2mctF30RHqAj2rKMXTvBBWJCEA6C+pZvlK
	hD/C/6pxubcgKGoYa3JP5E5AbPBhA3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5e0/4cJzzROCJLbTOZ3ywMCSw35ZD3sbRO990xPbywI=;
	b=prVLv3hWuzXZCunXhgLV59FCUUfmRBWDBvtKSuxLm3Vqi+ru3gmfFYfSJyq2Uy3MxVtEN1
	jMfTPe45/UWyPrCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=akwTeQPT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=prVLv3hW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5e0/4cJzzROCJLbTOZ3ywMCSw35ZD3sbRO990xPbywI=;
	b=akwTeQPTuw7/0gPxtBUnfRppm1J/2br1+zBSU9XcCeb9OrJ9eFHnT81AxAoOflaEB+VV3U
	oqtF3rrFjDGP3ncezN1aLUT8FbsMGsDBesPA2mctF30RHqAj2rKMXTvBBWJCEA6C+pZvlK
	hD/C/6pxubcgKGoYa3JP5E5AbPBhA3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296372;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5e0/4cJzzROCJLbTOZ3ywMCSw35ZD3sbRO990xPbywI=;
	b=prVLv3hWuzXZCunXhgLV59FCUUfmRBWDBvtKSuxLm3Vqi+ru3gmfFYfSJyq2Uy3MxVtEN1
	jMfTPe45/UWyPrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F7B713A9A;
	Tue, 25 Jun 2024 06:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v7iTD3Rhema2CgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Jun 2024 06:19:32 +0000
Message-ID: <d51930d9-c0c8-4d0b-8131-bce278c24db8@suse.de>
Date: Tue, 25 Jun 2024 08:19:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-2-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240624221211.2593736-2-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C1FF01F84F
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spam-Level: 

On 6/25/24 00:12, Igor Pylypiv wrote:
> Current ata_gen_passthru_sense() code performs two actions:
> 1. Generates sense data based on the ATA 'status' and ATA 'error' fields.
> 2. Populates "ATA Status Return sense data descriptor" / "Fixed format
>     sense data" with ATA taskfile fields.
> 
> The problem is that #1 generates sense data even when a valid sense data
> is already present (ATA_QCFLAG_SENSE_VALID is set). Factoring out #2 into
> a separate function allows us to generate sense data only when there is
> no valid sense data (ATA_QCFLAG_SENSE_VALID is not set).
> 
> As a bonus, we can now delete a FIXME comment in atapi_qc_complete()
> which states that we don't want to translate taskfile registers into
> sense descriptors for ATAPI.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libata-scsi.c | 158 +++++++++++++++++++++-----------------
>   1 file changed, 86 insertions(+), 72 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


