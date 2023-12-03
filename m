Return-Path: <stable+bounces-3717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526738021C2
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 09:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1515F280F41
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3128E6;
	Sun,  3 Dec 2023 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="QzjeqsxG";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="nLA56QDl"
X-Original-To: stable@vger.kernel.org
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C1107;
	Sun,  3 Dec 2023 00:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XKLc7nsSut7asYOvPOSBF3sFLon6YMwbrrbjTMI2vZI=; t=1701592373; x=1704184373; 
	b=QzjeqsxGm814if/mVNeJKXbUfXNIRBWy5uProtThQbOlun0xfcJI/q+Hkt1I4/8ucY+KTAcsAdY
	K0qkglSWFiKuzhDKAz8flfFqHW8HKBM7gDTH3m8aEcyzYwyDVxv6c6pWHX3VU5WxUD/pYacMpBQ+k
	atH9Wbe4m/KZkocJnPMFmH/oDztFRFlGRz30RZamrzCcroRFWt7/hLbKbMBWh3aUzf9YHHOIhvHkL
	iHzprcdirSJLE9nqvGYU+ew/yLPgPDj45/ee+gY8f1NBYydiq45Fvmdt1YboMwXhre/nXyoJbaYiK
	EeFWWEir2fbUrxu/zELbTK1Oeg/CaWP34l8A==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XKLc7nsSut7asYOvPOSBF3sFLon6YMwbrrbjTMI2vZI=; t=1701592373; x=1704184373; 
	b=nLA56QDlWBSDtOFmACYQf2vsfPAOeymFkVc2XEKzmc39/EHoRyAcBuoMq+MInKaKwUNLwPKh+/7
	gtNONFBGWDg==;
Message-ID: <ef575387-4a52-49bd-9c26-3a03ac816b61@moonlit-rail.com>
Date: Sun, 3 Dec 2023 03:32:52 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: Inoperative bluetooth, Intel chipset, mainline kernel
 6.6.2+
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, stable@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 linux-bluetooth@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org
References: <ee109942-ef8e-45b9-8cb9-a98a787fe094@moonlit-rail.com>
 <8d6070c8-3f82-4a12-8c60-7f1862fef9d9@leemhuis.info>
 <2023120119-bonus-judgingly-bf57@gregkh>
 <6a710423-e76c-437e-ba59-b9cefbda3194@moonlit-rail.com>
 <55c50bf5-bffb-454e-906e-4408c591cb63@molgen.mpg.de>
 <2023120213-octagon-clarity-5be3@gregkh>
 <f1e0a872-cd9a-4ef4-9ac9-cd13cf2d6ea4@moonlit-rail.com>
 <2023120259-subject-lubricant-579f@gregkh>
Content-Language: en-US, en-GB
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
In-Reply-To: <2023120259-subject-lubricant-579f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> Thanks for testing, any chance you can try 6.6.4-rc1?  Or wait a few
> hours for me to release 6.6.4 if you don't want to mess with a -rc
> release.

As I mentioned to Greg off-list (to save wasting other peoples' 
bandwidth), I couldn't find 6.6.4-rc1.  Looking in wrong git tree?  But 
6.6.4 is now out, which I have tested and am running at the moment, 
albeit with the problem commit from 6.6.2 backed out.

There is no change with respect to this bug.  The problematic patch 
introduced in 6.6.2 was neither reverted nor amended.  The "opcode 
0x0c03 failed" lines to the kernel log continue to be present.

> Also, is this showing up in 6.7-rc3?  If so, that would be a big help in
> tracking this down.

The bug shows up in 6.7-rc3 as well, exactly as it does here in 6.6.2+ 
and in 6.1.63+.  The problematic patch bisected earlier appears 
identically (and seems to have been introduced simultaneously) in these 
recent releases.

Kris

