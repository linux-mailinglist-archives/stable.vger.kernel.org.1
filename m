Return-Path: <stable+bounces-232356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLLtARoGzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EEE36EFD3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F0D3100DD0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1353016E3;
	Tue, 31 Mar 2026 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Im6GPjZY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA02F6591;
	Tue, 31 Mar 2026 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976537; cv=fail; b=JbTv6JxyVm395CPmtOGMF4G5knlRUuVmJGHqcJCY4ZbR94NFGQiraRqe6uv6cZtD7A4CdVVauK4O06n0ujKObKmKTuTEQOgv/D+egSiZklo1V1cpFq5qeZqkKP152WHMAmIc3u/R3bJfKUgaAwEyR5MZePw7NmIC45rn8HI9OYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976537; c=relaxed/simple;
	bh=VZ0GDvNEjMOmFTSrlVa6s70S2IXwEmwB6+rPVFhl9k8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=oNHwxsYHya0mQ8jsa0plU4CFwMBeXP4zBjeEiiwpT58AwzmiJyRa7NgxJTVp1EkUN4aQ6Bpzu+cW/S72IJTsD7FEVAFbQWsi/sKdtv58ewJwHQdOGHDDpwiXBuXCNffuCDDn/QPV4iUJBUudTF5JovHt+MOy7nomJV/4p4G0bzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Im6GPjZY; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V9NLF4207283;
	Tue, 31 Mar 2026 17:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=VZ0GDvNEjMOmFTSrlVa6s70S2IXwEmwB6+rPVFhl9k8=; b=Im6GPjZY
	krXgZIFhIMdOS80Xe2xQmYSjR5W4eQyy/C2pXG7/eVpA+LTTXbo9C9EHiObdA3YW
	AHl+cktspx4eEh+2AHNiEVpmyGa5Ct3/2vhgZNFEgMEppBm2TH5dcREnFQHOlQmz
	Y6hY2t334ASQlIiVUFUaQSOkUqQpSqa+ErJRPSly3yve2kmwjNupz/S3ijTDg4UR
	SqswfcBqHC1UX4YdqbVUZD4OuRI8abfSpwMhpEuFl6j93o6jp9oG1GCDdlxHedR0
	0mjSYc2eljdpuWciO9ef7crZMe+4AGSobpDr7SzGowr9IMhCS63CYUKFegOy1/+8
	AgKKwb4vCG/rFQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnmdre-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 17:02:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVMU1XEscSWKaCV4F7TEJYawb2Fmd0QJEaFUV8lWf4qaLa4xcDkFvpEchXoFMSNQMmJB6BumqmdrU+Z6mZGAHwaHIJObt2/TKNYA2pAp3gsJJnilXewSqKkoD8nJXHMt8qNDFHGh9a6aXYerX84f/TKdz6+TSrBqkpTRDm6znkhy1A6IsBVeCVzcF1E9Yi/UAuyDQ8Qr58sUmwV6cdhmJ6lL3LgbWTORlHzKEZzUDFmtqhS8hCAzqNRWnjw52B5XduVs7EsIEm17sHrM3509V0XLMp018pTJcjC/ijNKQEq/QrD0uORRJAVh2tYWFkuKavF4SxcPk3cVShyey2EVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ0GDvNEjMOmFTSrlVa6s70S2IXwEmwB6+rPVFhl9k8=;
 b=F7r9sjTXFs1fsS5EKRiWEy5UkarLPMQezESWnid6NWw2gCNKZK5rLKWPD9N5/0bvP+kfsQxFrGuJBhAIuJx2W5gRaivdu/+lmp8j+2jqLD2Rsm7T6NMtvhGDerssVrgWH0aUIpVvOY6tsEayzUJ4R1Yz5NIbTXI96es8MoztKJsqNDgpKSwz0V74Qjw9Kztc+egWM2W1jzxPrjEao5aPX40tqPF7cq95YkPLh+6h3tA2aS/XMkFAAuuK2uVHKDhtuzdLujSSD2kXbDvyE4VBoiyhoSP0MD3LfrREyJa02A/2++CWg6bXKFvauLs5x7wimejivuy+LEy9syqazy9KGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6529.namprd15.prod.outlook.com (2603:10b6:208:523::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 17:01:58 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 17:01:58 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  [PATCH] ceph: only d_add() negative dentries
 when they are unhashed
Thread-Index: AQHcwGczdLET/MkZjkWLja1B6qa1JLXI31oA
Date: Tue, 31 Mar 2026 17:01:57 +0000
Message-ID: <93e1f2a995ad4c8977e1519a542f9b7b58f47894.camel@ibm.com>
References: <20260327162308.1118621-1-max.kellermann@ionos.com>
		 <765945680a8b83b26148430752295deedea831e7.camel@ibm.com>
	 <f8c25bcd64be6fdaafd4e49507ea9e04110d56a5.camel@ibm.com>
In-Reply-To: <f8c25bcd64be6fdaafd4e49507ea9e04110d56a5.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6529:EE_
x-ms-office365-filtering-correlation-id: cd1d40f8-b2ba-497e-6a22-08de8f47381d
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 MD5CMByjV08v0gUnG3p2GhlDqpkQufvF2AsUxUaPboJFB4eVKpCIf8gitSKuG0c0rOYhQ3w2hpuHwf7upTkrRajtSR8X/ETh1e6Z765RXS7yMMycqZcbeIFK665Br6q44NP6fj2o7ppMsezH640r86aeemSxYFJswXuksD92JnmnmvotGHt382wdfo2/IEB3QFvXjD2xbSDGNPlYIUj/5ayLoBXLIEbBQMOAJl6qFIBZ9NaUpsV++ildPnwqT1+5f5SWDzN8PywM5blkdiAvR3iIRCyu6byEa21XlMpwVY21LaaRRV8QeqaLoU6qCWkORgBY/W6TrZb3jN2l0zM6PziBp82BUntOZvVlyoYkaHn+ZjuLLnIpm4lMr/03j34+dP1pdWqrGGpSW64wrdPzns439WD8Kt5TUweVS6Bj/Z+jZhkufMCRgwYZG6ZPIh/KKHaSMe6VLTUczGu+xlT43F1DXg2x4VdWB2iBp55W54fJraysiZvdMAmT3eLMk5Vmb9CIy6M7Nh6QtYf6Qcq3eqeaPW5OV6VPDg9EZ8ShVcTyvNI/0kJEvmugT6S3R1h3+PMinNv655iqTBi14XrbO/IpxULU11AR9ciY/C2Uwg3kL2GmDnLoWP/9p4TrDkwKYs3W1GOgOI5AxH8vEO1I1enPE9bcv/ApH1fWfSPYB9b3Z5qDF4/q/XRxJ3ocy0toBR+TPL4IWLwiV82cUdcebLqy+szDJG+yp/1zEH52atNZ9mD/lOMgrMIzzetjIkwFUAtG9Qh/+FH8HwAyfgOGoNdDHd8czyDAPeT0DXTwYag=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NENCS0dkQ3FQaGJEZnMxblJGTzRhUm5ydi9lT24yWjBIVlJtSENrWi9SZ2Fq?=
 =?utf-8?B?WlFKTWxpcUZ6cnZBblFIbE1hbnBXYTZHcFZTQ0hDdnlTeUNEOGVIeitTUTA1?=
 =?utf-8?B?VHpTN1pRZzAxU01xNm05QTkvWlJGQjRHbXpEVkxqbzZNWGdONDBLWS9OdWVn?=
 =?utf-8?B?c09sV3dwdUhueWF1VzREMk4xSHlPVGt5KzVRTHhvS1dGaFpCU2Z4TUNMM0tj?=
 =?utf-8?B?bERDTDZJKzdmRThWdjE1MjRsVTJDMHhpUWhaQ3paMGhpQm5MdG5QUS94d0VW?=
 =?utf-8?B?b3d0eVVYWHRCNTBxRVdXTWhPQ0ZIUWM0RFFQVWFnUzlwd1lhemYwNWxVNTZs?=
 =?utf-8?B?YkNhdU9lQTZGNlJyV3VjcEttckV4WEVrbWZMR0FJZ2RvWU8yRlZpMndlRHhw?=
 =?utf-8?B?cFB5QURIWHFmcFIzQWtzeXNGWkxOZUplOVNYZ2xMTDdOeVViSUNEcG9FNW1H?=
 =?utf-8?B?dnJpcFhkYXQyVXVoVGNwckFveVRqTTBxaHpYZ08xVS85YVE5VmVCbElZeDBU?=
 =?utf-8?B?NElNUUNMUVFuMFRka1FCMjZqbDh0aHNsazJVME5iVitoMFdCSXBJamtPNXdJ?=
 =?utf-8?B?YWYzZHc1bnBsTnI1U2FSSlUvbVlrU3p3ekZiMUQ4VmN3TlVwMDhCaDFYb3Qv?=
 =?utf-8?B?NGF1NDlOTStvTHFCRHBpa3BZelkzRGhuSUllaU5MeVNLRWg2aXQ5TzBpOUU2?=
 =?utf-8?B?WjJTaCtDNWNIWDAxYU1kNzJ0WnZ4VE9FRXgxRzlxNjNpTnBQaDRZd0F1T0Ez?=
 =?utf-8?B?bzBpVm1qUkltd1Jsc2x3aUFZRXppUXlKYlhtdlA4MHdXMHN2TXRLTkpxeENK?=
 =?utf-8?B?Z0VOUjBpenExTXpPN2UvWnhKU3NBVHNNNHdKeHZ2RXNkOHB6YzIzSTR3L25a?=
 =?utf-8?B?by80UDZwZ2tqeFRaMW9xK3NJcHZjajl3Y3o4czhiRGtVUjJsaE8zM3ZGV0ZJ?=
 =?utf-8?B?UVdpc3RKQmNDcXhldk9VNlhFUklXQWNuYmZiSlhic3ZVMGFVYjg2bTZzcHg3?=
 =?utf-8?B?MXpUVVlQOGkzazZRdGFoZGN2dHQybUtwdUt1K2lGM3htVzMrUHRGQTF1Uk1P?=
 =?utf-8?B?SGZpc0Q2OTR6RVpiTGFSR2F3QmFaY3FrU0tWWUJKWGdZa3NZS2hKNCs5MHN5?=
 =?utf-8?B?eGh5aE5RMjM2c1FCODNCd2tKcXBYalR1UThlQ1NtbnhJWnRmUlh1VENRa3I1?=
 =?utf-8?B?ZysxWGxVdHhmbUtpT25od0lBb0xCQ1Y5UlI1NXVFN01hMlRzQmY1cUFMeGhR?=
 =?utf-8?B?cklEU2tpbVl3cUliR1UrNFJzV0VNM1FNTkxFeVFqcG5IYWhuTW93TVRJQ3c3?=
 =?utf-8?B?ZFNobHpEcDBYU3h3Q1A4UkxycENTazF4U2hicXhVNDRZMVI2UjZXVGV1RzBB?=
 =?utf-8?B?cEIxamNGSERGdkdBUkdTaFNmTVROYTlFWWFDTFpJL1RyTWUzeUNteFhXeXVC?=
 =?utf-8?B?dFZqbnptNkVIOU90MVpKMFdnNEFKZ3FhRXducTViSkhLTTY4QmUvc0dJR0dR?=
 =?utf-8?B?em5OZStZUWJ1SlRBdk13Q01EeTUwdzFvMzhxUWJQVnBzdmYrTlpkZTFsZmlK?=
 =?utf-8?B?YTBMUlZRT09kWlloWWJoT2ZEYWNWQVYyTTdXd0VnY3RZT0h4eHYzeENzUW9o?=
 =?utf-8?B?ZnpjMzB1eVc0L0t3eVdWWHRqZk1VZDNnUG5tc05DdmkvcS9lY3BsNTRreHgy?=
 =?utf-8?B?S3plTTZGL3N0dXRDWG5VbTRaTGIxRS83Y01hSGl4UWoyb1ZVa2JZU0FRY2Jr?=
 =?utf-8?B?YTkzRVoxR0RhZWlzQTQwL3d4TktxY3c0ZDZKUjBxbzNzMmExOVpjcHNPeG5i?=
 =?utf-8?B?N0ZKNDEzbWNVdU0wdW9LZEVsRDQ2ZFZsUGdVODAyVmpDTXhIUEwrSU5qYXFP?=
 =?utf-8?B?SCs4VEt6V1pLa2szQjV2bCtzL1UxYmpjemVSUnkrMDhKbkIxRFpDcThGRWk1?=
 =?utf-8?B?UmRvNnU0ZENUOWdVS09vN2IzZUpKUEUyYWJHWTJDUkxzTVN6cFNQTFdtM3dX?=
 =?utf-8?B?NVJtamxZeW12VHBxZG12YXFCRGtJcmtrdE93V3crcS9jbXhoNjY5WFlqY0dp?=
 =?utf-8?B?ejl3aXo4UHdxQ2szMDR2ejNYWXJpQ3h4OEdpTHhHYVVHT21xVFhSdFBBVW1J?=
 =?utf-8?B?bk01R3NTbTBXaWVwUzBzRWV0WTBBZ0l5Z0g1YjFqK3Q0eDZhVm9zUldhYVdD?=
 =?utf-8?B?WjV6N2t1Q2JFVjNaSXluWHcxajM1eDBPd3RGNnU0QlhIRFlQR1RqRnY5ajJu?=
 =?utf-8?B?TC9zZC9FeUMvcmlJTHdvVEROMjB2UnlINzZMSWV0OHFuNExiRWR0MEhreXNw?=
 =?utf-8?B?eS9GdDNiUFc4clNzTEpJSHBkaU5jSmZ0L0dsc0wxYVpOOUc1L01EQmJyVE1W?=
 =?utf-8?Q?GbFbsu332txnobd7cAShYJx0wzoBxH7bqDocv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83FABBE1A13E654CA05BD276B67A2F49@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	KykG9mAf6vmmA4Ub3iCzCaAn/R69CPX+yfJUFCeOFYoFL9P9d8JqDjv99TsPITsWrOpGj8l1FfLUXXiQR7rt8JsozFrhvYdZ15R4ee2EfZExobONiG4csEp7c2ILmLl+r07+iEWIk0V832/1tQXAeHsyUSBfEsCu4FvBkVj2cdRK+MtsMaiM/YG4syiiqnOowNvFmQrRfg3S30tEVTFRpLDsxnq7jPvuE62ZEPzgrPwGspiow2iQSRBzlHCPCU6O8txnGUIf936pIVtSNjMusX5n2JvHsRokmddp+3gwdkxSCo6FdTnxnjuLTZE5R54xJQjfhLqEeoNgXlPYnj7l4w==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1d40f8-b2ba-497e-6a22-08de8f47381d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 17:01:57.9810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 87iIgVZGm2xvb11S1piTgJhGcDmJBTSJEXeXPsGKZyvDt2v6UalCqnM0P8qAE1NkXBZ/0SaxSQsheNdTTlNfPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6529
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: suoDja6jOPqfklQH2sc-1fd3oGs1aksB
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cbfe0d cx=c_pps
 a=dImUGf+04sfXZTE2vAy0Gw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=_1AO9TBkek7MWXjHW6MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2MCBTYWx0ZWRfX85ohSpamaka8
 tm+ePVCNrF4tgRPtBJk0cUdFi6d9Z4oNsCJpRrwxmkkSQFglIK3HqV2PTzTF7EMNyiTZ26JBlSX
 rBrtCBURgNicyu2rqTgwN1H0j/dJYt2qypnf5TfS55NEqhl8Wesy+RADXu/a6Eq2SQVD5rcB/9f
 +1q6DDOK4YrAA0ySEnFaEw1vtdRwHv5nxgXtXBnK0QCHdtddb3dLmxV7rG+MLi3KV+TwYqKRWCu
 CJ5fPaa9My9ewoGl7WMsDE1l//ViW6WiwD2o1lrPUCK1TQsGRUjycLbRM1lRPIrHV/4oTB7VixJ
 suEG7Ni78Wv1KNLKXukMbXmVmExIYzvwNVkrUBR2aO0vresYVX8kBT3chPT11nfiUjJ3yUb0Q6P
 tEG0WQhZOYtlDsNO7hLOKXtKrTxjFWfxn/xYqCYpBNBzpolj9R+p+S5LBzDu8ZsyEUp/5LHAeec
 mY/xFKzTxcUHwvuYvtw==
X-Proofpoint-ORIG-GUID: KVkgBykuDBpAo8NrT08agCBmtY6Ied3g
Subject: RE:  [PATCH] ceph: only d_add() negative dentries when they are
 unhashed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310160
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232356-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ionos.com,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 93EEE36EFD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE3OjA0ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIEZyaSwgMjAyNi0wMy0yNyBhdCAxODo0NCArMDAwMCwgVmlhY2hlc2xhdiBEdWJl
eWtvIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyNi0wMy0yNyBhdCAxNzoyMyArMDEwMCwgTWF4IEtl
bGxlcm1hbm4gd3JvdGU6DQo+ID4gPiANCg0KPHNraXBwZWQ+DQoNCj4gPiANCj4gPiBMZXQgbWUg
cnVuIHhmc3Rlc3RzIGZvciB0aGUgcGF0Y2ggdG8gZG91YmxlIGNoZWNrIHRoYXQgZXZlcnl0aGlu
ZyB3b3JrcyB3ZWxsLg0KPiA+IA0KPiANCj4gSSBoYWQgbXVsdGlwbGUgeGZzdGVzdHMgaXNzdWVz
IGR1cmluZyBsYXN0IHJ1bi4gTW9zdCBwcm9iYWJseSwgaXQgd2FzIHNvbWUNCj4gZ2xpdGNoIG9u
IG15IHNpZGUgb3IgaW5jb25zaXN0ZW50IGJ1aWxkLiBJIG5lZWQgdG8gcmVwZWF0IHRoZSB4ZnN0
ZXN0cyBydW4gd2l0aA0KPiB0aGUgcGF0Y2guDQo+IA0KDQpTb3JyeSwgaXQgbG9va3MgbGlrZSA3
LjAtcmM1IGhhcyBzb21lIGluY29uc2lzdGVudCBzdGF0ZS4gTGV0IG1lIHN3aXRjaCBvbiA3LjAt
DQpyYzEgYmVjYXVzZSBJIHdhcyBhYmxlIHRvIHJ1biB4ZnN0ZXN0cyBzdWNjZXNzZnVsbHkgYmVm
b3JlIG9uIDcuMC1yYzEuDQoNClRoYW5rcywNClNsYXZhLg0K

