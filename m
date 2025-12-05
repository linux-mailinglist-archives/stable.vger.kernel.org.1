Return-Path: <stable+bounces-200129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96ECA6F63
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28F3B34315C4
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC3E25F797;
	Fri,  5 Dec 2025 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mwzwteWz"
X-Original-To: stable@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E9B33C19C
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921708; cv=none; b=Dgf2CCDhEJOnZ3E0s4SKakalfrvtaPMEkx25+88Q6rSQSMoEJlZ/clyftYKscdvn9zdkrRpLP2EQqrYsY5Y50lLQWoBGk+OCBODnWPD7259cyKSI4a780u6hudZkFtTLaNO370M7v67b9vpkuXfOFfaFJDGzHd07T1gK0uv8KXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921708; c=relaxed/simple;
	bh=2b55B9Zjp61SytwW9T/Q+2xWGHAGJN9kgM34pLYbqGs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IigE3gknc7apB9KASwCCDX5YOu2WTtMfTgOn5B1Ww/B270hZXtqAo1ZviqB5xgDKZqQehB1yhIumK/O+cnjqkqZeAMaFn/99xlOGpBDfz5ROqnBuD+mZB3JdAsrVDKcjpf/0S4CWycW4kT3o/r/AEdOUCb3c42TMMryz7mKS0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mwzwteWz; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1764921698; x=1765180898;
	bh=Zgc5Bfim5kR7lSEF9D/3QfXneWnjNYTl3zLRKpUUg0w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mwzwteWzQ4+P+0EheVmeVZVyCucCeGcOdcgEVReGyJxazYbDrOdG1S7D0jCMUamfp
	 iydGU9+1EY6vFnlYBpjho6eu3YGlllfWJ2wa5oMcArU7QaC4un+wOMvnB64rlc5+XJ
	 jD70CbVLek+OcQzYRzDcZlWFx9rDEpOdvdynAg3HLrrWJiXfjcMU4iK849dVdORqy5
	 dWiuL1WI0jK7e3Bu8kDH2yay9JzGxXcB672cRzePhHmBO0oT0hxTGqCWsV4m7XNQ1y
	 q8gAdM8XXoCsHgwaEKlsUZ5QtgnUFQP4VR21r1c4Nl68QPGh59rwJvpxYkxGC+j5ud
	 WZbdLoJpZ6M5g==
Date: Fri, 05 Dec 2025 08:01:34 +0000
To: Andrey Konovalov <andreyknvl@gmail.com>
From: =?utf-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, jiayuan.chen@linux.dev, stable@vger.kernel.org, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] kasan: Refactor pcpu kasan vmalloc unpoison
Message-ID: <mtfitb3vqbcqzezrckjlo2vyszb3ufqgimmpmfhnybrkjt7m6f@3ovjldsuitwc>
In-Reply-To: <CA+fCnZfRTyNbRcU9jNB2O2EeXuoT0T2dY9atFyXy5P0jT1-QWw@mail.gmail.com>
References: <cover.1764874575.git.m.wieczorretman@pm.me> <eb61d93b907e262eefcaa130261a08bcb6c5ce51.1764874575.git.m.wieczorretman@pm.me> <CA+fCnZfRTyNbRcU9jNB2O2EeXuoT0T2dY9atFyXy5P0jT1-QWw@mail.gmail.com>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 2cea9ea5c467759ad35e9323c2a7e8e0c5500488
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2025-12-05 at 02:09:02 +0100, Andrey Konovalov wrote:
>On Thu, Dec 4, 2025 at 8:00=E2=80=AFPM Maciej Wieczor-Retman
><m.wieczorretman@pm.me> wrote:
>>
>> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>
>> A KASAN tag mismatch, possibly causing a kernel panic, can be observed
>> on systems with a tag-based KASAN enabled and with multiple NUMA nodes.
>> It was reported on arm64 and reproduced on x86. It can be explained in
>> the following points:
>>
>>         1. There can be more than one virtual memory chunk.
>>         2. Chunk's base address has a tag.
>>         3. The base address points at the first chunk and thus inherits
>>            the tag of the first chunk.
>>         4. The subsequent chunks will be accessed with the tag from the
>>            first chunk.
>>         5. Thus, the subsequent chunks need to have their tag set to
>>            match that of the first chunk.
>>
>> Refactor code by reusing __kasan_unpoison_vmalloc in a new helper in
>> preparation for the actual fix.
>>
>> Changelog v1 (after splitting of from the KASAN series):
>> - Rewrite first paragraph of the patch message to point at the user
>>   impact of the issue.
>> - Move helper to common.c so it can be compiled in all KASAN modes.
>
>Nit: Can put this part after ---.

Thanks for noticing that, guess I need to revise my script that moves
these under the three dashes

...

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


