Return-Path: <stable+bounces-225808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eECpIJIwuWn4uAEAu9opvQ
	(envelope-from <stable+bounces-225808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:44:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 227942A82B9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D6C530374B3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F059367F28;
	Tue, 17 Mar 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+mRoSiX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E93A6B79
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744269; cv=none; b=UQz95l0KFX+xivlfoEucs8gzQif/32CrkeKESymgAaUHaW8FZA011ryx0/l/Zo3jsv9ZQnauzvMvOMF60A5jy1N4Gbq3NBM2gHPEjia3soctLUF+uyxbwiHKHuvPtgxcZDzeQ8ieF6KX8o7avAT7NX16qPnUEdvRP5YqCmPpg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744269; c=relaxed/simple;
	bh=UQyonz/fROOd+E5ux5wnd2FwnDxCTcUUFUb5qdccPbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jtk6hbxdtkOOBakW4ML7fbpsmgUy1Lt9wA0GLB9AjXQDzZA7V83HjnyfSmiUhyeo0lo/HDb/0R9IJ/QiMc7BhZmtm8nalkreujIjWw5VIrdca5ig5usVStT9+KCUTNVC7Bif1/oGtT3M90Z5SPa1uYQFbQcM+Xcdc/Nq4q+jJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+mRoSiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4A7C2BCB1
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773744269;
	bh=UQyonz/fROOd+E5ux5wnd2FwnDxCTcUUFUb5qdccPbk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A+mRoSiXRnP0rpmp94IIjRt+NqHylOr8sISWSQVsw6FsnP9W4Gy1oFyPwBK0+kEuq
	 YfLXzK/+3b1dFclBnrbc2ImOIsXdkanWgEHrSTR11nomzEdwbZ2MsrKnz7L0qjTSVw
	 PyQWSqVlidOEPJwz1i8qLiBH3MOkd1512mPLL7fdIyQ+0uombK85JScW2GEnHLEXq1
	 ii/+gSwQ7AZdwIxfJaD2EebjNRUlYfVnUmrBr5fCQAGacIXTgVxS9TELk6L6l2pg6K
	 F9OzwUfvdSlqSRKO0bcQ3m8PyQo3ZvX5dzdqs0+spfSqu35ViQI1qzscOxz9lkf0bc
	 GWJmm9fFt5Qdw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-467161c4b89so3481224b6e.3
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 03:44:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9pgCNmPViE1d7Y+lXYCCAZO07imibj30FfZU+9pf6a4Uq4u5mxlwoV2d5Q3SUW4BAY80ZuKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY9TMB3YIS+e03zZTB9MWKWrcpSGd9sLVATPAYtNjb6CpMlcH8
	BtrLmx/2z9QgTE5vS+aSCwxattw9zGtn0RxIHQWIY9pzay+AIliU73VZuLvlWdQYj+SLQ06CMLT
	oXOot5aUQYzsy01VpE1M0cgV5VD82zEw=
X-Received: by 2002:a05:6808:66c1:b0:464:a1ee:c412 with SMTP id
 5614622812f47-4675754332emr7723340b6e.31.1773744268614; Tue, 17 Mar 2026
 03:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro> <abkD-VLprcbbEbB1@ashevche-desk.local>
 <abkF0GO01sMcOhvb@shikoro> <abkLEgrZbdb03VWg@ashevche-desk.local>
 <abkLY4AAQuFlTRC7@ashevche-desk.local> <abkT_jpjIki6pvX1@shikoro>
 <abkqEni3phP8dqqw@ashevche-desk.local> <abkuNpwmYGa6qJPZ@shikoro>
In-Reply-To: <abkuNpwmYGa6qJPZ@shikoro>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Mar 2026 11:44:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g=_HW7i8-emNdTtw_0Kjqri8qTehHvms52u-w7jqG6bQ@mail.gmail.com>
X-Gm-Features: AaiRm51cRor4ZZDDr_mxj0wmImR4wUCy3F3N-SYcdW3xJYMr5MLA4gbqvDIFXzk
Message-ID: <CAJZ5v0g=_HW7i8-emNdTtw_0Kjqri8qTehHvms52u-w7jqG6bQ@mail.gmail.com>
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Douglas Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
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
	TAGGED_FROM(0.00)[bounces-225808-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,chromium.org,linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sang-engineering.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 227942A82B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:34=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Like Danilo I am also not sure what lock protects fwnode accesses.
>
> This is basically the question I asked to Doug. If he also don't see
> one, let's take this patch as is.

I don't recall using any lock for this purpose.

IIRC, the original assumption was that device fwnodes wouldn't be
updated once set.

