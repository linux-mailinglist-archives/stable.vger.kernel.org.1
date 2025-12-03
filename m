Return-Path: <stable+bounces-199892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B0CA09D3
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB57F300AC58
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E554312820;
	Wed,  3 Dec 2025 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mA0pRbjd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s9aNIFZF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C3331218
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782583; cv=fail; b=IibFeaHaK5RWafOk26hp/qGlVyApLB7m1QZHwoUMJ3cLMAA19y7h6lwUpgufNsSdr4I/LdJ1+pys1ZISCyzsDQ6BeaRyp9kMW1RSeWyW+/RgRwjw6sMcZ7z39YwjD3aTv4XshdrueCObSuFlqLVVbzgFiFKmeN96ewVWKjZ4/nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782583; c=relaxed/simple;
	bh=hTSJl6ZBegq1MoYOwUqg/1nSOrZD5DMjrp1EW3G/ysY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jhsap3QHd+xEOurcPohsmfJXooELTz5rXB/PDwKANSzgTbOi+IuUltC1GazLgD+YZjyZR2UGjLCfjAS90jSqwQBQ+yWA75gUxWuHS5G72oTRnnilxkc1ht7lIHNjBp8VYcCg6v8NoumPoXthWJGatuNTGgzYqnmNpMVjm4bVTxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mA0pRbjd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s9aNIFZF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3F13G62926424;
	Wed, 3 Dec 2025 17:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hTSJl6ZBegq1MoYOwUqg/1nSOrZD5DMjrp1EW3G/ysY=; b=
	mA0pRbjd9kyrK1h6whZP2FJZtjzNY1fk7uR0bFRXby5t7k19iokDRrB6VP3Nw4Pk
	P3CJoN2gbDEXW4K4bEJdYF95c75SW1FlPxBlmZgGV5GYxh5jVCvOaeV7OKPFVUns
	U7Ni7ZQVVFXeq4yRkToUuHyvGmB4mYIwt+uSDaW8wnCmtZ2hnV6mvhUirchNOQnE
	LMdln8lS51Wo+OdOMnIO+Puzpxj19+tkr8bbKZpqpUjis3lQppbynoD97cv4qZm5
	AFskQ4DtgnNgiUpbd2KtJZWszaJB7ClfzxUUWtebuJfbfq2WydVk1SCfH35Sey+L
	DUQqVyt3oQU0UDbP8uDgdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7cp5udd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 17:22:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3GQ4Ea015061;
	Wed, 3 Dec 2025 17:22:18 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9ay3uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Dec 2025 17:22:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0+tq1BsGiNhUUIvBsFLazrBTGjFvkSv5gUaTS4WPJXaNqIdCm19knImsxP2a6x7kMvrBWyeghUfT4k2h9LyF07I7XB5qIx1d2/x/6GMhagiuhYjRV+Ii2K7QhLozWZLKeMzUGlXjKqVYKujDJnwK+EW0TGmsRTRHqofkxsC6oJmdVTHJ5JOXP4hGe/5RuHhpEB/oFbtZKDFIS44T4UnN9hxsKTKcvPwU5jE/gLcIGAmgs8NRj4y2AX/svnWO8VtBsUEDgXiS2I4ICc4a/JwpMwldp4eZSe/mpnR79WilA2ThcGg7/UtVFmMI9Lb/2rV3GeGDD6OTDzpW5OJGFn8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTSJl6ZBegq1MoYOwUqg/1nSOrZD5DMjrp1EW3G/ysY=;
 b=MwKNcCxZY/R7GhDgo+adsLcFKoG+bIbR6XGkWseUgfhQco/cCwv4PQvbMAFRFbtIMP/Kkpp9pCkP4EkgQzT73aBbSl4r/IdOrAkrrC5blUG7ZaDjhS7wUZCgh/58iPXVlkRdBnuuMA+fWCmpe+o5EkaqTrpYDp24p+C+v68lOAi5rj6Qo1wV+ngNUP18sw7abdoUFevgJ1D2IlLm6HAc+VDU//eq35Snbbjb6TyC9C8nnhII6oTN9Ck1/Ub64ugobTzjaZhwNlEwIUKGrDTlkW5SugoI4lxl7c9soZXVOEJ9E/dfpEB9pZ8TlORrCD/7mW7uKmzMFfgrSJOe+yEgOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTSJl6ZBegq1MoYOwUqg/1nSOrZD5DMjrp1EW3G/ysY=;
 b=s9aNIFZFF3mNhEL2aBL6DVoTDIHCwgrHZJ/gJGqimAea7UNoDkP4M3DCAb/DGMft8db0o51vvpwlDPDeazNw0eAVf0SGFWYkdEt9OaCvb4apq+s0tBI1KHaGCfUW4cXalfaMnn9CZG1RNBR3iWqGc4HlEhDm/R16jLLZJjOIzfE=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by DS4PPFF3A3AE169.namprd10.prod.outlook.com (2603:10b6:f:fc00::d59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 17:22:14 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%4]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 17:22:14 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Uschakow, Stanislav"
	<suschako@amazon.de>,
        Jann Horn <jannh@google.com>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Thread-Topic: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Thread-Index: AQHcWjT0tZf0cWosSkehWLbyj0E0c7UQPkUA
Date: Wed, 3 Dec 2025 17:22:14 +0000
Message-ID: <A8EA24F8-7A13-472A-9AB0-C7125205C3D3@oracle.com>
References:
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
 <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
 <CAG48ez0ubDysSygbKjUvjR2JU6_UmFJzzXtQfk0=zQeGMPwDEA@mail.gmail.com>
 <4ebbd082-86e3-4b86-bb01-6325f300fc9c@lucifer.local>
 <CAG48ez1JEerijaUxDRad6RkVm3TLm8bSuWGxQYs+fc_rsJDpAQ@mail.gmail.com>
 <2bff49c4-6292-446b-9cd4-1563358fe3b4@redhat.com>
 <0dabc80e-9c68-41be-b936-8c6e55582c79@lucifer.local>
 <944a09b0-77a6-40c9-8bea-d6b86a438d8a@kernel.org>
 <1d53ef79-c88c-4c5b-af82-1eb22306993b@lucifer.local>
 <968d5458-7d2b-4a8d-a2a6-0931cd87898f@kernel.org>
 <c798628d-9bce-4057-a515-8bc02457f370@kernel.org>
 <8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org>
In-Reply-To: <8cab934d-4a56-44aa-b641-bfd7e23bd673@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|DS4PPFF3A3AE169:EE_
x-ms-office365-filtering-correlation-id: dcdb9a92-7574-42f6-9062-08de32908096
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnRHRlp1VUJsMGJVYnZtdDhXU1FwT1ZSK2hkYzFIR3MxL1hkNWQycGgvQ1Bm?=
 =?utf-8?B?NmJRZ0xlNk9lYWtDRXhVcGNPZ2lEeHZ4TENEaXYzTmZzblovd3QyY1g1YXdi?=
 =?utf-8?B?L3hPVVVBL1RxU1dJbURBRmc1elF6clppOWpyTnRTUC9mS25JZCtHakx0Z29X?=
 =?utf-8?B?TmRoOTdZVzZtLy83SklRbXFzLzUrZWtQOGJncFVTd3VuWnVhUFJsaXQrUVVt?=
 =?utf-8?B?UitLeUhlZy9EQll3VWl4a0RRYjdtVzAvbldZYkJ2cDcxRkNrNHF0NDMxR3VH?=
 =?utf-8?B?d0tBV2hOODh4enduTWFmNURva0djbFhQdXh1VGNVUit5YkZEdXFFQTJhclNn?=
 =?utf-8?B?eW5kdkh2QkJUUGJ1T0Q5cHlDdFRZdEhkQ3RhMGF3RjR0NGszd3FHbUg2MnJq?=
 =?utf-8?B?MGdESmhLMWI3RVlBMjlIdWIwcmthVjBaRDhnR1Rjb2VYWVFoczJZekhkZzlQ?=
 =?utf-8?B?eUhONjRlZ0JQcURwL3l0emZWNlNXZW5TMGNxYUVMYm5jUi9rRUxoSlE1cWUr?=
 =?utf-8?B?bzNmQTgrT3VMOGw2emdYeWZoWjJWb2pudHpFWmxrNndROUpXK0RxZitGb1FZ?=
 =?utf-8?B?Y3ZoZnhOaWNSQTBqeDFydTFNVW4rU25DRVNYWXZCNloybnZtenVBQXVSSG4v?=
 =?utf-8?B?SEd0VDhJS3E4Q3lUdUs1Zytzem1ub2RCWEN5VlhEekhhcXdhUFhObFc2WmxJ?=
 =?utf-8?B?dU9nbHBJMEkwZWQ0cWhUdkZibzk1NDFmOUhUNFZZeG13L1lUY1NMM3pwRWFj?=
 =?utf-8?B?OXl6L2t3UTVkMG8xdUVkak42S1RwQkN1ZEtob0owQmdlZ1hwOGY2Z3drem9L?=
 =?utf-8?B?VmxMdE43bVRPQlZPU0NJd0lYenViL24wa3EyeVUxWFZGT3dIVndMNEEyeVFX?=
 =?utf-8?B?NGZ0NmQybEVzWGI5OGJ6bHhoOUtGZm5rcFNZSXZhcUVSNHZFWHZsZkUrVkpJ?=
 =?utf-8?B?K0c2bHdUVUt5eUVJOHdPWkVEM3U2TFQ2L1ZROC8zTnZEcFRONmd6UWNHcWhn?=
 =?utf-8?B?UUlmZzA5WmFzdmhnQjF0YmtiUVZHVldocG51WHBDQUorYldmM2Q2ZWJXQ0hX?=
 =?utf-8?B?S3hUb01FR3ZhSHBiNU9XSGE4ajZaL1NaSGVKT3ZwV0EvU0FyZ0tWV2tXamdO?=
 =?utf-8?B?cERUUjkrcjJNcHJZRmY5eGxsRURaclZVRUF1TjFsNGhUajhTYUtUQXRGOUVv?=
 =?utf-8?B?RWdkSGorWHJrY3Z5OEZwOW44WXVhem1xeTFxa3ZhNnE5ODZJSTN1b29sN0Q2?=
 =?utf-8?B?UVpPMUNoRDBQU3VoZklBcTkzdDVMbFpOc3Y3Wk9KSEpOb3dENEpJeXk5OXJk?=
 =?utf-8?B?N3FrNjJmOFlWZzdydmhNYUZEaS83OXgxdFBLNUcwekU1TmViUUJxOERqbHRW?=
 =?utf-8?B?MjQ2MVlUTTY1bWJLMlFtTzZrNGMvZGxzQmU1azFzdHd4NWhmZ3hpMjNXOWlk?=
 =?utf-8?B?RUsxWkcyZ0F4dEYxai90b2lKdDh3Y2UyTHVvMFB5SjJpK3NQKzhtRndDSVp0?=
 =?utf-8?B?YjZOZVFNOUdLVEY0cUFSUjZQangxOGR1d3JVRHhVYXRNY1BTR2ZiSHBjcWl1?=
 =?utf-8?B?RG5FTDU5RTIreFNHSnZHN2FUOUF3NG41UTg3OU5IMkp1WTV0amFtK3JBVFlp?=
 =?utf-8?B?cG5NRURGb0t3TGxGUG40SVFIQVh3azlPMlFITmp0Sk1sSkJMbTAvcVlPcXpL?=
 =?utf-8?B?K05aY3VsVlZzZE0xSHZUK0JJV25Ha1hzSCs1SHh5bExoSm5mSDdxdXpDckcy?=
 =?utf-8?B?dXEwaXNkQStuYmVocnZkVzc2eGgyUWQ3YjlaMWdEek5xYzQyZWx3c0JFYS9V?=
 =?utf-8?B?N1FOSERSQW0vQ2FWK2JVVkVyOWYzcjZCdTFEdmFPM0NkTzhJT3BOUVhsY055?=
 =?utf-8?B?NWZQTVVpOS9SWEZhTUhJQjZZeVpoV2JXSm1ITXlWSmExNkVaOGx1amVscE5z?=
 =?utf-8?B?a3RqVkpGb2djejZGbHpkREszSENVaHZZNHRpTUs1U3hQY2ltd0pHb1BubTZ4?=
 =?utf-8?B?WUNnSTZZOCtTUXFXeGNtU1hJcE9xN0tySlozWUx5WTgyQllQL3NRaTl4WUZK?=
 =?utf-8?Q?pJZ05e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d25rZDdtbG5RaTdyS2hxRFIwRzhVZ2tORUgxckRoVGJxM3p6S2NqRHFCaEVN?=
 =?utf-8?B?dE5mVk05NlFnSDNtaU12Qk9tUTl0WkhUMXU3R0F2MUlLRXF0UTBQZ2ZqVFJJ?=
 =?utf-8?B?N0E2eHNoWDZpbEhyOXdZZWhjZ21UT3RmbDF4ZTkxZW9XTENlWE5vVTk3MU9L?=
 =?utf-8?B?RGk2WW5VdlpmS1hPYmZJejFacDJnSitHVURGSXA0eVYxdXpSQnNWNXhzQmo3?=
 =?utf-8?B?aVNkamRpQm5ZU0VHSFZHMFdUQmU1ZlZsR2NYc3F5WVZJM3NiaW51dXJEcXlE?=
 =?utf-8?B?M3lKVmlhWXhyb24yQ2ZZQllyZi9USjREajVLN0M4RXZIVWU5WXMyZC8zT1Zy?=
 =?utf-8?B?VjBZZ3QzUjVsd3QvUFNjMThqbGFkc3A2dFBkbjFia1o1UThSSVZvN25HUTJ6?=
 =?utf-8?B?MG96aTgwTXo4QmJkdFRoKy9kMHZzcTFEeTZ0cUpVOVk0Z2lscmpGelFvQXdV?=
 =?utf-8?B?YmdnTjIwdGIxSGQzSGNuQWR2OTZZVkYrdGd3Zi9ZNkRSOERmRWUvVS9yUUZS?=
 =?utf-8?B?N1F4dExnR0JXL0tlWXA1L3NLeG5qcHd6c29aSHI5cFpMdHJUZG1Mc2dMQ2F3?=
 =?utf-8?B?Q0s1aWl0cHJYTjV1MDFMb2tzUnRGWkM0MUMvdDFpaEJkUjVMajh3R1lxNFFN?=
 =?utf-8?B?N2w3NVVENUVvVHFtclF5RTRlZGlDZVZzdElGZDE5ZGtjUm4vdjY1K2lBRTYw?=
 =?utf-8?B?aWRVTElSeGpEczdmZktKbXpQemtvaWluUCs0bDVZN25Lb0xibGRidGNXMDZJ?=
 =?utf-8?B?L21LY3JPVW5qY0NYOTdVSGw5alNUMytiajRXaTY0b0Vubi9oWTZiK3ZiZTZK?=
 =?utf-8?B?c0t1aHhWODdORWp1M21YYWxNSW5ET0NjQ241UzRCMGFiTVFnL1dGMlNvVFg1?=
 =?utf-8?B?ak95SVJUb2lPU1FZWUpxR2pIQW56c3VpeGl6bFJQanA3M3FMdXJZcDMwcUlY?=
 =?utf-8?B?OFMyTWIra0tWRWRwZ2ZES1VobDR1QXB1dmljY3lWVHM5SjZvdE9ZdEFYUjBG?=
 =?utf-8?B?VktnVWgwZEZSTXMyOUVuZkNUaFlCVnptUEJLRWJiR2YxNDNkVGZUVERSUXpw?=
 =?utf-8?B?RjJtYzZHWHRLbjVXcWJTckg0VTc0S1huN2NKSStqLzV3OHRscklibVZ6d1dr?=
 =?utf-8?B?dEFXSU5kZ25vVHFMUzE4bE15UjQzRlBoYlVaUC9YbG5oTzJ2VXdwczdFcHFS?=
 =?utf-8?B?d0F5RGNIY3BRQzdmQ3FtM2RzcDJuTTFJakVvSWptQWEvU2hlWVc4M0VobFFB?=
 =?utf-8?B?djBDSUVSNGxwVFljVktaSENPQ2kvQ1VSaURSUjFBMXJESVdWcFR6NHlMMWNw?=
 =?utf-8?B?ZjdUdnowMDJBQlJFRW5jbkF6UXhPTDVoaWRVMmpBNStuS3RGa3dMNktUNHFh?=
 =?utf-8?B?U2NnampYQ29icXdsOFgwZytaMWxwR3I0cFFRSUdJZS9jVk5tMVk0U3BEV0Jq?=
 =?utf-8?B?UjdBckprek5EUDI5bEJybnhPRWFWR1g0KzlkWk96YzhpeVd4MGFaYWJaNlBh?=
 =?utf-8?B?cXhmbnZvZCs4cFF3TVdpcXd3amU3SjZJaXFHb0ZDdmh1ejdXdVJqNUorK0dC?=
 =?utf-8?B?dnd6L1JuL3F0eXJVL29aR011UmduQ1RUbHFzOStTMHVYVE9RZHZsY2dHcVl0?=
 =?utf-8?B?aUU1aVlFODJxRlNoUDVWajZqL05OSkJnYkZkU3p2amxEL0wycEg1RE1oVUdn?=
 =?utf-8?B?c205RG1FVGpxM1BFYzN4eWdQZkl0Q0tGdnQ2K3orM1hjeWJQMmxFUlVKSnFN?=
 =?utf-8?B?UHJ2UVI5WnRIRjkvNDZaNzlSb0tIVmNWdUpCbVJKOVZBd2R6eXVIK0V4WVZq?=
 =?utf-8?B?NDh0b2RPWXZ4cG1QR00zVlA5U2lVVTROWWZjNi9ZM2ZCSVlZVkgxYU00Ym1T?=
 =?utf-8?B?cWN1a21GZ3dtREFYbHlOUVpOZllNM3cyNEVtVjVaaTVuT25RY3hkQktiUmYv?=
 =?utf-8?B?Z05FYjZwTldoUDRKRG1MWWYrRHNWWDJKcmhoMnFEUHZJbElVQlJuNkp1YXJp?=
 =?utf-8?B?b0VjRTRmQUNSU1FWeENLRzVjOTdGTndPbUJXdVk0cTNWdWhNSnM2N1dEQ2Zu?=
 =?utf-8?B?cS8xdzVVSVFEN2lsaTJQczlObk1uQ3lrdDJzcnV1bUhrMTNoS2IvZWFaRHBO?=
 =?utf-8?B?dzFSVGhuZHRHY0FiZWd0Qkx3M1crRzZJcXlaSkJOVkd4VUMvSGI5cmNHamF6?=
 =?utf-8?Q?l944pH8205v5lYwKlo2z75k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <813B521A89BAB245AC2F4AC3DA92EAFA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nj/4bYbardE8DIeuoJ8aoF75OTdwrqlFqXCTKXy6Hr0ohNciLaLReXJr/zKHUgJAyY8dDyxrKR9OBjnuZJizsO7UvnkR3y0mgsli41V73AJ3xi9okIJHQu1HFewiukLQFnAeR46o0ASvBDQobnW1n57hHPbR5VzAfaUkY3XYD2FcJyGSz9vbSgESan7gJ+HSC2gB4ZlN7cAMbJ0kk1geHZo4ZuYVRahxzGgxE+7mDo/LIhK6faC4mZeZzUnpeuLLeqM2u3VGrIGViY6mlnf3oClMQvapCfoNgxfLTzUEr8LE726I+T+OYY+ChWtdWJ56b1s5AQuhAMavgMNTkHManv74I8YXlPN4zTgbm9xGd/Wgft37RykLvQXElNKT6xgNk8pklikc0RIuwhkC85O/xBwT8zY+1dVIX+oOmsalf5lGFTnLFS4ldN/f5X5MUJqhvvs9aJtF18TfA1eO5/W8CAVfAJ1d2vfxtGDbR7jLPO7t/AIUjrQg4iioSd7AUilvfIlMeYS2zHvcWdh83dUVTlqFM61B0qpIPbp3FUvoj4XWUNCBUHXLoLkRNs8Wfy5y30jAfnJGC8exiBPgb/d8/uA1KpchEpD4yaZu993byls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdb9a92-7574-42f6-9062-08de32908096
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 17:22:14.6805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fnxTDaNgqhMkrIBaoUBmG9iXuc4MagEAq1+e2mZOs/simVWN04lNMrhKQHLYB5jm4tBbydZ+TA3f4xE8CgatjVRCdq73SZVkEpNuyzL3u0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF3A3AE169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030137
X-Authority-Analysis: v=2.4 cv=ZfgQ98VA c=1 sm=1 tr=0 ts=693071cb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=H2WPMUUn1ZpGZywV-xsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MzzctsTak40O9-pnYtB6lxEJ3p65rTWk
X-Proofpoint-GUID: MzzctsTak40O9-pnYtB6lxEJ3p65rTWk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDEzNyBTYWx0ZWRfXy0R+r5pa9MJk
 9AUTrEgeAThfm1ubUCyNRde7jT2VPiTkxwC7GVKebp5pdiXaRm40Y7RjsFUub4ZjxqkVc2eD3PP
 K73RQRCdZn/S2w92N09N+QchFXZwGip03W8FuFxhO95miyh4bgUv+M4pMiGsVKRaOIVwYZQOjjo
 Y3RUhjkhlS9CYLEZrSPepGbNWnbEXhwH0mMyDQvZkOGKr8lPOfVpjUDcb8E1jCtriBUCrwBLjOA
 o1snV6TK60dZVzGGf5uZsflVjgCbtaBnKMpqQlLAPENP5cjqlDRUVtZjO1j1nv9CRe99oj/mraD
 FqIw/w4seanAJypLUgX3FO7JdavRcavu3NVvEJzD3rGSyerYy5dIq048Q2GQjY8NicVvVkifErO
 M5CPMwHJUl6SwcrzutNKJYIIIwQ4xA==

DQoNCj4gT24gTm92IDIwLCAyMDI1LCBhdCA3OjQ34oCvQU0sIERhdmlkIEhpbGRlbmJyYW5kIChS
ZWQgSGF0KSA8ZGF2aWRAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiAxMS8xOS8yNSAxNzoz
MSwgRGF2aWQgSGlsZGVuYnJhbmQgKFJlZCBIYXQpIHdyb3RlOg0KPj4gT24gMTkuMTEuMjUgMTc6
MjksIERhdmlkIEhpbGRlbmJyYW5kIChSZWQgSGF0KSB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gU28g
d2hhdCBJIGFtIGN1cnJlbnRseSBsb29raW5nIGludG8gaXMgc2ltcGx5IHJlZHVjaW5nIChiYXRj
aGluZykgdGhlIG51bWJlcg0KPj4+Pj4gb2YgSVBJcy4NCj4+Pj4gDQo+Pj4+IEFzIGluIHRoZSBJ
UElzIHdlIGFyZSBub3cgZ2VuZXJhdGluZyBpbiB0bGJfcmVtb3ZlX3RhYmxlX3N5bmNfb25lKCk/
DQo+Pj4+IA0KPj4+PiBPciBzb21ldGhpbmcgZWxzZT8NCj4+PiANCj4+PiBZZXMsIGZvciBub3cu
IEknbSBlc3NlbnRpYWxseSByZWR1Y2luZyB0aGUgbnVtYmVyIG9mDQo+Pj4gdGxiX3JlbW92ZV90
YWJsZV9zeW5jX29uZSgpIGNhbGxzLg0KPj4+IA0KPj4+PiANCj4+Pj4gQXMgdGhpcyBidWcgaXMg
b25seSBhbiBpc3N1ZSB3aGVuIHdlIGRvbid0IHVzZSBJUElzIGZvciBwZ3RhYmxlIGZyZWVpbmcg
cmlnaHQNCj4+Pj4gKGUuZy4gQ09ORklHX01NVV9HQVRIRVJfUkNVX1RBQkxFX0ZSRUUgaXMgc2V0
KSwgYXMgb3RoZXJ3aXNlDQo+Pj4+IHRsYl9yZW1vdmVfdGFibGVfc3luY19vbmUoKSBpcyBhIG5v
LW9wPw0KPj4+IA0KPj4+IFJpZ2h0LiBCdXQgaXQncyBzdGlsbCBjb25mdXNpbmc6IEkgdGhpbmsg
Zm9yIHBhZ2UgdGFibGUgdW5zaGFyaW5nIHdlDQo+Pj4gYWx3YXlzIG5lZWQgYW4gSVBJIG9uZSB3
YXkgb3IgdGhlIG90aGVyIHRvIG1ha2Ugc3VyZSBHVVAtZmFzdCB3YXMgY2FsbGVkLg0KPj4+IA0K
Pj4+IEF0IGxlYXN0IGZvciBwcmV2ZW50aW5nIHRoYXQgYW55Ym9keSB3b3VsZCBiZSBhYmxlIHRv
IHJldXNlIHRoZSBwYWdlDQo+Pj4gdGFibGUgaW4gdGhlIG1lYW50aW1lLg0KPj4+IA0KPj4+IFRo
YXQgaXMgZWl0aGVyOg0KPj4+IA0KPj4+IChhKSBUaGUgVExCIHNob290ZG93biBpbXBsaWVkIGFu
IElQSQ0KPj4+IA0KPj4+IChiKSBXZSBtYW51YWxseSBzZW5kIG9uZQ0KPj4+IA0KPj4+IEJ1dCB0
aGF0J3Mgd2hlcmUgaXQgZ2V0cyBjb25mdXNpbmc6IG5vd2FkYXlzIHg4NiBhbHNvIHNlbGVjdHMN
Cj4+PiBNTVVfR0FUSEVSX1JDVV9UQUJMRV9GUkVFLCBtZWFuaW5nIHdlIHdvdWxkIGdldCBhIGRv
dWJsZSBJUEk/DQo+Pj4gDQo+Pj4gVGhpcyBpcyBzbyBjb21wbGljYXRlZCwgc28gSSBtaWdodCBi
ZSBtaXNzaW5nIHNvbWV0aGluZy4NCj4+PiANCj4+PiBCdXQgaXQncyB0aGUgc2FtZSBiZWhhdmlv
ciB3ZSBoYXZlIGluIGNvbGxhcHNlX2h1Z2VfcGFnZSgpIHdoZXJlIHdlIGZpcnN0DQo+PiAuLi4g
Zmx1c2ggYW5kIHRoZW4gY2FsbCB0bGJfcmVtb3ZlX3RhYmxlX3N5bmNfb25lKCkuDQo+IA0KPiBP
a2F5LCBJIHB1c2hlZCBzb21ldGhpbmcgdG8NCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9kYXZp
ZGhpbGRlbmJyYW5kL2xpbnV4LmdpdCBodWdldGxiX3Vuc2hhcmUNCg0KRm9yIHRlc3RpbmcgaGFk
IHRvIGJhY2twb3J0IHRoZSBmaXggdG8gdjUuMTUuIFVzZWQgdG9wIDggY29tbWl0cyBmcm9tIHRo
ZSBhYm92ZSB0cmVlLg0KdjUuMTUga2VybmVsIGRvZXMgbm90IGhhdmUgcHRkZXNjIGFuZCBodWdl
dGxiIHZtYSBsb2NraW5nLg0KDQpXaXRoIHRoYXQgY2hhbmdlLCBvdXIgREIgdGVhbSBoYXMgdmVy
aWZpZWQgdGhhdCBpdCBmaXhlcyB0aGUgcmVncmVzc2lvbi4NCg0KV2lsbCB5b3UgcHVzaCB0aGlz
IGZpeCB0byBMVFMgdHJlZXMgYWZ0ZXIgaXQgaXMgcmV2aWV3ZWQgYW5kIG1lcmdlZD8NCg0KVGhh
bmtzLA0KLVByYWthc2gNCg0KPiANCj4gSSBkaWQgYSBxdWljayB0ZXN0IGFuZCBteSBob3VzZSBk
aWQgbm90IGJ1cm4gZG93bi4gQnV0IEkgZG9uJ3QgaGF2ZSBhIGJlZWZ5IG1hY2hpbmUgdG8gcmVh
bGx5IHN0cmVzcytiZW5jaG1hcmsgUE1EIHRhYmxlIHVuc2hhcmluZy4NCj4gDQo+IENvdWxkIG9u
ZSBvZiB0aGUgb3JpZ2luYWwgcmVwb3J0ZXJzIChTdGFuaXNsYXY/IFByYWthc2g/KSB0cnkgaXQg
b3V0IHRvIHNlZSBpZiB0aGF0IHdvdWxkIGhlbHAgZml4IHRoZSByZWdyZXNzaW9uIG9yIGlmIGl0
IHdvdWxkIGJlIGEgZGVhZCBlbmQ/DQo+IA0KPiAtLSANCj4gQ2hlZXJzDQo+IA0KPiBEYXZpZA0K
DQo=

