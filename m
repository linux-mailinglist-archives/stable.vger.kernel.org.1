Return-Path: <stable+bounces-249017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK20KjaqCGrP0AMAu9opvQ
	(envelope-from <stable+bounces-249017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:32:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038055CED8
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490E03010BBD
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB0296BCC;
	Sat, 16 May 2026 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QVXuaIT2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8554654
	for <stable@vger.kernel.org>; Sat, 16 May 2026 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778952754; cv=none; b=MLeVCzc7pbF+7UEOCYIBk8vbK1px5E0/yO2y46b3OtRBCjvaPdX+k3UW7uOaxtQe6tQh35iIm3bsZhvYV3R0ixkeZ6L7jwV8DosgmWC4soPONClCFAJwy3d6AmDdcKpvEe2D+D2RcXFf3W6WQZc6rqCHx0tmqFQzYj4PezA8Kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778952754; c=relaxed/simple;
	bh=WJzga0QqZAxO1Yjdi5lRsklVaT7UVqCs4grf4qY2enY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyL8j1UbtnSEcl4XQE53IvcXFYTMo4uG3+pvf/mKVKHKqUTnQ7dxvIvWtHgJH9aNwjjxaG2gKw9bIMRyn/yPqqNS961pYN2uewzfoew0Lpon4hfWINbRKXuQkLb6esTaS5eqRCsYqBkA42zEd/3mrHkdCgwx2Kvml2SQm6IOSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QVXuaIT2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bcd3c190f71so174545066b.0
        for <stable@vger.kernel.org>; Sat, 16 May 2026 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778952751; x=1779557551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PRqWOI5lEDkAX8dh7uVdCRdEuSOby6Kyc0mg871lWR0=;
        b=QVXuaIT2ICrmbe0sOXCc67ujjmQU61oLL+jvSx1J1jILRGISCcofXwl2dmdMGQxVeN
         ep1oQblp3x3pwIgCowJ3zRm7nAPZBzSwd/HN9pGiXKuHqKl6JxKspdg1sqSuy1BnW+2A
         ClKv1q3WlfCN7uGifR+LdjPG5ZAXLZQX5jEpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778952751; x=1779557551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRqWOI5lEDkAX8dh7uVdCRdEuSOby6Kyc0mg871lWR0=;
        b=Z47Hxf7X7NF1ZPlx67o9F2X30ymA0mnRFqpMd5Ku34bZVGl0HR3TSPGp/MEmelEfhs
         NcsHYbWURdHgWMFOVYwJ3gE9R+lM0hxL1VLSxxpcfxFx07oXAem8dqERKED184qGFdll
         N85S0/59hQJD50s39aNrXrdVZVJ3whhkJIH/mnDPjKHEbAh432BnZS0JqkkM53V5c7r6
         U6HzBI98TPQw4HouvvXZRDB/TfygOIXT0MMhs1JxxZ0zsUIokqsVD6jSWFK0FDBTtjzA
         ufjSY4YcJYAf7gVeOhbBdUvDXjat5n5jRDGtCixyzYDfP/IIZCrC9vLMfhSEiW5EYso9
         u5Ow==
X-Forwarded-Encrypted: i=1; AFNElJ9BCQnLPyI7+5VCsMUMEWtY+6DuW9iGjMXPqfjn5se56uAwy2JEPYVp4ApuQGq6oNDkh9XdJsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZlCacHmRLjOSR7B/NFUypdgMO3dhCiYizHWQF+xFomjm4l5t
	TtzgLtRQmgjUCeum+Gw4vpvKsbpPjhpnmqaMlBHLoZMsZeWdHAR051jWH8/4F1ap7+xp7XPNEjy
	ZHJmXR0A=
X-Gm-Gg: Acq92OGMwzrT1C6t/3sy75XEtlw41eG0nsfugYdY/pfUI5p/UCt1bJP4iXhdj4ZhCS6
	i9jwY2qYRTCP6526/p6afBmUBMHOqphZjRqnrH3CJuKi8t4Aqxyf4+qoJqnbuqd4O9SCD+lxxuo
	frbuSRg4xydFjOm2NFiu8AGiLlXFOCIh00XGbCjCFbaKanlEMpI/077lWV7VRu2WRlOgRBg+aYQ
	4G4jqT9JveXDnUL6BijOJ+879lzT022ZAXyHmmhEJBG234WI49jvBjl0ZLLiZHuYGIMzt9+NWKM
	8dhyRuestwKSIH9FNV/11RlXTWe48EhgBveuceTjcueYvD88ZMc2vsdVnobineghcZ5GvXBrnqh
	6yTzp16/TyRhhmsJ5xEx09KlAw0Cf1o/K3ptS+Jsf12rSCwDNUT6dY3J+vSJ9qBy1B2OUW+DMXR
	8n0WXzjLJmCVrg/NIBgzee9E4dJrVE0HoPSP8LGK0/JitjjOyOoV/IZVwOw3DBTf8dbO2BPo0=
X-Received: by 2002:a17:907:2688:b0:bc3:7b0f:91ea with SMTP id a640c23a62f3a-bd51785f7e7mr410674366b.19.1778952750879;
        Sat, 16 May 2026 10:32:30 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd2f67sm365117566b.7.2026.05.16.10.32.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 10:32:29 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67be871ed3fso2462613a12.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 10:32:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8CgKU98nkz3urtAxA4HYuId8hrD7OIZlXtBRWA4INSlMCv7Q9mGeBBlnoYHUbfm/5ayGzW7Hw=@vger.kernel.org
X-Received: by 2002:a05:6402:13d4:b0:67c:5745:ba25 with SMTP id
 4fb4d7f45d1cf-683ba93ae7emr4639055a12.0.1778952749527; Sat, 16 May 2026
 10:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
In-Reply-To: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sat, 16 May 2026 10:32:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
X-Gm-Features: AVHnY4Kka0j2IZtXlEubXEvbRLDshDfFW_ViyHQQNFc30kCO1qbUru6xi8FCkyU
Message-ID: <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field post-exit
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Qualys Security Advisory <qsa@qualys.com>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1038055CED8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249017-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat, 16 May 2026 at 10:09, Christian Brauner <brauner@kernel.org> wrote:
>
> I massaged the patch a bit and rewrote parts of the commit message.

I still don't really like this. I think it's disgusting to add a
pointer just for ptrace_may_access(), particularly with 99% of users
already checking the mm for other reasons _anyway_.

IOW, that user_dumpable bit was a minimal bandaid for bad behavior
without breaking old code.

And the fix is *NOT* to make the bandaid bigger, but to just fix the
things that are broken.

And Christian - right now pidfd is broken. THAT was always the real
security bug here. Let's not change exit just because pidfd did the
wrong thing and didn't check the mm like it should have.

It might make sense to change the 'mode' argument to be something more
flexible and something that forces people to *think* about the zombie
situation.

That mode thing is already a bitmap, so one bit could be "require it
to have a MM", but I think it sjhould probably be done in a way that
forces the callers to think about it a bit more.

There's only like 20 call sites: let's *not* add a pointer to 'struct
task_struct' when 15 of those call sites either already check that
there's a mm, or explicitly don't care and handle the mm vs not-mm
cases themselves.

                    Linus

