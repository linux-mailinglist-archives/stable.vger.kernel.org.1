Return-Path: <stable+bounces-241289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK2VG3RC72lP/QAAu9opvQ
	(envelope-from <stable+bounces-241289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:03:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FA14716EE
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9C6E300B60A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4858A3A963A;
	Mon, 27 Apr 2026 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9rzC2Ar"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25453A872C
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287791; cv=pass; b=qaHkX+qhJmK/5T49d1/J5V28Q3wmceCNXjXXktuuGCkV9QdmmLwp8TJavYeG9YI9iI7b5PJVwbXC2jvQHLRKXefnWeB5HA7IAg53xoXDwmb1guom96h8UEN5F6Ipjc3n1x0w8kjejONW4JBQb+JGKVTHniVSQLmBmY2gluaL0s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287791; c=relaxed/simple;
	bh=5/GeQ5d4XY4FiXdEArcTqlSMP2Y+dzWjqJnYlkwIHvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaaS3krVTSScOYjhOdBIqVtvZ+YZlZ3ouD7Rn8TVnghEwbYHCF0XHZx2ECHC6h9yt8vDPOq7wtZXHIBmA3ke5kVK3jH++jzJRVogzsptA7Rekn5zzgSUqzkt6LGd3TBuNHxiqwoCj2eGKFjbOIrurnlfvZIjUsB5TOY5FUH7S2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9rzC2Ar; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12dca45ca21so2698902c88.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 04:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777287789; cv=none;
        d=google.com; s=arc-20240605;
        b=iz/eQdLw3IO5jugz94HJx3u50z+5oSVfooXL4jSiq/9xKKKSnnK3MmVVkze3k9prMp
         n1Lp1SyPvcuXxgm5lh0jjgTQOCXMNcMNEv+OgeZHt1qnVPGN7zNSWJSb3k1LFgkNrG/6
         LGA7ClbXOqIlf9fW+//H+oExNx3Hku2/pkR5/l/uT9WkGEywU7Ukn8SfiBB3HznOw1b5
         mW98alEE8EelPaBZGKvlAVnANnCqBuYMw3FLYUSJZghKArEEHu4Plp8OfoERM5GV+qsr
         Edyujg54jIHyqjqZ8LKu3THrHlSwm4bloBgvz4EwVut+0imxI0PV4tOysDn5obxhJXwd
         GwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hDTOE0AeM4nDcsZ3wtt1ZPjecLOWz83LVoC2/26egb8=;
        fh=ISKrff6+Mp11LJaVjOEp2KFhJGdaqf1ddhclsOtWpk8=;
        b=Ds8SEXxnwY3hmIL+AczVvEmdlCezniRbpA6nHGokgEAtvb4O4RQ6u6Iqd830L/CMgl
         sL3Er0PXmi4jXvns+9J1HvkwIzaoIl+qIEPwB9SIuQS4z3qMkLsw8SUXieVES5tmMzIE
         5ANuOywveVqhANgLjgNC3NMyy/Sw+ixYIqcE2flZ2Zb6CzJXp7ZnHWindqTguSZL/Dky
         wYB2aHPhqMu0EOPYfZqyZRd5NjCN2xSWcdjwarrnbbjBsZ0w95xfBPVc6IRWdUkLmWMx
         j9Upw6dIN8UM7C10mZwHsFB6LPEY4Pj288H5mPNtSusJrSH2ssZ8pOvM+i7+khUfJLso
         xilg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777287789; x=1777892589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hDTOE0AeM4nDcsZ3wtt1ZPjecLOWz83LVoC2/26egb8=;
        b=q9rzC2Ar1/+UtBFOUgPK28ejzBBXugRmsg3sF/KaYp+anm68dDoJcs8NU97W6aBiLF
         5FLEIEpVt+RR79rL6W22jjhS/IccCzWUXfXsx0TNCYek0CcffjSI3PBv6OAQeIGt25eA
         SgctKBU5BEe3xhqo/FvWTii5EDQ11dPlUL49d4bNw62fzRWEoiMtsO91y4kJFHcNL36f
         NbbyJf7UDv0MlKqEx/Mws5E9qAw3mF8PBJo/Z++OTJPs+c9EMfNWx1FX9Pr0v/pr8030
         W5AZrFeUsLu7kwSqMe+dV5kfA45B3OzMWIjEqZGCdRF31+4kTW0uxiKOwbCMDfPXlm6C
         4qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777287789; x=1777892589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDTOE0AeM4nDcsZ3wtt1ZPjecLOWz83LVoC2/26egb8=;
        b=rpAhRanvB6fqKJklXL8kzQ5tdmx16oG5nOa3s47H5Q9zxU6VE5k0ZqdunDhrRHE1td
         89dO/EtWwaApfujcYiipY0VhYKBwyVV4EyZsGq4kRWzJvGIwRFinRMJ2i9QXoOHPzPRJ
         BuqSr8+sEFK27e36QcPXKoITeFCrYXXy3k0xQSIDg3U0RTyhUlsZyZl5OdD4udWDjMiq
         1B4Rke5Mr7qQBXuTbmWSyOJS4luSwdb0bU917pSHtBfNaVrRpJeZtjax8rljZ56QZ+WR
         p8e9j1GqYau2fKlVWr6poYUtTaqsoHegkLVkwopDWZorusbZ+ZEiUK7uMlQcuGKKWT+Y
         DVaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yBVJZ650rU2SjpMQL7UObPSKXc/iO5vokXfQvZhOxT87rPfZMLXDz5D7YRIBHFMcrMNopGWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbptQ+O9LdBB+0r3zBFrjClkyq5us9HA40dAIzdI2cbguQWOD
	jfeBQP8onbOdeaa5tnGaXKMtQpN5yP8TMfcVeYWXrnVOvFHLFcm3/qMtkci3fNXgz2nrYt3D6IZ
	2B6QIN/VaLkmhpFd2Artmndeiec9J6Ugq9t1IfSp6
X-Gm-Gg: AeBDieup5SOR5kYqFPbv31wa/FKy+i6h75tl32ehYpdjZwHkhpnU2X6/KYqf/23fXlm
	GUIwofhchUql39/rPnBhs4u/iK2spO8+QU9Ozo+jpfigjWvwFtF29h7t3tM0y+e6DpfuoFjiKOP
	t2P3EImN0zlLBFPKBPBdugkGe7/p9AS5+DGGUBGmJrbJuXIS46z1PZXzNr7yO+UVuEowFYr8Eeh
	lSKtbsIGeOh9eStbnxNm7ybOS4hFpTgSQGcMMwxeOpfvpe6nCe3DHvtqj9tqybfzOLEvZZuxHeM
	yadWvyA6/RyLPNPYXeQSqUuDnNuFj7GEo6yt4fy5IAb5Iu+qMDgrAQBTR/U=
X-Received: by 2002:a05:7022:2213:b0:128:cf80:deea with SMTP id
 a92af1059eb24-12c73f697edmr20663248c88.1.1777287788342; Mon, 27 Apr 2026
 04:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420114805.3572606-2-elver@google.com> <20260424065617.5de5751ec5a5c91910d45a28@linux-foundation.org>
In-Reply-To: <20260424065617.5de5751ec5a5c91910d45a28@linux-foundation.org>
From: Marco Elver <elver@google.com>
Date: Mon, 27 Apr 2026 13:02:30 +0200
X-Gm-Features: AVHnY4JKLU6q39dCKyB4plPncNdXg88yW_ofsZa5rRywUQJ7hms373eIegh-620
Message-ID: <CANpmjNPEUAQD5Nf7bnBwd4sQPT3Dn_QZy_Ae2nv3rkX0jK=z-g@mail.gmail.com>
Subject: Re: [PATCH] vmalloc: fix buffer overflow in vrealloc_node_align()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	Vitaly Wool <vitaly.wool@konsulko.se>, stable@vger.kernel.org, 
	"Harry Yoo (Oracle)" <harry@kernel.org>, Roman Gushchin <kfree@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C0FA14716EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,kvack.org,vger.kernel.org,googlegroups.com,konsulko.se,google.com];
	TAGGED_FROM(0.00)[bounces-241289-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,linux-foundation.org:email,mail.gmail.com:mid]

On Fri, 24 Apr 2026 at 15:56, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 20 Apr 2026 13:47:26 +0200 Marco Elver <elver@google.com> wrote:
>
> > Commit 4c5d3365882d ("mm/vmalloc: allow to set node and align in
> > vrealloc") added the ability to force a new allocation if the current
> > pointer is on the wrong NUMA node, or if an alignment constraint is not
> > met, even if the user is shrinking the allocation.
> >
> > On this path (need_realloc), the code allocates a new object of 'size'
> > bytes and then memcpy()s 'old_size' bytes into it. If the request is to
> > shrink the object (size < old_size), this results in an out-of-bounds
> > write on the new buffer.
> >
> > Fix this by bounding the copy length by the new allocation size.
>
> AI review is asking questions about the nearby code:
>         https://sashiko.dev/#/patchset/20260420114805.3572606-2-elver@google.com

There's kernel-doc wording for this function:

* If __GFP_ZERO logic is requested, callers must ensure that, starting with the
* initial memory allocation, every subsequent call to this API for the same
* memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
* __GFP_ZERO is not fully honored by this API.

So while Sashiko is technically right, the API contract says this is
by design. Sashiko should ingest available kernel-doc API contracts if
available.

