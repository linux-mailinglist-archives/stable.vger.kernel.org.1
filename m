Return-Path: <stable+bounces-83502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756B099AEAB
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 00:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C8B2846F8
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511A1D278A;
	Fri, 11 Oct 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fbb65CDp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YbCLp4r6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8243F1A070E;
	Fri, 11 Oct 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685745; cv=fail; b=K7oj9nZ7GmplnKAZjPmnO6Z5okUyZPRG2sp4csieOKmNJ6/CnUZD/NuY2y2KqP9n6WBsv0iuGhdtvKmf2ivH2VMgkeh6NwXg1qSo23g7RXiJPY9Wz1TuD0Q7Pv98hCF1jDFavQGZ3uUI3W+KW53WULUycgS4n0REo4bXaoAaewI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685745; c=relaxed/simple;
	bh=clpd5dCdiOVI+HxjiZ7bMzFZiPqZ2bI959Z5ggDsEkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OIw5/LIVXd2RecXhs1YgZx8ZD5z4GnsyOd4WzfDNsUblEANkL2fPdww70bdohI5iECv77TjUmEBAufLL9GYL5Sck4EyNNgDadyUoRBmzolcEmMnprGXyvYOKjw7qXfxk/hx3dqbHi7vekCt5n8WClSyBwufEwTTbaMOauZNHMvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fbb65CDp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YbCLp4r6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BJU7H3007071;
	Fri, 11 Oct 2024 22:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=clpd5dCdiOVI+HxjiZ7bMzFZiPqZ2bI959Z5ggDsEkw=; b=
	fbb65CDpzcqDrS4TwlFE+IQc5QxqAEi4jvD9h9Bd7yF5Q3jsi/QVqY2+GifH2cum
	7JU1XgE9VBrmZ43+32NsJuCkO4Iulngx/bdWaPpbh3TNzukkYUKYQ3hkS+PLWxU/
	AJE/wScpUUXpp8z7SOtLtpB8Qzldc7HdLh+sR+e5f73ycx0RbEiZWwCcI4PH63bM
	sXfRGfU5+liQlMVnp2AlQYLFoQqOJEU0e2JksvnLKnZoknlHVeQ9OA+0VXhmfqU/
	2jFxNFxOXS7QIa0YvN2hSjMiL4uyaM8hl3+DoTG5iP7N8KE/IqvWFyCcRcqrWsYl
	SK4u0Tjt+26Fzg/+GuYTJw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ynwhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 22:28:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKYO08040231;
	Fri, 11 Oct 2024 22:28:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwj53ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 22:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qy7Sx9reHJLpj7utSha0Vyvf7r1jAdoSe8Iu7/PF9cAU6wyKq+Wcyz6Qrh5cxtH1vLkE8RaHqEcqymi6jEvF0Vh4Y++YqQLi3dDK/JnIpV/bkN4HOCfVaozZt5Qx64CMOuGDiyvyxAV86z0Jw1dAAObp9lPWQIHlYJ5zK7vxesNV8fgar92JwDAOqXYAtML4OzhB9gkWtdseqoANDPHtEiMsX43UulExYbFGiI/qRzxo1ZNh4fG02lyb4dFc4JifbP2ZlM50RvHbTscIct3oibU9MTt5S49my2f0GJT0ZT7Y5/YYzlw5ecH8QrdA3i9RgDleQSOgUFpgd1oVmbj+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clpd5dCdiOVI+HxjiZ7bMzFZiPqZ2bI959Z5ggDsEkw=;
 b=x0Eb4Lf4zLF+UCB3zLkmYmCXi1tU2qnXlayhY30/g1PB03vMwClOf+KYUCFxilycEYwqsR6ZoarIvrhjnwwBv92MdjAelVAyqk7jZbAmScILFpaVdjOA4mYkZhsA+YPoQiJJg29gfGA9VYDvSQ9uGC6spSBrA2z1IWne/zxGrbSjCRCZJGthmoHkQilXIQu2baSvW9BSaaB8/q5valp2aaz+tpONWy/7UhDePXyCgmQweH2oO7sgznMmRj2rxEC2lJ0+KBVw/pGJVVyS+6dXzYWDBQc2f6Liefbx1EFlh10TOQP4YqTFZ7M231IU5dUU9UnXIVAYLFbGgLfS17iNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clpd5dCdiOVI+HxjiZ7bMzFZiPqZ2bI959Z5ggDsEkw=;
 b=YbCLp4r6k+ukzWo8aI/cZa6ns47ruKY+FcKZ4WUdFXll9WmtY3fK4uHhRNbWlZdANTDqmM3GCXWCcwFq/4xFymYDAQLz1rSMlG156aUmwO2dOGqc01Axq52stlq14MS/eKO+tfOyjMBnXiO7eCSSgF0ds6j0ak26wTJ3muaG4g8=
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 22:28:52 +0000
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb]) by SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb%6]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 22:28:52 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
CC: linux-stable <stable@vger.kernel.org>,
        "sashal@kernel.org"
	<sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "kenneth.t.chan@gmail.com" <kenneth.t.chan@gmail.com>,
        "hdegoede@redhat.com"
	<hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "xi.wang@gmail.com" <xi.wang@gmail.com>,
        "mjg@redhat.com" <mjg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 5.15.y] platform/x86: panasonic-laptop: Fix SINF array out
 of bounds accesses
Thread-Topic: [PATCH 5.15.y] platform/x86: panasonic-laptop: Fix SINF array
 out of bounds accesses
Thread-Index: AQHbHAbCZXx87vdNGUyO1E/V2VIMCrKCFHCAgAANW4A=
Date: Fri, 11 Oct 2024 22:28:51 +0000
Message-ID: <67FA963C-4717-48F7-BED0-E7E2B7F98182@oracle.com>
References: <20241011175521.1758191-1-sherry.yang@oracle.com>
 <a96536d5-4d55-4e79-bf1f-519e77dcbf06@oracle.com>
In-Reply-To: <a96536d5-4d55-4e79-bf1f-519e77dcbf06@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7082:EE_|SA2PR10MB4506:EE_
x-ms-office365-filtering-correlation-id: 97842d62-772f-4ebb-0d44-08dcea44158d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aThhV1JaNTQ3Y0F0cWhMSnAzVEQrU0o5NTljWm55bHFjSzVRZ2tPemlTRUJM?=
 =?utf-8?B?OXBudzRKTlhMVjhWcit5NHV6TWJsaUg2WUJlZDN3eWVuYWZVZEw3d2wyUXJa?=
 =?utf-8?B?a1pYUHNoZTVLMWg2L3pCQXZaWmgrOSs1aUFxMEpkVlh5bm5zekhlWXF6NGRL?=
 =?utf-8?B?azJuazdOM0xQZG01a2tyaVpFTUtpOXIyTG1WNkJ0MmIyeEhaWUtCZFV4em9j?=
 =?utf-8?B?ZWY5dGNZSkttMUVtcnhsQWd2SFZDTlJrTzY2RGJqYVNtK0ltMWlhL25Za0Zt?=
 =?utf-8?B?dmRSanByRlJKbVIwdGRQVk1TQ05pZU9iRGUxRWdvVmNYblB6L1JmZklDWFRQ?=
 =?utf-8?B?Q0NkNDRCN0RjSlZOUkU5R2dwc1RzYUw0UHNlQThGa21OcUlSOXpMdS9heW9u?=
 =?utf-8?B?U0tyRWlIOUZhKy9aalJWcXgyN3VTZnNBaEhsSi9VUE56YTVKRjNGczdYeWlq?=
 =?utf-8?B?dHorU24rZlBoQVMwT2dpSFB4QnBkbmsvNUdUd3lldlJEQVpqQkUvaUlVZHJr?=
 =?utf-8?B?YUk0S3R5VDRRVk5XeUxYUEpZc2NSZkJPdG1tUVNCdnpHVVJlUE4rTXcrTUpm?=
 =?utf-8?B?cXRhYXBVUXdTODZla1ZmMTZYL2E4ZEcySCs3aXUwRi81MXR1Ryt4YkN2YVZy?=
 =?utf-8?B?ME5Idmp1QmJKWjNxUHdRZXNWTGhLNnpoWHdHOEZNR2JqZTFxd2dsZWcxVDdV?=
 =?utf-8?B?UmRacitNYldkOGprUjArRWcvUjg4c1dQUCtMaDZWYnljd1NYa0VxalRRejRn?=
 =?utf-8?B?Y3BianM4L0J2OUFabDd0MmMxMy9nTXZ1bE15V3pGTzVhcE1VSDNLVDR2U0tr?=
 =?utf-8?B?QTJxVHNwK2J4TDFhRm1mVDljTHRjZENhcFhQMVBWUVloTmRoUU1yMEZnNXE0?=
 =?utf-8?B?cGhocms0eVRjS2orcXU4WVFPU2F4MGxLZWE2RG5aaWxDQlJrYWJlWmhTQlV6?=
 =?utf-8?B?RU4yekxSM280cGIwWWdWeGMzKy9aSUJZaWZBMmc3NThoL0FWc2lXN3VvWWJL?=
 =?utf-8?B?Y0dWeFJJV0c4M1FETjdQdDE2MGFjaGhFLyt0NXBmM3dPekxENGxSTWIyYWh6?=
 =?utf-8?B?K3BmK3d5V1o4dlJPbTRWOWhqUXFyTTREUk9ENi9WSWM5Tm1MTGNvaWxOWDVL?=
 =?utf-8?B?VDRUWmlZdjcrMWo3OG1pRFRKaFE3L1UyN1gxeEMveWZ6NlNaeE5XU09lTWt6?=
 =?utf-8?B?YUZtMWZvYmYvU09HaUtVaUh1a0dNZ1NiSzNKYjg2bEtPY3p5aERUTTNoRE0y?=
 =?utf-8?B?a2p2ZHdBMUJHT2gzWUplV3dxWUVOQ1hWNnkvSkNleEtFVTEyb1prQ05kbU1H?=
 =?utf-8?B?UVBjT0tiNjhOaG4vT29WR3A1bFlzSmdRSTROaUoxR3l5NndLVnRjWDFHdGhu?=
 =?utf-8?B?aUxXSEJ6eDlsZ2VGOStDUzZtR05aRXNLMHU2Uk1TQTJHZDlLZVhaeVpWZ2Rv?=
 =?utf-8?B?WGhVSlZnMjhQbFBpUWoyWXg1U1BGeUxKTWtiYkRNKzFnaDQ4SDQxN25lbk96?=
 =?utf-8?B?dWFzNkNFVGUrZ290RjR3V0NGRzJWaG93UDdaaWF4d0dwMG4zOHFZSFVodGx1?=
 =?utf-8?B?YWJXSDVlbkE3Wi9ka28yNzNScUpObzcreWlvVml6SzFsYTRiWW5LMUJkOTVC?=
 =?utf-8?B?czBONkUrOWc1aURWMHBMZWMzcm5nVnZKd1F5dTlFMjJablZoZnZTRkozMEla?=
 =?utf-8?B?ZFFEck1DQzQ1bXRpdnlvN1dKbzFYSUtvVGVtL0JJM3M0MnkvWVV0VHM0TitP?=
 =?utf-8?B?cjJqc0VINkhnZHlUMUR1L3VLeGhIMDRwdStxNnB2bjEvZnpXWVlzb2RHb2hh?=
 =?utf-8?Q?cjbOjxTLAcE1b+EMApF0jaS6WNDHfAGoO8b/s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7082.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nzk4U2NTOXR3eDZjR1YyWHBNcUlwOGs2OXhORC9YWkxLR2I3bzBjcTk2RFg2?=
 =?utf-8?B?RTZFMEZ4ZG1NWWllWVRoV0xwaVY0RFNTZ0JIbUtqL2h6Sk16MkVZWWVpZUk3?=
 =?utf-8?B?amdsZEFnaEo0aVZMeWFGN29UdVBqMmJHai9CWVp5ZTNyQk5CSGZBNk00aXd2?=
 =?utf-8?B?aGFuaHNNSTQ3UnQ0TU8wTVIxa21qZUpyNGo4clo0S2IrZkdRenp3SWpQRHRP?=
 =?utf-8?B?OFlqZFpIb01ONzk3OHdRYU5CU0tVbElJWWFmaTU3N2pkc2x3VXQrMEdQNUhj?=
 =?utf-8?B?dlQ5YS8rS3lHVkpTNWhKUDM0L1FqYzdzUTRvOTJLVWh6cS9vdS9ISG5lUC81?=
 =?utf-8?B?N3JudVRDNUNDdXEvWDhkaFVUK1hxbEFUL3NsR2dHcXU3VzR0Nk96UHg4YmhH?=
 =?utf-8?B?WlZDRm03UG0zWWxUT0VlV1JWTGVkeUxUMDEvUFI4dmJrY2xiYWQ3bHpSSm8y?=
 =?utf-8?B?dGdma0FGcjJtZzE1eE1pbVc1ZXRwdnpuS24vTlBvSWE4VmJNVm5BSis4RWcz?=
 =?utf-8?B?NnRYUmZWTVE1eDRBN1JuU0xwSTY0N1pUMmJLRjNTMGZkZFM5OTdMM1VUUGtR?=
 =?utf-8?B?Z08ydjJoZk1BU3hPbElpRElOeHhRYTh1eGIycXZ5dFkxMTJ0MXpuQWFzc2ls?=
 =?utf-8?B?S0M0YUpVOFNkdHpTaVByck1xOWVwVDN1WXBHQ0dVSnE5RlBJcStBNlJhS2JH?=
 =?utf-8?B?SHR0TzkwV2EvamF6M3h6c1FkaVBGQU00VWNTRVR4ODVsYUlLWTVmK0FNOGRt?=
 =?utf-8?B?Q04wd253OXJwVms4YW9LTG80ZDdiYi9KNEVvRHZKRWNuTDdnRnA5N0dqdC8x?=
 =?utf-8?B?azc3bUx4SFpPcXJ3RFF0ekdYQktGNUl3eFVKL2FKU3ZsZXFaOG45UUV0dTJ3?=
 =?utf-8?B?aE8ycGN4TlVIUFBoUlYvcnB6ODVzSmdjeEJJVnBGUkxUMnlsSmpCM3lFNDQ2?=
 =?utf-8?B?UmVJRnVMUFN0SS9DTkVPVzQzak5iVStyT3NoRlYxZFVtd1dSZGYrV090bi84?=
 =?utf-8?B?ODN5OG9Wenc4M25uc2dHVGdnaUt2a0RJcFJiSGprMC9EMm1NcWU0a1dVdkVi?=
 =?utf-8?B?K1VNanNMNnV2eThGU08xTm54MW9YVUNxa1NKZThUYndOdDgxandsazIzbnZG?=
 =?utf-8?B?NWlDS0lxYWw2Qkd1VWt0QUJxd2ovZG5rMGRZNklLVnovRUl5YkI2S1Q2UHRl?=
 =?utf-8?B?UWN4MVk5RDZPTnVZMVhKaWJ4WHRYRHVrc2RWVjQwWUh5aCtsN3lyanphUG8r?=
 =?utf-8?B?UHFVZkdsMlptL2dkdmVTZGxwMllZeGdnTmlhQUQzR1FkSUF4K0VlNGlQTjNI?=
 =?utf-8?B?TmhUVW1NMVQzbHdKYytPcEsxaTZkQkRTSnMxTXZ6Z2Q0VmZTd1RDUG1Gb2cy?=
 =?utf-8?B?UVVHVy90M0ZNTlNBWVpsSm0vbkRnSlA2NmwwNVkvaGZnalN1UEJkUFZhamty?=
 =?utf-8?B?Lyt3U3BPeEhVKzZ5Zm1KOEFlK3RVendRMzREZFFXWDhmZHdCUE92cjZ4MkZl?=
 =?utf-8?B?ZXoyZzhrdmRpN2lQYVcxVU9TejFWOXMyQ29wT00wdGd6eUpxczhjYTRlL0h0?=
 =?utf-8?B?RC9jTjhCVDNnZy9HSHZQdllsOHA0d2dGKytTaWNYZ2NEYzRMTnNTK2hkVVZL?=
 =?utf-8?B?ZEdkd0Yrb29jdXRwMUlKbmw0YUZQNGJOdXhBYW5UZExRek5GMjR0ZjhJaDJ4?=
 =?utf-8?B?dG9ody9COU82eFhYVWRTaWo4VVFsYVpQU080WmJsSWpFeUVmY2tSbXNjbGlz?=
 =?utf-8?B?RXZ6aGZjZUM5Qml2RVRjN1FIc3N2OEN2MkFaQ3lOWEgySjIwRGdEZUxLdzFI?=
 =?utf-8?B?UjlGWjdPN0wybUVqSHN3MEorSU1zZ0hWVWJhekdSSm9PeGl0dmR1a082MC9i?=
 =?utf-8?B?SDdWemNuRlRhWkcwaWFpTzFYUldSdHJMZWlHVU1jOERUSWhYaU5oUytyWndR?=
 =?utf-8?B?a1JPbjJnTUk3Tmt3NHcrT2ZiSFNSVU1XQm5lVkduWXh2QVJ6OHZXNXRNdmxx?=
 =?utf-8?B?Y0FCZnVjZE9aK0pBbXZzOXNhRmZOdnAwWjJDblV2UTVJamU0dHM1RTJQdnp5?=
 =?utf-8?B?N3QxN00zbURnMFRGc2tyVEplWDIrVGdMaVRHQ3czQzJXZGNMY2xkL2NLbngz?=
 =?utf-8?B?eStWb0VFWS9HVlZnck5Od1U2eXBySk5BZUJ6NmRpb1ZMRXFyM3B4N09xQmgv?=
 =?utf-8?Q?O7S2RBRRoXvyqdT+BkcLmNk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <959891F49F4B1E4B82AF5B02224741C5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hgFaRsTpfT0Fw4omzNTREyZ4jDzpBccvEDwh2ILUAz8cHJE52LndZDCG7T9e03C2v1D4q4LiYIcRNAcD5DYW5FiTpnQ9RMPeY/OwTC0ukgQ7OvByx3Lyxc4gDOzn3VFqw83Yika4tRf1dLAjHaD27cuw/BGj1ff2f2STL6fDTPAF8TWoQ+uPo6rOrtNKFSMofrWvh/EH1mnrPntnqOAY7CeESRtgkFi7OWJVoMGoQ4eE1PPNL2vRmw7Krr5swzfWuFEzdS/YPtGE/0s2lkRS/SoBSatvAGMeV6u9azk7FlPbXdH5FcA130D828TaEYsfuq/FfKLyqDTRhUV25Yh0RMN3KsY9GoJJLVYDU2uSw5T2AXTz3EMmInACOeam8zYtB7CIf5tdkdKOQaV5KQgbLpCOzsYxHUpiw708ApyK+L9KdEdX/50A/3jztmwqLq/j5g5vo/FTSWBQuoQr09pZkf2ZC0Gi9cERutmqESP/AVPlnmkeahqxyFsnTVjrrC7CNYdeHYzjj9o66kUdNgTnLkKgiY4xlKL2uakRGTyimtJO/ptCCAr/RSiBAvpozREemRCuBKSj/TkJMngbpzSwHHJ3DcjP3/rssRGyCBU2OLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7082.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97842d62-772f-4ebb-0d44-08dcea44158d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 22:28:51.9476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wZ3gHc9e1W2EF8rZwNX0QDajKH3UkLKrCn42jnanGJXZbDvCD4WEJe9MavAkzPjxO+vh1S65dl8XssWHkEiOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110157
X-Proofpoint-ORIG-GUID: YxJThOmmhhNHN8TVxyTXRCEAhEEKJkyc
X-Proofpoint-GUID: YxJThOmmhhNHN8TVxyTXRCEAhEEKJkyc

SGkgSGFyc2hpdCwNCg0KPiBPbiBPY3QgMTEsIDIwMjQsIGF0IDI6NDDigK9QTSwgSGFyc2hpdCBN
b2dhbGFwYWxsaSA8aGFyc2hpdC5tLm1vZ2FsYXBhbGxpQG9yYWNsZS5jb20+IHdyb3RlOg0KPiAN
Cj4gSGkgU2hlcnJ5LA0KPiANCj4gT24gMTEvMTAvMjQgMjM6MjUsIFNoZXJyeSBZYW5nIHdyb3Rl
Og0KPj4gRnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4+IGNvbW1p
dCBmNTJlOThkMTZlOWJkN2RkMmIzYWVmOGUzOGRiNWNiYzk4OTlkNmE0IHVwc3RyZWFtLg0KPiAu
Li4NCj4gDQo+PiBGaXhlczogZTQyNGZiOGNjNGU2ICgicGFuYXNvbmljLWxhcHRvcDogYXZvaWQg
b3ZlcmZsb3cgaW4gYWNwaV9wY2NfaG90a2V5X2FkZCgpIikNCj4+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRo
YXQuY29tPg0KPj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDkwOTExMzIy
Ny4yNTQ0NzAtMS1oZGVnb2VkZUByZWRoYXQuY29tDQo+PiBSZXZpZXdlZC1ieTogSWxwbyBKw6Ry
dmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
SWxwbyBKw6RydmluZW4gPGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPj4gU2lnbmVk
LW9mZi1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4N
Cj4+IFtTaGVycnk6IGNsZWFuIGNoZXJyeS1waWNrIGJhY2twb3J0LCBmaXggQ1ZFLTIwMjQtNDY4
NTldDQo+IA0KPiBJZiB0aGlzIGlzIGEgY2xlYW4gY2hlcnJ5LXBpY2sgYW5kIGhhcyBhIENDOnN0
YWJsZSwgSSB0aGluayBpdCB3b3VsZCBiZSBxdWV1ZWQgYnkgc3RhYmxlIG1haW50YWluZXJzLg0K
PiANCj4gSSBqdXN0IGNoZWNrZWQgdGhlIHF1ZXVlIGFuZCBpdCBpcyBhbHJlYWR5IHRoZXJlOg0K
PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUv
c3RhYmxlLXF1ZXVlLmdpdC90cmVlL3F1ZXVlLTUuMTUNCj4gDQo+IFBhdGNoIGluIHRoZSBzdGFi
bGUtcXVldWU6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3N0YWJsZS9zdGFibGUtcXVldWUuZ2l0L3RyZWUvcXVldWUtNS4xNS9wbGF0Zm9ybS14ODYtcGFu
YXNvbmljLWxhcHRvcC1maXgtc2luZi1hcnJheS1vdXQtb2YtYm91bmRzLWFjY2Vzc2VzLnBhdGNo
DQo+IA0KPiBJIGdlbmVyYWxseSBjaGVjayB0aGUgc3RhYmxlLXF1ZXVlIGlmIGl0IGlzIGEgY2xl
YW4gY2hlcnJ5LXBpY2sgYW5kIGhhcyBhIENjOnN0YWJsZSB0YWcgaW4gaXQuKEFsc28gYWJzZW5j
ZSBvZiAiRkFJTEVEIHBhdGNoIiBmb3IgNS4xNS55IG9uIGxvcmUpDQoNClZlcnkgZGV0YWlsIGlu
c3RydWN0aW9uLCBnb29kIHRvIGtub3cgaXQuIFdpbGwgY2hlY2sgdGhlcmUgbmV4dCB0aW1lLg0K
DQpUaGFua3MsDQpTaGVycnkNCg==

