Return-Path: <stable+bounces-127451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B633A79844
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 00:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22137A38C0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD361F429C;
	Wed,  2 Apr 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J6AtNpqS";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E1BJ8R9t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WwuJI2RJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920A3597B;
	Wed,  2 Apr 2025 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633101; cv=fail; b=lRAEMi/FP8XIwtCKZ3wEs9qf6BGTJgehuXn1D35FsbCYoaN1J2bBWvnG+Wa9jnLXtnBSv7sfGCQZw9S4fhJ/KGDGvNFQPAnzqnr827+gxNaljEQ3Q4a7xJeRWWsGFARhD5pCCtEIn7HYaS1GtuHx2jCu1/unQoK4vGUXDFmWdgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633101; c=relaxed/simple;
	bh=BpX31uKtEFI4DTWzu0nFJuV+tsAV9JcToRaZMZ6jbWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sccgR+BkXQyd12rQDT1WUuC025v2RAUJh0A4UZfJ6EYPpMDDYRaP+zrauVcoAmElM75vchX4TYvd9yTaU37s3BOqi+iO0frA+NhVVQxlWbjNM+px84T4U+V4zYgz2XBPJ43JbZegx3mTpMW2AEUQXnrGmPeYS3GnsdECAtfTD4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=J6AtNpqS; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=E1BJ8R9t; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WwuJI2RJ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532IUicg028984;
	Wed, 2 Apr 2025 15:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=BpX31uKtEFI4DTWzu0nFJuV+tsAV9JcToRaZMZ6jbWM=; b=
	J6AtNpqSmwcrrvIYOsQTm3wZMCGGUzjPp7NEcpbS9Z9tSOa1UGeBKJwBNsGd44g/
	+pBYr/zoYo6cI2lSKuz/8fEeEYTwFL//5Lj8Afa6ZQHJv6k8fbgJ/SAfbwgibx6O
	SBo/Tvq/U0WRYOyPSy20D8Lt/k5NiS2HG2J8/A0O4cSS4ry/w3p1vaeOxqaXVglC
	0lX2n1Drr8aH6EFo8UACuIFE6L/k30Se/4wPxhVsnkcGCCdF7HGQSqr501LgB2N5
	oMDiccwDWitpXfiFN/dUhSWpitQOO8s8JV5CZX7hDYVIDkN/ZyejvFdC6+hNKNTM
	zGuis5t+DsYV9dRpUnE4hA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45s5egarkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 15:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1743633068; bh=BpX31uKtEFI4DTWzu0nFJuV+tsAV9JcToRaZMZ6jbWM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=E1BJ8R9the7bq3g0HRnWWss2rTfCSMFWk2uIPPwfZm3Bs+NiP2750Mxp1Jhhb5rNj
	 DRb6XhInB5cDCfaixCr7oDUcT8+RBjODYdqPog6II1WUaIGZqJ93eccwMO+W2WsyT2
	 VsNbsh1kP36P0pOAJdNOJ7yR5ltu2eckUsTCOpjLROyz24he9/LnqIBw5X/AOzaCZR
	 Gq3dDDRrV+Jhfok/7X3PVAv4j/bfhtFdqrMgdH+oCibBPBWGftrYLvYkrYCcpkj62c
	 emtYq6eTp0cCpdnikII8jOZFGR+OA1a2pmeZuQ+YbFX4cZWNcagR3yV2gnBgK4lVNW
	 l8rzVJv57MqdA==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 41D1C40136;
	Wed,  2 Apr 2025 22:31:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D0940A006F;
	Wed,  2 Apr 2025 22:31:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=WwuJI2RJ;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id CCF4A4035C;
	Wed,  2 Apr 2025 22:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3kdczwrb37dkm1W9MVxEyiyd2E095Ww6RqdBChe1Y/Un5iA6PXgmfpkH6Uxy8YE6JKfudgm8FBc+fQRy5lIVAZdN9JLa4/ZkKXXnRoObGQZ+yPP7KRLwaU0ORdbgUFawi+FtqMGZBetctkyTHcJw0Xzbh1+P1EycN7YNqGYNAx2BlqrH/el6psLAzWfgaAnaIRxQ1OqMiXLplo6brof5cR47e+nS9YfFNDUYZuz5FJB886Uj3o9mWJthak+QnxNEoOsBMLl3Vk+q7hGAKKFMB4dWVzGRyyTI7JPf9o0MSYpM7vJhI5JPGAG73tuwUq+4mpP0nR8HskPTiSRk5PbGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpX31uKtEFI4DTWzu0nFJuV+tsAV9JcToRaZMZ6jbWM=;
 b=MeJEl8QKQLRf6ANEnHkqVuHgPLuuRHHfGMl1XnAkr6qu38PV9DRslZyV/lPklA+Pj6J4LtapBU01LGCs4DZW6lwzW1mx67AKjPnfD3u1kOQwJp6MRQco8QEtxCAmtZLljH9EHODQcq7KQjsTQh3O/orILOAlm4ilIMCwWQc0a6lDB0kNl0DuNuLfhQ8+pIPW+dG9eAM+Rpkf2/xvDyh7lnkMhM0zNGyNe8w5AJUCxLQSfq+NhypIMNoBsjE824b22yz1C1UMIgXcCE6Rj9zAX1H12qieTQjT6pBuLD04KSkwCiU3ObdTYlu/Mw3ci+KD6jzmww2i6CXYSBNvm/Nmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpX31uKtEFI4DTWzu0nFJuV+tsAV9JcToRaZMZ6jbWM=;
 b=WwuJI2RJFZDVpul0D68hSARtbYsY6r4QCmrrEDXL27FpxUOjLWqME25W18dPgOy3WAifvJA00cSKhHawxfbDX9xAIPLW2wFgKun8odWNnnXTeMSY2oED8+crMvsP7i8BoCNxGOOuUSSDTL+o/ihJOjUOhSW4bKA9bbvbeTF8rBE=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.53; Wed, 2 Apr 2025 22:31:03 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%7]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 22:31:03 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frode Isaksen <fisaksen@baylibre.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krishna.kurapati@oss.qualcomm.com" <krishna.kurapati@oss.qualcomm.com>,
        Frode Isaksen <frode@meta.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Topic: [PATCH v4] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Index: AQHbo6TOGOPHoORze0SGwQO2Dw6NLLOQ9ooA
Date: Wed, 2 Apr 2025 22:31:03 +0000
Message-ID: <20250402223102.d6ib4b5plntggr4h@synopsys.com>
References: <20250402075640.307866-1-fisaksen@baylibre.com>
In-Reply-To: <20250402075640.307866-1-fisaksen@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|DM4PR12MB8474:EE_
x-ms-office365-filtering-correlation-id: f3381f58-7735-49ec-f479-08dd72360d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUhGaWlFQWN1c2tnMXVFNHZOWXFkY2x0Y0dnYlhnRG5QVVBtOHc5emlncmxS?=
 =?utf-8?B?Zk1SbjRwcDdPeklkM1B1ZEJvTXlPWVRlT01IY2xrR2VSZGFZTXdqOGphZ1Q1?=
 =?utf-8?B?TzdvbGozbytrczFGQTRBUWhLQWppUys1RlkyY1lGdzhSZmR0ZXhXYkg2ZCtD?=
 =?utf-8?B?OUdIZkF1eFpMK3duTUVxZm9XVnN0N3FRem5LSUJva1I2Snp0cjFIRFRLK0Q5?=
 =?utf-8?B?b0tiQXFaOXVOZ1ZPUEtvUW81aTN1a3d6a0dqSVJoQitKZ3ppNk1FUVpOWDEv?=
 =?utf-8?B?aXF5cWQ3cEU5UDl4dFRvZkpjRmhzd3VUc1BTSG1TVEhHanVOTmdCWUhIUEtH?=
 =?utf-8?B?TjJnZmJJRzllK3BaRDVDMDlRV2NTVmFHNE4vekcvU1JFYmlsMFhSRndneW0r?=
 =?utf-8?B?ME41QU5ZenhSUGs0bUc2d0w3MTkyRVM0ZXhKSDBWUEI1V0xzWndaNExNQXM5?=
 =?utf-8?B?M2I2VU92eWllNktIOHFYdTRxOHFyNlRpNjdHMkoxZU1uOW5jMUZGQSsxRUxD?=
 =?utf-8?B?RXdXelBOQzlGQ2Y4M3J2cjU5NERBc1o3NHpObStqTlBlam50bkI1MG5MQnIv?=
 =?utf-8?B?Wi9SNEFNdHNQR3FSYUxGSUk5MklLZ1VBWDdLcGw3Zk9oYTlwZkovRkJIb1dm?=
 =?utf-8?B?a1U3MVNwa2ExcnNOdHlSNS9Zd2R5ai9aZ3JZSHdLSithNkMrMlozZXMwM3lI?=
 =?utf-8?B?RkltakxGUlZOYTFPQ0l5WGR4QmZvZmFVWVVVSG1YQlEwaE5PRXFXQU9aSUI5?=
 =?utf-8?B?UTlraVVDdWxpTUpaclBPMlNQYktMWnFDWEF4bUxmZGFic2hpNUtOdFlhRGxR?=
 =?utf-8?B?ekRoMkdzdFo5aUVOSU51N3diTkRQM21NbWtSNmJQL29MRXl2c1R2UDlCQ2U2?=
 =?utf-8?B?YStzYklnWDVzVXk0anBXbVdDK3VxL2U4aS9HZ2t5bHc0WFNrYXluNWc4SVZn?=
 =?utf-8?B?ZzFIN3RqY3lGd2V1WnJhNEdyOUNPTzhZOVFWYy9hdGZwQjlpOENwaFFoZjBS?=
 =?utf-8?B?NUMxUHhWenAwZmpwaGdXNjBmZG5kZ0V3QXdJMDY4cGhQVnMzaDJReFFwR2wr?=
 =?utf-8?B?TU1CKzJVaUdTd2l5NDZ0OTVpK3BScTBieDVTK2ZkOHp6Mi9VWHVSa2MrWlBj?=
 =?utf-8?B?WURKeGw5dkpFQjQrYy9NTHlLckNRNnhZZWljWmpEVExwMU5HcDV6OWtPNzA4?=
 =?utf-8?B?aHBYVCtoZ29LZVJWc3dUWERiZVc0c2ovUFVrM2c2a2x3TUszZ2xhQTFvNlR3?=
 =?utf-8?B?U3lYQ0QxblJNYURma0p6OXFYVHF5aUV4NEFDZ1c4RlBIRDRlR1BsRldDNG1n?=
 =?utf-8?B?VHB1UU9iTTNrTXI3bXJhTXQ5NWFEUjlJa09HbFBjaC9EL0tLWjJUYTVNWC9U?=
 =?utf-8?B?NXFsRHp5YTc5aW5JNE9UTkIyUHVYeWVUeGRKMURsaU1OV0ZYbnJLK0I1amVV?=
 =?utf-8?B?ZTlzWnNlYW5Xd3Vtb3cyNVZFMGhmeHZKejlwNFNoNG5tVnZGalFDUEI2OXNr?=
 =?utf-8?B?M3ZnV1Y3L0MzSmtzaWdRdWpjQmpsNnNRd0pLb2xJMzRSN0x4Rkg1VG9qZVZn?=
 =?utf-8?B?aE56SVZ3N1E0cmtFRzVNUWxQamxPNGFNYm4raHc0QmJrL041RGF3REJWRHZ3?=
 =?utf-8?B?L1pvVzlEemQvS2gyQmhBMDdFZ2ZxU2pBMUJqOVU3b3NGYWp3d0ZZS05qZ3JK?=
 =?utf-8?B?Z1o5WUgxTnMzYjg1NjI3RnFCM05yTUVEWnlSTzRVTWlBbG1ydzZBZGlPVm5Q?=
 =?utf-8?B?QlR5b0w5MnQ4c1JkeWJFQ0pjelBKZStoYVFvT3FzRjZmNEgzSHVwM1N5dnFl?=
 =?utf-8?B?RzhpbjJCV083RHZDbjI5NFN4cU94V1diOUtHeXduaUZrWkYxQ2VNc2dwN2hQ?=
 =?utf-8?B?N0tzclloZUJLM0VjWm9mZnpBQW9ZODVNV2hUTjdUb0JUanJLL1pOekZXdzhV?=
 =?utf-8?Q?n0Qr4Cw7sVLHlOFDEi41Ycy2j4VOPxCm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3FyTEcyNGt1VEY2NDJVYjNqdHBBRlRaRXhaRUJiMlFQT1pOaE9HSngyaXY2?=
 =?utf-8?B?aXppK2VHcTBDVmxZQ3NnSXl2a011c0tDRy92c3FPdUo4RWZMam9kSkZZSzB6?=
 =?utf-8?B?SUpjWkM3dG54VG85SnRTaEhIaDhUSVJEVmRiQThMYW1YMngxaFF0Rkc0aGxn?=
 =?utf-8?B?aGZJdWRCbDJGQzkxdWR4NmVDRFV5Z3BCVUN6UEZWQWtPWUdxTHFxR0gwbTNI?=
 =?utf-8?B?UHI5U0k4c1JKWTdJSUdUMG1ialFMMkJiOHAxZ0lOSFRMOXQ1VE10ZTJXTEl3?=
 =?utf-8?B?dlhvaTVoSXI0OEpXS2w4WDQwdmVOTGc2V2N1aGZVeXFSeFUvdTErNkp1QkNG?=
 =?utf-8?B?K0hsSTZWVmZMMGMyODVaNDlDYkpLT3JpQnowV0JhMDJsUFo4dS84ZmtxK2ly?=
 =?utf-8?B?aW5JZWtiTTd4eU5CMlAzTjhTYlQ2ajB5UnpBZ2pKSXMyRmhBVGhuTytkMW1C?=
 =?utf-8?B?anJKZkFJekhTUWpMY1dkeWcweHFrWjduUThaVEo1QjRKbFFodWpCWVVrekt0?=
 =?utf-8?B?TFN6YlZmSXdTc08xbCtwYzgyVEdESGdwTGE5Sk9tb0tMVDc5OVprTG5QTUtB?=
 =?utf-8?B?aUlIUkxJSURiNmpZeXZQTUVoTi9Vak9Tb0NBZU1wcnlDN0hKL0tmUTB1Um9Z?=
 =?utf-8?B?aTd1bHhWRkpObm9vWEZ1STVackxhNkN5TG5tNmV3YmxVNjZYdUZ4bUpLcTZJ?=
 =?utf-8?B?ZTJuSG5iQm9yaVg3dTJ5RG96bVdSUFYzcjhGeW5GeGZXZjNRZEJhZGZNQ3Mz?=
 =?utf-8?B?Q0NyazVhcjAxa001c0NnWmJkZExsckV0V1hzU0FsWWNmVDQxNERGWjhBQ2lJ?=
 =?utf-8?B?ZWRBeGR0aytkUmNlckt2UVVCV3ZibFlSS1FYMjJTRUhvKzZqcWNnaXNuOEV5?=
 =?utf-8?B?OWpqMVI4NFJ6dzRRa3Z4OHlLa3pvRTBkbk1DUGhJYlR2bUJOZW5JRi81TFlG?=
 =?utf-8?B?V3VVOXhQbkYvUUp5T21WN3pzNkU3M3hTRGY3K2dEVHg5RGtTc1ZHUkVnemVF?=
 =?utf-8?B?UGpOVC8rb2pPZkZEMDZuZTdHejJBQnJtbmZ0OUViMkRuUk9KVmRnYTBjelEv?=
 =?utf-8?B?RWJrRTB5aHlIa2RKam5aSVNsYXBYQUNpVlRDelkrdUs3bnNoR3Y1SVQwbzRX?=
 =?utf-8?B?eklkRU9lV2NQS1BaMnR0YnZiMkFrQWZZSk9JRWpRWkxTQWtjTkFXcFovR3pL?=
 =?utf-8?B?ZzUxYjZBOFdHV0hOTzgyUzY2MmFtS3ZZZy9BR3NtSGpHcWtzNzRIZi9XaFZX?=
 =?utf-8?B?d2szOWJvUVR4bnZmZ3hQbDRHTWNsUnh2VnhnSVUyb2pCczhyWFZKL3krRUJn?=
 =?utf-8?B?cFRML2F0cnlWeVB5RW9WcW9qdVM2NURTVDBmUkRLS1lMeTBsZFJHeDhNK21P?=
 =?utf-8?B?SUNUVGJ6VlNmL0k4NFFMd25TMjlTRlo5b1pGTU9rOHZ4d1RaaTI5Y21TejNj?=
 =?utf-8?B?cHJQdXV3dEozZmZOSDRUOVAzbWViYkMrUlRDMnZHSUl0b1lCdmZzQSswaHVB?=
 =?utf-8?B?M0I3VTVVL3hrT2N3cmJYa3ZabTFadFVwdGhOY2R3M0ZDcGpYbXJILzc3dGtJ?=
 =?utf-8?B?SVQycm5QVnZlQzlBbFo2emdWR0pMQmxZVDlXNEVaVUtJdEhCSStSaFhFMXZU?=
 =?utf-8?B?V3R0YUp4Zy9wcDREbEhzOHEySDdybzNlekxCZGk3bHUwYUE5WTZDRlJqWU1U?=
 =?utf-8?B?aUtYVmxxT3dMUWtjWjdjeUFMN1JYa3J6NnZNWEhxUzdaNmdRWEhzRHFZMXBn?=
 =?utf-8?B?TFozTVZ2ZndVZW03dmdvUmhHMVI0MzlpdnJzMHdWNnB0b2FJM2gzbUROSzla?=
 =?utf-8?B?SVZBeUJoKzFIaXlZcWZwa1BSSTVWYUI3Z0QxcllFMGxFL2Y1ZlNlc0NLbmZH?=
 =?utf-8?B?NHcxNG5uc29PMU1MNU4rODN4Y0IzM01iZ253WStuN1ZUSkNZcUprNEhMU0Fi?=
 =?utf-8?B?R2JGSGszbVA5bTZ2NStvZ0JvOWxKUmIwWlZzTGFzOER0TGd2WUdPdUpFMUU5?=
 =?utf-8?B?VnlCWVJ5bmdUbjFBdC9ramJXdURsVmxWcHp0alEva1k1RzNmRGlRTWY3dmpT?=
 =?utf-8?B?eUtxNFMxN2FjVVJDaHFadjNZeGd0eE1jdWxjemdRRTh0WFp6aE5VT1dSOGly?=
 =?utf-8?Q?UpWO94PNNo3i+e9+76M+aMQ+7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <373D01FDA1A08C449FD027C8B80B8EB0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RReYDrDR2uXExnILXfBoIuFSrEJp2YRA37UDVS5kZ4T4zItVJinijMC1Lb5nPjYTGG3QBju1uJE7822zIg+EH1GqbmaRS1u0KSSH3q6k0XH7KQBoKbu0E9NtAGBkJW8Ik7FKtQKeT/uUmvK66nj1LCHF61EtMYHNA9ssrLJjTIkKPiyE/Ty76VGXMY7658Mp8o1kWxPQxueL3nuFURraXrCGDUDSMELEgziYSeT1PcGbjjEDBKoIq8VJdxstEuld3YF4wC8UW/fypmNzJU4+gLbXXCN/xLF/lnK9NnXetCEV8LoKuk2MAX02QVHJxPo71dSngCIlhKWwKRDjGoayDs130sXSOwqf+8pfBF2OLspGB0NRugBPzCKVl8iDDon/+DSql/S+ueKnR/Ssi7vXWqjef29UjWXqeBvgEzN6YebPxzuPmssTEtskuaFv1XJWvk/s4PS6vVehdFZ7757w0xnJQ4XYsuS3u5gph3wu1URJdFcL5tVhpL6tPIkuQ2YwgL0BjtZ9Jm/YclO+SMqbJlvfxi9e+GcEpDc/SNq336Q1jPkXeTE571oBNhlosOHfzDjnvUc3g0qVBf2vPe+/vY0VAOA+hRgqEKiH+cpXTrq85jsa5ZJfLk2papPOkxe0tUl8kj2Us3r70htaY1fE/w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3381f58-7735-49ec-f479-08dd72360d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 22:31:03.7042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZQfrkqtDW1NvVuC1jvAgbpywIcx650jMfTZc2CSV7tSMi33IIhKKl2unhMj+yi+uqNhOfwzDt8guP+xFTcr3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
X-Proofpoint-GUID: 3vB5KHKGqYEjYDatiAqb5dq0GAX4pUmN
X-Proofpoint-ORIG-GUID: 3vB5KHKGqYEjYDatiAqb5dq0GAX4pUmN
X-Authority-Analysis: v=2.4 cv=BrKdwZX5 c=1 sm=1 tr=0 ts=67edbaac cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qPHU084jO2kA:10 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=ljRNVb5Yf96Sgrzi-AQA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_10,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=678
 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020145

T24gV2VkLCBBcHIgMDIsIDIwMjUsIEZyb2RlIElzYWtzZW4gd3JvdGU6DQo+IEZyb206IEZyb2Rl
IElzYWtzZW4gPGZyb2RlQG1ldGEuY29tPg0KPiANCj4gVGhlIGV2ZW50IGNvdW50IGlzIHJlYWQg
ZnJvbSByZWdpc3RlciBEV0MzX0dFVk5UQ09VTlQuDQo+IFRoZXJlIGlzIGEgY2hlY2sgZm9yIHRo
ZSBjb3VudCBiZWluZyB6ZXJvLCBidXQgbm90IGZvciBleGNlZWRpbmcgdGhlDQo+IGV2ZW50IGJ1
ZmZlciBsZW5ndGguDQo+IENoZWNrIHRoYXQgZXZlbnQgY291bnQgZG9lcyBub3QgZXhjZWVkIGV2
ZW50IGJ1ZmZlciBsZW5ndGgsDQo+IGF2b2lkaW5nIGFuIG91dC1vZi1ib3VuZHMgYWNjZXNzIHdo
ZW4gbWVtY3B5J2luZyB0aGUgZXZlbnQuDQo+IENyYXNoIGxvZzoNCj4gVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzIGZmZmZmZmMwMTI5YmUw
MDANCj4gcGMgOiBfX21lbWNweSsweDExNC8weDE4MA0KPiBsciA6IGR3YzNfY2hlY2tfZXZlbnRf
YnVmKzB4ZWMvMHgzNDgNCj4geDMgOiAwMDAwMDAwMDAwMDAwMDMwIHgyIDogMDAwMDAwMDAwMDAw
ZGZjNA0KPiB4MSA6IGZmZmZmZmMwMTI5YmUwMDAgeDAgOiBmZmZmZmY4N2FhZDYwMDgwDQo+IENh
bGwgdHJhY2U6DQo+IF9fbWVtY3B5KzB4MTE0LzB4MTgwDQo+IGR3YzNfaW50ZXJydXB0KzB4MjQv
MHgzNA0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJvZGUgSXNha3NlbiA8ZnJvZGVAbWV0YS5jb20+
DQo+IEZpeGVzOiBlYmJiMmQ1OTM5OGYgKCJ1c2I6IGR3YzM6IGdhZGdldDogdXNlIGV2dC0+Y2Fj
aGUgZm9yIHByb2Nlc3NpbmcgZXZlbnRzIikNCg0KQXMgbm90ZWQgcHJldmlvdXNseSwgaWYgd2Ug
bXVzdCBoYXZlIGEgRml4ZXMgdGFnLCByZWZlcmVuY2UgdG8gdGhpcyBzbw0KaXQgY2FuIGJlIGJh
Y2twb3J0ZWQgZnVydGhlciBiYWNrOg0KDQpGaXhlczogNzIyNDZkYTQwZjM3ICgidXNiOiBJbnRy
b2R1Y2UgRGVzaWduV2FyZSBVU0IzIERSRCBEcml2ZXIiKQ0KDQpBcyBsb25nIGFzIHRoZSBHRVZO
VENPVU5UIGhhcyBldmVudHMgYW5kIG5vdCBjbGVhcmVkLCBpbnRlcnJ1cHRzIHdpbGwNCmNvbnRp
bnVlIHRvIGJlIGdlbmVyYXRlZC4gRHJpdmVyIGNhbiBjb250aW51ZSB0byBzZXJ2aWNlIGludGVy
cnVwdCB1bnRpbA0KR0VWTlRDT1VOVCByZXR1cm5zIGEgc2Vuc2libGUgdmFsdWUuDQoNClRoaXMg
aXMgbm90IGEgZHJpdmVyIGlzc3VlLCBidXQgcmF0aGVyIHNvbWUgaGFyZHdhcmUgaXNzdWUuIElN
SE8sIEkNCnRoaW5rIGl0IGNhbiBiZSBmaW5lIHRvIG9taXQgdGhlIEZpeGVzIHRhZy4gRWl0aGVy
IHdheSBpcyBmaW5lIHRvIG1lLg0KDQpUaGFua3MsDQpUaGluaA0KDQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnDQo+IC0tLQ0KPiB2MSAtPiB2MjogQWRkZWQgRml4ZXMgYW5kIENjIHRhZy4N
Cj4gdjIgLT4gdjM6IEFkZGVkIGVycm9yIGxvZw0KPiB2MyAtPiB2NDogUmF0ZSBsaW1pdCBlcnJv
ciBsb2cNCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNiArKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA4
OWE0ZGM4ZWJmOTQuLmI3NWI0YzVjYTdmYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IEBAIC00NTY0
LDYgKzQ1NjQsMTIgQEAgc3RhdGljIGlycXJldHVybl90IGR3YzNfY2hlY2tfZXZlbnRfYnVmKHN0
cnVjdCBkd2MzX2V2ZW50X2J1ZmZlciAqZXZ0KQ0KPiAgCWlmICghY291bnQpDQo+ICAJCXJldHVy
biBJUlFfTk9ORTsNCj4gIA0KPiArCWlmIChjb3VudCA+IGV2dC0+bGVuZ3RoKSB7DQo+ICsJCWRl
dl9lcnJfcmF0ZWxpbWl0ZWQoZHdjLT5kZXYsICJpbnZhbGlkIGNvdW50KCV1KSA+IGV2dC0+bGVu
Z3RoKCV1KVxuIiwNCj4gKwkJCWNvdW50LCBldnQtPmxlbmd0aCk7DQo+ICsJCXJldHVybiBJUlFf
Tk9ORTsNCj4gKwl9DQo+ICsNCj4gIAlldnQtPmNvdW50ID0gY291bnQ7DQo+ICAJZXZ0LT5mbGFn
cyB8PSBEV0MzX0VWRU5UX1BFTkRJTkc7DQo+ICANCj4gLS0gDQo+IDIuNDkuMA0KPiA=

