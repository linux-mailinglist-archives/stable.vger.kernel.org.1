Return-Path: <stable+bounces-83236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFCF996ED2
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E3028451F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430119F47E;
	Wed,  9 Oct 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LPEReZU1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h5nB3efb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E519DF98;
	Wed,  9 Oct 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485653; cv=fail; b=X8gHILfHa6PkNX5M2ragdpIw/cIFm+pdq4pRAybzolbb76pVqK9AJCoR5RhLUmV2XFNPTvAuYkNvnjZo34zxhnzYcSJHdqwF2h2etGAxqi26+XJI0X9eZjxUokwKUbZbXzbGHXqh8HyRy3qvVgTinB/AUkV1LZFZ0WNcTMFDcvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485653; c=relaxed/simple;
	bh=67hPMrby7qUbO6zyTWfXihScCw2fggOWvx2HFWi70yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s3TeUpDbloOEiTCZrOOOD9Ko1Gr3ZKmnwG14ZQsxRrMBBcYnF0nR67yjQ63AVNw6GUOUW0AWowS2hM7Gw8JsD+XwGUfju0JY6EORGPOJ5kKVuAWBHMzLYqrRcy6bEM3LsTGr+0CH6ZlKKZQqvEHqGcI9xpYhgAwuPuOqksS4Zm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LPEReZU1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h5nB3efb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499DfetM004735;
	Wed, 9 Oct 2024 14:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ob6CzJCgcW6yCuU6dBUXCzk0H/3B+m9Zjz2BYwE3pPM=; b=
	LPEReZU1jAFktST4VTK8W/FhTVLPJpcMGHqv/KA8ItpM5sN8ayIh/gYB+6Csjg7g
	EhE/Fb62K5VgZE70JILMxVopoAP9NgaD1HDieC2SRQ4SwklGT1/U6vjl/TtX8Gw5
	bVjT4iQhepXnXHtKERCo2IByNDVL2EDcKe148s0vdvcRFAyks2og77yyjQcHjFRZ
	Li5s80aetQumGViSh4leKbjeQujuFYbxVpfiPKl3rBSOjtuSM1fpKA0OkT/WHfKt
	P5EORiz3fo/IAzP6aHbBM2XayBVAafANcgLUrxzgpwcvyWTq7k/3pLgWU6g8MVrW
	7B/+bUuqhcIbJOgzUCtWCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034rrs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:53:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499E40gC039089;
	Wed, 9 Oct 2024 14:53:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw8ry8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:53:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4FxFQV0jebNDqhFF908V2bhPdFdVWoprJdUHgSfitr8ad7Mmz38qR9DmmnC8XTTFSJIgV6w/aqCGuf5YoRymtZQfGjTbQiaElS4FAx/4PgyrJvxtDVA/22eHbCl9do9o6Qc0ZBVsrGMywjXPv+WBTDxV6XrCZ5u6S8k3rvnW1XT91cYpnxkyRUmQ1KUig28wke6pUcMtE5bPJKF9a/8tSewDU7ERRz0+YQddQxNNSoJZjHv8c2f4QtJrc6i0mp9utsHPCdIzvECjmWsnxwnmnOqRhA0i3D4nh/d+eVK6WRCrdoUACgK/dK4MkukbDGhHlUDtn5wuOzYLemFyYOUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob6CzJCgcW6yCuU6dBUXCzk0H/3B+m9Zjz2BYwE3pPM=;
 b=Keh8yRUnqp0/wPgtE8sKTgW4TgqKvaPfJvYdnsw7DVgWnikIrpqgsALW0K4FDZFCilFpNYK9Qoz+RTaVhSn8cCYf1IvkZyF4EUTYCTZoPvbtH8JB1qEv6gWg3fnnEsAO9ZZyq0BoLEE4Hp0QgzkB9gTaqSfgXWOCFDe12fR7NINbit//rL65dwGS2S9XnJrJD1Ss8y7mT3Y/Lv0speScw6eCrsZ8SARFiO083y5BESNKuIBfwIQ2yt/jgtcu++EQLjrIt3QRnCxNSC1awa6/kFJiFAf82LAGhuFfJSfHRup/RSrzD65ghIQnXsjvHJ1iAl7zIfBPFUFdkusM9n4eiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob6CzJCgcW6yCuU6dBUXCzk0H/3B+m9Zjz2BYwE3pPM=;
 b=h5nB3efbHn2GATv2xnsyr/KqVkH+a8UEN5t2YEgtk46vcde8Me5BWZX13Ux4aGZYAzpNED4jvTofv/XPKPRMvMSx8oll5HU7OHQLy4s9pbZyiKIKpRVSnmvqlXfd3NqFlURN53zx8+Hyo2GOylK/nF0wd4nX+8tVfKPVjkXX2Vg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7471.namprd10.prod.outlook.com (2603:10b6:208:455::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:53:24 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:53:24 +0000
Date: Wed, 9 Oct 2024 15:53:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Helge Deller <deller@gmx.de>, Vlastimil Babka <vbabka@suse.cz>,
        Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH] mm: Enforce a minimal stack gap even against
 inaccessible VMAs
Message-ID: <3d334639-feb9-474d-a4ed-6aa6d2afb33d@lucifer.local>
References: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
 <1eda6e90-b8d1-4053-9757-8f59c3a6e7ee@lucifer.local>
 <CAG48ez2v=r9-37JADA5DgnZdMLCjcbVxAjLt5eH5uoBohRdqsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2v=r9-37JADA5DgnZdMLCjcbVxAjLt5eH5uoBohRdqsw@mail.gmail.com>
X-ClientProxiedBy: LO0P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b11d32f-4e26-431d-dadf-08dce8721fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OS9iY0VJMTlURXZyTUozeXVGYmRsbmFVZXE1Ukx5MmlZQUplRTlVWU5Sa2Rx?=
 =?utf-8?B?bnRhcEV1dTk2R0Jac29JUFdYa04zSEsrWXd6S0hkbFMraU8wVWhZMS9ad3Vw?=
 =?utf-8?B?a0lmMzN0YmlIajdGNDFpTUNXZU9DWWJ5b1BRbWowS2dpdGVhcXR2NXhLODJL?=
 =?utf-8?B?ZENXT0J4QkxESmJ4UmJualY2SHJXVlEvelg3OWlpNzhGaS92VUlKOFpkWXRa?=
 =?utf-8?B?djdpK0tLZTRCcS9CVUg0a0YwamEyNWJGdHRkT21yZ2I0c3dnenowRUhYdE5m?=
 =?utf-8?B?aHF5TlpSNGRwRS8vc1JWa0RaNW9MNzVsOE9sTWNyek9SWU5oaDArOUdvYVpS?=
 =?utf-8?B?NVdTYllVMG1TaWRTVUhnYU9NZkdNOWdmbGtzaDNZYnZPdHVFRi9KV3U5Mk9x?=
 =?utf-8?B?Y0ZwNGVxZ0VLNWl2cHpaekVoMm9YOUt0NVl2d0VwcXUrWjhNUWRIUS9NRlhD?=
 =?utf-8?B?YVBKejdOemJFa293aDFJTDhJeUtZcnRQZmRhdzF0QzUxSGw4dnQ1S05zY3k2?=
 =?utf-8?B?UXVJNUNZajB0TFY1ckRLL2lCWnh3Zys1NStZUE9PUkVEWlJlaDZkSkMyYWI0?=
 =?utf-8?B?eGxaeFdHT1JLbTV0ZzdLL0c2N1JndW5IUnFYYUpKdHFBbmFFZENtV0VPYzgv?=
 =?utf-8?B?K2dYajdwOWtzMDZUN1NZVk9jbklsMHZ6YUxCcHp0L0h0bE1RNjhwU0RScTcx?=
 =?utf-8?B?U2dSa2c5aWJlSlRkdXRodTQ1RWVDYm1ZZnU3S2dBNWFlb0dmdmMvb2Vqa1Vj?=
 =?utf-8?B?Sk5XWStvYksvcEJpNkQweHFUbjlxZm1lUjIwT0kyYi90NWhjc2hzeHJ4THRO?=
 =?utf-8?B?d05jWUYrN1h4RThMbFdUeGlQaVdxUWRWaE9keFY5UDRaemtHekRsR1RCQktr?=
 =?utf-8?B?Z0xTZHFsYVYvL3FUQnlLSG53ZkJWRFl2OUlGUEg3ekVVQXhUTktKckZmVEwv?=
 =?utf-8?B?T1l6OVYrbDFmWDJDaENkR090OUh4NzlDQ0tNQTJHcDk2Z1RNREFSTVRaSzFk?=
 =?utf-8?B?NXJ3R1ByODgybkN0STJWVTNNUkp5SUFGSUc4dzN1WkdzblZSKzdoeE5SYnlQ?=
 =?utf-8?B?NkVOd0NJTkRVck9KdFZYYkFHS2czL1pVd2ZoMkJISW93YzMzZzd5ZTF5ZzZC?=
 =?utf-8?B?Tk1uTk5ENWloeGlRbGIrT2wzdVFBY0RkQ2lpNzdhL25oZWNhaUNTVjhNelM5?=
 =?utf-8?B?dWxVc1pmSjh2cnBOK2REUGw2cnEydkpNRGdudlVYM1NoT3VBTnhVMDlTSE1m?=
 =?utf-8?B?NzlDR042Ukh5bG5xSjlEOGdRSjF5TUdzSWV1SEp4U2VLZWx4V0ZUeDBYaEtl?=
 =?utf-8?B?ZHR5Nk1ldWR1TkFvOGptZVo4UituTWpOdGt3WXdsa0pFWm1xWHdDNWRKWWEz?=
 =?utf-8?B?UWZFUHpTMHkxVFpuYjJ1eURQNXo1Zmd5QVZwLzN4QnUyOG83WHVyWlFlNTdo?=
 =?utf-8?B?N0ZIYkFOQ3dWRk9HMk82dldURTdOeHdoMmIyLzZMNzlBd3dKUlFCL1M2UWNh?=
 =?utf-8?B?c0E4WEZSTXYzckdGdmh4SDZQeFB2UzZQMTM2OHlGOHlRNkErRG55UGhvOHJZ?=
 =?utf-8?B?UUw0eFM3YnFhdjZOdWRQMnlBZk5vUUlWOFY5amsrTnlNYTYrWHZYS0ZjNW9F?=
 =?utf-8?B?Z0pjZ2VFSXlYaERVRnM1UEhLUit1bENYaUhKajdhbEptaVZxd25qVjc2VlA2?=
 =?utf-8?B?OGp6S2hBYW41Uks3cEI3T1loTVl0YVc0NFBJRDRraFBiNFVycEl1R2hBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW1mY3BpMDJzcW5HR2RJdzA0d01QTGlMSmRiVG4zSkdtTnhmRjFLcjNpN0R4?=
 =?utf-8?B?Yk01aHVLVWYwVElBNlp1WUtHUWNIdjhZVCtNazJJRG9ibWRzM2VNUkFtYnA5?=
 =?utf-8?B?bHlIMVJrdFk4akVGSm9GaHZBSklkWmtzZnhDa2FlVWhOblkxMGx1RVlXbSt1?=
 =?utf-8?B?bm5DcWlnMUY4Rnl1Yk52Vmk1a1F3NGZwcU92TUlkUStyMUJ1MmZGZGF1bEYy?=
 =?utf-8?B?WEg4TlRnelFrcG1mK3dyYzl4cFNYd0E1eldqMUJOYXFvOU05ZUZLTGkxcHVI?=
 =?utf-8?B?ekdWbGl0MnF4a2t1QStNZ29MdEUwTDdkVmI4enNhSkRmSWxqMERkZktaTmNt?=
 =?utf-8?B?bUpYNU9UZ3NvSWR1RmljelZPZ3R2SG4xWitLR1Q4L3F0Q1VDUHNPenJwRThC?=
 =?utf-8?B?SHd2V3JCczFBRTFObWlyUlBCYXE5SjNEajIzOUdXRDl0bldwcmdKdEZIUlBH?=
 =?utf-8?B?bFBXV3VTbzZOcHhjZUlYc0hxTFhvNlRQOHdVRUk1OFB3STRjQUJqTnRCNmZt?=
 =?utf-8?B?ZklxY3QrbHY0SUxUbEkzejdOT2IvMEVKd0dJb2NNQWo4MzBYVklYYUZCZGhG?=
 =?utf-8?B?VS9BTlNMYzBGaERCTlg0NUZWT0NpbERFakVIQkpPSXZWSVlaWmRFcXRaamNQ?=
 =?utf-8?B?ZzNmbU9od010NUtCUnBnbnNheUR4VlFya3EzTDV6Ky9JeUVFRzNxTElVL0Mr?=
 =?utf-8?B?dGJXL2t6bUg2M2tTMnZUWU5QTDdZZXkzSnN4a3c1NHEwUEVGNkZhWVNLN1dw?=
 =?utf-8?B?WkdzcjdmYXdBLzlQbkUrNFFTS2lnNUtWOUdpemhrQ3lFZXpMYkpldXJkUjJU?=
 =?utf-8?B?WkxxTFRkV0t6bXF2akR5VllRbkg4bkJ1blJLSXZsWWEvQ2FYdWt1THNIUDE5?=
 =?utf-8?B?S1pZMW5VKzhsaHAvTDIyTlhvK1BvRlNkclo1blRieFp1RVQ5bjhXQzBjUWJD?=
 =?utf-8?B?eXF1endFd3h0ZVFrSmxlUVZrKzZmUzYwd3BiWExZSGRuUFpxREtDZG1LNHZU?=
 =?utf-8?B?eVRMTmhPa0NIaXZQVjRPUXJ3T21vMEtPNzJob2xuQ2p2YlovVk9qRFRVWTdU?=
 =?utf-8?B?a2VtYm5sUUlaa0M1akg5M2pBTHJRUGVRaElHMnRTNS82ZFQ5eTZPSkZWK1l0?=
 =?utf-8?B?OWRLR1NyZHZZbVAvK1RNbkV1ZzJRazNEZFE1L1JIRW1RSUJpSmRpdGlEbURt?=
 =?utf-8?B?Y1NjZVVncUR2NThMSHB1cGk1NXlLOHJRZW10NzJqYlc4Zk11SUpzQlBxMjFa?=
 =?utf-8?B?TjVyNHB1dFQ3bDI5YXBtbHVBYSt2R1g4Q0ZlU2xmUldOWWlHeTduZGVSNkdO?=
 =?utf-8?B?dktZS2g3ZDROK2pxanBPcUVLUDZLdmd2WTBMdGwrTmhsM2RyMHVSQjk1V1BZ?=
 =?utf-8?B?MEpTQzNPdVFMTnE3SE9TZm9NR2Z0ekY2eWRKcDAydDhEeG5FaWRqZFRUSlBp?=
 =?utf-8?B?dyt0ekJsSjhIaVMyLzQyRGlBdm5WdnVNcEVnSDE1SmVJOWpDaVNNSzhwb2dW?=
 =?utf-8?B?QVcrV0swT05VelRQZzYyeXRmalJLMVFwNVZZZy9Xais4SjFwejQxNGhYZW95?=
 =?utf-8?B?QytjdjZZYnA5OXNHZVlZUk80eU1ueHN5MUhVVmhYYjVtR044UjBaNkdaRkdK?=
 =?utf-8?B?bldEdXQ1TG96bllhemJDcWRob2VqY0hnT3FRNVRMMHNvcnMvWUloR2F5aFlx?=
 =?utf-8?B?SmJObnFVUW9rQm0zSGt1TFlBL3FkVlJtK1dXa1l5UDF6Mnl5NlZtdUlKT205?=
 =?utf-8?B?MGpKV0dOZFcwc0diaGgwL3FNbjZLZ0FKTWt2WVhjWVYwaUlrMzljVVZLYlpK?=
 =?utf-8?B?L2IvM0ZxbmJKUitCZ3VBeENiUFdSVTZTM1AxMm5yaUFEWXphOUpCZjBybUJX?=
 =?utf-8?B?NWZpbWVveStwbzllZE9kVGo5WHBraVpSZWFIWk1icjFiZVAvbTVsTGJwN0Z5?=
 =?utf-8?B?TGVobjRSODQ1UnREbHNKbGVMZlVMbDZaQk5zSjFWRlJuMDdPd2g1dEJLZnlQ?=
 =?utf-8?B?RFV6Mm1XV0o1d1UrQkVvQU8xWDJKQTdQM1ZzWUo4RGRIdXpreW9zZmZkYXRl?=
 =?utf-8?B?cWVocXBkYU9iOVlaWmNFYzFjS213OVRlRnV3SzlsdFRicUk0bWIxa2szZDhJ?=
 =?utf-8?B?dWttRFRzRE40U3p1NEhkL0o4bUpMOVdNZnRyVXdRaTYxMXkxVTA5QllaWHQ4?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2xTdEifx/GrXkvvyuq9s6kAshuQbx7uhYoHoPISWu3UKuQwRe5CAfOZ1Js5mjCppTRfZKj3uLIW7rtok4E3zXYJSFZoxoS+FnC3HHzIkk7w/6Yoy+GRCPboI5Twpz3T5GLFdqTKcUg2/j+7FxetXB2ritPRx5nlp6Zfn1eZQ+L62w7eIOM+PJWjewJPqMy9ru0Y1ZVPoj0YjRqlCg4Hevd2z0Ljr++tq4w5fk7cO79kohplf7oLDhJCg2lI6kjeEdQxp0AcMhFfffyteSZgVLyCPM3qdNxr/JiBTweBM4QKo9chPi1a3H6ojP3A46rTq3VHHbFeUL1JiDP+hxwhMe5atw+vZ4fKMksHqVMbQc9M+8pIrPFzFCuM66pK9Ixzw2FNqYgyQ3HuJJj1u5AiAa7TGkuxV1lDRXKduXRBdqCgriAVAwuoxRADJJVW+oFD94Iv//YoHGk5wHlC3H3MX4gKfudKAJsw9QUHrXM9aTaX/PQ52JlwxK4lAqR3aZDcb5YYkMlXblyzeklI8hZetMj1IoT9hcnNLQTC6j3ktEziSVS8hDUgHPtcneLm6i477ESUsspCaaGfmjJRr4IcTYckJ3DdO119Nz8ul7orSVgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b11d32f-4e26-431d-dadf-08dce8721fee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:53:24.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnB2Ha1gvDzEknqFJkD4Az2BYQX19zIdP2cWM3pNoGe5Nwbwk4e29duMqgKl3Pu4KCoEo/GI3CdEP3MKMrb/L48GU0cd+NF1W63wfzfJ+kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_12,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090092
X-Proofpoint-GUID: saeZLmAOOGcd0cjG4lE_WbD3GHBNumjq
X-Proofpoint-ORIG-GUID: saeZLmAOOGcd0cjG4lE_WbD3GHBNumjq

On Tue, Oct 08, 2024 at 04:20:13PM +0200, Jann Horn wrote:
> On Tue, Oct 8, 2024 at 1:40 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > This is touching mm/mmap.c, please ensure to cc- the reviewers (me and
> > Liam, I have cc'd Liam here) as listed in MAINTAINERS when submitting
> > patches for this file.
>
> Ah, my bad, sorry about that.
>
> > Also this seems like a really speculative 'please discuss' change so should
> > be an RFC imo.
> >
> > On Tue, Oct 08, 2024 at 12:55:39AM +0200, Jann Horn wrote:
> > > As explained in the comment block this change adds, we can't tell what
> > > userspace's intent is when the stack grows towards an inaccessible VMA.
> > >
> > > I have a (highly contrived) C testcase for 32-bit x86 userspace with glibc
> > > that mixes malloc(), pthread creation, and recursion in just the right way
> > > such that the main stack overflows into malloc() arena memory.
> > > (Let me know if you want me to share that.)
> >
> > You are claiming a fixes from 2017 and cc'ing stable on a non-RFC so
> > yeah... we're going to need more than your word for it :) we will want to
> > be really sure this is a thing before we backport to basically every
> > stable kernel.
> >
> > Surely this isn't that hard to demonstrate though? You mmap something
> > PROT_NONE just stack gap below the stack, then intentionally extend stack
> > to it, before mprotect()'ing the PROT_NONE region?
>
> I've attached my test case that demonstrates this using basically only
> malloc, free, pthread_create() and recursion, plus a bunch of ugly
> read-only gunk and synchronization. It assumes that it runs under
> glibc, as a 32-bit x86 binary. Usage:

Thanks!

>
> $ clang -O2 -fstack-check -m32 -o grow-32 grow-32.c -pthread -ggdb &&
> for i in {0..10}; do ./grow-32; done
> corrupted thread_obj2 at depth 190528
> corrupted thread_obj2 at depth 159517
> corrupted thread_obj2 at depth 209777
> corrupted thread_obj2 at depth 200119
> corrupted thread_obj2 at depth 208093
> corrupted thread_obj2 at depth 167705
> corrupted thread_obj2 at depth 234523
> corrupted thread_obj2 at depth 174528
> corrupted thread_obj2 at depth 223823
> corrupted thread_obj2 at depth 199816
> grow-32: malloc failed: Cannot allocate memory
>
> This demonstrates that it is possible for a userspace program that is
> just using basic libc functionality, and whose only bug is unbounded
> recursion, to corrupt memory despite being built with -fstack-check.
>
> As you said, to just demonstrate the core issue in a more contrived
> way, you can also use a simpler example:
>
> $ cat basic-grow-repro.c
> #include <err.h>
> #include <stdlib.h>
> #include <sys/mman.h>
>
> #define STACK_POINTER() ({ void *__stack; asm volatile("mov %%rsp,
> %0":"=r"(__stack)); __stack; })
>
> int main(void) {
>   char *ptr = (char*)(  (unsigned long)(STACK_POINTER() -
> (1024*1024*4)/*4MiB*/) & ~0xfffUL  );
>   if (mmap(ptr, 0x1000, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0) != ptr)
>     err(1, "mmap");
>   *(volatile char *)(ptr + 0x1000); /* expand stack */
>   if (mprotect(ptr, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC))
>     err(1, "mprotect");
>   system("cat /proc/$PPID/maps");
> }
> $ gcc -o basic-grow-repro basic-grow-repro.c
> $ ./basic-grow-repro
> 5600a0fef000-5600a0ff0000 r--p 00000000 fd:01 28313737
>   [...]/basic-grow-repro
> 5600a0ff0000-5600a0ff1000 r-xp 00001000 fd:01 28313737
>   [...]/basic-grow-repro
> 5600a0ff1000-5600a0ff2000 r--p 00002000 fd:01 28313737
>   [...]/basic-grow-repro
> 5600a0ff2000-5600a0ff3000 r--p 00002000 fd:01 28313737
>   [...]/basic-grow-repro
> 5600a0ff3000-5600a0ff4000 rw-p 00003000 fd:01 28313737
>   [...]/basic-grow-repro
> 7f9a88553000-7f9a88556000 rw-p 00000000 00:00 0
> 7f9a88556000-7f9a8857c000 r--p 00000000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f9a8857c000-7f9a886d2000 r-xp 00026000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f9a886d2000-7f9a88727000 r--p 0017c000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f9a88727000-7f9a8872b000 r--p 001d0000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f9a8872b000-7f9a8872d000 rw-p 001d4000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f9a8872d000-7f9a8873a000 rw-p 00000000 00:00 0
> 7f9a88754000-7f9a88756000 rw-p 00000000 00:00 0
> 7f9a88756000-7f9a8875a000 r--p 00000000 00:00 0                          [vvar]
> 7f9a8875a000-7f9a8875c000 r-xp 00000000 00:00 0                          [vdso]
> 7f9a8875c000-7f9a8875d000 r--p 00000000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f9a8875d000-7f9a88782000 r-xp 00001000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f9a88782000-7f9a8878c000 r--p 00026000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f9a8878c000-7f9a8878e000 r--p 00030000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f9a8878e000-7f9a88790000 rw-p 00032000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7fff84664000-7fff84665000 rwxp 00000000 00:00 0
> 7fff84665000-7fff84a67000 rw-p 00000000 00:00 0                          [stack]
> $
>
>
> Though, while writing the above reproducer, I noticed another dodgy
> scenario regarding the stack gap: MAP_FIXED_NOREPLACE apparently
> ignores the stack guard region, because it only checks for VMA
> intersection, see this example:

Oh my.

>
> $ cat basic-grow-repro-ohno.c
> #include <err.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
>
> #define STACK_POINTER() ({ void *__stack; asm volatile("mov %%rsp,
> %0":"=r"(__stack)); __stack; })
>
> int main(void) {
>   setbuf(stdout, NULL);
>   char *ptr = (char*)(  (unsigned long)(STACK_POINTER() -
> (1024*1024*4)/*4MiB*/) & ~0xfffUL  );
>   *(volatile char *)(ptr + 0x1000); /* expand stack to just above ptr */
>
>   printf("trying to map at %p\n", ptr);
>   system("cat /proc/$PPID/maps;echo");
>   if (mmap(ptr, 0x1000, PROT_READ|PROT_WRITE|PROT_EXEC,
> MAP_FIXED_NOREPLACE|MAP_ANONYMOUS|MAP_PRIVATE, -1, 0) != ptr)
>     err(1, "mmap");
>   system("cat /proc/$PPID/maps");
> }
> $ gcc -o basic-grow-repro-ohno basic-grow-repro-ohno.c
> $ ./basic-grow-repro-ohno
> trying to map at 0x7ffc344ca000
> 560ee371d000-560ee371e000 r--p 00000000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 560ee371e000-560ee371f000 r-xp 00001000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 560ee371f000-560ee3720000 r--p 00002000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 560ee3720000-560ee3721000 r--p 00002000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 560ee3721000-560ee3722000 rw-p 00003000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 7f0d636ed000-7f0d636f0000 rw-p 00000000 00:00 0
> 7f0d636f0000-7f0d63716000 r--p 00000000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d63716000-7f0d6386c000 r-xp 00026000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d6386c000-7f0d638c1000 r--p 0017c000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d638c1000-7f0d638c5000 r--p 001d0000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d638c5000-7f0d638c7000 rw-p 001d4000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d638c7000-7f0d638d4000 rw-p 00000000 00:00 0
> 7f0d638ee000-7f0d638f0000 rw-p 00000000 00:00 0
> 7f0d638f0000-7f0d638f4000 r--p 00000000 00:00 0                          [vvar]
> 7f0d638f4000-7f0d638f6000 r-xp 00000000 00:00 0                          [vdso]
> 7f0d638f6000-7f0d638f7000 r--p 00000000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f0d638f7000-7f0d6391c000 r-xp 00001000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f0d6391c000-7f0d63926000 r--p 00026000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f0d63926000-7f0d63928000 r--p 00030000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f0d63928000-7f0d6392a000 rw-p 00032000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7ffc344cb000-7ffc348cd000 rw-p 00000000 00:00 0                          [stack]
>
> 560ee371d000-560ee371e000 r--p 00000000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 560ee371e000-560ee371f000 r-xp 00001000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 560ee371f000-560ee3720000 r--p 00002000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 560ee3720000-560ee3721000 r--p 00002000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 560ee3721000-560ee3722000 rw-p 00003000 fd:01 28313842
>   [...]/basic-grow-repro-ohno
> 7f0d636ed000-7f0d636f0000 rw-p 00000000 00:00 0
> 7f0d636f0000-7f0d63716000 r--p 00000000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d63716000-7f0d6386c000 r-xp 00026000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d6386c000-7f0d638c1000 r--p 0017c000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d638c1000-7f0d638c5000 r--p 001d0000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d638c5000-7f0d638c7000 rw-p 001d4000 fd:01 3417714
>   /usr/lib/x86_64-linux-gnu/libc.so.6
> 7f0d638c7000-7f0d638d4000 rw-p 00000000 00:00 0
> 7f0d638ee000-7f0d638f0000 rw-p 00000000 00:00 0
> 7f0d638f0000-7f0d638f4000 r--p 00000000 00:00 0                          [vvar]
> 7f0d638f4000-7f0d638f6000 r-xp 00000000 00:00 0                          [vdso]
> 7f0d638f6000-7f0d638f7000 r--p 00000000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f0d638f7000-7f0d6391c000 r-xp 00001000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f0d6391c000-7f0d63926000 r--p 00026000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f0d63926000-7f0d63928000 r--p 00030000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7f0d63928000-7f0d6392a000 rw-p 00032000 fd:01 3409055
>   /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
> 7ffc344ca000-7ffc344cb000 rwxp 00000000 00:00 0
> 7ffc344cb000-7ffc348cd000 rw-p 00000000 00:00 0                          [stack]
> $
>
> That could also be bad: MAP_FIXED_NOREPLACE exists, from what I
> understand, partly so that malloc implementations can use it to grow
> heap memory chunks (though glibc doesn't use it, I'm not sure who
> actually uses it that way). We wouldn't want a malloc implementation
> to grow a heap memory chunk until it is directly adjacent to a stack.

It seems... weird to use it that way as you couldn't be sure you weren't
overwriting another VMA.

>
> > > I don't know of any specific scenario where this is actually exploitable,
> > > but it seems like it could be a security problem for sufficiently unlucky
> > > userspace.
> > >
> > > I believe we should ensure that, as long as code is compiled with something
> > > like -fstack-check, a stack overflow in it can never cause the main stack
> > > to overflow into adjacent heap memory.
> > >
> > > My fix effectively reverts the behavior for !vma_is_accessible() VMAs to
> > > the behavior before commit 1be7107fbe18 ("mm: larger stack guard gap,
> > > between vmas"), so I think it should be a fairly safe change even in
> > > case A.
> > >
> > > Fixes: 561b5e0709e4 ("mm/mmap.c: do not blow on PROT_NONE MAP_FIXED holes in the stack")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > > I have tested that Libreoffice still launches after this change, though
> > > I don't know if that means anything.
> > >
> > > Note that I haven't tested the growsup code.
> > > ---
> > >  mm/mmap.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 46 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index dd4b35a25aeb..971bfd6c1cea 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1064,10 +1064,12 @@ static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
> > >               gap_addr = TASK_SIZE;
> > >
> > >       next = find_vma_intersection(mm, vma->vm_end, gap_addr);
> > > -     if (next && vma_is_accessible(next)) {
> > > -             if (!(next->vm_flags & VM_GROWSUP))
> > > +     if (next && !(next->vm_flags & VM_GROWSUP)) {
> > > +             /* see comments in expand_downwards() */
> > > +             if (vma_is_accessible(prev))
> > > +                     return -ENOMEM;
> > > +             if (address == next->vm_start)
> > >                       return -ENOMEM;
> > > -             /* Check that both stack segments have the same anon_vma? */
> >
> > I hate that we even maintain this for one single arch I believe at this point?
>
> Looks that way, just parisc?
>
> It would be so nice if we could somehow just get rid of this concept
> of growing stacks in general...
>
> > >       }
> > >
> > >       if (next)
> > > @@ -1155,10 +1157,47 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
> > >       /* Enforce stack_guard_gap */
> > >       prev = vma_prev(&vmi);
> > >       /* Check that both stack segments have the same anon_vma? */
> > > -     if (prev) {
> > > -             if (!(prev->vm_flags & VM_GROWSDOWN) &&
> > > -                 vma_is_accessible(prev) &&
> > > -                 (address - prev->vm_end < stack_guard_gap))
> > > +     if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
> > > +         (address - prev->vm_end < stack_guard_gap)) {
> > > +             /*
> > > +              * If the previous VMA is accessible, this is the normal case
> > > +              * where the main stack is growing down towards some unrelated
> > > +              * VMA. Enforce the full stack guard gap.
> > > +              */
> > > +             if (vma_is_accessible(prev))
> > > +                     return -ENOMEM;
> > > +
> > > +             /*
> > > +              * If the previous VMA is not accessible, we have a problem:
> > > +              * We can't tell what userspace's intent is.
> > > +              *
> > > +              * Case A:
> > > +              * Maybe userspace wants to use the previous VMA as a
> > > +              * "guard region" at the bottom of the main stack, in which case
> > > +              * userspace wants us to grow the stack until it is adjacent to
> > > +              * the guard region. Apparently some Java runtime environments
> > > +              * and Rust do that?
> > > +              * That is kind of ugly, and in that case userspace really ought
> > > +              * to ensure that the stack is fully expanded immediately, but
> > > +              * we have to handle this case.
> >
> > Yeah we can't break userspace on this, no doubt somebody is relying on this
> > _somewhere_.
>
> It would have to be a new user who appeared after commit 1be7107fbe18.
> And they'd have to install a "guard vma" somewhere below the main
> stack, and they'd have to care so much about the size of the stack
> that a single page makes a difference.

You did say 'Apparently some Java runtime environments and Rust do that'
though right? Or am I misunderstanding?

>
> > That said, I wish we disallowed this altogether regardless of accessibility.
> >
> > > +              *
> > > +              * Case B:
> > > +              * But maybe the previous VMA is entirely unrelated to the stack
> > > +              * and is only *temporarily* PROT_NONE. For example, glibc
> > > +              * malloc arenas create a big PROT_NONE region and then
> > > +              * progressively mark parts of it as writable.
> > > +              * In that case, we must not let the stack become adjacent to
> > > +              * the previous VMA. Otherwise, after the region later becomes
> > > +              * writable, a stack overflow will cause the stack to grow into
> > > +              * the previous VMA, and we won't have any stack gap to protect
> > > +              * against this.
> >
> > Should be careful with terminology here, an mprotect() will not allow a
> > merge so by 'grow into' you mean that a stack VMA could become immediately
> > adjacent to a non-stack VMA prior to it which was later made writable.
> >
> > Perhaps I am being pedantic...
>
> Ah, sorry, I worded that very confusingly. By "a stack overflow will
> cause the stack to grow into the previous VMA", I meant that the stack
> pointer moves into the previous VMA and the program uses part of the
> previous VMA as stack memory, clobbering whatever was stored there
> before. That part was not meant to talk about a change of VMA bounds.

Sure, yes this is what I assumed. Might be worth clarifying that just to be
_totally_ clear.

>
> > > +              *
> > > +              * As an ugly tradeoff, enforce a single-page gap.
> > > +              * A single page will hopefully be small enough to not be
> > > +              * noticed in case A, while providing the same level of
> > > +              * protection in case B that normal userspace threads get.
> > > +              */
> > > +             if (address == prev->vm_end)
> > >                       return -ENOMEM;
> >
> > Ugh, yuck. Not a fan of this at all. Feels like a dreadful hack.
>
> Oh, I agree, I just didn't see a better way to do it.
>
> > You do raise an important point here, but it strikes me that we should be
> > doing this check in the mprotect()/mmap() MAP_FIXED scenarios where it
> > shouldn't be too costly to check against the next VMA (which we will be
> > obtaining anyway for merge checks)?
> >
> > That way we don't need a hack like this, and can just disallow the
> > operation. That'd probably be as liable to break the program as an -ENOMEM
> > on a stack expansion would...
>
> Hmm... yeah, I guess that would work. If someone hits this case, it
> would probably be less obvious to the programmer what went wrong based
> on the error code, but on the other hand, it would give userspace a
> slightly better chance to recover from the issue...
>
> I guess I can see if I can code that up.

Thanks!

