Return-Path: <stable+bounces-39974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80148A602B
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 03:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175671C20A6D
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 01:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A34C7E;
	Tue, 16 Apr 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bPSmf4ay";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NsUwe09s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WwfWmvh2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6E5223;
	Tue, 16 Apr 2024 01:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713230597; cv=fail; b=ddHYqM48brqwGilRFrIw4mNP6+wUMv0vEGvinCKZhK0uE7bBinOEzEs9gc/zCKv6PkGB5K7xjF4EKgj4rCWUGztzXu07A30j5b2b5ZyAIDYycQVcl7j8ispyxy53JuAbmnIVrbJvug1a2ZOWpLcE6OFu1XeXgj4IkrJo7jl4ytk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713230597; c=relaxed/simple;
	bh=TQf/crGpcrRjR1+mTnR4w64X8tYAIzLhe4qUMIb15vs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SDYUXXFfKXRHZhKEVGkUv6NnX75AfEV8c4sbiLy+AM6508zR44+MLwqkkoGBifa5bO7hk/y3pJ4pbw6z+Pio7vqbAAIr0xrAplq9fmCmcuyBKcExNUPV8IH18vIj3ol4ksuknD3RPqWSnSgCxe4rwco3nZVbZU3msmnMsdn+j0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bPSmf4ay; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NsUwe09s; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WwfWmvh2 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FKXYtc016624;
	Mon, 15 Apr 2024 18:23:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pfptdkimsnps; bh=Piu0
	alu9o36IJPHdea0pDP06ni2mRAhi7g7r9SnER5I=; b=bPSmf4ayCXBaao+NKxGp
	6uUfm2n7dFysVoi4DS23X8ZN6s0qXRKoPFklFddWp7NCUU8zNmNA+cZXjHzrfG6M
	RQv37z0qbX33JebWF0/S5tjJoD7r5nXimKLxhlORqo2EqOL2bcLZnyL7RqfXcV81
	/psLkNvdNuubBIHBv+WNB/mTNbxYvkJXGS/DTBh646Bi54iKZ581l906oIm6HhOx
	R5RoPfUkV7YqC+XPl/ELTcYHqHHyZ8il4sBKMeXjNnNHEkimyu3ZHDL2VgumGsEs
	97jOeFet7mbARARag/LuZMAv00YT4JkuXK8NSeMsC4SGRGf4PxePkb4XR1au2sWm
	mQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xh7h6t240-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713230591; bh=TQf/crGpcrRjR1+mTnR4w64X8tYAIzLhe4qUMIb15vs=;
	h=From:To:CC:Subject:Date:From;
	b=NsUwe09sWjzNJBzikbeGrFL2pAeifks7bu8dfvyFV89xHOwxqS5gdCAZYRZg3vvM6
	 NhF2o+aVKdyCerasutMPYLJhXyhuE1fiXXvVf811demsmC2/cHW/n4DZM8mtH4+5Gs
	 q051fXKuylBwQrRSanU03jdZJWRpXKE3jdLqQCefbzMDGYmivsLGWSP9PGHAKmB8Wq
	 yEr2+m2Q4ds+SLLHpenDjUTutOAB1AI6l9Buk90Fs+GOZaVZIYo9ewLOUP6Ds2VIII
	 EDWmq+dUAQ617rhYmSvY4ssvLBDD6rijeZbR0JGhA5tNXZ/qD3rJxlZH9moO0aBxhp
	 2H7t+kwzx1NNw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BBEC440540;
	Tue, 16 Apr 2024 01:23:11 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9EB85A00A0;
	Tue, 16 Apr 2024 01:23:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=WwfWmvh2;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E7B7A40407;
	Tue, 16 Apr 2024 01:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1udry/eZkW7m89C5IVW/klEjcxew3qpEZbeOkret2p78runVuTZBOU/15Vy54y+ZCO3OJI951qbXKUfwsRjDv+MqH9dB5aVer8N9eNnjmQwZjcNUYoqOvVZUrJDGkAMFmBNc0bzuRhI2sJjVmxdvnX9mvgT/0cg2RJeQauyoaLwTK7Re1dT0XOs6EsPqeHNnmBvyJDh7HS7dB8rURnnQ50+xkoRPoKn7fRO/pBzClhJCjxoJ0qj1pP7fXusXrww1+rkPcZDAziODLe2QOUeQJ+fapmtkcD6xyM/BUCKfgVB3WD/7aZtFOuu6gkHrvE5bTfrmw/gRmnQl47gy9DPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Piu0alu9o36IJPHdea0pDP06ni2mRAhi7g7r9SnER5I=;
 b=FdRNFSaKk/l/0RHp0QZvcHjRBolU9fKoGRr3SjMDaUdNb2sPOD95JaKBYTOdo1sjQE78ZNaX8QZ6ix0bioEWUH25oSppQZPiomCD4vw5Cdi3K4dXdtDKYR/LbBCWOCg3I5FKJuqJjKbXGf+CoMpZmNVj79fjRz22uEmMWrT+asaOvPXem6mGe018lFiDJn9eTnW+GA6MSTqCvHhV1CN532O7eqlfRfLUxFhCmSc3vd6u7hzpBgdKRETMF2N7fE20nioIiAoAHi5+9xr15zYyVY/uxLLFQpX01bgmza0lxw8YjUlNaRIn3PzdHNzImRKu+0TatLiAcWaDcQ05LAhOEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Piu0alu9o36IJPHdea0pDP06ni2mRAhi7g7r9SnER5I=;
 b=WwfWmvh28XW18/o8i69oUWQnWZbavfhbbe8u2qm1a+hoE7OwFks432LjcvkD4HP44ZsVlo8N7uLWlik++ioU1VWPPQUELMNYvt+ZdGTkZkmi+lcck7xyYp3JhuoykBnEJW339uypIHoj4snUJNsF+W8H3Xey0eG/gihsJPFxahw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 01:23:07 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 01:23:07 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
Thread-Topic: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
Thread-Index: AQHaj5yjebQdC8LUukqoOAQrmzd1BA==
Date: Tue, 16 Apr 2024 01:23:07 +0000
Message-ID: 
 <00122b7cc5be06abef461776e7cc9f5ebc8bc1cb.1713229786.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB7622:EE_
x-ms-office365-filtering-correlation-id: 9f21c6eb-30c7-4be4-0513-08dc5db3c588
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AAliOjenHMBrtsiZz8BiXyJX1cw1hqvsREf1yh+FyssJqkZx1/ySuE2JB/sjY8LNwoFn49nLw4EErd5IkDN351JqwhTr2JVhOTxFcFkFkjeivMSZxR4Y2a9ofV/nk3rzqQOAG9Jj6ggov7HFAeBmBpFGwVzDavU3aVKE6aQ9R32DKllDxzjYSJZ3yoFDSHo3yd1vyFFn1KLv5Q/psB1jnQuknA51a3jzMRVZsRyuZbIIdslFTep983bDTdPezfcCV2/ea+Lz6cV3DU5UNJz01DBQmRSs2lQP7InTjQzGzwDFdVjFGf/Rre5eZkOW1WVf5j0eq+C+PGruBxfwCWaMVnRBO8aLzXOqzcVWYU7AbnCHNzHx9RF6wrChnDGC/igsqqrvOq/+NMSMpW6/dGjhgQhCv9vhfXrCFCzqhypfCphbW1Y8MuI+P5ALxt6Gq2FESwS/0MDwjhjDQdp75qg3dnQsoadGqqlCYs9gOWr/vmzhccbttTBth1GDvHg74/8AeSFQaJN5rwNXnZSQ7dLT2p3EteW39l8QQu2ppPtXYCDJkG6Nv6cN7L9kOodxbpqF8vWMb/eh/Hna5trceRvd1jWP1kSP8Mjn6MiZaa56YUjFdre1tGxUJmULO+c4xtfH1d0aX8FmVaQV2Yy6x7kuxbWX1w/bhE32z/Apq2jh2maArI11f0F5Sk+tmUPHBTfvJiE7A7WxWybag4XnKArdGMGipIDmdqDEyHhRMjtxPVo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?vAPnqVR55ly4IFQdjgUy1dvVW8pkJkt1g5VZh27m0f6/TwyYDqhy4sa7Tl?=
 =?iso-8859-1?Q?a2Vk/FFmd/J/PCi7u8Weqle+6l1XnD7EUBmnSAuR/anFYs1xk4JXk5rtjk?=
 =?iso-8859-1?Q?8eFW5eM5FJhx0nfC0c9Ne5NoXBzRWlEmDpCC0sFdGsUCv/gz+lj1HkkUIc?=
 =?iso-8859-1?Q?bRBnNSyEdgj4fzRoV841Y9WDuf+rnI9yBmpBpVRaoT76l6ULnOtayRVQyR?=
 =?iso-8859-1?Q?pFNqh2rRQ55F62HQcx3t7dCB+SZpLUm6wQMv2y888ZD2O6JP+NfRcLCYP+?=
 =?iso-8859-1?Q?pLTpizBG92s7cTWOTGw+UUNoYO5RFLioHXLzb942DMqd+UxnsGAjQ+Ygyf?=
 =?iso-8859-1?Q?MRsjLeC2QokQehBd7iClhamcWBkblYsCEzgdGtxx9e9PCdboX4HTCs8mus?=
 =?iso-8859-1?Q?S0f2Cfzfvc4Rh1/mY53+IE+9vP88buZKLGtzekgptXHqu08irpJJ759Rid?=
 =?iso-8859-1?Q?+zk8YBPe4ei9CCKBSnPHPaR5HInmM17MqAefiXDD7p9C3i9NIddvrmNm9k?=
 =?iso-8859-1?Q?6GZZt3atIL5m83dxNUCXSwuWqgESugX2u0D9xXGHdsQ11XzIfIYCIlD+yU?=
 =?iso-8859-1?Q?NMfrDNC+YbLambD045GcBzH9rgo91hiOlj1yrAJBkDWE3RQ+E3RjPcQpfM?=
 =?iso-8859-1?Q?EfFnc88gO3jvEhe3nG5DmaPZPjDy61v7VpENMsOphfzTLj7VdYuVOMBG77?=
 =?iso-8859-1?Q?/6PCzdB+v10z5juzCoDFhKQHrL8ES9agi+xI+gSMKll8IKyYdlSkdI1Egn?=
 =?iso-8859-1?Q?cNFRJiCELjmlphMlOTF5a62c8NFI2+hvgz0hauZHapbb9OV97ZCfVUP4ah?=
 =?iso-8859-1?Q?LCo9lYAg4HiF8PoopwtcizF3x+/sV0lB00aX/4E475Ch5i9NJTKSAld4jS?=
 =?iso-8859-1?Q?rpS8RVx8/sHCeob8CpRGo6bqLA4yRU4cGQ0oOFwcrAh3g11yGSRbaeb2+/?=
 =?iso-8859-1?Q?g+23O+I+J8kGPIYL2+ma6udcC3aO+L63kgA3cIDAbyfGuVpIBYm3F93Chr?=
 =?iso-8859-1?Q?4IPPuZXfomDRvaCeN+/E7n6y04eN0SlixiBhLPWbPVXQNd1VIUyYyDZu2i?=
 =?iso-8859-1?Q?rYZrXVlFsr4qoYqNIkVLemOqbKNgl7oSSmF/rFKlGi9udQOzxnOWPKTA06?=
 =?iso-8859-1?Q?qPAMWdY6xnWsOhvI1Ma/TJIY7ewlNPmAgj6DyedosNvAM3kRbZ6HhFjI9O?=
 =?iso-8859-1?Q?ad/ddMR17QOzI0H3hgHhor90PTNUP4P0GIB+dos4WhQAq7tYDM1wdZn6cH?=
 =?iso-8859-1?Q?duCBUetd+zMK2q0hNyxk5DfI3bj3qYUZ7TOwtLuTmgK0+kTfH/lx4KcOEf?=
 =?iso-8859-1?Q?AH5KmqvLeLFHX0/yCdP4ib6nXca5XDxpYiNjsfR55pkoJLrxM1DV0JUqae?=
 =?iso-8859-1?Q?t7OrWw70+0AlSAFrHe1mN6YK0GkEqHif539NYgAcJjIAgjygB9MLbmlUtv?=
 =?iso-8859-1?Q?dpQs9deDlrNsRqe88ELVHbkQCkL3t+QFcQB9P4mkflsw8YwkQV2xrrqcLS?=
 =?iso-8859-1?Q?o5uyPArrDJw710ECJYahNDPwiaudbszhapEDQme86gbmKXmIOR1ZRPyzp4?=
 =?iso-8859-1?Q?jO661RODND/OiM0dLOlp5TIgVvMy9LEWRS7gtmWgnd3OtA/n4yQey5Z+h3?=
 =?iso-8859-1?Q?/AMEBUrGvpJvk8lgCioPuIQXsHpL+Z22zS5va+nI41p0nMjcJXZYuACg?=
 =?iso-8859-1?Q?=3D=3D?=
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
	/hPekXBzSUJC5/FLYOTKuHOg9aQsl9IbQOPaVBM+oUSLMOytPgr3Pj97WMRFmOMRtBTnZZilzKYfuI3Lw58c8JXwESZDwfu8EGD8phPU209/HSfMEVMbHKjo4E515AinVHjxKc9Ln6OUxH3LA6BfkEP/a1kkzBMSMaBZGwVbb9YcNVnkmsqggh3kNO0Wuw8cK+BFk3sHoFfpOKzFDqF04VqeCbUt9ZPEZ8HZp05/pf7yK54fxexMWeQp1ytou7Upd5SITPgu05koR3V4dQDYW9//CCz1xK+2GUwAUeXe3JLZgsLysSvnwNpuHnl5XI4NHBeg9o63xUS4AT0iD+aUf8O3bNMQaPWAXQnkzUxIbrg0brtaMKKOxOG67pHjjDMrgT7wRbaPBsTbMVQRaKHqylZ1gNNg2AeIwF1mfz8xOQYxgQtDesDlYgea/dvVlhXlMJX1ojPEmvMuLIilkJ98AtOq0nbFLPtu+7MEKcKngqP1E3TWgGGiabo+kKwAbzxBUEvPgjGrTwqgyWFu6bQr5T8mrTcjevQb7kl9M+2sfIC2orkcOnwUiLheg5lkyZQGyr7ylz77RQG04q3Zzn1Vh54SioBeSVM2Go/RKDYNc7W/UGU/Fq9oPxYdKZ6TFb1UZe8mRziB0NlKIFSrlNEVnw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f21c6eb-30c7-4be4-0513-08dc5db3c588
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 01:23:07.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epsCTZb19xRG8WJ1e38hBOONbDObnPSPrfb5K3/StleTGdIO4fmzSKDyxPf2zxqSUR+Tx2pgSunDFPR8ZDwiUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
X-Proofpoint-GUID: pCyskl-qkiRN1ivi46Po8_fUWMgmi2nW
X-Proofpoint-ORIG-GUID: pCyskl-qkiRN1ivi46Po8_fUWMgmi2nW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_20,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160007

The DWC3_EP_RESOURCE_ALLOCATED flag ensures that the resource of an
endpoint is only assigned once. Unless the endpoint is reset, don't
clear this flag. Otherwise we may set endpoint resource again, which
prevents the driver from initiate transfer after handling a STALL or
endpoint halt to the control endpoint.

Cc: stable@vger.kernel.org
Fixes: b311048c174d ("usb: dwc3: gadget: Rewrite endpoint allocation flow")
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/ep0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 72bb722da2f2..d96ffbe52039 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -226,7 +226,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
=20
 	/* reinitialize physical ep1 */
 	dep =3D dwc->eps[1];
-	dep->flags =3D DWC3_EP_ENABLED;
+	dep->flags &=3D DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |=3D DWC3_EP_ENABLED;
=20
 	/* stall is always issued on EP0 */
 	dep =3D dwc->eps[0];

base-commit: c281d18dda402a2d180b921eebc7fe22b76699cf
--=20
2.28.0

