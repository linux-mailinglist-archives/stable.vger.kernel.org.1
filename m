Return-Path: <stable+bounces-273148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PjP9ObOIUGqc0wIAu9opvQ
	(envelope-from <stable+bounces-273148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:52:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E447376DE
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 07:52:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mgml.me header.s=resend header.b=KgQcXfNM;
	dkim=pass header.d=amazonses.com header.s=zh4gjftm6etwoq6afzugpky45synznly header.b="Y/nb+UXU";
	dmarc=pass (policy=none) header.from=mgml.me;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273148-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273148-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 304C93013698
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCE38228C;
	Fri, 10 Jul 2026 05:52:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from e234-58.smtp-out.ap-northeast-1.amazonses.com (e234-58.smtp-out.ap-northeast-1.amazonses.com [23.251.234.58])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D82233958;
	Fri, 10 Jul 2026 05:52:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662753; cv=none; b=NaTYnuAKTcHNY6lMJBW2UXt+fy14h0jdST0EqwA4eB2Xrf6xVADH3pUZWBVy9wn6SlDl7+izlx40w7EM98B0AbY4f1wn78sGlUayZRaYkKo3tjR63HIYUIo8D5i4lraepZM7ZoYAI9bFaSJQz41JL+EJt8lmYrU+COrAj0rHi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662753; c=relaxed/simple;
	bh=vHaU2coOYNDoemaojTQSVEM0trILUAv0APHfkLpvG/Y=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=LLanNpY1IeT6pq/2gBvDsdPPZsbPl5c16A3J4+esbrhy13onvrtPXpAgMJb7GDwTU5m8OPBxh1HEXKC51aNTjgu/MLvYYz9QhiXflTZVq9PZhYeWEct1p15C0hFVKgplGbOaWeJPqRKVk91OK3EOSUQOX/xQqfVlu8xYcjvHfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=KgQcXfNM; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Y/nb+UXU; arc=none smtp.client-ip=23.251.234.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1783662750;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=vHaU2coOYNDoemaojTQSVEM0trILUAv0APHfkLpvG/Y=;
	b=KgQcXfNMHrF4yqb6DBMKwzIP9PVeA8vg2FVe7h8C5q+i6k7SvcofdvgaZYNAmFEL
	aVEfv4jXFzF71CTx6HHB2tBvsiRt17SpkdfSKDcK1ongvu7wlOgVcnVLpMoTuxulVPH
	n8oJoInUmAJSXYEmiowWIj48qMT0WFltu2WJQggM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1783662750;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=vHaU2coOYNDoemaojTQSVEM0trILUAv0APHfkLpvG/Y=;
	b=Y/nb+UXU2TI/ufSNzZVJW9GBwEk4azx0bg6VPOto3RVQhnr4sW3+at3N2QvcuQU1
	NBskt9CTKIUz5Deve6qHYYgiQjL3HVKUgxwB2BgnctPl+PtUttiNiZepasOFJC+56mb
	GhNBeouPFP3gZblJr5CFSljcantoCfqqNyVcKvUY=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <stable-reply-item009-kvm-515-20260627162226@kernel.org>
From: Kenta Akagi <k@mgml.me>
To: sashal@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and
 related issues
Message-ID: <0106019f4a95a94b-890f7204-aef4-451b-b01e-14aa58b7a554-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 05:52:30 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.SskAFE1oaJ7KCjyyJFCV37nkSRmUZttpeGoevLE2CszduPSq19CK0OWqrkMmPMemkYWmFvQfvS6+lCR9ETv8vDWvEFaQZtUQ69n4DuGGNbGH4U7i+CnKWCHWm/HpilUFxPcCpCRFiQTHPHnKlfimqanQj7AjyJ2y8XQuaQGs83Sl+MS5tJ/lS6+Uh2zwyhRo:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.07.10-23.251.234.58
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mgml.me,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[mgml.me:s=resend,amazonses.com:s=zh4gjftm6etwoq6afzugpky45synznly];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[k@mgml.me,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-273148-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k@mgml.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[mgml.me:+,amazonses.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazonses.com:dkim,ap-northeast-1.amazonses.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45E447376DE

On 2026/06/28 1:35, Sasha Levin wrote:
> On Fri, 26 Jun 2026 19:46 +0200, =
Paolo Bonzini <pbonzini@redhat.com> wrote:
>> [PATCH 5.15.y v2 0/8] KVM: =
fixes for CVE-2026-46113 and related issues
>> Please apply this instead of=
 v1, due to a missing line in the last patch.
>=20
> Queued the v2 series =
for 5.15.

Hi Sasha,

It looks like 5.15.211 (released on July 4th) does =
not include this patch
series, and I don't see it in stable-queue/queue-5.=
15 either.

stable-queue$ rg -l "KVM: x86: Fix shadow paging use-after-free=
 due to unexpected role" | sort -V
releases/6.1.177/kvm-x86-fix-shadow-pagi=
ng-use-after-free-due-to-unex.patch
releases/6.6.144/kvm-x86-fix-shadow-pag=
ing-use-after-free-due-to-unex.patch
releases/6.12.95/kvm-x86-fix-shadow-pa=
ging-use-after-free-due-to-unex.patch
releases/6.18.=
38/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
releases/7.1.3/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch

Could you please take a look?

Thanks,
Akagi

>=20
> --=20
> Thanks,
> Sasha
>=20
>=20


