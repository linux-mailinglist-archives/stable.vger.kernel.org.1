Return-Path: <stable+bounces-123195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005DAA5BEEF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 12:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5DB1888152
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C76253F05;
	Tue, 11 Mar 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="kq/UFAtI"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F871EBA09;
	Tue, 11 Mar 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692426; cv=none; b=Ioq4qWG+fTQ93J9KAQclC3JMjAnQrvZReWGNBqBKeFKSNtJ6RFw73DHrc6J8oRXw9vQn2D0bNyTND5SC49dxXpr37SmmkvgD5vzqjRy8nDvikrtB2JilRLr2F7v2im0uyojO7o6DmAEgC3ibCJLS0fHYc22KUpZa1R7PdWKIupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692426; c=relaxed/simple;
	bh=fw+Gn7lVTmFQHX2G3+L709XHoTRr/Pnl+NP5DaQZweU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=GMJJGMvSz17lyWPA0fOH+1EjqBFu0i6+LhA/3t43pfJBd5F0eM9gbsCxMo6RfBly1gMRCBYQWdpTcyppJ4l79baDv9iHkg+sSwBr0zaI4Z5/r4jJC4WCzrRstE1cpyQGY7kaCYZ8rV6BGfbbPxd2a+i30TwWiYaeejCFnUgD9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=kq/UFAtI; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1741692355; x=1742992355;
	bh=fw+Gn7lVTmFQHX2G3+L709XHoTRr/Pnl+NP5DaQZweU=; h=From;
	b=kq/UFAtIqSMucu4HI3iZlAgtVwVhOzpMtt3eb7CHhn/imNiexj3QCUul1NKSNqu1U
	 FU873nUOeHpOMiioeU4wvDD97JtGMD2nZbD3KfBHFnCgUofTx3391f5KJOCElu8bLE
	 dJzi/4uoXuzh2oGTxM7Nv35t0wBJ71hFCbzry/3uA5H+pf9wpz028QYqymYrGlnFld
	 UjDfmurqYFolZvHmGm5XFA7epvrzSLM/2x0XH9u+cYehQp91HaWaVLRY6VgszmiVH1
	 ob+8uIBArw5xIdBC7vAZD8cp4mPkF3aQ82SQYjtH6YykaA3YnYURQYfo6nDcfs/GLo
	 2HJ1J0ZW8G2nQ==
Received: from localhost (c-85-230-82-121.bbcust.telenor.se [85.230.82.121])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 52BBPpFx004169
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:25:53 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 12:25:56 +0100
Message-Id: <D8DEEUPB16WF.154Y3AEPXT4L1@matfyz.cz>
Cc: <phone-devel@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        <stable@vger.kernel.org>, "linux-mmc" <linux-mmc@vger.kernel.org>,
        "LKML"
 <linux-kernel@vger.kernel.org>,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian
 Zhuang" <haojian.zhuang@gmail.com>,
        "Robert Jarzmik"
 <robert.jarzmik@free.fr>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] mmc: sdhci-pxav3: set NEED_RSP_BUSY capability
To: "Adrian Hunter" <adrian.hunter@intel.com>,
        "Ulf Hansson"
 <ulf.hansson@linaro.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20250310140707.23459-1-balejk@matfyz.cz>
 <727c857f-0234-417b-af5d-69b3ae064d0f@intel.com>
In-Reply-To: <727c857f-0234-417b-af5d-69b3ae064d0f@intel.com>

Adrian Hunter, 2025-03-11T09:34:28+02:00:
> On 10/03/25 16:07, Karel Balej wrote:
>> Set the MMC_CAP_NEED_RSP_BUSY capability for the sdhci-pxav3 host to
>> prevent conversion of R1B responses to R1. Without this, the eMMC card
>> in the samsung,coreprimevelte smartphone using the Marvell PXA1908 SoC
>
> So that SoC is from 2015?

Rather at least 2014 as that's the release year of the phone.

> Is there anything more recent using this driver?

Looking at the in-tree DTs using the compatibles offered by it, it seems
that not really.

K. B.

