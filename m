Return-Path: <stable+bounces-223203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAClAs6OqWni/gAAu9opvQ
	(envelope-from <stable+bounces-223203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:10:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C01662130A3
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC584303B1AF
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8B388E55;
	Thu,  5 Mar 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="lSRp6XtH"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260BA3A0B05;
	Thu,  5 Mar 2026 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719819; cv=fail; b=dGQUSZw1nvZPCGNiZLc/cFzfH2Vxkl0apPPmCB3LUpvN05qy8d64dy2QXcjhWa561PhCbvMi9zn+XVEBCZf2ILpItr2Fuk8DbPTywrBoL6BeT+QPs0LiZAPl0Uvqx6NIlkQ6IWjS5fwMyBf8pOQihezQLze+75D5iPTvdGEz+yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719819; c=relaxed/simple;
	bh=Kpc0pZWyESy3z+DMNLjCMese2e89atEgF9otHaKxvlU=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKgbh4mGRf3iq/Xdej9RQPG5UGbc7Hs29NvCjiiYVIAz+0UB+noeElsfF27gr+2C3UWCObtc+d/xWanNpstr+LRH8QsflVNZk8UVkNlWxK7xizrQyiOXD8kMfNUoqcHkfJJTupM3T/Sf+vD7ul3rvOEaSmwtXeZWrkgJ98GKM68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=lSRp6XtH; arc=fail smtp.client-ip=52.101.46.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfvVirdXi+kab2WypUGsb9UnkFX/ys+pgtvruezn1VYNQhWxEkzqXCw0Cl7R7yEQjVHTtMq6R2xCu/7vLQvs9Kpis8x8+WRhzXyqpw7tgu08gO54AKmQmHOsuarrFKzR6ovk1N5GC2yvpd9vSrYOCuJra7Zd1lPkeOQPl4pqljJeMY5B4GOX6HCPHZ3uCzt7Dh+8fQeoZvtxtM1u4vQiB+qykaOXSA7DaXkEO//Y+Ip6F+xjRuk6+3mAeep3tkhUCz2TmMgRyF016fr+w7XOMcz75jwdjM6eXFtou/bvGjnR6dzOmeBMMfE9mmo6N6M+O6twLxtsXyMdIZt/+DUBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKTKc5haDv5AwND0znap41ipnEzWzDHZRenfaEDLKDo=;
 b=ykZiFoQMK/TcTl5YcT2DYyw4AbcB4MOaDtYT1lMaVAMSMY+CCNt8lmaBNQ4vElUH/vsUFFb0V/DnRI5IqLnCFj+bEMmyfdDepE76Qgkm9oADxps0+S2HLNEYY66ADwLWqATOyH1I8K8WhG8gbZZt/uZ/rULHQeK4F8iC1PO1n4G27uIFDJBOedOT51oSPrWMatuoRt0en8U5nSZbp9JQMuz7jS8ysUXwyKhtOGIeChPADwuUoKWdd9Et7RlXTB5QuF2YMiuyIUbDliYI+Y63IunCJSlQamv8tXS5EaC3DoxL3hbgxS/8YugdR+SRIPyldm3fyEtJ0ZT3+4lJO3yzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKTKc5haDv5AwND0znap41ipnEzWzDHZRenfaEDLKDo=;
 b=lSRp6XtHyvtRo8E9z4PiIMZpYX3RfX9MelXeEy7L04ZdIB9HEg0cWTiVkA/jEqH9StfuHLk+cyyefuP/nVZ5+e7iR7+oBAfY665aJy5+0zThGgiHMt2l0Ts30rdythZU7KuBScakKKCY/i0tN7npmHraYG4bstDvWm1E4ruOFY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by CH5PR03MB7933.namprd03.prod.outlook.com (2603:10b6:610:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:10:14 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 14:10:14 +0000
Message-ID: <14074526-5b43-457c-bf75-cef6d5088193@citrix.com>
Date: Thu, 5 Mar 2026 14:10:10 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org,
 David Wang <davidwang@zhaoxin.com>, lukelin@viacpu.com,
 brucechang@via-alliance.com, "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>,
 cooperyan@zhaoxin.com, benjaminpan@viatech.com, TimGuo-oc@zhaoxin.com,
 QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com,
 "CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
To: Yao Zi <me@ziyao.cc>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
References: <20260228173704.62460-1-me@ziyao.cc>
 <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com> <aamNaEcpOAH17QWA@pie>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <aamNaEcpOAH17QWA@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|CH5PR03MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: cebe7ca8-b9a1-430e-038c-08de7ac0ec08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	Umzxoa5cbteegUQ9Aj9OIsMeAadsK5Gl0UO42SJg1J1UyZxyCUrrRSlIGHqAn+ZXSRKJ1zjIT6uZviF500URZjV3ov06Wv7zKdQQ2VY3LLvz3LuOBR7Uzl55jRp5H1mmqXF73E7tU8tbUgfCIF3ZaUG76xpulOHs0wvKaVzrXsJFdqGOtM9pvV+vuK5VGOe2fZppY7WaClpRqy+y3Q00UkovcEg2Cd6IRBbDI1D8P7ISSZIbeYAr945geyKhMaPHTmvG/wHoKd8CjNT8g5q+uojixtQat80wR4kbMol1Rs28NoaGV0IUXCEOFgsp3L8xUj+MFKDKXfeXtMmeHth0yp4WQyy07R5PmjqZ9Wqc+vG24B1nPE918MnzJnufM1STfxUUs2n+G8/bPbr5mIzbqWp1WhQ3J2HuZtd8JA7uPuNSZblhYusm2eW+1RoWF782KKKEa6+aw7irA+4c0ohlMNK7BIQx83PwQTPF9AgHbWXYW+nv5fU4FzRSX3wXTE44/zks1ibgdiWsecwS0ZIo0YQk+ILtTV2PWGOO2Y/Tb1aqZK000N9JH/gUR6E5KCdOnRrVYMiR/nMmh/XKSfZ59uJ2zj0jr5EPPubuxZXSUA0IFIxEMPe/oo9P02K7Qq8tOA25JcXMkM199DXJ+PSsS5U7/SZd+A1MD1yWsvP0WlSVm//pfYg7xbGnRALjysXLPGFuxaASiiCHtwxZY2+551Y1godghZcZlJm3hZ3XloY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3NTaTVDcHRYU090UTBRRGRzaEVlTzlSV1RXNkNTRHJlWUlLc3ZFVGV1UXBM?=
 =?utf-8?B?R0haT0xvVEF2Lzlhb092TnQ1bCs2eTVOWTdDaVFPc2JYaG55K01NSkFOd2JK?=
 =?utf-8?B?OUhDczdxK0QwQW9HSnR4RnZoVWxHTmxXUE9nUXV1ZGFYYTRwVWFFMDZaVWRp?=
 =?utf-8?B?clk0RmtqbGVJSGN5amJJdjQvRGt4cDQ5TEE4RWlaZEw5eU1FY2t5VVBPZ2dk?=
 =?utf-8?B?WnVoaTRZUEg2TEZmc1ppZWFWUUFZbldud1AwMUVpejhsL3ZxcThSQm9MS01r?=
 =?utf-8?B?Y0hMSXI3NmFmc1EwMFBDUDNuVEtMZ1ZkZXowRTlCOXF4ejA0TkZiaUdVWjdR?=
 =?utf-8?B?YTdhZFJWWDg1eFBWWFZWN09XdGlIdzhNSG9oRzVXU3hHMm9MSnlVZW1QSmR0?=
 =?utf-8?B?T0J3bG0xOFcrVkpyNmNHQUJVVC8rSVpGc1gvVFF2dmtBWkFTVWs0TzJoSHZR?=
 =?utf-8?B?NmNSL3ZQTDkwNW9nZXJCK1UycVV5dElFQ1M4Z0E5d2F0T1owS290WEhQM2pr?=
 =?utf-8?B?ZVRJNnJ3UGtBMGl1VHRTUkxvbkpkNmhWQlNydGNLeitmSktnRTdteDluV0Vs?=
 =?utf-8?B?M294ZDRFZGhMQXBiUmQyMjVQM09UMkhZZWhwVktrazFQcEswNmhLRXdrRHU1?=
 =?utf-8?B?SlgvZVZkb1Q5L2ZMTXAwbkdaT0tEaXViVXpOeEFYYnlpeGZwVTJGRkZ5MVBO?=
 =?utf-8?B?TktMK3lMTWwxNCtkVEhLeDBBMEZLS01zdngrQ1lMRWVUMUcyeXB5YnJSZUdn?=
 =?utf-8?B?RnVkMDN3a2ZiQ0VWbEx5RDRabHQ3NVhSeU8yYy85ZmhxMG9VWk95QTVaVTc2?=
 =?utf-8?B?OVlhRUdaM3VMR0ozeGVzdk9QZWVxZGdDelNpMGt5all4VFRJWlk5VzVvTHZp?=
 =?utf-8?B?aTBEN0NRS2VkTWlkdTN3ZzZ4RlAwWGNzVStxaFBDekp0ZVUvMkI2dVFIa2Y0?=
 =?utf-8?B?cVhVcm1USFVxeTFycVdZTUFaRVZmbHNwL2tvYVBacjMyWXRMOWhMRHFtUldh?=
 =?utf-8?B?SzBUQ3pNZmZ2dDI1bFN1Q3F2N3NpZEhIKy80OHF1dDFjS1pXWExOazhtVHFr?=
 =?utf-8?B?UnRzcUVNcCt0VjZwQUZXbGFBNm0rNGdwNDd6RHlKOWhEcTYzSnJlR3Uwa3lu?=
 =?utf-8?B?cXlMV3hzZlRjK3I2RlBUOWJPZVRVZlZJMng1RDFucmRNVXhIMkpKOVZqTjla?=
 =?utf-8?B?dlVFR21MNDZHNlI1WXJOTDZoOVBJaHdzckdTNFMraDZ3d05lZEdZTVFEZUdw?=
 =?utf-8?B?UnYxd3BhOTg3bUg4cXlpMll4SDc4bnR4ZjZyWFh2NEdZM0NnS2dOb1ZHL1BW?=
 =?utf-8?B?YXNqaHdWN2U4cXJHWjNPK3JFV1dwaGU4MFAxRytBd1FianlTcC82dUR0QUoy?=
 =?utf-8?B?Vm5qbk4rNjM1YWhtUzZsL2R1ZXpDd2QxYTVYSzBvUVZoZVRUTGZvMG5aYlRR?=
 =?utf-8?B?L1EwQ2M5T2kvbFNPN3hlaUxCbXFmNEFZWnY5ZWhMV3hzblp0M2FwRzV4U1FX?=
 =?utf-8?B?ckIwV2dZV3NpYUNQZUI2U1hsRDRLNkZ0OXFxRUkyZzZ4clZMdTZQdGVVVm9p?=
 =?utf-8?B?emFMd2RYRk43VFV3TjlmRmE5bS9iMlRKU0w4c0htb1k3YkVaMjA3dmc2RGUz?=
 =?utf-8?B?Yi9PS05LdUFHUkJYMFJTZlBYbDhvZ2NzSzlVTGE4UC9DRkNkV1h0ZlJLZGRF?=
 =?utf-8?B?UVJPemJuaGZIQnJPMWUxV2QzMWZTb1dGTmxMTGVXZWtGVFB2WXJmeHdCNUlD?=
 =?utf-8?B?RHF5Z01zTC9SaDFadlNJUytzUFZlbzhCbU1pS0RKZjhPZEJSMTNmeDJOc2Nm?=
 =?utf-8?B?VEZVVEs3azJXQmZndFFDNjlXWFd0YUoycDVEc2dwN2E2UWJ1aXpja05mcjVO?=
 =?utf-8?B?T1BDRDFrbEZDR2tHWkViZk9mWHd4VXd5b3RDL1Fhd1RaTVJwamFYSFN5d2gy?=
 =?utf-8?B?VGJlL1JlUDRMeHJGVGllMzVjZmEvRHljYkovYTExY2dGb0xBRlg1WWNVL0I0?=
 =?utf-8?B?Vi9VbngxdFpYN2N4cnlyM2JwaC9uWTE4MFRIdU4yalR0RFl4bVNLN2diT2Rr?=
 =?utf-8?B?UjNjVkcxRGg2NldKN0dpdHZhaWIyaHZuUHJ6Y01lZEE2d3JSSG82V25rL0JE?=
 =?utf-8?B?bk9ka1pRY3JOeHlKeUVJVzRSYUJkWEFScEVwOTFzV2JKSHBzQ1ExU1REUytv?=
 =?utf-8?B?cEt1dzl6OGV2MkRvN20yNFkrbXFPRWp0bUlGM1FLbmJ1NklIbVZ0dmg5aWNI?=
 =?utf-8?B?SEUyZlNRemhzTk1TaEFxVHNCaFJpRkxaL0R1UjRhc3B3UExBcDFlYitTK1Jv?=
 =?utf-8?B?b0JYUnlnQWZHT0I1YWRhbnRrV3YycEI5M3ZVUDE0a3lLVVNVMlRGWmJiSTlE?=
 =?utf-8?Q?pWyDl654Cn5acXg8=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebe7ca8-b9a1-430e-038c-08de7ac0ec08
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 14:10:14.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgi++nvLo9be756Q9ZF32FRl3AYUjZBTIl4LcEYlu3wtJa+itbdeyVGnY+wtAvAqUV/ijogo5nMecsxDP3T/O7jmzNs2Z9p6cU0Mr+NGJes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7933
X-Rspamd-Queue-Id: C01662130A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223203-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[citrix.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,citrix.com:dkim,citrix.com:mid]
X-Rspamd-Action: no action

On 05/03/2026 2:04 pm, Yao Zi wrote:
> On Thu, Mar 05, 2026 at 05:03:07PM +0800, Tony W Wang-oc wrote:
>> Thank you for submitting the patch to fix the Zhaoxin CPU issue.
>>
>> After internal clarification, we have confirmed that this is an
>> issue with the ZX-C CPU ucode:
>> When modifying CR4.FSGSBASE bit 16, the ucode propagates its
>> value to another MSR register. During execution of FSGSBASE-related
>> instructions, the hardware actually checks whether this MSR
>> register's bit is set to determine whether to generate a #UD
>> exception.
>> When the CPU enters SMM mode and then returns via RSM, the CR4
>> register is restored but the value of CR4.FSGSBASE is not
>> re-propagated to the MSR register.
>> As a result, after enabling CR4.FSGSBASE, once the CPU goes
>> through SMM mode, executing FSGSBASE-related instructions will
>> trigger a #UD exception.
> Thanks for confirming the issue and the explanation!
>
>> This issue exists only on ZX-C CPUs, which have two different
>> CPU vendor IDs and distinct FMS values. The following patch can
>> be used to identify ZX-C CPUs and properly handle this issue:
> However, I agree with Andrew that a ucode update, if possible, would
> be the preferred way of fixing the issue up.
>
>> --- a/arch/x86/kernel/cpu/centaur.c
>> +++ b/arch/x86/kernel/cpu/centaur.c
>> @@ -201,6 +201,11 @@ static void init_centaur(struct cpuinfo_x86 *c)
>>         set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
>>  #endif
>>
>> +       if (c->x86 == 6 && c->x86_model == 15 && c->x86_stepping >= 14) {
> Are this condition and the one below in zhaoxin.c precise enough to
> recognize all and only the affected ZX-C models, without mistaking
> unaffected designs even from VIA? Please see also my concerns raised
> previously[1].
>
> Though I haven't tried yet, since reproduction of the problem requires
> entrance to SMM at least once, it may be hard to detect the quirk by
> executing rdfsbase and seeing whether it traps. So if the conditions are
> precise enough and a microcode fix isn't appropriate, I'd like to stick
> with CPUID matching in v2.
>
> David, Andrew, is it okay for you?

Given the SMM observation, this cannot be probed for reliably, so will
have to have some kind of model check.

Ideally using the microcode revision matching infrastructure, assuming
that fixed ucode can be produced.

~Andrew

