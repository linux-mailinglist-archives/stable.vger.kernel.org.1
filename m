Return-Path: <stable+bounces-144768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A6ABBBFB
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF22317CEE0
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC41A2741A1;
	Mon, 19 May 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lx03V7gh"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EC1F462C;
	Mon, 19 May 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652900; cv=fail; b=j19xzRhSzbVSmKgHMyUJqN8qnD13mrWPZbd2m00oaVlWNNEjkfDyP8Nhotj3fLXH0q4i0LZTtNE3kONPOzFe9UmEK9iTJ+fq/2TZrrDL9AVQ4xK3IK8352Cfhn1Rv65rvF2VN4p8VXE6k9/n5/qE3TESh5pVOpTO8WGeh5jjB+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652900; c=relaxed/simple;
	bh=nNuUQUqOqn6dRCYL/dBAt5TP4I20LLw4tt179mTrrxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VfdtbMDMl46xog10lasPPsRd+o2R1nf6gxoXdLlVi2nIWNP4wErRNF43xsOT29CTa7JhLJeC0hys1+FqNWWHGKBGuLtuZo4KSZEr+f9WkPH9lJn+adTetUEGWVVoSIZczqGcnG2BR17LuAWky34xxqHNrwVJvbs028fshtvGZ5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Lx03V7gh; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JAhTWO021667;
	Mon, 19 May 2025 04:07:53 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46qxnprmbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 04:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM7jYp4z/T8yT9kLnP3cxLGZgVlHjkpL5wvPj0IMVxTH7ugypaMNUnvhNOUD22rmfqLTT0o2UXlO3iGYmjl5X0AFFzLzc8rwWOts9nkOahQWR1tTjnG4L8g2PIOrF0W/scF9FrOA759VGp9dhKVaW29p2MkFehJ25HUTB8UN/ynkCXg4nCHaL8hJDUIrUk3ba28uXalLp0BKFh9j/IumVoq/zezZR8v9AQFgCzasgPCOlcFtulf64dIytgDSX1djcOvwa8Fp9R4RQKXTbptjyioQIghfmAedm/KtFv348duS9py7Oiqw6RWLvJY1IqO8F0ZUBAq64riOEE3revfymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNuUQUqOqn6dRCYL/dBAt5TP4I20LLw4tt179mTrrxY=;
 b=HsyZ2kY1RSSz7Ddp9nWoQHSSIrsKeaRfj+++vpMOjwCA3DO2ymGdHtkyEbObTD0SdE49YeMfZ/IxZl5DTuyKBPB4DbXGm2Ptv2896fMkPqOgdnZhPcCRbCjsFyXwG4RGtjui3yAZq8Ll0z2FfoAo8KRvu0ob+Vj4omFo1BUaesoSnHczWsSvpv9sZUYXp6sfOaC7eRBpXFZlzayj73Hv4iBYQDME2GZDv6IP3GoC3H/W6DufeohmVbUD4oApkGETyxaQW+BBPslgywqUECtGo+ykfNJ1I29e9dbqRn3LZBIWqoUoh4x0VbKRQV/KsASOVmmOONRVe24i0m+iuVpDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNuUQUqOqn6dRCYL/dBAt5TP4I20LLw4tt179mTrrxY=;
 b=Lx03V7ghFD6iJtkjuZEtUZgeZ0ZwQ3PwmRvQe3eOzioGzkPjZCGtqFRpi7iLG3DtECvmwkwd3cbFyOyBqzOL6qyS9o0tKt5pkkW4JfCAXjLM2jo95G31CZgcnbxcNJNY8qe0gE+XWxsa2YHbWC/bc0zSASFFnOXSS9hXM2IncPM=
Received: from DS0PR18MB5285.namprd18.prod.outlook.com (2603:10b6:8:123::20)
 by BY1PR18MB5301.namprd18.prod.outlook.com (2603:10b6:a03:523::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Mon, 19 May
 2025 11:07:45 +0000
Received: from DS0PR18MB5285.namprd18.prod.outlook.com
 ([fe80::6de5:adca:97fa:c4b8]) by DS0PR18MB5285.namprd18.prod.outlook.com
 ([fe80::6de5:adca:97fa:c4b8%5]) with mapi id 15.20.8699.026; Mon, 19 May 2025
 11:07:44 +0000
From: Igor Russkikh <irusskikh@marvell.com>
To: Wentao Liang <vulab@iscas.ac.cn>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jackson Pooyappadam
	<jpooyappadam@marvell.com>
Subject: RE: [EXTERNAL] [PATCH] net: atlantic: Add error handling in
 set_raw_ingress_record()
Thread-Topic: [EXTERNAL] [PATCH] net: atlantic: Add error handling in
 set_raw_ingress_record()
Thread-Index: AQHbyKfje8/FU8fSf06rysBOZxp8f7PZyHkw
Date: Mon, 19 May 2025 11:07:44 +0000
Message-ID:
 <DS0PR18MB528549682B139522F013838FB79CA@DS0PR18MB5285.namprd18.prod.outlook.com>
References: <20250519102132.2089-1-vulab@iscas.ac.cn>
In-Reply-To: <20250519102132.2089-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5285:EE_|BY1PR18MB5301:EE_
x-ms-office365-filtering-correlation-id: 3608a100-2876-48f8-eaf2-08dd96c561b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEdGMzhxS0hyeEZkRDMvSFRscnFTZVJKeXF2UXJ4LzdBd25UeGxSZksrS2Qz?=
 =?utf-8?B?M3VGd1FXUWl3VGhHNHNkQUJJRWgrOVhjTm80aFFXNThJbEw1RlRLZWdrZUJM?=
 =?utf-8?B?MEdycjdoa25YOW1aMjNpcjF1d09NZHlpS21iZjB5WERuZ0tJMTVvK1RHZHYw?=
 =?utf-8?B?UUtNQS9RQml1cEJPc3BPcUJTVFA3MGhjYmw5aWpNOXQrU0J6eEhZWE44SVZu?=
 =?utf-8?B?RU9pZXZNM0IrdE1DU2JkaDdOM0RPQ25wQUtKRkVOTDdhdWVKcVI5M2dwVWZv?=
 =?utf-8?B?UzNZRTd4L1F0Y3lISzhlcTF5YVgyRnZ2RnJMbU5jbS9ITm9SQXNGb2FQc1No?=
 =?utf-8?B?TktQZEpLRVZQb01ucno2Q1drMGg3eDcwWWZjdmJTaUpPbnJORG9PRGtWU1Ra?=
 =?utf-8?B?ZzFZODlneFB3U0QrQStsN2pzQUpqZlQzeHVFT3hDNDhmT0NoSnIzVkRKbFBD?=
 =?utf-8?B?eWVucTFiV2t1NlU1SFFvRFRRTXNxejNiMzEyaVhKWHZ2NmpOeGxXZjVlQTRY?=
 =?utf-8?B?QkpuMDZkdlNsT3R1aUM4Vnl1S29yRzluTTMvNFgzWFJycm9FTTJUZnFIb05o?=
 =?utf-8?B?QkpzaVpOYndsT3dkUGFnYW1tRTR6REMxWGhJeDdGblZFN2NYRjZwa3QrNjdD?=
 =?utf-8?B?VWpDc0o2M2tHeW9Rcll1N29vT2RaMHQ3ZVNGTHkwRjBkODJSaEdGVzErRFQ2?=
 =?utf-8?B?R0FHR1FtZko0SzJRNXdYOVJQNUtSaTFCYUZaMUNvMXZtL0ZNRzREQmhoT1hC?=
 =?utf-8?B?aE9nQTlZNGRQQm1CYlFTOFlkSDhUL3NhVFFkWEtZd1F6M2ZJeERkYXRMQnBD?=
 =?utf-8?B?Ym9QSEdoekN5d3JObjN6K0RGSkFlN2RRYXlDWnVoa21lNWI0STAvQmhhOWtF?=
 =?utf-8?B?RHlITk42SWY4NW1UQllkR2g3NGJFVHdhTzhrSklrOThCSUFMTzJSVlhmMFVm?=
 =?utf-8?B?NXpKZG0rcTlGamsxc1JqdG9NTW40T2NKemgrVmRqVW9RQnZTZnlNbE5PQ2N3?=
 =?utf-8?B?MlRYRnVxanVaZ0FrMVNFZFV4NjV2eFFDVXBTYjJBVUg4UW9UdlgrcnZ5WnM1?=
 =?utf-8?B?dEljOTYrWWdGOVJHWnFsTE9NTS83M2N6T0VKQSs5VlZUWnVEWkthaVA2OVNx?=
 =?utf-8?B?YnkwcDMwZVZ0R3ZMaTQ2Q2daQzVzNWpweDlLdlpTSlF4dThIaWNIOGgxMU5S?=
 =?utf-8?B?Rm5lYWZ5UmN5Uk5WNzQyV1ZaMjM5UWdrK1FaMDkwaTh6SnlLTDVEay9GRmll?=
 =?utf-8?B?bWR6WFlubXdXMzFqbWM5aTdSaktwM25vNWRXN3ZUUW1tK29rc1Z0eERNUlpB?=
 =?utf-8?B?ZTJxU1FNclowdGFjcXRTajdPaktyRmVRQW9yTFduSWplSm9YQ3hrdnprTjdB?=
 =?utf-8?B?azI0Tjd1dzg1S1dzTnBaMmlNN1J3MzJRUjY5cHlpU05ZUmRpd2YvN2xBS0Vl?=
 =?utf-8?B?MEMrRXI0OE9RYlRERS9OWis4ZFBhd1hYbUVXVm5QK2ZtMW16T1dHS2oxQVZQ?=
 =?utf-8?B?UVRpcUZxT1lKRVNjRThnNmVodWI2VURJdjZXT01sM2NzVnFJd3RoTndGUlpI?=
 =?utf-8?B?TURJSjUreUJYNW41R1lidFMyVzRORkNnUHZFWUd2ZE1TTk5zWlVYNmoxajhR?=
 =?utf-8?B?TE1lcEJiZFZIMFV2a003Vm5jRXlFWk9uM0V4NkhXaitKQ1hqc2x6bmhuaGJk?=
 =?utf-8?B?NjlHNjBqZ1ZLd08wQ2VPaktaNkR6cGo5ak9TWUEwNEpST3FMSjFaN3RuSHFW?=
 =?utf-8?B?V0sxSFBpcFk0ZU84NVdXUkFta09jcEVSdGZUMjkyUlBEb0UwT1hNNWxVTUZX?=
 =?utf-8?B?NmRIN2hZVnFQeEZDeFFoVjdXR0w0UkhGazczc291Ujd6V2JwUkFjNnRkS0Fn?=
 =?utf-8?B?S1FWTWFSa3pEV05ZYjI2S2x3bnFzTmpxTG5oUXg4ZGlQaE1ZeXkvYVVBd0E1?=
 =?utf-8?B?ZFlxOGZaeGxBdTRaRzJsaXN4VVBkMDI2cjJ1aGJoV081SWtRZVpZVnlmQkFv?=
 =?utf-8?B?RUU4dnNKTVJRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR18MB5285.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVhzS09PbUxwNnNtRWpnS0JOWFZuRzQrdGVGRkhFV3hsR2V0eFBXVG9lUk5L?=
 =?utf-8?B?NWxmZS9Ga3lta0R6TGNmS1lHL2J5RFNjSTlkcUNQK3paWGwrT1h6Sm02eTkv?=
 =?utf-8?B?cTFyalBkWEJTQS9WMU5UUGx1MlVVRVd6dGN4QWRNR21yOFUvTk4rdXNYV1J2?=
 =?utf-8?B?UmpnTTlEa0dKSXBVVHgyOGNKMHkwYUEwUlB2KzlEdXNmYmt3NFhyQlVQOXBT?=
 =?utf-8?B?RXRKWFRhUXFGTFBSTHc1cUtFdGhsSzkwMWZzWjNvcDkybjRzNGZwOGp5d21Q?=
 =?utf-8?B?azVjWU93QUlsRVNaNVRQcjA3SitYQjRsb0RCUW9PcSt5aG9ZT0pZZ2NuNGts?=
 =?utf-8?B?aTBGVFluRnE2Y1dHSmxXL1BqTTlKVnBzNzdLdDdPTlNHY0tnc3FCRGtMKzdk?=
 =?utf-8?B?OC9zQytzVUVGdlFDa08yelhxWi9wZTlRZ3hxTDVuQ1NNcEJQMi9YWUJjbk4z?=
 =?utf-8?B?TTdFamdDbDdFTWcrY3V3RUtXVjNjMGxuejJva01pZXV4bGtVU3JSWkE4MFYy?=
 =?utf-8?B?M3Noek16TW1SQlZxTEZhYkFWYXdXdGNwKzg4Z241d2JJRVowbldyeDQwejlE?=
 =?utf-8?B?N1IvZDRNeDNBM0d6OXgwRU9IZmdpWTRveERXUUhidGJQblZXUFNqS0VrYjFH?=
 =?utf-8?B?V3FQTk16cFI3QkFuNmJwR3loU1FOSG9Uc3RFdGI1V0x0cTRCbTE1TjJ2cUtp?=
 =?utf-8?B?OFVJbVFUNEpXUmhiTzBOQnhkaS93a3U4NTNRZUFNYlJNa3dsV1V0Zk80V2da?=
 =?utf-8?B?aEtiRmVsSFQ4NndqWFgvU2JSS3hMRTVsMTVSZ21INlBYUXd3dXR0VDA5L1Rz?=
 =?utf-8?B?NVMveldsOHNZdjAydHZmSndLbWhYakI4bldzdHNnNGEzSWJscmd3NS9wRFNC?=
 =?utf-8?B?Y2UvVngvblJXWVV5YjdoRTMwNlgwZUVyejhXMlJFaTRST3c1THhRRmxaaUNn?=
 =?utf-8?B?aE1Pdmw1ODEzcUxlQ2h3WGovc1g5UkZBdkdkd3MrVWYwQ0xrNldsU1pCV3Jx?=
 =?utf-8?B?Zi90b3A4b3FvSzdqZW5LSStsdlBNRHlFMFVLTnZjL0Y3c1ZEM1R5eFYxS1o2?=
 =?utf-8?B?eHFKMWplNzkzTndwZElrQVZ2OUNNeVlYYVl6T0NFVnBKY09NNkphb2d4Rmhn?=
 =?utf-8?B?TnY3UUFSMHNyRi9xMDY1b0ttV3RQbWxGSUpzYVRFUGNsQWtCZjkxL0hpckNU?=
 =?utf-8?B?NUlVeHl2eTV4bTBwc1hMS215OUVxQStXL2tCbjFMRUxQZVVoeGVyYXU1allP?=
 =?utf-8?B?NEhNMWNhdjFZaWQ4SEIzZktDT0k0Wm1rSTlSY3F1V3lqdVU0TStLdkRTVXlv?=
 =?utf-8?B?dHdLVkF4di93STBSclo1Um5qVXV2dmdsVExnamlNb3EvaGFnRFBBS1Y1S3c0?=
 =?utf-8?B?ckJQWEI5Qk52SmZHMFBTRHZSbmRmREF3a1U3aGxNeEV2UDhmdFJwcHdTbU1J?=
 =?utf-8?B?bGxqem1YZEozL2wwT21vVVpkWHBDamplU2NPbTczaXViT2Rhejg4Uml3Q3NC?=
 =?utf-8?B?dzJiZE8rWnZZV00zbUJBeFgyZHNsQ2NHOXlrN1lIbDNHVWRtZUdzTTMrTTNU?=
 =?utf-8?B?R2hsVHlMOUl2clJFcWNDU04wTFRRTkhqRFdLWWlMMSs0T2xFL2M4ODZjcTdm?=
 =?utf-8?B?SVkvUm1DK0JMaUw0UXprdElnblM4NGNRU1lrUVZ6ejhWS2krbWFqVDNBSFl0?=
 =?utf-8?B?T0s4NU5ObEpwSHBmZmpBWVdHTE1abWI1Q3cyb2JwWXYzaXdHTnJzZXhYVUlm?=
 =?utf-8?B?aUs5b1prMmJ2K1FQbEt0bWh3TXFwRGc1OHhJZTBLaG1DNHY2KzNoajF3WkIr?=
 =?utf-8?B?a3o1U3hzTUJGTzVqcjdzMVVzaExtMmkvM25VQ3VWekgyTzhRaHdscnJMTzR4?=
 =?utf-8?B?enpLUHJsZjN5bjF0aXYvbHVYV3VaMnBhSFdocEVVN2JQSTErcWdSQXZvRUZn?=
 =?utf-8?B?dzBSWldXcG1tNm01QnBrU0lTYTNueWd3WGE5THcydlRPSk9GZDBsa05EUEtC?=
 =?utf-8?B?UDZBek9Ucmo5YVZsTm5ZMWUvcnIvdkQyRGNqcHZibVAvZ245UC9PNEl4Ullw?=
 =?utf-8?B?QzB3dHpaVkV5SSt4akpCaFh5eDhiaDBTT0JCbkZLTDlnTUlieXZURUJXMlJh?=
 =?utf-8?Q?ADHIGdfUKYRYerRZgmU7/Ww7j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5285.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3608a100-2876-48f8-eaf2-08dd96c561b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 11:07:44.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2Jvmx86D9kpoVLhvYAPtyDDETkkZTzTFtM9V/YY6KgYmu3EXo2NIsf5ImZ17QYXMhhh0R9IDw73yRt1Nx7whw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5301
X-Proofpoint-ORIG-GUID: r346wpFjZpDn6ZdxXm4JJk7feiFmox2B
X-Proofpoint-GUID: r346wpFjZpDn6ZdxXm4JJk7feiFmox2B
X-Authority-Analysis: v=2.4 cv=Z7fsHGRA c=1 sm=1 tr=0 ts=682b1108 cx=c_pps a=u2H4imzVBiBAAVvoIH6jzw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=p3ayZ8-9JPDKol7EsbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEwNSBTYWx0ZWRfX/LCDWTYtbg0i mgwS3YK0YZeo3rJgx4l5mhoNhOg1gk/Br39EBeuPr0amd3DcJ0vHkJL5OwhqaK/Iyz7vbhB50gU UisbVEyGbVdUAFy/H60zTU0wByWtILoH3So6E8b1WgAM7wanFwG13tn1zjOZTP2Q8QPa5rgZXj5
 QBf9Jt1vLonXJOdD8sPGwU4s7jPb6kUDzaGROw4hrBZi3pzN4HHWyO52VWjnyivX6DGxzGrRyM7 EFYxBvY/iL4epxXYkVYb/ytDyDvK29h5SgHOimk+CTmjP0lCll5vqFG2kqmK0ZaxvnBwDTLJVPn 6NY235ngcucKv1zIj5Pdp6W9PN7BbOfFcHHwIKjw9z+z7fbwi42De37oNc5mmGvU8Ay6RL51gg5
 x5XLB4/rC32UpvkkXxPPEOhu1+DH3kgUPCoXeSg826f1Afffj89ZRmvVpLinM5ev5s2FWzlW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01

PiBUaGUgc2V0X3Jhd19pbmdyZXNzX3JlY29yZCgpIGNhbGxzIGFxX21zc19tZGlvX3dyaXRlKCkg
YnV0IGRvZXMgbm90IGNoZWNrIHRoZSByZXR1cm4gdmFsdWUuIEEgcHJvcGVyIGltcGxlbWVudGF0
aW9uIGNhbiBiZSBmb3VuZCBpbiBnZXRfcmF3X2luZ3Jlc3NfcmVjb3JkKCkuIEFkZCBlcnJvciBo
YW5kbGluZyBmb3IgYXFfbXNzX21kaW9fd3JpdGUoKS4gSWYgdGhlIHdyaXRlIGZhaWxzLCByZXR1
cm4gaW1tZWRpYXRlbHku4oCKDQo+IA0KPiBUaGUgc2V0X3Jhd19pbmdyZXNzX3JlY29yZCgpIGNh
bGxzIGFxX21zc19tZGlvX3dyaXRlKCkgYnV0IGRvZXMgbm90DQo+IGNoZWNrIHRoZSByZXR1cm4g
dmFsdWUuIEEgcHJvcGVyIGltcGxlbWVudGF0aW9uIGNhbiBiZSBmb3VuZCBpbg0KPiBnZXRfcmF3
X2luZ3Jlc3NfcmVjb3JkKCkuDQo+IA0KPiBBZGQgZXJyb3IgaGFuZGxpbmcgZm9yIGFxX21zc19t
ZGlvX3dyaXRlKCkuIElmIHRoZSB3cml0ZSBmYWlscywNCj4gcmV0dXJuIGltbWVkaWF0ZWx5Lg0K
DQpIaSBXZW50YW8sDQoNCmFxX21zc19tZGlvX3dyaXRlIGlzIHByYWN0aWNhbGx5IGFsd2F5cyBy
ZXR1cm5zIHN1Y2Nlc3MgYXMgb2YgdG9kYXkuDQoNClNvIGludHJvZHVjaW5nIHlvdXIgY2hhbmdl
IHdpdGhvdXQgYWN0dWFsbHkgbWFraW5nIGFxX21zc19tZGlvX3dyaXRlIGFuZCBhcV9tZGlvX3dy
aXRlX3dvcmQgcmV0dXJuaW5nIGVycm9yIGNvZGUgaXMgdXNlbGVzcyBJTUhPLg0KDQo+ICsJcmV0
ID0gYXFfbXNzX21kaW9fd3JpdGUoaHcsIE1ESU9fTU1EX1ZFTkQxLA0KPiArCQkJCU1TU19JTkdS
RVNTX0xVVF9BRERSX0NUTF9SRUdJU1RFUl9BRERSLA0KPiArCQkJCWx1dF9zZWxfcmVnLndvcmRf
MCk7DQo+ICsJaWYgKHVubGlrZWx5KHJldCkpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsJcmV0ID0g
YXFfbXNzX21kaW9fd3JpdGUoaHcsIE1ESU9fTU1EX1ZFTkQxLCBNU1NfSU5HUkVTU19MVVRfQ1RM
X1JFR0lTVEVSX0FERFIsDQo+ICsJCQkJbHV0X29wX3JlZy53b3JkXzApOw0KPiArCWlmICh1bmxp
a2VseShyZXQpKQ0KPiArCQlyZXR1cm4gcmV0Ow0KDQpZb3UgaW50cm9kdWNlIGNoZWNrcyBvbmx5
IGZvciB0aGUgdHdvIGxhc3Qgb3BlcmF0aW9ucywgYnV0IG5vdCBmb3IgbWFueSBvdGhlcnMgYWJv
dmUgdGhlbS4gQW55IHJlYXNvbiB0byBkbyBzbz8NCg0KT3ZlcmFsbCwgSSB0aGluayBpZiB5b3Ug
d2FudCB0byBpbXByb3ZlIGluIHRoaXMgZGlyZWN0aW9uOg0KMSkgd2Ugc2hvdWxkIHByb3BhZ2F0
ZSBlcnJvciBjb25kaXRpb25zIGZyb20gYXFfbWRpb193cml0ZV93b3JkDQoyKSBhbGwgaW5zdGFu
Y2VzIG9mIGFxX21zc19tZGlvX3dyaXRlIHNob3VsZCBoYXZlIGNoZWNrcyBmb3IgZXJyIGNvbmRp
dGlvbg0KMykgdGhpcyBpcyBub3QgYWN0dWFsbHkgYSBidWcsIGJ1dCBpbXByb3ZlbWVudCAtIHRo
ZXJlZm9yZSBtYWtlIHNlbnNlIHRvIHBvc3QgdGhpcyBpbnRvIG5ldC1uZXh0Lg0KDQpSZWdhcmRz
LA0KICAgSWdvcg0K

