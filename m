Return-Path: <stable+bounces-255079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDt3OFyFGGq6kggAu9opvQ
	(envelope-from <stable+bounces-255079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:11:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C55F621A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C162300CBE7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665CF405C4D;
	Thu, 28 May 2026 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j3u/9bjv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34252E736D;
	Thu, 28 May 2026 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991577; cv=fail; b=WpYktRqSo6cUUCIa2K5ctGoVZ9k33l6CXCXJWKVpG/vF3e5CETXe5aoY58fAvPaatitlPlq8Y9bW8iBhDq9CkNK2mnCA2LKq7XSt3oL0eb19I78mEETfxk2ry7UtnZv/RON8ibbnE4a9BkT0SPE9fEmOWP184Bd4BQk1L9sB0w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991577; c=relaxed/simple;
	bh=ZM55bIrNmxJM3YeRUF0yNmkRUE5AXgbVzlUgSr6qMWc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=LyOlzrJr5QE/0y7UBh5gTIgGGkuFeqAT/kwZSiZh4geclsb8qq4H766gJLc48Rey77S0xNF7qW9eGeubVNc68wSq0uoPPDMAFFUtZSYvZaM8CqrpWtG0lVvjcpl/wZLtjxLYWQ0SStPo1LeROBOT5YRkGyDJ780b0vh85cl5p78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j3u/9bjv; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SCdrWX3784378;
	Thu, 28 May 2026 18:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ZM55bIrNmxJM3YeRUF0yNmkRUE5AXgbVzlUgSr6qMWc=; b=j3u/9bjv
	B5VWdPq9QcE/OKQl+81qezoTNBU3uVHrZrxYkmux74kubspzOT8zgcondax4A4m2
	tQSntrAkeIwLjnXsLcdkuaM0KzuRMomEUfN8b4Ufps/h59oG9XDx5yF42L+xd4uZ
	/RSvwOOeY76LAOY+TsgPClapL3PyRY13jEjJhiDMQsMmKfpjuaCypmzFWoqWd4ro
	HY3w652+kxnmWTR76cWh2QYgLgGvs4wGiSQMlN5CZQtzRKLqeDpvc0ISkAhxhZnp
	E1K11J4RFmpQ1Sv77CIY09MdKEi9HQ894YdeqGuVAVKfviYF6XAs6dC/G6ZaDXRc
	XOACyOoJBFLFYg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889c7wa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 18:06:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3BlCANqwqjfCAB1aMrJ1AcxqTMXL2MW4sBmzK6zNk6faw0TAu8U1+ksbJoDahI2NE5tgV9JdWGkkYUSCjn1Npn34YmA5KMMlt6yTLKUrlswVtJyhuS7cFL51h4bp6hv6w87ZFRBZiG0NGSjSomv4u98tqMLgn8vt7uSOKzxrK7pWk3p63teLj3TYIowwlzJFikiuvQTOHk4nbBEkngtdXh9S+iT4Un6xx6cntn+0arZA2e1VIphwUGs6C8f8ENgICkzjCQ81LKDBVGuL9nPebZ6S/jebzf1lML388rfJR11+HCHMvzVqsL+s0Y8l/Jgm4Or92NrLtiN6or6+9gWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM55bIrNmxJM3YeRUF0yNmkRUE5AXgbVzlUgSr6qMWc=;
 b=eVZRxTuyHL2DedWbuzCOh0lPw6eTNONpLeSym+U3F7ntRMzaMMbiT0UMAKUU5bu5MQ3nETyjtSnMUKILrSzv3ZOWJtirZQk3/0DnN2aQzJpu+u8vZ6ygeQ7IqcfQ8pMYohPXKgi2UQm1WoYzmHMMmvGVnCDt+KYo9rWBXOuDwyFxcVOfujcqK80WH6MXT0V3AhPq8kMRjfngg9vgAyakDRwhdIFRQwCbRteI84es+xQhawzVs/aMRy095g5LHlBpmPlPBLkYm1t0tEHvvwQyhGLrtb44cOiyiUAHzscRHH6wLlL0C1RF4a01flwETqM28PMhVmTAmVktRL88lq3u/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6747.namprd15.prod.outlook.com (2603:10b6:208:519::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 18:06:06 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:06:05 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "jhapavitra98@gmail.com"
	<jhapavitra98@gmail.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] ceph: fix bare ceph_decode_8 OOB in
 decode_lockers()
Thread-Index: AQHc7qWRr/dzVG24UUqgj1iKdt7W1rYjvAAA
Date: Thu, 28 May 2026 18:06:05 +0000
Message-ID: <1cc8ba61e7fa29ca4e9ea83ceca8f217dff0c98a.camel@ibm.com>
References: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
	 <20260528132521.843004-1-jhapavitra98@gmail.com>
In-Reply-To: <20260528132521.843004-1-jhapavitra98@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6747:EE_
x-ms-office365-filtering-correlation-id: b5b7996c-b20a-4a23-f82d-08debce3c930
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021|5023799004|56012099006|4143699003|11063799006|6133799003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info:
 whIr5keh69mU5vCc6CCEdVV1kQ5u8wwjzzT8kTW1M+NUq/3tMAACRLNAQCNXdDhP/Dqa00QeF+2yxDUtFyx4ERJGj3YkFzMGew0IPOkVpIsIihLII88OuU1QS4narRjpFS2poznAx+DOijTh4cXE+A6ZPPfeKxNw+85n78J+WrRCAcwz+Itlde/d05R155gbYqrqcEPCceF+CdM7dgbaKm6JzQgw7U2N6Bt57TtbV7SQrG4czEPUN4L8sPzedFRp9FTNHFxe7gFDWE39SxS76UmblhpcQk/6J1pzd4hyHWMq9a1pvMA89WqvBzXpLOY+x5udMyqo3ju2g1Xq9vpSa9O6UMTKCY8JYHywPVDzh05aL0nydfIfieNOWikI+bJH01PVukkFmz76Rw19Brw96ROU2GZCQhoicRXARbH2Z8l4dE1CwSntzE8KdbtMIvaqekiPp1qhYqrxqhCZ0YVqYFl3J/2avsQCsqNsL2VOMn1tXp6tjA4GlsGhsiVLhk1QXMUC4JJAvei1Xk1cIWK6LOP66YkzP85GTRyH8Cv1CXDMQ0Sm4esjHN3cl1wBll04x732vT/2A4mPckuQj0zSO0aYIa9AykeYKMMA3mP/7TKNGJZADhlhzMzELd2X9/5MRYvPWwv8EjeJ4ZrhMAnDnFE3pcvYl2FQOmOgqJXSpkL9taBsrAYwXTBGY0GTomfaUb26RHLTwJLIUrqnR0RZlqKBiyrnKIYxxmWC1y+K29zYj9pqeyNNGCI4zaB4iIkT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021)(5023799004)(56012099006)(4143699003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mkh1VnN0TDBCcXNINktldVVLVzN3VUdsTmtqNkREYjlzdERuOGorRVNuaEdj?=
 =?utf-8?B?V3pMMU4rUHJZNUh0bXlXVnVxWGFzd1I1dTRUTVlja3h4ZDVlbkNjVVJyU2hF?=
 =?utf-8?B?NEZGcTBaTkFYVzhMYSsrZ3JZckdGZEpUaXlwRjU0VWNZUno1T2h2dUVxZXlk?=
 =?utf-8?B?bTMvZHg3QnZMY2wzRWoxaEtXTkJ5Y0xhc2YvRW1HVGVMYlV4VGdob09pQklw?=
 =?utf-8?B?OG5zUmM4c3pFV0M1SUlNVE9URURRcCtGcUlOQUhrbmdvaFhJTFZhNTJyOEdh?=
 =?utf-8?B?SW91U3A2aXlIclNqMEM4ZURDVVYzbUViTFpaSmpIdUFqQUZjMGlzZ3NuQXIw?=
 =?utf-8?B?YlBGMnFOOW5COUp6VXlnV0tRdFQ2eEpJUG5KVEIxTXlnZHZYQUFHTCsxRXFX?=
 =?utf-8?B?dkxZYmkzdXFsSUxzU0YzNklzRG9aYVhOZHZJUmdpL2NZYm9QcFlxUk5IT0xI?=
 =?utf-8?B?THdaMVdXTmpHcjhzSDc3NGNXVDlHb1RtY2tLTzRzZkR5M3JPaHV1SG91djJ6?=
 =?utf-8?B?Z1NtWnZoNTExRGdrVlpUVVkxTmg1emFxYW9XSlBjeE8xOTY0bzJTYVhSakds?=
 =?utf-8?B?Y0tWa0xHa2F4SjlieGpITmVnK3g5SmdYSitITzVRVWRUK3ozeDFTSkxWQmcy?=
 =?utf-8?B?M1RJRFdkcS9KZFcwdlc4VWpPc3J4dWxxRXZqcllZbHNsSXNjd1dZaUpnL0Yx?=
 =?utf-8?B?eTQxVHp6SnBIWkFCKzBBS1ZLMEFvb3dZVHpDSWdNdmxtNFlKV1RoU29ocnU2?=
 =?utf-8?B?RTF1c1l0VldDamhyNXV6OUd1MkwrVzVqeVFoMEoxVWdwaW1FbTlvUEdjaEtv?=
 =?utf-8?B?VXQvVjhWMlh1RUhtM2V0eGFTWW9Dcy9zbnFuOUo0N3lXWEZ4UUZNbXFyWjZl?=
 =?utf-8?B?aGgveHhNbGRSZG1zbDM3MjUyMTR1eitrSXVkUDhFY2gzNURrY3BKNDVQUjBQ?=
 =?utf-8?B?WDB5bXk0d2c2RllFRS83cytTU2E3NmdCa2MvcU9NcmN3UWM4R0VwZllhVDBR?=
 =?utf-8?B?enp5b0tSTUZwdE9DTkNlcUhqWG5IR1ErZnhWMjNYdWUrR2xaR2p3RjNtbnpJ?=
 =?utf-8?B?UHJQdWZadW01WVVnbUQ0NlIrMGNkTkhzQXI3TXpkVlRXV243SUFUQjZ1NTlk?=
 =?utf-8?B?UmxPZnNPZDZkS0M5Ly9TeXl2Uk1IaDBGdjFFSmxySTdvc2VuZjg3ZWtiaWxs?=
 =?utf-8?B?cGpXWEFBY0M4R3pNTUVOanI3Y29ISTVQMEJESUlCdXBKQzJxaVo1V3BNWlpN?=
 =?utf-8?B?am1FcXl5cG8vQ1plZEVhZzZMSW51OFhVNmc1M1VGN3dpUmNCMVpLSFpzTTZZ?=
 =?utf-8?B?eXlnK3BrSXFRbk5pa2pGLzJzZ1JIVXFDSGdOdFYvcnNVbXE3WDFoSjNRM0I3?=
 =?utf-8?B?STJ6QjJVYTNoaWNZRDhmMlN3ZUVEaC93NHdKVDNWVmExMW5SbEVHZGp5cExj?=
 =?utf-8?B?MGxpTUFMQ0diVU1HOHlPWHU5WDk2MkNobjUwang1Q013NXVhTldTeDJrSFFE?=
 =?utf-8?B?NEZXcTM4NEZ1blowRkh5d2piR3NVdnRKT1NmcjBsT2RJVmRDNkxIcnRESUor?=
 =?utf-8?B?TmZGcnliT0tzK3A0dEVSOUd6MytSQjdUQ2xkT0FOR3JXb1pIS0pXcTVoT0xZ?=
 =?utf-8?B?MzRWM0RiYWY3RS9odHd3MGVjRU04azVUVHN6QUtwWDNtNi9teXJhckRCZlVi?=
 =?utf-8?B?RUdEem00VlNYV2hGSjBJRG9YVHhMWDdQWHFtcFAyOWVOY2hXTEh3cVp2RlFu?=
 =?utf-8?B?THViTlhjN0hEbVR3TnFpR1N4WTZHbnAxTndqSU94c0F4U1Rwc003aXZaV0JQ?=
 =?utf-8?B?SUxRSkE0V01NZ1Z2Ujg3dlB2V1dNMVRXK21RMkFqNFl5WjVmenhPdDg2MmxW?=
 =?utf-8?B?RkhEZFFHdERkb005L3ZmRVZnSFZCYlhzb2lQM2tvamZiYU9yU214TVRPeDVQ?=
 =?utf-8?B?SytDWkxid0pHelJwNnQrREZsejdWaWUzTjlLVnBQUUp1eFkxbzRDdVRjUjls?=
 =?utf-8?B?bU9tZ1RSRXdGZGR1d2lLbG80QzVxV3lFMjMrdWhnaC9Ka0hqUzNpdGFZQkxD?=
 =?utf-8?B?TFVYRTR0VkFPMnZHb1lFeENtVjl4NHc5UU9xd3VkU1lSSVgwZFZ0bDRvOSs1?=
 =?utf-8?B?MzlWY1c5cnZaRWdPZkhsbnQ2MXJ2eFAwalFrTkZ3QkVpbTUwUnk0bE5hVCtl?=
 =?utf-8?B?aHdidG00N0xwWFlVNzdQV1NucmRZV1NKUHNFZURadDJVN3FOUjFtbHJhb2I1?=
 =?utf-8?B?V1lXc21HejdPK1BkMTVHc3hLY1dNQTFSalBqb2ZiNjJUS1l2MUhsM29vajZW?=
 =?utf-8?B?dGNrQ1drRU9vbXhObFNoZndBU2lJaU9rS0ZCeTdHVnBxQnA2YnVSeE5NY3FT?=
 =?utf-8?Q?O93DXsiPQxXDwyf9lDZY1MOuK9Xfw75slLtox?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E260212F1EB63F4C8C1718BF001D1073@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mh7piAv7KqF9ldInHoyz2aWRovR6OTIVLks5GqGiDV/0SjXajba+OVZJPFrC8xUscFP7j9VlPUYb/zm7iiRJZlBaUsz2Hnx5bAJhrVL9adeE4Xkx2VBL6KpkjuQBC1ewb8dsxJ8SOUq5XplyHH+NXfLewjlaVKnueDYC4A4bYiOlr7Lczp799VfbsIy1bd00D3kmoOurzVX1dsHpqT3SVsi2Zem42oLqllosADG0wqU7+a+jh7VhJuD//ULeshpyPDfNnaQB+ZvNUUMqsIpFJ3SXIbBityE5nMhSQUFUC8uQ9UXmZ0z6/h9boVwFb5gGq8CVvmrkYe1QJvkOTfjUlA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b7996c-b20a-4a23-f82d-08debce3c930
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 18:06:05.2067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GkKxpW7iWFRfire9D/ItD7YvOOjm0MRATeC+YW6YS3doBwk/Px07JQtsF1ovBtVKSes4X+hnAqCryy285sw1tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6747
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ASZbqiQVcnJah_n8KYsAf9LpT1xXyIa0
X-Proofpoint-GUID: VNDTGOPgSPOkd1wCB5M6YxfXtiibbWkg
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a188412 cx=c_pps
 a=z66bnWj0fqQOmAclyDzAfg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Mp2DbVetSN-rV-vyTUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4MiBTYWx0ZWRfX8i+ZBoVQ7cwp
 RsOtIGqVdtgxNcrwz85V8FZPToETyTwAbAlYLbWyqGz86JHAmEjtz9omeoaDscN9veD+2bkTO5d
 PbD48MZSjatv9AcnpWSZbbDLNMt9uHB0P569i1xH3cmkbizJJr7dtmz/GDmu9twbu9MYcYYafl0
 JgxZ/qfLLGHBh090M718aukJlpq7VO7Ip+vg1Z9eadLoXTe+n8zx50SZh3oeZlmIFOn9M2E9S1p
 gTW13xW83fSCMvfN64JWpW+vBql4Le4zMjpk2DApH6QnHGm9ngXZOspIAnH9cxAtjC/ZdPVjdhU
 5q/EqTpcxtzQ00XZD5CIckBaLyjvT3ty3XUOJW8IL2g3Zgx+mYetxeDJjVl9Z/BowhP+IyyWWi1
 S6WiXO0rdXrIVhc76ro3bqb4428HUdp7J4Esorg9j3aN3poA+Vr5CR2nJ2b3UJ8bp5C7BwvCssR
 OmTlF++cVC9I9pA6Caw==
Subject: Re:  [PATCH v2] ceph: fix bare ceph_decode_8 OOB in decode_lockers()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280182
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255079-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 143C55F621A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDA5OjI1IC0wNDAwLCBQYXZpdHJhIEpoYSB3cm90ZToNCj4g
ZGVjb2RlX2xvY2tlcnMoKSBpbiBjbHNfbG9ja19jbGllbnQuYyBjb250YWlucyBhIGJhcmUgY2Vw
aF9kZWNvZGVfOChwKQ0KPiBjYWxsIGFmdGVyIHRoZSBkZWNvZGVfbG9ja2VyKCkgbG9vcCB0aGF0
IGhhcyBubyBwcmVjZWRpbmcgYm91bmRzIGNoZWNrLg0KPiANCj4gSWYgYSBtYWxpY2lvdXMgb3Ig
Y29tcHJvbWlzZWQgT1NEIHNlbmRzIGEgY2xzX2xvY2tfZ2V0X2luZm9fcmVwbHkgd2hlcmUNCj4g
bnVtX2xvY2tlcnMgaXMgY3JhZnRlZCBzdWNoIHRoYXQgdGhlIGRlY29kZV9sb2NrZXIoKSBsb29w
IGFkdmFuY2VzIHANCj4gZXhhY3RseSB0byBlbmQgKG9yIGlmIG51bV9sb2NrZXJzPTAgYW5kIHAg
aXMgYWxyZWFkeSBhdCBlbmQgYWZ0ZXINCj4gY2VwaF9zdGFydF9kZWNvZGluZygpIGFjY2VwdHMg
c3RydWN0X2xlbj0wKSwgdGhlIHN1YnNlcXVlbnQgYmFyZQ0KPiBjZXBoX2RlY29kZV84KHApIHJl
YWRzIG9uZSBieXRlIHBhc3QgdGhlIHZhbGlkYXRlZCBidWZmZXIgYm91bmRhcnkuDQo+IA0KPiBU
aGUgcmVzdWx0IGlzIHBhc3NlZCBkaXJlY3RseSBpbnRvICp0eXBlLCB3aGljaCBpcyBzdWJzZXF1
ZW50bHkgdXNlZCBhcw0KPiBhIGxvY2sgdHlwZSBkaXNjcmltaW5hdG9yIGJ5IGNhbGxlcnMuIEFu
IE9TRC1jb250cm9sbGVkIG9uZS1ieXRlIE9PQg0KPiByZWFkIGF0IHRoaXMgcG9zaXRpb24gZ2l2
ZXMgYW4gYXR0YWNrZXIgaW5mbHVlbmNlIG92ZXIgdGhlIGxvY2sgdHlwZQ0KPiBmaWVsZCB3aXRo
IG5vIGZ1cnRoZXIgcHJlY29uZGl0aW9ucy4NCj4gDQo+IFRoZSBzYWZlIHZhcmlhbnQgY2VwaF9k
ZWNvZGVfOF9zYWZlKCkgYWxyZWFkeSBleGlzdHMgYW5kIGlzIHVzZWQNCj4gY29uc2lzdGVudGx5
IHRocm91Z2hvdXQgdGhlIGNvZGViYXNlLiBUaGlzIHNpdGUgaXMgdGhlIG9ubHkgcmVtYWluaW5n
DQo+IGJhcmUgY2VwaF9kZWNvZGVfOCgpIGluIHRoZSBkZWNvZGVfbG9ja2VycygpIHBvc3QtbG9v
cCBwYXRoLg0KPiANCj4gVGhlIGdvdG8gdGFyZ2V0IGlzIGVycl9mcmVlX2xvY2tlcnMgKG5vdCBl
cnJfaW52YWwpIGJlY2F1c2UgKmxvY2tlcnMgaXMNCj4gYWxyZWFkeSBhbGxvY2F0ZWQgYXQgdGhp
cyBwb2ludCBhbmQgbXVzdCBiZSBmcmVlZCBvbiBhbnkgZGVjb2RlIGZhaWx1cmUuDQo+IA0KPiB2
MSBvZiB0aGlzIHNlcmllcyBmaXhlZCB0aGUgYmFyZSBjZXBoX2RlY29kZV8zMigpIGJlZm9yZSBr
emFsbG9jX29ianMoKQ0KPiBhbmQgYWRkZWQgdGhlIGVycl9pbnZhbCBsYWJlbC4gVGhpcyB2MiBh
ZGRyZXNzZXMgdGhlIHNlY29uZCBiYXJlIGRlY29kZQ0KPiBpZGVudGlmaWVkIGJ5IFZpYWNoZXNs
YXYgRHViZXlrbydzIHJldmlldy4NCj4gDQo+IFJlZ2FyZGluZyB0aGUgLUVJTlZBTCBjaG9pY2Ug
KHJhaXNlZCBpbiByZXZpZXcpOiAtRUlOVkFMIGlzIGNvcnJlY3QgZm9yDQo+IHRoZSBlcnJfaW52
YWwgcGF0aC4gVGhlIGZhaWx1cmUgaXMgc3RydWN0dXJhbCBtYWxmb3JtYXRpb24gb2YgT1NELXN1
cHBsaWVkDQo+IGRhdGEsIG5vdCBhIG1lbW9yeSBzaG9ydGFnZS4gLUVOT01FTSB3b3VsZCBtaXNy
ZXByZXNlbnQgdGhlIGZhaWx1cmUgY2xhc3MNCj4gdG8gY2FsbGVycyBhbmQgdG8gc3RhYmxlQCBi
YWNrcG9ydGVycyB0cmlhZ2luZyBlcnJvciBwYXRocy4NCj4gDQo+IEF0dGFja2VyIG1vZGVsOiBh
IG1hbGljaW91cyBvciBjb21wcm9taXNlZCBPU0QgaW4gYSBtdWx0aS10ZW5hbnQgQ2VwaA0KPiBk
ZXBsb3ltZW50IGNhbiB0cmlnZ2VyIHRoaXMgYWdhaW5zdCBhbnkga2VybmVsIGNsaWVudCB0aGF0
IGlzc3VlcyB0aGUNCj4gbG9jay5nZXRfaW5mbyBjbGFzcyBtZXRob2QgKGUuZy4gZHVyaW5nIFJC
RCBleGNsdXNpdmUgbG9jayBhY3F1aXNpdGlvbikNCj4gd2l0aG91dCBhbnkgZnVydGhlciBwcml2
aWxlZ2VzIGJleW9uZCBPU0Qgc2Vzc2lvbiBlc3RhYmxpc2htZW50Lg0KPiANCj4gRml4ZXM6IGQ0
ZWQ0YTUzMDU2MiAoImxpYmNlcGg6IHN1cHBvcnQgZm9yIGxvY2subG9ja19pbmZvIikNCj4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGF2aXRyYSBKaGEgPGpo
YXBhdml0cmE5OEBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MjogUmVwbGFjZSBiYXJlICp0eXBlID0g
Y2VwaF9kZWNvZGVfOChwKSB3aXRoIGNlcGhfZGVjb2RlXzhfc2FmZSgpLA0KPiAgICAgZ290byBl
cnJfZnJlZV9sb2NrZXJzIHRvIGNvcnJlY3RseSBmcmVlICpsb2NrZXJzIG9uIGZhaWx1cmUuDQo+
ICAgICBBZGRyZXNzIFZpYWNoZXNsYXYgRHViZXlrbydzIHJldmlldyBxdWVzdGlvbiBhYm91dCB0
aGlzIHNpdGUgYW5kDQo+ICAgICBjbGFyaWZ5IC1FSU5WQUwgcmF0aW9uYWxlLg0KPiAtLS0NCj4g
IG5ldC9jZXBoL2Nsc19sb2NrX2NsaWVudC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgv
Y2xzX2xvY2tfY2xpZW50LmMgYi9uZXQvY2VwaC9jbHNfbG9ja19jbGllbnQuYw0KPiBpbmRleCA0
ZjI3YjNkMTUuLmM5MTgzYTM0OCAxMDA2NDQNCj4gLS0tIGEvbmV0L2NlcGgvY2xzX2xvY2tfY2xp
ZW50LmMNCj4gKysrIGIvbmV0L2NlcGgvY2xzX2xvY2tfY2xpZW50LmMNCj4gQEAgLTMxNCw3ICsz
MTQsNyBAQCBzdGF0aWMgaW50IGRlY29kZV9sb2NrZXJzKHZvaWQgKipwLCB2b2lkICplbmQsIHU4
ICp0eXBlLCBjaGFyICoqdGFnLA0KPiAgCQkJZ290byBlcnJfZnJlZV9sb2NrZXJzOw0KPiAgCX0N
Cj4gIA0KPiAtCSp0eXBlID0gY2VwaF9kZWNvZGVfOChwKTsNCj4gKwljZXBoX2RlY29kZV84X3Nh
ZmUocCwgZW5kLCAqdHlwZSwgZXJyX2ZyZWVfbG9ja2Vycyk7DQo+ICAJcyA9IGNlcGhfZXh0cmFj
dF9lbmNvZGVkX3N0cmluZyhwLCBlbmQsIE5VTEwsIEdGUF9OT0lPKTsNCj4gIAlpZiAoSVNfRVJS
KHMpKSB7DQo+ICAJCXJldCA9IFBUUl9FUlIocyk7DQoNCklzIGl0IGNvcnJlY3QgcGF0Y2g/IEJl
Y2F1c2UsIGluaXRpYWwgcGF0Y2ggY29udGFpbmVkIHRoaXM6DQoNCj4gLQkqbnVtX2xvY2tlcnMg
PSBjZXBoX2RlY29kZV8zMihwKTsNCj4gKwljZXBoX2RlY29kZV8zMl9zYWZlKHAsIGVuZCwgKm51
bV9sb2NrZXJzLCBlcnJfaW52YWwpOw0KPiAgCSpsb2NrZXJzID0ga3phbGxvY19vYmpzKCoqbG9j
a2VycywgKm51bV9sb2NrZXJzLCBHRlBfTk9JTyk7DQoNCkFuZCBJIGV4cGVjdGVkIHRvIHNlZSBi
b3RoIG1vZGlmaWNhdGlvbnMuIEkgYW0gc2xpZ2h0bHkgY29uZnVzZWQsIGZyYW5rbHkNCnNwZWFr
aW5nLg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

