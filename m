Return-Path: <stable+bounces-225700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGTUEflquGn5dgEAu9opvQ
	(envelope-from <stable+bounces-225700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:41:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E24EA2A04D4
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 974973031238
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591983F0776;
	Mon, 16 Mar 2026 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Y61tsCKI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016D3F0753;
	Mon, 16 Mar 2026 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693680; cv=fail; b=kla+Xr/7CLOXS9mgppTwvY0z/UJ4IjXRtWr2OFMsZ/w65Dh+FX7CXFrro0VUaUxwaNmGTXPt9KhWcgWSXIT/6MAGmaJRNNMGI7BnBsrYatWiQfdhl9GPtUeuXRhhqQZQO80RchdkSZlMhbmvXM765ksgxX7Y0pOuE9BwuGPxjcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693680; c=relaxed/simple;
	bh=31JxqIFwRQhxmEijPOdDoIwolX2z4FN4a5mVcDCh5O4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZW8BjJGwwzBMyJ4cLma9baM06ScJwSBKiaasDJlfhqQhQxzFGJjh0z9oVBu/T3wJtwEEBvdol5RQ/rXDlsrd3taTHMj+8rqP6lnl5/RIjww+5y0C6mVm0r0+7IToLU/iKJVjg37elgDidrnk930F1TS+GYtL4CrXLKprgpUm/DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Y61tsCKI; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GHg9991879577;
	Mon, 16 Mar 2026 20:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=NoPptf6uL
	Qqxhly5TzDWFS61ugFXPCd7LTZ7ZvVQRKk=; b=Y61tsCKIddUleq9h6Kg4HugbK
	uC1I4FJ7rNVDnZ+Wr7BFLcYcBCkyg6Y+iyK1dLZKOWcglBh9nRT8PY8ODbdpi4Om
	Y6I+GNwLLTgQbsF9OKAXp4k5iS6nOldEIgvP95E3h+M7Xudp7fb2iQEwcqgTGEm6
	YFAmwKUrpXJTjktr4pN/K9wWrRCmo0w01/htt18ABWCuUMGdYUiWgsjoffIoAmo0
	REbo9HBS4fL0+q2WXcSU8Dx14HNoJOt2QIFl4Om+p+FRI0KbCOxhAvMDM/4ieYqN
	Jfixi3eju5nVTixq1/GtM3QWJ596Zdz4a37y2ahytTllyl4SQ4SA738A0Hrtg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cxm668btg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 20:40:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0hA7lJN5SMwAZSz6fNntZPSAABFg82+tXMTcC+aODtN5ag9CA6HOR0BFob0tY8axxaoi5/S0iBK7gnCCzGoAIOxrlcBrqJbJMwo3mneg6xQZAMJJB60KcyfTo2+8WrKtNbWoH+FzvD3L0r1+2pEVO1soC0NA24ixYKBYhmazeFNVFJDB4d+NxSdI1decbiy9Wp/FX7tQOApa9M+N2LwRWSjbPPgAskRwCwz3fRwSZ2bv2jmlvilq7V8JnhrbN5kqO0PA6O7wZRWJsYWnbDle1Scxi6VVtgHKtnqTNs4sE7s02LPHDH8Q4eZL5+7MMnz3+4qCvjb7XDVIvwYIf3BPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoPptf6uLQqxhly5TzDWFS61ugFXPCd7LTZ7ZvVQRKk=;
 b=blYk74UrNyX+UMGsDCgT19RyeyymeH85gmHftVl2TwOyRhXMASftvPBjRYqSj+qYRCgVVENWTyhpqH97/EcE6saSOC30SGACDUcYAlq3gkgS6lFaJXUH/VI6mYqp84lk8xLglYXkB8fpKucr2cgg3foYVPZk86QTGqzJ39yJJSziNu1E2GAVepJnifBf+SUQqnIG/swgq+6WfUva1uT9bFIZkom9zi8OkJABtREAP1RO+27CwWAqdixFk6f9uKj0YOZ6APzXfD+uSKMTYQSyXbRCaPdBCOGZfAXZ8IZ+W0HvG5dYTcMmM0k23ZPyh1SfTXoGpwPBGw4SzUcEMTpphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 16 Mar
 2026 20:40:13 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 20:40:13 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me
Cc: robin.murphy@arm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com,
        ahuang12@lenovo.com, iommu@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v1 0/2] dma: fix dma_opt_mapping_size() returning bogus value when no backend hint exists
Date: Mon, 16 Mar 2026 22:39:54 +0200
Message-ID: <20260316203956.64515-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::25) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SJ2PR11MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: a535b4fb-a29a-49a8-4f71-08de839c3975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|10070799003|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bNnNv1sOenY4QD4nvYGypU7t0aZTYrDa8/GAPJMTJL/o2sfP5kadaSoIP3pb8GxQxYCYEwiY3zwfK/ZW5lavImck1R2pb2ZL8A4Ef3YkTwm2meSMgqG8DfaaQa3duFKbkPjnnXh/McdpwekXPosmvCS9RTALNIPj+6s76t5AVuOObTY3AcdKAgdYjIQThOWmjnTYlJJlZc38qhwoBzBzoq+kbxn6AjLjzi4iWcCx40ymh23munk9gmGAcz7EmzXK5DbESWSyMEZBoXDpj5RaOsKpsCZLfJtjz2wUixxOhNSUXWkaKXdJ2+lad/qQhRK8WtOFztQd+abqhyKYu8tPziPFLZzgbNHmNaNFtoJOQ9kQZyZbYC0bRR9SZ9D/otyYQl/OC0bBwuUwPa9jMnfLF86k9gJcSjPtQTfQTC/9RY/HI1omxXOTXxvAKQwENqWxGZGux3Z2ZttyWfT5u8piAB8KT2QS5sEyduf2IXyGxbYllrFOXOxVfq+qOR1uVSERW5xcgA5DBWaPjVy9pFBzILxcbW1olvlz+vZBJW3Z3oI28f5sQ0rQv/ZE0TdtkwU1LUr46pf3SiWJDyX9LUfIKudfyhY4mdi5C8M72NpIPBaXZlQxHqB3o2CPlimUAoqBkoaW4LxI7awAJyIjagHMN5Vq5K+BGS1hS6CVO3To3sKEYJ7zT/uTapZ4gBr5nnI2nWnN1YkZQDSfBF5blzxjdJr0G7vddtSXVu9KCJHaDtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmR1US9vazBXZVl1M1lmVC9qZjVHT3ZDQ1lHRWQxTDBtTjA3MEdmcmtPeE5U?=
 =?utf-8?B?UUdZUkxRUWxiRml0ekZ4RUJwaks1eTRKSGptS2Z4OXJvVGNMZm5zb3FqVmNC?=
 =?utf-8?B?U3MrblhpbWVZbDA4RVoxK09hNkNyR3lkdzQ4WUJhMXcwREhXaHcrZmk1dkQ2?=
 =?utf-8?B?VFJXSmt5MlZjbE1yenVCczUxRjRUVnRiWnlXNE42dGlTM0tiM0VHVys3RE5E?=
 =?utf-8?B?YTd5azliY0kxckNtTDlHSkVKK1ZwakZFL21XNUQ3THI3Z3FkZFVxUVlkMHcy?=
 =?utf-8?B?THEyby8vdVhIS0FDdXJaNEU3Y04yK3FyVW9nbGIzNHEramlMZTlZdzM0ZktV?=
 =?utf-8?B?N3NJYldQNkRyZG9UZGl2TFEvN2kwVkxtTFNDZnpLdmVIOGJlQzNuNFpabGFo?=
 =?utf-8?B?R283bUhVd1Q3RWlaWXJNUmpKRXNaa2hNN0Q0OTdybmFZUzFWNUN3NHVDcnVY?=
 =?utf-8?B?SW41R0d5M3F1WU5WZEZqMFI0QVVudlZyOWlBbHNXZ1QvVk9FMnVWTXVjNnEw?=
 =?utf-8?B?TmZjcE13SlZZalFzTmNrWEEva1piODlGVjJHcEtuYis3TzN6dDg3cnBqMVVW?=
 =?utf-8?B?dG10YUtCYmdRNXhuMlhEZGpPZ2lqQlNMOHgwVk1WeEJ2Ti9NaVJTNXBUcHFi?=
 =?utf-8?B?YkhNaDB2KzVpaXg3R3F4M25nbzQrTDArbXJGMmRIdWQrYmdiY3VsbDdvcmZM?=
 =?utf-8?B?VFFjOHljNzZ1WnpNK0ZlQkplS1R6SlRSMHNYUzFFTWxYZUZXRmZVeUZzRWFi?=
 =?utf-8?B?RE9haTdjekRadjVYZ1F3dnNUV0o5SFhSdWlkQ1pqYmNNeUhWSzhIVW5Wa2VK?=
 =?utf-8?B?UjMxMVBaMWRoRFRtTnFxZzNZTzFWb09jeW1LbHBjdGp2czdDSGJmYVUzVnl1?=
 =?utf-8?B?dXo3bUN1V0ZGM0ZyS2VWUkViNVFHWmZ0NjVORUVNK2ZQdG1lUEJTemhFQzU3?=
 =?utf-8?B?Q0wvVzNhWThOdisrTU5tTDdvL3B3bjZnZnRWZjd3aFdNeUpPWElZS3ZubzhJ?=
 =?utf-8?B?NXF2blpoNXd6ZnNvWW5heTVBOGhaMFNTaDdYeFlYa2N2cjhrQ0FSSm5VM1Vh?=
 =?utf-8?B?N0hIaDd4bldFUFVTTVlrNldVRUFzZVdiWTRENDVLdTlINGJuUjY1NDJLRkts?=
 =?utf-8?B?UktvSWhFaEJ2SVJTL1NhaVFoT3ZkUm5Hd2FUc2JjeGFJREppd3A3clA1OVZF?=
 =?utf-8?B?dktaRnoxbjcweFIwQ2NmMlVySm1HM0RmYXBlWEJWNitLV1hLZUVWdXozV1lB?=
 =?utf-8?B?ZXNaTXNFSUR5b2FuZ3NMZUIxSDJpVDVtLzlISDBTTHR2NWoyUmlueE1MUVln?=
 =?utf-8?B?ak93M3JYWm5tT2tKN1pIWllKSmFEL3BlUFhkT3ZxRGxLRS9XdWNPQXo4WnRs?=
 =?utf-8?B?MDZJUWx4d2pGQUJxcENNYVo5aWg2OGJXQ1gzRDZhcVRZSWtwMmhVc1pEQ1l2?=
 =?utf-8?B?OFk4RnloaUxZQTZQY21RS1E2aklhK0ovQnZlVW9hV0hIcnQ0RURNNCtrOWxY?=
 =?utf-8?B?QjIwQktLNytqYzd2OTBVN0xrZUxnc1BCYzg5TmdrSnNqL203cXdOTjJ2SUUv?=
 =?utf-8?B?U1JZd1dxZHR5TEg0OFVoaEhsZUJ6SE9zay9lQzUvamJBbWtYamhEWTVMVHlB?=
 =?utf-8?B?ZHRwNk9tcDR1TjQ2OWYwNjdsVXZYTDgwSDd1RDRqOTdkQWZXVlVmSncwb01H?=
 =?utf-8?B?bnpLTkhkYlhUZ0JTSG9aZy8xMXdSd2NkaFJ6MGY4L3JaamJQTml6NjVkdlVl?=
 =?utf-8?B?MENmZURBUS96T2U1K1ZHYWNGWTIvQlljbmQxLzVVcVhiTnU2ME5ZV0JZbG05?=
 =?utf-8?B?b3RIQ1VxQTMvZkJCUWk3WlJNVWs5RVJYbW9MZUh5UHk4UklVc1JydnFINVBP?=
 =?utf-8?B?c1QyMElSK0w3YTc2K1R3M1hUYWhESW80Y0ZDUXhuOTE2Nm9qamhRZWxXdS8v?=
 =?utf-8?B?cUNFbHN1cjNQKytZQUpZT3Q3b1lKdXMxb3o3UDgwZU54Y0ZVemZoS3BRZ1Ir?=
 =?utf-8?B?OHNJbURNZWpVY1QrZTRERll6RUcvRVVJNHNBcytSVVdhTEZWMmRORmtRd3hG?=
 =?utf-8?B?aVpMbGRSUk5PM2JrblNjREYyOWJjSU9pdHo5ZG0raTJwdmh4aVBOaUovaVVL?=
 =?utf-8?B?MitMM1hJOVhEYjE1RUZMbGJYSUdCWFlLazYvajFqOW05MlMra0g2L2ZUT29U?=
 =?utf-8?B?NCtuUUdlMERaejNrTU1PT3RGL3cyM28zMXZmUkdERGpQUi9OTEpvcHpSVGtu?=
 =?utf-8?B?SU9oMlI1U2tPZ1IvU3BkZUh5ODh1ZnNMTzZiSzArL0dtcFlFK2VJYjJCNlJr?=
 =?utf-8?B?WTVYSmN6UnNJVzVmNnRtMW1LdmY5ZFZzamVTUldJUW1yN3ZGdGFQME5EM083?=
 =?utf-8?Q?uVTJVSF82XSrb/qoXm9IcP/eRwKnbsy9zFDKzigwQKq9n?=
X-MS-Exchange-AntiSpam-MessageData-1: QROsSk2Ls0zfRTwzyYbMrf4k7AA79BgQ1sA=
X-Exchange-RoutingPolicyChecked:
	XFnAzaw7Ni/EDbrlg/Og6YWR+2RdqSUh3NgMyi26ZNHnb3jw9GyTF3Hhgceispdg1OKqiFL/GrphkzoZ1CecRvGlH1qNc5TU/+UGnZh5522jedh1MisAJX8XY0+wEAhpCzfqtvf0ECfabJ7u03AKfhe9HC17i1/oHIOnqq6J5bVfojBbFgG/cSwCWYPlmzp/04opAijj9zXj55z/rCGluW1MJfpv0qh3dOpEv0cGfdy/C58c1AF8w8wOBNnKi1/fkeUsDlWqzgsUfQUfq8rPo/FucJDtpatyeCTeiIHY2a/nNyxb/H6fnrZU22FKlgB8eq6N5v2bHsD8+u7GED+/zQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a535b4fb-a29a-49a8-4f71-08de839c3975
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 20:40:13.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSIpMta6XfDgqLr1DwsVCT866H/CavZ6foxIJaz842yMfDK1O/89JMMiuH6QjH3EayIR1W52zJCG6ZesMqo2wuYZmg+/CxMVvwdbqKOvw5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8370
X-Proofpoint-ORIG-GUID: ANPAg6dkCaD2NuBBhDseX5R8JYEe2eSd
X-Proofpoint-GUID: ANPAg6dkCaD2NuBBhDseX5R8JYEe2eSd
X-Authority-Analysis: v=2.4 cv=fLk0HJae c=1 sm=1 tr=0 ts=69b86ab3 cx=c_pps
 a=F2A7jaVQFOduNxX/8CKReg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=zhf57jD7ADIg8AuCfh4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE2NiBTYWx0ZWRfXyF6lkqL5Xgyl
 mjTrApBGwXF78x++TLpZcLOV0hKIlehxSYj9hMqtUKe3oMXPhijohe4tHI2AyIPy8Q9VzbzFpWO
 8i5C/790XKi2FLIRQ9Gy/G6xurNBkgPWLdXMjme5cC1THVj+paRtDSs/DTOar9qUoUnLJb0YbFU
 iGuMHcvxtDLD1HbSJoGIYYaZCurxTAMJIaPY8Jq2Q5gdgzWHoPdGDWVaZZrzBFyiUUZPUOcSsiJ
 LpSvhFBXMj4RSVyYwDSTZm7HplNvNyU/bnUFSKRlKex8LjK97CFUkEy4uyzahjEcPiJ9+3OCaOt
 xxsYoSW8qEKL6yXDQKPz7Qdrg+crRYbmMLOquvja5aRQ2UylAXftmayI2LrkG3ppkkkOOhM5FzX
 KcZRJ+Gyx28oMSHjF3DmeMYZyffLDXKjrXdJuEOwM7w5yiDwv3hOET/KPJ6sUmW1JGitiEifBbK
 xS3hn38gmBsiwoDS14g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160166
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225700-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com,windriver.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E24EA2A04D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dma_opt_mapping_size() currently returns min(dma_max_mapping_size(),
SIZE_MAX) when neither an IOMMU nor a DMA ops opt_mapping_size callback
is present.  That value is the DMA maximum, not an optimal transfer
size, yet callers treat it as a genuine optimization hint.

The concrete problem shows up on SAS controllers (e.g. mpt3sas) running
with IOMMU in passthrough mode.  The bogus value propagates through
scsi_transport_sas into Scsi_Host.opt_sectors and then into the block
device's optimal_io_size.  mkfs.xfs picks it up, computes
swidth=4095 / sunit=2, and fails with:

  XFS: SB stripe unit sanity check failed

making it impossible to create filesystems during system bootstrap.

Patch 1 changes dma_opt_mapping_size() to return 0 ("no preference")
when no backend provides a real hint.

Patch 2 adjusts the only other in-tree caller (nvme-pci) to handle the
new 0 return value, falling back to its existing default instead of
setting max_hw_sectors to 0.

Note: the scsi_transport_sas caller (the one that triggers the XFS
issue) already handles 0 safely.  It passes the return value through
min_t() into shost->opt_sectors, which becomes 0; sd.c then feeds that
into min_not_zero() when computing io_opt, so a zero opt_sectors is
correctly treated as "no preference" and ignored.

Based on linux-next (next-20260316).

Ionut Nechita (2):
  dma: return 0 from dma_opt_mapping_size() when no real hint exists
  nvme-pci: handle dma_opt_mapping_size() returning 0

 drivers/nvme/host/pci.c | 15 ++++++++++-----
 kernel/dma/mapping.c    | 13 ++++++++-----
 2 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.53.0


