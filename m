Return-Path: <stable+bounces-61304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051D293B468
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A54F1F24953
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C756615B548;
	Wed, 24 Jul 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qu6kGQRk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAB415B541
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836682; cv=none; b=DJN4nPSU9NSJzJMMF8DKqqJV7owXpN11rR2d7N5Ln/kVzD2ohuOYKOThFFl85MUzrgfSH3b8GqClZ3zHB/xmsf93SNI3LmXISpHqT8cuGCD1dCNjqXr3M6dk0AXEu5oN71O5vW3pYTcdS8Ql/uYiRFYf7NO3g5q+OWYirofWsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836682; c=relaxed/simple;
	bh=L0HA7bXP+oA1PVZK4yQ7WoxLnnwclHX3r3/x+QVvFRk=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=MNJ2zmoXeaZTMh3WF0coegU2hdIXmj++TAtpeTo0ZK4rbMCcVeNhAOh/bLbhOZpiV+vkYVoBbz5r8dhACHSSZQpJ+v2anmOwX0P5FElABjhQaP1kwuEpbY5bWf3WSvLeV+Ng7rr/hHasjRnP89hlY5vINIyT2OpJInl8m4W45LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qu6kGQRk; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFto0M008504;
	Wed, 24 Jul 2024 10:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=qcHmsForODcQC7sJn3S12lQApEYsfjMAhFyJvayH9C8=; b=
	qu6kGQRk9AacsAdPFGq9Px90P8ZJv0iKkx3q5sCbfAfv/wCZ+VA/PSUAP9M/QWLn
	cQPGp2F4JgOdD47SqqYeUO9997ScMxnlje4aO+zTLLCONA9niRKMS9kZfG/J6HKU
	gx5WiCPGuLLcCkrybJsD3pROJgw4JzmJl1hgsSxDRnYV0b+UxzTVxQnqN5SZE7pZ
	6w7K3Ug5brCwEJfokOIDRScBo+kqf9QSbQD44+Fe1VUTl9Lb223eLNAEmkSrlXoo
	1CqcdCseG+vk7Za2RFNQbgF0+oZA6Y5hJjEymiFDdcVyfHYfGzNBzKiNR8lAOP8y
	xDQ65mPOP5Uqh2Vr8zwPRg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40gamx4rcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 10:57:40 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 16:57:38 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 24 Jul 2024 16:57:38 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 047E2820244;
	Wed, 24 Jul 2024 15:57:37 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        'Takashi Iwai'
	<tiwai@suse.de>, 'Sasha Levin' <sashal@kernel.org>
References: <20240723180143.461739294@linuxfoundation.org> <20240723180146.679529179@linuxfoundation.org> <000001daddac$e3525c70$a9f71550$@opensource.cirrus.com> <2024072444-regulator-audible-4fe5@gregkh>
In-Reply-To: <2024072444-regulator-audible-4fe5@gregkh>
Subject: RE: [PATCH 6.9 083/163] ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
Date: Wed, 24 Jul 2024 16:57:37 +0100
Message-ID: <001201dadde2$34f68710$9ee39530$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQLyD8B3yh8i0hgv7tpKHZqoLGh8kAIJjVwZAe6iDEMBz4upEK+pZm3Q
X-Proofpoint-GUID: HeAe9PLpsFdJXoFr2UOTpEw8EX-rLMwD
X-Proofpoint-ORIG-GUID: HeAe9PLpsFdJXoFr2UOTpEw8EX-rLMwD
X-Proofpoint-Spam-Reason: safe

> -----Original Message-----
> From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
> Sent: Wednesday, July 24, 2024 2:48 PM
> To: Simon Trimmer <simont@opensource.cirrus.com>
> Cc: stable@vger.kernel.org; patches@lists.linux.dev; 'Takashi Iwai'
> <tiwai@suse.de>; 'Sasha Levin' <sashal@kernel.org>
> Subject: Re: [PATCH 6.9 083/163] ALSA: hda: cs35l56: Select
> SERIAL_MULTI_INSTANTIATE
> 
> On Wed, Jul 24, 2024 at 10:35:57AM +0100, Simon Trimmer wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, July 23, 2024 7:24 PM
> > > To: stable@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > patches@lists.linux.dev; Simon Trimmer
> <simont@opensource.cirrus.com>;
> > > Takashi Iwai <tiwai@suse.de>; Sasha Levin <sashal@kernel.org>
> > > Subject: [PATCH 6.9 083/163] ALSA: hda: cs35l56: Select
> > > SERIAL_MULTI_INSTANTIATE
> > >
> > > 6.9-stable review patch.  If anyone has any objections, please let me
> > know.
> >
> > Hi Greg,
> > Takashi made a corrective patch to this as there were some build
problems -
> > https://lore.kernel.org/all/20240621073915.19576-1-tiwai@suse.de/
> 
> Thanks, but that's already in this series, so all should be ok, right?
> 
> greg k-h

Absolutely, just checking!

Cheers,
-Simon


