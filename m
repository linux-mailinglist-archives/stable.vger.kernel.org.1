Return-Path: <stable+bounces-164405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC15B0EE6D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 11:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761E5546E13
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E92286887;
	Wed, 23 Jul 2025 09:29:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9A3FB1B;
	Wed, 23 Jul 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262956; cv=none; b=OWPSaBp7Inz8NBAflzU/k8fy7gXdQi2Y65xSF21AiJnTYf1QKZnjq5wzDDexPw4sCOJwWMB3tnf9Wa8PCX8FUTr5Uc4yJZmg0GPggwri1LVPTdE9IwvaUJqAzKY4WZsjmSrpN8O8/PUpc45DRgXQ/xO6s2cKqu3HZMUMdHt+eJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262956; c=relaxed/simple;
	bh=grOY7rG/X+b9Vqa7udJpstXqVwojxMiy+5DRZZXGdFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jQyUq/xu6XTNTOyt5cQ2L7HdoC+ip9Vwd6bSJHwHyx7z4/w0oTqMgcU6qljswCzCB4QCtI6mhims2nF9ZH7eKST4zYOgtnicVFBqKd30NOdXojlny4CPqbXXIIyA8UKqg7qxM/XibKHb4WLSfVtibNsw+92WfcE+30hpHPhkQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 23 Jul
 2025 11:29:03 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%6]) with mapi id
 15.01.2507.057; Wed, 23 Jul 2025 11:29:03 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Jakub Kicinski <kuba@kernel.org>
CC: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Ming Lei <ming.lei@canonical.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
Thread-Topic: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
Thread-Index: AQHb8Xe2qza52xx55UmGbnkg6Pc/lg==
Date: Wed, 23 Jul 2025 09:29:03 +0000
Message-ID: <aICrWl2TTTInbfT8@w447anl.localdomain>
References: <20250710085028.1070922-1-john.ernberg@actia.se>
 <20250714163505.44876e62@kernel.org>
 <74a87648-bc02-4edb-9e6a-102cb6621547@actia.se>
 <20250715065403.641e4bd7@kernel.org>
 <fbd03180-cca0-4a0f-8fd9-4daf5ff28ff5@actia.se>
 <20250716143959.683df283@kernel.org>
 <55147f36-822b-4026-a091-33b909d1eea8@actia.se>
 <20250718161825.65912e37@kernel.org>
In-Reply-To: <20250718161825.65912e37@kernel.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2955B14450647C67
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95DD33E56AD5674EBC1A132FFD9750A6@actia.se>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

On Fri, Jul 18, 2025 at 04:18:25PM -0700, Jakub Kicinski wrote:
> On Fri, 18 Jul 2025 09:07:26 +0000 John Ernberg wrote:
> > > Thanks for the analysis, I think I may have misread the code.
> > > What I was saying is that we are restoring the carrier while
> > > we are still processing the previous carrier off event in
> > > the workqueue. My thinking was that if we deferred the
> > > netif_carrier_on() to the workqueue this race couldn't happen.
> > >=20
> > > usbnet_bh() already checks netif_carrier_ok() - we're kinda duplicati=
ng
> > > the carrier state with this RX_PAUSED workaround.
> > >=20
> > > I don't feel strongly about this, but deferring the carrier_on()
> > > the the workqueue would be a cleaner solution IMO.
> > >  =20
> >=20
> > I've been thinking about this idea, but I'm concerned for the opposite=
=20
> > direction. I cannot think of a way to fully guarantee that the carrier=
=20
> > isn't turned on again incorrectly if an off gets queued.
> >=20
> > The most I came up with was adding an extra flag bit to set carrier on,=
=20
> > and then test_and_clear_bit() it in the __handle_link_change() function=
.
> > And also clear_bit() in the usbnet_link_change() function if an off=20
> > arrives. I cannot convince myself that there isn't a way for that to go=
=20
> > sideways. But perhaps that would be robust enough?
>=20
> I think it should be robust enough.. Unless my grep skills are failing
> me - no drivers which call usbnet_link_change() twiddle the link state
> directly.
>=20
> Give it a go, if you think your initial patch is cleaner -- it's fine.
>=20

Apologies for the delay, I was stuck in a higher priority issue.

I've tested this approach and it looks promising. Will send this approach
as a v2 later today.

Thank you for the guidance, very much appreciated.

Best regards // John Ernberg=

