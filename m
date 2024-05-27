Return-Path: <stable+bounces-47352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7C78D0DA2
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FEE1C21587
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707E15FA9F;
	Mon, 27 May 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="EhWrLL+w"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0717727;
	Mon, 27 May 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838326; cv=none; b=t9pvZRSVOxeVsaXYO5CtljDAq5cbnBk+l8aiSVDvLCMWUU2ceC8JAndMSJLi83kJR6Cffd603RGcloFpTsl3q6+L3vS89gEdajh8gSdU5oyQQe6bOiplqFxS7fUEldU0TPowvZaIPV1uPR+lCxRx6DyjEnEw2+5qQrmYCliia2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838326; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=E2xoTA0mbUF8sVMXThMwGRYJksLPufCKU+4TDlbFykAl+lRlkSTdbIkdDJWRhpjpu2f/sfvZP5ZQkb/21lcxC/BEo3d2Sewo2iZLDdtm8yJJ3PQja+HpOdLtsx7a4nl5U4ApWacqbC1f4QI8G0PuxCthP4Uy96QNVcWSehF6zKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=EhWrLL+w; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716838321; x=1717443121; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EhWrLL+w9hdZQZdx4s7O1D3zvuJYvwzmMl2ay3OOHGuKJvioHl/10FvbHPg6LkuR
	 DhczJXL5gpBCcaSdvWqem5eOfIBAhMiA3SpuxGvSf1Py+HIzF7uiXK2BKBAfaRwv2
	 HdvusuTXSSjQpJGP+mIvmIh+3K8jpRPISoZ1kF+oJsJLwvwPmZhgJGeyMRXUPPqkR
	 pCJznmDGOuPxOxq8cKfMqUCh40GbaVAg1AAYLhk+Tmn3GWg2E/oeqiMgatDY7Ex2R
	 5F5BciJ1mb7PCRky6u0SqAqdseAKR4QrUKStfwhB/UF5JNom1vS5n62ya5D9OXS0l
	 L60bamqA072GiiRxCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.221]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLQxX-1rupe60hRD-00IX7S; Mon, 27
 May 2024 21:32:01 +0200
Message-ID: <4b594156-38ca-47f4-ad9b-8f988b632b22@gmx.de>
Date: Mon, 27 May 2024 21:32:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.9 000/427] 6.9.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BTtreE723VMNG9RwL8Pr7Ps9zjM0Q+pvQGTSlnlIzsPh71BFNrK
 gV6vc2nmb+myl40r2zaZSkhsOulpoDSMrIhTgEqOCI8KWTJ9uKTBORZmohL6MYtVsJmu15h
 4xNHF8T3N656wmBCnpMqGxx27v9xPlOy8yHHULZgdHnoUrJQdK/YTpKnvUe5j6NtF/C2W4h
 76h2L/tgtSTxu4pRyje1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1Li2LL8TlFE=;1aq23OSFp0xtYjKKLeB35DKTOU1
 Cnwxp3y0VCwPt0ngMT3QCo+PkNEgFQDJw3BEqONL2dPb6XxwJKgCyYs4FQBQf5dvxjC0PIDgT
 5mJkoefmQqqVbg279s1qX/nprIKXYus5jScqeU9a6lPKOVW5Aa4EDK4UL95p2KUI/7fnR+Kks
 gOtLorEvkkxmou7xzoWmGxFFvMNzFQtkPiIrdtnQjLJdcng1RUat8F1gLSZ3VBuicVS2m0zRC
 sICuf5GkM0HK2DqimONBjeJ96yN9mOpsMBPRLevikTqnVN5Zi9zlZ8GBOE72uqj2Z4QhJl62f
 tE1CyQUbMrNmYE2H1ISrNorjBPWiXlXsvpUqR3TDWACQFp75aAiQnu+yw0t3xcdRdt9cm3O1A
 MtEIBhm3GulPD5yhyE0sOD+jmtepoWC1jthKrj51Y+ND0VXBvwTE4ZTFPEJWNLZNGAz3jzj4x
 vMQwg3HNBvqO5QCmp+JF/lHlKSfPg/evW86DXGGA83cLdHsNZ942BANB1tQGJ7JAFzeBrb1AT
 ZzCA6wxMAyB5pBvKoweFmPcSgvdqx8A997QCCo1LWoGABPxN0cdk3izCnbaz4gbfWSajE4kwE
 5Tcx8iT0hEFqFSQMMbR3nD2dmzpB2rRRts1R7TfyZXqcO2IV8sIaLeNTDvasRucWsfsEkiQFH
 AaTKUiD9TlfVQCINCu843hxDXSCQBFY6SHBPh0IFw6SER6UKox1p+8pKQIWv6SK4ZusmFtld/
 +Or/P/TG/kTVObGal1Tolae89MSyEe2xDZ+zBfz4vYfY2YzrXLYjbNOyVPQOAKn/yjrsMFZkb
 6MibWL47PzchaSo6sdT76a85NnXBRPdrOMtNZrZ086CTA=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


