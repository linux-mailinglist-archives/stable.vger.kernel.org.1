Return-Path: <stable+bounces-61303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714D93B469
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BB6B24643
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710815B963;
	Wed, 24 Jul 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="aLNOdKMs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D7F1598F4
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836673; cv=none; b=mRKxRPaEz74i518IcqU8nU/+2Pd2pZXS74RzY514lyW7Je7dJwtpMCDI4nPvuO8b4C2tYhkF0nstUFiC6BsRQ5ZLHBGkzCjCh17upX/Nh6XtdJDGiLYdhp9dbzswos7dP2oOkFhFDLO6CAKTftIWJEgNDg27LseFOBApHtPLl+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836673; c=relaxed/simple;
	bh=XxWzz8IT32iDI4cEG0JSzSuTkrNROP4CEK0EjPSVtuY=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bt8h1Hmk2mS1+gRuiFUDJ8rENQTNoEJafn5MImbMqN3muNryWoHEe7sXg9cZEMnN4b2KGEvcCfqUMFkviTQsw8N6SFA5BpPDKF7sD7k+6or11Bvkfj6ZUciprT56rdEHDMGKiOwL40mQeSOzP+iJR2wYY294ul+A2Bw8Ft8Da2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=aLNOdKMs; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OFtXNQ027842;
	Wed, 24 Jul 2024 10:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Y/to7gwDeSPmlJbsRzqK6rL30bDH/vknxk9GcT4SZck=; b=
	aLNOdKMs0thlW0fKpmCgBrxvkXxS2n6k4w3IS5qiuDMi8Cd+e3g3w7JhNKkXDJGs
	z/hrpexrGwUmZuOKDWD35muhwTdxce108CsL7tHTxb846e9YhSXY4uJzlkNMPVt9
	/L8DEnJir9agYVV0kku4cooXlnUXBYJqcpBHh5GPetpqKHS5oXjXnp/SJDnzmZHa
	X8lzdsZmNUjVyF3V78LkR7wOONO3XyD4JKWQ5xNg3sAL9OYaBaJR0vAz4GAJEaJM
	aJXyMsplASy/YDwqn568H6tXnXIOoHnt16OHTlIrzvCymCiOaxoGr4ea+5TJnzMJ
	bRb/OG50BfeCVDbdOtROqg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40g9nj4u9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 10:57:42 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 16:57:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 24 Jul 2024 16:57:40 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7E0EC820244;
	Wed, 24 Jul 2024 15:57:40 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <patches@lists.linux.dev>,
        'Takashi Iwai'
	<tiwai@suse.de>, 'Sasha Levin' <sashal@kernel.org>
References: <20240723180404.759900207@linuxfoundation.org> <20240723180407.143962331@linuxfoundation.org> <000201daddad$047f1910$0d7d4b30$@opensource.cirrus.com> <2024072402-hesitant-rural-ca4a@gregkh>
In-Reply-To: <2024072402-hesitant-rural-ca4a@gregkh>
Subject: RE: [PATCH 6.6 061/129] ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
Date: Wed, 24 Jul 2024 16:57:40 +0100
Message-ID: <001401dadde2$36733c00$a359b400$@opensource.cirrus.com>
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
Thread-Index: AQHk4wAjmeYr4l5M1d/u2hFDB5sLMgIHoZLhAXs6/bICX46vAbHC6vBg
X-Proofpoint-GUID: nGBRd_V9Bl0XgDz4IOCBlW90jtonlhdw
X-Proofpoint-ORIG-GUID: nGBRd_V9Bl0XgDz4IOCBlW90jtonlhdw
X-Proofpoint-Spam-Reason: safe

> -----Original Message-----
> From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
> Sent: Wednesday, July 24, 2024 2:48 PM
> To: Simon Trimmer <simont@opensource.cirrus.com>
> Cc: stable@vger.kernel.org; patches@lists.linux.dev; 'Takashi Iwai'
> <tiwai@suse.de>; 'Sasha Levin' <sashal@kernel.org>
> Subject: Re: [PATCH 6.6 061/129] ALSA: hda: cs35l56: Select
> SERIAL_MULTI_INSTANTIATE
> 
> On Wed, Jul 24, 2024 at 10:36:53AM +0100, Simon Trimmer wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, July 23, 2024 7:23 PM
> > > To: stable@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > patches@lists.linux.dev; Simon Trimmer
> <simont@opensource.cirrus.com>;
> > > Takashi Iwai <tiwai@suse.de>; Sasha Levin <sashal@kernel.org>
> > > Subject: [PATCH 6.6 061/129] ALSA: hda: cs35l56: Select
> > > SERIAL_MULTI_INSTANTIATE
> > >
> > > 6.6-stable review patch.  If anyone has any objections, please let me
> > know.
> >
> > Hi Greg,
> > (As remarked on 6.9-stable) Takashi made a corrective patch to this one
as
> > there were some build problems -
> > https://lore.kernel.org/all/20240621073915.19576-1-tiwai@suse.de/
> 
> And that commit should be in here already.
> 
> thanks,
> 
> greg k-h

Absolutely, just checking!

Cheers,
-Simon


