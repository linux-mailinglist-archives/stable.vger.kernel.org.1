Return-Path: <stable+bounces-232831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJAXKGBTzWkMcAYAu9opvQ
	(envelope-from <stable+bounces-232831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:18:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38A37E893
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 20B2F303FEB4
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48F47CC91;
	Wed,  1 Apr 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e47uZky8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyMHXd9B"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA022D4E9
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063858; cv=pass; b=F8i4KwvgXl6x8qj4SjMcnBS+Za92SL3yT67toHEClwRXD1fmSA1yp65EL5Tpqg2vj5NmM3vODBdC7v7NDJosoo1NFgdFqZb+2U8y+ukSh9a3QkGyRvIqMWKwBdgcbjTXlG7nS8jrqPqOYdnkEgTgmtYatTbfXgaol1HYBF28KMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063858; c=relaxed/simple;
	bh=YLA8Bxr0qjhGeJBT1dfMNIXODC0ytUsNS8MvnzBHm54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE0PPwz1tRjY4yWFHB0pgIBxHreFMFJ7kyqDW2yeHWftcTk4/ubTGMMLJLvoMOErHanfW8MxUy1FP7hlzh5Ih4RLW1FCe0h6MF3qjfJWhs+0wW1YAXDGQpbYGNwwVwFamPFy8Cy53BoR3gSh3lAKs7pKuuDkaq+i75IKbfuZrZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e47uZky8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GyMHXd9B; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775063856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guYSzBv4ZfXSiUmPyjqlFgw8GTvAEvrhowJxXPh2gBY=;
	b=e47uZky8b8og1419ItyKH57WfUPY6sa23pQfTOkbYURBksWRwURl/ouw9OzVPMVNPHzmS1
	xOr0Pg/Co6/TsL8NMsS1A12mBYaUQ+THWNMsfs7ZK1XfM7bq0c1UQ4SVfLZnxaKDBrwCV0
	690GZYB/Nj+md1Kd3wu6dtiAySidP7M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-i13UiDvaMoKIMnoEHCgPQA-1; Wed, 01 Apr 2026 13:17:34 -0400
X-MC-Unique: i13UiDvaMoKIMnoEHCgPQA-1
X-Mimecast-MFC-AGG-ID: i13UiDvaMoKIMnoEHCgPQA_1775063854
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d034589d0so23119f8f.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 10:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775063853; cv=none;
        d=google.com; s=arc-20240605;
        b=MsqaN2BFA5U0Ib3sbHxeiiW6W7bHGegp7wnpT6wexO/aTlNvqzcgaQaP7GxS3CAu0H
         ScwWzCvjzNoDSUXBk9eqSAxo4QyOUpOGHHfCKkPosAjadsFcvAWRIMF+RhERHA1RBXAv
         16c6mEbd13Us8hqVMS/idGoOnwlT5AKsUL3T/3GSGg38mr96tBtfo1jUD6uHVt5eyjzy
         1jFJ4iUPnqcDAxj66kV8K9BXIRYcwvg9OMNp4/jhAuR/8kvr1WbIOgA+VQlLPUV6taLx
         mmtDdBX7U6ItQCctkaK/8vi59wMw7qFK3YD38yOZ30tZ8KQlJKiclq8jOccB0gxeBmaG
         O4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=guYSzBv4ZfXSiUmPyjqlFgw8GTvAEvrhowJxXPh2gBY=;
        fh=ZWOnm4fierVhrnhhVp33OPHA4NeLLpBr9TGy+87h9F8=;
        b=ef3dlSkb3owaPEHsLWXNiqaWzC/HPHkAquHnA9FV3XCGXyU6mqPC5e0wGrLB9rL707
         MNyrnWV4YxMInrkNt1pvQmzVzhVnc8q1DUHNSo3dndQ1yLEZSv3zlpcL6kzfiFPD5DXx
         3T7Bjd/XgXrGYtfdirQVG66MvysK59Hd+aVKG7glPbhY/q0cxukIguNLmaaEnjK5j2A4
         ihPclJ3w+7KbG2/GSOLwPeuM9zeM1Ckh7oJWYlY7xHbAZKzblCauk8NzssR4nOZBjtT8
         hVX6rLH8MCdO9vD2XO5EHXKPgVQXEP4b8M2eJWck7FQYipDOSF6x7/qQbPZrtWZRyadF
         iGBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775063853; x=1775668653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guYSzBv4ZfXSiUmPyjqlFgw8GTvAEvrhowJxXPh2gBY=;
        b=GyMHXd9BXTHtGBZvInn8507/ZVtWc5+OAjpodmIFJJ9U8S91FBcwCVzFuM3yhCNSM8
         jQy7MrdmH29CaHRQ2g8E6wwGQaT6N538o4SaV/4Uq4+3kU5RaWh4juXb+yqkhe16nSUM
         sUozVy5CEf51sdq0YsTYhng2UCBLlkUNuFJbPuWZmvTxjD51W2GbIHNxxGyw/B2GtzPm
         ujHPThgU7SvkEXGPGzsci9hxMapAFjlrJveGYdDeUiiWdz35WC6hgkGu/l6M4bf2GyK6
         kIipJh/zSFFmVgjTtu+/v9CeekRkAqv6AoLbXIE0N5f7NbGl7gUVYWksBXL1wUvJlhCX
         AdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775063853; x=1775668653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guYSzBv4ZfXSiUmPyjqlFgw8GTvAEvrhowJxXPh2gBY=;
        b=q+7NeW1wRTh2kGrZVHBSXoZYrZglmdIUcpFEUKlnvLJMEJEYffJmOTZlnqwDK3OH/P
         6XICGei/UZ3YiiMl/j2qT0+UqczvYXlq/WFcLd7PaoNIsat40IvkgqU2GsgbUSfEU87N
         dKhniScWJyeLjSMNwEKY0WqKRMfHmAocjsh3UUdoAeBbEZWpNUFC0GN46sq1NKc5iGlH
         3SlLaeGqkR0qwugeob9kttclbztEuT+pJKFOCQbAcy42A86Kn91DHW9f35wT/kONyOwL
         ZZoqKUD1B3Gm7NXD3T8VvLzdNbPzqoEvc4xZz3NgZeRpd4qVuhVg+mAySopW5KBzlV2+
         y6pA==
X-Forwarded-Encrypted: i=1; AJvYcCXxa3qke8Oa0d1bJxIeBiH1bl8OFzFdJTMmWKQCDNrac4kf0uoU/lDSwado4Sp6C3pgplzePEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnpP+ZCby2vmk7s18zqZkrpFMUYZCvqQzZQlTzLJ6mlQJwKju
	cNbmJFuGUbNv0fX94OmPPemjnUMsW80g0V81fC/7YLZzXUIkb6SDtXkG263ON7UtMvOZtM+ZPxq
	iRSCqV/VdtWUYgVBsPCN7AU4efKJKxcCYQaSSalEaQ6mKwL0ibXCjSdd7CZkz89NH6csZxq0TEU
	d6CeCSsAza1phRe9WtUJGlSzv9pMQrQedVuv3hJeBEEeQ=
X-Gm-Gg: ATEYQzzoqlizO8DQ828NM/sQURPjp6KXob04bxhHkg9pq/kc/8KDdLusxT8+2eNL3ht
	fducQCDd3n01cVnn0IrxClwlKYvmUxrf0aFkb3JhnjwSxVhNbOFBe1nN8E6oZKlI5P+Vk1Sadiz
	JIyCXvUcE758cEv9nB89ibMslL6cbUYQLLCgLSiXCkki2Lt3u+PpAHCvf+BczbXIev+WdflC79U
	GW9uBBA9K+3D2ArHjae1IA9AtLC0Uv6CyGDb4K9HAEavM1btK+kAulxH6AnZ/Q07bq2vevbmoN1
	0rf4
X-Received: by 2002:a05:6000:2586:b0:43d:30f:122c with SMTP id ffacd0b85a97d-43d1504d1f5mr8918897f8f.5.1775063852762;
        Wed, 01 Apr 2026 10:17:32 -0700 (PDT)
X-Received: by 2002:a05:6000:2586:b0:43d:30f:122c with SMTP id
 ffacd0b85a97d-43d1504d1f5mr8918848f8f.5.1775063852343; Wed, 01 Apr 2026
 10:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
 <ac1OXbMbAY4snEPg@google.com>
In-Reply-To: <ac1OXbMbAY4snEPg@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 1 Apr 2026 19:17:21 +0200
X-Gm-Features: AQROBzA7J9iEyyUEEArbNfiwRRdKe1_iXF1bfQR4_kkhyOWkd834h_Vr9iUaSzg
Message-ID: <CABgObfZJV5hU_7WoPWLRH3-EvKts+UBZOwtCXmwVZYJP8dDo2A@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race
To: Sean Christopherson <seanjc@google.com>
Cc: =?UTF-8?B?7ZmN6ri464+Z?= <jeon1691951@gmail.com>, kvm@vger.kernel.org, 
	gregkh@linuxfoundation.org, yosryahmed@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,google.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-232831-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F38A37E893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 6:57=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> Eh, I wouldn't call this dangerous per se.  Problematic, sure, but AFAICT=
 the
> host is never at risk.  My official stance is that any panics due to KVM =
WARNs
> when running with panic_on_warn=3D1 are NOT considered KVM DoS issues.

Yes. More in general panic_on_warn=3D1 is only a good idea in two cases:
1) because there's a much bigger vulnerability that you know about and
can't patch, and you want to somehow mitigate it 2) because you
(relatively speaking) don't care about availability, which means that
treating WARNs as vulnerabilities is misleading.

If someone (like a distro or an Android vendor, I don't know) sets
panic_on_warn=3D1 without having evaluated (2), it's entirely on them.
(Please, no bickering about the definition of vulnerability. It's
perfectly possible for CNAs to describe configurations where reduced
definitions of vulnerability apply, and "the user asked for it" can be
one such configuration.)

> KVM WARNs are 100% worth fixing, especially if they're guest- and/or user=
-triggerable,
> but the WARNs themselves aren't security/DoS issues, because in my very s=
trong
> opinion, allowing use of /dev/kvm with panic_on_warn=3D1 when the platfor=
m owner
> cares about host uptime is user/admin error.

Yes.

> There are many, many nSVM issues that need to be fixed, many of which are=
 functional
> problems for well-behaved setups.  For me, those are by far the priority.=
  I also
> want to fix the a guest-triggerable WARN_ON_ONCE(), but it's not urgent, =
and not
> something I want to spend a lot of effort on with respect to providing an=
 LTS-friendly
> commit (though if we can get one cheaply, that'd be great).

Plus in the presence of large-scale refactorings and fixes over the
years presence of issues is hard to ascertain mechanically. Older LTS
versions won't even have struct vmcb_save_area_cached and may
incorrectly register as "not having this issue", while the actual
situation of nSVM there is much worse than top of tree.

And for the same reason backports can be hard to evaluate. Sure WARNs
tend to be of the "ok, I was overly conservative and didn't think of
these circumstances", which is on the easy side, but there is a reason
why KVM requested no stable autoselect.

Paolo


