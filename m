Return-Path: <stable+bounces-219602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKu7DaHxnmnoXwQAu9opvQ
	(envelope-from <stable+bounces-219602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:57:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0798197AF7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B48693047BD2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83CC3B5319;
	Wed, 25 Feb 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZjqaredD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB733ACEF9;
	Wed, 25 Feb 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024202; cv=fail; b=Y1yAj1zg4Fg+WNRyEfwrF6Y2DcK0TtT3i37txgNqeFkFb9tjWSvCFuEe+GZPSsbX+CKGY/yo2+bl60/ZaeedCXAzb8S+15Bs157fOT3rx4udv1P1gngFUySQ+AAjdKvZW5F9RrFWlIBc6yFmOXKph6CBdWWkavpyDofFDcLLp6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024202; c=relaxed/simple;
	bh=wGnnrY2qLfsoC+FRfYbV/Scire96Wek9JSkid/D2gOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUq1IaEDm2YnZ1GWPnZWDlAzPE4J+qJe2g47+26QfrDZBkMOxybMsQS8+GW8LvDaFhhmt3Z1hMHLw9ls3u6MhJwrm35Nz5e1wU0FUryI5Jan2m1fg9CZnLWuyGxCwyhe4J0OMkr4swWzKi9Pn8HCZJRiuSaH7DtPxxxT14VBI/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZjqaredD; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P6jKSS3630199;
	Wed, 25 Feb 2026 04:56:23 -0800
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021083.outbound.protection.outlook.com [40.107.208.83])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4chf1mtmya-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 04:56:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAIix3j9rlwKHYxLP8xKLDCgFnarkDTgy0/isyBlQe7fgKiqcX6ZZ/ijc4Oj/jEjZvSeyMGUw733aMK9xcl64Fr1cJ403yeOvvvgm8NhoIrKNs94/rGkrJO7KhtN1YfBf0Wumja4DWTo4/kOq+Owl0vkbmmnovac5q6oOCXIBCZ6aGKbTwHkZduH3DS4j+JL84y6iCFLuVEwQLNTkA4VZ1jasi0hw2WEP9AdKnkSbrs38H4FWEJVtlcOEZR2Pmnv29RibWqwrBtyapn8LeozHVsOWV+Y+wUenZmcGEABcxv70dHLjjc8gv77d2oMdZG4mWRq1QWZLhAftAAhS70ltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGnnrY2qLfsoC+FRfYbV/Scire96Wek9JSkid/D2gOw=;
 b=MlR44m1k0Bj3ujifeMlmJxlzY4twV9Fxx35oWfduDHH5yOiNQG4p7poT1HMDVudZSk7k8L0mQ5zybk5T7XH0s8ZoF4HT1meWGcBRE/YSEYLUs59fJtNGLxUDJrvxG/bEBaoM8tNGpCW7e3PpsrawroO7qcRkwUu5G0ehlVYkLBGuCh7jIvXI9KwgA3RFcJkY3uww4E1XgAlhU6aJ6vCR2z+9SSmINmHhcZTrqDK7HwOIO3kaJUGO3rHMgr2scIivHLzY8o/saj5c8czDyhu5s/wZ77nwMxDjeo0jQ3aZgUkibyYM96GNbhLAgEh0TZAjnznbO03jNttdPmeLJtXcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGnnrY2qLfsoC+FRfYbV/Scire96Wek9JSkid/D2gOw=;
 b=ZjqaredDvkoQMFJJmeUPvIuZ+ck8EK0ElW7TiJCujZov8tEhe+GdL34uU91++/DfvsvmB9Ze1UUocNo6l8HmNa5aVsewfikRN6JetmSYMJnzy+ZSEURyZ/hvef6MiQVAiFO3V8h9v0iUnkeT/zL1MD7gjjIM2nwzr8mo8IaNiZc=
Received: from BY1PR18MB6374.namprd18.prod.outlook.com (2603:10b6:a03:5aa::19)
 by SJ4PPF878B471A8.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f2c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Wed, 25 Feb
 2026 12:56:20 +0000
Received: from BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374]) by BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374%5]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 12:56:20 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index:
 AQHcpVsOKxOBWB2/y0CrIf5i5ji46rWTMV0AgAAk+ICAAAJzgIAAAelwgAABfwCAAAGJIIAAAtEA
Date: Wed, 25 Feb 2026 12:56:19 +0000
Message-ID:
 <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
In-Reply-To:
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6374:EE_|SJ4PPF878B471A8:EE_
x-ms-office365-filtering-correlation-id: 857a170a-a4e3-4a76-d5d2-08de746d4589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|7142099003;
x-microsoft-antispam-message-info:
 x4U3GpwIRsoC1817iSEN8VNi2nWN+J4tWmvfNbFqpqHyHvXSWnI/OM/ZRRNr9j2vUTrTqvnqhTkDYMf77xBoljVQ1kwmVMBSlxm+fPHQkmR+s9I+W3/WIGwo5TQNXlchyJK5HXkrwwd/Otxz/EP8XloAb5scVtS0nQALSODlT5AhZ6XLyhg+SCa7IzT+Rs7q3TXju6RqA9ecmOLNKPHN2VXy8ufkyGTbtwU9jUqLxN+Zy91rTdkvXN28k+ruBzgg9L1j5TD8SYNduKpIcH8Lwy4KL2NkMPWBzRwffjB8NCy1DcipV2RVRLzI2uzqReJwJQVbaGaqbGjQi2ALPYy47EMHpf1UESfUPfDClRXVTQyOj4uFl9uMug3tgsmMt36qytyFb0DBRw1CvbbHBR+zhFAeng5/eQ7I9mJCjWm3XQIW13ze/G2swJYNbahzzcYIk3+t72H97w9T21l0dSzPkhA4VRkIy9GpWvl/yZlf7JK0b643PJ8Nts0URcJLcqsxfbNpqoiIpcbd+N8IeFakYGPyKAB/n6N/H8HHZm2VU2jOWpq/z8tUe0UqqRzbOHNSEW0xNIewaYqdMz1w4GWUilb/UuD18IBAEG94Tve947B/EBpr5LFZDz0XxCj3yjPNx77aRDt/iI5k+qzHT7Q9c3tnN9WsgbCytY9hBSoJMEkzwbJ9ln+cByiwGVZ/SGVvPLyV06GWTjZg4CfcpF4M5b6Uw9j8rQq89XUKq0qvHLalYZ1SmZ3Xg89TeIcae1nh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR18MB6374.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(7142099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amtPQ0JqaDBockFpTGlpd2NIMWRQckxYYTFmYXlBMDVkZ2xzemMyVEpqVEJF?=
 =?utf-8?B?MWJQd3B1UUtzdHVlMldlcUVoOHRZbnplK1B6S0c2YkpSeHBSWDVDcUV0cFBB?=
 =?utf-8?B?VXNJOVNEWW1qSW5qSDZUa3AvaUVHcVhxWFBTWHJIeThQdkhVRFNLZHJVWkRR?=
 =?utf-8?B?WjRLS01sRGdHN3k4THI4anY0RkYzby9Qbmp5QjMvV09iT0tsTElQZE03ZTB0?=
 =?utf-8?B?TnVnM05xdUNnQy9hdktIWGNTK0FHZTIxWUhFSFJrVEZGeE9nQUlzYU5iNDBz?=
 =?utf-8?B?UVQ1M0s0Z2JhcTU0NU1RWGhYZkxtbUFSaXo3bXMrTDhlOVZFUG5qWlhZdVdG?=
 =?utf-8?B?U0kyZ0VxbWpxdk1xSFMrSWduK2dtQWZHcW1rMTdBVUhIOHQvVTkzSGJUR2tm?=
 =?utf-8?B?eU5NUlJqbTdMYm9VNy9OOFFMdXBScUE2dy9tSmNkRVZYZFkzbFZUSHBVNUpl?=
 =?utf-8?B?aXgwUWlVZ3p0WWs4R254TG1zaWtnNzNQa3NtVkxycEhZOURjYUhlQjFXMXRl?=
 =?utf-8?B?amRSaklxWFJiTnNFNU9QT3lJZ3Y2U214bm1XanBzdzFGWXlITnFaem1Ldkpp?=
 =?utf-8?B?eFc2NXF2WC9vWlRYOTBycHpTelRZT1N0elhCY1hCZzd0ZU4yNzhVWkFaSFhs?=
 =?utf-8?B?UE14T0tRNUhCYWlLM0x4dWF6VzNmMlNPWUhDTGxKSUFUdnJnUXgzT3FpMlh6?=
 =?utf-8?B?UENQNG0xTGhGWDVLL0h1NjUvUWFyaGkzTTh3WEV0dkRKUFJtYjNDYXZVZ2t4?=
 =?utf-8?B?OTdZMFZBbjBxRlM1bVBjV0xVTXlyZVFuRE5tK0ZDMVpnMUhFaHZIN2gvS1RX?=
 =?utf-8?B?U0lwK3dsVyt6d2Y2aW1lMVRUOWllNHh1c1VGTCtQVWtFd3FMTDhJMGVKQmlC?=
 =?utf-8?B?RmNWK3ZvdXh2V1BVaVdnYWNJcTBwWGZXYWJWc2dlWVUwTWtsSFRZRnZMdk51?=
 =?utf-8?B?OEZ4L1hGbXRESm5iNEFNdjNLVFkya1FITmoxdHZlR1VSRTdJWjlOcXprc3k3?=
 =?utf-8?B?SmhGaGYzbEVJcFVQbGlBTGNIb3pXSkx3dmdNMmVpeVJEd05qREVjZ2VZUjZR?=
 =?utf-8?B?bjMzckpwM2hMeDJ0RXRqUnlYZ3F5TXQ1aEx4WDZXdWdoU2hzVFBVR3c3ekl1?=
 =?utf-8?B?b1dDcWs3WVVqbkFrYk1ISlFWL1hoeFB6RVhZZjFKTzRBak1TUWtTT0lud1Jl?=
 =?utf-8?B?MXVzdVRXajlkNE1jTFJvcVd1RjhRWVJIem52R2dCUTNsT1V0SkNHR3U2TzFF?=
 =?utf-8?B?MHlxcFNpR1VNQ0FjTHNmajZReHo4aThKbmVXdkJxU1FRbzFqWWpQTklPWGFr?=
 =?utf-8?B?YkVsTW9kT0JyRC9Fb3YrdWZUalVkdThKN202a2U1bGRKN3ZseGVOM0w1WmVz?=
 =?utf-8?B?T2tSeFdkZFc0d0dEU1JCRFVLQmF6OGtJZFFleHJDbmloKzNOUURFUThDS2hT?=
 =?utf-8?B?VkRmdzFqKzZKRGQweFM4dDBjemlLenQzdkVtMmhidEM4ZXN6dWZlby94Lzlj?=
 =?utf-8?B?cjJqSjUrQWw4bldWNEpjMnpnbkdwL0FVTVZCZDZCZFhSVjg3SVdTWDBUMkJJ?=
 =?utf-8?B?cjIzaGh3dUd0eDUrNkRDb0JXOG1BRFNUSHgxdTNXUkVZWVBmbGFyRUw3ejVC?=
 =?utf-8?B?cWFWb0M4cXZTQzR0TGhKNlNHMEN4ZllMNkFGTFlxS2VPYmIxbXp4S1FqUXR4?=
 =?utf-8?B?MEQwcjFhaFQ0NCtpQmpTREFoVkRyY2tENndjZmNNZ1Uyd3U5dU11ZGNjNlFj?=
 =?utf-8?B?NGFXRTdLdDU0dkU3alROdm40OFJBK3ZtYmd6Tm9wQ1RKWnRGSGVrdkM5Yzlj?=
 =?utf-8?B?akFwZlFNZTZLazZGcThMVDVXb0RvMXBBazRWZjRDRVJZakxEYjErZHBONWFV?=
 =?utf-8?B?ZEpHZnJqTHRpVGhhZmdYWFJqZEpjSlpleW52WldpZmZBRmZwcEpldHhyQzEy?=
 =?utf-8?B?RmVZRVc2MTJ5QzBELy83bEUwZ3RZUUMvT3JOWVg3OGdnRGtCaW1Wa0hVcnJZ?=
 =?utf-8?B?cVh3Mm0xKzNIZXFlQ0Z0aHh0cUZHRWlFWDhyM3N6OEFKU1hHLzYxT0M1VTcx?=
 =?utf-8?B?N2s2N0hJaTB0NFJFWm9VUlI3cEw3UXBUYm1JYy96dXVLNDlRdFIvQWllbWxK?=
 =?utf-8?B?YURUUXNQUzdFYWlVT2JHc0xMaGlRTFpIUm94ajM2VzQ3RWZXek9WdkFJOTF1?=
 =?utf-8?B?bEhuMXlTT1h0YkVlTHJEelZhSGRYTzBxcVpMOVNodG15b0cvV2dtd0JXeHRS?=
 =?utf-8?B?SVlzWmZVOUNoVllTdUk2T1NTdjNTMGlLRUtLb2VWWE5JTHFMZElYdEFpVCtS?=
 =?utf-8?Q?D1V8uAH8l4cAwgV0VP?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6374.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857a170a-a4e3-4a76-d5d2-08de746d4589
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 12:56:19.9875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //UnX791cS6vYXmBmGJFlGWrBdvg1VEIQm20i0PTMLp5sKg8C9liIAofB+G9YkeKuVK9w4rYva7gIRBm8ehCZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF878B471A8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMyBTYWx0ZWRfX0DcHngnUOuWp
 GNBcMlu9Gf1sLgoX7PTkw/74pSBEeks/dKGC2uBHJUYqITlk9aSUruKJhfv8w4FkhD/EeAx0s9S
 ADfbrBFafuYkBdBRcU1JQZlwbFwsJwYVrrBHJqOXfuw/g8zt809BKOuJ+bU6NPWA5m02zX5bh0x
 yRv2wFXtoOUQMSU17VenX2WrzZTdWn/8rEFM/NnZ7RM3w021e+l8lXBMprTzqygGu8CsvR/slUU
 auYfzZRc5mq3YSJAQEbWIcF0oA/1fQ3WbbcTqoRU485KsraU43M0iR8Gn3h99wvWg2VGziRA/5o
 FD0ozhVjFIuPyP1oc9ZS9gz8hZCWo0AtDX5sxjOvm9+Cn9Be09GWsrFtWmYzLq/hZylbxc0Lbb2
 0IyuOEvEFir2QDTMZ2N8MBLiLgNwby2WBXSUp16u/y7QHR1Hx6Tww+5eixmFlMpXeR2qx74S9K4
 Sg6Fwb5cB2BARAIkbzw==
X-Authority-Analysis: v=2.4 cv=a+c9NESF c=1 sm=1 tr=0 ts=699ef177 cx=c_pps
 a=JzGR8r3o28cAtrGeABx37g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=20KFwNOVAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=J1Y8HTJGAAAA:8
 a=1XWaLZrsAAAA:8 a=RpNjiQI2AAAA:8 a=RAc5HzTHCQYeEt02PhIA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-GUID: 2wHVwt26eSf6Kah3Q45r4Dfpw8Bag7sA
X-Proofpoint-ORIG-GUID: 2wHVwt26eSf6Kah3Q45r4Dfpw8Bag7sA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219602-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,linux.dev:email,proofpoint.com:url,BY1PR18MB6374.namprd18.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E0798197AF7
X-Rspamd-Action: no action

PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI1LCAy
MDI2IDY6MDcgUE0NCj4gPiBUbzogU3J1amFuYSBDaGFsbGEgPHNjaGFsbGFAbWFydmVsbC5jb20+
DQo+ID4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LmRldjsNCj4gPiBwYWJlbmlAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsgeHVh
bnpodW9AbGludXguYWxpYmFiYS5jb207DQo+ID4gZXBlcmV6bWFAcmVkaGF0LmNvbTsgZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4gPiBrdWJhQGtlcm5lbC5vcmc7
IE5pdGhpbiBLdW1hciBEYWJpbHB1cmFtIDxuZGFiaWxwdXJhbUBtYXJ2ZWxsLmNvbT47DQo+ID4g
U2hpdmEgU2hhbmthciBLb21tdWxhIDxrc2hhbmthckBtYXJ2ZWxsLmNvbT47IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW0VYVEVSTkFMXSBSZTogW1BBVENIIG5ldCx2
NCwxLzJdIHZpcnRpb19uZXQ6IEltcHJvdmUgUlNTDQo+ID4ga2V5IHNpemUgdmFsaWRhdGlvbiBh
bmQgdXNlIE5FVERFVl9SU1NfS0VZX0xFTg0KPiA+DQo+ID4gT24gV2VkLCBGZWIgMjUsIDIwMjYg
YXQgMTI64oCKMzQ64oCKMjhQTSArMDAwMCwgU3J1amFuYSBDaGFsbGEgd3JvdGU6ID4gPg0KPiA+
ID4gPiBPbiBUdWUsIEZlYiAyNCwgMjAyNiBhdCAxMjrigIoyODrigIo0OVBNICswNTMwLCBTcnVq
YW5hIENoYWxsYSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gUmVwbGFjZSBoYXJkY29kZWQgUlNTIG1h
eCBrZXkgc2l6ZSBsaW1pdCB3aXRoDQo+ID4gTkVUREVWX1JTU19LRVlfTEVOID4gWmpRY21RUllG
cGZwdEJhbm5lclN0YXJ0IFByaW9yaXRpemUgc2VjdXJpdHkgZm9yDQo+IGV4dGVybmFsIGVtYWls
czoNCj4gPiBDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkgYmVmb3JlIGNsaWNraW5n
IGxpbmtzIG9yIG9wZW5pbmcNCj4gPiBhdHRhY2htZW50cyA8aHR0cHM6Ly91cy1waGlzaGFsYXJt
LQ0KPiA+IGV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhrcVchdGMzWjFmOFVZbldhdEst
DQo+ID4gOFdiMzZEcHI5RkpYWk1Cd0V1Z0hqMXhDR3dSbC0NCj4gPiBkTlhNX0k4WWs3aGJiandD
SGU5V2hnUXdtR3gyTXM4NWZJa1NtS00yZEJRZUg5RGt6YWskPg0KPiA+IFJlcG9ydCBTdXNwaWNp
b3VzDQo+ID4NCj4gPiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+ID4gT24gV2VkLCBGZWIgMjUs
IDIwMjYgYXQgMTI6MzQ6MjhQTSArMDAwMCwgU3J1amFuYSBDaGFsbGEgd3JvdGU6DQo+ID4gPiA+
ID4gPiBPbiBUdWUsIEZlYiAyNCwgMjAyNiBhdCAxMjoyODo0OVBNICswNTMwLCBTcnVqYW5hIENo
YWxsYSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gUmVwbGFjZSBoYXJkY29kZWQgUlNTIG1heCBrZXkg
c2l6ZSBsaW1pdCB3aXRoDQo+ID4gPiA+ID4gPiA+IE5FVERFVl9SU1NfS0VZX0xFTiB0byBhbGln
biB3aXRoIGtlcm5lbCdzIHN0YW5kYXJkIFJTUyBrZXkNCj4gPiA+ID4gPiA+ID4gbGVuZ3RoLiBB
ZGQgdmFsaWRhdGlvbiBmb3IgUlNTIGtleSBzaXplIGFnYWluc3Qgc3BlYyBtaW5pbXVtDQo+ID4g
PiA+ID4gPiA+ICg0MA0KPiA+IGJ5dGVzKSBhbmQgZHJpdmVyIG1heGltdW0uDQo+ID4gPiA+ID4g
PiA+IFdoZW4gdmFsaWRhdGlvbiBmYWlscywgZ3JhY2VmdWxseSBkaXNhYmxlIFJTUyBmZWF0dXJl
cyBhbmQNCj4gPiA+ID4gPiA+ID4gY29udGludWUgaW5pdGlhbGl6YXRpb24gcmF0aGVyIHRoYW4g
ZmFpbGluZyBjb21wbGV0ZWx5Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4gPiBGaXhlczogM2Y3ZDljMTk2NGZjICgi
dmlydGlvX25ldDogQWRkIGhhc2hfa2V5X2xlbmd0aA0KPiA+ID4gPiA+ID4gPiBjaGVjayIpDQo+
ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNydWphbmEgQ2hhbGxhIDxzY2hhbGxhQG1hcnZl
bGwuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0tLSBzaG91bGQgY29tZSBoZXJlIGJl
Zm9yZSBjaGFuZ2Vsb2cuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiB2MzoNCj4gPiA+ID4g
PiA+ID4gLSBNb3ZlZCBSU1Mga2V5IHZhbGlkYXRpb24gY2hlY2tzIHRvIHZpcnRuZXRfdmFsaWRh
dGUuDQo+ID4gPiA+ID4gPiA+IC0gQWRkIGZpeGVzOiB0YWcgYW5kIENDIC1zdGFibGUNCj4gPiA+
ID4gPiA+ID4gdjQ6DQo+ID4gPiA+ID4gPiA+IC0gVXNlIE5FVERFVl9SU1NfS0VZX0xFTiBpbnN0
ZWFkIG9mIHR5cGVfbWF4IGZvciB0aGUgbWF4aW11bQ0KPiA+ID4gPiA+ID4gPiByc3Mga2V5DQo+
ID4gPiA+ID4gPiBzaXplLg0KPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gIGRyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYyB8IDM0DQo+ID4gPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0NCj4gPiA+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYw0KPiA+ID4gPiA+ID4gPiBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBpbmRleA0KPiA+ID4gPiA+ID4gPiBkYjg4ZGNhZWZiMjAu
LmVlZWZlOGFiYzEyMiAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYw0K
PiA+ID4gPiA+ID4gPiBAQCAtMzgxLDggKzM4MSw2IEBAIHN0cnVjdCByZWNlaXZlX3F1ZXVlIHsN
Cj4gPiA+ID4gPiA+ID4gIAlzdHJ1Y3QgeGRwX2J1ZmYgKip4c2tfYnVmZnM7ICB9Ow0KPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiAtI2RlZmluZSBWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJ
WkUgICAgIDQwDQo+ID4gPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiA+ID4gIC8qIENvbnRyb2wgVlEg
YnVmZmVyczogcHJvdGVjdGVkIGJ5IHRoZSBydG5sIGxvY2sgKi8NCj4gPiA+ID4gPiA+ID4gc3Ry
dWN0IGNvbnRyb2xfYnVmIHsNCj4gPiA+ID4gPiA+ID4gIAlzdHJ1Y3QgdmlydGlvX25ldF9jdHJs
X2hkciBoZHI7IEBAIC00ODYsNyArNDg0LDcgQEAgc3RydWN0DQo+ID4gPiA+ID4gPiA+IHZpcnRu
ZXRfaW5mbyB7DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ICAJLyogTXVzdCBiZSBsYXN0
IGFzIGl0IGVuZHMgaW4gYSBmbGV4aWJsZS1hcnJheSBtZW1iZXIuICovDQo+ID4gPiA+ID4gPiA+
ICAJVFJBSUxJTkdfT1ZFUkxBUChzdHJ1Y3QgdmlydGlvX25ldF9yc3NfY29uZmlnX3RyYWlsZXIs
DQo+ID4gPiA+ID4gPiA+IHJzc190cmFpbGVyLA0KPiA+ID4gPiA+ID4gaGFzaF9rZXlfZGF0YSwN
Cj4gPiA+ID4gPiA+ID4gLQkJdTgNCj4gPiByc3NfaGFzaF9rZXlfZGF0YVtWSVJUSU9fTkVUX1JT
U19NQVhfS0VZX1NJWkVdOw0KPiA+ID4gPiA+ID4gPiArCQl1OCByc3NfaGFzaF9rZXlfZGF0YVtO
RVRERVZfUlNTX0tFWV9MRU5dOw0KPiA+ID4gPiA+ID4gPiAgCSk7DQo+ID4gPiA+ID4gPiA+ICB9
Ow0KPiA+ID4gPiA+ID4gPiAgc3RhdGljX2Fzc2VydChvZmZzZXRvZihzdHJ1Y3QgdmlydG5ldF9p
bmZvLA0KPiA+ID4gPiA+ID4gPiByc3NfdHJhaWxlci5oYXNoX2tleV9kYXRhKSA9PSBAQCAtNjYy
Nyw2ICs2NjI1LDI5IEBAIHN0YXRpYw0KPiA+ID4gPiA+ID4gPiBpbnQNCj4gPiA+ID4gPiA+IHZp
cnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpDQo+ID4gPiA+ID4gPiA+
ICAJCV9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfU1RBTkRCWSk7DQo+ID4g
PiA+ID4gPiA+ICAJfQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiArCWlmICh2aXJ0aW9f
aGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX1JTUykgfHwNCj4gPiA+ID4gPiA+ID4gKwkg
ICAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9IQVNIX1JFUE9SVCkpIHsN
Cj4gPiA+ID4gPiA+ID4gKwkJdTgga2V5X3N6ID0gdmlydGlvX2NyZWFkOCh2ZGV2LA0KPiA+ID4g
PiA+ID4gPiArCQkJCQkgIG9mZnNldG9mKHN0cnVjdA0KPiA+IHZpcnRpb19uZXRfY29uZmlnLA0K
PiA+ID4gPiA+ID4gPiArCQkJCQkJICAgcnNzX21heF9rZXlfc2l6ZSkpOw0KPiA+ID4gPiA+ID4g
PiArCQkvKiBTcGVjIHJlcXVpcmVzIGF0IGxlYXN0IDQwIGJ5dGVzICovICNkZWZpbmUNCj4gPiA+
ID4gPiA+ID4gK1ZJUlRJT19ORVRfUlNTX01JTl9LRVlfU0laRSA0MA0KPiA+ID4gPiA+ID4gPiAr
CQlpZiAoa2V5X3N6IDwgVklSVElPX05FVF9SU1NfTUlOX0tFWV9TSVpFKSB7DQo+ID4gPiA+ID4g
PiA+ICsJCQlkZXZfd2FybigmdmRldi0+ZGV2LA0KPiA+ID4gPiA+ID4gPiArCQkJCSAicnNzX21h
eF9rZXlfc2l6ZT0ldSBpcyBsZXNzIHRoYW4NCj4gPiBzcGVjDQo+ID4gPiA+ID4gPiBtaW5pbXVt
ICV1LCBkaXNhYmxpbmcgUlNTXG4iLA0KPiA+ID4gPiA+ID4gPiArCQkJCSBrZXlfc3osDQo+ID4g
VklSVElPX05FVF9SU1NfTUlOX0tFWV9TSVpFKTsNCj4gPiA+ID4gPiA+ID4gKwkJCV9fdmlydGlv
X2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfUlNTKTsNCj4gPiA+ID4gPiA+ID4gKwkJCV9f
dmlydGlvX2NsZWFyX2JpdCh2ZGV2LA0KPiA+ID4gPiA+ID4gVklSVElPX05FVF9GX0hBU0hfUkVQ
T1JUKTsNCj4gPiA+ID4gPiA+ID4gKwkJfQ0KPiA+ID4gPiA+ID4gPiArCQlpZiAoa2V5X3N6ID4g
TkVUREVWX1JTU19LRVlfTEVOKSB7DQo+ID4gPiA+ID4gPiA+ICsJCQlkZXZfd2FybigmdmRldi0+
ZGV2LA0KPiA+ID4gPiA+ID4gPiArCQkJCSAicnNzX21heF9rZXlfc2l6ZT0ldSBleGNlZWRzIGRy
aXZlcg0KPiA+IGxpbWl0DQo+ID4gPiA+ID4gPiAldSwgZGlzYWJsaW5nIFJTU1xuIiwNCj4gPiA+
ID4gPiA+ID4gKwkJCQkga2V5X3N6LCBORVRERVZfUlNTX0tFWV9MRU4pOw0KPiA+ID4gPiA+ID4g
PiArCQkJX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRfRl9SU1MpOw0KPiA+ID4g
PiA+ID4gPiArCQkJX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsDQo+ID4gPiA+ID4gPiBWSVJUSU9f
TkVUX0ZfSEFTSF9SRVBPUlQpOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IHlvdSBmbGlwcGVk
IHRoZSBsb2dpYyBoZXJlIGFuZCBpdCBtYWtlcyBubyBzZW5zZSBub3cuDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gRGlkIHlvdSB0ZXN0IHRoaXMgcGF0aD8NCj4gPiA+ID4gPiBZZXMsIHRlc3Rl
ZCB3aXRoIE1hcnZlbGwncyBPY3Rlb24gZGV2aWNlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiBTbyBpZiBkZXZpY2UgaXMgcG93ZXJmdWwgYW5kIHN1cHBvcnRzIGEgdmVy
eSBiaWcga2V5IHNpemUgdGhlbi4uLg0KPiA+ID4gPiA+ID4gd2UgZGlzYWJsZSB0aGUgZmVhdHVy
ZT8gaG93IGRvZXMgdGhpcyBtYWtlIHNlbnNlPw0KPiA+ID4gPiA+IFRoZSBpbnRlbnQgaXNu4oCZ
dCB0byBkaXNhYmxlIHRoZSBmZWF0dXJlIG9uIGNhcGFibGUgZGV2aWNlcywgYnV0DQo+ID4gPiA+
ID4gdG8gZW5zdXJlIHRoZSBkcml2ZXIgbmV2ZXIgYWR2ZXJ0aXNlcyBzdXBwb3J0IGZvciBSU1Mg
a2V5IHNpemVzDQo+ID4gPiA+ID4gbGFyZ2VyIHRoYW4gd2hhdCB0aGUgbmV0IGRldmljZSBjYW4g
YWN0dWFsbHkgaGFuZGxlLiBFdmVuIGlmIGENCj4gPiA+ID4gPiBkZXZpY2UgcmVwb3J0cyBhIHZl
cnkNCj4gPiA+ID4gbGFyZ2Uga2V5IHNpemUsIHRoZSBkcml2ZXIgaXMgY29uc3RyYWluZWQgYnkg
TkVUREVWX1JTU19LRVlfTEVOLA0KPiA+ID4gPiBzaW5jZQ0KPiA+ID4gPiBuZXRkZXZfcnNzX2tl
eV9maWxsKCkgZW5mb3JjZXM6DQo+ID4gPiA+ID4gQlVHX09OKGxlbiA+IHNpemVvZihuZXRkZXZf
cnNzX2tleSkpOw0KPiA+ID4gPg0KPiA+ID4gPiBzbyBjYXAgaXQgdG8gTkVUREVWX1JTU19LRVlf
TEVOLiBXaHkgaXMgdGhhdCBhIHJlYXNvbiB0byBjbGVhciB0aGUNCj4gPiBmZWF0dXJlPw0KPiA+
ID4gT3VyIGRldmljZSBtYW5kYXRlcyB0aGF0IGhhc2hfa2V5X2xlbmd0aCBtdXN0IGJlIGlkZW50
aWNhbCB0bw0KPiA+ID4gcnNzX21heF9rZXlfc2l6ZSB0byBndWFyYW50ZWUgc3ltbWV0cmljIGJp
ZGlyZWN0aW9uYWwgZmxvdyBoYXNoaW5nLg0KPiA+ID4gSWYgcnNzX21heF9rZXlfc2l6ZSBpcyBs
YXJnZXIgdGhhbiBWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkUsDQo+ID4gPiBjbGFtcGluZw0K
PiA+IHRoZSB2YWx1ZSBpcyBub3QgZmVhc2libGUuDQo+ID4NCj4gPiBJIGRvbid0IGtub3cgd2hh
dCB0byB0ZWxsIHlvdS4gcnNzX21heF9rZXlfc2l6ZSBpcyBqdXN0IHRoZSBtYXggZGV2aWNlDQo+
ID4gc3VwcG9ydHMuIGRyaXZlciBzaG91bGQgYmUgZnJlZSB0byB1c2UgYSBzbWFsbGVyIHNpemUu
DQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGlzIHBhdGNoIHByZXZlbnRzIHRoZSBwcm9i
ZSBmcm9tIGZhaWxpbmcgYnkNCj4gZGlzYWJsaW5nIHRoZSBmZWF0dXJlIGluc3RlYWQuDQo+IEdp
dmVuIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uLCB0aGUgZHJpdmVyIGJlY29tZXMgdW51c2Fi
bGUgd2hlbiB0aGlzDQo+IGNvbmRpdGlvbiBpcyBoaXQuDQoNCkkgdW5kZXJzdGFuZCB0aGF0IHRo
ZSBkcml2ZXIgaXMgYWxsb3dlZCB0byB1c2UgYSBzbWFsbGVyIFJTUyBrZXkgdGhhbiB0aGUgZGV2
aWNl4oCZcyBhZHZlcnRpc2VkIHJzc19tYXhfa2V5X3NpemUuDQpCdXQsIG91ciBoYXJkd2FyZSBk
b2VzIG5vdCBiZWhhdmUgY29ycmVjdGx5IGluIHRoYXQgY29uZmlndXJhdGlvbi4gRm9yIHN5bW1l
dHJpYyBiaWRpcmVjdGlvbmFsIGhhc2hpbmcsDQp0aGUgZGV2aWNlIHJlcXVpcmVzIHRoYXQgdGhl
IGhhc2hfa2V5X2xlbmd0aCBtYXRjaCByc3NfbWF4X2tleV9zaXplIGV4YWN0bHkuDQpJZiB0aGUg
ZHJpdmVyIHVzZXMgYSBzbWFsbGVyIGtleSwgdGhlIGhhcmR3YXJlIHByb2R1Y2VzIGluY29uc2lz
dGVudCBoYXNoIHZhbHVlcyBmb3IgZm9yd2FyZCB2cyByZXZlcnNlIGZsb3dzLg0KQmVjYXVzZSBv
ZiB0aGlzIGRldmljZSByZXF1aXJlbWVudCwgd2UgY2Fubm90IGNhcCB0aGUga2V5IHRvIE5FVERF
Vl9SU1NfS0VZX0xFTiB3aGVuIHRoZSBkZXZpY2UgYWR2ZXJ0aXNlcw0KYSBsYXJnZXIgcnNzX21h
eF9rZXlfc2l6ZS4NCj4gPg0KPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gKwkJfQ0KPiA+ID4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiBAQCAtNjgzOSwxMyArNjg2MCw2IEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9wcm9iZShzdHJ1Y3QNCj4gPiA+ID4gPiA+ID4gdmlydGlvX2RldmljZQ0KPiA+ID4gPiA+ID4g
KnZkZXYpDQo+ID4gPiA+ID4gPiA+ICAJaWYgKHZpLT5oYXNfcnNzIHx8IHZpLT5oYXNfcnNzX2hh
c2hfcmVwb3J0KSB7DQo+ID4gPiA+ID4gPiA+ICAJCXZpLT5yc3Nfa2V5X3NpemUgPQ0KPiA+ID4g
PiA+ID4gPiAgCQkJdmlydGlvX2NyZWFkOCh2ZGV2LCBvZmZzZXRvZihzdHJ1Y3QNCj4gPiB2aXJ0
aW9fbmV0X2NvbmZpZywNCj4gPiA+ID4gPiA+IHJzc19tYXhfa2V5X3NpemUpKTsNCj4gPiA+ID4g
PiA+ID4gLQkJaWYgKHZpLT5yc3Nfa2V5X3NpemUgPg0KPiA+IFZJUlRJT19ORVRfUlNTX01BWF9L
RVlfU0laRSkgew0KPiA+ID4gPiA+ID4gPiAtCQkJZGV2X2VycigmdmRldi0+ZGV2LCAicnNzX21h
eF9rZXlfc2l6ZT0ldQ0KPiA+IGV4Y2VlZHMNCj4gPiA+ID4gPiA+IHRoZSBsaW1pdCAldS5cbiIs
DQo+ID4gPiA+ID4gPiA+IC0JCQkJdmktPnJzc19rZXlfc2l6ZSwNCj4gPiA+ID4gPiA+IFZJUlRJ
T19ORVRfUlNTX01BWF9LRVlfU0laRSk7DQo+ID4gPiA+ID4gPiA+IC0JCQllcnIgPSAtRUlOVkFM
Ow0KPiA+ID4gPiA+ID4gPiAtCQkJZ290byBmcmVlOw0KPiA+ID4gPiA+ID4gPiAtCQl9DQo+ID4g
PiA+ID4gPiA+IC0NCj4gPiA+ID4gPiA+ID4gIAkJdmktPnJzc19oYXNoX3R5cGVzX3N1cHBvcnRl
ZCA9DQo+ID4gPiA+ID4gPiA+ICAJCSAgICB2aXJ0aW9fY3JlYWQzMih2ZGV2LCBvZmZzZXRvZihz
dHJ1Y3QNCj4gPiB2aXJ0aW9fbmV0X2NvbmZpZywNCj4gPiA+ID4gPiA+IHN1cHBvcnRlZF9oYXNo
X3R5cGVzKSk7DQo+ID4gPiA+ID4gPiA+ICAJCXZpLT5yc3NfaGFzaF90eXBlc19zdXBwb3J0ZWQg
Jj0NCj4gPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4NCj4g
PiA+DQoNCg==

