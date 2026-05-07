Return-Path: <stable+bounces-244626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMBiJm7V/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:09:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 460774ED3D2
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB214302A6C8
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DF44E045;
	Thu,  7 May 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jgEc5w9Z"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799B327BFB;
	Thu,  7 May 2026 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=44.245.243.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177376; cv=fail; b=S+LFKXXhH6hpBCZN4/Hj3aB6PRxeYwlfmL0fGw6LKb5DzrNKeBcHVPoXfrnGCOcqHE7SqpYgan6ZhUkLVEbhIChGJKbh3I5Vh5cXmVYi7xYEHkx3IV8YtH4FL7m7aZRdXKOkUG4YBENuB9QrQTSygu1apBnYtIA5ZGjJnYHSHRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177376; c=relaxed/simple;
	bh=R578UJCnKdrVIN5iipNpotPSWXB/3rILaBAN8Q2aYbs=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njhJOKzdxURyCI/v68/ISsFAAOpm5NBEQMX4Dt0u2BIrlhPT9mtILeh+eranRLWZSCs6FXqlGCR//+Idp6nEgaPjgK6IfkuR12yl8h4W6DfZfuOnaWMuvOIogLHetRCUaGuGAOdlxvzAQwSsCKUkPng3wOQh8pLUV0Un9LLWZ8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jgEc5w9Z; arc=fail smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778177375; x=1809713375;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=R578UJCnKdrVIN5iipNpotPSWXB/3rILaBAN8Q2aYbs=;
  b=jgEc5w9ZNkB4qtVNvpI4UUei/w0QCWivF3kG+/qR6ER9TPTbnV4tJxCX
   vxkE20O6RCuaE52WTyxs5XLx6YOP8xnNYP7ldenogOx2Slc13X2mcFm4t
   Hu7px/+N6sPmtzaQyW2UQ3qscN1jlskFckSNmHrHjiBIvwvRWhGXdaH37
   qBCDTljWEck0PIctEhb8OQYDi3Kfy1MWvmqdpcpmhCco8RLtR/VQgSQO5
   wU4XHD5aabdI7xVRNyAYRq8x6QuyBmFAbi7l7ai8eQenTG5XzKcmZyBOu
   Rra/gX4BxR+9LfembfU1QzFMSdBlhJk4WQsXw+xXzmtE6jYcFpl2efYvd
   Q==;
X-CSE-ConnectionGUID: 6LuIPEgxTC2Vw0YWm13wCw==
X-CSE-MsgGUID: yT4wB25mR/ijw/HwP9/eMw==
X-IronPort-AV: E=Sophos;i="6.23,221,1770595200"; 
   d="scan'208";a="18630738"
Subject: RE: [PATCH net] net: ena: PHC: Check return code before setting timestamp
 output
Thread-Topic: [PATCH net] net: ena: PHC: Check return code before setting timestamp output
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 18:09:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:13984]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.42:2525] with esmtp (Farcaster)
 id 0103a352-40b3-4c35-9b10-616e220c3d7d; Thu, 7 May 2026 18:09:31 +0000 (UTC)
X-Farcaster-Flow-ID: 0103a352-40b3-4c35-9b10-616e220c3d7d
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 7 May 2026 18:09:31 +0000
Received: from EX19EXOUWC002.ant.amazon.com (10.250.64.172) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 7 May 2026 18:09:30 +0000
Received: from CO1PR08CU001.outbound.protection.outlook.com (10.250.64.206) by
 EX19EXOUWC002.ant.amazon.com (10.250.64.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Thu, 7 May 2026 18:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJTTHaBxnexGENSRmvKLTG4r+0L46omTxl8IwYoEa3qZxa0YrTG99V13DForA5PqCs0xyFIUVom0FzA5EsjILCRRP9xSU5xdsOMRXkGYemaPwMnoV7t/LbJN2lA8aakYAHO5NCSQNbWRB6iEKGC/XA36cj4KSsqaNLLOqC+r52Dl/nsBOi2KODjbj4jAfrODO1ZHSsd7n2mh8oSH7D8uNm4UHgJVAn6nIrALvqDopOY75hQSFPK5hWwcC+HkoaBf16Qa4dzsA6cNAJ0M8FqDGVtSWhUue5N+eLJnCt574ccfPszC5fXLDmOEjrVHjukqEUScf0fTZhSQMFZ36Fb+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R578UJCnKdrVIN5iipNpotPSWXB/3rILaBAN8Q2aYbs=;
 b=FnPlUvdxF/h92c+19z49US6Mgo8zAwXAdbZzZzwtffX2VsnDvzJ43EpmrkYzupbajAQWv5pkkrGZlzqonMmuURr9uZJNv5ydo5APs9ABmATW+RjcdHH5PuvYZVfygElxsJ5eLRLzfEyveiztHC6zSR/U9WgYi4R1zLBQCwO4Fv/WQIFL5bqjkSwWsV91ry4ikL+eTc3GZX9pMCgP7SbEHqAQ8bLsIUG9VnQqb3YlAGDKioMv9foFfwx5s3YoTINR9mdIfJJCDkrG8we0SYTEzJnPpNqAbbJEW0LpIxlOASdiUFOf16Lr/QnVuZYj+gRZ/qqQ1It0FFV/6+1CqHZWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4664.namprd18.prod.outlook.com (2603:10b6:806:1d7::5)
 by CH0PR18MB5481.namprd18.prod.outlook.com (2603:10b6:610:18b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 18:09:22 +0000
Received: from SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112]) by SA1PR18MB4664.namprd18.prod.outlook.com
 ([fe80::972c:f0e:7126:9112%6]) with mapi id 15.20.9846.016; Thu, 7 May 2026
 18:09:22 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Woodhouse
	<dwmw2@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Miroslav Lichvar
	<mlichvar@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Wen Gu
	<guwen@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "Sarna, Yuval" <ysarna@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Arinzon, David" <darinzon@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Thread-Index: AQHc3blxxl08Jw15aEuVMUz4ywsvgbYCX7mAgAB8D3A=
Date: Thu, 7 May 2026 18:09:03 +0000
Deferred-Delivery: Thu, 7 May 2026 18:08:54 +0000
Message-ID: <SA1PR18MB46642D5E1B1C507A7C282E90D93C2@SA1PR18MB4664.namprd18.prod.outlook.com>
References: <20260507003518.22554-1-akiyano@amazon.com>
 <6511ab18-250b-436a-a11c-f50e78334666@linux.dev>
In-Reply-To: <6511ab18-250b-436a-a11c-f50e78334666@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4664:EE_|CH0PR18MB5481:EE_
x-ms-office365-filtering-correlation-id: 7176f7ee-3007-469a-cd52-08deac63c3c8
x-ld-processed: 5280104a-472d-4538-9ccf-1e1d0efe8b1b,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|56012099003|18002099003|3023799003;
x-microsoft-antispam-message-info: cA8YkTAcrtKLigjYElpBSyuGtaS51Eh7nlK5hHj6yRKyZ5Q4AsvInD56yZ3UmDQca7BhaIxMNe1EKNfDYHIBNP87zBQ/fsGCUWFV+T+rt+LNnWG4Lv3D4v1NgGASsPlGarsJ9/2P+15zTixbObfwsSR6p0urp2if/YCNB3f1DKNY1S/3LXGLNZwqiJQsSr7Q5IOAO9YBsx25DccApgSCZImLHPKChGkELBM9IfE6b20nk8t9OU3kas9UGDUelC94hIpgt2BkO55FOPSk2qYA/aHbX9g4P9RvSkEDLB3KbKHDUd5W3puWMD6VPmDYXjLrG5A29OHqvSsKkWC3pnwOwZ+e0A+tWGhVgmVcrDynwyNMw5Xr1HNWacMAEtE0z/bs6mjbZR0kFZlPrj4fEDK2tBu6jO8Klmx9suNeWLtsuD26L00Z8z/TryS2RxfZAOEpuANaETXbQX+VRQ//on99966G4BYv3vZbYm66tLF88h6tS7fLbJqscm+cAXCoRk85Un0heruTYi3U8BJwMOFEFpOqOyjCtGqUfigD5cY0G1vSYm+opizMkL7uiyvxwcvp3T+MDvgwG4yg3dkyR9TyHILMG1rIvIbum9JcjO/mQIZPA7cHPb1oL1ZbeOvW7LlNl/+l2c+r93CsWS8WaDkarbGoYq6cdzkcq1y60N6h9rnt11txYf5kuX+h8qVv6GrY9jLnz9jVsVab+0EkWF16nAH+oVyyNlEX0RqrpEUfSiyIPNRXQkeG2sMZNKtdHrFe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4664.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG1xencySEtLRDF1VlZtWnZlSVlkVFJ0ajljWVJ3Um9IR0c1cFdkcFVZQVBi?=
 =?utf-8?B?ZXBHbzI3MlcvS2pIUHlEOXVKN3o4OTFWZHNkajFJdWU3djN6alMwVFV2VWlR?=
 =?utf-8?B?QnA1OTlBWHdnSXdmYlBBRVRVbm41VVF6VjFReTBSanRkTis1NFVFMVhzUEM1?=
 =?utf-8?B?bC8xMWsreTVrejRHeGtyS3l3d0IxQWluRFpvQ2ptaFhNVjB3L2szQWNvZURu?=
 =?utf-8?B?enlUWG5YSEE4NVp0SytzcDRsalRsdDhPK1R0NURSejZPRm5DeWljMlRRODZP?=
 =?utf-8?B?NWNCZXhMVWoxaCtHc3Y0T3hkaGZaRE5yV0laSXhZcDRrdStTNVROK0ZBeWtm?=
 =?utf-8?B?WVdIdVgydHhIL2Q5UFZENmhMWlpvT2hzR0RZQUZpT0lXSXBYd2dOaGJ1MS82?=
 =?utf-8?B?bzZVdFE5aHV6UlNPbkFkZG9selU2bzNUcDN4cDJIMWlNNy9sTUkxV25icHJx?=
 =?utf-8?B?QlJsN2pIUE9SVHRScWlOVnVlZlJnNEV3dDR2WlozbG1xUVNWTUZqR0hnMFpQ?=
 =?utf-8?B?cnNITDhWVUZYWnYxQ0VqdHRRTCtKL0lPa004VmhhKzNvZFdyUkp3cW40K0Ft?=
 =?utf-8?B?RnZpNkpRamxTVDZ5THlKazh5MVpwMTl6Q1FEaTdlS3BSMy81ckdqMkQ0ZkpS?=
 =?utf-8?B?WHNjdEllQUFSVTdaVHdZTXI0VThtWDgxY3pRVnlzbUI5RzVPMVVXTzNqUlIw?=
 =?utf-8?B?anFVVTdlTzM3YVNoT2VGNFpXb1phK29LZmxLNHFOS29yajNuQ3QrMGJLM2d0?=
 =?utf-8?B?d0gwbWJ2TzBTNEFLZ0xSMTQzTmxKVHJrYzQzaHpBbkIvK21KdmRIbVVMekhn?=
 =?utf-8?B?UDFrN1JoL0VGVzNGL0Z1QkU0N0JMc0ZUSi9QcDVJaDNhc1VZa0tnUXFkYjll?=
 =?utf-8?B?R0ZmMklXeTBIZm4wVk9rN3VFWGVDR2JIbUIxVzBQSUhvM2Y4MW5SdXgyK0c1?=
 =?utf-8?B?alFZM1JYbkVJM0czQUhpd1FKcFo4b3FpQmVNYzZsWlNma2hxOUprQ0tLK3Mz?=
 =?utf-8?B?cmU1ejZFeUxxLzRpNnRGc2xKazI1YkRGeStvaEdQc3oycW42U25KdWVyZGZp?=
 =?utf-8?B?ekl2TmhqMVhvTS9uMDVpOGQ0QmZHbXVhME42eEdHNkNldUIvS2J4akRKMFJE?=
 =?utf-8?B?RW9sc3FrSHo5aTdCblpwek91RFVDWDlqaGxjd1FWejYra0gyYmMrZDNiYS9i?=
 =?utf-8?B?Q1cySXVSRjduS2Z2a3VjSlpJbFNYRlJPc1lQdTh3RnFNOEhzZjl3Undxbkxp?=
 =?utf-8?B?b0ozTFBMN1VsTzhMdFltdTRGYm1WRHRVRW5FZFN0YXlqdXhjaUJCMi9QSFUz?=
 =?utf-8?B?KzRDMUFESk1ZQm1qeXI2bDVqcTJldDlPVmNMT1lTVitTdUx2akk0Ti9nRExK?=
 =?utf-8?B?ZVFFcVVVVWxndXpNSStYUkNuYVk4NnJ4SExLQ2hiTUpIUXlLaUNFSndmeVIx?=
 =?utf-8?B?VU90QnE4c3lydnVYaE1lcjdVSWFGeU5NL1krekJKTHNKbmIrcGVqUXZnT1ll?=
 =?utf-8?B?TG5vUjhENEhuTmtWYnRpckFyY2VVU3dZUG81dFl2NlVlTEo5NTM0cXdnYktF?=
 =?utf-8?B?bFFMOVg1MGtHQnpwbXlvcmE0VHJVak5IWEVQR1l2bDNZeVhwNm8vV3RVWE1K?=
 =?utf-8?B?USs1RFRhU1hkc2lqbVpDL1hOVWdVM0U3aGFwVld5QVcrdExYc3huSzIySFhI?=
 =?utf-8?B?QWxYNlRXMFhnWC94b2UxamZGRC9GRXJtNUhvN01RM3RRSGQwa1VUUXVWNHZF?=
 =?utf-8?B?aHZHa2xuT2F2VGUrcWpPaTZET1ZPWXIwbXJQK0tQbE5jelVGUGxGNFBKLzNI?=
 =?utf-8?B?cmhOb0JJQytiQUxyOEVKdExKN1RnTHJrSmJHcGxrUUlZVWFUOWs2UjBDeC9N?=
 =?utf-8?B?eW1seWVlYnBabEtXbnU0aHZsWldpc2VxRVpObEU0blR6dkQvVTVXdXRBQXA3?=
 =?utf-8?B?dzdZaTZsbjdxaFhpK3hjNmNFM0huM3lJV0R1Zmk3KzBFSEUraVlXSWZwd0t6?=
 =?utf-8?B?alNsNngyczRhUmRVVDN2QnhiUmRWQVJqbzIybHpubHpjb1hIM3RnUi9zbXVO?=
 =?utf-8?B?YXlXTmdkNSszRFBra0ozUW1HQkxMemQ5aEQvTUg4Und5WjZ5bzlrYnZzVENw?=
 =?utf-8?B?NWptaW05UUhiK3hUVVlxVUg3S0h0aEw1aTQ0clFMeVA3TjF4NVhhMEVDQTdi?=
 =?utf-8?B?S1o1eG5XRXlOdkRLUHBrTEQzREUvRUFSei9hLzVxLzFaNjJ4Y2VId1JOaVNR?=
 =?utf-8?B?VHN0TG55WWttNi9sTjNJaUEvQ2JBcmZyU2RYRzF3ajNEcmZZRFVab0crM05E?=
 =?utf-8?B?WDhrV3g5aVVqeVJ6TmJDeUhQRzFjRDRtTEsyUTFjQUV6eE91RDJQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OhVrP4EtbkJO2/mSLxMGiTPUSdFnzr12JBdUOROlG2G0W7v8becD0u7KlvjMBI5y5ZVUSIXMHV84yRU/MZd6S95DvawaXbTfVjktl/sQ4GMwpJr+/68AF/As+nTzk1Bw/hXc1g9FukJEgXJump500RQbAQTtFn5g4/d1lYj9cNgL1LrB8OLfXdkhdAvehmq4FZKwZJkLwISnGQCibHxxrHvjldzXTZI6TqhpQycmQyUoTsyccy9qr7qb2vZluYdWmDzw/gNkRjfLd4nu1J1uE5nntbh0YETHVgQjd0SyfG+AQxVVaz5ieON8t/KzpMEI6MJxEn5LxoxuAZ6fVM95DQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4664.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7176f7ee-3007-469a-cd52-08deac63c3c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 18:09:21.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6zfLpDDynDJhWyvQAnwg4jssYGAGajhWqS3NxEjxmx6lMyhV3g2cKt3akhM9+FTXlHuInht1LzBbb/0uIylwtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5481
X-OriginatorOrg: amazon.com
X-Rspamd-Queue-Id: 460774ED3D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.56 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244626-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.co.uk,amazon.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZhZGltIEZlZG9yZW5rbyA8
dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj4NCj4gU2VudDogVGh1cnNkYXksIE1heSA3LCAyMDI2
IDM6MzggQU0NCj4gU3ViamVjdDogUkU6IFtFWFRFUk5BTF0gW1BBVENIIG5ldF0gbmV0OiBlbmE6
IFBIQzogQ2hlY2sgcmV0dXJuIGNvZGUgYmVmb3JlDQo+IHNldHRpbmcgdGltZXN0YW1wIG91dHB1
dA0KPiAuLi4NCj4gSnVzdCBhbiBvYnNlcnZhdGlvbiB3aGlsZSByZXZpZXdpbmcgLSB0aGUgaWRl
YSBvZiB0YWtpbmcgMiBzcGlubG9ja3Mgd2hpbGUNCj4gcmVhZGluZyB0aW1lc3RhbXAgZG9lc24n
dCBsb29rIGdyZWF0IGFuZCBjYW4gcG90ZW50aWFsbHkgYmUgQ1BVLWV4cGVuc2l2ZS4NCj4gUGxl
YXNlLCBjb25zaWRlciByZWZhY3RvcmluZyBpbnRvIFJDVS1zdHlsZS4uLg0KDQpOb3RlZCwgdGhh
bmtzIGZvciB0aGUgcmV2aWV3LiBXZSdsbCBldmFsdWF0ZSB3aGV0aGVyIGFuIFJDVS1iYXNlZCBh
cHByb2FjaCBpcyBhcHByb3ByaWF0ZSBoZXJlLg0KDQpBcnRodXINCg==

