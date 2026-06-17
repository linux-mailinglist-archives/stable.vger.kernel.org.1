Return-Path: <stable+bounces-266882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jyD5C0DqMmoO7gUAu9opvQ
	(envelope-from <stable+bounces-266882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 20:41:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA29D69BFA4
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 20:41:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cLmMSbjr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hQFvr5xF;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cLmMSbjr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hQFvr5xF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266882-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266882-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FEE0301FF14
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45237646B;
	Wed, 17 Jun 2026 18:41:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2812F6920
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:40:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721662; cv=none; b=an8KD1wiyDb4ICo12kqdrXmvUodWDTYtoVbq/klXclQYP4xxkYT3X0++P4ZBYCfDwz+qVCSIhQxA0TpuHo46h4VYz0OTdGE0+kbGdpjm48/lrM97yOehCmlI23GiqwsE2ck5T8BwRfFkeDhus+lTokaSApmpQRdpdL4s0bCOXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721662; c=relaxed/simple;
	bh=sHFBc5RzYGiZ/Y9cGYkZBnDpqDecWaZRKLQm93DNmF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTVeVXcRu04wmCZeCh/nHYBFgIq8W2tbsQylNb9WNMrPxzDvMJeWpu5ouVh6iAVkPE71HBm2r5pSxs0rF/WmmVydMYXT5wjaCj210h7lzRCLy5LrkSy3yseD+7c+Oj8/5jfpybspCGf3mbuaUyNLmV7hxoJ8wbhI+ZGZIoP1gGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cLmMSbjr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQFvr5xF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cLmMSbjr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQFvr5xF; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52BF875E83;
	Wed, 17 Jun 2026 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781721658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZbq6J0hSGr8udLOZpoMOaG0budeZVJWDyq3+j2KID0=;
	b=cLmMSbjr6y5+Osu23p3SM3Jy9GoYUH0DIhVs6FH0vRxGmfKNOXe+JkE5AsP1Y3UQgW5i8E
	FP9ztmDQ9AesZlzhz4zDK1sZPUvt9X0wlFfdIk6UBVyZjeEVbq4ZSatZC9hgCijhscgUbc
	y8oU6hRgELa71fJOsLDzLiOue55HZvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781721658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZbq6J0hSGr8udLOZpoMOaG0budeZVJWDyq3+j2KID0=;
	b=hQFvr5xFOFqH/WFTX45SGMrIBW8CRm+529NubsHnOPzRsgMLmIzLSmGOnO5SEPJZDPTBQW
	gkISzLpTab85aBCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781721658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZbq6J0hSGr8udLOZpoMOaG0budeZVJWDyq3+j2KID0=;
	b=cLmMSbjr6y5+Osu23p3SM3Jy9GoYUH0DIhVs6FH0vRxGmfKNOXe+JkE5AsP1Y3UQgW5i8E
	FP9ztmDQ9AesZlzhz4zDK1sZPUvt9X0wlFfdIk6UBVyZjeEVbq4ZSatZC9hgCijhscgUbc
	y8oU6hRgELa71fJOsLDzLiOue55HZvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781721658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZbq6J0hSGr8udLOZpoMOaG0budeZVJWDyq3+j2KID0=;
	b=hQFvr5xFOFqH/WFTX45SGMrIBW8CRm+529NubsHnOPzRsgMLmIzLSmGOnO5SEPJZDPTBQW
	gkISzLpTab85aBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 155A2779A8;
	Wed, 17 Jun 2026 18:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P76GNTnqMmpuGwAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 17 Jun 2026 18:40:57 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, io-uring@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.18.y] io_uring/net: Avoid msghdr on
 op_connect/op_bind async data
In-Reply-To: <2026061727-thirsty-sculptor-1e6f@gregkh>
References: <20260617175102.2976716-1-krisman@suse.de>
 <2026061727-thirsty-sculptor-1e6f@gregkh>
Date: Wed, 17 Jun 2026 14:40:56 -0400
Message-ID: <87zf0tdn7r.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:io-uring@vger.kernel.org,m:axboe@kernel.dk,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266882-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[krisman@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krisman@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA29D69BFA4

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Jun 17, 2026 at 01:51:02PM -0400, Gabriel Krisman Bertazi wrote:
>> [ Upstream commit 3979840cd858f30f43ea9f4e7f7f1f56de82d698 ]
>> This fixes a memory leak due to the lack of the cleanup hook for the
>> iovec.  The stable backport differs from upstream by dropping the
>> io_connect_bpf_populate hunk, which didn't exist at the time and by
>> fixing the merge conflict due to the introduction of
>> io_bind_file_create.
>> 
>> Both IORING_OP_CONNECT and IORING_OP_BIND reuse the msghdr object just
>> to store the sockaddr. Beyond allocating a much larger object than
>> needed, msghdr can also wrap an iovec, which will be recycled
>> unnecessarily. This uses the sockaddr directly.
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> Link: https://patch.msgid.link/20260602215327.1885109-2-krisman@suse.de
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> ---
>>  io_uring/net.c   | 36 ++++++++++++++++++------------------
>>  io_uring/opdef.c |  4 ++--
>>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> This isn't in any release yet?

It is queued in Linus tree during the current merge window for 7.2

>  why just 6.18?

The backports are slightly different, so they were sent separately. The bug
exists since 6.12.

> And why wan't it
> originally tagged for stable?

Because it was originally a clean up that we later realized fixes a bug
and should go to stable.

> thanks,
>
> greg k-h

-- 
Gabriel Krisman Bertazi

