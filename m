Return-Path: <stable+bounces-268275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CIqDOJPKPGqysAgAu9opvQ
	(envelope-from <stable+bounces-268275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:28:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873946C3061
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:28:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SH6GH3ng;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HnGwcIOc;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SH6GH3ng;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HnGwcIOc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268275-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268275-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1AA303AF33
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 06:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEFB3C0A06;
	Thu, 25 Jun 2026 06:28:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7C361DB8
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:28:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782368904; cv=none; b=hKaDkv3V3arycCGqTpBmbwgd+8rKOttAMMBiuHKXaC/N8ornSNtSztJ4tKISGNd2GLIiPfNL9JZ4XlsnFOZaYAASQI7cAJpC+Y/mp7gw2ohfpf+q1izaBoee0TscZw4WUhfRXxzeS98j9h46fKDtLoJRRE6hyWY6wpEA1q/7Z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782368904; c=relaxed/simple;
	bh=0M9b9MEPq1z/kXNItE5PRl014Mi6+b1gzm92Rcg6eJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbzxvFzjdZf7nbM2oIMUH9Adh36qo3K6jO06lFGdnLD4qUUasv4CcFTE02V/nb/nIX8HPhhPCxWbP5TDyv8+eUus1yLl8OX2abLWPB6hj4zHxg7kM4DKvk2KjbT6ZKIXa3vLLVxfANgqeAne3BY9cap4Zd/uUIDPO3pFQQ6hZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SH6GH3ng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HnGwcIOc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SH6GH3ng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HnGwcIOc; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 680F375D61;
	Thu, 25 Jun 2026 06:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782368901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqyRnCdWwD5/GhVDobjbRRcNZYuZHaOkqJjnDII62Dk=;
	b=SH6GH3ng03EIq1CoU5ah4tXsJtUzLoksHndIMu2mK5MeTxAODmSYagJjmYIgfpvOTbHAWJ
	NBdLZYXyiBy136pW5XYR0ASVLRwe+LulHJjsLbWxwpzPS/6csunCyjZCjpLGsKEk8r5it6
	/jVxs2YcNejROzCqIMBGNCIxW5wiPsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782368901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqyRnCdWwD5/GhVDobjbRRcNZYuZHaOkqJjnDII62Dk=;
	b=HnGwcIOcIz3W16xC7aIKe2+P2MZLOPimFzZ8m1wmEBEuIBegYP89DN+cxLUcR4nrR0WSty
	byVX+1YuB7kRgCCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782368901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqyRnCdWwD5/GhVDobjbRRcNZYuZHaOkqJjnDII62Dk=;
	b=SH6GH3ng03EIq1CoU5ah4tXsJtUzLoksHndIMu2mK5MeTxAODmSYagJjmYIgfpvOTbHAWJ
	NBdLZYXyiBy136pW5XYR0ASVLRwe+LulHJjsLbWxwpzPS/6csunCyjZCjpLGsKEk8r5it6
	/jVxs2YcNejROzCqIMBGNCIxW5wiPsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782368901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqyRnCdWwD5/GhVDobjbRRcNZYuZHaOkqJjnDII62Dk=;
	b=HnGwcIOcIz3W16xC7aIKe2+P2MZLOPimFzZ8m1wmEBEuIBegYP89DN+cxLUcR4nrR0WSty
	byVX+1YuB7kRgCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BF4C779A8;
	Thu, 25 Jun 2026 06:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LwzuAIXKPGqTRwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 25 Jun 2026 06:28:21 +0000
Message-ID: <e49bf04f-2004-4ff8-995f-6a17a54b57fa@suse.de>
Date: Thu, 25 Jun 2026 08:28:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] block: validate user space vectors during
 extraction
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: dm-devel@lists.linux.dev, hch@lst.de, axboe@kernel.dk,
 brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
 Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org
References: <20260624170905.3972095-1-kbusch@meta.com>
 <20260624170905.3972095-6-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260624170905.3972095-6-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268275-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kbusch@meta.com,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:dm-devel@lists.linux.dev,m:hch@lst.de,m:axboe@kernel.dk,m:brauner@kernel.org,m:djwong@kernel.org,m:viro@zeniv.linux.org.uk,m:kbusch@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 873946C3061

On 6/24/26 7:09 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The bio-based drivers don't necessarily check the alignment split, and
> stacking block drivers don't always handle a misalignment detected after
> submitting the bio. Validate user vectors against the device's
> dma_alignment as the bio is built from the iov_iter, rejecting
> misaligned early with -EINVAL.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5ff3f74e145a ("block: simplify direct io validity check")
> Fixes: 7eac33186957 ("iomap: simplify direct io validity check")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio.c          | 56 +++++++++++++++++++++++++++++++++++++++++---
>   block/blk-map.c      |  2 +-
>   block/fops.c         |  2 +-
>   fs/iomap/direct-io.c |  1 +
>   include/linux/bio.h  |  2 +-
>   include/linux/uio.h  | 10 +++++++-
>   lib/iov_iter.c       |  9 ++++++-
>   7 files changed, 74 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

