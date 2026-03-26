Return-Path: <stable+bounces-230445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LWpKRH/xGny5QQAu9opvQ
	(envelope-from <stable+bounces-230445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 10:40:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B94B332754
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 10:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D41AE304C715
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984B934751C;
	Thu, 26 Mar 2026 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="YEyslCU8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AFD2D948D;
	Thu, 26 Mar 2026 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517964; cv=fail; b=jQWxWLi8b4wnt1VrmE6IraNiE+BNtriPJtUFxqZ3cHnRRX0IRuqs5W440IQUi3WMIoC3WvlkGXJuNHb4jh+XvX0zDV6pYDuAikQRB90s9mNuR0mpwwpkCz0EjurYYOMkUCcIPIpQpUofy8hFKX9MQpXzHZxYAGySsYjgzO0xU6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517964; c=relaxed/simple;
	bh=vkqNF1hkWItzGi15I+z84QFStroBT89UrAHiXjYeWUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jiY9VDcT/dXUShe7xcLw0nz33T0ef1GpWW0Nj0DVTMq639tOloO6epbgLjtxcv2L+9N3goykqa8OwIJD+4E8tj2VhWA5AOSPgSXsa8E17BMiMguh9ChiM7WyNO6JqoO+WSp8a3mATSW5X9KI/B5w50FoDvDN2PshLLtDsF2w/uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=YEyslCU8; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q8B5G81550715;
	Thu, 26 Mar 2026 09:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=u1aNVdR+A71O/0kxmvzC7z
	YWwz+0JUTnD5ePDJnFwHw=; b=YEyslCU8lLyjlVjqiFBPFLqZP93Xj5cOYt4Z4C
	LJgznI/r2B+5RNNov2sbbLs16UpWjiLJ86w+fGfjmXmVLHabObA5Fm+ocwB0YXe5
	MdvQcqdw+68qav8IkN7SS4uKeYBXdxOaQjbL/m1i6rNOhl+d3BQHUU1bY3vTZhRr
	RzRb0weDuhms77fV2PsfQG+PLgOf2P48EvI0BaEc3YGySy7dfZH7Qn0R2JIAM/RP
	se/5+IcpLjqPYA3DUygY8mESMWYKKGl4nWvd30ny3IOMoDbKH25p4oJfDP+P87is
	Cy7gmHc2tTe41fDyuPqxzplMiVvNP8TLhxUhAlTw/jWLr2uA==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4d1kuy40k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 09:38:57 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62Q9Ytig031819;
	Thu, 26 Mar 2026 05:38:57 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.201])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 4d1pnudffx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 05:38:56 -0400 (EDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 26 Mar 2026 02:38:56 -0700
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 26 Mar 2026 04:38:56 -0500
Received: from CO1PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 26 Mar 2026 02:38:55 -0700
Received: from CH2PR17MB3797.namprd17.prod.outlook.com (2603:10b6:610:80::18)
 by DM4PR17MB6295.namprd17.prod.outlook.com (2603:10b6:8:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 09:38:52 +0000
Received: from CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2]) by CH2PR17MB3797.namprd17.prod.outlook.com
 ([fe80::cf6d:89de:646d:d1a2%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 09:38:52 +0000
From: "Boone, Max" <mboone@akamai.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org>,
        "David
 Hildenbrand" <david@kernel.org>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R.
 Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal
 Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v2] mm/pagewalk: fix race between concurrent split and
 refault
Thread-Topic: [PATCH v2] mm/pagewalk: fix race between concurrent split and
 refault
Thread-Index: AQHcvD4QPlVX6dffc0+pYq6SVAIeIbW//H0AgACTsQA=
Date: Thu, 26 Mar 2026 09:38:52 +0000
Message-ID: <55B8AF8A-2A22-4250-A9BF-85434BF28858@akamai.com>
References: <20260325-pagewalk-check-pmd-refault-v2-1-707bff33bc60@akamai.com>
 <20260325175006.1c3cae2ee50dd491a153226e@linux-foundation.org>
In-Reply-To: <20260325175006.1c3cae2ee50dd491a153226e@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR17MB3797:EE_|DM4PR17MB6295:EE_
x-ms-office365-filtering-correlation-id: 5b44fee7-ff46-4287-b1fe-08de8b1b7ddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|6049299003|1800799024|376014|7416014|4053099003|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: QPu33PlANBVCgBOqel1Bv+cfhBCu9msaa/rm5fwqmRF5PKEAMJ4TeojsnGh3Lpnlk2GnjzdHnPCiz7nIY3Jxl6sJKTvvn3hXxH4EjtcxyUh0tXAz2ZCPbUbsKNnNxWIv9/M3dw9QnMmx7tdnrCqBXqXieMCoswMCdi5CZU9f/CzxIuFRIrRGjpyq1UdL3Q0dnMtyoojw2tpIu/V2QTCaAAZnQgshLNwh/uFJeS8dD425h1ISjHTCS8P/htd9PWZY/R4dEVwC7zeqo+8rqaTyiaGQSzouPxzbFb0qKB2FuwZU1gKlkynefRhFPd4DfAMkC6bMaiATXGQSjqXvIjqQ3kCAwt9YB8bdqzbu/y1jJnhA/rUeSfvM57rInDA+3LskB7Q0jFngn6CpB6BKCPW9cHJzV/d4vZQoEoVhZWgJ9oPvuvwFOfhQVVDH59muzVDFe5+EKxaBmeuzh3z/1olrLN9GV8Hg87zaZSXYIhTH0mmC9ojUKYTwgF6l+G7R2gwA/SFkRYYuGoKMzO8KdgaTUUywDG3mH1uY41NEFh/lcV2wLBwsas0v9+dil1S4qTj7wdOsguX72Skm3IwUvoYVt/ua9vP7sesfqcXKSGORuHzVEmL9dignk47MMA//V+LvaoY53QYdPKoE2IsyH0UyzVGvnBj448Dkc7ONvof+Oe1H0CmpY7MtQ00s4CO5U3w2aJDbnbOpuoBNReRagKR11KcVlIWbzvrRPUsZJGbvXwM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR17MB3797.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(6049299003)(1800799024)(376014)(7416014)(4053099003)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFNlT1FMZjhSTW4xZmN0S0VxdVRidVlOZmxxN1o4bHlEMlpaeVhqR2FVeHR3?=
 =?utf-8?B?ZVBSZWpwWE9OTlloZXRLMTUrZXIvRXNGQ1Y2UmtVcEF2TjBVRWI3bEsxekJp?=
 =?utf-8?B?N1ZraU15NTg3TG5NTkVxb2tTclRNVHVONFpVaThsK1cwZFVVQnJGOEM3b3Jq?=
 =?utf-8?B?ZzBqQ1ZsR21wK0N5bEw2N2hLM21PNFVTekNOTUlTNll2UGVoS3YzbnhNZXNC?=
 =?utf-8?B?V29DcnA1R0c2d0FQeEdNMUFuSFF6L1ZnUmhNMWhuYnVELzVqTXFLaHg5WkQ2?=
 =?utf-8?B?WE5POGNSM2p2aEpKMENPeFNuZm9YcnhNd0Y1dkNjNjU2NTEzcEZiOTl2YW5X?=
 =?utf-8?B?ZXNiUUFUMnZTYllkVGI0RnFjbjhXL1FGanlwQXFDUEJsSWM5SHRRZHlJZ3ZQ?=
 =?utf-8?B?ZEVCT0ZYRHZaajdQUDZhSHNyeWVyRDFwMy9QZnl0WlhkTTBTaDZuYWdVV1FD?=
 =?utf-8?B?ZGJtNnU0d1JIYU9iZFJCMTQ1NHNseGNpZFMzWGg3UzNrVUpPWXZTUlRBQ0wy?=
 =?utf-8?B?eFpuOVg3c3hZa0NodDdtajNlbGFJVzFKem5ET0hNYUVIbUR4RFFiV1pKVGN6?=
 =?utf-8?B?Q24xOGtCVkYxL0Urajk5RDdiK3k5b1liZ25tc21BR0IyNUhIOG9yRTRBRnJE?=
 =?utf-8?B?TkFGZDd3cmViT3lZa2ZrODJHMEVRa01wL3FoZWVJa3MwNi9HQWhEOGFkZGh2?=
 =?utf-8?B?YTFIcE1jMzhUdDdaa0x3MG5VR0FwL1MvMVl4TkRRRkUrUDBsUU9weE1oSVdI?=
 =?utf-8?B?ZStsSVZ3R1Z5cUlxMmFUdVkxV1J2V0VHMkpQSVM4by84cDdJWG1ybnA2L3hC?=
 =?utf-8?B?emJjTTJXOVdaclBuV1pKUHlVeTBOb0FjbDhyVWVOTERhS0ovMDJ6RnNCZTYx?=
 =?utf-8?B?UThMcEFOYnJKWGVROWkwQlloQUNMd2Zxb1UxL0tQZ3QxU0NPMWo1MUVIR0VI?=
 =?utf-8?B?L1pNYXA4YlFCaytZeUw1Y0RKWjg3ZFhVR205eUhqUlJWVWpka1JVcWVOWEsy?=
 =?utf-8?B?MEZ5dzNUc1orR3czdlAxaVZ3K0IvT2xES0ZPckxyT1J0ZWxZMFFRU0dUQkhz?=
 =?utf-8?B?YW9xa2hEZkdJR1lqbmpxS2tlczdZQ0Z1YU9ndVd4SlRkTCtmWTZjT3RUd29V?=
 =?utf-8?B?Y1dVLy9rUVh0aVVIN3F3azcvZUF1MFl1NjNPakxMQXkzZ3VBWDBXUVZsbytC?=
 =?utf-8?B?Wkt5dGIxTWZJV0JkTFpiN1dJM2JvYWtvZEtTeEl0Yk5xNnlNUEVOZlFWaUh2?=
 =?utf-8?B?YldneFVucmtwYUZrNThua1N1YjlSTlc0ek1WTGI0S0ZnYlREdGYwR3U5K3pM?=
 =?utf-8?B?S3NyN0JrVGRGaDlQQzI0a0drZTNNVkZxMzlFVFBMVklDMTI5anA5OVpyeE9a?=
 =?utf-8?B?cWx0R2hHN3hpeXlMVDYreDRteEZvVWNVMm5sc09UNkx5akJ5VWpmblJ1T2F5?=
 =?utf-8?B?Q3F6Szg2NmRPeFFHa29NRmtJVG04d2tycmhqN0JNY0RzSzVvVkJXalNDdkgr?=
 =?utf-8?B?TG81TjNBUjFuK3hXT3RMZ2JEanZRR3h2VlFRNWJNN0JvQ0UxbzJhT1BHam5Z?=
 =?utf-8?B?RVFaMlYyc1A2M1ZXMTMvVVNRV2xETWluOXVvNmtGQ1hwWmpoa0xzU1pxSmtS?=
 =?utf-8?B?Q2R2Y21keGdNOElzSFdrU3VpdjBmSjVGRzIxQnBIKys2YXhPZ09wMnluY1cr?=
 =?utf-8?B?Z05sU0htTFFyT0R0VkoxWHRGYVlYbHBMa2dSTW90MitTbGpoTllCSXRxcFY4?=
 =?utf-8?B?b2Y5a1RpTitjclMvcHlIN0xKR0kxZXhvb0tEWVZwT3VoYkxuVFRFT201RUNr?=
 =?utf-8?B?M29uYWdXdFhrYzFCb2JzWlE5NGhlY3A1SHBWWUEwUHpHNit1S1FoUmxaQ2FP?=
 =?utf-8?B?byt3VS95WUUwc2xiUmg2bWt0bmRGOUhxdnpzMXJlWTZRWEJ2T216dUxOUDdk?=
 =?utf-8?B?QnFGQS9JMHhCdG5EbnJFblNqOFJBeFh6dlRESmE5MmZhVEpEMlNYQVdLL3hl?=
 =?utf-8?B?VW5Fa2Fud3dMSDJmZW8wWS9aSHkvOHM5cUU4SThjKzZ3dDdxeWFBa0ZDaUFW?=
 =?utf-8?B?UlMxeTFua0xYK2VkbFBGNXBJTCs5SS91S0d3YWJuRlZwTS9hcmc1WjU0eGxt?=
 =?utf-8?B?MkRhT1VSYmRuZ2JkYXlOVUxpa0dYMnZ5eXRrbUhRU3VHaTNZSzZGMFI4bUtB?=
 =?utf-8?B?VzMxSzVDRDZKcWVJR3FvcjRYbFhZenJPUXJVT3NjRjROZUtzRVZLb2ppcXRO?=
 =?utf-8?B?QzlBalRGZDZxeWovUHhnZmdJb2NYb0p2SEJ0aU9aMnRQb0pZNWFMcVErK2xT?=
 =?utf-8?B?TzZaZG5FdUxGZzRaRm5EZFFZaFo3SEI3ZXV0dWg5bTVQYkpUY25LUT09?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBKoa9s/SQHwekyxuPDcIeGAjq6U96IQQvSdZN6P3KIl+/w5m0FgI9bXeyYuzhEbJ4o90eNJ2RuPnlBpqvj/nsnwBN9lOHco2rlSkSe6/c+gr04QBanxbXY0hefTo7YD7H3cbd7pMV+diLQW5ryTP0KZqaK1gQxhRtw2NH9G6xq/cata3CB87/ZERLTnYijKO1s4i4Bo+Im5ENdfpr7f+w79JVZdp2mgmXnsy5n6E5Snrp/BKAOX7OX8vllNGseMEZf8EP1VSL5VkF8QNapmBtRV2VB8Js9OykRszL+2Eie5Q1K+jaKY6xAOTVE58uvYNqlZWbeY4O5DvIV5gA/YSg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgnVnbHhnpLcp17ckfNBTeRe3lYY8Pi0Sy3fFWwxzQ8=;
 b=j1KIKSKI5kAAEhkJOU0GgS49jqP6G0q3k/96QlLsvUgSVUVVkcXawtv9Kx44k9XPe2uF+wfLh+PDHGFEvQ7zkBKNcNcBgNtfDOBSfWnJexcSNFaYNgw4hGpNXNzNeum8ppX07qgGDn43XlcnI2l4IjNcn3ZCN6aTX0KhmQIm0yhpsWvcaOCaFkYQIdTeqYBLiUgfUXBXFl7F+eu7xfdN3+Zod5qTygEM8L5crGq/kZnYGoU8c3asZAPOyxRKsPyYAP9WSX91mFuKisGjfqYcszDPsN/BvIXNOU6UVanky/uJujG2KFhvexudjXNF4QT58MagLU1J1b03LPJe7ZZasg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: h03UPQR1uyCniILnFc9Eokab6WDtLLNjz5YP1hu6denFVuq0dPWU/JfBJLg4+qQANM/izi64m9IrueZPughMrfsx5aECCuAHmGweGeV2/Lu4rmSlOnEqpgRhTRe3+qmlvtMrLA4Q3Tm31s1EKau28Ujy4PmFXRT5hjby29fTr2Jd3kRjpiDjWwy6HlpfFhqNYIQdBraK1BmRps7/V67OLXb0s97ntERq8OhMLmeRm0xOmuUgCGAs6XHFzxHgzd63Och4jizwWaIRA83YWrVgbq03IQP5aYmYnAPRsWngygDmGIkus0QQiNtkxVrJWWIUOC1mSJoWhsiGb8GVu2R/qg==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH2PR17MB3797.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5b44fee7-ff46-4287-b1fe-08de8b1b7ddd
x-ms-exchange-crosstenant-originalarrivaltime: 26 Mar 2026 09:38:52.5164 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: JPhu9/oEHRe6/hcIVGOF0D0jUr9rER2hL/t4Z9D4wqNzvzrltAOHUTAf9rEvZmoou6J07ewwM2TX5bDnPpvflg==
x-ms-exchange-transport-crosstenantheadersstamped: DM4PR17MB6295
Content-Type: multipart/signed;
	boundary="Apple-Mail=_6D2F323F-E255-4C43-AD8C-3DCD5A6BC630";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603260068
X-Authority-Analysis: v=2.4 cv=EZn4hvmC c=1 sm=1 tr=0 ts=69c4feb2 cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=4xFXqd-_BHBjZVyr95gr:22
 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=wqEPy6YdJa6IHq_5YgYA:9 a=QEXdDO2ut3YA:10
 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: FCgpyX3eIX7JH3vabWiP0_wIn1ml9Qr2
X-Proofpoint-ORIG-GUID: FCgpyX3eIX7JH3vabWiP0_wIn1ml9Qr2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2OSBTYWx0ZWRfX4JPmtt2Vbev7
 ACf24w0ysI554hU8v8km2btY+m0fVvIzhEDO34LbI2ZimUYdCT+VKZnUAB1TT9Sio6EdrqvaUzJ
 NCFqoZYBjI7MZgm4Sy+0xVn9Paetj9c6a8X2OpiiPPzDrpzURzuEIR+t+2gw7TKqvGkRKAlXj0O
 HSqP+GO6LDwL5xYoOhuMEPlnWge1T3kFxtB7TyJDgqmPEAzhsBw/Tl1Y1pAHyrGbsVDvrqy6dN2
 0YMTIOlqEXkWldZqGvIDGpaMZaRlsCyF/vqEOGiOoi2ti7DNSrqm1fFQJO/1lNSKrZz8sqvmubj
 TjvGgRpnXLPtGLAGCan2Rv1syRiRVkxX9mXlxAGarkuqo5bujGK5jqaXnHzcyW+vjziRvx2aoys
 wvRUmEXolVTFEssOhiWsfI8oy6QCRe8rseqO12EZdN5/6iPajUuN/JWdo9NJdW1Bh3HZFkPdMrL
 nZ0QTaDPw1ELBV+hpZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603260069
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230445-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mboone@akamai.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	RCVD_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,mboone.akamai.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 4B94B332754
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_6D2F323F-E255-4C43-AD8C-3DCD5A6BC630
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Morning,

> On Mar 26, 2026, at 1:50=E2=80=AFAM, Andrew Morton =
<akpm@linux-foundation.org> wrote:
>=20
> [=E2=80=A6]
>=20
> AI review has a couple of questions:
>=20
> [=E2=80=A6]
>=20
> Is there a race condition between the validation of pudval and the
> dereference in pmd_offset()?

I don=E2=80=99t think so - as the comment states: If we spot a PMD =
table, it will not go away,=20
so we can continue to walk it.

> Since pmd_offset() dereferences the original pud pointer rather than
> using the validated pudval snapshot, could a concurrent thread =
collapse
> the PUD into a huge leaf right before pmd_offset() is called?
>=20
> If that happens, it looks like pmd_offset() might compute a page table
> pointer using the physical address of the huge leaf, which would then =
be
> dereferenced, leading to the same crash this is trying to prevent.

It shouldn=E2=80=99t change, and the check specifically confirms that =
the underlying
entry is a table which can not be changed into a huge leaf (given that =
we have
the mmap read lock).

> Should pmd_offset() be passed the address of the snapshot (&pudval) =
instead?

No, the snapshot just wraps it in READ_ONCE so that we have guaranteed=20=

coherence when doing the check. Using the reference does not have any =
benefits
in my perspective - I also don=E2=80=99t see it doing much harm per se, =
but let=E2=80=99s not increase
the scope of the change unnecessarily.

> Can this loop infinitely on unsplittable PUD leaves?
>=20
> If walk_pmd_range() encounters a PUD leaf (such as a VFIO or DAX =
mapping)
> and returns ACTION_AGAIN, this code jumps back to the again label.
>=20
> During the retry, split_huge_pud() is called, but it only splits =
Transparent
> Huge Pages. For device memory mapped as large PUD leaves, =
split_huge_pud()
> does nothing and the entry remains a leaf.
>=20
> When walk_pmd_range() is called again, it will see the same leaf entry =
and
> return ACTION_AGAIN, creating a deterministic infinite loop while =
holding
> the mmap lock.

We shouldn=E2=80=99t hit an infinite loop, theoretically I guess that we =
can when the two threads
are concurrently splitting and refaulting in perfect lockstep, and it is =
something discussed=20
in another patch [1], but adding extra locking is quite expensive for =
something so
astronomically small.

With regards to =E2=80=9Cunsplittable=E2=80=9D PUDs such as VFIO (i =
presume this refers to device PFNMAPs)
or DAX (special) mappings. As far as I=E2=80=99m aware, if something=E2=80=
=99s a vma it should be splittable like
this. Previously split_huge functions had an extra check for =
pud_devmap(), and the trans_huge
check should return true for VFIO mappings (i.e. on x86, it just checks =
whether the PSE bit=20
is set which happens for huge PFNMAPs).

[1] =
https://lore.kernel.org/all/45e50068-751c-4e8c-a6b0-62cf8d1e58e6@kernel.or=
g/=

--Apple-Mail=_6D2F323F-E255-4C43-AD8C-3DCD5A6BC630
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCcow
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFITCCBMig
AwIBAgITFwALOJfLRtbGzZc1dwABAAs4lzAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyODA3NTYy
OVoXDTI3MDgyODA3NTYyOVowTjEZMBcGA1UECxMQTWFjQm9vayBQcm8tNDZZVDEPMA0GA1UEAxMG
bWJvb25lMSAwHgYJKoZIhvcNAQkBFhFtYm9vbmVAYWthbWFpLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOX+npfSrX/rwhOySq6aejQMUVslPFpNvXdEnmMlnEjR95gq0Ygp+wQc
Sde+JGBpGHsPMzHT1Nd3V1acm4cW1WB1aRqJOMfSLifg6SLkq2EM9WsftEiA1G4BT4UP0PFZY2Os
6TXvebAuVg6LwhB417rEJ2kuS/DKpiG8trAVDR6Uy9vbSMBp6iIewBc9r0CjW8l1zgRr+uQpXEUP
mF2BV0l3Qo5r0nhPqTWR9oAX4/oTqnhbEhQ3tOFYTjzO1K9DdzX8mVggVSZz/M0v0gtkZVvO4B1t
3Sh+1lla5eMY4hlVHW1/FKqMe4EMXmDH7goTEuXPpelJiNRdBh7ud7xNNFUCAwEAAaOCAsowggLG
MAsGA1UdDwQEAwIHgDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQw
HQYDVR0OBBYEFO0y/xWMpkyOUMuNKmuzNtjXpdtRMEQGA1UdEQQ9MDugJgYKKwYBBAGCNxQCA6AY
DBZtYm9vbmVAY29ycC5ha2FtYWkuY29tgRFtYm9vbmVAYWthbWFpLmNvbTAfBgNVHSMEGDAWgBS2
N+ieDVUAjPmykf1ahsljEXmtXDCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2FrYW1haWNybC5h
a2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybIY8aHR0cDovL2FrYW1haWNybC5kZncwMS5j
b3JwLmFrYW1haS5jb20vQWthbWFpQ2xpZW50Q0EoMSkuY3JsMIHIBggrBgEFBQcBAQSBuzCBuDA9
BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEp
LmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFrYW1haS5jb20v
QWthbWFpQ2xpZW50Q0EoMSkuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFpb2NzcC5ha2Ft
YWkuY29tL29jc3AwOwYJKwYBBAGCNxUHBC4wLAYkKwYBBAGCNxUIgs7lOoe41C2BhYsHouMhhtIP
gUmFpcMQmtV/AgFkAgFTMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQw
DAYKKwYBBAGCNwoDBDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0D
BAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwCgYIKoZIzj0EAwIDRwAwRAIgD5UL4MI1RXeg64RR
kifZAeItCnkZ4ecrqSEGpLcXV+ICIAdB9vZdM1WGxtag0rlqG0j0FBrCWixC0cdHNpFrqNx/MYIB
6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMT
DkFrYW1haUNsaWVudENBAhMXAAs4l8tG1sbNlzV3AAEACziXMA0GCWCGSAFlAwQCAQUAoGkwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwMzI2MDkzODQyWjAvBgkq
hkiG9w0BCQQxIgQgn1qAyb7cTMm0cCUrz4nGsKy3+Y8dX6JaHraZlst9yYcwDQYJKoZIhvcNAQEL
BQAEggEAXh9zXxUO61dLT0Xets8Po4dYynNv9UVxUYovbD2Rs29rV5xqIaL3iS6FdGW4gNTnGap5
X5oxRXErsXuvm4Zq53KBIIx36Nc//yrhxbVeltCETxmK6pPOuHgPr11Avx2nQW/xl0o/3fiTrQ3m
mk6U1ghC3VysBMz9QfLCZBwcv1QkNZ0x1hQ143BEVOdrqobVhBz3H+4kTwC7k6kYtJsHSwG4kIhz
7vI0DoV5fLGntolpCEBgLAPUfBoArcZ3Xg6/O2pxCT0n/lyE3U+mjlu8kQqmhANZFDvVkNUFiepS
LMkQGctB8j2dZi+eLfEeJE+sHwdeboZfrgtE2qoQ5AkV9QAAAAAAAA==

--Apple-Mail=_6D2F323F-E255-4C43-AD8C-3DCD5A6BC630--

