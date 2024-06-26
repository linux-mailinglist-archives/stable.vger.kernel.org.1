Return-Path: <stable+bounces-55816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06F9175BB
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 03:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6421C21D0D
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 01:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D071BDEF;
	Wed, 26 Jun 2024 01:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BgNK2r35";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Qk4JNm7B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qJ4DMlCD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D219F4FB;
	Wed, 26 Jun 2024 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365849; cv=fail; b=LyTqjZwAYJ154SMBnvv3ItgOoBOvImN8Z+mxC+LngEiFL7niB0jBJastiRgRKpn3fhzhzNgGOH+IBSXIiC8UHNm/u9GSF1PIRSbs0WEkMwWhI+o8BXHP7lsHWJtS8N9AGsFHW5rwoBxd3SYCEmcYZ652fIgWveBLiTK5k7B2n2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365849; c=relaxed/simple;
	bh=kiCcO/TedUprv4RllMl2XwYzbSQHDjW3TmzOrFF5A00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V70fuhs860gWtK+y3RIWbuYIYqrNlJKklPQH+2RgUg2drzFYFL4lU1SGDKD3SbKYRw4uGVdsmevdBdk8U5bbGM82nVHhr0bPJSs9/vcVW+GgiLZLFbnBInQOmsglW6rjEo2Qlwt6cnfP2h0hGVlaPTDXFcJTJ/ChIRNrs3hJC5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BgNK2r35; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Qk4JNm7B; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qJ4DMlCD reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PMi3g9023512;
	Tue, 25 Jun 2024 18:37:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=kiCcO/TedUprv4RllMl2XwYzbSQHDjW3TmzOrFF5A00=; b=
	BgNK2r35P6QmMxglppUQ1j1B8X6NlATUPw0dv42Gb1KODM1bjQ//ubulMf9MIsm8
	+NkBUZYeh6y0dOONs0TBcRIXmNRNC0yRPitQe7qdn74sxpoqzy+rpx4j8t57YqFG
	/qT3itmFIugkr+cVFi2Y3veaemocrEQCLk4y40ATM97Hk9xRZYxafxqIxKnRglwx
	ZbdBJxM6XsnnD8UmQYf4pzfR2ZytsAoKfdnI6t2z7oKBAPiRk8vw6jDYUDYVXVU5
	tZ/MnjrLNHzAoF8iv571+AEukjakedWWn+nJFy/rlhUbE650vTUkXCYlVmGkJdoU
	hPh0xgq96sM6o5FGlNUn7w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3yww8cnwxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1719365838; bh=kiCcO/TedUprv4RllMl2XwYzbSQHDjW3TmzOrFF5A00=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Qk4JNm7B681YhGyTuqr1LQxP95Jii/XCATdc9QmLueHL8H+Lee4AecvNPoryWCLYl
	 HW5svFEFwJUzgWb+6l2Ze68dPOI/4dsmwxiPavHyKlbXXS+Xg1w7oEpugz80QXU4Pf
	 lyWshMJ2ekg5BC8uXPUdUZRggbHQzwzjXHtsNbe3rxBfOhyDfwpeBsQuXAz6NwQMnF
	 bv41BgmQYuQelAhViYuKhSSR1qo11v8/37/mxjx7Gj1XMTr0LYWHIR1n4+IW0rXcoa
	 fZV7oj9d204Z4uanS4YBi612rw6ORiXknwQ9Ew4NJRD6WfviiF8/dN2J9s1dCGjokS
	 +9/ukDb3LYm9w==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 67166403A2;
	Wed, 26 Jun 2024 01:37:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 40403A0074;
	Wed, 26 Jun 2024 01:37:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=qJ4DMlCD;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E060E40585;
	Wed, 26 Jun 2024 01:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNzzh003SmjaE1NXGp67deFdJaQOYRFenIxLdl6lxkUBoTlpcRLZH2ldLig/3a3kxHQdCBNycjIhoUiJnCnw3GO1ltU44emy5C/wbLP68m/rffz/hYOQTTrKPznwpgzdVEjKKPjo35IP8s/KWrtqS4XBplCiXdzL7tJJMR83NCRZri1L8mYTeRnSrVRTROL3bej+Eus1HddQrM2mtW5n6tsvccLG4Zt8blGwbQg6nnI4tCENb4IAEh1Gv8waYcjMY+WPOxv16RQdCPaKluNxFuDn/97//rax6BuJmZY5DB61O2ZBXefptsV+eNe8AbP9VrhO4axTXlaaH9iH8ag9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiCcO/TedUprv4RllMl2XwYzbSQHDjW3TmzOrFF5A00=;
 b=DBqfEy0NO/rJ96Uml0J7vUC+5o0dhLZ30scOvfOLbd8ep4yJfFa+wSNHUm8/brauW8GeAKJ4jepBXp+D04HZhAQKxZy8EUlb/9stOVhXYN4qSrOJsBXQ4AgxPV3tgvoC8MWpX7BaZUOTfPD18wN+P5C9/8E1sVGP2c3PDyHevWHC0SEGHNH0CkFp3NKMd9fiw9uNvv3DnsIuRfOxOT1oKnWgvcWOiN0B81yWCpU75sBkxJT2HdLLMGsWXCDKqWpiBLxfi3uueZeUOZcyH6Lm7FvzKz62ImOkvZAQ1pH6N/qLRRy0sNvnsWcIClbezssjpn8PXEfQ5SoNw85x/SQHJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiCcO/TedUprv4RllMl2XwYzbSQHDjW3TmzOrFF5A00=;
 b=qJ4DMlCDVkf35bDGYPrafVt7kEAkkOh9xzoEstxoLRoX0/maMlhbwnhM1bxyd2U8NWMCDgF2He/9aU+vp2FRfghKIJ7/081RfkTMlYdFLshq1o7W+diOrl3YwCIahGdPTEMc+0ypNC0WvUnZxMrnfwLEOOVWeBLIz6mNMHueJYQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Wed, 26 Jun
 2024 01:37:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 01:37:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: joswang <joswang1221@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: 
 AQHawj43Ri5O9FacdU6gpV1LQKb6abHQ5pwAgACMzwCAAD1DAIAABnyAgAAB9ACAAAinAIAADYmAgAEMJQCABZTtAIAA3dwA
Date: Wed, 26 Jun 2024 01:37:14 +0000
Message-ID: <20240626013710.dxqa6r4mjuc6on4w@synopsys.com>
References: <20240619114529.3441-1-joswang1221@gmail.com>
 <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
 <2024062151-professor-squeak-a4a7@gregkh>
 <20240621054239.mskjqbuhovydvmu4@synopsys.com>
 <2024062150-justify-skillet-e80e@gregkh>
 <20240621062036.2rhksldny7dzijv2@synopsys.com>
 <2024062126-whacky-employee-74a4@gregkh>
 <20240621230846.izl447eymxqxi5p2@synopsys.com>
 <CAMtoTm2UE31gcM7dGxvz_CbFoKotOJ1p7PeQwgBuTDE9nq7CJw@mail.gmail.com>
In-Reply-To: 
 <CAMtoTm2UE31gcM7dGxvz_CbFoKotOJ1p7PeQwgBuTDE9nq7CJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB8106:EE_
x-ms-office365-filtering-correlation-id: 8f76ab2d-0f0c-4417-ff23-08dc958081d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RHVTRXQ3SEl1T3dGS3lIS1F5c3BHUjdaVlhNTVVVMVpGOTdabnhqRmNFVFJu?=
 =?utf-8?B?Qno3a0xYNWRDazJ3VVZNU3pteXhTTyt5YTRaSFhsQWJabFFNNlhvT1RHVWc3?=
 =?utf-8?B?N1IrYmJnc2c1L0hndzVzSnV1SXBReTFCMGZBWThqbTk4ei9iSHJTbW1TV25x?=
 =?utf-8?B?M3hUVVhlZEYzc21kbDJ2bXpvbHUvaEZGdVRURENXVTQxSExaandHOVpVVDFZ?=
 =?utf-8?B?UU1QV2tHR2tGT0tQVmtqUTl6NldwV0tVT2RIaS9tL0NDanBIcVBRMWdDZW9a?=
 =?utf-8?B?cUlIV0dtM0FyVkNEVUNVOE1MVS83cmlFNzZHeEI5UDhrL3kzSzJtRmM4RkRr?=
 =?utf-8?B?b1lNZisxOGZwMjltSE9YandPaDhKMVZPbzg5eitTdnpFVS85dGpLMkt4TDlo?=
 =?utf-8?B?V1k4NCtrSXdBRnVOWWtmaldxK0VjSmRjeHRZbk1rZGhMWVNkdldrNEdHZ1FU?=
 =?utf-8?B?dDZOeFAzaHUvbEdMOTVlbTRMWm84U2dRWWhhZzVsL3llRlh3ZkhLTWF2a2J1?=
 =?utf-8?B?cUk4TkZDSHVHZGVRZU9nUnYySjJJOS9nMjJIdU8vem5XeXJ5NDlhclRKSGho?=
 =?utf-8?B?OGkySEFSZVI4aktkdlJaZDdDdmhUNXVzeVAxakhLVENXMnRlaFY1WHpjTFAz?=
 =?utf-8?B?bDR5QWU2OEZLbm5NRjlEK0lTSGg5Ri9DbHhCVlBNQVZ6SmQvU01GUlBTa1o4?=
 =?utf-8?B?QkZwRUZUOXV6Z0NtVWNiN1JFK1kweUJWaDZ6UmpYNzJXMlJaaXEwVVljUXZl?=
 =?utf-8?B?bVBSbFBBaSsyWmd1LzUyZnZqM1FZd1ZxenNlb1Iwd1dlQzBuRXYySDlmWlc2?=
 =?utf-8?B?emhlT1NYUkJVd2FoUVJnSWJ5K1pHWXRpQjRGL3grTUlmS3hteGZrbFdRUlVT?=
 =?utf-8?B?dTk4d290NWVDby9hT1lhVCtPSUZFT3VXM2dSSVBoZDVaM2ZZQzNjUlE0Nmdy?=
 =?utf-8?B?QjZBN3M0Wm02MHZSVWRGOC9LT08ycXR5Q2U0M25haW0wM0g2SlhBODA1ZE9F?=
 =?utf-8?B?cC93TWJLTEJYS2UrVnVtbmVHZ1FleXRWcWYwc3NyN0xHRXNsalVPV1l2WVNz?=
 =?utf-8?B?REg3VlZGWlJoeitXYXJBd0JjZzJBd096ZmZ5cUdkWGkveDIzaEtEamg5OStQ?=
 =?utf-8?B?TWtxL0Vhdi9mTjArb21rVXdzV2VzdWVyUEFGMGNyMTBadm5SSmJ0aG0vSnlw?=
 =?utf-8?B?WWwxYXlWVEpOL1JHUVE4NVFSaWV6cC8yOThZbFNhd2FhSEhzQjAzOE9ydi9m?=
 =?utf-8?B?ZlFzazk2Mi9PeXgyR2Z2aWViRlZxcWxXZUl5S2crQitzWnB2eFhXUkJqRXB2?=
 =?utf-8?B?ajFna1ZldkdGZVhycHdTRGdzNUpKTzB5YkxPQ1VUZktocjE5NmNIU1RIRG1y?=
 =?utf-8?B?RGVPM0x0OVZFUzhzTktXZHA3KzNBbVFmblVTd2x6cldXWUdXekFWMThmZlp6?=
 =?utf-8?B?cEoveFFLd3J5OUhvcWk1TWlVTU9MTmwvVE00MFNiOWowWnZMYzhWMnlRVHpD?=
 =?utf-8?B?YnhIUVpsS1JuZjhOWDBGRDBPQllCbGt3bzZMRjBxRGsyTWVtRGNLUjBPWTgr?=
 =?utf-8?B?TzlLODlVZ0tPOVB5UEh6R3c3SkRTY01hN1cvUXJWaHZtZ0tIVkh5VisxUWtU?=
 =?utf-8?B?bk9HMnUzTlFuOFpqODhpTGdmQ1NrOXIyL2ZRbFM1OGpydWZNMjBZckhrbVM4?=
 =?utf-8?B?WDVzcnRFV1NLdGxhTGIwQnU2QlJNTysvdWNWVzFaWkpYZjFMbkNFRFRPWjA5?=
 =?utf-8?B?V3F4aXIzZHRNdTdVMnhVWGY0S2ZhTnBjcFNqUkxzdW1xRXgyM2QwemxlaWlq?=
 =?utf-8?B?VFJqZ1g0ZlVvTDhFc0lRenE5VEEvOXVaZnZCUGJ0cU9BcHU5bGRQb25UZks3?=
 =?utf-8?B?dWFpMU44QTluaWFEOVB3YlpoaXUxUlVPMFRpSlRSMlYra0E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?LzhYWG55cWtqOCtsaXBPY2pDZElmcnZZdjIweHN5N2dtSkNrN1R4L2dwcDFZ?=
 =?utf-8?B?SW5QWGNuTmJkd244VUg4NHYxaVBwNTBtNWFuNEw5NGdOQmVSdmlIUUdVU3RB?=
 =?utf-8?B?NHVXV2wwVmNva3RJYjBpUDJ3VDNXWFpRUjRvZE8waGx1anlZM0xNQytpQWEv?=
 =?utf-8?B?d2h1ZnYrclByVFFVQnhMSW14UytiSnVzcXd2MkdBTGQxVXJCSHVjZFdnbDhM?=
 =?utf-8?B?Z1NiYmhFNm5yS2oxWkFQT0NhQ3ZIS2JBNWxCZUxlaXYrSHFxMXh1dGIrYmlU?=
 =?utf-8?B?SU13L2NraXNCeDVIV3A2eE45c1c3eFBvZWhlRE5wbGdsanl4Z2pwVXczb2lW?=
 =?utf-8?B?NEV3RDRaQVh1VEN0OGtwNFRYOWJJK1ZwcHJjeDdiWFZPdWh3cWhYOXVMdk96?=
 =?utf-8?B?SWF2TDA0WG9JNUV4ODZXUE1GYkp5ZE1xenF2a1NqSWsyNTF6S1U2VkF2Q3RB?=
 =?utf-8?B?UEx4UEM0bkhrRnFYUkh1QmpVazZ1cWRBdkFZTisxTFY1M3QrVnFmZS9HMlhS?=
 =?utf-8?B?R2tvOGI3aTZWd1dsVW5RcTZhc2gwanlLMS90YitRd1R2VkdXNUNEYnNVYWhi?=
 =?utf-8?B?K0swWS8yczhNTzJaZjhEUW05NVh2U01aT0kxYlFRQTUxc1U5bnRqbGRENUdB?=
 =?utf-8?B?aGxUcHIrNmFwVnRjOSthTzNSSXF5MnNka0Q0aktVbjFyV05hUGJlaXdTaTYx?=
 =?utf-8?B?WkhncTRZZjB6ZnBCdWdlZTFkTnJ0MzlWUkdKNmhKMTI4emdoT3NGcFI2UDhv?=
 =?utf-8?B?NnZzZmFnL002emR6L0NVeDBTelpqWGF6NEVWWWwrN3pTcWZETFRndzdjcFdp?=
 =?utf-8?B?dno1NHYrSzY4eHJ4UGVBWkN0T3plQ1NGb2V2eUJQY0ticFVFWHAySzdaR1pG?=
 =?utf-8?B?bS9ZWmk5MHM0Zkk2QXREZU9hUUlDRnZFa1NVeWRJSlJzaEd0b3k5U2F4NzlR?=
 =?utf-8?B?cmFXeGZxa0s1TzVWaVRHSjAraWdQc0QxSTNaQm5tVlU0M1hvMmhvYXlMQU5S?=
 =?utf-8?B?KzVmUUpZRGxlNXRqWVQ1ZG40WmdDeVpMaUlSNHZXVDJFc1pBRW9YaUExcmVi?=
 =?utf-8?B?czA3aGpSZ1JudmNwb1gveUlZTmVIRjVJZ0x0bUhFcFRLNnE1SG5JTVEyMXVn?=
 =?utf-8?B?L1BaWnU1VitGYVdlVzR3YklDWElzODJJeXp5VkwyT1lnUUJXT21xNzcrNStU?=
 =?utf-8?B?d21FcTNUODdWRnBnSlJxWGNHRExwMWNRa1dpVHJrU0psbVlOVGk0S2RNSDVV?=
 =?utf-8?B?Nk9uS1lyUnV4Ni9YaE0ybFV5aTRpZjJ5d3NPK24xZmczN3NVMWpjaExmOTlq?=
 =?utf-8?B?OTZjWm1kQitZaUpicUYvRTNISEM3REx6ZUZ1SElmRVhNNDdzbndnOHF4VWZZ?=
 =?utf-8?B?RHZ6OU1HdEpzMS9DeUo1VWNwQXF4Q1JKbGU0K2hoRGtZYnZ0Z1BoWGw4SWZT?=
 =?utf-8?B?SUhYenZvczQzdXY0dTMwd1pFL28xUlA1Y2VCRFM3MVJuMGJuSWVTM3BNdC9O?=
 =?utf-8?B?MXBwNUV6YjhRc3p0eGZEcU9IYmZlQ25lWDlzUFp1SFp6eFNob3FpYk9ZMGh4?=
 =?utf-8?B?K2s1Ymh5UHk3SGZQZE12NXdjbmRINlN6QkxKNDFMVzVlZXFXdkVlbnRyZFhF?=
 =?utf-8?B?QlhjNSt3YkxSU0pTSytQdzdqblZlVFRWVDAxdkJ1bUVEY2c4aGlQTG95d0Zw?=
 =?utf-8?B?WFJ6ZGoxOWZ1L2RYYWhTRTF5NEJrN1lCR3l2ZENnWEp2a0JRZUlycnBEWWJk?=
 =?utf-8?B?SE0xWjU1c0tBSjZJLzF6cTFNT0Y4R1lsUzFvbEoraXRrRUxhSml3ajlWVHdj?=
 =?utf-8?B?YXJDaXBBckhTS3RUamxIdWNZU1dPVFE3SmRRUXc5RXVRTnhjcGlEb2lsRDlp?=
 =?utf-8?B?cjJlTm1GUEtaRzN4QjJqd2tsb2JVYlhYUlc1YjJQamw2MzRQUUUzOG0rVGxN?=
 =?utf-8?B?LzQxeGhGbWNDbTdUS001OWNRUlpSOThtMm9wV3dvRmJVeC9ldnA3VTRNa1Zq?=
 =?utf-8?B?cUNyelJVamZkdHA5d3lTa3FoZXFqTis0SXpXYTNWd3lqMGptN2JFajk0ZE1r?=
 =?utf-8?B?SEJ1aHlpMjRWaHEvNWpCSnNrbDVJdkdER1E3QThqZWRzS1VSRENTOFV2Z2lC?=
 =?utf-8?Q?SbrAhy5ItrDipHO07Zv+WaRQF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <144EE71D028A9C49BB257F4A71E1C247@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Pn2e56ooEPv6y4Vrw0d7qNWDB0+96PIaPO1bNPiqfK/DtzoeAqMCiYcIpf2zUVrcL7NF40jTkw/MlLEc391r0i8OiqaxlbAMb7UtHm2rTdKkP0P5oAbPhkH5baO6f48jOv+/xA1vcKGv7LIoniyTeh8gpJHRTvZvXNwk980rzCUGdD7yJ0u0kJXU25S1WD8Vsi2+B3Q0UmIPSav51Vg6Evg/mBrTUAq/NyZUYKynrqlmj9exMjlLHews5d4+9WgBoUNsXFgcXedCJyHjtDc+wEee2zC67KQ7ie7Yk1ClS1wf7t8XJMRyQhsV6aqP5nUD+4S6AZJBkDX6yqbmrOgjKPeaEsjyxgWbX4mACSg1YFXA2Ntm2wyEs9059+LkuVeXthR04ZPdTjd7ATse+uyvBOH7C71hQ5VTYJEjOa4MDq1kdHfwjhykxGm0GKOvORc94tJM5DkHR82ie9PUKckPuFJqF5pL5FyQ4JVJNzX9ireIu5v9F3SSx4K7kJCuLzMV2zo3eIhYXk33tIHxskkCUDKOnYW2IZBHi/TtDhKj5r6tTcNZl6IxHfC0aKQlqSc0CJX7iys6IA0e65O/P+vVkC8S1E8G9pkqkx25J7oiAbsBQ2w3sWf9uvbY9kd6wp5afVVLL/KeOzAgXXdF85OsPg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f76ab2d-0f0c-4417-ff23-08dc958081d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 01:37:14.6019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NOFJZvgg0sbVbomuzWA5HTSPz0Qsk7W8nnNylQaXRy9ev/R/QaIPgDNQnQ2qESwTYISsvfQ8nicTkXZJJHihpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
X-Proofpoint-ORIG-GUID: FCKGeTttGtYUMkxOAr4HDwRmjypSkUKe
X-Proofpoint-GUID: FCKGeTttGtYUMkxOAr4HDwRmjypSkUKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_20,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=797 impostorscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260010

T24gVHVlLCBKdW4gMjUsIDIwMjQsIGpvc3dhbmcgd3JvdGU6DQo+IE9uIFNhdCwgSnVuIDIyLCAy
MDI0IGF0IDc6MDnigK9BTSBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gT2suIEkgbWF5IGhhdmUgbWlzdW5kZXJzdG9vZCB3aGF0IGNhbiBn
byBpbnRvIHJjMiBhbmQgYmV5b25kIHRoZW4uIElmIHdlDQo+ID4gZG9uJ3QgaGF2ZSB0byB3YWl0
IGZvciB0aGUgbmV4dCByYzEgZm9yIGl0IHRvIGJlIHBpY2tlZCB1cCBmb3Igc3RhYmxlLA0KPiA+
IHRoZW4gY2FuIHdlIGFkZCBpdCB0byAidXNiLWxpbnVzIiBicmFuY2g/DQo+ID4NCj4gPiBUaGVy
ZSB3b24ndCBiZSBhIEZpeGVzIHRhZywgYnV0IHdlIGNhbiBiYWNrcG9ydCBpdCB1cCB0byA1LjEw
Lng6DQo+ID4NCj4gPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNS4xMC54OiAxZTQz
Yzg2ZDogdXNiOiBkd2MzOiBjb3JlOiBBZGQgRFdDMzEgdmVyc2lvbiAyLjAwYSBjb250cm9sbGVy
DQo+ID4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIDUuMTAueA0KPiA+DQo+ID4gVGhp
cyBjYW4gZ28gYWZ0ZXIgdGhlIHZlcnNpb25pbmcgc2NoZW1lIGluIGR3YzMgaW4gdGhlIDUuMTAu
eCBsdHMuIEkgZGlkDQo+ID4gbm90IGNoZWNrIHdoYXQgb3RoZXIgZGVwZW5kZW5jaWVzIGFyZSBu
ZWVkZWQgaW4gYWRkaXRpb24gdG8gdGhlIGNoYW5nZQ0KPiA+IGFib3ZlLg0KPiA+DQo+ID4gVGhh
bmtzLA0KPiA+IFRoaW5oDQo+IA0KPiBJcyB0aGVyZSBhbnl0aGluZyBlbHNlIEkgbmVlZCB0byBt
b2RpZnkgZm9yIHRoaXMgcGF0Y2g/DQo+IA0KDQpIaSBHcmVnLA0KDQpXaWxsIGEgc2ltcGxlIHRh
ZyAiQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiIgc3VmZmljaWVudD8gT3Igd291bGQNCnlv
dSBwcmVmZXIgdXNpbmcgdGhlIHRhZ3MgYWJvdmU/DQoNCkZvciBlaXRoZXIgY2FzZToNCg0KQWNr
ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtz
LA0KVGhpbmg=

