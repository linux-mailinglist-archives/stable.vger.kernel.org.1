Return-Path: <stable+bounces-87835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074289ACC36
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58A41F22154
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83711B86CC;
	Wed, 23 Oct 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdpHmSeO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980C1BBBC0;
	Wed, 23 Oct 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693499; cv=none; b=I7p56h37ixSIn4UEamJDRPQFhQLsh5xGlhS2HsW3ejEu/NXEYFLB+Pq73kVmwxN75B2gaKgdND7+ay4GbwPY9KzlfTI4aZvDWQa5BzSiLqWhQ0OMh2WGlRmCVMom8qD97J8mk7N8ogqX9dRPNsvEEAt/ThIFmpr9tm64ApWxphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693499; c=relaxed/simple;
	bh=vOPOg3lWLHfwgbf5aNXDeZl0cIpNdD47DGZ0baeW1tE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K9w2NdJ/kuvfa78euwoXosXOUag/l5uYU2lr9ictEPKXZS2OUn2nF1+8GTwdKIXT5Ias7Nw25HsjgFJAf0KTD1AjEK1Z0zouzQ+7QHWhxIF3rpnbMVq41vcEew0G1t87uTgSUcUFeUMAXYGPUvR9WPXLf5z3GfD2MDXeECz5euE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdpHmSeO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729693498; x=1761229498;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vOPOg3lWLHfwgbf5aNXDeZl0cIpNdD47DGZ0baeW1tE=;
  b=YdpHmSeOqp3S+/pxSn/aKpYj+7WqQxtjXZ8mHTR6+WwbflceLLXugFYE
   FHt96UvTBOSN0nBg5lkhYtpEUt8VFl12W4ijO3Itw49sPDogEq8RpqZ+A
   YRKeVZHG6ZhErPdomQ2tiUrokc6y/+hQ93TGPbH1QG0B82BEvVbEKWcNA
   UY2I1W8+3Z0ODLOUMGu0Pi4ThBcksunHcfLZBlLLC2lVtBTQgTy/igbiU
   h1UnoEDPTPbziSQo2p/0x1WR1FJQFY3Sg5iprvpFZsjX2fwSmZRqjWR5C
   TvBmGf1QWV2r96aOBBVceZnw/74RiJf18Q5okrUz8U8fAirsca8LabRE3
   Q==;
X-CSE-ConnectionGUID: mMOE0CroTCis6ugwzSiHkw==
X-CSE-MsgGUID: BzrrzTd6Q4q+6+Z7HgfQnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33091519"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="33091519"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 07:24:58 -0700
X-CSE-ConnectionGUID: 3Xwn5gqYRr+1+GOJAG6cPQ==
X-CSE-MsgGUID: +2QKtaksTqmd9buVWDJKYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80635081"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 07:24:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 23 Oct 2024 17:24:51 +0300 (EEST)
To: Sasha Levin <sashal@kernel.org>
cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org, 
    stable-commits@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "David S. Miller" <davem@davemloft.net>
Subject: Re: Patch "tty/serial: Make ->dcd_change()+uart_handle_dcd_change()
 status bool active" has been added to the 6.1-stable tree
In-Reply-To: <ZxkGNdh6cQnKEpSt@sashalap>
Message-ID: <3d5209b9-ceb7-3fe0-667d-38c1c0db8c50@linux.intel.com>
References: <20241022175403.2844928-1-sashal@kernel.org> <a07de63f-1723-440d-802c-6bedefec7f24@kernel.org> <ZxjidR9PG2vfB_De@sashalap> <28b8da74-02ff-8b2d-4eca-74062dc84946@linux.intel.com> <ZxkGNdh6cQnKEpSt@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-298596848-1729693491=:1168"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-298596848-1729693491=:1168
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Oct 2024, Sasha Levin wrote:

> On Wed, Oct 23, 2024 at 02:56:06PM +0300, Ilpo J=E4rvinen wrote:
> > On Wed, 23 Oct 2024, Sasha Levin wrote:
> >=20
> > > On Wed, Oct 23, 2024 at 08:25:12AM +0200, Jiri Slaby wrote:
> > > > On 22. 10. 24, 19:54, Sasha Levin wrote:
> > > > > This is a note to let you know that I've just added the patch tit=
led
> > > > >
> > > > >     tty/serial: Make ->dcd_change()+uart_handle_dcd_change() stat=
us
> > > bool
> > > > > active
> > > >
> > > > This is a cleanup, not needed in stable. (Unless something
> > > context-depends
> > > > on it.)
> > >=20
> > > The 3 commits you've pointed out are a pre-req for 30c9ae5ece8e ("xhc=
i:
> > > dbc: honor usb transfer size boundaries.").
> >=20
> > Hi Sasha,
> >=20
> > I wonder if that information could be added automatically into the
> > notification email as it feels useful to know?
> >=20
> > I assume there's some tool which figures these pre-reqs out, if it's ba=
sed
> > on manual work, please disregard my suggestion.
>=20
> We already add a tag to indicate the dependency, sometimes folks miss it.

Heheh, it seems I'm too among them. Thanks a lot for pointing that out.

> In the case of this patch, here it is:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/t=
ree/queue-6.1/tty-serial-make-dcd_change-uart_handle_dcd_change-st.patch#n2=
5

--=20
 i.

--8323328-298596848-1729693491=:1168--

