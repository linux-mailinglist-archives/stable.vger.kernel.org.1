Return-Path: <stable+bounces-139682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE065AA936D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7068189A6FC
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A122A24E4D2;
	Mon,  5 May 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="o2B4tWub";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YdcvYw7p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NMGhIcfD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA302046A6;
	Mon,  5 May 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448828; cv=fail; b=IiAHU5MpaNxKQt+LKvig/q28RsGWiutCV18gtOBGtKlyOZe3N+nCasFFv0X3KC/SjMuBRVWCEF5vOD/KVHnmOkUsii1fFOlWFngqnbUzwXNVjn8cayR80sKb2jSsefIyaJROojTBRSuQ8BPe0K79HstLWFa43X6ES2tmHD2Qk9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448828; c=relaxed/simple;
	bh=bLZ1HMS/x9eT4/cAquo3Q+/2b8+yc1yEm5GnXrG1IRo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WzUPigGUpcgFL+EZPZZHf9Um44QbNFe6swdJeOJ9FOvuuGCYlFOwhvx9taEb353UBh+yhzWA4+IIcAvLQx3Zv0Fj5dwdhOQ8u9LnSAnefzqIRtKDuvpiJoxOkh860idJqmybpn6u7oLMJMeXGBC4CaUTeA33z6PJJwoDKO8H42U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=o2B4tWub; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YdcvYw7p; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NMGhIcfD reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5458eSa1019001;
	Mon, 5 May 2025 04:48:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfptdkimsnps; bh=Ev97U4GHZ4xvmIr8nkD
	zHei1dmCbVZaJjwvSgb1epQE=; b=o2B4tWub7EHgeicA10zPIqurxWxXllxDcGo
	TfIlP689TSVoIHD+OhdYEbG8NH4/WLVKGvRx53mmSf6rXilMh9vD93p59PX06lTA
	8G1Fm2Iko9yeMfgb6kdft8AafyYvidzmFw0KRfjjZpITL+yFk8JbdstDqNXvoxiJ
	C2TEzo+TbdIAkrvjnKasZUtKdY9OLTP4o9jHkmIwJAbYEMsgdzKrOhxBn2yZ8m+4
	6eQvG5ueRByQbpn8p/BG2lqmoAokYVCEjheJq3kopTC2UqvKuyY9dpLe/ik0hzu8
	VItnm+TauEWuSbf7HM1+41Yna2ghymrApzr8Fl7471uLCaZbcNQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 46dhsdnfqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1746445688; bh=bLZ1HMS/x9eT4/cAquo3Q+/2b8+yc1yEm5GnXrG1IRo=;
	h=From:To:CC:Subject:Date:From;
	b=YdcvYw7pKQbPttv+S4ONtIJxsU+hffsNV+YQxE8e2okAZAFVIgo0QZweLfkJP0dH6
	 VVXvO17ukch4UMpcUJu5t5MBsy3fHNyJgli6sgcWLR9JYE9lU0rszsk7HvHInikytU
	 8EGLbpPfrQh/I0zkpD+MdZ7V2TC2w0BmW8Z6Q4D6qQWkQBGpC3HZXlP1FPV+hc4/3i
	 Lql/v3DNdShwQLFx2vY/mSQKGE0NgA7MzjWwwWFku8FRMgpzgvz2uQWAkB62HqHmqE
	 xP43cJkov2tgz9NBAfLH6ArfVEU2Rr9ek3O03sVtUgofkXoR9ziPW3aOrkSZ2ZeFO8
	 /AgW0q3cCxJ0g==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6BB1140105;
	Mon,  5 May 2025 11:48:08 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id BEEB8A0080;
	Mon,  5 May 2025 11:48:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NMGhIcfD;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 309B440087;
	Mon,  5 May 2025 11:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+NgvoOWYsIIcGOBvE/lbSrTBcWcNdhwEJELJiCE0yRfX3veebsUAer+DW5c39Xxu/r76PcCEy0n9ak3VezDPXzaNzXWIiPD1i82kpDK37z6N63a+OGvb3h1/25w+w7q4/OKOyUUvx7VJT9HRj/dmar+XdpRewFLrjQUSR9L7B22gWqL7TqvJ4tBok7gW71GtyL4ERy9sIpLLsBoKsfBSfH7fhUGAQi4nPysj6dMIuq5mnbqtVcmbKBCMvAQRDjaoZjjecuCd12Cz2frO/4U3s1C0lXwMdVK1UbT2CBYzkqD1OFuxReglooEWHXjsxA1gTQoovID8dzqQKZFDnf38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev97U4GHZ4xvmIr8nkDzHei1dmCbVZaJjwvSgb1epQE=;
 b=vvOgWjCVpcQkyGj+NBQeT3rC/4XN6ChXF7ImYA6WZZ+QXgFLPrc1QhJ464bv7uagqkPyZiDkp7GwkkaB/Fold2j6BOgJ9QM6HgGe6KhigHOnqLQCu/du1GcJOLQBmYbOeeC6L7vdlznKeeQ8R+PypaOZjCYWt1Azb8J5BXH0Ojrq3WCSo/eTygAJ9ghZ9KbAuu9pq6nrfGaALyyy5dPZaBb9dhzHwbTGO1Y2cTO64/gQGfxFI14+PIy7M/vvFuZJTX9we+t4ixpAH9Dd0WdYXVehFBKSxEAiddn+8bV/LjZH15q7kpjPCj7K3WOKFH7UXDMjjP+fZl64K2zvn4kAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev97U4GHZ4xvmIr8nkDzHei1dmCbVZaJjwvSgb1epQE=;
 b=NMGhIcfDPMrqoM/hZ6CkGFOYEbb4H9JB24ZYZXw3Ru60NQAUMjYbeQFU89h5dg60ixIDrnYUbr/gp77WEIUev1bpN4vof84vQiw6Pt+JsB8eDU6nH8HgrD06bBctrV2nYFboKAMPlR43nXmuHcBAqOxgAtkJK1YwAD25qT3r5Ac=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 11:48:02 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%6]) with mapi id 15.20.8699.012; Mon, 5 May 2025
 11:48:02 +0000
X-SNPS-Relay: synopsys.com
From: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: John Youn <John.Youn@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v 3] usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY
Thread-Topic: [PATCH v 3] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Thread-Index: AQHbvbOOfaGHhouyg0SbnVpFZZ8lAQ==
Date: Mon, 5 May 2025 11:48:02 +0000
Message-ID:
 <6242fbe1b81f16adeb96079448f0df92b6b8b664.1746442461.git.Minas.Harutyunyan@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: e37459e8-8f90-4080-46a4-08dd8bcab10f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZoRKYVkq6gh5eySaixd97CdmbhD502Eflyo0oe/Z84SPkIxOIb39ShFMFq?=
 =?iso-8859-1?Q?cM1hcMICZx2BF4SP5lIFyg+zV92MyRCHVON8X1NDI/TVdhr1rqYAsssMNw?=
 =?iso-8859-1?Q?iesOqxUuFe74IWp6U2BefkBjdWAEPfnPg0carIs6zCby40GBxSvsZmTJnK?=
 =?iso-8859-1?Q?m1gwpg5JQ1gSoXhkV8g0TMe3RnU607HPC1OozLfmvywbDXjs6SbzrDpaEa?=
 =?iso-8859-1?Q?HXkT2dvhcoD2D9mCgLM2ZRzsq02qf7gHT260M0cqv+AlW1SQ2cHO5qANM8?=
 =?iso-8859-1?Q?gGkpCnnDzLIytYc8bH+j2m+SyQkCaOAPREROrlEs03FJPCE2sEiXZ0mONh?=
 =?iso-8859-1?Q?92aSIEp5cjwQB8LBQz5FEdMjDV5dnf8FDmE6ehejUHOAK+okLzAxbaEKme?=
 =?iso-8859-1?Q?t9TaGmaQybjqWFP9UGM5XKIMjFz5ZtEXXZHRtkzDIGToRy5Ef8t2v/wP3P?=
 =?iso-8859-1?Q?r6NKNaVQDsSsTzmZ+5AU6SDSOW1pzbuUFLUYvTG5FzVQw/o8l033kcj5Dd?=
 =?iso-8859-1?Q?olPpQ/slxaPAOCot3USMbxzn2hxZ23txrMmkNg3pW4Cu4uW6kSIqzflkWL?=
 =?iso-8859-1?Q?1HdZV1GDMvzA/3tNvKJqcfBfMHFPbqlmrfH6MCdY5uRbihvAwCbQOZ3O4A?=
 =?iso-8859-1?Q?6hD9HhdD6pzVWavOShYk1amA/rzH+ikMILkxeFL/YX7MHCIshMgCqluaAE?=
 =?iso-8859-1?Q?M6BggIUg1+i5CW3wVRFrq/BBgSZraH4pV8QMUGsdEjGcJKhT/YJG+MkN3O?=
 =?iso-8859-1?Q?FC/fP2Pir+8ryZDDEsMHCyVolvXfHVKT9KgWhutiptV2gYYqZytXUUrWpI?=
 =?iso-8859-1?Q?D1G5i02SbFYuVhrwwBnhUy+ZNRJ7We2s31grMfI2W5j/OWCF6OxFrdQ3+r?=
 =?iso-8859-1?Q?suvIycnrRSUws5HGw6OiuDYoGTGkSDsW8joyAKqi+YAY/FR45bobBFdAJJ?=
 =?iso-8859-1?Q?zJTAzatj/QI5X9v7hCBDxvME7cP2eOPOu7FvpRlAOaKa+b+MEKjzqxgiT3?=
 =?iso-8859-1?Q?jpvqeiOw/mLBw4boJqOBEOFvpMqUBr7MKzigRVuPJUHOKd1/EN8qor4Kp+?=
 =?iso-8859-1?Q?H1ox3SOJWh4E+keAjvsaLnuFzHyNQpd6ix2fOWTZ5wYojyJgRCD7t6sGEz?=
 =?iso-8859-1?Q?1GOVnWTEDsLgWCuiaEuSdlIunj/qLiRztbGXzKLFEP2ioNBDkWZKPKOzna?=
 =?iso-8859-1?Q?Y+wq6LHTAAU5+0ZbYQmbE/l7z0+HgT1O6YM05/k0jR7RksvJNEvzTvTm9w?=
 =?iso-8859-1?Q?bPWsntn0+gm2DEcvo9V14/NY0vB9E1Fr9S5QZezEHgUv2xP6PCQi+NHnug?=
 =?iso-8859-1?Q?CU1O2Buq7DBO7iC0xGLW/I4u4iOKHpgIQASRwz0otjSvlU6uHqkYWqvHNj?=
 =?iso-8859-1?Q?S8cTC/b1b8E0yGP/onwzCKocUGnJsRTHTxPL/c1vmV//ywjBPahWlMSCbR?=
 =?iso-8859-1?Q?W+r86vGzHudjzUEvN8FWNMX+ztck+YVo9Mnk6jRf1wYy8alNIB39FGEVw5?=
 =?iso-8859-1?Q?eCRzJIBCLgfLveh2+TdWNkYP17SAW+KhS24Q7ukiEfU0SXR+UGPJdyv6eD?=
 =?iso-8859-1?Q?luSr+gA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8796.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Yu+oL62DShBpWPVdWEIv+zFW19FU58RgIyZtKfCT7dYp4asybLTcl/7exi?=
 =?iso-8859-1?Q?GLAzhlEk30hZucsQtL7gOVF1mhgsAbVpoVJe49i6Bc8eAd3Gcl9RfZcQW2?=
 =?iso-8859-1?Q?sdKG6jh+EYzw3qtNxIQRsbz7ppEWJEa3BeLgAqB5qVYUME0CwwPQO3MBQX?=
 =?iso-8859-1?Q?nec4N9uJYyNq/Q83GAVqPahgTF8aRUP11nGHsvBULODH0M3Kk9meloryHZ?=
 =?iso-8859-1?Q?isoSTm6m4qQXLzAUutnNR6X2C+HlvVSet1qiaeMwXUcIshm4idT4ViomkF?=
 =?iso-8859-1?Q?joM794fbKlhwmj/HzEaexqmU1JIKME0bUcFrGWDxo2sHXAPuP765wg6uAo?=
 =?iso-8859-1?Q?UOhxfPpWedF9KWfXg+qZmEMX7i5/syRVgkWDe8CteL4zcFf2iRozVN/9ST?=
 =?iso-8859-1?Q?gAhJmcqq8GJK24YGxFoUmGvjRgGIjxtv2KxZL0MBwMuY6zMA5DfPBD425I?=
 =?iso-8859-1?Q?2OTTDyCL4SoKvEZG5CS9Q8PwlJr9h73DdiEd2wW/WK7WUyG/yyFKuMpzZr?=
 =?iso-8859-1?Q?kYIDUAv8Mmsq94z59xbl7Y49gnIb01VduptlW9D+gtQ+JN9bMd48juHFHK?=
 =?iso-8859-1?Q?gLt3U5wWdg57uEm7eO8turNXr1fNiEjyO9DQovbF9MSsjp+fqTRBMX8CwP?=
 =?iso-8859-1?Q?d6jjtUh4GegQ5fQ9/u9/UcRISHdHpVb0sm3wOqhS4IICDXLuK80N9I8Dtn?=
 =?iso-8859-1?Q?FvuodbwoSm4oezYmQiJr9jhpugH/fMxGXNg6a1kKa9TwaInBIZYBbJcwRx?=
 =?iso-8859-1?Q?xczo+sC3/UIREHsp2wcB1ADtsFesJtMvI1TJHgGu04HSheOxeGFk8/DQ6z?=
 =?iso-8859-1?Q?jHFNXepHOQMcqnOB4GKDFGGig298l13PFjoqzPZJLLSW05XYpX25KCuxt/?=
 =?iso-8859-1?Q?tjTXrvke9hJkzPkk1CuLxKhqP2GX7tJ2YnPrEdM+ojTS+HEvAmKq5p7wm3?=
 =?iso-8859-1?Q?re4cr/le1EykBELnZ2ih/bmMvvxXhfZMj/AcIhBZ1qLq6nBkB28tkLNNPU?=
 =?iso-8859-1?Q?vRREDrZVRN9hOgbDytV4PMaPUcLWdQpOWthbyXofWUSEallGMUCH8pUgKM?=
 =?iso-8859-1?Q?Kde89bd6sFbq+2fqCDA2pyLgi2Xw4fjAt7si0LlW1COZuaFUfeMH92cTdC?=
 =?iso-8859-1?Q?gD/fOb7if6yCdirT8ZDYmA59qN73t3GYwhuBVRWOmz4Q0L5iW4WZXj6jrd?=
 =?iso-8859-1?Q?NMVj2Xl6szA9SRCxZTfUjcBr9Q10cyVeooaLr0nCkmul2wF8Ayex4psCJ9?=
 =?iso-8859-1?Q?W0mpCHX49GwnWe7b8eA/PSKteVT7LwLkMQJuslq+EQHd7MDXSucq77eZEV?=
 =?iso-8859-1?Q?RaXt8GEjpY+MejbEqK4KRUy9SBGs7o2JbDfnOnN3zjCAqZojApTcG6jz+Q?=
 =?iso-8859-1?Q?4ffm3ABrGsNuBqdtOrF5zPIavDEXGg1ukKWM24GN/KyB4Yl9mGI2opxDEX?=
 =?iso-8859-1?Q?rYl8mGFqhHMQI19l4SaenhfGrPvxWs1wqakzKxdgQCj/deJFuSXVIbn1ZE?=
 =?iso-8859-1?Q?P0+i0UKz8OAYIqCu7pnhJiQShef69nXcp0blNY+dT9f3plaCGXunal/P+5?=
 =?iso-8859-1?Q?N7G5NgXbDI3XSKpHwiXQSmeNVG6lNalaf2AKGC0U+EweUflgtCty3AjVDm?=
 =?iso-8859-1?Q?mky/kTeVSZKd+Q6+wd+Dg2k/XtMQAD0+RK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uB/XFOiwZ0I5HKR+9rv/CorwrxFZ6nsYG/D0IjALusrrJMPhHtQ4Q8/f8Poh+4HlmhuKFfdvw+xCGoz788cvs+vKXsiC/1hQ/BGlMj2zvpqawQkuIN2ODDczWfEG6TCknb57HFk2U1BsruFXUX3CO0GgpOvZNyedHQI65HUhlROiOqH6L2jgXPgvjdeXMNcuqIZILvD+Md8onjlXI8H/28u8WB19/KHVwzTAAS7aPwOc3qX+LUmlvKf2zDMTDRjVg1H43Q66NYXlrk84PEqo8j1r0HQY2DiKPLlbAszjU8H7vvPCE7y/5M3EtxQ6tKuCRIvuc0XkLVES22tLgyB4J2B3yFyE0aToTMX686QADmAEmIOZWgsiowiPezcC8Yc9ISCHUZD7p+c86a7LNy8cl9yxDj1eot+1FpyhAauryodkFf5641KN6bLVAoQrW17VW6skKzDcz+mTmzkFKIw81hJEXuWQ4hDTAFnBRx5+nLXzpcDETsvJJ+jRAY8yaN9IpAzs7pszirHaYulvgkh3VUf2NSwPn1ETCMrSJ3BdPOEHNTvbzp5umT5uLkKExTuZ8ScGWUvgANoDqJgvPUeMGrNBM1MqgMPHEIRMe9eQvv7D5q/tGlAZe0Dp2feKzDMMB40ItmnDAV1T0uI0LlEZvA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37459e8-8f90-4080-46a4-08dd8bcab10f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 11:48:02.6069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YIptieZ9Cp8N+3JIKPMhQIvSOqi7n/znDmFApETs2OoqOP7ED6nIjUqd0H8S11+mJpi/tZRzT+xDUHjTsrenQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
X-Proofpoint-ORIG-GUID: K8HTLk2R4PinJqtKyso4SCwUpuoEN8eF
X-Proofpoint-GUID: K8HTLk2R4PinJqtKyso4SCwUpuoEN8eF
X-Authority-Analysis: v=2.4 cv=EfnIQOmC c=1 sm=1 tr=0 ts=6818a579 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8
 a=1nkadCgX71emagpZ3AIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDExMiBTYWx0ZWRfXx11AL8ScWyvk
 V35SxLb03TwfJKvbPrblmiiFeOIttVcL6UtHosFySxx0uO3NVEQdNahx0P9xYcfmlb7Vw4Y+XQu
 /SGaiOPQq+zCmzm88INq0Uvsph75e7FP7wQtR92va/B6h2JIyl1wu8oZnDWp9D4eR91hbNYYXsS
 7MpK9ir+/HlwB15JE2vaZ9xlO05j0UtY2RjTmUNORBJBuScvScLznegxLPtQZFb7kmsFYffwvL9
 kXJidRuc9ZA3LWB6DQGv342hy/1qyEmhpYXsMl5oJtZNGKci/bNf2RBZCpf8z7/jw+5CbFvyqv5
 W5m2RGkwtqHF64l6VHyphtiYviY8VWIrw/RnHcoM0/RASM73RxHh7p6zmaUa4inF8zJSW4NTHp2
 QFZ4UiNfo8SuVL+sqT+C/Onp8lWgQrzJdpBj4Y7Gjd0v1j9sQqYPV/S/e6XTTX9gmSTbzAa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 mlxscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=747 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000 definitions=main-2505050112

For UTMI+ PHY, according to programming guide, first should be set
PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
Remote Wakeup, then host notices disconnect instead.
For ULPI PHY, above mentioned bits must be set in reversed order:
STOPPCLK then PMUACTV.

Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
Cc: stable@vger.kernel.org
Reported-by: Tomasz Mon <tomasz.mon@nordicsemi.no>
Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
---
 Changes in v3:
 - Rebased on top of 6.15-rc4
 Changes in v2:
 - Added Cc: stable@vger.kernel.org

 drivers/usb/dwc2/gadget.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 300ea4969f0c..b817002bdee0 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5383,20 +5383,33 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg=
 *hsotg)
        if (gusbcfg & GUSBCFG_ULPI_UTMI_SEL) {
                /* ULPI interface */
                gpwrdn |=3D GPWRDN_ULPI_LATCH_EN_DURING_HIB_ENTRY;
-       }
-       dwc2_writel(hsotg, gpwrdn, GPWRDN);
-       udelay(10);
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);

-       /* Suspend the Phy Clock */
-       pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
-       pcgcctl |=3D PCGCTL_STOPPCLK;
-       dwc2_writel(hsotg, pcgcctl, PCGCTL);
-       udelay(10);
+               pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+               pcgcctl |=3D PCGCTL_STOPPCLK;
+               dwc2_writel(hsotg, pcgcctl, PCGCTL);
+               udelay(10);

-       gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
-       gpwrdn |=3D GPWRDN_PMUACTV;
-       dwc2_writel(hsotg, gpwrdn, GPWRDN);
-       udelay(10);
+               gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+               gpwrdn |=3D GPWRDN_PMUACTV;
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+       } else {
+               /* UTMI+ Interface */
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+
+               gpwrdn =3D dwc2_readl(hsotg, GPWRDN);
+               gpwrdn |=3D GPWRDN_PMUACTV;
+               dwc2_writel(hsotg, gpwrdn, GPWRDN);
+               udelay(10);
+
+               pcgcctl =3D dwc2_readl(hsotg, PCGCTL);
+               pcgcctl |=3D PCGCTL_STOPPCLK;
+               dwc2_writel(hsotg, pcgcctl, PCGCTL);
+               udelay(10);
+       }

        /* Set flag to indicate that we are in hibernation */
        hsotg->hibernated =3D 1;

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
--
2.41.0

