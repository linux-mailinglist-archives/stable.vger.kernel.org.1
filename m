Return-Path: <stable+bounces-249563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD38JmRPDGqXegUAu9opvQ
	(envelope-from <stable+bounces-249563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:54:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296257E19D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6506D3091533
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC6332BF44;
	Tue, 19 May 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyIyPC+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D133688F
	for <stable@vger.kernel.org>; Tue, 19 May 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191338; cv=none; b=HGGfmQDX/hqi62s9XCURb0jqA6wbACkgWM1VXNpGn4lu8R1Qqc7rAwzpft0v6RQRLfu+5Ui8/8ORYBywincpFm9CV+XmBa1dmD5//rQ1/r1MfoHRH1TRJ1q7kmiYD5fn6ENO4hrd3r+Yj2yuHlD6mT1KEwmOChoKEZaYQsAwIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191338; c=relaxed/simple;
	bh=P8tH35z/uw0sUKZFgOPDgy73UQSBzwGUIBPWsAuyH6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmqUFihRuiMKNxsjCjQvHc/9ytjiSr4xqWdrsy48JfkEkHeEWDEIj8BUVkwjsMuOgXXQH2T45XkdSfpXL3Do1drk9XuXB3NrnUjrifByWMWiXVway0PHM0MNcujZVzoe6NG3orft5oLTVfIcNeNrheh9W6cW9xNBrMTTwMeOzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyIyPC+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDF5C2BCFB
	for <stable@vger.kernel.org>; Tue, 19 May 2026 11:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779191338;
	bh=P8tH35z/uw0sUKZFgOPDgy73UQSBzwGUIBPWsAuyH6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AyIyPC+Th7V8akdW2YEbMD7D6pYR0JZw+wVug4nh6QxWBviCvESRqZsU9E8y3TUrF
	 FOZREpj5dz9FH2KgXYy7g9biXVpVK8inm6xv8GG8AFxRBBow0lZlmArtlxlYUV/S5Q
	 bm2siEC/VPlZYV8n0V/A0pi/5QTTI0XzbBwqKz0vKuY1KMMhie3NAw67j7CqXVddd+
	 Kfrx6k2Aiehd7ebuR7WKGZqovjL+yjdp17CRl85zKQVAHT772t3TRRVO/dGL7vzmGj
	 brtYp54Xfya0cTNcHG3/dARudZ01yO4tgQg8/Nw8IvCmoqrUAKp8s519tBEjWAvRtC
	 desOjo5DtIt6g==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa0da74eaaso4308492e87.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 04:48:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/kI4WrQwk/uutXZP7xN+pqCotF4PGYpL66TY39An3NmNBnZeSxs+JXlyhKUtbCpJdX86o/gsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCry5UmNWPCmEnMRdyYyr9w4C+1IvEzs+caLN7XbDK1ifSrNVZ
	JGVgI2Bveo35HNzpkEUOhEkc6sxyHuO+WpyhDwzAZEAutxwmFVi12VPQ7d6rNt2o0i1McT/J1jF
	lU1NDPerdGBjHhB71HC7J+6JHB9W5Yf8=
X-Received: by 2002:a05:6512:15a7:b0:5a8:7ed5:7462 with SMTP id
 2adb3069b0e04-5a8ffc4b5cemr5829232e87.6.1779191336447; Tue, 19 May 2026
 04:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E2OXET.4X5GTP37VTNC3@kousu.ca> <4bba4c5a-debb-4844-a032-986f761a74af@leemhuis.info>
In-Reply-To: <4bba4c5a-debb-4844-a032-986f761a74af@leemhuis.info>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 May 2026 13:48:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g6aHsdmNhW3Yr54KnGkOHn81bXFVHD-6+bvYWUsmZZdw@mail.gmail.com>
X-Gm-Features: AVHnY4KxJPOE1zcY4KC6fhnc9_2se9KlcaGnCNlMQYBIAtVrV38iYDqoTJo8Dgs
Message-ID: <CAJZ5v0g6aHsdmNhW3Yr54KnGkOHn81bXFVHD-6+bvYWUsmZZdw@mail.gmail.com>
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Nick <nick@kousu.ca>, 
	regressions@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	todd.e.brandt@linux.intel.com, xi.pardee@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org, 
	Azael Avalos <coproscefalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,kousu.ca,lists.linux.dev,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-249563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,leemhuis.info:email]
X-Rspamd-Queue-Id: 1296257E19D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:56=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [CCing Azael, just in case]
>
> On 5/12/26 18:49, Nick wrote:
> > My Toshiba Tecra X40 laptop's function keys no longer send events.
>
> Rafael, have you seen that this regression seems to be caused by a
> change of yours? Namely 57c31e6d620f13 ("ACPI: scan: Use
> acpi_setup_gpe_for_wake() for buttons") [v7.0-rc1]

Yes, I have.

> No complains, just wondering, as it was easy to miss. Ciao, Thorsten

Sure, thanks for pointing this out.

