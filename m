Return-Path: <stable+bounces-135151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B5A971F9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD6E189C83A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D78228E608;
	Tue, 22 Apr 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Iylus/51"
X-Original-To: Stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FBC8DC
	for <Stable@vger.kernel.org>; Tue, 22 Apr 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338079; cv=fail; b=fffNW7Yg2X8X9FdyYCpfdqUeBYOPnmUL8kUZjjrz3WNWif8oJezae9ZmS95uW4+jtv0D2lyYlvpfBGTNx5dSNfvZXw44ZyDnC6sT0xDDzYkaRlnjCyoWK9ZFvNZzU27unLVmgtq3rxnuQvFm2cQxQrytvgOA4+zJmimLCz+8Zj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338079; c=relaxed/simple;
	bh=j5rxqwOGrm8GWVk2ieZG6EeAb2EtIMQL2ZvkFSjRDC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tKjoeEvvcIQJrn/DVo1IrGiltApnJxcL9YZI0gpfxhHAfIqQh43+US2+OXC/vAwASVMFHnzhZZ8DsMj/+0T+sRut5GpG3DLA/BxHEiQ32vBf56NRpCjy0LxuG24RcwgA47a25gbFkHVOlMqw0A/pOf6NGTADt4yYUGqrmHtzcUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Iylus/51; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v98QfdfVSZSRhf53qqRtf6OAxa9I93WLxMeFTzQR+wdQcxszdNWY+H96iXsij1UGQDUMRun/yRd6jAB2Osx/Z88AgdgJKUTpW1u2ozW3ow54LMtmUNRwhYf982UPiySSAKbDi7dkOhCUZiLARnvamnqra1XDjkdt5U6qPYR27uFpVy17kRcsg/csCsXrTxgX+jJ1zSwX53SFojex7fa0IcMNe7n8H5uF0tQuc/i/KmD2P4529eQwvG8Yw7DxMbfmjruQASEmBI/Po76aFgGPajg0Lej9MlV4fU4T2YXcP5TErCxiHLnZC4yQCdf12+gdpIS+P0DNcOZSpq2ofP2PtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdAxgIR+/DmbF96v/x5CwfJwF6XN0osCeLC7qtjm3is=;
 b=cGIQSgOjqjADNMEwBo13nRrq+L5/64BzHn4aT2D4TigeZGlaj/LVV4Yyt8tajjK3U0Vz6OkLCh2xdBeszCdwmmunpheOumawUIoWK1mp19nb2N4zXTox7GAt9+mVe78Cop12CTMCHztx+GYc5gDlUAUj4kXIbB9fn1oGJqb6GMbsYO3lWp7jqBAg4rfcauLCxOK9q1qoRsJ9nUGbdB2LjVeL4r/u7HZ07iVShp6aSa6ev7Q9pzfwJXL+fuzzRu92kYbVttIkhPMbT7lQnnm1+xzszM/GGyIEQO+/GqufwqCdIiSq9HgtsuVoMtOX0FtU9Hfkw/fYM3gqMugmZMuLdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdAxgIR+/DmbF96v/x5CwfJwF6XN0osCeLC7qtjm3is=;
 b=Iylus/51s4iGyPrmp4KpLN4hlHpMnYmr+2D2XWPMfwyDPT0kpMG9W/BCTs2Ml5tHnnooiPXDbLo31tRT505Vlx4ZyS9ODLAkHuwjVK9AC73ULM2Z0wYsetcrWfzcjoO5IxcAADtcELZUGgCpdT4+WD6l6uwmd5GSl/MLgxAGfUI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 16:07:55 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%5]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 16:07:53 +0000
Message-ID: <3c1b4ded-ac3e-4829-8f8d-74b98a8ea7a4@amd.com>
Date: Tue, 22 Apr 2025 10:07:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix slab-use-after-free in hdcp
To: Mario Limonciello <mario.limonciello@amd.com>,
 "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>, Stable@vger.kernel.org
References: <20250417215005.37964-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250417215005.37964-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: ae75ee2d-93be-499d-4c6b-08dd81b7d676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzg0YlhUcHhlaWpYYmp2WGdrMEszUTkwY1I1dnNYbStmeUtHaHRieVl0eC9w?=
 =?utf-8?B?UUF3eEx4MzRlL2FlMVAzbm01UnBJaWJTTHptQ3EzaVU4TTJyYmxUYjQrMUlm?=
 =?utf-8?B?bHZNalBYbWNUSVkyM3BKQXdhREdVOWpCZVVjWTBmbjgzNzhnY1ZtbEtHNmUv?=
 =?utf-8?B?Mi83M2V1MzJWUmhyLzQ1R3JnUnRZcmduN2VqWUEvTlZ3STJOeU9TQkpsK0Ju?=
 =?utf-8?B?a2FzRVVybldpdWxSNFpmeUhpYStQREtFVDhxeExYT05YejBCcWVRRTZzWkVQ?=
 =?utf-8?B?NVFTeXVSQlVyS0ozbGZKUEZXYkNqMkNPZ3pKMHFSbG5zQTM0UGNQWTF5eXNq?=
 =?utf-8?B?RlpXaHdEWVI5aWFpZzZtaHFueFN3RzdEUVk0VzFMckhadDZLaEtVOERuR1dj?=
 =?utf-8?B?eUFIMjdzam5wYUkzOS8wZFovdnN1NHNjajJPR0UzQURVenpwQUxRZWo1TU9U?=
 =?utf-8?B?Y2IyOEpjbEd4WmUxbnpoajhyR1ZMVWw0VTBBSlhhdWdudmttRWdDN3lRblpu?=
 =?utf-8?B?VkI2czdYTHZjbXFWZWt1NVlSVHdMSEZzWjlraENDOU82SC9oUmErMmpHaUZ3?=
 =?utf-8?B?VDVndXN0N08vSFR6QXBzVklNc21PcmVHcUxJUXhEUnFQMzJCVHJRTXJUREg1?=
 =?utf-8?B?MDhUY1ZCZ0dvVG5RbUtFakUxZjdKeXJhbzhHUGZSbjNCQlI3aXowOS9icjFi?=
 =?utf-8?B?bjdEM3JJeDB6TXRtbFVySFJZL2JrNU5KeTBZRXVUbEplOFFKZGp0MjExQ2xS?=
 =?utf-8?B?OHVvbzN6VHFSTk5XTGZjU2dvSHFiU0RneHhsd0w0b2UwUTV4T2FZRUs5UzNX?=
 =?utf-8?B?aUx6YjRRVDZIZjJES3luLzNMWXlLZm5HNVlaaG5PVW5PMmJLWlRnTHpOZm5U?=
 =?utf-8?B?NU9iN0NxcmhSd3hqWExXd1NOSXdXZFpSYlc3OFdSanlaaVl1blhlOE5idnVO?=
 =?utf-8?B?cGZQWG1tMWpFZnhGbnQvMGg1TXZEUkNINkNuYm9EUEhFcWZKSWdDWkdZVXV4?=
 =?utf-8?B?U0M3MTVGS0VZSDZ4SmFRRVFDbjdtWWl6UFV0bXJLZWV0QUVVaE5NOTRSVUho?=
 =?utf-8?B?MnU2aWVYSTFGaitTQmIzd0U4cUxaL2prQndOZnorT3daN2tzOGxjeDJreENS?=
 =?utf-8?B?TUpORXVSL1RncHVOc1NMQU1nME5aUWIyQWVXaitHSzNhcVEyaldEMDlEWjN3?=
 =?utf-8?B?VUJhWnNNdzduOFRDZ21sUWQ4RC9MTXZSWUdaZENkcmZONlN0azUzVEM5WllT?=
 =?utf-8?B?ekRTZ09heE9QeTN6YnFZVVVJTEorZEdvUVovSHExcUphL1ZtVFl5cXBwSzNK?=
 =?utf-8?B?MWlTK0lOTlIwMUF3Z2RnalFHdXpzUGJ4cG91TkhSdW0yclFDQTE0L2RsWWx3?=
 =?utf-8?B?dmF6NnNBMjc5d040SVJXNnp6cFdsVW5yWmRiUlhCM0xNZStXYkw5TEN3d0Q3?=
 =?utf-8?B?Smd5VjRhOUhPMEEzWE5OZ1dnMFpEQnFMZmtlTkNmZEpBNy9Oeit5SDJOUzZX?=
 =?utf-8?B?a3ZZb2FyVWR0cUhyanlJejZkdElYZWhyNnczVTF6MTVyQW9kRnJEUC9IYStM?=
 =?utf-8?B?bGh3VGFYS1BPbFk4bW84TkZidExqdWRrNkNDakdSSTQ3eGtWVkVsUTFFdXU5?=
 =?utf-8?B?NkpxaWp6M05WOXcxZ3MyUUZkNElnb2pIbjJKYUlUa3l2ZmloMjd5bWdyeVRp?=
 =?utf-8?B?bjBvNEZFc1dEU3JoZzB5dkRMcDYzN1VBeHkxd01sRE9QMy9MNTR2SmxnU3k5?=
 =?utf-8?B?cmlFUk9FL1Jja2lIc05aWGd6bDZLcCtha2hrcWZLRHNycVE3eFcxaXlPbjNj?=
 =?utf-8?Q?qcWjUMpm9iHKDcchE3lKI4maT2GuYw3LNnTQw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3o4L09NSXFhR3pSK3hpYTNIUzVNbmJXZ2VFejE5Ymx2T3BVTUxieStQYkI0?=
 =?utf-8?B?LzdnelU4ZGNpdGlGL2lqVkQ5dmlvNHluWjV6aldVVGRSNFB6UGxhYWY1aW44?=
 =?utf-8?B?NVAzb0Q1djlrNXNuQU91aXhQeStQbzV0aE5jdDc5bHFvS25NNlllTlp6TEwv?=
 =?utf-8?B?cmR5azdqMG5YRWNEUFdoOG9FUXNBTXdMVTZlSEhCaThwdmRrM3B3Q0RpNVFK?=
 =?utf-8?B?Z2tEaWpZalN2akc2T1NqRHk2djJnMUhoYmhmRUg5dnRxa0cyME1idTF5dlJw?=
 =?utf-8?B?SGx0TDUyL0FpSnZGSVN0RGl0M1N3a29mVkVKbWx5eTMwelNLUjRhanhySXlt?=
 =?utf-8?B?OHZVQzc0b3RQUk1iSHhHdUFvaXJMR0IvRU1vSGNpdC9yQVVxdW1MV3VwMzNs?=
 =?utf-8?B?TG9IbTVPcFoxbTJiWXN0eTc5Q1J1R1pnZlFCTTE4YmhMQzZHdkNJQk9sL2I5?=
 =?utf-8?B?dWEvWFBuY05DaExNNnpkMGFOa1RvWE1INjhlcGRha2l4M1plT3ZGODZweVBs?=
 =?utf-8?B?Z05MdFVnZ2NWdDB0cG0zYjNNOC9sU3M2VGVlUERSYXhJQ3BLalh3dUFTZUpT?=
 =?utf-8?B?UTg4UGhvVUFqbjZsTWlkeEovMmoycmJmMEowOXRORENKUVRvUXc4d3h2NHpm?=
 =?utf-8?B?ZGsvdWhKTzFyWStmSkg4NnJ1TjBCYm1xbmgxYjRlQktOSHdvRUJEdkpIcnA1?=
 =?utf-8?B?TlBVY3ViYkFIYklRQTdCNjI1ZmhvVkhuZkEyeGN4Q3h4WFhkenBGemZPRUd4?=
 =?utf-8?B?N2plQU9DQ2QxTUpvZnBaZnZ5ZXZDRHZlRWtzeTVDQW9WVm5YK2poaGQrMi9u?=
 =?utf-8?B?OGtETVJxQmFFTHk0cFF3cnVnRTJGM1VPT1VzZ0c5SDBHVk9BRWkzdWx5dkxw?=
 =?utf-8?B?YkdZUW5VSXgwQlhtZUNobjBRSE5MTk5TQWtjaEFteXN5N0RyVmlaN1N3L1Js?=
 =?utf-8?B?ZGJUdkJ6RVhwZmNVQ1FXY0VwTDB1SUsydmxld3VlRkVEU3JVSTNic3Nmakp6?=
 =?utf-8?B?endZaEs1ZUxRYVBUem43OGlXYm1yOUVWR1NOQ3Y2dTF1MVdKMXZ4Qm5Bc1F3?=
 =?utf-8?B?eVJpVmZmYWVML0FJT2lTTGYwZnR1cVRJamxtZUdFUjBadmhaQlEzQ1pwekpt?=
 =?utf-8?B?cCt2RFVxUzZLZU5lS200T3huQTZpaG9KYnpiakxJL3BheFdwQjZGa3lBWTJj?=
 =?utf-8?B?ZnRWVFpGZzk1SlMwcHNkdEo0VTdGd3g4Nm10MTVURGIrdkMxY1B1a3lHc3p1?=
 =?utf-8?B?d3UwaHFLdnh1dk96VTMwWTRzZ1dudWFPeXhlWUFtL1JVK2ZXckdxdERRZkRw?=
 =?utf-8?B?RXVvc0h0cjUxamY5d09vRS9WNG4vcHhqMDRJREVLR1RGaTl6VFJwejVKSDF6?=
 =?utf-8?B?aHFGZk4wQTliQVdIaFlSODE4SW9IK2pVSHNadFh2Qm5tZEJyZTd6dGYyc2Z1?=
 =?utf-8?B?NjNrMExrNm90SG15RXdPeUNpR3NKL0FlOE5lS0FLbEJXLzAwWklkd1MvL1p1?=
 =?utf-8?B?c0lBUDgyV0tERXJKTTFUbHc5YkxxcTAzQVZNdjlxcGtieWZyUlo0bG1RY3Q0?=
 =?utf-8?B?ZWpYRVM1VVhkbFpEVzR1Qm52aDdCT3pBR1M5M3lWU0YwVjZteTltcFZpRGJh?=
 =?utf-8?B?eUI3R0Y4M0NFakVNc05TRjIwdDBKTVphcTVZRS9sMzM3NjlsU2pTVUlBdHM1?=
 =?utf-8?B?NUNqNEFta3lpdXo2ei94UmlhNXc2MnFMR3BaNHNJZHBDMC9zWXc2WEtOTEo5?=
 =?utf-8?B?RlA1MU5wb1pvZDY3NzVmamdlRmlTUHRIMmlYdHd2b2F3ejVmYmJFMWNyMG9q?=
 =?utf-8?B?eXA1THUvMHBBMWxtNWVCVXdVRnBpY25qUk5PeTNVZ1ZWVGtqczV3U0djK01W?=
 =?utf-8?B?MktJemV3ZG1Wb0IwQ0lkdDFWTlgxcTc0YTBwVVVyeWMyZ0xmTUUwWi9saVdt?=
 =?utf-8?B?bVBmb2IyZFFBK0lUYzRETERtTkZtenNDeXh4dE8wRTBLRE5ENVU1Zm9Zdy9K?=
 =?utf-8?B?a2xPdEhaVHY1bklNbXM0YThrWnNXSW8vSWZVTytYdUgyNWZ2eTdUNzhaQkpQ?=
 =?utf-8?B?MUFIb1hUcTFXODJMcEl6d00rV05CQitaY0gybjFsaXhpcUsyb2lnaVMvbnRY?=
 =?utf-8?Q?HoHcFceX9sRXA8tSVO73XCuw7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae75ee2d-93be-499d-4c6b-08dd81b7d676
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 16:07:53.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9drdG0fgLMs1MuiBS3FTq97yAeDJlEJfI3wtUQEDUvoKjvFX5c/YVufKIbX9P0oHfy/UFuJrbyV2cqa//7/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 4/17/25 15:50, Mario Limonciello wrote:
> From: Chris Bainbridge <chris.bainbridge@gmail.com>
> 
> The HDCP code in amdgpu_dm_hdcp.c copies pointers to amdgpu_dm_connector
> objects without incrementing the kref reference counts. When using a
> USB-C dock, and the dock is unplugged, the corresponding
> amdgpu_dm_connector objects are freed, creating dangling pointers in the
> HDCP code. When the dock is plugged back, the dangling pointers are
> dereferenced, resulting in a slab-use-after-free:
> 
> [   66.775837] BUG: KASAN: slab-use-after-free in event_property_validate+0x42f/0x6c0 [amdgpu]
> [   66.776171] Read of size 4 at addr ffff888127804120 by task kworker/0:1/10
> 
> [   66.776179] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.14.0-rc7-00180-g54505f727a38-dirty #233
> [   66.776183] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BIOS F.17 12/18/2024
> [   66.776186] Workqueue: events event_property_validate [amdgpu]
> [   66.776494] Call Trace:
> [   66.776496]  <TASK>
> [   66.776497]  dump_stack_lvl+0x70/0xa0
> [   66.776504]  print_report+0x175/0x555
> [   66.776507]  ? __virt_addr_valid+0x243/0x450
> [   66.776510]  ? kasan_complete_mode_report_info+0x66/0x1c0
> [   66.776515]  kasan_report+0xeb/0x1c0
> [   66.776518]  ? event_property_validate+0x42f/0x6c0 [amdgpu]
> [   66.776819]  ? event_property_validate+0x42f/0x6c0 [amdgpu]
> [   66.777121]  __asan_report_load4_noabort+0x14/0x20
> [   66.777124]  event_property_validate+0x42f/0x6c0 [amdgpu]
> [   66.777342]  ? __lock_acquire+0x6b40/0x6b40
> [   66.777347]  ? enable_assr+0x250/0x250 [amdgpu]
> [   66.777571]  process_one_work+0x86b/0x1510
> [   66.777575]  ? pwq_dec_nr_in_flight+0xcf0/0xcf0
> [   66.777578]  ? assign_work+0x16b/0x280
> [   66.777580]  ? lock_is_held_type+0xa3/0x130
> [   66.777583]  worker_thread+0x5c0/0xfa0
> [   66.777587]  ? process_one_work+0x1510/0x1510
> [   66.777588]  kthread+0x3a2/0x840
> [   66.777591]  ? kthread_is_per_cpu+0xd0/0xd0
> [   66.777594]  ? trace_hardirqs_on+0x4f/0x60
> [   66.777597]  ? _raw_spin_unlock_irq+0x27/0x60
> [   66.777599]  ? calculate_sigpending+0x77/0xa0
> [   66.777602]  ? kthread_is_per_cpu+0xd0/0xd0
> [   66.777605]  ret_from_fork+0x40/0x90
> [   66.777607]  ? kthread_is_per_cpu+0xd0/0xd0
> [   66.777609]  ret_from_fork_asm+0x11/0x20
> [   66.777614]  </TASK>
> 
> [   66.777643] Allocated by task 10:
> [   66.777646]  kasan_save_stack+0x39/0x60
> [   66.777649]  kasan_save_track+0x14/0x40
> [   66.777652]  kasan_save_alloc_info+0x37/0x50
> [   66.777655]  __kasan_kmalloc+0xbb/0xc0
> [   66.777658]  __kmalloc_cache_noprof+0x1c8/0x4b0
> [   66.777661]  dm_dp_add_mst_connector+0xdd/0x5c0 [amdgpu]
> [   66.777880]  drm_dp_mst_port_add_connector+0x47e/0x770 [drm_display_helper]
> [   66.777892]  drm_dp_send_link_address+0x1554/0x2bf0 [drm_display_helper]
> [   66.777901]  drm_dp_check_and_send_link_address+0x187/0x1f0 [drm_display_helper]
> [   66.777909]  drm_dp_mst_link_probe_work+0x2b8/0x410 [drm_display_helper]
> [   66.777917]  process_one_work+0x86b/0x1510
> [   66.777919]  worker_thread+0x5c0/0xfa0
> [   66.777922]  kthread+0x3a2/0x840
> [   66.777925]  ret_from_fork+0x40/0x90
> [   66.777927]  ret_from_fork_asm+0x11/0x20
> 
> [   66.777932] Freed by task 1713:
> [   66.777935]  kasan_save_stack+0x39/0x60
> [   66.777938]  kasan_save_track+0x14/0x40
> [   66.777940]  kasan_save_free_info+0x3b/0x60
> [   66.777944]  __kasan_slab_free+0x52/0x70
> [   66.777946]  kfree+0x13f/0x4b0
> [   66.777949]  dm_dp_mst_connector_destroy+0xfa/0x150 [amdgpu]
> [   66.778179]  drm_connector_free+0x7d/0xb0
> [   66.778184]  drm_mode_object_put.part.0+0xee/0x160
> [   66.778188]  drm_mode_object_put+0x37/0x50
> [   66.778191]  drm_atomic_state_default_clear+0x220/0xd60
> [   66.778194]  __drm_atomic_state_free+0x16e/0x2a0
> [   66.778197]  drm_mode_atomic_ioctl+0x15ed/0x2ba0
> [   66.778200]  drm_ioctl_kernel+0x17a/0x310
> [   66.778203]  drm_ioctl+0x584/0xd10
> [   66.778206]  amdgpu_drm_ioctl+0xd2/0x1c0 [amdgpu]
> [   66.778375]  __x64_sys_ioctl+0x139/0x1a0
> [   66.778378]  x64_sys_call+0xee7/0xfb0
> [   66.778381]  do_syscall_64+0x87/0x140
> [   66.778385]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fix this by properly incrementing and decrementing the reference counts
> when making and deleting copies of the amdgpu_dm_connector pointers.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4006
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Cc: <Stable@vger.kernel.org>
> Fixes: da3fd7ac0bcf3 ("drm/amd/display: Update CP property based on HW query")
> (Mario: rebase on current code and update fixes tag)
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index 2bd8dee1b7c2..26922d870b89 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -202,6 +202,9 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
>   	unsigned int conn_index = aconnector->base.index;
>   
>   	guard(mutex)(&hdcp_w->mutex);
> +	drm_connector_get(&aconnector->base);
> +	if (hdcp_w->aconnector[conn_index])
> +		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
>   	hdcp_w->aconnector[conn_index] = aconnector;
>   
>   	memset(&link_adjust, 0, sizeof(link_adjust));
> @@ -249,7 +252,6 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
>   	unsigned int conn_index = aconnector->base.index;
>   
>   	guard(mutex)(&hdcp_w->mutex);
> -	hdcp_w->aconnector[conn_index] = aconnector;
>   
>   	/* the removal of display will invoke auth reset -> hdcp destroy and
>   	 * we'd expect the Content Protection (CP) property changed back to
> @@ -265,7 +267,10 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
>   	}
>   
>   	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
> -
> +	if (hdcp_w->aconnector[conn_index]) {
> +		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
> +		hdcp_w->aconnector[conn_index] = NULL;
> +	}
>   	process_output(hdcp_w);
>   }
>   
> @@ -283,6 +288,10 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
>   	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
>   		hdcp_w->encryption_status[conn_index] =
>   			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
> +		if (hdcp_w->aconnector[conn_index]) {
> +			drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
> +			hdcp_w->aconnector[conn_index] = NULL;
> +		}
>   	}
>   
>   	process_output(hdcp_w);
> @@ -517,6 +526,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>   	struct hdcp_workqueue *hdcp_work = handle;
>   	struct amdgpu_dm_connector *aconnector = config->dm_stream_ctx;
>   	int link_index = aconnector->dc_link->link_index;
> +	unsigned int conn_index = aconnector->base.index;
>   	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
>   	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
>   	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
> @@ -573,7 +583,10 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>   	guard(mutex)(&hdcp_w->mutex);
>   
>   	mod_hdcp_add_display(&hdcp_w->hdcp, link, display, &hdcp_w->output);
> -
> +	drm_connector_get(&aconnector->base);
> +	if (hdcp_w->aconnector[conn_index])
> +		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
> +	hdcp_w->aconnector[conn_index] = aconnector;
>   	process_output(hdcp_w);
>   }
>   


