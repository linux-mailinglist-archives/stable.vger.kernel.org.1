Return-Path: <stable+bounces-243907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GAbO3H6+Gkr3wIAu9opvQ
	(envelope-from <stable+bounces-243907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:58:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC84C363B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40863301E5BF
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88E3FB7E2;
	Mon,  4 May 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhsxWcNa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7293FB7E9
	for <stable@vger.kernel.org>; Mon,  4 May 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924718; cv=pass; b=iD9xIjQhQaGwl0xjVxopr3DphAnCBBRuoyAUaBFSvxyAg7s97OK5w4+RISMQFUa9KpLFFti+ku7uFBXHTFWitnbd410Zk4/peyR4yKdD8Phq7IVWaPqdLvPXG7oINQxGKxYiHedRl3iXW/r4lrs9HmmOEqcuH7gkWsMFV3ziMeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924718; c=relaxed/simple;
	bh=D0x/MTLW7vDS1AAs+2/eraYArPBjq6gq+kxQnVpL3Mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jycBVAateGFYpTgubmeQx6/OVfik4qkHuAKrzJ1qLH3STXNWXmhS4IgAlhFWY8G3ZbnKG/uEBtU2mRj82YA5qRshTlaxfcN4/Iv/TnxEzFjdn993CYPswl951gTXXd7TNcTuQYMIrUVK15uicEcopNtAQb+i8WjgdnbIcQA02LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhsxWcNa; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67929ff6dbfso6773389a12.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 12:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777924714; cv=none;
        d=google.com; s=arc-20240605;
        b=d62cgQXHdjflzDS9BpFPz2rnRfPXgWr1+SnjOPvvv+yz2lfUQmoVHsVLmhYPs6gDG7
         GpLnezC/ljCGpLQxViUPkAtVjyNmBvQ4ag4a5FIMg7PuYx7YrB+s4vqsDVY+jjBjyG8j
         kJinsjnm8T4B7O7IbzDJFG3pDaRUCy8XYcrqWvpjDNmCKyxsbYaeumSqr9LoUarfoLfm
         eqpl+fL4Es/EJgG6hBVwftf5lbLtC9E54d9KD+uqLw5hLLuPLjE37lCMnmGUiUl/W+M8
         9i7PITm42lkCRwS7tsWv49UtpngUiIiXuvi+g8/f1UnKvYqKKBntWvEBgDzP7UjKTaky
         vafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=esEqdBvyNeHgcLcZRMKUkcBSd2coHxMvjI5oFXwBBPs=;
        fh=urHPd6F57xW2X+YYzpYSpT6XvBV9GQxP80weQfp8ih8=;
        b=ZxmLnWfYB3DmcqfbOAlJ0iE1cjmyRwArD+DTL5nr4Cyr20c9APWKIuZXbbp8FLEFch
         HSKAqYBU7N2aE2UhlyNQccbqCA/dCmfIvZxpNlDcppgFo3Sin8Z94uGnqEyi7T8mxw7E
         x2KOg9cQsHc4iZcJc5A6I2+2vbGMpbZQtBAD8MIrELS88bndz+WUTys+7TiwsgRs7A3q
         3mJzky+NxV/UKNKTEs3JEScyTlk4S7mEzhgH0HNGb3soaiiiJmqc3L/qFlBDIPOD2mbk
         hZssPZrKxwKQWHm/NpcheGlasQQovqsCY5ETgPY9SPE8qHJ6wZPlUWGYX4YMyixfimGC
         GtvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777924714; x=1778529514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esEqdBvyNeHgcLcZRMKUkcBSd2coHxMvjI5oFXwBBPs=;
        b=OhsxWcNaRpG4Q+b+hKzzXVXVxwm3yYsFsnKtlHce7ygXSmOcdb2JEw9jS5iyCiXT7s
         aamXsKgCQYCFe+eEAiSG8/w6+/0vgs/bW5qzwH3NUUxvts57uyhDwJGsq9fCvrfnYNsA
         d3GDcVC34SHBusblAdwVOSjzE69F/n321Fud0DXAyfx4iAAK7lm9+xu7SoZs+MMcCpr2
         1u5G1KqaduwX4gWdCMQuSPSR6n43Ao171GX/RcG7tnRIXdLOWcRYsILJWXVVNPl2LMZO
         WB/EiNecEedVWdyT6pnhRrdYCnTW4n72QhTdt5cGYLNToLVkAYDpBOQhMn+LV3eKcp9a
         N5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777924714; x=1778529514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=esEqdBvyNeHgcLcZRMKUkcBSd2coHxMvjI5oFXwBBPs=;
        b=UOaUTKKfa7jXBDQt4M0zJt65q9EET5q6f6tn80TqUaVrOJcnArHCD7EwcvTY1W98Xg
         1Nd6sERBKm/D256wVhUsO2lyp1ABg4u5vHi6unKmteVOGXhb+lWxr/mfD0LIyZTYNh+a
         7q/Qga+6rCezRGoKXTJRNj50cOydVg2NBzoV9bVA9tpoa1brDfxe9e9mRbHF6nQiHKjH
         EBb2GkSifmOTz9gz8Cq0qyeIJGEik793lYs3QNnuWLcGv2IoWJ0spbSrUYAWd1u5pQfN
         7r6X2snr9FelprhaUJOBLuY+57zIBi/MJdYhJjj9gNil/+VA/uH/As6p3mwlx9atFiHP
         T0gw==
X-Gm-Message-State: AOJu0YxTtIsmRXbYRWaKtzaP99Ki1UfwvufRu/t4K1U6T/fUVT7IeOM/
	dH9D4AXL9f9E+nOzeBNnHLfKPzkdjS6gsJPUGLBJOQoFfuKUOuVDabDJMWymAXHwl9M1SW05LDi
	ikfZOFfKx7N1ItygDYLBu7E9hh0So28sWeYq5
X-Gm-Gg: AeBDievEBmxwOs9AACYNwAAvdumwuQaFzE1ejtAIbk4qsRzrHEg0Z/4YMfdxbi7qa8B
	E2DnJ6X4k6QoMVSujqOTtST88tPu+BasXsUqJu4tLQQzv7/BnvcJSoraJE+BQCRzz+icB2Dl/ui
	pA+JcYdPyP68njGG2MbVoh8Fjpzd+lFdKTNuyN/kokZbBffz42O3D0guI7Kk9pUsT9uwq5wGiub
	h9vOHgbb4THBzyFThX5rlIIZ7iMPV+W/Wt8JQs3GgbRkr6vi+PN0+m+JsFOeSe24CcXnaZaaPCm
	jx5Xez6GDJJ2WL9zffeT
X-Received: by 2002:aa7:c34f:0:b0:672:64b:c97b with SMTP id
 4fb4d7f45d1cf-67c1aab3100mr3731156a12.26.1777924714107; Mon, 04 May 2026
 12:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-y=SD7V7dcBXuAqq8=p2R46SAr1uKZtMACynvk1=Cftqg@mail.gmail.com>
 <20260424221126.1238744-1-elaidya225@gmail.com> <CANaxB-xFcF7U=wJv8EqKy=j=-P3SN+sLQ9ytH8Ej69h03tqL8Q@mail.gmail.com>
In-Reply-To: <CANaxB-xFcF7U=wJv8EqKy=j=-P3SN+sLQ9ytH8Ej69h03tqL8Q@mail.gmail.com>
From: Ahmed Elaidy <elaidya225@gmail.com>
Date: Mon, 4 May 2026 22:58:22 +0300
X-Gm-Features: AVHnY4K-gqls4V5lFPSYuwMzajTBx-lOIHJ6BTOdcQJ2CRq2bDdmxV7hRnhW0rw
Message-ID: <CAP48DwbE3MnQqVmbOsrSZgo6tYvqE4RV9o4dS2TODUP9G85aog@mail.gmail.com>
Subject: Re: [PATCH v2] mm: fix VM_SOFTDIRTY propagation on VMA merge
To: Andrei Vagin <avagin@gmail.com>
Cc: stable@vger.kernel.org, lorenzo.stoakes@oracle.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 59EC84C363B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243907-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,oracle.com:email]

Hi Andrei,

Thanks for the review.

> Should we fix vma_merge_new_range too?

Yes, vma_merge_new_range() exhibited the exact same logic gap where
vma_expand() leaves the merged VMA without VM_SOFTDIRTY if the target
sequence didn't have it natively. I have added the exact same fix to
vma_merge_new_range() in v3.

> How are you testing this patch?

Testing was done using the CRIU ZDTM transition test suite
(soft-dirty-merged-vmas.c) on virtme-ng. The test enforces an
unprivileged namespace testing environment (ZDTM_ROOTLESS=3D1) where it
tracks VM_SOFTDIRTY across merged VMAs. The unpatched 6.18 kernel
fails this incremental tracking natively, but correctly propagates the
bit with this fix applied.

I've addressed the formatting suggestions and added the Fixes tag to
point to the 2014 commit (34228d473efe). I have just sent the v3 patch
to the list.

Best regards,
Ahmed


On Mon, May 4, 2026 at 7:42=E2=80=AFPM Andrei Vagin <avagin@gmail.com> wrot=
e:
>
>
>
> On Fri, Apr 24, 2026 at 3:11=E2=80=AFPM Ahmed Elaidy <elaidya225@gmail.co=
m> wrote:
>>
>> During VMA merging, such as through mprotect(), VM_SOFTDIRTY flags could=
 be
>> lost. This breaks tools relying on soft-dirty tracking, such as CRIU
>> incremental dump/restore.
>>
>> Upstream resolved this using a broader VM_STICKY infrastructure (commit
>> bf14d4a05387 "mm: propagate VM_SOFTDIRTY on merge"). To minimize churn a=
nd
>> risk in the stable 6.18.y tree, this patch skips backporting the entire
>> VM_STICKY series (9 patches). Instead, it introduces a minimal standalon=
e fix.
>>
>> VM_SOFTDIRTY is intentionally excluded from normal flag comparison to al=
low
>> merging in mprotect. This patch ensures the resulting merged VMA retains
>> the VM_SOFTDIRTY flag if either of the original VMAs had it.
>>
>> Suggested-by: Andrei Vagin <avagin@gmail.com>
>> Cc: stable@vger.kernel.org
>
>
> It probably should be: Cc: stable@vger.kernel.org # 6.18.x and
> the prefix in the subject can be [PATCH 6.18.y]..
>
> Please add The Fixes tag to the commit that introduced the issue.
>
>>
>> Cc: lorenzo.stoakes@oracle.com
>> Signed-off-by: Ahmed Khalid Elaidy <elaidya225@gmail.com>
>> ---
>>  mm/vma.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/vma.c b/mm/vma.c
>> index 5815ae9e5770..03728d855684 100644
>> --- a/mm/vma.c
>> +++ b/mm/vma.c
>> @@ -978,6 +978,14 @@ static __must_check struct vm_area_struct *vma_merg=
e_existing_range(
>>         if (err || commit_merge(vmg))
>>                 goto abort;
>>
>> +       /*
>> +        * VM_SOFTDIRTY is excluded from normal flag comparison to allow
>> +        * merging in mprotect, but we have to ensure the result is corr=
ectly
>> +        * marked with it if either side had it.
>> +        */
>> +       if ((vmg->target->vm_flags ^ vmg->vm_flags) & VM_SOFTDIRTY)
>> +               vm_flags_set(vmg->target, VM_SOFTDIRTY);
>
>
> Should we fix vma_merge_new_range too?
>
> How are you testing this patch?
>
> Thanks,
> Andrei

