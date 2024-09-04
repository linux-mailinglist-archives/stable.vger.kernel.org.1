Return-Path: <stable+bounces-73051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4512B96BDF1
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 15:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10B9282553
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA81DA637;
	Wed,  4 Sep 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ML5kv2AL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v7d1dv6C"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13121DA114;
	Wed,  4 Sep 2024 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455215; cv=fail; b=b8sz41kNv1p9k35VrCQBiFT2crqF/TKofa+HB8WkEyd0fsLz/ySkALLaQTRpdLZ2WOWFDcfcJLnDmSXzw1JQ/OW/2jAgNEhUwb3ZZ+0L5rRd1BiEo0r1EP55b+yvCaPNCWdVQoDeTkJcEKetwgS511vPLy918ADGjxD/rtLmQX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455215; c=relaxed/simple;
	bh=fkCZ/JoT669RXbZP9aOKrFoBq7Hp3uHw9Bqxi0Wa/wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K94avSJ4Z62QOKsIjnge6il8MSNlvsO/3LHZSlcRnLBQGlgUq4h4ptarUE/jmph+KajojYbIv4RCzUUWl5WfrKOoEROpDgBCZDjXbshUOqz+dca9BNUd4lBAsur9h91ew/w0zII6PqBiKDhqB1taH4o8LRtIiToEw+914ocyLO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ML5kv2AL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v7d1dv6C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484CXdJw029114;
	Wed, 4 Sep 2024 13:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=corp-2023-11-20; bh=PfmumKa9lwlNKA
	r24Nq61UmtE0+Go1PhCZBT9Z3GO2A=; b=ML5kv2AL0KrieSDAN6AUuuKOkBkiRf
	hOduRh1ngtprPeR1jBOH69ivYZVP2iR2ZO8W5yILJ1iGbbLEVWEQXARD1t0NEk54
	vlzbxQ5OXCoA4Nod40tiR5pbJmypOxVzi4j9WVGeamUHAvJKXUM+Rrv8aeC3yHdM
	NecfBu1fZiaWmG6XEAcUA1CtF4AncEJE0qcq9hm+VtP0HINolb1wC5coSlWTWAcg
	vbnPHzgaqx4zL3Tl2g19CDy6hDKmJ6vKfD5fuccteH7L6p5iDHOCsopsWFscV8Nj
	uhVF0qgHXfuICWowiq7JR5oUKWzJ4rsvItzUSa+rIujU0HEDfRp4eBwg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7uf20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 13:06:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484D2xCA001753;
	Wed, 4 Sep 2024 13:06:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmgbu02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 13:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxLQvdaX1HWnjlAEkZ9sQ8JyBQiD/srK8KeWqYkx42HZoHLdSUn9oU3hEi8CgbOfsCYIdDyTaczsjDcVpvlFmUHJjM1C9miu9WTHWtpPZdHYineDGYM3OVpfLMUJ1LfoTXbQ8m+9SIgnXZ2pbn8xeMMbjSylCult1z/4hdFHR0fGyykcGBhtBTKazFegDA1gzbYo7OAukBh2WJZNax13ypLT6Aa6lqmlK6OwhHSZbhD9AR0/AOdBfWlUl9IawFsxvb4shTdRHVYf+gIFblswul2EZ+Miu8IDhbR3FOn2hcbBQX+ZMRXXbDN5vx4CVJCUH1QUH3gWNWr7ssJqLc5mJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfmumKa9lwlNKAr24Nq61UmtE0+Go1PhCZBT9Z3GO2A=;
 b=Xc5ZqMGQygIbmYHTxsDbM25vVAkLVTf5a/JdIVUd5EchlKbKoi7tJmAa3oPNss/0g7jaf2jVMFfEsnFDwMYEU9bmgqeSd6BDsNHUXQCxoFGyMqho2pD0LM8WBJpPHU61xt2UvutFEVpvwJaGs8M4G8nLnuaYyZRPtyRyP9qba2RMUpWDL4Yypw4vzSc25+ep8km3WYCihN4JVJL3JtxsDgOBNkusyc8vBM8cit21CXq1yTsej7o/nIu2hKjjiCXNOegxndo/WCnqAPjadVEqZBQ2kUKjeQI/bbF/Rl3dCE2/e0fFv4bJ/GUC5PZeMJpCx4tsmTIsHlcuOjTLYFi3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfmumKa9lwlNKAr24Nq61UmtE0+Go1PhCZBT9Z3GO2A=;
 b=v7d1dv6CXXxRVpDQFOoD7I0euu6u3OTTZM+Sx9yK/oTwL5+Nmehhmep8fErFDnuGTYYZPfrJHvKHzsYv+gQ82dXJ1mQDrzGrlKx3euWOADiNkFmN3ciNmFy8/14Whgb/QMbLxy+OI5VvmgAaVhV4nFusKeKeq8N+yXViMbFAn10=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by DS0PR10MB8150.namprd10.prod.outlook.com (2603:10b6:8:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Wed, 4 Sep
 2024 13:06:45 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 13:06:45 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH 5.10, 5.4] net: set SOCK_RCU_FREE before inserting socket into
 hashtable
Thread-Topic: [PATCH 5.10, 5.4] net: set SOCK_RCU_FREE before inserting socket
 into hashtable
Thread-Index: AQHa/stKyqzoAXLGPketIs0jliR0Jw==
Date: Wed, 4 Sep 2024 13:06:45 +0000
Message-ID: <004b3dec44fe2fe6433043c509d52e72d8a8ca9d.camel@oracle.com>
References: <2024072924-CVE-2024-41041-ae0c@gregkh>
	 <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
	 <2024090305-starfish-hardship-dadc@gregkh>
	 <CANn89iK5UMzkVaw2ed_WrOFZ4c=kSpGkKens2B-_cLhqk41yCg@mail.gmail.com>
	 <2024090344-repave-clench-3d61@gregkh>
	 <64688590d5cf73d0fd7b536723e399457d23aa8e.camel@oracle.com>
	 <2024090401-underuse-resale-3eef@gregkh>
In-Reply-To: <2024090401-underuse-resale-3eef@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|DS0PR10MB8150:EE_
x-ms-office365-filtering-correlation-id: 2aba1cdf-3783-4fbf-1096-08dccce26d7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VFQzSjRJeDJWOHhHOGh1M0lwS1JEdkphdEhPNzg1L3NZeWRyaHZCWjYwQ1o5?=
 =?utf-8?B?YTNFdFJ5dDRpeVR4UlhDaUYzcWZ4Q290OFRkQTVJUnI0WkkrU092RFc3TFRP?=
 =?utf-8?B?UEtJQlZ1T2lkR2ZOMENuTGoyQ1dmZEExLzd2aTJJZk1vNTVIL1U2TkJ6QU1C?=
 =?utf-8?B?cVFNZm5iUk1rT05rMmwzaTdZbkJiSllZVmdya05YdWhCMmE2MWw3NU9RYkRW?=
 =?utf-8?B?blJjU3dHOXpsRHZsVkJDZlpWMW1QUTdJS2NrY3NGTFVKL1h0bUN3SXRyaXhz?=
 =?utf-8?B?RkFrM2lqS2g5ODR1OWJ5SkVVQzN4Ui9LTUdQbTdRRk9lMUdJQkdXM2FobVdD?=
 =?utf-8?B?VW5tUjVEdmJDeHBwQnJiUjVDWnZZN0RjWkZVV0RRazVoSjlkeFg0cHZ6cEQ3?=
 =?utf-8?B?dmtoZEppWnV6cWxTejBvT0dVMU5wOVlIb296cUEwMjRiVXk5RGNReFliTnpo?=
 =?utf-8?B?N3dkZHl6UzlSbk9xQ0VTalE0WWVlaldGeFdjak9JSlBZZHowb3NucnMzeWdv?=
 =?utf-8?B?QjJveWZVSHFIY2tjcUFLY2Z4SnBXNGdWenlGTGxoOVBTejdYdVV4TUt1N3lu?=
 =?utf-8?B?UjN5L2loYVp5OFJXSlVzOVQ0OXV2cEora1Zsb1JzMGpoMVVGUXphdStMMnJq?=
 =?utf-8?B?bmFIUUlFdDByN0pueDRZNnZqMElza05FSlEwcEgvMWdVa3MxL0JKeG1WWEt1?=
 =?utf-8?B?amZHLy9BV0szZk5zaWhBZStaaEVmZDFSOTEyV1RXR1pRQTVxSFlaU25JbU9q?=
 =?utf-8?B?U3NtQUp6R3U4OG4rbHpEYmRYTjUvemVKNWlWeGtIVTlxQkFsL2hhaFVacjVp?=
 =?utf-8?B?cG4razlYLzFhdFpYZ01xcjhKUGhzRmFCcjRPdXZORklwQnlWMW5hbnZVZitP?=
 =?utf-8?B?dDk5cVlIcU9PUnZiV0N2b0dwajRiTktVeWJCR3QrVlVnSm1oUlV4Q0Y4TEp4?=
 =?utf-8?B?R3JYQlZpN0Y4cE9KTGg5djJicGZ5NWdTSEt2d2JNWmRqRVlMY0RlM3g2Kzlv?=
 =?utf-8?B?TE5YU0FFZVJBRXIyaG1GcjJiT3crUUF0RWM2OVhUSE1OdllvSjJlMEFXKzBE?=
 =?utf-8?B?VFEranVBbGtsUnh1NmpQcXJSRkpwNWErTTBPMnZQZnVHYlNwSHM3OHdYc2tM?=
 =?utf-8?B?RHNsK0c1YVc2djlBZzkxS2ZpVExmMzZEWkdBcjRLemtYanFEK3hIQmdNOEVj?=
 =?utf-8?B?ZkxmeWZ6NUpZSFNOVUw0eTRXVmJldTRHMVc4azdtUzNjSGd0b0tRUTN5ZFR3?=
 =?utf-8?B?ZnlaV0trekcwTkF1Ri8xSVMwUG1xTmRYLzBiL1BZWWlKeHRhSHQvUk1oVG5T?=
 =?utf-8?B?eE91R1FocFJMUUdEM1Y1SXlYV0ZXZlNyOFJMcGQvMkRrNUthMk5KNXVibnhO?=
 =?utf-8?B?TlR5UTlKWm9VYkxTY1hnOUZkdXpEQU9sdUpmZUIrNEF0cVFVZmhXYU16Ky9Q?=
 =?utf-8?B?bzZnZmdLSTFXbVl2bjNFZ0pkdXlneG5WK2ZuOVN3Q0dkVUp2TFpsUGNMYmhU?=
 =?utf-8?B?QkthSUpJdzdFcWZjUWduTEw2d1JVV0ZQVVB3WUZud2pMUWpjRjVpMFdrcUxE?=
 =?utf-8?B?Y1lMRHl3SXdJdFdjeGN5V3huRGpFdDRaOWlUWDNaR0orRWthck9jblBIemd2?=
 =?utf-8?B?Q25pSlphYkI1WFI4ZFZNSWxGQjNPZ296Q1FMejdBQlVoWjZYQVpUT0o2ZGRN?=
 =?utf-8?B?d0tDQ29iMGI3WC9pRkc1VXVqd0JjN2FtZzBpQ1pzL2x4eG90b0ZlcXhicjNJ?=
 =?utf-8?B?M2RPRHJac0FFVG1Yd011WEZLRCtOb3ZTR3UvQTU1Vk5FZ0RwdkxnVXp4Rk5y?=
 =?utf-8?B?VlFVV2Q3NXViUnBFcnFhV3N2QW1FTVFDVmxrWjd3NjlEQnltR2FxbzdlMnNq?=
 =?utf-8?B?aUsvVm9SbFNLZWh2cjlwV0FETTVtRE85Z2Y4Z3Y2L05JUmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aS92ZWRxZm1FNjhFS0RTM1o2ZTFGWmJaM3JzVXVPVXFWMzVMZ0d0aFZoalBh?=
 =?utf-8?B?d2E1am1mT1YwbVY5L3RHSEIvT1BDdmpPWlB0UUxTRUpXczExZmdoRWRWaVVB?=
 =?utf-8?B?bmxHL09tT3N4ZFUzOWdoWDExUWc2VkZZL3dqY1VsSm4vWGJ2K0hjNE5zUHdm?=
 =?utf-8?B?MzVtT0tRckoxMTBFM1lieHlyUlBieVYxSEtSQVZYV201bmdBZU85c05sdW8y?=
 =?utf-8?B?cGhWWEQzZHM3MzhtTC9pMy9FemRCQ2Nra3NCdHFmczZQMzBaTG5QQWxKZUJu?=
 =?utf-8?B?aFl6Z0FCM1RGOVFURFhDTjlFQ3FOTkE5SitvdGNIT1dXUFBWODJ4bllULzdz?=
 =?utf-8?B?bzN0WnYzVWZGS0J6ck9HZGhXOWc2a25IcS91WTY4aERuS0pZZFBxRXV6YUda?=
 =?utf-8?B?bVFxb2JqcFZXZUFNQ3ZrU0ZycUthZVJkQS93ZlZUZ1hURGR0RkhyYnlxWlVy?=
 =?utf-8?B?STNPZWMvZ1dBYVVmT25HWEJrbnNiUXMvcUhMY0g4Z0hqdS9pajNsa1d2VWFv?=
 =?utf-8?B?dkQwdFZOYXFSdjZtRlJvYU9GSGJFWHEwRXpFN1c2a3Y2S1VhTHBxWkkvWGpW?=
 =?utf-8?B?U2xNVWR2cGg0VzF6YnhSWHhSOG5ENFFhd2l6OFpNN3JjSDE2S3p3ZWJKWmpI?=
 =?utf-8?B?Tm1ZYVc5WElnL3ovWHl3VUZ2bDR6YmsvZGsrcUlPdHZhL3BjVHZ1L2lGeEFx?=
 =?utf-8?B?OEQ1bjc2a3ZJUStwT2ZPWTgrWXhLUGdiWFBKM0tnOXJidHFwbzdaTHgvandE?=
 =?utf-8?B?cmVGL1pOYzFQRFZmOGJhSUkzalFjN2RPMTNlZFQzSUNmVVlvMHZwN0trSjF2?=
 =?utf-8?B?WHJqMktjbjBNeHFZemRoMkR0K3JhT0RjZjF1YkRoZzZhcU1QMXRCVHBvUGI1?=
 =?utf-8?B?Q01pL2tJMHJHc3Nhb2NMajZYR3NiRlVyUDVNbkkxeTNyalBBS2xyT3dKM0Vr?=
 =?utf-8?B?alhSQzRkcVcvQ2ZibklaWjN3bWY4SHoyZ051aFFJN1lCY0pJUHphNTR0amlz?=
 =?utf-8?B?RklHWkNOQitzSUVkeUE2SjdoM2tKSWl6ZmpoUTlxZXNDVThKWUcvL1dORlBw?=
 =?utf-8?B?U1J6b2JnUk1lTlZOK0ptVVZsaWpCcXRqT2FuUlpqWHNNbVRiaHJxVk9NU3pU?=
 =?utf-8?B?bVZqdEd3djB1RkJXd01tbk9obDg3b1Q5TGprQmlmc2UwNE53amZCb2graVQ0?=
 =?utf-8?B?WmpNTFIyZHU0TGVYTk1PV1poS3JGYkRSME1JeXJ4MGEzNEtWblZhdGZsUEhE?=
 =?utf-8?B?VWJ2VTVZbGRkWTQ1QnB0enZsaEoyVGdlbXNST2FhSW9kYmo4RDdILy9zMlZU?=
 =?utf-8?B?UXlyZDhQeUJsNktHODB4dEk4Z2pKS2VKV0JxL1ZJVUx5YmdGcVhvV2NBMzJF?=
 =?utf-8?B?dVYwOFBTd05ESmxLTmp3U3lFZEVOTS94cXgyc1phdXlqa2hzOHhqKzN4ZU9F?=
 =?utf-8?B?T0ViV3FwYy9SSkZxY01yZFVwWEVHWUlObDcrM1g2SlhGQktTVjBTaXlGekxs?=
 =?utf-8?B?VGZOU0diZnl4YUhFM3I5a0NwVU1xSGtGWW9NUmZHYnJDUlk5My9ZNXBIN081?=
 =?utf-8?B?eWF4QkZ5dW9EanlzSnBXU1VLUGh3QTVnTDZlaWk0bDlRL1NRMzZGb2Nzdksv?=
 =?utf-8?B?TUFCbW9Kd3lYYUZMWlc5ZXNXdWJYN0RBY1dDL2dxTTNqY051cFk2alFFWUty?=
 =?utf-8?B?MEZhUVBwdnBDY2Qyako3ODNtMFNYczZibjd3dGlSYzlwd1NWdHJLTHdXdDla?=
 =?utf-8?B?Z2lNVmNqYU1pd2pQaFdyVERZcVYvSGVoSnd0dXhwaGxyVzhmbitKZ2krOVIy?=
 =?utf-8?B?dEZNcXNYNjNJQlZkZ1Q3dDZqS2JkSVVxMk1CNldqRHcwaHhLb1JHai9pZUl4?=
 =?utf-8?B?R2dReExsTkVCYVc3ajJUVWk1aGtQcG95SlBxb1o0cTBmZGx5VzUzUkUwSzlr?=
 =?utf-8?B?Y0hxY3ZtREsyRVdnUzVZeUx2OGpjNHYvZUxpZk1IQmJORkRiZEVZVTlFUnMz?=
 =?utf-8?B?UTZ0ZmYvY2ducVI1SHVQT256eXpydlpUWEdWK3BRS3RUVzlldmNPMTJVMFlE?=
 =?utf-8?B?dDB5c0k4UW1KeERQd2kxbHNpaDBHRUhDMkVZSmJmL3hGTU56VGllandSV0Q2?=
 =?utf-8?B?T2FvWWhKbEFwbFBpeVFHRHEvbVdYQS9XY3BOTWoxYnhST2p0aTBuODdRejBZ?=
 =?utf-8?Q?t7a6TTVw5SidEHd+KjvIKb9RNBUbRO4Lx3K9oMJSYr6v?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-aMY8anj4eTrj68nwtut9"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xo63ScsVPP+S80PW2stvI9nfvKz4T3RApDKYSOJDyk8AYXF4eFet0UYpiQHN0q1Wf5+l+gcOsXSuOcjaXm5k3iahXK68Uh1vAJRuYqFm6ibQqFZJ5YocsDAfeCdqLlePyRGV2UQmqpmloGQgMnEN/j1QNwZ1qM0JP3wmaX4UltHAVXn9zxH6DEih9Fcb8Xg5pq8J8wJC0NkJByvEbGc6LnVIbJcCsb36DAPs952dna2ByNipQLavpr6eR0sRMlY3yvb8V7h51hY9RTbCiyAG9tWicDiwuHUGyCXDhUZ94km7A1WP7zFV3zn922DXZ6XH0BRpRpNMLCC/Q9S5HG/Gf2/2mFfpZkSx2ef2Irxc8ou4pCdgJsVm9B33VN+96J2y2dHtVj4KYhtMz4arSQAUGaXb5JLBJv2TLPIy8NA9OazVrabF6GpgyVzvpNMPaUJ1gBQhsSsKM2gaXvSY27VYYb0M2OV54VyOXYxktYduQaXZGNYPj7+KQmJ8dQDIwUKqjLlto2gbznO15Ghno8v4WoLXMAKSfAjznOKhELOSNrygNBb5aZgoNjV9nO7KoMRI250pSXG7mZVs7lXITvtuIt4wCaCmeLKdSPgw9VDrEJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aba1cdf-3783-4fbf-1096-08dccce26d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 13:06:45.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9bSrkUzxMgRP+6h115dJx/NcPc29F5hapi5Iy3LOaHPptnv2dtHRX1ryNOcrpJ3grc3zw497aiYswweyMTQl/e17cWKzGvbr3nkahLdyfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040099
X-Proofpoint-GUID: wxe65JCjCf0A3uZtnO3cKUC7Z_Zr8vaH
X-Proofpoint-ORIG-GUID: wxe65JCjCf0A3uZtnO3cKUC7Z_Zr8vaH

--=-aMY8anj4eTrj68nwtut9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Upstream commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99 ]

We've started to see the following kernel traces:

 WARNING: CPU: 83 PID: 0 at net/core/filter.c:6641 sk_lookup+0x1bd/0x1d0

 Call Trace:
  <IRQ>
  __bpf_skc_lookup+0x10d/0x120
  bpf_sk_lookup+0x48/0xd0
  bpf_sk_lookup_tcp+0x19/0x20
  bpf_prog_<redacted>+0x37c/0x16a3
  cls_bpf_classify+0x205/0x2e0
  tcf_classify+0x92/0x160
  __netif_receive_skb_core+0xe52/0xf10
  __netif_receive_skb_list_core+0x96/0x2b0
  napi_complete_done+0x7b5/0xb70
  <redacted>_poll+0x94/0xb0
  net_rx_action+0x163/0x1d70
  __do_softirq+0xdc/0x32e
  asm_call_irq_on_stack+0x12/0x20
  </IRQ>
  do_softirq_own_stack+0x36/0x50
  do_softirq+0x44/0x70

__inet_hash can race with lockless (rcu) readers on the other cpus:

  __inet_hash
    __sk_nulls_add_node_rcu
    <- (bpf triggers here)
    sock_set_flag(SOCK_RCU_FREE)

Let's move the SOCK_RCU_FREE part up a bit, before we are inserting
the socket into hashtables. Note, that the race is really harmless;
the bpf callers are handling this situation (where listener socket
doesn't have SOCK_RCU_FREE set) correctly, so the only
annoyance is a WARN_ONCE.

More details from Eric regarding SOCK_RCU_FREE timeline:

Commit 3b24d854cb35 ("tcp/dccp: do not touch listener sk_refcnt under
synflood") added SOCK_RCU_FREE. At that time, the precise location of
sock_set_flag(sk, SOCK_RCU_FREE) did not matter, because the thread calling
__inet_hash() owns a reference on sk. SOCK_RCU_FREE was only tested
at dismantle time.

Commit 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
started checking SOCK_RCU_FREE _after_ the lookup to infer whether
the refcount has been taken care of.

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Resolved conflict for 5.10 and below.]
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 net/ipv4/inet_hashtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 56deddeac1b0..0fb5d758264f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -653,6 +653,7 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		if (err)
 			goto unlock;
 	}
+	sock_set_flag(sk, SOCK_RCU_FREE);
 	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
 		sk->sk_family =3D=3D AF_INET6)
 		__sk_nulls_add_node_tail_rcu(sk, &ilb->nulls_head);
@@ -660,7 +661,6 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		__sk_nulls_add_node_rcu(sk, &ilb->nulls_head);
 	inet_hash2(hashinfo, sk);
 	ilb->count++;
-	sock_set_flag(sk, SOCK_RCU_FREE);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
 	spin_unlock(&ilb->lock);
--=20
2.45.2


--=-aMY8anj4eTrj68nwtut9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmbYW1EACgkQBwq/MEwk
8iqFeA/7Bh8QnJYwN7fHFiusA9Hm7wKxgXgU84U6w0GaaYhs8CyS1SG6SRvkng3D
8YF7U9MHV97JDskK/yDEtz8/QmOcrk+VP/crveA8Zo0eAXX8W/vxtszqZLuhvWb0
mj38WMD5GIIa4W1BY7soQGZuzpjE+qVKzdV7hiGpjrImAsrR6V/zmwXRDZUCr0Dp
xrNUap3FrrtehfkoEa5MwurLlGHHzUEak7yzWQsS6ScZH3QdLSFru/CKuD2jlqEo
njwRR9p4Gdx5SBlv9v4PT/RzmFcaZo0lypDZcgbUFQCLFI5PBv37DVcKI8kjrzu4
UW/Htv6RVAxJsUN+RnuHJWcKmbCugCjx2q4cKlRYZ0/LTb0t6ZJyJhQOIT1Awft/
74IKGhrH+jBK/fxxSj4Kh7sQ4o29+oWFD+5zxff2j9iNIWHsfwA3OxDj+b7QWcEs
qZyxsx/0rcMer6oHi6EX8+byrqpuPfx+Rk0Y/KbzS+Q/9JEkivctEnTTt6S0Ybv0
FVKyOYDE8qYS/YIl8UcbMHzk6Lbp5lrlqDfeHa/9/YTffX+z3oVfgIUkfP44f23o
Qrf3eor3yn+vC1RITpmBsS3t4wN+vIcK34v580h1vVLGonSmmVEXRS/IG78etsPx
OwucsseqENe80Ar0bRemlbMCyE51T4MQW6DwMWrYnoVL7XkuI9U=
=k1bn
-----END PGP SIGNATURE-----

--=-aMY8anj4eTrj68nwtut9--

