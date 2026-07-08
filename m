Return-Path: <stable+bounces-272620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7OQLLtQhTmpEDwIAu9opvQ
	(envelope-from <stable+bounces-272620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 12:09:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9221D724115
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 12:09:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xd+P5Nbr;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272620-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272620-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9E6930267B9
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C293438B7;
	Wed,  8 Jul 2026 10:07:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE837C936
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 10:07:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505264; cv=none; b=i6JK4FVqddr09corSyyV0/utCY3FsSIZcrZ1aidtF6Bp7AouS5rE2wMMtSJSzXC9HtYBXAJRmM8wHjf7X5+e/s+gCoRMqDrQjKEvTE4GNaTfIwXbNRJC/vBlvL4o8eBib7UZ6uKvvKmSYuZGGJ+oWVf/+UKiLYwBnBp2atTTBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505264; c=relaxed/simple;
	bh=1qkcjBIfbcNWm48MG23VXF7DyZGMyiuQnaU1T34dIQM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8bzEX2slmnjl6QQzB6saMqTO9O3dZffipAHFJoKorR45QvoZQzDMphaoZJm5JlGR5mP3s7DkZMMaKyp+Kv97gxAK1KXvaez+bDsTfA3hv0m3n9dC+bf0Foj97oRbbaBNnMiZUqPqiooTYKUQOFKHEQDe6yioYuazy9mIdFa4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd+P5Nbr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06C21F00A3F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505263;
	bh=1qkcjBIfbcNWm48MG23VXF7DyZGMyiuQnaU1T34dIQM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Xd+P5NbrYYbBPeZyIeWioVteK8iIAYBiO2GHThMz3MQ6BxwM0+8238HbvGqOK5rjg
	 qfHOxR0vb01o7xgK72bCcwpT3q105Ux09/9j2aQQHxtTBAagq7TKVuLyjCjm6dRHmr
	 mdUUdmLw7Puoz/YVAxqsLAhwT/+a5P9OlSNe6mhZWb2Iw9OBhTbK6UefBBPfWYDH3s
	 YIc1c/XyY5atgR9787utbeWOpEerdKiXjMbjnTKQ7IAw/1k6W2RRrSInDo1e4h78pm
	 2Ef2KShIY2EcAiPPgPOwLLc1iMOSw+FzmVql6OePWFElC9/HxlNfG02WJyjIK2BRgF
	 awjZ/7Au1iXew==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c65bde4eeso3916211fa.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 03:07:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrxjA9g9ICPPbxcNlf+wjsExWP950KnEd8pkMFJubcsztVLoJJ/R9fCfBTuRDGFWo184nebyb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxammLkD9ThD0OCI9g+/DrmaH68Du3wUondlQRokoSAXTjckSzz
	YJNULTdHIIKh+v117ok2rmOsKKf5HLi9ZL6mbjH60Mnxs4B6YCGm0y4gXPBRKhKlyPh5xih66AZ
	aPr2T4LpEQUCnC9LLf4PMxBPf5iOSBXK5peWu/YPOUA==
X-Received: by 2002:a2e:bcc6:0:b0:399:87c9:4573 with SMTP id
 38308e7fff4ca-39c79a15074mr4505271fa.22.1783505261713; Wed, 08 Jul 2026
 03:07:41 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 03:07:40 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 03:07:40 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ece47e97-0287-4e83-b9fc-294407393f82@davidgow.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095459.12111-1-bartosz.golaszewski@oss.qualcomm.com> <ece47e97-0287-4e83-b9fc-294407393f82@davidgow.net>
Date: Wed, 8 Jul 2026 03:07:40 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfSMmzXnsOipfJvTQDGB6FtnpErmSk7S-bGnid3bfDi=w@mail.gmail.com>
X-Gm-Features: AVVi8CeVRdkZ8z6wRoAOxG8XT-CMZbU8H7DKdkDiAdkSqkcQKplmq4WyL2m445w
Message-ID: <CAMRc=MfSMmzXnsOipfJvTQDGB6FtnpErmSk7S-bGnid3bfDi=w@mail.gmail.com>
Subject: Re: [PATCH v2] bug: fix warning suppressions with kunit built as module
To: David Gow <david@davidgow.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	brgl@kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Albert Esteve <aesteve@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alessandro Carminati <acarmina@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272620-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@davidgow.net,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:brgl@kernel.org,m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:skhan@linuxfoundation.org,m:linux@roeck-us.net,m:aesteve@redhat.com,m:kees@kernel.org,m:acarmina@redhat.com,m:akpm@linux-foundation.org,m:brendan.higgins@linux.dev,m:raemoar63@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,oss.qualcomm.com,linuxfoundation.org,roeck-us.net,redhat.com,linux-foundation.org,linux.dev,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davidgow.net:email,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9221D724115

On Wed, 8 Jul 2026 12:03:31 +0200, David Gow <david@davidgow.net> said:
> Le 08/07/2026 =C3=A0 5:54 PM, Bartosz Golaszewski a =C3=A9crit=C2=A0:
>> CONFIG_KUNIT is a tristate symbol but the warning suppression code in
>> lib/bug.c is only built if it's built-in due to it using a plain #ifdef,
>> rendering warning suppressions broken for kunit build as loadable module=
.
>>
>> kunit_is_suppressed_warning() already has a stub for when kunit is
>> disabled so drop that guard entirely.
>>
>> Suggested-by: Albert Esteve <aesteve@redhat.com>
>> Cc: stable@vger.kernel.org
>> Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning ba=
cktraces")
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>> ---
>> Changes in v2:
>> - drop the guard entirely instead of switching to IS_ENABLED()
>>
>
> Thanks very much. Works well here.
>
> Reviewed-by: David Gow <david@davidgow.net>
>
> Happy to take this via kselftest/kunit, but if you'd prefer it go in via
> mm-nonmm, that's fine too.
>

I sent a v2 as suggested by Albert. I don't have a strong opinion on which
one should go upstream.

Bart

