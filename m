Return-Path: <stable+bounces-226122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGUhFD6BuWmxHAIAu9opvQ
	(envelope-from <stable+bounces-226122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:28:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E651B2ADF5E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC3B7300901E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4E3128A3;
	Tue, 17 Mar 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1oilQ2R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253FF312837
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764584; cv=none; b=GUcZ8eXfps5Q4M3Tb0RAu4cqoEqq42nXsvWayqXTgaEH8ZBcktU6ghLf1S3TUvgsY+PU1W59MsrcjzZvFBbtp432RNI2Gt4pkc7eQqqBMzS3A0rx29+AauSp79+HEcaIjj7WzMPIrwzCVMLubR5LpcTzSvh8vJIXiHgTGK9Ynac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764584; c=relaxed/simple;
	bh=A8Zxzj2VIVs7gCjiuA/V62IbfaThIn3OZXBZScVzyTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxzJOn5Dbmgoqv7kc47/FoxMYCaUMuOEhlmJmmsmkW57PkZ4k6eoLNjQA98GBOrQJVU2KudAaY7P+sakXfUvfShXWQmWi8e9+eCFeNZgJGYr9QpC5/LdL5I968M+kLm9f8W1glFvZswtS9doSO+i3+jF9vEcPuUWBE32DHEKods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1oilQ2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F08C4AF0B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764583;
	bh=A8Zxzj2VIVs7gCjiuA/V62IbfaThIn3OZXBZScVzyTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n1oilQ2RfVsehzR1BSrE6fgxSTW2dQE0AuT+mhDnN3iMPS7tR7GIDgbhArz+7fqvG
	 quPXg4MNIyX+jzqJMQ/zZ10LQdr3OW/hCkQaQfzNUYR70OY+rAvq6fjPDGjpnID8FR
	 +MXH/8dlIhFagd1PipESy5lYWjQ7+JgOUr2GSqGYHZFow+psiatdybX0vFMfjVDElb
	 Pgy0wr5jqe6ZJS0n6bdg/LXTuVRWnDC5u1qRwNite/yAfUPdRcEvrLK1Y88G8sorn0
	 FedHOExohhq+JDObmMdQKPI2AOtqH4tkdVrUfYTFaNqBm6Ox2Zz9Kp0GZfCykNZe8L
	 FsRc6Yd9UXlpQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-662efd1bdd4so39619eaf.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 09:23:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuVIWZSK6+u8pICm0cqKcMvgBn0LkkXHKe3nuq32euXLkDGuMFEF0lsN85+RTQ+0XBbtdmMUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnYSiimAZv8WDWt1hvuBXwEe1ChXrJ0qLUHrS89LhlNquxv9R
	/Zs3vBgEUfJ09WyuBI34pDyCeSqvdQUMeCey0QDvLq+5Pu9u2hgzVVcgQI6aYMxG0ZfuhabasaT
	tgvjwS/VewuhqIOLGphDcBrKCVyux7yk=
X-Received: by 2002:a05:6820:2902:b0:67b:af16:488a with SMTP id
 006d021491bc7-67c0cfd4c10mr142151eaf.13.1773764582291; Tue, 17 Mar 2026
 09:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CAJZ5v0hwO16=mP_vB=wi7x8CjROAw_Nd_Tq-hEohrDW3C58RbA@mail.gmail.com> <0f92ab73-5996-4977-9ada-e8a26957110c@kernel.org>
In-Reply-To: <0f92ab73-5996-4977-9ada-e8a26957110c@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Mar 2026 17:22:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iw3aaboh83wdOyYpGK9LkNafbmdU3zhLXtxrbSQU9-_g@mail.gmail.com>
X-Gm-Features: AaiRm50hNFkNvSW2ZboUnTv_v1gMXj6WJgZAzhbsC1wLCWGL90Y_OtahDKKfqu8
Message-ID: <CAJZ5v0iw3aaboh83wdOyYpGK9LkNafbmdU3zhLXtxrbSQU9-_g@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226122-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,linuxfoundation.org,vger.kernel.org,linux.intel.com,sang-engineering.com,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email,intel.com:email,mail.gmail.com:mid,sang-engineering.com:email]
X-Rspamd-Queue-Id: E651B2ADF5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 5:20=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On 3/17/2026 5:11 PM, Rafael J. Wysocki wrote:
> > On Tue, Mar 17, 2026 at 5:04=E2=80=AFPM Douglas Anderson <dianders@chro=
mium.org> wrote:
> >>
> >> In various places in the kernel, we modify the fwnode "flags" member
> >> by doing either:
> >>   fwnode->flags |=3D SOME_FLAG;
> >>   fwnode->flags &=3D ~SOME_FLAG;
> >>
> >> This type of modification is not thread-safe. If two threads are both
> >> mucking with the flags at the same time then one can clobber the
> >> other.
> >>
> >> While flags are often modified while under the "fwnode_link_lock",
> >> this is not universally true.
> >>
> >> Create some accessor functions for setting, clearing, and testing the
> >> FWNODE flags and move all users to these accessor functions. New
> >> accessor functions use set_bit() and clear_bit(), which are
> >> thread-safe.
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Acked-by: Mark Brown <broonie@kernel.org>
> >> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
> ACK or RB?

RB, sorry.

