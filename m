Return-Path: <stable+bounces-256456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN8IOubgGGoJoggAu9opvQ
	(envelope-from <stable+bounces-256456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:42:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 952BD5FBBEC
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 02:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC133007E28
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 00:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CED34BA5B;
	Fri, 29 May 2026 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cu4ySRQF"
X-Original-To: stable@vger.kernel.org
Received: from iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com [50.16.246.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08EBC2EA;
	Fri, 29 May 2026 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=50.16.246.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780015296; cv=fail; b=UD2BfBO0OTqtPkWswalHSu7/eWRx1fRKqxpdnZbuYkpzR28BCcq2JjxWfgjXKcWH6qcEhUcvp2PgSXzg7nRm//p+HoS2BJ9RwxlU3UCujEIZyXk5qDXiU9hWOOWZ7vjwVOvCd7hdWC8i72xILqh9wWxqRlyTYqCZGcjLkoomlik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780015296; c=relaxed/simple;
	bh=Gg04BNdVu70AunOA8CDR+++izIAeTphoW9/ws/wbeP0=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWbnJpooMHJxziJNn0ptV6rWCllOo+CFIOt0kK4uGAA2yPgrEVxzINTixCGye1SKz30O5mxYlfP8srVOGsT1veFfLTjaFkWnwDBsJJQWDlWQcGLN4fJuTOWefrGqBb7GHmzzDaCGfhGmIqrHz6Z4YlzOFV66KV6IcRZs/QbzAb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cu4ySRQF; arc=fail smtp.client-ip=50.16.246.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780015294; x=1811551294;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=Gg04BNdVu70AunOA8CDR+++izIAeTphoW9/ws/wbeP0=;
  b=Cu4ySRQFOnL35rjgMuqh/OJAtI8HmEaM4YaY8d1M/C8oWmHX1lkq6++z
   QqqXtEBYZAOTmvInRqwaz4J9TFXlSk1JMY1VLWro7FBbSNeEeU5fs0c60
   hZvYIC3/l7RSm2lTSiq8wL4x8kpGaEoXisUFh5SDRaHvRljKnrhzwBFDh
   /AE7gkIsVITzvZjFz3zNB7WEsEfvDpzrq9a/gX+z+3wmSUmDvoBe+5exK
   AN/PssTuQhP3PHEZd9amLXmPA7Tp6r+7YhIdl70E/hmYXXRjsisuTu+o9
   uNQQl72S2eJBlEmKBdQE+WysX1WHXB76SGPU92pk8j/uXjrxP4sH2O7Mf
   w==;
X-CSE-ConnectionGUID: NT+ba504RX6YZPm9eqMARg==
X-CSE-MsgGUID: Dr7Wtmp2SW6pRdrxcj1oRA==
X-IronPort-AV: E=Sophos;i="6.24,174,1774310400"; 
   d="scan'208";a="19201061"
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing
 sockets with pending send data
Thread-Topic: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing sockets
 with pending send data
Received: from ip-10-4-22-235.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.22.235])
  by internal-iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 00:41:33 +0000
Received: from EX19MTAUEA002.ant.amazon.com [52.94.133.129:12549]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.4.242:2525] with esmtp (Farcaster)
 id 7803ee9a-3fb1-4956-aa11-2e35c92b8202; Fri, 29 May 2026 00:41:33 +0000 (UTC)
X-Farcaster-Flow-ID: 7803ee9a-3fb1-4956-aa11-2e35c92b8202
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 29 May 2026 00:41:33 +0000
Received: from EX19EXOUEB001.ant.amazon.com (10.252.135.46) by
 EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 29 May 2026 00:41:32 +0000
Received: from DS2PR08CU001.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEB001.ant.amazon.com (10.252.135.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Fri, 29 May 2026 00:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHzJJpLC1wESxPIoQg/skGIRVKrIPcCzB8H/iGiDG+NgrekFjf61mYXEMiHMhVh64x3Iz7BTsu4VsCbwDtU93GklM7YtgDtIznSD6OhJs9GUNYX13KiwhgU2UBeegwRZJ/nvm0PGMbofyxQtrNF0aoHQFr0qtCqdtLmc/fdzaS4vkEinkl6G0rgtYmwa0nVP4XMVR8xt4/1HeDoKFbBxZusA5zjDHeIwvONow//WrPA94bFaVnIBUFHtc2MksVHep7LxknIEqrk1d/b+KSOGgE/8+7ejy8hQ8DNoPFsZ+JWicw/5NsQvjTsBFjWHaY57OUmfogPGgGjzDjPIHcHNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg04BNdVu70AunOA8CDR+++izIAeTphoW9/ws/wbeP0=;
 b=vSg0k62D7/tdJWPZp00BDyPBTx46esCiP/dXXmRybr37AKUFXUhSsXHX1/+3RdMReB6ixFEaFTmTahh1Na+XZrBUAwOYSxzwCeQVpwadhb/ey5R7osMlZegYD8S2zWBirErdIO5dfcNNzZFsOLzkeJxK7/YatOHgyODud4AQzEhHZc2shKH1UY2bDfJ/+znVbiUogaSle4ih2wCEpzi76Ki0NzKcbcrYuxHBOOGbYG8uT/EXqgpDa+j+oUVc6RlBHwBQnhsLZa1RdGWfJIp6Kjh/ss1e+2tX9uYltoow7bzJEHxtjepxEsWEYXrT7dU4JszqPzS+d80y4UfBzG9Z9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4728.namprd18.prod.outlook.com (2603:10b6:806:1db::15)
 by MW3PR18MB3498.namprd18.prod.outlook.com (2603:10b6:303:5f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 00:41:30 +0000
Received: from SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5]) by SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 00:41:30 +0000
From: "Ahmed, Aaron" <aarnahmd@amazon.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "edumazet@google.com" <edumazet@google.com>,
	aws-binance-tam <aws-binance-tam@amazon.com>
Thread-Index: AQHczskVAbHrfsqWm0ylDOIzc6Zy8LXj+36AgA8bggCAAJPFgIAtIPKAgAB9AQCAAqwjgA==
Date: Fri, 29 May 2026 00:41:30 +0000
Message-ID: <A2E89DBD-8DF5-44A0-A09B-ACDBDB7FB31D@amazon.com>
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
 <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com>
 <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
 <9E49374E-D1D6-4D41-BFE0-03EE734DF9F2@amazon.com>
 <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
In-Reply-To: <CAAVpQUBtKBzq36Wz9p3MaHR=G10-NFBtQXgGW3S3QV5THW2iCg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-05-29T00:34:28Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=d7f6e09f-6046-4dfb-aaaf-054c5b0ecaa2;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
user-agent: Microsoft-MacOutlook/16.108.26042616
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4728:EE_|MW3PR18MB3498:EE_
x-ms-office365-filtering-correlation-id: abefcefb-875e-46ba-ac94-08debd1b0652
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: CjDINAsCPTg1tuaj2VtcVvhKARHQp/kWZ7BO/vTwBEg5rybGWdg950j5e0i+tlLttnfrjffxmRCAqOX7hccPQndG72lxfGQwBCH1i08xzckDDTQm+pBpb3+/mcM9bXpoAfjMOlHsdlFKNX+df8eUNqqE8ZnfIIqVsYqkRpc8+M7lKs1ZD+hQnDVWNtU1N5t+4bY3IaGrozTHxcxSIPmZEb70/AnD0iwRZqDMdUzPwrcnQpaGj+mFIgqGga3UIpYLVLFqhNypNXhjHjfOB6hC9a/45Tpw3g31jnzd4htg6qH4B648PgmkmRwHkPhJCbBURRsrTxDE4HaQg6UIKoFEmW1G2YnHGWQ3LdQBbxCYnBSYrTM62PM39gA8oyA1gdpcmepdSgmpw+0tmi/Xv0H/KArPGUE7ZT3rfODVyW+mzFpEExp0Gsg/G9Vpuuny/NBJ8fbdmkyK/FeP7tgksC2YDPMdBbieQdySRQxSZkur7yMA8qBjGSezYYP2+5mpQ86Ty4mJUtXGD6Z78noqROoTbDiYitecwqr4fwyFMAFGjHY4rBzrX/2rNt9176gGzV68HG765eCv7PolWj13ZBceU2wQlosGrlfwMK0CXwZF16xIARa+Re63OhL+Ui8Q4+CKovH7viNWPFpX+rtO6gI9PyB/nzltxb+pqMQ3x/G4XVs8AqNJd+iWingFKvlVSG7AeAXr1xy/2jAl3KeXxWp856NcUxCc9t3qSVZAjZh2NK7wh6Jt2wx75hoVhvWSbGZE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4728.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3RrYTRuNFBIcVhlZEw4eUlySEZPVEE2V2F6Qkc4dmlIVkdzeGFxYjVWVHBp?=
 =?utf-8?B?NHdZZGR5Rmd1NEF2dktwbnA4YmpCUDVFcE1GeWZTM2ZCZG1aUmduQUtzYTBY?=
 =?utf-8?B?Nm84YW92UHJrVjlkc0xqUS9rMkpIV2RyWFp1VVRXc213UnAvc05IRy9rbHRC?=
 =?utf-8?B?M2xnNVM5aENkVDhESlVZVHMvSTlnaVY3MUNHMVM5aU5zWkxUcHR3OStRVFVK?=
 =?utf-8?B?VXFjaXl1bjEySGhVWXNzTFV5WHZzZG5OeWVZN0hDb1pWQ0hmUThCVTVFRUlW?=
 =?utf-8?B?WWlJOWE3a3VwbHEwcllvYVlPbkcyOUgwK0RZbXR3VE4xOGxVTFpLNTRiWVQx?=
 =?utf-8?B?TjhXeDNXNjdnOFdKbFdZQ0VUNEhVbmVtZlRWemc0WmRXRVJoTHdQRWQyUFh4?=
 =?utf-8?B?VjQwUXVSc3ZPZFNrM3FxZ3BadWJDUFFUT2FPUloyTFVlQ1VxT2lxMTR4Ym1a?=
 =?utf-8?B?UjVodWhUQURUM2s2MmE1VHB6Snk5UEMxQUY4L0lNc0s3b2pNTElkRFJLZVg2?=
 =?utf-8?B?Q3hxOGppTTdtU1ppMzRoWjNrVHQ4K2M5R0k1bkpmeDZaRHVtVko5dnBhT2Vs?=
 =?utf-8?B?cHV4ZFNtdjlSNGtHLytVb1NIL01FNmRKMWl3ZUdMbG9ZREtuTFhiYkxPaHIw?=
 =?utf-8?B?N3VNZGk3NlFmc3AxTWFTa1RwclVqWE9ZUGk4WW1UbzBrTmJDSlFzRGRHbWdt?=
 =?utf-8?B?OGw0K0hEL2twYzRXRllMWWNRRW0yVndnQklyQzlCd0hJNFF0MUpndlRHZElm?=
 =?utf-8?B?TjdhYUdsZ3gvQng4WlBLQTVHRVNUMmJMWHNpYjhlcnBSMVhUSW1ONE9SOEI5?=
 =?utf-8?B?Wkh1OU5JRVgyVmtVWVRVZUcweEFPM2V3MGJMeTdUa3dPS085M1JoUHdJcWNu?=
 =?utf-8?B?RWYxQXIrZUdSSjlER2M4N2ZwVnlVN2l3Wm9tS2FCYjB5bkMrTmxuTnoxQnVE?=
 =?utf-8?B?TnZ4dE9QbnUxai8wekV6VGlvby9CWDI1eit6Y1Z3VEhrSUlndURqZHcxTUUz?=
 =?utf-8?B?M3BSUjgxUFYxa242QzEzSjNzUmlpL2hXYk5yYTJ4akMxclhTamE4cmczSmpa?=
 =?utf-8?B?QThLQWVjRmN2ZEUyNGp4bExRYUNsbFVlczN3anhLSkxZbXZOS0xOSm11Rkti?=
 =?utf-8?B?Ykp3UUNzVGQ3ZHYvL0tlank5aVk4QlJpZlNqRXAxbU03YndsbksxYTgySXJr?=
 =?utf-8?B?NGVvdEZ4SE1KdGdMQjE1c0l5MGRRZ1MrMzR4dkFYT3NpRkc5UkVjRkpoTXlM?=
 =?utf-8?B?UmJIMG9oclk0cXdMSnVZMnVFWGFNVVhjbFNjMlJUeCtGbzR3TGRtRHBsbkJE?=
 =?utf-8?B?SnNoN3hONSsyWHFkekQvaFdNV0phZ2ppV2duWDRFSUJYdE9lRkFBMEJRcmFV?=
 =?utf-8?B?UGFZbHJmUWVqN2VVTm8rYVQ1STFicjNLTGdKOFZMWmVlaW90Rzdkd1ZxWXRu?=
 =?utf-8?B?QmdHOXppSUxFeEx0K0dhakxSMlU0VnBZWk01UHA3SjJhZVlFUlpwUVZIQXhP?=
 =?utf-8?B?bE5aMzZDdUFhZ1lvOGtxMytjbElzNkkrQ1BXUXBEY0h2OElDY0xSRG9JRnVO?=
 =?utf-8?B?Z2N0QVBNWmZmK25jZlFLZ3c3K3lLdGlDQ1ZzTm5pSkVod3ZVMUswMndnWUtX?=
 =?utf-8?B?cFZOa29GRGZzandoSkQzT3FVbFM5aWJQSXZ2SkZsVTFWbEsxSitOeEQrMlZE?=
 =?utf-8?B?T1RxQmxCbUhrL3hwN09kbnlPZ1FrSytRYmR0dlVXQkpOVklVdGJFNXl0SEpx?=
 =?utf-8?B?V0MyNlpNSHVrK1RRdUgxcUplMlVlbXJlTmJYMThXWFd3L1l1TkRkc01jRVdN?=
 =?utf-8?B?dlRwMjBRc09hUWtydXBSaExWdkFBL3JpdVI5M250WGNYQjVkMDhkZjZQNkpt?=
 =?utf-8?B?YmhvdjJQZVptMUorMzFrYmNzTThoTlZENHF6cFZzZmNObkxOSWJMWGU2dkNR?=
 =?utf-8?B?aE1rcHRSa1MvWjlvemZ2TTJGNCs5Zi91UHNVcjNaVXg1cExHanZWVmx0eHE3?=
 =?utf-8?B?MlNWSjROMFBUVWkvYm5BS2F0ZFBsL3ZhdVZvRWdYc2g4RlVDcDNac3JhNGl4?=
 =?utf-8?B?cFZQVDgxTVVKZDVLZm5EUTlsa3pWajdmVlZqRkRMUHFuRFF0MFJENU0rTjZX?=
 =?utf-8?B?aHBpdmpvcmdZN2t1cXdDVTN0UkRWZWlIcVJzd1pwcVhiN3VvQW56V094VDFL?=
 =?utf-8?B?bnBsYkkyQUdEQm5uVGVzTFI0cVRLZ21jZGJ5MHhZNVhZekFVc0hWUnN0VkJn?=
 =?utf-8?B?Y0pnUCtJYzlQQTZ2ck11aUo0aG0zdUtPZEVQaFNDN2t2eVd1aXkrR1RXZjZO?=
 =?utf-8?B?SCtWMFFaOTVZVGlUcFcwN2xESHBzQU9DZ2VBcW5yd2dkUmNMQ0JFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1F2CCBF9FFD54418EBC2B625709EC1D@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SmYM3sKrD+qXz6JK8pszbKrxlhQaJ+H3x5dYfsoN6pkrp7K5k4qaVRpotwlDSW7tNpKC+U9P8s6U5lXbO702CyMSndqhRPPS1YVh7PB1o6uz1sL5c+RNjpwG6lSX3F2u7M2xywe2O/jrA32WEvUOLNkXnb4Mp8yTDI0uM+GvZq9M8k/A7hdJJMuKrTG6rygxzv7/Yz1mz0mnENAYwpxf1xjPxXFzs5C3FsLIpCmOOwM7L3STi+WY8rUnStuvqvRZXvcjdm07a2kXrNTyo1hkT2dYOBzZ4K+SwcMTRot0wlf5PRnrr1FaSkE7lvWX8R/ixv0HASEe14KgC4+L5lrlQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4728.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abefcefb-875e-46ba-ac94-08debd1b0652
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 00:41:30.0650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCrfMx9NgqYWVIAss6PT4fgrlnTmEdJQPCqeNrGlbYW0TIvsKtJ8BEjOFAybILlrpLpVenOyXcRWCUZbo675fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3498
X-OriginatorOrg: amazon.com
X-Spamd-Result: default: False [-6.06 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256456-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[readme.md:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aarnahmd@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 952BD5FBBEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgS3VuaXl1a2ksDQoNCk9uIE1vbiwgQXByIDI3LCAyMDI2IGF0IDU6MTYgUE0gS3VuaXl1a2kg
SXdhc2hpbWEgPGt1bml5dUBnb29nbGUuY29tPiB3cm90ZToNCj4gU29ycnksIEkgZGlkbid0IGhh
dmUgdGltZSB0byBsb29rIGludG8gaXQuDQoNCk5vIHdvcnJpZXMsIHRoYW5rcyBmb3IgdGhlIHJl
c3BvbnNlLg0KDQo+DQo+IENvdWxkIHlvdSB0cnkgcmVwcm9kdWNpbmcgdGhlIGlzc3VlIG9uIHRo
ZSBsYXRlc3QgbmV0LW5leHQuZ2l0DQo+IGFuZC9vciB0aGUgbGF0ZXN0IExUUyB0cmVlIDYuMTgu
eSA/DQo+DQo+IEFuZCBpZiB5b3UgY2FuIHN0aWxsIHJlcHJvLCBwbGVhc2UgdXBkYXRlIFJFQURN
RS5tZCBhY2NvcmRpbmdseQ0KPiBhbmQgdXBsb2FkIHlvdXIgLmNvbmZpZyBmaWxlIHNpbmNlIEkg
ZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gQW1hem9uIExpbnV4IDopDQoNClJlcHJvZHVjZWQgb24gbGF0
ZXN0IDYuMTgueSBMVFMgKDYuMTguMzMpLiBVcGRhdGVkIHRoZSBSRUFETUUNCmFuZCB1cGxvYWRl
ZCAuY29uZmlnOg0KDQogIGh0dHBzOi8vZ2l0aHViLmNvbS9hYWhtZWQ3MS90Y3AtbGluZ2VyLW1l
bWxlYWstcmVwcm9kdWNlcg0KDQpUaGFua3MsDQpBYXJvbg0KDQo=

