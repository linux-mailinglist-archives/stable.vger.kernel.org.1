Return-Path: <stable+bounces-219826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHFvJ5pjoGnajAQAu9opvQ
	(envelope-from <stable+bounces-219826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:15:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F851A864D
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75EF33018D62
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F03E959D;
	Thu, 26 Feb 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="U0kLVBHC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8C275AE8
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118640; cv=fail; b=JOiWDMt1aNk9KXAqmhiBxdSBTc7s46egUGEBR4TLSX4ZvCotHgnHSRDbSb3ewnZMdYOB75Mz4FokhO4Y1Nl9zE1lEJ060F4ecJSxmyOA/2RHXOujAp3Vm9Cz6AWHtultBNgnAW+TccBi+/NHCqbTG7MbHYxbDpUjdyWA/hdFpik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118640; c=relaxed/simple;
	bh=LhG9bbFG6ISMy1gibIPVnpMGxwALkZxYYdAVWMGonog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EpgMMrqG/+04Vn3+B2yJ201zhv74wgFfuPxkl4vQqu1PWPmTgFkxGGzAPHQjnHNkOebeCjY9RoGlRG3s5WD9UY2z5XSbqAWd/NE6pUdKRnRPMGAnxW3IpMlS12c+ilekj6JvuGja4xvIOFH5Ea5UIAQYJpFnrfiJ3OvRKbmscB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=U0kLVBHC; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q5pgIq190732;
	Thu, 26 Feb 2026 07:10:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=yQuaZfsavyJzKQvVDsZLrymWYLr93hUsfLTdBQvm3qk=; b=
	U0kLVBHCZfiI8Yg13JWgp2CaavN4ZFjxMnON2HPXACoa7olvuT4y0wff3+ra+yOk
	pCH3HT67nyMHSTmUHikcfQfwLyoALZAdddthsS6e0z3s14AfVGV7LFcoFnI1Gy5l
	E9+FgI2eZ5VJwYMxMgwbT5/aSBKWesgduIAvfVegkIoImtv8jExZHlyJxo+dHp4N
	swKAeZmM9rQF7NcPGXcouM44MRgXVqytnroHARRtRsXnuDlik3XmacWDkKtolwoX
	QR5yaeoPQgHQx89yrFMOoQBZ+rIo86oQvr+rDAFWUYAlm6zg5oNZLucSRzTygFzV
	YfejYnErdq2U8vJS6+U9mw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cjdu2rmb2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 07:10:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm0oTOErqlVt3LfC5Tpl8g1+HsIvtiS/ntnXeol2FMKo1rz1UpaSP+f6I0VVeQFP+gpsF5eYqLRSqGnCTcBp6vEJH+Yiv7PR8GOOjk6vr6EpuO9QblqH8ZyZnMYhNvdkmHSxz1B5/vJ+ezYdwbwMHwMQuwFE4pPihqhAhnLirhiTf2RzRVAA8XMEyOysqIeN0KqbdLPQUTZKEFAxibv2Ht1oeooCRo/Gp6BDFlkRpx2UyIuWEoYF7fN8/WfOtmrosxvJeRf5ft1olYIGBISPu7/TBCCCpQqAOPKvUeSPMfA2bTMI3b+90TGoyO6DJpJ2PxdOYTcJvlyBByDj6SI3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQuaZfsavyJzKQvVDsZLrymWYLr93hUsfLTdBQvm3qk=;
 b=zSlptcN2aMecw10FebKWrxriGxJMmqe9lBnbl8nFYUHPczImbyWuZyUBASGnsVJZd8zaSAuGEbBcY8e2MHV4kxk+n42NVMprbFhSVLHuJFaaa36vMR7WmCvkXqnsICn/LtzpHvrharTD/o/i4AUOXJQlHgiNlWXFsF9t0yFvULmmlKH1X9hsgvMhho/a9N2w2ARi5pSTkmJ7VDtYDEjXsYjz9qWh5T5dxTOTVclBJuuNkONcJDKmqB0ksk6erRF0tMu7nySMRq2jkQWGTKmSvJeVtgIi9Ih2T/BOPqTHuJKqEyRXUNb+Wdpcs25cg42J4nKtxTU/HvqS8Pg9hB6sGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by SN7PR11MB7065.namprd11.prod.outlook.com (2603:10b6:806:298::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 15:10:27 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::8ca9:28e3:e6fe:26c3]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::8ca9:28e3:e6fe:26c3%5]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 15:10:26 +0000
Message-ID: <4cb077c4-63b0-4ca7-881c-39e81fca0051@windriver.com>
Date: Thu, 26 Feb 2026 09:10:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: question about automatic backports to -stable branches
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <90479cf8-8087-4c8d-8d94-6bd3b885a77c@windriver.com>
 <2026022502-spoilage-drearily-cade@gregkh>
Content-Language: en-CA
From: Chris Friesen <chris.friesen@windriver.com>
In-Reply-To: <2026022502-spoilage-drearily-cade@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|SN7PR11MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b0f49a-bc5f-4cf9-7c68-08de75492bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	usYZZvowQQqIE6qXLRSbaULRUkZf3KxeoACQlNyo3QgdRrqYLkq9nxGGF5KKQXSHX2QqIDFkz7bZSp2x4qPzhTg+sXZ9Ya+aj5tnxXNU/qmDB5zy5TpEFyiZZLP7zhfztk/J7fBb2g8NhnqPL3AwLZndS5NR6uU/Z5uKD7Ck6he9ANNd1rNvJxiUbSFW0Eo7Kr0RAzZ86kK3xynRavDzNA3YH6AkgT+3yZ2JV7LC4ylvg7zv5ttU59M9q2dTHyTItRodjdYbLZbymi/YiPPMPcgtc/XVad+pAjpXo31cdHyNhRZDRzuPpjNZNl9m+2zdG52Ocl3PATnK72y4jN8/DDY19ZSZ/p11Yz60jxSJDJQOk1gF0ifBDCmuAxyYc358/JTbCVr8MX9cUbv4O3O+y0Y3in6Do4LqAoctn4XHZKlbMo32ZZ0UwjBk1CQJADWdwOv29Gbny2/m3caFBZOmwRPkX7jqfbs/8TlfioFTuJ6ZJE8iA6co41kQ1gHfVAMYCJhsVITGYV/gNeoOtd/yt6a525gzbRQ12GH2DbAQNMT9+yLY6i6SwK7WQ3a0bbcbxyfD++Crs78QnyWhnTlW/o8r6VU54vDYmi4DNC7DEvv4+6W61gm+nP7cD3TP2VI9EaXeYM3DDKWPzxpxga5D6XZqQgLOVARiQ/6ddG+s+3BWVlb12GfAa6iyEujo0oQzpdgxn1NM4HbzKrzu6Tt0RTgu+eYvhn1r7OXcvHgplnY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJvZmpsL1FWMzZsUmx3cGt2cFZ5aGllQWFUSk9nblhJR3EyVUFwZlpORnN2?=
 =?utf-8?B?RzBNbGVVWm1wUnBlTzhSb1B1NkFlYkw2eUVQK2lpbUVrQVhDVjlkcjNmSmR2?=
 =?utf-8?B?bG5DTXVCUU92eGlNS3ZCYnFHckdtdkFub1VLNXcwUTk2QWJPY3R5R2VtM085?=
 =?utf-8?B?UmZ5U3BXb0wzSVBxazJ3UVpOUlUvTUQ1Wmp5WTEydTAzSEh5ZDQzbk9SSHlr?=
 =?utf-8?B?ck9aeDVwSE9iOHpZYnhEMnlTKzFqdVlGeEI1YUE4TDg5YnM5QkVHZ2hmRnVI?=
 =?utf-8?B?YnVQMlpjZkJwRmNLczZCWmRudHFZeHVWMGo3RENIWmU0eEEra0R4UTVMV2sz?=
 =?utf-8?B?UGZFajJyUTNXTjNLT1pweWk1aEVrS1JVVlpaL2x1UWxkRXU4OTUvbFNWNW5L?=
 =?utf-8?B?Q0E1K1ptbXBqeE1sWGZFZkhZb1ZtMWhaS3dnRlRRV2Qxa1lQcXJmWDAvS0Q5?=
 =?utf-8?B?elJXckNCSVkvcjh6UmxJZ2RqUDFLMUVzbzdVcFJqU1FGUGN6ajRFckFoZHcx?=
 =?utf-8?B?NktzQ1JxQjJDek1ZNlliSTI0VjlIb3NhOXFkMitXVjNsSnFyWHMzbzRYOWZp?=
 =?utf-8?B?OVBRMmNVektzZWZTaVpJUEdDekcxM0N0TC9TQlk5VG0yb1g1UjlYaFA1SGov?=
 =?utf-8?B?ZzZSME9NZnNHWXl3SkVna3M5WmFRUmJZYzNtUlRER1dVZTdocFZMWjJUa0ht?=
 =?utf-8?B?Z1Ixb25zUkRobWN6Z1JxeVUrdHkxZGVTdU5aZkd3WW5YbjZzVm1vb3k2cWxr?=
 =?utf-8?B?c0p1OVYvUkVEUVd2S0hvRldTNGoya3J0Q3Nmd3BIWWMyazg4ZG9NQTdzQWRp?=
 =?utf-8?B?N1NBOUJKQjZMc0VuNHFRTXNSR3MvQkFxWjRNY3Z4eEI5Z2lYVjBHR1VMWEI1?=
 =?utf-8?B?UUw2ODNUT2pBVUduWkg1ZDhwNTNvWHRVS0NkTWpubjl6K1A0RjJqSHVHSkV0?=
 =?utf-8?B?dm55SHhwaEJkQUVhSEJTUUJVR3QwcHJRSG54ZWhuV091ek1xV1pLZ2tUN25z?=
 =?utf-8?B?NVN2czR2V3Vmdlk2N0JwY2tjVTlQV3V4R2tpTzJrSEFTSjBlZk8xYlNFUTgr?=
 =?utf-8?B?ZllLejFmOGhqMGMyWklTczB6cU9FUWhkbHFXdnlrUUZOWnQxdElNV0FGUTMv?=
 =?utf-8?B?bmRUT0JIMUJkN0R1VXRIR0kya2d0K010L0tNMHZnOTh3d0NoSnNiZnM0aS81?=
 =?utf-8?B?NWRVM1hHVytlOFZzTUhhOFRUWVdTUERZNklLOGY0M3BrMGR6Z3lYYjU4cG1Q?=
 =?utf-8?B?YWh5S2NVcG55enhEUFA3QU5LU3I4YjNrejZiUlkxRGYvcDl1RG1lUDV5TFBP?=
 =?utf-8?B?SktScnJNNDNxKzl6QTlQUWVVb25qMGVzMHN2Q045R2IzRlF3Qk5saU5rR2Q1?=
 =?utf-8?B?ZU93SlgzcmVkUFM0bDBoTkh1WFhRWnRLNlYyUHNsV0xoU2dOZU5OcFRUWVZW?=
 =?utf-8?B?NFFxYmpvSUNWU2Y2RmtwMVZxWGxiNmxQTERYSXVleWNLck1DdUxnc1U5bzdU?=
 =?utf-8?B?amxFcmFtMVp4RHd0dmhmaThPMHZFNC9VcjRVUlBVWjEzSHIrRjhCb0Z1TkJx?=
 =?utf-8?B?ZUxSOUVHZXBXazFpdys1aWZwNGQxeFJXQzRUcVRGWkVuaWZ4VUtndnBWd0dk?=
 =?utf-8?B?a2tyY2R5MWdWd055alAyT1MyUUlycFNOdVFnT2pVbUZVaFZ5bWh6SUxCcDB6?=
 =?utf-8?B?aStDUlNDTTRTamx6S05sdHhUalliS1ZYU2svM0FHTi9WV2puSkdmc1dKdVFJ?=
 =?utf-8?B?SEdRU1dGODVqSE04V2Y2b0Fydlo0eW9EMTJXZDk0emk3U253bVVQRThTS0g1?=
 =?utf-8?B?c3JDRVFkak5ydUFBYWtmdlVmMk5OMjVFMHdLRDFBRzI3RU5OZFZjUGNPaEZz?=
 =?utf-8?B?QnZOZGlyZ1IvMVJGaTJ1elcxYy9jTUF1TXc5U2VvUGFiVkx1Ym0vOGwweHd0?=
 =?utf-8?B?TnBnNVJBcHFZSU9SQUo1REEwVkRGS0pYN1pwUkx0QmxZcFlLakRya2R2cHlX?=
 =?utf-8?B?dVdEREdHRGd4SG5oRFl5bStYQjJZaVZHQk82VHRvNFhMVTJVY0Y2YXBxa0RU?=
 =?utf-8?B?eUZZejI4NTFvT0dQQW8xTjBCdXMyWmxMMzdPVzFVZmpUZlhXT0NRekhlSEZE?=
 =?utf-8?B?M3Q0eW5uRTAvNUFiU1hIUTEydDVPdGhsZ3EwSkovWHVGTzJGRVVxeTdNRzlu?=
 =?utf-8?B?ekVoNUNON21FVkNLcEhVaE5BWnF2U252Uyt5ZmpLK0loS0VWMElVd1pXV1g2?=
 =?utf-8?B?WmpVbEUvbXJBcFZYZk1zRmJQbzhUbXdBMGdhZG02dzNIYnp4TVBOakNZWUw0?=
 =?utf-8?B?Y3ZyU3JuYW9Ld2FNdWlsbUxXM2JzWElORXZtY1lkUW50bGRRekdWT2dnVGw0?=
 =?utf-8?Q?v0qhl019fbL9QRb0=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b0f49a-bc5f-4cf9-7c68-08de75492bc3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:10:26.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm68O444UJ4jsjCDez/qTldTtUv6X58OINi9h/VL4utpxfVOPt3y47sv82XFJbUeWVIpmI6dMZV6wHhDy/AJURKG0NcvdzF1G+pwKwM4XC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7065
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEzNiBTYWx0ZWRfX7MUfokQ/gqjL
 2Wh+Eqjt/uXEIAUZp8LM4feUAV+AZrj5WvekVl5SqpvRPzbHuSexhIu6tZhE2xF/Mwy6w7dXd1E
 PQcqecK6ieqq3a9FUfA6Iw4yeKCXHs+WZ2v8uky9e7jDtStcOgtDRj9zTOtpqVs8ycEbWYvtfCN
 21XoT9AHUKW2Ecr2UuuRbygv6wUmyGxo6gAS5+fIwVKMHHnTyjHnZNFPNiWhYwA2N5xeWHDXU5b
 2CTwmtkgFRusWM2tOORMVkD0TsJYUXuxbD34V2xwBwpJMxr4KvQL/dpPVKgSpmBEvv1v3XmJrCK
 KypVLC4NtYUtBnsTcXKeY1ueXjN5c5Mmm4n+X6jT2HZuCEfjNfPB0pJPEYKuM4C7QlFaZOkqmjj
 SDqOuVY3O0z6PVQXyNhi5EIu/Phdkr+reY1nU6x+zoSLDFqABmxfZlAHbXJBcn7Sf07U1Odgp81
 TYNoAglcayBs3wDpByA==
X-Authority-Analysis: v=2.4 cv=WpMm8Nfv c=1 sm=1 tr=0 ts=69a06266 cx=c_pps
 a=NNTlVNVDZfSUkWkRvmJkNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=VwQbUJbxAAAA:8 a=dc5qJ0K4ctAKs2xJsw8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aQ-l8SX5fbeFR3ZIMm_q2m3I9FHulXnh
X-Proofpoint-GUID: aQ-l8SX5fbeFR3ZIMm_q2m3I9FHulXnh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219826-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:mid,windriver.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chris.friesen@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 00F851A864D
X-Rspamd-Action: no action

On 2/25/2026 10:20 AM, Greg KH wrote:
> On Wed, Feb 25, 2026 at 09:56:12AM -0600, Chris Friesen wrote:
>> Hi,
>>
>> I'm trying to figure out what the expected process/timeline is for automatic
>> backports to -stable.
>>
>> Commits 2fa119c0e5e5 and a5338e365c45 were merged to mainline on Feb 01,
>> with the "Cc: stable@vger.kernel.org" in the commit message, but I don't see
>> either of them backported to either 6.18 or 6.12 -stable branches.
> 
> For a commit that was made in Dec 16, why did it wait until 7.0-rc1 to
> be merged?  We treat all of the cc: stable patches that show up in -rc1
> as "obviously no rush" as that's why they are showing up in -rc1.

I'm actually not involved with the original fix at all.  We just hit the 
problem on 6.12, found the fix on mainline, and then I got curious why 
the fix hadn't hit the -stable trees yet.

>> Is the backport a manual action that needs human attention?  I had assumed
>> it was mostly automated as long as the cherry-pick was clean.
> 
> It is automated, I'm just behind 700+ patches because of the huge number
> that come in for the -rc1 window.  If you have something that actually
> is hitting people, and fixes a problem, ALWAYS get it merged before -rc1
> to go a bit faster.
> 
> I will get to these eventually, and catch up, give me a week or so.

That's fine, I just wanted to make sure it was in the queue.  Thanks for 
your work, I appreciate the time and effort involved.

Chris

