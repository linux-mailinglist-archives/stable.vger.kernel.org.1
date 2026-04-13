Return-Path: <stable+bounces-237665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMkhKQ9n3WnsdgkAu9opvQ
	(envelope-from <stable+bounces-237665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:58:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 028803F3A98
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45DB8301CE5C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D8138CFEF;
	Mon, 13 Apr 2026 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="kJgdggOk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MA2mEvcW"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9F345738;
	Mon, 13 Apr 2026 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117514; cv=none; b=LbeWw+/WtEteAOj8cyDWQkxP34LhXbGelvFRxACSnhPSCmEmnLg1LvA5B4Bsjz2Aq/3sN2MgMMUV4DwCVlWzKL3iL/syjLK+2bX6ULWQeEg/muaFIB9kjkNwumhe24T+i17L+a8s1cQASCXy1IpW/ofakgZpfxOPv171Zl9YWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117514; c=relaxed/simple;
	bh=C0yQ9BDOsFO04xZMEKxNKTeaCSyYENFuecFymEGCchw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJB5KarwAIGEHhMJLMFVlyJwEsHyG01jlyZ3E4ykApThfpC3Bi5m8YmepraHY73IhH89r0MM/f7NsMM0ROMM7G5M0mfaULqzfZg+0g47a1x2+5HqjTD2vMZg3vyi+fxE08gYPhUBcZGDV9RURcaQC/thPLJg40/2JXbuIrTiZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=kJgdggOk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MA2mEvcW; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F0C4BEC0515;
	Mon, 13 Apr 2026 17:58:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 17:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776117509;
	 x=1776203909; bh=4GkHMXB+cNXlgnY7q7iUg5quFdQWL06EszHzzvx6iBA=; b=
	kJgdggOk3KxmLPv2DnGRPayw0Dz05sdKkyxHoGRx8a7qFo+Z+CCx8mGKACQeAjrO
	9SVG5XuPKfCMk6wX8t9GWWvMmyPGLmfTw8F6SI4v4RojFlmNvlRv3GYUVmijWWzq
	CBJYDSMNuwz/DuR5ds/27LC5lwg32Z64OnJVvwkzraljLATVOES6OS+Z/EVx+4BX
	0Uhrg0bvmeD1LI0jFIlB30rfFtP/vStl9u97iNAyAaK3XzaN/ePEtoVQsKRRvXbl
	m1HoTUgGmpAEWSASnYc2cM56J+FQUDEFLLOykSM6Hh3/L5upTharLjJ22G+ApPEt
	O+BDTvGJGtFPQue5ihNWvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776117509; x=
	1776203909; bh=4GkHMXB+cNXlgnY7q7iUg5quFdQWL06EszHzzvx6iBA=; b=M
	A2mEvcWk9qLJp66rAs9lOcGa8v9aurMVhEHIL91x+aIQzMHqVEyXryfXJEraKVQZ
	EmBpVo9qWwZiWJQZ50/AXEdUttOrADZbEbi5FVcCRhW2bIn5ZFaT1c0sS3EbA8HX
	IAaeO9N9+9LgtFYg1LMwwfEwKf5o7mFxSv5FbgKEgJP2V6Vuw/GydnYEPXIoI66/
	xXS2jtrNe8QxD4arD9zK58a2+PXnxhZAjDJEjxhV50+mfhWAY6tomsJnmTBXmQfG
	LxQ3zIuJ+CPX9d7GxRtDCiNO+Ikxf4BC4ApvNF0xRFM+cLlnvzjbNONbQszQbHAw
	LKlVVnX14smPPDitt7V5w==
X-ME-Sender: <xms:BWfdaZ901DJKzXnqaAHGiCCMEoP7Z6hj_1CucJ36HEI5XbNAK-Eo8w>
    <xme:BWfdaV6SQqzYSec0wNwbyFw3zrszTmEcqY-1dXlPmymofyPaSQeS6ULOokTI94mT9
    7nRUURM59zEGvaLOwIMuCzrEY3cOybbwZpyV8-NpoOHlxh6sqiBeQ>
X-ME-Received: <xmr:BWfdaSmI-yPHwpJT0vgRwButVsEWIHiVrzaZCB5M7ZS-eq9fX5HgTsq9Q_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepieeuheevjeefgffffffhffegjeejgeevveelhfegleffgfeugfehkeehgfev
    ffdunecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohht
    rdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhitghhrghlrdifihhnihgrrhhskhhisehinhhtvghlrdgtohhmpdhrtghpthht
    ohepihhnthgvlhdqgigvsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjgh
    hgseiiihgvphgvrdgtrgdprhgtphhtthhopeihihhshhgrihhhsehnvhhiughirgdrtgho
    mhdprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshht
    rggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BWfdaYFVssTc4zb585ugrDSNd5eHdxPaezmHLl1N4ztQnX7sM9mV6w>
    <xmx:BWfdaZ-R-qCe7bZcErer2WouarYQopMpbKb_Ue1vBvYR3wX_kfZNGw>
    <xmx:BWfdaZmt_cDEpi79btJhR5moy0NDI16kL1K6h7U_MlnRFrn2jP6U9w>
    <xmx:BWfdaUB70ZxyXLOgk3qTxRSfPe7MnIEqB-LZjaV2WpS7rgZP3KUlKw>
    <xmx:BWfdabtxJwg9nqd38KJJDw5izNd4GoKks_DHNLRNG4RqvfIxH91JaTQM>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 17:58:28 -0400 (EDT)
Date: Mon, 13 Apr 2026 15:58:27 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>
Cc: <intel-xe@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <kvm@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas
 <yishaih@nvidia.com>, "Shameer Kolothum" <skolothumtho@nvidia.com>, Kevin
 Tian <kevin.tian@intel.com>, <stable@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v2 1/2] vfio/xe: Reorganize the init to decouple
 migration from reset
Message-ID: <20260413155827.494b7f0e@shazbot.org>
In-Reply-To: <20260410224948.900550-1-michal.winiarski@intel.com>
References: <20260410224948.900550-1-michal.winiarski@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237665-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 028803F3A98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 11 Apr 2026 00:49:47 +0200
Micha=C5=82 Winiarski <michal.winiarski@intel.com> wrote:

> Attempting to issue reset on VF devices that don't support migration
> leads to the following:
[...]
> This is caused by the fact that some of the xe_vfio_pci_core_device
> members needed for handling reset are only initialized as part of
> migration init.
>=20
> Fix the problem by reorganizing the code to decouple VF init from
> migration init.
>=20
> Fixes: 1f5556ec8b9ef ("vfio/xe: Add device specific vfio_pci driver varia=
nt for Intel graphics")
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7352
> Cc: stable@vger.kernel.org
> Signed-off-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> ---
>  drivers/vfio/pci/xe/main.c | 43 ++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 18 deletions(-)

Applied to vfio next branch for v7.1.  Thanks,

Alex

