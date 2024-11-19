Return-Path: <stable+bounces-94018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5EE9D284E
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050DA1F21333
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21DA1CCB53;
	Tue, 19 Nov 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XS/eOi29";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eUqtteDP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XS/eOi29";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eUqtteDP"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB90E57D;
	Tue, 19 Nov 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027004; cv=none; b=n71bM3eh2SNQT3U7dG+6b+6nRNkbyRniZryXH+tkrOkrfVUrHdJ4TbxloONSrDL1UTPFtDaoVqVFMZkp3WkQ+8mmhzz/4Shdm9dMQ+5R8nxJnffU3hclIy3WqCtG3GnJbHWzl1TR35Su9XsPfiOD/EDMShbbwZEo59XAVuKddig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027004; c=relaxed/simple;
	bh=ad2GvHN3fcJLb5LPKw2v2shaHOY1+QPxPzs+8SZ1MGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dH0zpMvBGE4fHPQ6cszaxAWGkM4QcSwLfBou+xGfnJISSTO6m0COL7moowKcBCGWfKefGu9efksGxxulfR6HE8/Ql+z6kpSZFog9K4xR7lQeCi+Eju9Vp0mkZk436Zb8N+MffWr1CEgQCPuD2ofEwN6VybW7TByQFPqGgc/IXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XS/eOi29; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eUqtteDP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XS/eOi29; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eUqtteDP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 939111F79C;
	Tue, 19 Nov 2024 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732027000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=78eK/xKpdwzTo490zBwaeaASTrV1q2qFVo+vGv2j2EY=;
	b=XS/eOi29YM+fIQ9X7m8uzOJazsp2yRukUlaP39A0JKyQS5fVOJoSnu+GmR1qPvySSTAey2
	xCwWmOZEPDqTyxQ9mZrHrgsJtogyYqXaEv/lZ93dvGHzev4GD4lg1p5yY3ahZ9iXe5NWFI
	m7SRsHTOO+r6LPBzruE4zPLjl2wsNLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732027000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=78eK/xKpdwzTo490zBwaeaASTrV1q2qFVo+vGv2j2EY=;
	b=eUqtteDPog95VnW0zKN8G9xJVLVhuqGTaGHqp5g8JUpCBeGrleL4hhw5HLKuvvzGNR7wVD
	3OC+344GUfIMlyCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="XS/eOi29";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eUqtteDP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732027000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=78eK/xKpdwzTo490zBwaeaASTrV1q2qFVo+vGv2j2EY=;
	b=XS/eOi29YM+fIQ9X7m8uzOJazsp2yRukUlaP39A0JKyQS5fVOJoSnu+GmR1qPvySSTAey2
	xCwWmOZEPDqTyxQ9mZrHrgsJtogyYqXaEv/lZ93dvGHzev4GD4lg1p5yY3ahZ9iXe5NWFI
	m7SRsHTOO+r6LPBzruE4zPLjl2wsNLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732027000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=78eK/xKpdwzTo490zBwaeaASTrV1q2qFVo+vGv2j2EY=;
	b=eUqtteDPog95VnW0zKN8G9xJVLVhuqGTaGHqp5g8JUpCBeGrleL4hhw5HLKuvvzGNR7wVD
	3OC+344GUfIMlyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B61F1376E;
	Tue, 19 Nov 2024 14:36:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ytF/HXiiPGeWEQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 19 Nov 2024 14:36:40 +0000
Message-ID: <4e10f9e9-11e7-4f02-88b7-47102197e93a@suse.cz>
Date: Tue, 19 Nov 2024 15:36:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] mm/mmap: fix __mmap_region() error handling in
 rare merge failure case
Content-Language: en-US
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jann Horn <jannh@google.com>,
 syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
 <qmmd4lujbzwyhxmjf3wagmfakbirjleufgkh6ozh5wbled3zp7@2z6trp6xlci7>
 <2024111935-tabasco-haziness-b485@gregkh>
 <6m2hn4wzvvgozrrvvivy6brxiafx6g2qaedkrcicxnmflcopzg@7idyf4fuymff>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <6m2hn4wzvvgozrrvvivy6brxiafx6g2qaedkrcicxnmflcopzg@7idyf4fuymff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 939111F79C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[bc6bfc25a68b7a020ee1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/19/24 15:25, Liam R. Howlett wrote:
> * Greg KH <gregkh@linuxfoundation.org> [241119 09:17]:
>> On Mon, Nov 18, 2024 at 03:32:14PM -0500, Liam R. Howlett wrote:
>> > Okay, before I get yelled at...
>> > 
>> > This commit is only necessary for 6.12.y until Lorenzo's other fixes to
>> > older stables land (and I'll have to figure out what to do in each).
>> > 
>> > The commit will not work on mm-unstable, because it doesn't exist due to
>> > refactoring.
>> > 
>> > The commit does not have a tag about "upstream commit" because there
>> > isn't one - the closest thing I could point to does not have a stable
>> > git id.
>> > 
>> > So here I am with a fix for a kernel that was released a few hours ago
>> > that is not necessary in v6.13, for a bug that's out there on syzkaller.
>> > 
>> > Also, it's very unlikely to happen unless you inject failures like
>> > syzkaller.  But hey, pretty decent turn-around on finding a fix - so
>> > that's a rosy outlook.
>> 
>> Why isn't this needed in 6.13.y?  What's going to be different in there
>> that this isn't needed?
> 
> The code has been refactored and avoids the scenario.  I'd name the
> refactoring commit as the upstream commit, but it does not have a stable
> git id as it's in mm-unstable.  So I'm at a bit of a loss of how to
> follow the process.

Is it not in mm-stable now, given we're in a merge window? Anyway AFAIU if
the stable-specific fix is completely different from the upstream
refactoring, we don't even try to pretend it's the same "commit XYZ
upstream" no?

>> 
>> Do you just want me to take this for the 6.12.y tree now?  I'll be glad
>> to, just confused a bit.
> 
> Yes, please.
> 
> 
> Thanks,
> Liam


