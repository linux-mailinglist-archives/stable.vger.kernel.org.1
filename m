Return-Path: <stable+bounces-254145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJqZNadOFGqnMQcAu9opvQ
	(envelope-from <stable+bounces-254145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:29:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4361B5CB1E0
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9731A3038157
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8143859DC;
	Mon, 25 May 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzwczHsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D8383C74
	for <stable@vger.kernel.org>; Mon, 25 May 2026 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715595; cv=none; b=uNQJuLKLizxkQOEUVKrekE+CS6x1YkF/ox3UTtX9TWkNCs4SONFfw7fJ25qNJf+RmTUUzaJBs3i/HKJmJzemfVgc1Zd3sY8o/qOOwChe9eNVtVW4ckScQH6n1/k1BQPP2+/nI7L5nvpmI8NC463qJqEScgBCoFuiHAP4tl2SBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715595; c=relaxed/simple;
	bh=F/NF48u90Tx5XUcUreX0E+pKC4zLouLi3sdXS+N8lqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWVe7si+ZcTEefV7X4I2eNTdFHUrMboBAxgP040ptZE6sCaprecAU593sYfVlCiQgyjhVc4OTU0OkInxh9b46uSm6Hzf3k29dXrv2WMFfdpoAz1x7+bMyHq7zllJnWiEc1qY8tAyLp9DyMGyjhAR51QX+0wX/w3Q7tYCjq/cydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzwczHsa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C511F00A3E
	for <stable@vger.kernel.org>; Mon, 25 May 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779715592;
	bh=F/NF48u90Tx5XUcUreX0E+pKC4zLouLi3sdXS+N8lqc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mzwczHsaNb9dzWKnhQj/Yeqr7eQsbdF2KjBrtGW3tX9KSBvcpfbQNnlrbbB71MS6T
	 6hbMVkmRysDZHepi1OP6pJg/SC1YnTQhWv90bF7laaniSn3AmVLKgtXLiOSdcyQRXk
	 FmOc4UbjwK2R75q6LMqmStTUu3CUZflIiwDWoF5MgBolj/EgxtmypAIGtbFM3fecln
	 80Yt1eH7XY6iC5hPsqUAPSKd2JDr+LguePJLPlquCh4rZqdN8Ec69z/ICVzEadi6U1
	 XmtWkg9hrfJpKPOrzXfviYEQ3OUFUPD0ee8rdlVT8iXxYoNgXsIx8sQMmUAys59FJl
	 U5E9RYqhs/Q9w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8721851e2so10835746e87.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 06:26:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/MVNxdjsumO4b4G9L+TKLl7Y9uwqUw6+x2zZ2B4NULW9QdGrH6TIUbIKlbaoGmxJg8r2X7aWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsxt6AMsJonK6C0bRRjazZRgOyz5hDM8PDcqpnRR7kKx7OCefR
	IJVMljV7kPoRx45cnLmHf+UJFEk5040S/KTeoNAwv78pZeNVeI0GB13L3QyV8zH31T+grGUS16n
	mEU6gu9BYwVss7gNjpiLv6V+UFCCeOfQ=
X-Received: by 2002:a05:6512:118f:b0:5a8:6cbc:60f3 with SMTP id
 2adb3069b0e04-5aa323815a9mr4278899e87.34.1779715591117; Mon, 25 May 2026
 06:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-gpio-shared-free-vote-v3-1-8a4fddc6bedb@oss.qualcomm.com>
In-Reply-To: <20260522-gpio-shared-free-vote-v3-1-8a4fddc6bedb@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 15:26:17 +0200
X-Gmail-Original-Message-ID: <CAD++jLmaWhY_Ts0EUje6ZW_3jk77O9peafBpzMorF=ApmMf4tQ@mail.gmail.com>
X-Gm-Features: AVHnY4IayrmY9c3i6v1yRMZMDwtYy4PcKQqYcOpBHswrzmux7GAxsso0aG0ET6Q
Message-ID: <CAD++jLmaWhY_Ts0EUje6ZW_3jk77O9peafBpzMorF=ApmMf4tQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: shared: undo the vote of the proxy on GPIO free
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marek Vasut <marex@nabladev.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254145-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sashiko.dev:url,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4361B5CB1E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 9:49=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> When the user of a shared GPIO managed by gpio-shared-proxy calls
> gpiod_put() to release it, we never undo the potential "vote" for
> driving the shared line "high". In the free() callback, check if this
> proxy voted for "high" and - if so - decrease the number of votes and
> potentially revert the value to low if this is the last user.
>
> Cc: stable@vger.kernel.org
> Fixes: e992d54c6f97 ("gpio: shared-proxy: implement the shared GPIO proxy=
 driver")
> Closes: https://sashiko.dev/#/patchset/20260513-gpio-shared-dynamic-votin=
g-v1-1-8e1c49961b7d%40oss.qualcomm.com
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

