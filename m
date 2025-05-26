Return-Path: <stable+bounces-146380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3FAC41E4
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0F43BA7DC
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B36212FB0;
	Mon, 26 May 2025 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9o6NH6V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XWNSHjdO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s9o6NH6V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XWNSHjdO"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46D212B18
	for <stable@vger.kernel.org>; Mon, 26 May 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271290; cv=none; b=VDTUsOY86LqZDEKWdF1bOXGBQ3Yexm3g0ZvucNyCVFkx1A/VVtttZjNL8XOW/jTcpVwlaTtmwFdd6VBQcotu5qFxU98QicBRo4uV93bGKiUxQjiFj6a+kZxo6eNz95QK7y7jDTZSjOX4epNu3Qz/r435fuhX6nSOCinwcAJNv6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271290; c=relaxed/simple;
	bh=sJI5T5gMrKsRcMtURiKUZhD0WuCKbcvCgGssK3pjk+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TfLgpsfTLVN3Kr5BeeoweBKrT/ZMGPKcGs2cpQfAxnH5xzC1D6S1ay1aII/R2QgT2Ttp8wPqSe0CTHXyKoSubVkW8AP0LfG/Qg4vUfYuqaJoV1+NgQUPMmGk33MRNOghoVmJ0jtMe/IP7whmLWt55zmI6tYsjHwIB2nnISS4scs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9o6NH6V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XWNSHjdO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s9o6NH6V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XWNSHjdO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7A3A21BFC;
	Mon, 26 May 2025 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748271286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D+qE3pOstO856y4dSQaXjbHrO/MNEiDzJe7bcLXqF48=;
	b=s9o6NH6VnZ861Q3oryxUf1NNhtsi1Uj4LbXUnU8WzhPf7lo2CbKaRthHOgN8Z6tHIJ0EZA
	GbKot0z8aV9ASrOJCJsQgAPG0kn9vm+WTIsUd9SoMQLY4IBos3nBhnha5GffH84mKUfJbc
	0Lj3cTcmJOstV8873LriBMJDRLwDKNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748271286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D+qE3pOstO856y4dSQaXjbHrO/MNEiDzJe7bcLXqF48=;
	b=XWNSHjdOXd2PI5ir/dZ1V197HUxVtMj6YlzTJR4Tpqf2dhYIZZmntRZmO21vVFskQCKree
	yXYI5bMzd3JlNvDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s9o6NH6V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XWNSHjdO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748271286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D+qE3pOstO856y4dSQaXjbHrO/MNEiDzJe7bcLXqF48=;
	b=s9o6NH6VnZ861Q3oryxUf1NNhtsi1Uj4LbXUnU8WzhPf7lo2CbKaRthHOgN8Z6tHIJ0EZA
	GbKot0z8aV9ASrOJCJsQgAPG0kn9vm+WTIsUd9SoMQLY4IBos3nBhnha5GffH84mKUfJbc
	0Lj3cTcmJOstV8873LriBMJDRLwDKNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748271286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D+qE3pOstO856y4dSQaXjbHrO/MNEiDzJe7bcLXqF48=;
	b=XWNSHjdOXd2PI5ir/dZ1V197HUxVtMj6YlzTJR4Tpqf2dhYIZZmntRZmO21vVFskQCKree
	yXYI5bMzd3JlNvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A39D21398F;
	Mon, 26 May 2025 14:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gRScJ7aANGgiVwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 May 2025 14:54:46 +0000
Message-ID: <1b3858dc-6eae-4ac1-9924-be1f036a6317@suse.cz>
Date: Mon, 26 May 2025 16:54:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mm: fix copy_vma() error handling for
 hugetlb mappings" failed to apply to 5.4-stable tree
Content-Language: en-US
To: =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>,
 gregkh@linuxfoundation.org, Liam.Howlett@oracle.com,
 akpm@linux-foundation.org, jannh@google.com, lorenzo.stoakes@oracle.com,
 osalvador@suse.de, revest@google.com, stable@vger.kernel.org
References: <2025052601-directive-strep-6b85@gregkh>
 <87cybvbphn.fsf@igalia.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <87cybvbphn.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: B7A3A21BFC
X-Spam-Level: 
X-Spam-Flag: NO

On 5/26/25 13:06, Ricardo Cañuelo Navarro wrote:
> Hi Greg,
> 
> On Mon, May 26 2025 at 12:45:01, <gregkh@linuxfoundation.org> wrote:
> 
>> The patch below does not apply to the 5.4-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
> 
> This patch was superseded by a v2:
> https://lore.kernel.org/all/20250523-warning_in_page_counter_cancel-v2-1-b6df1a8cfefd@igalia.com

Stable backports are done from mainline commits so assuming it was v2 that
made it to mainline, then this is v2. Although the subject doesn't say so as
it's newly generated from the commit subject, which drops vX information.

> and it was ultimately decided that it's not worth it to backport this to
> stable. This was discussed here:
> https://lore.kernel.org/all/0b2a5a80-0709-452f-9815-018cc1cd14fb@lucifer.local/

In that case the "Cc: <stable@vger.kernel.org>" should have been also
removed as it's that line that triggered the stable backport attempts.

But since it seems all stable versions failed with a conflict, the easiest
way now is simply not post any fixed up versions.

Vlastimil

> Cheers,
> Ricardo


