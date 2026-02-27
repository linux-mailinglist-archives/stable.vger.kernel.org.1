Return-Path: <stable+bounces-219885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHkNKanhoGk4nwQAu9opvQ
	(envelope-from <stable+bounces-219885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:13:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E91B12A3
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 01:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5414C300F7AD
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 00:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C322A817;
	Fri, 27 Feb 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+xPTXnD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9311F239B
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151202; cv=none; b=PYUCrHXgsY0vkWnVohEui3PSIBr6ZUX2PgU5RjS1BXSH763MU8XN9G1HBf5iAyFqik/VYwczRXA2mlmpbXSEIdP1rJzFqFM3QfTx4oK1LunUUQL4oJ+kg1hw1b+D/IGaZU0atxpGNXa138JsqJyBHxb7djyfJTKItIRyt/Fjddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151202; c=relaxed/simple;
	bh=qUqDumqrEysKvvzn7b3yuEIJM9ThYwDQsBhBjQ8cCkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gM7kzMRRdNoPYKxEW6KKPd+SL+MnbGEQx1J4klWUREmLT+1z/OBjsUwqFTXYmKSoFAbdrZt1xlV1BJlQ48O5LtwWuQqF5srpLI+xl2Bu0/Fq//5+xhptCViY/AJ4LGonEl7V7mj0Zk8XYV18lFuaBDdO6p2wWh3gXXjqXJrrFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+xPTXnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F148BC2BCB2
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 00:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772151202;
	bh=qUqDumqrEysKvvzn7b3yuEIJM9ThYwDQsBhBjQ8cCkI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k+xPTXnDVIVIwvqENi5DYFrB8YQuBOFN6KCGNxzN0nyBafefB/BMf+4SBS/eKB7uQ
	 +khEYXsX7PnP3n/W3s3haHRkNB19331nPz490eo+ETXxELZ5HdbXttramJDtJi74iU
	 1hT1PIbZPj9f1XFjVqWCDDCCBiegL/UZrC/m7za7VGEX2C43s4xfI2o1252C84HgKO
	 5e1PpBFzpgCv+Xa689OwxxmuusBmkuQgb6c8Zkbcb7M2/UH/1fgoVYGSp5Z0l3Z9Ed
	 850AIVqfI6Z9tRnGblj6IDxLZtFwquZcJ9nQj+gWTbPimY3QmuYDoUX93lxchqDAPV
	 CrVGSgeTGAFzw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7982c3b7da9so17411947b3.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 16:13:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX15535eUJddtJxVAwYHPZYui6uvhamI7jPEC4EN9V0U2m4PkHqiqUksw5iMSv8I5K1UQSnNr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBUSLQuTL6iwxEuIQASBAiq9L+sOjJg2LEekOs7exFU3DV8bP
	jeNDF5cifebt6lQPKZgmRCemepU8cChkNB5s5Pyy/KsUqCkCeG4+bA7wu7hjCBRW2piaIRkWWs2
	f+YcXtFCVwsDBZoFL2aFdQyTzfjV4Svo=
X-Received: by 2002:a05:690c:112:b0:798:5333:ce1c with SMTP id
 00721157ae682-798855090aemr11680817b3.23.1772151201232; Thu, 26 Feb 2026
 16:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
In-Reply-To: <20260226-i2c-pxa-fix-i2c-communication-v4-0-797a091dae87@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 27 Feb 2026 01:13:10 +0100
X-Gmail-Original-Message-ID: <CAD++jLky3BTqryNY4MkiLpLZKW-OZhG78tC8Gp67wXZ0WMpt6w@mail.gmail.com>
X-Gm-Features: AaiRm52Gm-BswzfmZ91rHxmFojNKjWg-xm2ljpTlm0-vUOMkdIUDq-NT6rw7rAo
Message-ID: <CAD++jLky3BTqryNY4MkiLpLZKW-OZhG78tC8Gp67wXZ0WMpt6w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] i2c: pxa: fix I2C communication on Armada 3700
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Hanna Hawa <hhhawa@amazon.com>, Robert Marko <robert.marko@sartura.hr>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219885-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas,kernel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C38E91B12A3
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 2:11=E2=80=AFPM Gabor Juhos <j4g8y7@gmail.com> wrot=
e:

> There is a long standing bug which causes I2C communication not to
> work on the Armada 3700 based boards. The first patch in the series
> fixes that regression. The second patch improves recovery to make it
> more robust which helps to avoid communication problems with certain
> SFP modules.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

OMG what a trainwreck this is, thanks a lot for digging into this and
fixing it Gabor!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

