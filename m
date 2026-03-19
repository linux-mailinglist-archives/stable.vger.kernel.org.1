Return-Path: <stable+bounces-227359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOUQEdE6vGl3uwIAu9opvQ
	(envelope-from <stable+bounces-227359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:05:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E982D07F6
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43C332AA302
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934E3393DF7;
	Thu, 19 Mar 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ey/4Pl3s"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214D3128D4
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942756; cv=none; b=LVGA4tAWmg8bv0C9yvgiJ3747O/DaxT7SZSOJOQr998GUr6yijSSqZ822G57NxByEJMKkRAELb+QHN4vfaXAxCd86NbNGgyDFKr4b1QMs5S+Q9PM9nrQ4yJ2xGfSG+cLicZEx3ePCmkNLmDkpSLugqYolEVxMT7cHF0lCTn2HAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942756; c=relaxed/simple;
	bh=1qiYzC4e4C5Osb7cyOfG+hx3gfnhgiG4CgnJdnnYqWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faK5L/7fcC9VfH9Db1FfNeFvEmS0pvkQuktedCktANr1TMVRYa/um/27GitdoHnEBYQDQRxJA6DEw8TaAlNBcSpUc+EE1/YZldMxuBxS0Yi9OAS/gTKcYfhDFddmXq1Tr+Y5XpuddSFGjYZ36Bek/c7pWljDTWB2dskF0YmttUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ey/4Pl3s; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso141663766b.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773942748; x=1774547548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwNvoAxpSBA3F4YxfMu4dubOKf0cPSpjGd1s0V+Fdds=;
        b=ey/4Pl3sn5K5mHN0JtIepY45ufbzz4EbQ9OhhRAVyebrrXQcVooHXVVUeqLYy1+JgC
         IXZSN5eUxWevTk3gYQq81IpiBdyxRr/+FmXbWNupxfAlqpOAEQqrG1i34gg5PAk0dDa0
         qz2IGjK5jr2oHzMpqrXFRduAPC4zokCcV6T1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773942748; x=1774547548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwNvoAxpSBA3F4YxfMu4dubOKf0cPSpjGd1s0V+Fdds=;
        b=p0nyeih56dZpuZRIhngTaoTmbKw6DUV7MlTXb6vKUoxzlIZyHyNmk22bB3upAlP6tH
         hf7svOQyvTk4aq5KvTF1MAsBaZrCa0OFMdd6IDbeLZwAZymDiodpIbalEWm4G202EjeZ
         +qo9OG3QSRp25asnjHferbcxHEerwCnvhQWTTfC59Rd9+WY69sXqXkbg/ksI5/0soY2m
         08sc7tTQB+7gUPu/alpqVeurK/b2wI3z8gjja4a7T9iBxf2EdtXTq//QLtnya17D7bl1
         8Djnhq0+uJYKJNXiLA4H8GlrelAC9jpe3q746G8KxvreO7TtsngPFs0z2WpdWoElpn3O
         mMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP0zXOJhDLSEPbZ9TVKo0Q6o67knYvKGCJlN33JN3QTaFKOFxLo0WpHTJtKRQpic05j8knX6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dQGHJOvWYgArXH7kIrLmAmmRKx8qDxvQsbDMFYKx0BKAmkPK
	et/jkVIbp15ZTt+sPIwaub4JG/qk6Q0lcghOFiEzbrKLQ8xt0+26/y4MN6e3thj0Yzd8ttAmT6T
	9dcVUbA==
X-Gm-Gg: ATEYQzz2pug8JVZqkQW2IiRwLo4tb6JgrY+dftoUBNgE7VgbUydljMniSO8GYTHgSyf
	oeeEqQ1zpojed90xmqijoYSP1XYBklCRc38mzlIuDiEY3lqZ5wdhXAVQIxntKsbTz4dIjuj1hzN
	XO2gAssJxbcF6iyRshR0YwKzE9bF8jhIOND1+arG8/PQTFf78WOsi8AAsKNiWgwU9w+xgJvR2/j
	y2J7moMXAl952oirSg4S0cuhb52siIhFHVto7HwasKcz5IDF43CUXesSBzLrv8Esu5veXaJbTxw
	jfvqkbqVZwELV9IwdTQZCqGkl1KJqwWxnlK9CsXew5GtPvm5nvpgjdkk7Xk+Tzy27PSbd4yiVYA
	sLLVo8Ls1OtxlxTdawHQqrZa20rGwo/l88FKZ1VF+9PeJcepGEvCz9WqfKmFl/a4qHt/NrtTlU7
	cU+QJpZMe35gmVaP2e2bfQQbTEmbR/cZsYzgiDBJngQ/28PxiV2L9pUgS7Ed7QZg==
X-Received: by 2002:a17:907:d501:b0:b98:1b18:782c with SMTP id a640c23a62f3a-b982f0b9a52mr22605866b.6.1773942748085;
        Thu, 19 Mar 2026 10:52:28 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f142b8efsm512144166b.17.2026.03.19.10.52.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 10:52:27 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4327790c4e9so691831f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 10:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+8R/CmgsUfK1UVRsbtjxS8vVUSWrq2iqLjTljM3a1Gn38rzGE2ToW1AY87KExehXI3waFAk0=@vger.kernel.org
X-Received: by 2002:a05:6000:18a6:b0:439:beee:43b5 with SMTP id
 ffacd0b85a97d-43b6423d90bmr470716f8f.3.1773942745211; Thu, 19 Mar 2026
 10:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
In-Reply-To: <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Mar 2026 10:52:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
X-Gm-Features: AaiRm51jE-pJGKyYKekSNJEdkSVtbmzl88hjmcc-VHWIT0EUhGVU2WYljuGhtW4
Message-ID: <CAD=FV=WEWMdh+SuSE-5P81g7NhV8KH_4u_FxcRdBFRTAaASqhQ@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Saravana Kannan <saravanak@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227359-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,sang-engineering.com,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sang-engineering.com:email,intel.com:email,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: A3E982D07F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, Mar 19, 2026 at 10:25=E2=80=AFAM Saravana Kannan <saravanak@kernel.=
org> wrote:
>
> On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > In various places in the kernel, we modify the fwnode "flags" member
> > by doing either:
> >   fwnode->flags |=3D SOME_FLAG;
> >   fwnode->flags &=3D ~SOME_FLAG;
> >
> > This type of modification is not thread-safe. If two threads are both
> > mucking with the flags at the same time then one can clobber the
> > other.
> >
> > While flags are often modified while under the "fwnode_link_lock",
> > this is not universally true.
> >
> > Create some accessor functions for setting, clearing, and testing the
> > FWNODE flags and move all users to these accessor functions. New
> > accessor functions use set_bit() and clear_bit(), which are
> > thread-safe.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > While this patch is not known for sure to fix any specific issues, it
> > seems possible that it could fix some rare problems. I'm currently
> > trying to track down a hard-to-reproduce heisenbug and one (currently
> > unproven) theory I had was that the fwnode flags could be getting
> > messed up like this. Even if turns out not to fix my heisenbug,
> > though, this seems like a worthwhile change to take.
>
> Reviewed-by: Saravana Kannan <saravanak@kernel.org>

Thanks for the review!


> Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
> it here, I might be able to take a look at it too (no promises).

I don't _think_ it fixes my bug, but I'm still not 100% sure because
the bug can take a day or so to reproduce and it appears to only
reproduce on official kernels built by the builder. :( This makes it
hard to say anything for certain and also hard for me to inject extra
debug logic.

I did finally capture a ramdump of a device in the bad state and
managed to inspect the state of all the fwnode and fwnode_link
objects.

The problem (simplified) is that I have a pinctrl device:

  max77779_pinctrl {
    pin1: pin1 {
      ...;
    };
    pin2: pin2 {
      ...;
    };
  };

...and then a client of the pinctrl device:

  client1 {
    pinctrl-0 =3D <&pin1>;
    ...
  };

  client2 {
    pinctrl-0 =3D <&pin2>;
    ...
  };

At parse time, we get a link between the "client1" node and the "pin1"
node (and "client2" and "pin2").

In a normal boot (where the bug doesn't reproduce), when
max77779_pinctrl finishes probing, all of the links to its children
(which don't have a "dev" associated with them) get moved to point to
"max77779_pinctrl" (__fw_devlink_pickup_dangling_consumers).

When I detect the bug, the max77779_pinctrl device clearly has
finished probing, but the client devices still point to the child
nodes.

In the debugger, I can inspect things. I can see:
* The fwnodes for "pin1" and "pin2" clearly don't have a "dev" node.
They also don't have "FWNODE_FLAG_NOT_DEVICE" set.
* The fwnode for "max77779_pinctrl" clearly has a dev node (and a bus).
* The fwnodes for "pin1" and "pin2" show zero consumers.
* The fwnodes for "client1" and "client2" _do_ still show suppliers.
* When I look at the fwnode_link between the clients and the pins, the
"supplier" points to the node for the pin.
* When I look at the fwnode_link between the clients and the pins, the
"c_hook" is non-empty.
* When I look at the fwnode_link between the clients and the pins, the
"consumer" points to the node for the client.
* When I look at the fwnode_link between the clients and the pins, the
"s_hook" is an empty list (next =3D=3D prev).

It's a bit baffling because everything looks nice and consistent with
half the link being severed, which doesn't seem possible when looking
at the code. The code seems to always add to a consumer list and
supplier list at the same time and remove at the same time.

I've started to run out of ideas on how it could possibly get into
this state. If you have any, or want me to look at any other data
structures in the ramdump let me know.

-Doug

