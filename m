Return-Path: <stable+bounces-165058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D35B14D56
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3097318A2CCB
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 12:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976EA28F53B;
	Tue, 29 Jul 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NmC1Mttn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LXokN/gu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NmC1Mttn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LXokN/gu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838B13C3F6
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790599; cv=none; b=Cw4bZIgHeHKRtaUbvJYAL+wbwd45h2OcrhHNYAQngqM1oMARJccjjhk8sCYmAwcTklaKPk6Nx3ZouaJOg5Td3/5UtAk0sz1ijmI+4Vv7yOiL8usqiRXtzJa/+73QaSCgNvvCUuf0dlyDXeU/C+BKPha8Y3wQzCDxbP5Hq4za0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790599; c=relaxed/simple;
	bh=zOhfASOthAqWIzLnifKwRQnTaYVTSFziEpqeHJY4P+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mla9UgmDDRBW+7EXaVxP2V1Tjqfw1jWaLXd1BY8w1QptNOMNjoIKX0qoB7aXVtSIncd5QILgwneYwRwYzv3qC1omRjwWLFwGV8bROtVUNbMMQELHdxnSX2SuNcqyeCCLt5xrD8u5S8adElINlTIYF0ZgQF6MvfyKu4hsEn86WMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NmC1Mttn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LXokN/gu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NmC1Mttn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LXokN/gu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7075321A21;
	Tue, 29 Jul 2025 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753790595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g4Bnf9kH5GHai8tgujDGESwikQd+CAfC9HWyiHTVmy4=;
	b=NmC1MttnJ6/weN7udPKkQFHHbiovIQgcrEYx1uRqZyBD0BokzY66xSon6sOF3lXRUURFrk
	Dgqe5OKKbjXaQ1aphK26jiabNxm+V63ZRgUHK2stAUP7KWV862z/aWlyXE0ei63dEZMMcb
	gPowD2H1vPJzLAnANhMmBghK6YiCm2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753790595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g4Bnf9kH5GHai8tgujDGESwikQd+CAfC9HWyiHTVmy4=;
	b=LXokN/gugwUEh7Xu3UoMkCSwMuGOHj3b9L21q/zvN4/1uujkyHdVAUBL9ceusa1588lB/p
	5i2gLX3rMTkG1VCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NmC1Mttn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="LXokN/gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753790595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g4Bnf9kH5GHai8tgujDGESwikQd+CAfC9HWyiHTVmy4=;
	b=NmC1MttnJ6/weN7udPKkQFHHbiovIQgcrEYx1uRqZyBD0BokzY66xSon6sOF3lXRUURFrk
	Dgqe5OKKbjXaQ1aphK26jiabNxm+V63ZRgUHK2stAUP7KWV862z/aWlyXE0ei63dEZMMcb
	gPowD2H1vPJzLAnANhMmBghK6YiCm2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753790595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g4Bnf9kH5GHai8tgujDGESwikQd+CAfC9HWyiHTVmy4=;
	b=LXokN/gugwUEh7Xu3UoMkCSwMuGOHj3b9L21q/zvN4/1uujkyHdVAUBL9ceusa1588lB/p
	5i2gLX3rMTkG1VCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A72213A73;
	Tue, 29 Jul 2025 12:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FwrHFYO4iGh7AwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Jul 2025 12:03:15 +0000
Message-ID: <717f1f43-3ec0-41a7-b0a9-05383a4325d4@suse.cz>
Date: Tue, 29 Jul 2025 14:03:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got dropped
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250728175355.2282375-1-surenb@google.com>
 <197389ce-9f42-4d6a-91c4-fce116e988b4@suse.cz>
 <CAJuCfpFzxCayf083d35dS7Py0AK-CSr3H=_mymP9yXcyWzOqPQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpFzxCayf083d35dS7Py0AK-CSr3H=_mymP9yXcyWzOqPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7075321A21
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/29/25 00:53, Suren Baghdasaryan wrote:
> On Mon, Jul 28, 2025 at 10:04 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> As for further steps, considered replying to [1] but maybe it's better here.
>>
>> As for a KISS fix including stable, great. Seems a nice improvement to
>> actually handle "vma->vm_mm != mm" in vma_start_read() like this - good idea!
>>
>> Less great is that there's now a subtle assumption that some (but not all!)
>> cases where vma_start_read() returns NULL imply that we dropped the rcu
>> lock. And it doesn't matter as the callers abort or fallback to mmap sem
>> anyway in that case. Hopefully we can improve that a bit.
>>
>> The idea of moving rcu lock and mas walk inside vma_start_read() is indeed
>> busted with lock_next_vma(). The iterator difference could be perhaps solved
>> by having lock_vma_under_rcu() set up its own one (instead of MA_STATE) in a
>> way that vma_next() would do the right thing for it. However there would
>> still be the difference that lock_next_vma() expects we are already under
>> rcu lock, and lock_vma_under_rcu() doesn't.
>>
>> So what we can perhaps do instead is move vma_start_read() to mm/mmap_lock.c
>> (no other users so why expose it in a header for potential misuse). And then
>> indeed just make it drop rcu lock completely (and not reacquire) any time
>> it's returning NULL, document that and adjust callers to that. I think it's
>> less subtle than dropping and reacquring, and should simplify the error
>> handling in the callers a bit.
> 
> Thanks for the suggestion. That was actually exactly one of the
> options I was considering but I thought this dropping RCU schema would
> still be uglier than dropping and reacquiring the RCU lock. If you
> think otherwise I can make the change as you suggested for mm-unstable
> and keep this original change for stable only. Should I do that?

If we decide anything, I would do it as a cleanup on top of the fix that
will now go to mainline and then stable. We don't want to deviate for stable
unnecessarily (removing an extraneous hunk in stable backport is fine).

As for which case is uglier, I don't know really. Dropping and reacquiring
rcy lock in very rare cases, leading to even rarer situations where it would
cause an issue, seems more dangerous to me than just dropping everytime we
return NULL for any of the reasons, which is hopefully less rare and an
error such as caller trying to drop rcu lock again will blow up immediately.
Maybe others have opinions...

>>
>> [1]
>> https://lore.kernel.org/all/CAJuCfpEMhGe_eZuFm__4CDstM9%3DOG2kTUTziNL-f%3DM3BYQor2A@mail.gmail.com/
>>
>> > ---
>> > Changes since v1 [1]
>> > - Made a copy of vma->mm before using it in vma_start_read(),
>> > per Vlastimil Babka
>> >
>> > Notes:
>> > - Applies cleanly over mm-unstable.
>> > - Should be applied to 6.15 and 6.16 but these branches do not
>> > have lock_next_vma() function, so the change in lock_next_vma() should be
>> > skipped when applying to those branches.
>> >
>> > [1] https://lore.kernel.org/all/20250728170950.2216966-1-surenb@google.com/
>> >
>> >  include/linux/mmap_lock.h | 23 +++++++++++++++++++++++
>> >  mm/mmap_lock.c            | 10 +++-------
>> >  2 files changed, 26 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
>> > index 1f4f44951abe..da34afa2f8ef 100644
>> > --- a/include/linux/mmap_lock.h
>> > +++ b/include/linux/mmap_lock.h
>> > @@ -12,6 +12,7 @@ extern int rcuwait_wake_up(struct rcuwait *w);
>> >  #include <linux/tracepoint-defs.h>
>> >  #include <linux/types.h>
>> >  #include <linux/cleanup.h>
>> > +#include <linux/sched/mm.h>
>> >
>> >  #define MMAP_LOCK_INITIALIZER(name) \
>> >       .mmap_lock = __RWSEM_INITIALIZER((name).mmap_lock),
>> > @@ -183,6 +184,28 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
>> >       }
>> >
>> >       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
>> > +
>> > +     /*
>> > +      * If vma got attached to another mm from under us, that mm is not
>> > +      * stable and can be freed in the narrow window after vma->vm_refcnt
>> > +      * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
>> > +      * releasing vma->vm_refcnt.
>> > +      */
>> > +     if (unlikely(vma->vm_mm != mm)) {
>> > +             /* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
>> > +             struct mm_struct *other_mm = vma->vm_mm;
>> > +             /*
>> > +              * __mmdrop() is a heavy operation and we don't need RCU
>> > +              * protection here. Release RCU lock during these operations.
>> > +              */
>> > +             rcu_read_unlock();
>> > +             mmgrab(other_mm);
>> > +             vma_refcount_put(vma);
>> > +             mmdrop(other_mm);
>> > +             rcu_read_lock();
>> > +             return NULL;
>> > +     }
>> > +
>> >       /*
>> >        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
>> >        * False unlocked result is impossible because we modify and check
>> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
>> > index 729fb7d0dd59..aa3bc42ecde0 100644
>> > --- a/mm/mmap_lock.c
>> > +++ b/mm/mmap_lock.c
>> > @@ -164,8 +164,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>> >        */
>> >
>> >       /* Check if the vma we locked is the right one. */
>> > -     if (unlikely(vma->vm_mm != mm ||
>> > -                  address < vma->vm_start || address >= vma->vm_end))
>> > +     if (unlikely(address < vma->vm_start || address >= vma->vm_end))
>> >               goto inval_end_read;
>> >
>> >       rcu_read_unlock();
>> > @@ -236,11 +235,8 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
>> >               goto fallback;
>> >       }
>> >
>> > -     /*
>> > -      * Verify the vma we locked belongs to the same address space and it's
>> > -      * not behind of the last search position.
>> > -      */
>> > -     if (unlikely(vma->vm_mm != mm || from_addr >= vma->vm_end))
>> > +     /* Verify the vma is not behind of the last search position. */
>> > +     if (unlikely(from_addr >= vma->vm_end))
>> >               goto fallback_unlock;
>> >
>> >       /*
>> >
>> > base-commit: c617a4dd7102e691fa0fb2bc4f6b369e37d7f509
>>


