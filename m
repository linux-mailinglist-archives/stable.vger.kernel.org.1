Return-Path: <stable+bounces-55141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F37915ED5
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396E01F22F2B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 06:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0711E145FEA;
	Tue, 25 Jun 2024 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="esAn6VFa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MrshfLZQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="esAn6VFa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MrshfLZQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E76145FE1;
	Tue, 25 Jun 2024 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296521; cv=none; b=LEsguUK/Sq5ctvsG3xbQgXc/ImktY3+hfliwfWlWlukCM4qNWokfRTbZwrpkLrnTRQlrXfDx4TrWzh5GZ6UU0ZuAoMLbiwinLEzIjQJ5Gp2NuUqlmTXj49lKPjrrDXvkN4xVlZKfgePRzxdpcEVtYV5p4HJex9WnSf3tmfWWMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296521; c=relaxed/simple;
	bh=I9zGYGgNQDc3Reqy8lnnKV2YDhG7u8GfKZ6NOKlg6JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLClqqB3GIYR52bJxeUDD3Fwyy9rXgO4wN0Ud3h8Ta4a+0o2Jr3LrV/4Bcmt5lOAo6451hiiIzLxODQGah2h4ZHrpXzHR6yOGX9Q+XwSbCqlP87OCt+S9oCJ3vqouAtnVf3iKFBY1CY6B7Zpe1nGIuuZQr4Fd5veIyrM4MM369U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=esAn6VFa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MrshfLZQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=esAn6VFa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MrshfLZQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45BB5219C5;
	Tue, 25 Jun 2024 06:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnWPXm3IUsDRXs8qz97hr52ZPmx+7AttsquiXD4RsxY=;
	b=esAn6VFaoYw94USSCGwlxdeuD+3JVCS6SCXGTv+UJoGkaL+Anpou9xnVhpkVKLmBuao1bY
	YqHN9TBUv7kVptxV9dgZxSP1WuMQ1dTECaeOABwHMOJjTIT3Mw17GTBrHkG9Va82x6ZP36
	3/XPDJB1MesfGFQoOF2fgqqpQSAo/Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnWPXm3IUsDRXs8qz97hr52ZPmx+7AttsquiXD4RsxY=;
	b=MrshfLZQxe6aH9jDGs5mJh5+w74GXi4XStKchmhQf4YDtAaZC7L8tIK+MeHayUdPXq0erP
	qO5oIeNyUJTSbMDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719296517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnWPXm3IUsDRXs8qz97hr52ZPmx+7AttsquiXD4RsxY=;
	b=esAn6VFaoYw94USSCGwlxdeuD+3JVCS6SCXGTv+UJoGkaL+Anpou9xnVhpkVKLmBuao1bY
	YqHN9TBUv7kVptxV9dgZxSP1WuMQ1dTECaeOABwHMOJjTIT3Mw17GTBrHkG9Va82x6ZP36
	3/XPDJB1MesfGFQoOF2fgqqpQSAo/Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719296517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WnWPXm3IUsDRXs8qz97hr52ZPmx+7AttsquiXD4RsxY=;
	b=MrshfLZQxe6aH9jDGs5mJh5+w74GXi4XStKchmhQf4YDtAaZC7L8tIK+MeHayUdPXq0erP
	qO5oIeNyUJTSbMDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52CB01384C;
	Tue, 25 Jun 2024 06:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f+cdEARiemZ5CwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Jun 2024 06:21:56 +0000
Message-ID: <73dc7b9f-4e2b-4b51-b58a-d54779ad529d@suse.de>
Date: Tue, 25 Jun 2024 08:21:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] ata: libata-scsi: Fix offsets for the fixed format
 sense data
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akshat Jain <akshatzen@google.com>, stable@vger.kernel.org
References: <20240624221211.2593736-1-ipylypiv@google.com>
 <20240624221211.2593736-3-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240624221211.2593736-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On 6/25/24 00:12, Igor Pylypiv wrote:
> Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
> to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
> indicate that the INFORMATION field contains valid information.
> 
> INFORMATION
> ===========
> 
> SAT-5 Table 212 — "Fixed format sense data INFORMATION field for the ATA
> PASS-THROUGH commands" defines the following format:
> 
> +------+------------+
> | Byte |   Field    |
> +------+------------+
> |    0 | ERROR      |
> |    1 | STATUS     |
> |    2 | DEVICE     |
> |    3 | COUNT(7:0) |
> +------+------------+
> 
> SPC-6 Table 48 - "Fixed format sense data" specifies that the INFORMATION
> field starts at byte 3 in sense buffer resulting in the following offsets
> for the ATA PASS-THROUGH commands:
> 
> +------------+-------------------------+
> |   Field    |  Offset in sense buffer |
> +------------+-------------------------+
> | ERROR      |  3                      |
> | STATUS     |  4                      |
> | DEVICE     |  5                      |
> | COUNT(7:0) |  6                      |
> +------------+-------------------------+
> 
> COMMAND-SPECIFIC INFORMATION
> ============================
> 
> SAT-5 Table 213 - "Fixed format sense data COMMAND-SPECIFIC INFORMATION
> field for ATA PASS-THROUGH" defines the following format:
> 
> +------+-------------------+
> | Byte |        Field      |
> +------+-------------------+
> |    0 | FLAGS | LOG INDEX |
> |    1 | LBA (7:0)         |
> |    2 | LBA (15:8)        |
> |    3 | LBA (23:16)       |
> +------+-------------------+
> 
> SPC-6 Table 48 - "Fixed format sense data" specifies that
> the COMMAND-SPECIFIC-INFORMATION field starts at byte 8
> in sense buffer resulting in the following offsets for
> the ATA PASS-THROUGH commands:
> 
> Offsets of these fields in the fixed sense format are as follows:
> 
> +-------------------+-------------------------+
> |       Field       |  Offset in sense buffer |
> +-------------------+-------------------------+
> | FLAGS | LOG INDEX |  8                      |
> | LBA (7:0)         |  9                      |
> | LBA (15:8)        |  10                     |
> | LBA (23:16)       |  11                     |
> +-------------------+-------------------------+
> 
> Reported-by: Akshat Jain <akshatzen@google.com>
> Fixes: 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense")
> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


