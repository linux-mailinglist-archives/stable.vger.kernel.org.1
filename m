Return-Path: <stable+bounces-215918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFeoGj2EjWmQ3gAAu9opvQ
	(envelope-from <stable+bounces-215918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:41:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A8312AFDD
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99A373093494
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031E2C026A;
	Thu, 12 Feb 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ud/SronE"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53328D8DA
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770882104; cv=none; b=rjDUZmD7K4KXWMyrm+hOHhWBIrav7ESqGJjgnj2AEPvUtbRpnxPswOjpfkPSgV5bdN4OdkoCyAkNZc4vEGw3EeAqlhcfhZvxSGuj6+JkEgAdojBv1wC3FWQuR5dg1YCRqdVxsoVuW5UplyP3c3u2F3BB1wEC3I2UVJUa+V2pxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770882104; c=relaxed/simple;
	bh=cEBIWJ3ehLrc76X31QYlb+TAKdMLaUZdC//PLRMTalU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cKd9xkXqxINi+QpoDpJnVia87tC5GuREpeDow2obU4BBi6BfipiKiTSguaR/SjCg0Nt5AwGinbG2eRUWhGz5JiXOI1jco4n1/92j3VqAr9bt5Uxq76ikC+AclvFvdCkkM5BokvX2dVB1qkf9ZdoixQEstFuseVMFxu69JSUttgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ud/SronE; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b866e72c00so2211107eec.1
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 23:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770882103; x=1771486903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VSf763pHNcy+KFpYTZlO2t/Xo4VPImXHxSKQSv4ZFI=;
        b=ud/SronEN8J6ZFlQAvpKkRhpkguFAmp5HK1AupddQEglWBqgtyuiusL2+2dTZNI6lE
         KnvBwAdy65jyAMbXHy2QwRBm5n1uk+jQzPf2ANs9MwaiMT54R/5ESbSxrRRnrDF9S5dI
         XEGN+rbQL3MJVDQTeIwSWISXEYgrmEQ+Qg+WiMksRnM16oOtKlA4PXBx4tFqeCBl7IS5
         JEt1kKxk+OFbRKOpRWzsSIHFiYCi9tAEqbwJDFN2BC+pGxKHr0b6/q6rDvNt4Ax00Rsp
         /RZN2MIUkRUF5kiaDW8i3sD6cYnPyR85VzrO3u3jex7JWuZr9LEc411YYRSQ+Cm35fb5
         g5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770882103; x=1771486903;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VSf763pHNcy+KFpYTZlO2t/Xo4VPImXHxSKQSv4ZFI=;
        b=eAGtik3xTeeRYjuZEUQdOA51x7+vzFeBhuCFZkEyYgJ73Y0r7pZbOwsZfdvqSXHp4u
         f47CRhbpH5vsmwWhFdbwx1hlc2euLu9Aqu1skOvA6/IHZgIy1kWdmymwU+1pjxp8zXc9
         4tFh6szTL+iyP/GMKxuCXf762LX77XxGkuzezuUos4zgpJl1ywAcBH09koyC+jzhXz7S
         k9ZBYn+dkd1UsRSpoO8c0q+xr5mPXIxIgwUvD3Vw7pEW3nBPfGSKLOyAH8SbjXVz78zC
         tMGzyyu/Cs1EmeSLgbrMNuN1X93/qQ7kay3jmKVqsviRz8SRAiHR/tPljwjIIeGDGteH
         rPYA==
X-Forwarded-Encrypted: i=1; AJvYcCXClnysPd8j/cEzHkzed0+IbrjgDE6ctXQcQJ04wZDtxNGDEISfn8eOF5BnVSNoiqi7P15SHlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ShNZNXgFaiQOiHppfUIUQHqcGLIW5l27tvuPGGr6U1ALUYXI
	jkILoprkqV4PcVOUCqBLEVQuOkpdUB/ZOCp2dpgUaNYyVUBny86CkADMmlxa0UTUbrVwRhFNvNp
	6/fmecot5OA==
X-Received: from dydc22.prod.google.com ([2002:a05:7300:3116:b0:2ac:1b2:391e])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1686:b0:2ba:96c3:ae5d
 with SMTP id 5a478bee46e88-2baac7bf3fcmr543737eec.42.1770882102552; Wed, 11
 Feb 2026 23:41:42 -0800 (PST)
Date: Wed, 11 Feb 2026 23:41:40 -0800
In-Reply-To: <aYxM9JbH1tlTtxqi@google.com> (Alice Ryhl's message of "Wed, 11
 Feb 2026 09:33:40 +0000")
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210232949.3770644-1-cmllamas@google.com> <aYxM9JbH1tlTtxqi@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Message-ID: <dbx85x82s91n.fsf@ynaffit-backwards>
Subject: Re: [PATCH] rust_binder: fix oneway spam detection
From: Tiffany Yang <ynaffit@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, Paul Moore <paul@paul-moore.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, Miguel Ojeda <ojeda@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-215918-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynaffit@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,android.com,kernel.org,gmail.com,paul-moore.com,konsulko.se,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92A8312AFDD
X-Rspamd-Action: no action

Alice Ryhl <aliceryhl@google.com> writes:

> On Tue, Feb 10, 2026 at 11:28:20PM +0000, Carlos Llamas wrote:
>> The spam detection logic in TreeRange was executed before the current
>> request was inserted into the tree. So the new request was not being
>> factored in the spam calculation. Fix this by moving the logic after
>> the new range has been inserted.
>> 
>> Also, the detection logic for ArrayRange was missing altogether which
>> meant large spamming transactions could get away without being detected.
>> Fix this by implementing an equivalent low_oneway_space() in ArrayRange.
>> 
>> Note that I looked into centralizing this logic in RangeAllocator but
>> iterating through 'state' and 'size' got a bit too complicated (for me)
>> and I abandoned this effort.
>
> I think current approach is fine.
>

Is there a pattern that would allow us to avoid so much duplicate code?
Or like... a nice way to call into a shared low_oneway_space? It's
frustrating that the two implementations are basically the same except
for how they iterate over buffers. I've been thinking of rust binder as
binder's chance at a fresh start, so I'm reticent to introduce this kind
of tech debt so early on.

I don't have a clear idea of what the appropriate fix would be here, but
I'd be happy to help do some plumbing if it'll make things smoother in
the long run!

>> Cc: stable@vger.kernel.org
>> Cc: Alice Ryhl <aliceryhl@google.com>
>> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
>> Signed-off-by: Carlos Llamas <cmllamas@google.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +    /// Find the amount and size of buffers allocated by the current caller.
>> +    ///
>> +    /// The idea is that once we cross the threshold, whoever is responsible
>> +    /// for the low async space is likely to try to send another async transaction,
>> +    /// and at some point we'll catch them in the act.  This is more efficient
>> +    /// than keeping a map per pid.
>> +    fn low_oneway_space(&self, calling_pid: Pid) -> bool {
>> +        let mut total_alloc_size = 0;
>> +        let mut num_buffers = 0;
>> +
>> +        // Warn if this pid has more than 50 transactions, or more than 50% of
>> +        // async space (which is 25% of total buffer size). Oneway spam is only
>> +        // detected when the threshold is exceeded.
>> +        for range in &self.ranges {
>> +            if range.state.is_oneway() && range.state.pid() == calling_pid {
>> +                total_alloc_size += range.size;
>> +                num_buffers += 1;
>> +            }
>> +        }
>> +        num_buffers > 50 || total_alloc_size > self.size / 4
>
> The array can never contain 50 buffers, but we should still keep this
> check in case that's changed in the future.
>

Now I'm second guessing myself. The existing structure would make it
easy to use different logic to decide if something's spam depending on
the RangeAllocator and that might be helpful!

Who knows! Not I!

-- 
Tiffany Y. Yang

