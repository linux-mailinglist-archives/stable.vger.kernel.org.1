Return-Path: <stable+bounces-254495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ACUEMqZFmq1ngcAu9opvQ
	(envelope-from <stable+bounces-254495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:14:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D813F5E04AA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91833300B463
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C42C221DAE;
	Wed, 27 May 2026 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fmzXCo0B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tG/GQzcf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fmzXCo0B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tG/GQzcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0B3B5847
	for <stable@vger.kernel.org>; Wed, 27 May 2026 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866053; cv=none; b=uVPGJ844E230i0KQ3HgQ0ubKv4cvlEaVSt1pslQmNQkHwO9x5j1KA3qL2+R4bPOKWKll7AfiSfxjrBNasg1yvbvaoYbvcAZg/8eutIjAsuLopTHd03tInxo3J3AZWe/1ic9L4kBfutYm86/KA0kZyoLjdu5CuwjsCUdOgo1AFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866053; c=relaxed/simple;
	bh=qvcDS+0ZZcUcSmH0EXhiL87qB3apltPD6B520dTxjpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czppzT/5TmhFeukvEkHHg4rqwFMwZfNYKV4W0QwCtXCpB7qxstYnyre6tfTqX5q/xRlnoLrRCUspamQhzO5AGbdXaE1cqhxyoHRr313KtHoD3L+zjgs8NkaFwD8DdeYhF7K0CspyiNcrP3acd7LqtJ1CS6Ah2uaBvvS91pssByI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fmzXCo0B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tG/GQzcf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fmzXCo0B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tG/GQzcf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16D0F6B2A5;
	Wed, 27 May 2026 07:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779866050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=;
	b=fmzXCo0Byt9IYnknQYcioyUGk1BXp2/s7S62MysYY8D6xo0ytDCeNhkL/81vPUgUas+XHh
	9oIN79KgO6h/Iw0mfeDcot4ZyS/8lSoXfHKkaB/OfMgzYtBBzAIs0BU4VHnHXxALyEz051
	C8LZEwoB/ZGF1urKBjaAyoXaJzU2kX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779866050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=;
	b=tG/GQzcfuWV0zmNUkGp3xBlUaosMjh/vMv+3eTJ/uOoPAsF70MwqmeHiSfgxtaZqdsFcFk
	ncHjipb0Tcxt2pCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779866050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=;
	b=fmzXCo0Byt9IYnknQYcioyUGk1BXp2/s7S62MysYY8D6xo0ytDCeNhkL/81vPUgUas+XHh
	9oIN79KgO6h/Iw0mfeDcot4ZyS/8lSoXfHKkaB/OfMgzYtBBzAIs0BU4VHnHXxALyEz051
	C8LZEwoB/ZGF1urKBjaAyoXaJzU2kX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779866050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rlc0D+brFLEZzu9MUAeu/fVFuNp+Tp+vKmpJdrfg+pQ=;
	b=tG/GQzcfuWV0zmNUkGp3xBlUaosMjh/vMv+3eTJ/uOoPAsF70MwqmeHiSfgxtaZqdsFcFk
	ncHjipb0Tcxt2pCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 939FA5A6E3;
	Wed, 27 May 2026 07:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I37bIsGZFmpVJwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 27 May 2026 07:14:09 +0000
Message-ID: <7878d133-9324-452d-88f1-c9adaf9364b5@suse.de>
Date: Wed, 27 May 2026 09:14:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: scsi_transport_fc: widen FPIN pname walker
 counter to u32
To: Michael Bommarito <michael.bommarito@gmail.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Nilesh Javali <njavali@marvell.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Shyam Sundar <ssundar@marvell.com>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@kernel.org>, John Meneghini <jmeneghi@redhat.com>,
 Bryan Gurney <bgurney@redhat.com>, Justin Tee <justin.tee@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, David Laight <david.laight.linux@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260519190615.2761667-1-michael.bommarito@gmail.com>
 <20260520133015.1018937-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260520133015.1018937-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254495-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,HansenPartnership.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[marvell.com,oracle.com,broadcom.com,kernel.org,redhat.com,lst.de,gmail.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: D813F5E04AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 15:30, Michael Bommarito wrote:
> An adjacent Fibre Channel fabric actor that can deliver an FPIN ELS
> frame to an lpfc or qla2xxx Linux initiator can trigger a non-return
> in the generic FC transport. This is not a local userspace or IP
> network path; the attacker must be able to inject fabric traffic, for
> example as a compromised switch or fabric controller, or as a same-zone
> N_Port on a fabric that permits source spoofing.
> 
> The Link-Integrity and Peer-Congestion FPIN walkers used a u8 loop
> counter against the 32-bit on-wire pname_count field, and did not bound
> pname_count by the descriptor body already validated by the TLV walker.
> A pname_count of 256 therefore wraps the counter and keeps the loop
> condition true indefinitely.
> 
> Factor the shared pname_list[] walk into one helper, widen the counter
> to u32, and clamp pname_count against the entries that fit in the
> descriptor body before iterating.
> 
> Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Changes in v4:
> - Use min() rather than min_t(u32, ...) for the pname_count clamp and
>    fold away the temporary max_count variable, as David Laight suggested.
> 
> Changes in v3:
> - State the fabric-adjacent threat model explicitly in the commit
>    message and clarify that this is not local userspace or IP-network
>    reachable.
> - Use min_t(u32, ...) for the pname_count clamp, as Christoph suggested.
> - Use FC_TLV_DESC_LENGTH_FROM_SZ() instead of open-coding the descriptor
>    body length calculation.
> - Factor the duplicate LI and peer-congestion pname walker into a common
>    helper while preserving the LI-only host-stat update.
> 
> Changes in v2:
> - Drop the redundant cover letter shipped with v1.  A single-patch send
>    does not need one, and the v1 cover carried stale draft markers.
> 
>   drivers/scsi/scsi_transport_fc.c | 77 +++++++++++++++++---------------
>   1 file changed, 41 insertions(+), 36 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

