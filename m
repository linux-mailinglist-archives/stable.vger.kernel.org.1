Return-Path: <stable+bounces-249020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMF3MoqwCGrz1AMAu9opvQ
	(envelope-from <stable+bounces-249020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:59:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC3D55D03C
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24AA13014BED
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224C3E51D4;
	Sat, 16 May 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7y8+daA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE3D379991
	for <stable@vger.kernel.org>; Sat, 16 May 2026 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778954318; cv=none; b=E0jdoIgGFP9opZ60Lt8aDxhbDhP4may4oBqb8D3r437YHs29p0BeqarPLQYnyWK9hRyUu1kSwK+JwBxvKp1lnrfgdxdMk34AqqtxtSQtZrNkjLuYp/SE2EgGYaVbMLXNSNdILVzQrhGDcEQ7QZLm4h77s9HH5c17FCmhvTzaOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778954318; c=relaxed/simple;
	bh=j6UcsyYEwqrgKLf5qbICeLM/y+q8YM5+OtUI5QIhPKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h49Y9Y5ag8DiY1DShD0YqXFA1mlm7QUjWzJxH2yJVd84MPtqqonCdrsE5OcZ7cM4qJbkyG17CyCC9u8YJHhoObN6yhrbdJnhrx+urb05+dCEjvT+VQ3CIhUkLXoXej/I4ykVxvVryc8Pp7U9c4MzS9H55NvOkIufdm7KsFp8NZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P7y8+daA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bcc2b199c17so120183766b.3
        for <stable@vger.kernel.org>; Sat, 16 May 2026 10:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778954315; x=1779559115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGwTJ4BAHlzloa9AqYm3GmL0/jhInuFYHO2ONjIcdOk=;
        b=P7y8+daAHmYgcrdKe7Qd3XVyOTKpb18PKmyf7lBw6rzFehNchjWWSBDlZdd0+6RCRq
         PPtY3W5jNxacp9zqZzMzxvz1SYarAUb30BW0jNdWBV8zyi1EZ9owQI0E2vIFDvw4Jluy
         tZANpIm3r+/xURtYPMe+FRhLy2DFzk+OgvWpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778954315; x=1779559115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGwTJ4BAHlzloa9AqYm3GmL0/jhInuFYHO2ONjIcdOk=;
        b=QRtKK22LhCcCRvLJhj/cjrEyv6DKSAZ/qEnwhIXn8lWCOVYf9DoBQkOrXAOYBdl37z
         bGc7meDY2MgG1RECbHrfdH9g3SQVnhvJm6/M461HS95GrpDy/7xEzh3k6EUrLqTTJAw4
         gNiwQIYzLPDtg86tPmMmilfVRdWAJJltbCQ9s4m3ZAVDTy5ltfXwyREfnx6sHhJFZM79
         4B+0UsqaWJYhtPXvhElspTPoUeuKJuAmsM++eAsqOtB3rFHWAfiNLLMDCCq6IGwdRG6r
         Do5tNzK2B2IGDvT7halbAoCiC6b14zS1splrDmZqAjImXnQQqFjARyH2t7K4rbOacMAz
         boIw==
X-Forwarded-Encrypted: i=1; AFNElJ+5AjzpmhtGLhosOcGHXT2wkxX+QA3b4gQnkDBS8iVidwfwxkE3VW/P4zL/q+Kt1hhQ+xl/bzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0m/CNNdNxRa0GHj9L+AIUgX1AARkxSRfYX7re2ZGWI3h2HQ+/
	9/tyitUKngJQjHzYrTYL94jyRNZGd1F20BEj8ZN0O5eQPnI/8UAC7qQihqmOAc7KCPwL0bfhB7B
	/MXcoU9c=
X-Gm-Gg: Acq92OF9wjQCowu16yRNWQoFSPrlU9ZKWLp1lUJlsMtk3WG+JQcwhjfZG4YZzA+JhAR
	KH43wiIJuJM6WzhUMub/IXO2ZFmMnPE6+FASPAO52jgUQ9v6LS52NfOFOFOHyCe0F9t+DL1auzJ
	6VG/Y4DQfLvHh0x/1ShAW2u8uE12OCff3b80oDdkNi9D1NWEeSVr7akeO96clfZHWsn3sMvyKVw
	kYHSkPwVRHw8V75a0GQK2I2BbF9eCOGvOOMO0SeADf2rKxsT5ZLlbjKpG/dVc83v4I8M1u+q9vZ
	j/0E6JN7nHf3eW2uZFMtmWAIsBH9ryyfi6w7qNVZPYaZwTd4i0iUCbJkpJhawksPbE0CvqDT21m
	TwfR1x4RACa8IunpQHj0TOzeHq2p2LmypNXGKXPBG7NPFTqQ3geYF1PsBCgsjNbSEr5g3f2tbQZ
	T9t6U2zgOoeGFxIBUZOWys2HEoN+zl840HVWqPpP6ta/3HpcXCYlRnzxGsj0ShCCA8wC0Tcp8al
	Jl3jF40wA==
X-Received: by 2002:a17:906:6185:b0:ba8:a21f:9c4e with SMTP id a640c23a62f3a-bd5177e0935mr467027966b.11.1778954314837;
        Sat, 16 May 2026 10:58:34 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c31494sm370490366b.20.2026.05.16.10.58.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 10:58:33 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67929ff6dbfso1730097a12.2
        for <stable@vger.kernel.org>; Sat, 16 May 2026 10:58:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/dunVb+CEb8AsU/kLhInROG5dU0xgwnRFkEETS5GSoq9gsaLaPFXl1+OgB8uI5NiQPllu5xMc=@vger.kernel.org
X-Received: by 2002:a05:6402:13c2:b0:683:1cc8:84a8 with SMTP id
 4fb4d7f45d1cf-683bd28ac44mr4486474a12.12.1778954312490; Sat, 16 May 2026
 10:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-work-exit_mm-v1-1-76bcc7c2439d@kernel.org> <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
In-Reply-To: <CAHk-=wgvUW=1qtJxYcvbA_WaTom6n73nT7S_=7tZd0bo49BNOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sat, 16 May 2026 10:58:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-5WSdzg_UxAFSRtjTUfscATJ8+1R3Pqvw8=-KKLmQCg@mail.gmail.com>
X-Gm-Features: AVHnY4K6Ktb_aIH9HBPMrhx2OrcbL7_dXcucaUZ04bAao-kOu4bqIibcgFQVmBw
Message-ID: <CAHk-=wi-5WSdzg_UxAFSRtjTUfscATJ8+1R3Pqvw8=-KKLmQCg@mail.gmail.com>
Subject: Re: [PATCH] ptrace: keep task's mm around in separate exit_mm field post-exit
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Qualys Security Advisory <qsa@qualys.com>, 
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4DC3D55D03C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249020-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Sat, 16 May 2026 at 10:32, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> That mode thing is already a bitmap, so one bit could be "require it
> to have a MM", but I think it should probably be done in a way that
> forces the callers to think about it a bit more.

The whole "fscreds or realcreds" bit is completely broken too. So I do
think that we really need to just fundamentally fix
ptrace_may_access(), and change the calling convention.

Just as an example, look at proc_pid_wchan(). It uses that

        if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))

thing, and that's pure and utter garbage. It's a very traditional bug,
but it's a bug.

Why?

Because the creds used for IO should *not* be the current creds. They
should be the *open-time* creds. That code shouldn't use
"current_cred->fsuid" AT ALL. It should use file->f_cred for
credential checking.

This is a classic mistake where you make a suid binary a file you
opened - open it as regular user, pass it in to a suid binary as
'stdin' or 'stdout'/ 'stderr', and get information (or overwrite
things) that way that you shouldn't have had permissions to do.

The user filesystem creds should be used for *open* time checking, not
for read/write time checking.

Now, this wchan thing is a case of "not really impotant enough to
worry about", but it's an example of how this ptrace_may_access()
interface is fundamentally broken.

So the problem really is ptrace_may_access(), and that thing needs
fundamental fixes. We should not add exit_mm to try to paper over the
real issues.

                  Linus

