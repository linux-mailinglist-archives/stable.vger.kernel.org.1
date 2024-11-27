Return-Path: <stable+bounces-95586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38A9DA252
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 07:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5328358D
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 06:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D0113B5AF;
	Wed, 27 Nov 2024 06:30:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFF139D
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689030; cv=fail; b=gx9IonWPtkMYZjw3h/FZhg0p/VmbM2nUpt3d8Ef4Blk6zMFkkzAeb8UEmKTHHZ0qkm86Eex5em8J8u5PhjfJbKYoDnNUX0uaMW4A2m9ZBbb1TksMIsWpZOuak2FSBoEm7lRS9IuWjsC0KrEs5Su9fiCeJOeasi9Xss2KLc6wTsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689030; c=relaxed/simple;
	bh=SYUT2hjrmxMd4bdIMnTFjztupXj55IjdFOnQSb/R6nk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZzSG1XDhMa6ad2tm/W2JvNRRLqYFVIX7dYkyZwpByLFFi+gxEuvRhu6bd+LJY5CMQI9yGIaLbTkG4b9Pr1ynI11xSMqhzjSsMUdH6Rbqtht1HaxKD9uRsu4k65Ho72gC4zz4UvGhgNmFFeJXaeye6s3R2N4GWMV9wCWXfMjIuh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR4WRME011898;
	Tue, 26 Nov 2024 22:30:23 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433b79byaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 22:30:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JL1xC1tb6dLt1gZged7A7B/DG/KPg5bSGrgTi5Fhlo3RHQC3KdC2B9bc/Px9cCT4FvxdsGUERl7pUugyJgNqrZeeXvBKui+Ep62vG0hr/yOJHzu5mbsARqdUFPxP2N3UX/bhJAOqgzZTENH1qBrpxySfwj6bLuxy2nh6EhNtoqS9xSl8dQuOtNIBgnIsUekzwpVuWqyWRShhF5XOMOc5/gwNeGTAJMXUs3LRbNffGffUGiCX+VhCYcGVl10oLpEeZDilP5kERkPa1H7VIiW62rPJuQhhnfceCipB6BzRXXrFpubvL832uckYaWc6vVAFbN90TT9q29REWTEphBx7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLlBSOn5bi40rLQE2urDg2enh1kQDcOW1Y4dKttGMB4=;
 b=KooChQvu0dfbuomgLPT1wnwW1hhn09ZlWgTAuqli9RX/8zq8WcPIJngBSK0jbaV8k6ZBKQVxNmA39BPSoS5Gb32GdQYbeuzssaI0cXd7l9Smel2hZrkF1HujLad5Ss0jr0dWDWal9+eLfW2d2EQJxDvSxXSU7opNRofHJ5JuyRExyQeEAlaFiWGRRuHWuzQusWbg7TITLxVUDkSBhSuzGsDPLBVomaxwTFp3UqVvF8i6Ax9tnCt7Vc490VeI4w1g+ud3nIac8WzLDjPxERLWEtbGK1A8AQ7iXaYLvp+mGk437miNFjX3Uzw4dZx4ut7efGIOu5Ir37cmVZwY7KHmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 06:30:18 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 06:30:17 +0000
Message-ID: <1d763451-2b60-445d-b6f3-5c24730be8b1@windriver.com>
Date: Wed, 27 Nov 2024 14:30:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] dm: fix a crash if blk_alloc_disk fails
To: stable@vger.kernel.org, mpatocka@redhat.com
References: <20241127060354.2695746-1-bin.lan.cn@windriver.com>
Content-Language: en-US
From: Bin Lan <Bin.Lan.CN@windriver.com>
In-Reply-To: <20241127060354.2695746-1-bin.lan.cn@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::14) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d2e6c8-dacd-4e2a-1f47-08dd0eacf57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?end5M2xlNXhMRjdwZHBRYUJuRGovTFBXUmIzUFQzakZTYnczSURUMjdVeFBp?=
 =?utf-8?B?ZjgrREwxMXI3NzBRbkdRNGNrbmVKbFZReFcwaUFicWxXSHk2UUN3aWw1enRJ?=
 =?utf-8?B?RmZnejROMDR6QzZJeDZHRWxsTTNUUmxKOStDME80SmhhZHZPZDM4NUtTWTMr?=
 =?utf-8?B?YmFhaEhBNTRVYTFoMjFycFRyenhCZ0RyQXZPOGNML1daTXhXOWR6TzNiUWV4?=
 =?utf-8?B?RnNwazh5dVFrbElMZEsxbUR4Ykt5TGM3TWpOeklqc1Y4dk4zSlZVbjZ5ZWx6?=
 =?utf-8?B?TFVDelpQcmFwc1RxbnQ1VWUxbG5YOEpiMUhnclhyMzhDclVuWUZkcHNMTWdj?=
 =?utf-8?B?UWR0eFdwbkNKM0hMWERpNlIzMFczaGEvTFEzeitZUEZOMlVTMFpHaU5OK0dy?=
 =?utf-8?B?NDE1b05FcmhxUUkrK0hqNWhTSFg3S2FFeWhPY0YzYVZDVUZpQTRveUp4V1A5?=
 =?utf-8?B?N0tFMlRUSDdKVEUvaXZFRlhzRnlJc0VXNE5sNVVWUG5DNFA4SWdJcG9jOVFD?=
 =?utf-8?B?K09tc0JjdUUrbjFLdTFJYW01NjBEYXdabEpDcFJKVk9uMHR0b0Yrc0tMR2Iw?=
 =?utf-8?B?cG9LbWFIU2RQM1o5M1VXSFZpSFpMR1Jwcmo4OHU4Z3BWUHVrK2l3VVR1TnZ1?=
 =?utf-8?B?WGc4clN4cG5lWHg1OTJkbnZlU0QrQ3ByT2pwNDl4RlA4VjVBdHMvVXhiMmdt?=
 =?utf-8?B?blcvcEdOUFJUai9rUDBIVFFvaHlGMEpRNFRlK1U5aGgzaFEzZDY2U1FvNHho?=
 =?utf-8?B?YkR2TzNpdVl6blFaTHBRWTJUUUh2cWhzL1EwWU0xcWp2Y25oSnU1WmM5ZXc2?=
 =?utf-8?B?bCtuK0ZCOWhRNkgwZHVjR1ZRWmFrd3JTTThjK3RwQ0VKZ0pKZHhaWmdoUExB?=
 =?utf-8?B?bWlJTlZ1R3NMTHZVK3RoMFpHSkQvUG8rRy9xWTIrTmUwdGVoTUh1WEsrb202?=
 =?utf-8?B?dldJR1NTRG5RYjNORUF4ZnYxZDJnZThNSTM2akNlWmxYdXJEbVJDbHFrVmpz?=
 =?utf-8?B?NG1nTHVLbXo1UHk1TFJadHZPT1BsU0FNT3pZR3VudXVqMjBJdE1FUFBTTDZ6?=
 =?utf-8?B?N0tHbGQycDJuU25GaEswUnp0MHpwbXdod0Y1TEtjNFZGWkV2SWIxakN3eVpK?=
 =?utf-8?B?UGg1VkpMbUpWQzhIUi92S0hGSDRUNGlWMjh5WGtIZmJtWUlYTlRGSzA5Qmc5?=
 =?utf-8?B?M1FXb0dDL0tnbkdMUXMxUmhqemJHa29XenBoVmhmYVJGWUtySjhtMUNPWEZT?=
 =?utf-8?B?Z2k5bFI5c2Ivc0dnck0zVTVCRWR3SDIvR09GLzEzRHZUbXBrQWp6RzlDT2ZO?=
 =?utf-8?B?LzE3MkVBM09XY1pWN2FkdWdVWlVSSW1IMk4ram9EYjBWajdrWHF1ZWtUVS9q?=
 =?utf-8?B?Rms3bHZHenJMMStUWWRpYmNNcjFtbnlSZFBISFV2NjcyY05BNVV1NXBPMTFD?=
 =?utf-8?B?NlU0anJtTzhZUjlydUhQQ04yMVZqZlpwQ3lyejQ0MFpxZ2UrQ295MFpuQzhP?=
 =?utf-8?B?enNuK29rYkJzdDdvYXd3dGNuUHZydUl4WlJ5SlJhdGpUK1JaQU02bXlzbUxB?=
 =?utf-8?B?eVpiSVlURk1LMFkwcGJpeGdSNUVrQmNDdHo2QW5mUWsxUWxWMlhuVWZ6MXNn?=
 =?utf-8?B?WGFMMzJhcXVWMmVwbTlRNE1pRWtuQ0VhakI5MWRvUE1jbjByY1BZeHNHS2xM?=
 =?utf-8?B?dHdNN2htb0JTa3FsS3RjZFB2b01ydHg0S0dVNHB2SDQ5bjZ6Vlp4NnF5SVJk?=
 =?utf-8?Q?rOVxiCAFSgrySEYRT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qml0S3FNbTBPMVRDV280L00rd0pnY1lYYTZyZGVkMFZaaVIxQTUyQnh0cXV0?=
 =?utf-8?B?eWt5SXkrWENsWHQ3TU5VaWVlTmxTaVFLamJlQUJPclFEdVR0OGNTS3VVS2l3?=
 =?utf-8?B?UGhOL056UU1qOFdteUdYNmYyMzNLSS84cGNmck1oV1N6Z3FPL1ljUHBzQjlX?=
 =?utf-8?B?TElnTjhHK2oxOWphbDB4OTY2Y1M4aDZwVDZxam9zTDlZRjNFN3o1M0FmVmtB?=
 =?utf-8?B?eFEzMDI4YlhGZ09ZbkxEK0hzS1RKUHJYcWNGdk9HWWpSUHJVQ1ArNHZyUERp?=
 =?utf-8?B?MS9QR1grZlVqZmlhRDFNNkw1UUhESTUxSUs3ZjZmckVGWG5sSS9CNytRL1B5?=
 =?utf-8?B?S0M5S0ZzWmp5emRPdFZLU0lGaXYrcldrSUdtMUk2eVBqMGJFUEVtWHU1YTkw?=
 =?utf-8?B?TnB5ZlRpZjQra1diYUFxVjdlRmt0bzYvMzhmaUVzVHg0c0ttSGJVbWkrS1l6?=
 =?utf-8?B?dzNvaEEzdHF0MFFjME1jNU00aStjOTc2bE5ZNm04QVBIM29xUUNJRDl6L1lC?=
 =?utf-8?B?dnd3SG0wTkV3UGIzaGR0WjY1SzFnY05CQ2tUam5IRXVZemFIcEppMlRXaXBV?=
 =?utf-8?B?WUk0ZkFaOGFNbzZrbWlsaXFCTDlZc1FjTTM4NTRrWndNbU9hN1Q2VTYrRHpG?=
 =?utf-8?B?MGYzbERlUHRaelJsT2pxN3d4eStMRHNoeDZFU3hQc1E1dXJ4NzVidDVnZnhs?=
 =?utf-8?B?S0FrSFA2TENCOVl2SlVaOTh4OFhvcXhkRTROMTVIMkEvM0xUc3BackdRUUMy?=
 =?utf-8?B?M0R2WHU3NWFsbENzZmZVdndGQk9nalpZRFNsWUIxN1pPRjIyQ29DOEl6ZmM5?=
 =?utf-8?B?UzJETEkrZkFRaTBWUGZ5SGdOYXNWQnhMcWJxaHdmVVhNek9nelRrYWNWZGJH?=
 =?utf-8?B?Qld5SjRtamcrcmRYRzlLaUtVVmlmVmVmYVZNbGRPT3dJV2RzdytROGJsenN5?=
 =?utf-8?B?cjFrOGlGU056NzBXRS81ZjRINXZvekdKUXordnJkNmRRcEcyakgvS3Y2K0Uv?=
 =?utf-8?B?VmtjSktuaDZZSVllYmd4NVozSlYwWDhSL09RL3NSMi9zbFJRb0FVcUd1OHNi?=
 =?utf-8?B?R2RQb2hveVV0UGhGaExocUsrNzJ3MzlpaVh3am9UTXZ0NDYyUGU4TEdOMVFz?=
 =?utf-8?B?Q1QwNzlXTDR1TXUvcnJ2dHV0c0VnaDYrcXZkZUV6Yk1Zd3Q3Q1IwaVp3Uzds?=
 =?utf-8?B?bXZkWFdWU1VJLzUzMjB6aHZNekk1TXJPcm92MU9QZ1Z2K0FIb0JBbFVvdjd2?=
 =?utf-8?B?UXNzN0NlUEdFQW1lZDRoU1VseWF0c2ZMZVlOSDN0cWNFVE1WSzZDeFlKZXZT?=
 =?utf-8?B?U3BEMk9oRFRDd2QyQUdiamY2NUxmQ09IQW1lRXI3MDN5eGlFRTQwdE0rZ2F0?=
 =?utf-8?B?ak1PSmMyeEFyUEZqQlBJWnkwb1BQZlVUVWFJazNQZGpJTSsvMlN5SDNBV0R1?=
 =?utf-8?B?cGg1Y0VNeGgyZkNVVzN4bG1tbFVlWWpmbVY3VGVQeVdmNytGTHR4TlE1azUr?=
 =?utf-8?B?YmpkamJhMkxHeEZPa1FrL0pjbk9PK1l1bzBTbklaSldBU0hhVkhMVmxsVFJr?=
 =?utf-8?B?NFJEdDhCRWpIWHA1OEJDZXo4bDYzYjlTVytWUnVVNEtRYWx3SS9nMmFsTlI1?=
 =?utf-8?B?TDRkMHNROUJhRTJvR1N4Q0dNeTZFcDVjMzAzTlBjTS9hWDJrVEFxeGdNZzdM?=
 =?utf-8?B?VWR5b2lzcDM4aHpPaFNZeGp0TkE0MEVZMExBWS9RaElxUEVqY2hJbVVjRHRJ?=
 =?utf-8?B?aVBRMGNJS2FzVUYrR2R0UHdPYWMybks0VHRoNVlLbXhhMXNVTGEyd3JMNVJB?=
 =?utf-8?B?UzZhWGJ6bTlLM3NYVk1JTVlOR0Y3Ym9OYWRua3NrSTIxektMRS9PK3hWUFVX?=
 =?utf-8?B?L0ZvUkZGVTRRSm95TWk2dCtBaUx1MWdiTXdZRjA2L0pJVCt4aElRYXBxK1Bu?=
 =?utf-8?B?RVk5c0NvWUpnTmpscGdFWXI1TlBuVUs4d3VRWXZDakhOekdYc3VRcm8rbWw5?=
 =?utf-8?B?dEdFT0ZBdFgwazVvY1N1VndLQ2FrNElKaW9JQWF5aUxOOUFZM3JiRjg5M3Nk?=
 =?utf-8?B?NFl5TjYyd1JpY05YRVJkQnkzZFJFUzMvaTc0cEtkNU84R2FBUnpWbEd1STcz?=
 =?utf-8?B?d3NWSTd2bmRNdFUvTWZ6ZUwwLzVDUnBtUnhHWmJrZDYvSUp4c0hJeC92UEV3?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d2e6c8-dacd-4e2a-1f47-08dd0eacf57c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 06:30:17.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfgyYRH8Xmk+j0zdHxownCn14xXtYheGlTTswVjAvhdIG8h2B6nWVPse5N22uc8fveyzB/GThqVsRJnWl0vcOSFcFXOZb/gxtLJZBB2NK9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
X-Authority-Analysis: v=2.4 cv=atbgCjZV c=1 sm=1 tr=0 ts=6746bc7f cx=c_pps a=yF+kfS/uWKtSACHbTM5LMQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10
 a=gu6fZOg2AAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=t7CeM3EgAAAA:8 a=NKcImveXeWnOTgmDRuoA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=2RSlZUUhi9gRBrsHwhhZ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: A7fLvNVgDyqae30zpC20K3EuoTZL-kEQ
X-Proofpoint-ORIG-GUID: A7fLvNVgDyqae30zpC20K3EuoTZL-kEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_02,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411270052

Please ignore this patch for the return value of blk_alloc_disk() is 
non-NULL or NULL at linux-6.6.y branch.

Bin Lan

On 11/27/24 14:03, Bin Lan wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
>
> [ Upstream commit fed13a5478680614ba97fc87e71f16e2e197912e ]
>
> If blk_alloc_disk fails, the variable md->disk is set to an error value.
> cleanup_mapped_device will see that md->disk is non-NULL and it will
> attempt to access it, causing a crash on this statement
> "md->disk->private_data = NULL;".
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Closes: https://marc.info/?l=dm-devel&m=172824125004329&w=2
> Cc: stable@vger.kernel.org
> Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> ---
>   drivers/md/dm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 5dd0a42463a2..f45427291ea6 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2077,8 +2077,10 @@ static struct mapped_device *alloc_dev(int minor)
>   	 * override accordingly.
>   	 */
>   	md->disk = blk_alloc_disk(md->numa_node_id);
> -	if (!md->disk)
> +	if (!md->disk){
> +		md->disk = NULL;
>   		goto bad;
> +	}
>   	md->queue = md->disk->queue;
>   
>   	init_waitqueue_head(&md->wait);

