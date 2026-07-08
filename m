Return-Path: <stable+bounces-272622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DcWvNbIhTmo3DwIAu9opvQ
	(envelope-from <stable+bounces-272622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 12:08:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CA7240EE
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 12:08:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l2XG7Yxt;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272622-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272622-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B09D3016290
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7C038C2D4;
	Wed,  8 Jul 2026 10:08:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86EF3822A8
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 10:08:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505325; cv=none; b=PDN4A7I7RvxBton2f9e6hqg+Hafhc26e1Mf95W2/WRnLKI78KyyIMNimBKEGn0q7Z1/vs6kuubtLIHU3Gbj26/vDAykjJd5qjoOyZ/t/enwf5izxoTI/49rBxt9YR/G9QkI0Ef2LEwk0rOpXyDNqjGSxrXI08zc6/vc5sKFJq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505325; c=relaxed/simple;
	bh=kC3JKeJ0Wn/CEPl2CcvmIPkBEK+LAdN1ZPQISN+fXlg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA3cdeij3mh0NdcqbPZdh8nhm9e2sPhAqsPWezgduWbpMfKe9lBwaksfZjxXILOo7lbP/ueC8DqF7NJc0hmhc3tbPbTq+2h943LPujk5qa3Nwr46XjDvdEoNq7PfhCMt0N1NjVJ3FyNaVwqOX+MK3aUH6pZbzfXmhC2phtCfkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2XG7Yxt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FBD1F00ACF
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505324;
	bh=kC3JKeJ0Wn/CEPl2CcvmIPkBEK+LAdN1ZPQISN+fXlg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=l2XG7YxtIUnZTJtyRWgenjNhhD/419lELMrB2kDA30dtj1KjCy304QWFvoDDkT+av
	 AZyHsUsBD9FnlfjgpWxBTdgC0GixbfSkx/fn22V9Q6JhBrEkyPRRlGQEhuTjoHKai7
	 78ci+3EBo8dANNNK593EgU1702JNAlhxutSFHu46lDyefe7pS36MrDHGZxjjOUQ2wQ
	 oFO4Mhll7Dicfqafb2lQHSZ4H2OPu6+DHspJ4ZIQrXwsf5DnarKAyBVHNOnM6jMx45
	 jIC21VqV936h6Svxxdql64uZIY9l+HmBckR/3cTwtEgdAcklu/DDcnuNzXxNBWL3gn
	 dbswkK4ghysHQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c6209df17so2879751fa.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 03:08:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpkih3/fHpJNth6BdVy6QIvAyP8JggeK054XPo+KSOv/vmBnook31XTLm+o/9V49KYGgxLJO7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyECPHTBh2kXdz7QpMAMAYuIYWtDzTGThh64VDpNcGvYIErUekh
	otUqFrkmrCybJPRYUP48+gINVylzyxjRnwHYjvfe/XKeEqGjTzskgj7RKmLZ5stNORl5PLQ8ZiI
	J53NLEticFb7vUbL4gdg6YKjHj0FJxd9MK2bqsWW8Ew==
X-Received: by 2002:a2e:b889:0:b0:39c:7d51:70e4 with SMTP id
 38308e7fff4ca-39c7d517d81mr2182151fa.23.1783505323226; Wed, 08 Jul 2026
 03:08:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 03:08:41 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 03:08:41 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMRc=MfSMmzXnsOipfJvTQDGB6FtnpErmSk7S-bGnid3bfDi=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095459.12111-1-bartosz.golaszewski@oss.qualcomm.com>
 <ece47e97-0287-4e83-b9fc-294407393f82@davidgow.net> <CAMRc=MfSMmzXnsOipfJvTQDGB6FtnpErmSk7S-bGnid3bfDi=w@mail.gmail.com>
Date: Wed, 8 Jul 2026 03:08:41 -0700
X-Gmail-Original-Message-ID: <CAMRc=McGBr_6VZTSjT7azgdmdFjKoAeizXqFeOSw6JMoAv42Wg@mail.gmail.com>
X-Gm-Features: AVVi8Cc2ivIKvKUw7t_O00gsqze0UWEJcUUo7XmWOYGE58GGgD04tr7nBXY17-g
Message-ID: <CAMRc=McGBr_6VZTSjT7azgdmdFjKoAeizXqFeOSw6JMoAv42Wg@mail.gmail.com>
Subject: Re: [PATCH v2] bug: fix warning suppressions with kunit built as module
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Albert Esteve <aesteve@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alessandro Carminati <acarmina@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	David Gow <david@davidgow.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272622-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brgl@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:skhan@linuxfoundation.org,m:linux@roeck-us.net,m:aesteve@redhat.com,m:kees@kernel.org,m:acarmina@redhat.com,m:akpm@linux-foundation.org,m:brendan.higgins@linux.dev,m:raemoar63@gmail.com,m:david@davidgow.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.qualcomm.com,linuxfoundation.org,roeck-us.net,redhat.com,kernel.org,linux-foundation.org,linux.dev,gmail.com,davidgow.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,davidgow.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 608CA7240EE

On Wed, 8 Jul 2026 12:07:40 +0200, Bartosz Golaszewski <brgl@kernel.org> sa=
id:
> On Wed, 8 Jul 2026 12:03:31 +0200, David Gow <david@davidgow.net> said:
>> Le 08/07/2026 =C3=A0 5:54 PM, Bartosz Golaszewski a =C3=A9crit=C2=A0:
>>> CONFIG_KUNIT is a tristate symbol but the warning suppression code in
>>> lib/bug.c is only built if it's built-in due to it using a plain #ifdef=
,
>>> rendering warning suppressions broken for kunit build as loadable modul=
e.
>>>
>>> kunit_is_suppressed_warning() already has a stub for when kunit is
>>> disabled so drop that guard entirely.
>>>
>>> Suggested-by: Albert Esteve <aesteve@redhat.com>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning b=
acktraces")
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
>>> ---
>>> Changes in v2:
>>> - drop the guard entirely instead of switching to IS_ENABLED()
>>>
>>
>> Thanks very much. Works well here.
>>
>> Reviewed-by: David Gow <david@davidgow.net>
>>
>> Happy to take this via kselftest/kunit, but if you'd prefer it go in via
>> mm-nonmm, that's fine too.
>>
>
> I sent a v2 as suggested by Albert. I don't have a strong opinion on whic=
h
> one should go upstream.
>

Ah, nevermind that comment, I thought I was responding under v1.

Bart

