Return-Path: <stable+bounces-227008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNAUDjVrumnnWAIAu9opvQ
	(envelope-from <stable+bounces-227008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:07:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3B92B8A84
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EF6E300E155
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249A3A0B31;
	Wed, 18 Mar 2026 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLY1dV3s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808F3806D9;
	Wed, 18 Mar 2026 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824814; cv=none; b=WiHAnvIZuhqlEgWJWw40e15wIlpjcIE+t6d9Ye9NH/tpIfQ+IwDGb+coSvQtu4sTNTi5oM6X0wM1XZ5MJ4uVyhBqxDMVBBXC8p/dbZlWtDjRIj35ftzV/Bi57l3ZKB/Vv1qWJITADFGITw/c4A3f2B4XZPgolp4nMPAEm316wLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824814; c=relaxed/simple;
	bh=OOpz2QLVOMmh9KY2GRGxQ6h+0tnAzCc8jxynqR/fL8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf4bEBjizwgm8EdOcW3auquIs8OkwfzXAOrXJ2LE94C53ZO64cj1ie2Vrh4/ry1uxGb7Q8xAlL0sgHfCfYSv9uUaVJFr8QHDl12nQTurJUwUcGmuJSvHpWsbqF8RlxhM+eFe3osVfj6A+9qr3n5zdxyEZ814q8OTxJ8tTSPvdNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLY1dV3s; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773824813; x=1805360813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OOpz2QLVOMmh9KY2GRGxQ6h+0tnAzCc8jxynqR/fL8c=;
  b=VLY1dV3sVmWq3gJTWrFSVViPbCnFtyc2GcbLiLD3QqGf5w9n7Tn/sjAg
   BUbeOdkvfd6Nx8zNp/gLZ/ImnLRD4i3DZNp6sbg6Y5Vn8FOemBvk/Cz1v
   yDswofBEh6LvGKlVOtV0BDHue5yd++YjKZcJtsbiDXfBM34gEPZ5oIrTU
   xHRdH3xVbQkIb+rtH3Z5H0xW/qFTyz9pI1QrW77YMNvAzXUZOnoL/IDjk
   tajQ2tEK0V26vaghBKQ6bbw+koMb9we5D5EswiVCrWldwRgVjI7IIDYIh
   AJBuEGs7lrQkl+LhOQ0sUQNUes8mPZI84tEvgFWrSeL9BpM57/Mh4WGgh
   A==;
X-CSE-ConnectionGUID: R4xC4tmMTU28wQFRZ0zGew==
X-CSE-MsgGUID: IqpuriG9S2yAIoES04+teA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74573983"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74573983"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:06:53 -0700
X-CSE-ConnectionGUID: bGaVs8xpTUCoR2u709K5aQ==
X-CSE-MsgGUID: hk9DpRDxSG2N5wW8ulwWpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="253045856"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:06:44 -0700
Date: Wed, 18 Mar 2026 11:06:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
	Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	driver-core@lists.linux.dev, imx@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
Message-ID: <abprIZ4_LUScJrSd@ashevche-desk.local>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro>
 <abkD-VLprcbbEbB1@ashevche-desk.local>
 <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVX4tfko8iv-EdwO-bBcwCd+cPkb9aP8qJbcM1F4zdz4g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sang-engineering.com,chromium.org,linuxfoundation.org,kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,linux.intel.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227008-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[34];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EC3B92B8A84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 09:41:44AM +0100, Geert Uytterhoeven wrote:
> On Tue, 17 Mar 2026 at 08:34, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Mar 17, 2026 at 08:26:53AM +0100, Wolfram Sang wrote:

...

> > > Thanks for tackling this issue! I agree it should be fixed, just
> > > wondered about one thing:
> > >
> > > > While flags are often modified while under the "fwnode_link_lock",
> > > > this is not universally true.
> > >
> > > Is it a possibility to use the lock in all code paths instead?
> > > Because...
> > >
> > > >     struct list_head consumers;
> > > > -   u8 flags;
> > > > +   unsigned long flags;
> > >
> > > ... this change costs some memory on every system. Maybe it can be
> > > avoided?
> >
> > How much memory does it cost? On most 64-bit architectures is +4 bytes,
> > rarely +0 bytes, on m68k it might be +2bytes. On 32-bit it most likely
> > +0 bytes. I expect that 64-bit machines will cope with this bump.
> 
> On all architectures with natural alignment of pointers and longs,
> it won't cost a thing: struct list_head contains pointers, so the
> struct must be padded to a multiple of 4 or 8 bytes anyway.
> On m68k[*],  it will cost 2 bytes, as the existing padding is just a
> single byte.
> 
> [*] Iff m68k ever switches to 32-bit alignment, there won't be an
>     additional cost due to the change of flags here, but of course
>     there would be a cost all over the place.

Thanks!

Yes, the worst case is 64-bit architecture with 4-byte alignment. This
will cost +4 bytes.

But I think we are really wasting time on this part of the discussion
(and any similar) as long as nobody targets struct device or any other
BIG FAT data type, that will bring much more benefit than saving 4 bytes
in some struct fwnode_handle.

-- 
With Best Regards,
Andy Shevchenko



