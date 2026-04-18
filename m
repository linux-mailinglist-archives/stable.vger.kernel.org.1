Return-Path: <stable+bounces-238530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE7TMj/O4mmX+gAAu9opvQ
	(envelope-from <stable+bounces-238530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 02:20:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65541F4FF
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 02:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89DCB300A61F
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E203175A94;
	Sat, 18 Apr 2026 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Iy46NOOM"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504070836;
	Sat, 18 Apr 2026 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=35.162.73.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776471599; cv=fail; b=MAHkEZtq+I83VyT5QirBdA5vcLQoBK/DKDYYtzsBTbeijYqrX5iK9VVXZU+RST3cYHRoELW3KqSUADl6AEZmrICGyi40OddK31G3s2O1G4VBNUKXc5rzlTdX61XK9sIZJ3+YKoWNXykwssXXRN+Ab4r7g8hwnJkiIW6g73wzHuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776471599; c=relaxed/simple;
	bh=fl4PQkF1/RfUC+l/365gzdbjiJv6u1jGogHrqFJ962M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G9cAYeeWqBtxPvqophMhLtF+hhlVSfCRkAnfYDSltAMJzwdg8XPTJtJjWgXDr0YnbnAovQDE8ZpmSjTAlX9WhNKi5UiLiKoDCvwH8J4t6QBUKHDivFTGKFY/9kk7CDFz5QVcaeGiTlgQsZhOnvsri+OZPgtN/StOZglucXGpkGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Iy46NOOM; arc=fail smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776471598; x=1808007598;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=fl4PQkF1/RfUC+l/365gzdbjiJv6u1jGogHrqFJ962M=;
  b=Iy46NOOMi4o6GA910F3ahCba7p9E9776uQeA7B4L7DP6XuA9sndsnxTu
   Efa1/+NbT/UOZX2UgFtzaU1JnD1qMrPh3E4mAL0g8J/1eDPrav68/+iGK
   hOurP9/j/J/AQNBCrjl+BOKzT098jVdHqN3g40HlA/HKWlJ+I376E+zKR
   oHmnSKDVzm6OSiOcK6088nmZ18CU+dHr7ocels33wJwLyziW5UueUtAM2
   WUJx5FwnbZbQlyPIzEXVQtDq07O7MI6B4Pz9+IMMHFk6+dBVT82B/mmWi
   0ap5haIiXToT8SnhVJFBjInNLthpu3E/3XZokvIum/BQDiT/ZBckoIXLB
   w==;
X-CSE-ConnectionGUID: rUi5Y2waSgKEsU+mLeRnLQ==
X-CSE-MsgGUID: FcYAbB3jREWE+xE7Mf6aXw==
X-IronPort-AV: E=Sophos;i="6.23,185,1770595200"; 
   d="scan'208";a="17401436"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2026 00:19:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:14376]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.68:2525] with esmtp (Farcaster)
 id 26a8f95b-7ba2-46f9-bb01-1d4c329ff515; Sat, 18 Apr 2026 00:19:58 +0000 (UTC)
X-Farcaster-Flow-ID: 26a8f95b-7ba2-46f9-bb01-1d4c329ff515
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sat, 18 Apr 2026 00:19:57 +0000
Received: from CH4PR07CU001.outbound.protection.outlook.com (10.250.64.168) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Sat, 18 Apr 2026 00:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMcSAFZXxFe05s+aklwk6qZh89aLVdRKKQVlSMHVaorm1p2Esqq3U4z8JulvzDpTvLcLzqtn6khkr9XLnpCg3tOBlq8vNprECzSZf1+e486IT6XOxyTqyF25HP8Fi9sY2Wgrf9n7pJ68ChBv6dioK3PYqnWamkIdKpiFMCm5lXyFfdQhyPFV/f2WR7czplrmstEsIwQHPEU+gTEZbxQ+yq9zH8wwCNaGEf0nxsRneSIshUKdBxOdcU27yK6g7NKK2RIZr/UNOZxo/rmPQ/GiMysa43yR37ceJVYOMGL5e6bnOhqZQKFoPuGbnca9HJbl/pRHYxQcyqvDXrQu4+HXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl4PQkF1/RfUC+l/365gzdbjiJv6u1jGogHrqFJ962M=;
 b=VNAJ/wmKOZ9EMuqCXrPEBdoz6quUfCOfp+DERPCLRCc/UN/r+n0ILL+PcuyvRXU/WLC7kK35gsNSN4YIxDEYMwempciNqVqsj0s0W+yyGk7eyynTLb8Gi7zh1tCn7K5AwbPsr7C7cTP7qmRz8Ni9mFCKfsPB7AcNB24bcxfnVN8gtxQR5oezRZ64240poEebe+f3X1yJTt1bPEK7/rKP+kr4o4LL7g4EqaA32sCPMr5fhZbggcQiXg1KPqkux4Ya3mtULk6cc5msKcjIpJdaXQkzn3orJQn5hOH/pkMX9IglW5en9VmWrfAavBWgwcyhD8rksGCriHpuM6C15A+v8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from SA1PR18MB4728.namprd18.prod.outlook.com (2603:10b6:806:1db::15)
 by MW3PR18MB3676.namprd18.prod.outlook.com (2603:10b6:303:2c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sat, 18 Apr
 2026 00:19:55 +0000
Received: from SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5]) by SA1PR18MB4728.namprd18.prod.outlook.com
 ([fe80::3fa5:9d2e:e6a6:67d5%6]) with mapi id 15.20.9818.023; Sat, 18 Apr 2026
 00:19:55 +0000
From: "Ahmed, Aaron" <aarnahmd@amazon.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "ncardwell@google.com" <ncardwell@google.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuniyu@google.com" <kuniyu@google.com>
Subject: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when closing
 sockets with pending send data
Thread-Topic: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
Thread-Index: AQHczskVAbHrfsqWm0ylDOIzc6Zy8A==
Date: Sat, 18 Apr 2026 00:19:55 +0000
Message-ID: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-04-17T22:06:42Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=424c9079-8b3d-46cb-a0ce-76e1467bb5cd;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4728:EE_|MW3PR18MB3676:EE_
x-ms-office365-filtering-correlation-id: 95912064-a032-4bd9-026b-08de9ce037a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: v4Kro2QjY5ZXUbUaADFKyXQShuEUZb5vAn06rxbm+s3j1/oc7fcXQnhIfsGRhXXe48NKpbHtpwF8ZgQxXGdXolafujB8PkeQwoXK8lCiiOUcvM3H5JxRS/YER5Vz9u87aqvl47qqyz88Hl6xGLqhLu8DjcwPFgRe3YZK/b9BEay6ZTP4Bw+UNaV8Rs4KgQMgbFF7Nxl2dhPFVV+AdFIwrCM5OjziRmeiOCU1sBxR+Cdf+Y8Gg0lVYsZTLYFEQkmZ4b3LimAAgFW0I0b8IdsxHi1iqGZy85FOIftdFI3Az0LxciRzSo4RtYQOHADc4ZH7QFf7LZbW67vXm/40faiD9vYvb/Q5P2QJfs884vaPnk/YZfQeHbyIttq0sSZ463t3GHnN0cy8pIGLRXOuoJ0RNomiSkZerXitvYWvKsaeUgWM/wg3EW5WDOhWcstvLGcjlWCjqSqplVtvVAfoksxqCVGf6teLHaB+PSB/W5NRPIYMcBPXIq9xQc2YAY1by5lXWC4MVi2u2fYZDC2+CpOZVJxy95TxNaGjOiI5M5CzGBa0uA6kZJ1uPnoWiXQgwQN8EwIkzyCgSXZ2Tng+MTq8HtoNygpB1IN59pqMuWzEZdHQ7YiiTPdY6FdZGsk3kZHC75v0WN+iaa2FiGenk/S1HZ6XFmyrXYjQsNjqiioQt2gCDcaoO+8qQ28CHn8IQT6GeZLdnT8IGnwFSGK34pKIEocDx2cks3MoJ67YkxkSgrYfdtKilJChZL3zzvpwAaAsg8HelC0TD+qCOmszKrTEq5Ei5Ix1h5D62CnKlHqJT6w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4728.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXVrdlFtbHhzb3VBTEhpY055M1FhWWZkU0hma1IyWEdnakVlQllHZHhObG1K?=
 =?utf-8?B?ZFhnZUl5ZkVLZGE4aUhFQmdEbUVCQ3pyRDFpYy9JVkgrS3ViSWJ3Z3lUdStt?=
 =?utf-8?B?NXF5Q0VGS3Z0R1F0YjdBSCt0OEwxUmJtTGp0OVY5RUNvN2Q3U000V1lXclpu?=
 =?utf-8?B?RjF2TGs4UU1seXgzUnpSM2dzUVIwMlEzNytTQmxzYVAvRlI3bWZLSlczU2hG?=
 =?utf-8?B?MW4wRyttOGVFTFNqeCtHREtWa1VmWVhiM0VCcjg3VGErSDRsdU5GemtSU2d0?=
 =?utf-8?B?c1p4WmtCajFhQ2U2UTB0R1dsQ1ErekFMZlgrSU0vbktjSXEwQlhWWURta2Jz?=
 =?utf-8?B?WXdKWXp6UDU4b3ZBYzRPTjgrd3ptNnMrT2I3cmFRT1lPTllSM0lpLy9QSUZr?=
 =?utf-8?B?Vzd4aDNjOGlXRVBKd3dWSllqV0RBcFBqdER2NFlteXJMaGZSOHVjU2V0MFRv?=
 =?utf-8?B?TjVnRmFuZEdQWUdBTDBjQzYwQS85NG01T0RWbG1hSklYQlpkYnZ2OHZTWTR2?=
 =?utf-8?B?QnJ0RXBoLzRnNlJ3TjBRc1MwbFNwTE4yWWtmSmVVMXFZWURwZ29ocjJiK1gw?=
 =?utf-8?B?MzM3L1FHS0s5UnA3anpWWjVja3NoaTVzNmVtdVNENnRscDdBaWV3dTZjSTZL?=
 =?utf-8?B?dlhOL3Z6Tk15WnREd1hWYlZQZHo2M2FtNDVsQnIyWTVrd3lVamdQSFViQXFv?=
 =?utf-8?B?UHZVbyt4UFVPK1Z4QlVxY0hud3p2ZHprMVFNV204amJuWFNkVFZJS1FWZnVZ?=
 =?utf-8?B?UFVKQi9xcG0wSy8reGpJRkZpVmJEUm5HS20veG1ZSHJIbEp2SVk1WlFyVmdV?=
 =?utf-8?B?UnhhRmVCZytSVHdvOTl1eGIxSzBBR0gyTjNiYUNGU2VyQ0xvaVJKV1lTVXNY?=
 =?utf-8?B?VkUvMjl4SmN2cFB5TnFaVVZYTlc1aUZSQmlReW1kaERETFNQaXBhTDFwbDE3?=
 =?utf-8?B?eFk3UG9rN3dsNXFZMWRZRTBKZXlnVU80Sk4xa0p1VFdHVmtiNExzUDE5VHM1?=
 =?utf-8?B?bVBnSmlDS2ZmazdSYnA1RzJsYUl4KzA3bjFFbzBaQUJtNm1USjBMYXJkcndW?=
 =?utf-8?B?bE05WU5hd20vdFdPelM5anlNa2dvY2kzakhZMlMzZmlTU1VLL2k5dnk5dCtr?=
 =?utf-8?B?VW1FbUExTHZ5UmJFU1NDZGVyY0FhclYyWExHYnkwZGRHaDhpM0psdUxMdVVk?=
 =?utf-8?B?UUtzU3h0SzVSTm1WVjJhRTkyV0p1bnpBUWVVYXFhclZRQmtlS0R0MThJL3BB?=
 =?utf-8?B?VkFDVy95UmRXZEgvUTEzVXFlYmlKRDFodEUwb0M0ekovWU5ncHF4Y0xUdjNr?=
 =?utf-8?B?SE9mVTRzdkF5NWtSY2dwb0lmK0xvVUo4TWhvSWhZWnBZcjNkaHpCNjRGT3lX?=
 =?utf-8?B?QTN0NmN2VGo5c1RJVEdQVS9MUjhFNlR1VW5QMWhlQi9KQXRobURHdlhTQXEr?=
 =?utf-8?B?VkpQOFZLZWVkY01PMGpZNVUrOHJod1MvMEpzYkZTaEsxNngzMGozNHZzQWsz?=
 =?utf-8?B?TGtKbDZwS3EvL0F3SkpuNWZ5V1lYUHd6ZWovL3g2K0l1cDFRY1ZIVXJMOVkw?=
 =?utf-8?B?U3RISGozTU1hTlF4SmR5WTNjNWRwQVVJNFA1bG1BTEErY05zK1VyNGExK3JN?=
 =?utf-8?B?bW01SDVHMVN3Y1lFdE5GNkZyZG1CUVFBRFVFbnlVSll1bWdhS2RjcEExeDhl?=
 =?utf-8?B?cVBENllHYlFUWG5IenlqWUNnbkEvVlVPdnE3UXJ2WXlDNEJuUnBDQzc3UXhD?=
 =?utf-8?B?aDdIa0lrZS9ubEszczlEVXlQMEFOOXRhRDMyVmpUcVdPcjBxY3FwZTFkcUJX?=
 =?utf-8?B?NTlOZU1IQ0ViN0pZSXFiZ3RCMnBWWFZKMlBDcHVZQzJDSlUwSVJITU5ZTXN5?=
 =?utf-8?B?WFNCVTRUK2MydnZITVlxNWNhTUdrdW1EaXdyWE9LY0lqZlhDNTV5dlovV0hI?=
 =?utf-8?B?bmdoVTBoN2RRVDFPVlFKbkEzYWIxVmRXQ2ZiQ2tyTXorUWhZeVlNZG5OY2ZG?=
 =?utf-8?B?RVVTU2JLcU5STzZYVFpYblloUzVaU3ZZRTZQdTh5a2FydWZLUW95T1VOcVN5?=
 =?utf-8?B?VGdUNE5Td01wam9QYXVEZ3NWYUw3Z2hxdWNzNUtING5oblZnZ01ZQTNpdy83?=
 =?utf-8?B?bzRQUlUvS0RjMVd0Mm4vdThEK25LeGtHRWhYVzZDWnp2Y3JpTi9INmg4aGVD?=
 =?utf-8?B?Q3UwSzVjaHZNZUlKR1JsamJoVWdzVzFsSTFZT3kyRDNHOWpTWGJTNG5GNEZ5?=
 =?utf-8?B?M0h6SU1KVlFTNWlFQ2NJMEJSbzgxbXQ5SWtVMUZyc0ZQSjFqUXUxSjlDYXZB?=
 =?utf-8?B?ZnpNcVJvNFNQdWJKOHJEekNrcGxldkpXVVRZbm45b3Y0bStEQjF5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68E96A8BBAA8DA4D8B4596EC01595DBB@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tcTXmSt0vksBhUpIV18emvUaU7DR0yYdAmykdqmxOlwiX8Kk0aHiNywp6p+UxXPoMspDIoFn+GPw2HsglCNPC4R03INrwFnksCyEo/+VPg5//V9Jhy8uUa8YyYW4B9QbIc5/eyzdYprtWC21Pq4FFBKlk59PU3IJYDlPFdY6AEUHM6xxgOnSZJ1pQNbiI5zQX+GH0EilGSUZO0QZEyGJi8j8EGsm2ErgFk0XokXYAXjZe/DOmvd/iwmAv6UzRERl5tFyjN+HmFP2sVqYPB63EC/7LwdRj5HDPKBHD58eBu1E7fcFYNX+A0BnSMLHCApbQ/HcXYwoLkNdXR02bmhf6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4728.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95912064-a032-4bd9-026b-08de9ce037a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2026 00:19:55.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3Cj220GVPTAwtKQYC8gaxC/jvORL2QZBmxac5dtwpbA/99KCXPvh0CETCKxunJxwVsic7LB+ZAudbVSESsm8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3676
X-OriginatorOrg: amazon.com
X-Spamd-Result: default: False [-7.06 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238530-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aarnahmd@amazon.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7A65541F4FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGksDQoNCldlIGhhdmUgaWRlbnRpZmllZCBhIFRDUCBtZW1vcnkgbGVhayBpc3N1ZSBvbiBBbWF6
b24gTGludXggd2l0aCBrZXJuZWwgdmVyc2lvbnMgNS4xNS4xNjggdGhyb3VnaCA2LjE4LjIwIHRo
YXQgb2NjdXJzIHdoZW4gY2xvc2luZyBzb2NrZXRzIHdpdGggU09fTElOR0VSIHNldCB0byBsX29u
b2ZmPTEsIGxfbGluZ2VyPTAsIG9uIHNlcnZlcnMgaGFuZGxpbmcgbWFueSBwZXJzaXN0ZW50IGNv
bm5lY3Rpb25zIHdpdGggZnVsbCB3cml0ZSBidWZmZXJzLg0KDQpPdmVydmlldzoNCg0KVGhlIGlz
c3VlIHdhcyBkaXNjb3ZlcmVkIG9uIGEgcHVibGljLWZhY2luZyBub24tYmxvY2tpbmcgVENQIHNl
cnZlciB0aGF0IG1haW50YWlucyBtYW55IHBlcnNpc3RlbnQgY29ubmVjdGlvbnMgYW5kIHN0cmVh
bXMgZGF0YSB0byBjbGllbnRzLiBXaGVuIGEgY2xpZW50IGNhbm5vdCByZWFkIGZhc3QgZW5vdWdo
LCB0aGUgVENQIHdyaXRlIHNvY2tldCBidWZmZXIgb24gdGhlIHNlcnZlciBzaWRlIGZpbGxzIHVw
IGFuZCBzZW5kKCkgcmV0dXJucyBFQUdBSU4uIEF0IHRoYXQgcG9pbnQsIHRoZSBzZXJ2ZXIgYXBw
bGljYXRpb24gZGlzY29ubmVjdHMgdGhlIHNsb3cgY2xpZW50IGJ5IHNldHRpbmcgU09fTElOR0VS
IHRvIGxfb25vZmY9MSwgbF9saW5nZXI9MCBhbmQgY2FsbGluZyBjbG9zZSgpLiBUaGlzIGlzIGlu
dGVuZGVkIHRvIGltbWVkaWF0ZWx5IHJlc2V0IHRoZSBjb25uZWN0aW9uIGFuZCByZWxlYXNlIGFs
bCBhc3NvY2lhdGVkIGtlcm5lbCByZXNvdXJjZXMuIEhvd2V2ZXIsIHdoaWxlIHRoZSBzb2NrZXQg
ZGlzYXBwZWFycyBmcm9tIG5ldHN0YXQgYW5kIHNvY2tzdGF0IChUQ1AgaW51c2UgZHJvcHMpLCB0
aGUgd3JpdGUgYnVmZmVyIG1lbW9yeSBpcyBub3QgcHJvcGVybHkgcmVjbGFpbWVkLiAvcHJvYy9u
ZXQvc29ja3N0YXQgc2hvd3MgVENQIG1lbSBwYWdlcyBhY2N1bXVsYXRpbmcgd2l0aCBubyBvd25p
bmcgc29ja2V0cywgY2F1c2luZyB0aGUgbGVha2VkIG1lbW9yeSB0byBncm93IHBhc3QgdGhlIHRj
cF9tZW0gbGltaXRzLiBTZXR0aW5nIFNPX0xJTkdFUiB0byBsX29ub2ZmPTEsIGxfbGluZ2VyPTEg
aW5zdGVhZCBkb2VzIG5vdCBsZWFrLiBXaXRoIGxfbGluZ2VyPTEsIHRoZSBjb25uZWN0aW9uIGdv
ZXMgdGhyb3VnaCBGSU5fV0FJVDEg4oaSIEZJTl9XQUlUMiDihpIgQ0xPU0UgKGNvbmZpcm1lZCB3
aXRoIEJQRiB0Y3BzdGF0ZXMpLCBhbmQgYWxsIG1lbW9yeSBpcyBmcmVlZCBwcm9wZXJseS4gV2l0
aCBsX2xpbmdlcj0wLCB0aGUgY29ubmVjdGlvbiB0cmFuc2l0aW9ucyBkaXJlY3RseSBmcm9tIEVT
VEFCTElTSEVEIOKGkiBDTE9TRSB2aWEgUlNULCBieXBhc3NpbmcgdGhlIEZJTiBzdGF0ZXMgZW50
aXJlbHkuDQoNClJlcHJvZHVjZXI6DQpgYGANCi8qIHRjcF9saW5nZXJfbWVtbGVhay5jIC0gU09f
TElOR0VSKDApIFRDUCBtZW1vcnkgbGVhayByZXByb2R1Y2VyDQogKg0KICogQnVpbGQ6ICBnY2Mg
LU8yIC1vIHRjcF9saW5nZXJfbWVtbGVhayB0Y3BfbGluZ2VyX21lbWxlYWsuYw0KICogUnVuOiAg
ICBzdWRvIHN5c2N0bCAtdyBuZXQuY29yZS53bWVtX21heD00MTk0MzA0DQogKiAgICAgICAgIHN1
ZG8gc3lzY3RsIC13IG5ldC5pcHY0LnRjcF9ybWVtPSI0MDk2IDgxOTIgMTYzODQiDQogKiAgICAg
ICAgIC4vdGNwX2xpbmdlcl9tZW1sZWFrDQogKi8NCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1
ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPHN0cmluZy5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0K
I2luY2x1ZGUgPGVycm5vLmg+DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxzaWduYWwu
aD4NCiNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+DQojaW5jbHVkZSA8c3lzL3dhaXQuaD4NCiNpbmNs
dWRlIDxuZXRpbmV0L2luLmg+DQoJDQojZGVmaW5lIE5VTV9DT05OUyA1MDAwDQojZGVmaW5lIFBP
UlQgICAgICA2NjY2DQoNCnN0YXRpYyB2b2lkIHByaW50X21lbShjb25zdCBjaGFyICpsYWJlbCkg
ew0KICAgIEZJTEUgKmY7DQogICAgY2hhciBsaW5lWzI1Nl07DQogICAgZiA9IGZvcGVuKCIvcHJv
Yy9tZW1pbmZvIiwgInIiKTsNCiAgICB3aGlsZSAoZmdldHMobGluZSwgc2l6ZW9mKGxpbmUpLCBm
KSkNCiAgICAgICAgaWYgKHN0cm5jbXAobGluZSwgIk1lbUF2YWlsYWJsZToiLCAxMykgPT0gMCkN
CiAgICAgICAgICAgIHByaW50ZigiJXM6ICVzIiwgbGFiZWwsIGxpbmUpOw0KICAgIGZjbG9zZShm
KTsNCiAgICBmID0gZm9wZW4oIi9wcm9jL25ldC9zb2Nrc3RhdCIsICJyIik7DQogICAgd2hpbGUg
KGZnZXRzKGxpbmUsIHNpemVvZihsaW5lKSwgZikpDQogICAgICAgIGlmIChzdHJuY21wKGxpbmUs
ICJUQ1A6IiwgNCkgPT0gMCkNCiAgICAgICAgICAgIHByaW50ZigiJXM6ICVzIiwgbGFiZWwsIGxp
bmUpOw0KICAgIGZjbG9zZShmKTsNCn0NCg0KaW50IG1haW4odm9pZCkgew0KICAgIHN0cnVjdCBz
b2NrYWRkcl9pbiBhZGRyID0gew0KICAgICAgICAuc2luX2ZhbWlseSA9IEFGX0lORVQsDQogICAg
ICAgIC5zaW5fcG9ydCA9IGh0b25zKFBPUlQpLA0KICAgICAgICAuc2luX2FkZHIuc19hZGRyID0g
aHRvbmwoSU5BRERSX0xPT1BCQUNLKQ0KICAgIH07DQogICAgaW50IG9wdCA9IDE7DQogICAgc2ln
bmFsKFNJR1BJUEUsIFNJR19JR04pOw0KDQogICAgaW50IGxzbiA9IHNvY2tldChBRl9JTkVULCBT
T0NLX1NUUkVBTSwgMCk7DQogICAgc2V0c29ja29wdChsc24sIFNPTF9TT0NLRVQsIFNPX1JFVVNF
QUREUiwgJm9wdCwgc2l6ZW9mKG9wdCkpOw0KICAgIGJpbmQobHNuLCAoc3RydWN0IHNvY2thZGRy
ICopJmFkZHIsIHNpemVvZihhZGRyKSk7DQogICAgbGlzdGVuKGxzbiwgTlVNX0NPTk5TKTsNCg0K
ICAgIC8qIEZvcmsgY2xpZW50OiBjb25uZWN0IE4gdGltZXMsIG5ldmVyIHJlYWQgKi8NCiAgICBw
aWRfdCBjaGlsZCA9IGZvcmsoKTsNCiAgICBpZiAoY2hpbGQgPT0gMCkgew0KICAgICAgICBpbnQg
ZmRzW05VTV9DT05OU107DQogICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgTlVNX0NPTk5TOyBp
KyspIHsNCiAgICAgICAgICAgIGZkc1tpXSA9IHNvY2tldChBRl9JTkVULCBTT0NLX1NUUkVBTSwg
MCk7DQogICAgICAgICAgICBjb25uZWN0KGZkc1tpXSwgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRy
LCBzaXplb2YoYWRkcikpOw0KICAgICAgICB9DQogICAgICAgIHBhdXNlKCk7IC8qIHNpdCBmb3Jl
dmVyLCBuZXZlciByZWFkICovDQogICAgICAgIF9leGl0KDApOw0KICAgIH0NCg0KICAgIC8qIEFj
Y2VwdCBhbGwgY29ubmVjdGlvbnMgKi8NCiAgICBpbnQgY2xpZW50c1tOVU1fQ09OTlNdOw0KICAg
IGZvciAoaW50IGkgPSAwOyBpIDwgTlVNX0NPTk5TOyBpKyspDQogICAgICAgIGNsaWVudHNbaV0g
PSBhY2NlcHQobHNuLCBOVUxMLCBOVUxMKTsNCg0KICAgIC8qIEZyZWV6ZSBjbGllbnQgc28gaXQg
c3RvcHMgcmVhZGluZyAqLw0KICAgIGtpbGwoY2hpbGQsIFNJR1NUT1ApOw0KICAgIHByaW50Zigi
PT09ICVkIGNvbm5lY3Rpb25zIGVzdGFibGlzaGVkLCBjbGllbnQgZnJvemVuID09PVxuIiwgTlVN
X0NPTk5TKTsNCiAgICBwcmludF9tZW0oIkJFRk9SRSIpOw0KDQogICAgLyogRmlsbCBidWZmZXJz
IGFuZCBjbG9zZSB3aXRoIFNPX0xJTkdFUigxLDApICovDQogICAgY2hhciBidWZbMjA0OF07DQog
ICAgbWVtc2V0KGJ1ZiwgJ0EnLCBzaXplb2YoYnVmKSk7DQogICAgZm9yIChpbnQgaSA9IDA7IGkg
PCBOVU1fQ09OTlM7IGkrKykgew0KICAgICAgICBpbnQgZmxhZ3MgPSBmY250bChjbGllbnRzW2ld
LCBGX0dFVEZMLCAwKTsNCiAgICAgICAgZmNudGwoY2xpZW50c1tpXSwgRl9TRVRGTCwgZmxhZ3Mg
fCBPX05PTkJMT0NLKTsNCiAgICAgICAgd2hpbGUgKHNlbmQoY2xpZW50c1tpXSwgYnVmLCBzaXpl
b2YoYnVmKSwgTVNHX05PU0lHTkFMKSA+IDApOw0KICAgICAgICBzdHJ1Y3QgbGluZ2VyIGxnID0g
eyAubF9vbm9mZiA9IDEsIC5sX2xpbmdlciA9IDAgfTsNCiAgICAgICAgc2V0c29ja29wdChjbGll
bnRzW2ldLCBTT0xfU09DS0VULCBTT19MSU5HRVIsICZsZywgc2l6ZW9mKGxnKSk7DQogICAgICAg
IGNsb3NlKGNsaWVudHNbaV0pOw0KICAgIH0NCg0KICAgIHNsZWVwKDIpOw0KICAgIHByaW50Zigi
XG49PT0gQWxsIHNvY2tldHMgY2xvc2VkIHdpdGggU09fTElOR0VSKDEsMCkgPT09XG4iKTsNCiAg
ICBwcmludF9tZW0oIkFGVEVSIik7DQogICAga2lsbChjaGlsZCwgU0lHS0lMTCk7DQogICAgd2Fp
dHBpZChjaGlsZCwgTlVMTCwgMCk7DQogICAgY2xvc2UobHNuKTsNCiAgICByZXR1cm4gMDsNCn0N
CmBgYA0KT3V0cHV0IChUZXN0ZWQgb24gNi4xOC4yMCk6DQpgYGANCj09PSA1MDAwIGNvbm5lY3Rp
b25zIGVzdGFibGlzaGVkLCBjbGllbnQgZnJvemVuID09PQ0KQkVGT1JFOiBNZW1BdmFpbGFibGU6
IMKgIDk1NDkxMjg4IGtCDQpCRUZPUkU6IFRDUDogaW51c2UgMTAwMDUgb3JwaGFuIDAgdHcgNSBh
bGxvYyAxMDAwNiBtZW0gMA0KDQo9PT0gQWxsIHNvY2tldHMgY2xvc2VkIHdpdGggU09fTElOR0VS
KDEsMCkgPT09DQpBRlRFUjogTWVtQXZhaWxhYmxlOiDCoCA5NTMyMTgwMCBrQg0KQUZURVI6IFRD
UDogaW51c2UgNSBvcnBoYW4gMCB0dyA1IGFsbG9jIDUwMDYgbWVtIDgzMDANCmBgYA0KDQpUaGFu
a3MsDQpBYXJvbiBBaG1lZA0KDQoNCg==

