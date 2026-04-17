Return-Path: <stable+bounces-238393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KwEDAai4Wm5vwAAu9opvQ
	(envelope-from <stable+bounces-238393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:59:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C73416681
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70E4A300950F
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB683126C0;
	Fri, 17 Apr 2026 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDbNydmJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB92F12CE
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394731; cv=pass; b=opjNDuXyBCjcKXIssZ639+rjHJJw3NOaPuGuA3XJRv2laXOj9p6onGEBOC75WyOMuiyUL9F6YjPPAdcd8GlS3Fa16vZm+9tvjM6oI1zAiNFMfNqY2ko18pKqwJFYyQf5b5X5S4svkKSqMLTpfG9+yw9aAAP81J2cadLcq/xsUXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394731; c=relaxed/simple;
	bh=rR1liQlAztVMGE+LKdTCzP+X3Rl7c7twLoi7YOzzO90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcOpqRiPofx1YeCioR0Plzri2iRxNwYDLAxwCWzDFuSS4Nat1MFNFDgYDbSPeBy/6fY9JqNkTLuFQJ7dKH/asOm0lwAgDkn7f70A2GUNtYuIw0WSWHGSUT45ioFo+mEZkf7e6jHP+tG+bs/jHfBPHh6Ql8eu6q+jeWzaIF12GmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDbNydmJ; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651bc8f864fso153425d50.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 19:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776394729; cv=none;
        d=google.com; s=arc-20240605;
        b=LvsyWM2d0QL9ke4N3UVPAnDE4blD7LoQN2VgSQiMnqjriJRRECv5NgeegBjeSoImsE
         OxAw4po9qAYdRpCv9FxEFR85k/LzF9ulu1V4zVTLAz9ArYP0RRof+6mR+TYKyOTIlZxN
         L7yVKwtC6t4O9L6xaB/w8B2PWzS4WhqiTUbqjVFKQtJRGIRNUFSXm99t3jtg6rZT1cUL
         hM/9y7Onh7QieIQUGRHZHmY9NaSD9LvBOiqWUku1gzxAKHeUoWED3mbCqyh8YYC6BZcv
         9NLuRXlhv3dnRBT/qhnjAN+rjfuZC8G4/3SwoCPW0oQex6ygyCMbL4DTTWt6JwReMZLa
         MNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zMky0cVeh2idyOgOmX8kaKwnJVvVHTaqDBxjuS2oOdg=;
        fh=C9b7Lms+leP5klyRrSfO5f+NuDxTF6eoNQZeOhxsx5Q=;
        b=XFpWeYxxHXoWPHVeJ37nfHe02jqJxx5B2ROjYj+TnqQvli0BGmShN1Nawzs9GReGgQ
         aTiB9Uf7VvQKIChkvtn5tCPBTvPQZeee1fFoZtSTbxZMX72lGaCY6srFnuifbOhNQ0Rb
         gqE/MWwh37HS5nLJwNddCK1ZlP0u+IhalsjT9L0jXxQtQB69UdOSalQJspPXDAh0gFc5
         pvtjjFqXVNOJfrAd/SX+S21MuLOSSOoIC9u3HwZJNvPDvyGrKwT4lU66vBi9khDE9CZQ
         3CNOct2PLCuOSAQ7o5ulcYfTu49kTDN3o8nrj+EAUyaUWcLs+KchSkZidhOUXVDx/W/f
         DG5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776394729; x=1776999529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMky0cVeh2idyOgOmX8kaKwnJVvVHTaqDBxjuS2oOdg=;
        b=lDbNydmJsIBdhQ/ZKHbwlkhnkvCaSpOEfmFZ97Y2Emh4OZQdmHRjDWjWdN4FDmKEQG
         6HmG0hUrBYVtTjIIOh/05/ozo0I/y2PKngOjQ5L6d1viyflOKr7z8L8bu0ETdXBGqPlM
         yUoSItgqIVSvi6DVt307nDZ5VYPwr2CnsvNOmiqx50vUjDrad+CDUIzVmTBPINfHeotp
         ArhwFBK4e8/hAJdUkeMpOcahNypIar8xE6324GJ9yrXxu/8MlqLlHMQvJAnY/W5BCKzV
         4FTaKObGvRF33TfMyzNcfz6N7UrAboTZ8Kwk5tB1JrXMNzB8eDoYMbV296zAxYTEt+4h
         FnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776394729; x=1776999529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zMky0cVeh2idyOgOmX8kaKwnJVvVHTaqDBxjuS2oOdg=;
        b=U5WPIbgVhHeiAe723GgYaG1KK5JffVYNavrKXjuwThVEB2ZxxMIaGdbpxf/MFQrGtO
         11c0kE4BM1QPtK8Ok5XszIHMig2+yzcuHKogig1uY0jMXQUmsjIO9dqFdzrPyqdoTrmN
         1rBvFQzBpFZKGXJEfCg4ugBqCTcOznTXmqqoHK6uSinXaB9sAgwZQFRDIHlPEaDdWyQT
         EinMUQHIXr0Kv7O2gfKR1HTnk++7u3MG/S5COqEplSLGLRy1r6YObrl85NSK29iIP85E
         xUpORHdbK2dIbBmSY+lZRvSVLxxel+XQJ5Y/GQzG7O2rynHxA3ypIXwsSN0RTCgcqcqC
         Km6g==
X-Forwarded-Encrypted: i=1; AFNElJ/fQpCPWfWPO80ovJKt7kRRLQHZ0SYXYyvAfmqiqzpiMCjDAayNbHZ7vLmKRn6PYph3YZZ/rCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6ycUFJBbd4fwAz+tKgnr6fWN1c2AvY1d3q0z29ckrRh9Z46R
	w1un5QYpLYgD6l/xgdsOVdPOmNEAlvFtsfCZFqdUHpZz4Bwi4rlJbDfulTmAJxeNnQefAAyfB9a
	d/TPDyC1nKrRgQm9wy2Gkx8INCibdqgA=
X-Gm-Gg: AeBDietj7/9w7LNcL2Lj+X86AdPqjJzco69Dm9tBTEnKCYMfbqgh2Zn6qKvdycsuPpA
	OUzXHXjjB6zKcjrxpnnUVXyUQyUVrXss+M0e6BkprzM/W4iDwCjZa/9n4aWJN9FP9FOv8ZRxKO9
	KJWEkVoQ2n+w+aW9DYc25LJR5KsyRvJDqGGvBpIj0elNq6kvsx0SbwmI/9qXdV+w1wa8SDsd33o
	8U8baDXxLR2ScNhay4H8TfSKZ/t/MH1nnU6BIfiqTSVyLZDvqjrTEuEnqKuyKfEneVSI4t+LWJ6
	T5G/FLkpjzCl2ar2SBRFk3Q/j/Lc7vsN1Eyl23xapnvcWfk=
X-Received: by 2002:a05:690e:13c9:b0:650:5316:175b with SMTP id
 956f58d0204a3-65310b028f7mr1140874d50.52.1776394729349; Thu, 16 Apr 2026
 19:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416200439.2987930-1-michael.bommarito@gmail.com> <CAKYAXd94w_Mi0gzAKrHiMnV2LsVk-Rzo6JcGtXNbEJZG4xXF4Q@mail.gmail.com>
In-Reply-To: <CAKYAXd94w_Mi0gzAKrHiMnV2LsVk-Rzo6JcGtXNbEJZG4xXF4Q@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Thu, 16 Apr 2026 22:58:38 -0400
X-Gm-Features: AQROBzAQfRoNPv_BCLl4UjKUpp-kGov1M25b6YcO0KYyM5811sPTveZqffffwHg
Message-ID: <CAJJ9bXzRpb0-B8LwUNc_yx4ADt2CEzH_wSbtQ5CZP6K+YKS7rw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: validate num_aces and harden ACE walk in smb_inherit_dacl()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238393-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,chromium.org,talpey.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83C73416681
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 10:47=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org=
> wrote:
> There is no kcifs3_test_inherit_dacl_old function in ksmbd. How did
> you reproduce the problem?

Sorry for the confusing splat.  I pulled the pre-fix ACE-walk loop
from smb_inherit_dacl()  to simplify the setup in a test module and
re-used names from another harness.  _old keeps the original weak
offset guard, _new uses the tightened size, and the patched version
survives.  If you want, I can run through a full repro with qemu
tomorrow using the real paths.

