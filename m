Return-Path: <stable+bounces-87718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B274A9AA287
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4741C220E4
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC4C19D8BE;
	Tue, 22 Oct 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="htoLfM1Z"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F07199EBB;
	Tue, 22 Oct 2024 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601725; cv=fail; b=mx1whgE0abpjw3C0NB7m4tlooBF5nyhKUlSSLX6Wc/jTQGxrwWBfU7xiAIX4NkTBBfksO5s+Uef/fUCaLNkSm42Ni/tZAWfgpJ4hONUkBMyxBw9fsdJNQLblgfK4uhc5VvXXqizsFb2XmOiVdafnjH0VdoZfztvLzzSGipXoZCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601725; c=relaxed/simple;
	bh=GPIp/PG2D7cxLYWwFKbtLsEAxJ9nEcL651B6loot/34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XP8zpQDhd/hMyXv7JU/g+FO/Ef4HemrsTPKbDePK44th7TYvtuQVJW2mLFQnfgeh42umDLiET8Kw3OjoEK+duO9XnNYVAT35uE7Nn9vZtszl8ml6NhQHcB2nUjtDhBXvRqvrOefdUHx1LhIG88czX2EBSwPjmmLSb0sYwMPATVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=htoLfM1Z; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv80vqEmQnTSS5w5xZ+cCI2Ug5zNP8ZL3mKAThKuG14dqzCLtDIrwSO+KvN1dBfp05FHq0CS6F4bU75IsV64fd15uZy6SQV6Ssa7AHRBGHxDsgZZnezIQ+SL7XXbo6De8wdqFI2fQXOqfragMQGWcQWCn0kN3/bs/ykMK431Fg7e02h7o8EmOujWIDRq3fxd7oYeiAOm2L8p2G3Tls/dbOgryJ9O8HqIWXyeuVZ1LA8y3jKMdprjR72ANAKmipOAEcfLuhyEJpkzejKx/M6SldmMYDfUfdKEYpHxIA/plhGd4NhXhd5jdVNxOSUxk5rLDpuAbf5Rl7NRYCXehH5RNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inMeb3WYKJg9yo7vvV2kFoYcHUUViXY05RgIziaJQgU=;
 b=auBpXSSFp6O3sONwogU1qx6MuCfeT9N8Y/JZ+w5yh8+Tj1i2cke7bcC9s6m/TwTalC9L3MtM7QmMjEnFV7Ua9ler/YlF2QPvPyBn1i5jKoXHehHRm0hS2wa5aUJlDhd2GQ8Bbh8gs4smGmSvf0N0hpF5iw5K2RWen1Eq7Mm1p9+jpo+UrfqJ0hwIqcFuIYwtKjmtTyYvzW+9Jfg9uJWLS4W0s0NUK54Z468myDcEv8jtLidowrr8vZkPFYBIYwxA2xl7BdDwN+YuNKnDpyDML6hGG72B2b2dS7wxFggLYTp1P8K3mpIUYIckfs4gYXMxfHng/4Bst8WLL3SAkN3/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inMeb3WYKJg9yo7vvV2kFoYcHUUViXY05RgIziaJQgU=;
 b=htoLfM1ZDZPveaYqM07BNv3frocWBHdIuY9tX7Tbrb7LM18ddTdSwKxKJ3R1d78Ki3vFw/T86coUyx3eYRN6HwNkamYTX7CUslVj8LL41TClXENhSowYQN2VRfzMwrQoCB2KWTz6Ck9FrtGJqwVbHj5/l5hpbEws30wAyQEM9xM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 12:55:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 12:55:21 +0000
Message-ID: <96560f8e-ab9f-4036-9b4d-6ff327de5382@amd.com>
Date: Tue, 22 Oct 2024 07:55:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: rick@581238.xyz, mika.westerberg@linux.intel.com
Cc: Sanath.S@amd.com, christian@heusel.eu, fabian@fstab.de,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <000f01db247b$d10e1520$732a3f60$@581238.xyz>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <000f01db247b$d10e1520$732a3f60$@581238.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:806:121::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7c6f00-0330-4d1c-5003-08dcf298c991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1RDWkZJN1ltNlFDc0dwMmplNEo2OVVZdVI1NGJ4SCtRWWM0emNMdThhbVY1?=
 =?utf-8?B?cGgwMm5IMzI3NHpvd0J6cTljVkJDSjVHRmZOaFNZZCtvZHRHSWR6c2F5bHlx?=
 =?utf-8?B?b0dIcEdyMHdzT05HZ3RiNm54cUh4dlR3bTlsa1dEcXBNLzdkYUd4bmFRWHVI?=
 =?utf-8?B?SFJ0Tkw4Y1M1ZkxNWWhkbXd4V29MZE1vSTJTOHZ1YWRwYjVra1VmSjZRa0VF?=
 =?utf-8?B?a1htYTBqbVUrQ2I1OGJmOFp0K0UwVnRiOXQ3cm8yOWV0c2V4T2szRVY1RXV6?=
 =?utf-8?B?S3RKS3VwMHVnMXBqcVZJeUtOS0YzTHorRVlZZkhOQXl6VUFIM0dhZDJRKzV4?=
 =?utf-8?B?WUhoUThkNmQ3cTluWHNITTJ3WkNFMG0ybnF1dllTRnRMSkp1Q0F3QVNUWW9v?=
 =?utf-8?B?YXYzQ3lzL3cyQTdOYldnNHdDcVJBZlZSekdLL2F4M3hLSlB4QXYwUG5IVEda?=
 =?utf-8?B?QXlrcWlYK1NWYkMrdmorUUZmZEZQTThXdTd6OWlPVzJBSG5tV1V2RWJIYkU1?=
 =?utf-8?B?V0NhdVpXaGFjdjFVRDYraHVHVWFlK1dTVnVjUFRDZ25ldHpnOTBQUDJLcG8z?=
 =?utf-8?B?dFd5ZjRmNVJBdXRITGgvN283Uk5FaFNVb3hOOXBpbmV5bE5OYytGL1dxTlNR?=
 =?utf-8?B?WHdDYXNRYVFxcXJLNmluRGROeXpsSHUvNnNhUXphNHJzYTFzcmcxaUZoeWZ3?=
 =?utf-8?B?dk5pZitnVzl6aDFQSHQ0emVqUXQ4YnhtNWp3aXZLZHNxOTFrZ0FSanlDWlBi?=
 =?utf-8?B?T3laRW02aU1ERXYwaFRCNXFZclMwbTB6TmZvUVZYdm9IOU9GaWZ6eUlkb3ZM?=
 =?utf-8?B?cTFYejBUZERKQWdlbUZEVTdxNlRjRlpENndLZjQ3WmN6Z29DUEJPOTZBeFNn?=
 =?utf-8?B?dG1saDU4bkZSbklUd0RrQVNITDIzZnRQeGhuRUdoVGRZM1FoSzVyNk1GcVIy?=
 =?utf-8?B?L0pBM3FOS2UvQ2U3ckQ4L3BSd1FUWTlNY0ZDenRuUis0NXVnRDJhNnJWNkpN?=
 =?utf-8?B?eHJwazN6Z3prSFBMK2kxWE9BZ1l3ZytUcWZveFhkSFRGNUpCNlJsajVNb1Rk?=
 =?utf-8?B?SHBGU1lPU2Z1enhnUU9kb1pLNm1MZ1pXWFNObit0TWEzS252ckdmWnZOOEI1?=
 =?utf-8?B?c1BZS2MvdkNuK0htekM2RU5Cem1TSVdOaC9BNysrQlpFUThvWEV4RWU3elNT?=
 =?utf-8?B?NGRyaXlvSHBoZWlGYkNHbXBtSEo3LzlkTWUwa1JxRWZyYWhmTFB3Nkpkd003?=
 =?utf-8?B?WGJlUlMySU1ybWluWWlmNHpVbGNPK3M3aytFNGkxbStLT1EwSlM3TGlXMi9N?=
 =?utf-8?B?VUFrdVRBN2RhTzNsbENhdU5RenJjKzAxMlJPMXh4S0ZETUFVUmJOcCtxcS93?=
 =?utf-8?B?R2FweTlUNzl0QjRBYUdhY0tmd0xxU1hZaWh1QWh4a3ZkR1hINTFuSDZzZWwv?=
 =?utf-8?B?S0l2dlVmcDhaR0lFeWZ3dVBZTWJOajB4MlhFYWRnN3Z0OEw3MVYyRkRoZDRM?=
 =?utf-8?B?bkRzRzRGbDZ1M3VBVzNsODFNdlZ3RWJiMUNpaFo4bHhlMGpHTGdPZWRtOUNY?=
 =?utf-8?B?NDlyQS9ieWVTWjYyMlVFSXZ6aU5SK0JnWm1OeVk5ZGJSMTZ5MDhZTEVnT2Zp?=
 =?utf-8?B?Q2hHQmlHYmVQbGpyYk0zSVFzdFMwa3RpR1lUbFE4WEdFcjFycVZ5WHBIU2tS?=
 =?utf-8?B?ZVA1NDdtWktVUW5Kd1ZHVlRyWTZBV1l6bldPaU0yS2UyVEhUSWJOdTNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?My9rakN4TjIrSFN1QlROMU16aXZnUUk1ckJKbm9pRHZ6Q2k1QjdZbkdwNTg2?=
 =?utf-8?B?N1pidnFxZzhscDMwMTFWQnNMelJxSHd6OFBxWk9MWnBDd0ppOFp3eWM5cmVP?=
 =?utf-8?B?WlIybE5GVzdiWjF3c1FxRXN3dEp1TlRhb3FBSWdqVEZ6SnMrTXhSdWJiVVVj?=
 =?utf-8?B?dTFEOGxkQXBuVjY5MGI0OUc4bER2RlhrekZrWnFscnhtd2NoWTNHQ0VwZmg5?=
 =?utf-8?B?dlNUTHliOEtMRzdTc3p1ZmIza21oZVM2SzNVQXFoa2dRSXFrMkU4NEIzcEtW?=
 =?utf-8?B?bUVnR0pLNW5FdXhESnFNQ2p1dFliQ1NtcjRGNUwzeUJVR2ZLdDRFQWl5eElq?=
 =?utf-8?B?bGp6WTdZMW1rZ1VmQXRSNDFDT1JKMVgyZXExclFNN2dkSmdkOWJiZStES2pn?=
 =?utf-8?B?T1Y3OC9jc1pUVzVlb29xSWgvUkdjOE9naHd2ZjJHTGVhQ2wvM2R3WURpNkNu?=
 =?utf-8?B?Y1FJVHk4T21WN3BkTFkyTXNRUHFjMWZtOVpiV1VWc1JqcFRvTThLUHlTaEEr?=
 =?utf-8?B?WUhkZk5EbmpsTkZ5UTRBYXRhMnlPajJqemE3V1JmRTczYTdpRVZGOVhqV0dv?=
 =?utf-8?B?RXdyUktDbkxGcTNnOFRjQ3YxR3UyNDAvN3dqaFUrSERyV3BhK0p0WEhZdWlO?=
 =?utf-8?B?VFQ5dHIyS2JHV1hJSGw1U1ZXcmVzc0RwcnBaZmtBajJDeWxsRGFyNDloVVE3?=
 =?utf-8?B?VFlXSkxzMTNwSFc1bitsRUtweHZod2twNEdwRzNUVTNkZm9qM0hROWhEUmxs?=
 =?utf-8?B?UVFmeDFMMjk2dzN1OWRPWEJJWEVXTjNxWkV6RnlkcytlWWlZTnpZY0NGZmhL?=
 =?utf-8?B?VWRmcHJwVWNWcmlFMGQwSVFnVTNiWDBQRFlPaDZ3SEcvOVpWdHlyMlVTc2pl?=
 =?utf-8?B?NkVBVGxPNlRQa2FSMlZIdWkrNnBubllGWUhwWGJlRDJFN1hramNRcFJBcSty?=
 =?utf-8?B?bG9uTDFJQzdVK3lUZDRJN1hnNkNkUWk5bFRxQS92K0l0anVRbXlXL2szbE95?=
 =?utf-8?B?Vjh6SDRMMnN6QWEyWXEveENoM0NJbGZEMmN5UDlmTHlvSlpVa0FQOHJLczgv?=
 =?utf-8?B?eXFsVWdlZWU5N3hnSSs3MFhNanBOTVg0NktVRlRkbXNnTlNVWjFnM1loT0dP?=
 =?utf-8?B?ampqMUVRWkM4VlZSQ3RzRXNjaGN6QWc0eUFsZ1FUZnk4TGJINWtObU1BbEoy?=
 =?utf-8?B?Zmp0WnVKeW5WUlRFRmpiUGV1KzE1bXpWaDhpTkFXY3BJZ2RGSjVjcGN4akhW?=
 =?utf-8?B?VnppV05iYkdyQm9Dak5PK0ltejAyb2hpRStvdit5eGlLaU1hL2xzQnZQL3VM?=
 =?utf-8?B?ZkxSTkx2clkvR1YwYytFYkJhcGgrOEVIOHlXN0FwbTcreVZRWTVoZllvWU1P?=
 =?utf-8?B?RkxhSTFBSUp2MmwvVkltemxxa2FkMnFPNjExVkFON0pqMitLdGlzSDMwNHhQ?=
 =?utf-8?B?d3hiUExnVjBkQkozWTljK2R1Vkx2blkvS1VrcWg3MEkwUys3WkthSmZhZEJQ?=
 =?utf-8?B?NlIycCtjak1qaXRyNFo1UnpVUTM1N3piNExQTW1QZys5YVE0eHJEZzVUd1pi?=
 =?utf-8?B?VnErMDRwYzF3NTZKTUVmZ1Y0d2FlVm90dzdacFRMNExQY293UStOdHdpWVox?=
 =?utf-8?B?Mi83Z3IrZk9nMWMydVdmQ3ZXdkJxajlTamtaWlpqdVF4cmpGL1hnYWc0cURB?=
 =?utf-8?B?c3RweU8wUlVVZlhMMWl3emZYQ0kxMzRMdXU0dGs1RjZHMmRtMGpTNnRjQVFL?=
 =?utf-8?B?S0k1SkhlbE1OVGo1UWVNNFdmQ0tyT0VkNGoxUWY2Tno3NHR1ODA4UWxlY0NB?=
 =?utf-8?B?NjNVRDZ5UHZpT0QybnRzS3A1VzN0OEhTazVjOGVuQ044NUR2dHpZbWs4Zm5u?=
 =?utf-8?B?K0swK2hmN2NmVVRPalVjRVprVXVrdnRITXgxcVJUa3g1OWdKVFRpTFhQL0ZV?=
 =?utf-8?B?YjhNOGlscjN5WVc0dFQxeVFqNzVudFRoYmlkYTFnSXJGaVIzWVdsZ0J4TUVB?=
 =?utf-8?B?T2YwTXV4YUhrUUp4OWUzVmNRby91Y21Bb1pLSzRrbUp6R010cmU5TTBML1Er?=
 =?utf-8?B?cytnVjJqNjNjYlZYZldMSGNZVTBML2MvYTA5VjFwajJETUh0SkJmQk1PTjRN?=
 =?utf-8?Q?3OECDFN6xJssqWFtz6ttL0oU+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7c6f00-0330-4d1c-5003-08dcf298c991
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:55:21.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtrLUqAiiYAupyZky4RqnS2925Y+bBcDYCtt8gERoVvuO0YKYknOZI7apPcm1l0w2iD+fku8SJ7Fj7xgVuUneQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

On 10/22/2024 07:13, rick@581238.xyz wrote:
> Hi all,
> 
> I am having the exact same issue.
> 
> linux-lts-6.6.28-1 works, anything above doesn't.
> 
> When kernel above linux-lts-6.6.28-1:
> - Boltctl does not show anything
> - thunderbolt.host_reset=0 had no impact
> - triggers following errors:
>    [   50.627948] ucsi_acpi USBC000:00: unknown error 0
>    [   50.627957] ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-5)
> 
> Gists:
> - https://gist.github.com/ricklahaye/83695df8c8273c30d2403da97a353e15 dmesg
> with "Linux system 6.11.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 17 Oct 2024
> 20:53:41 +0000 x86_64 GNU/Linux" where thunderbolt dock does not work
> - https://gist.github.com/ricklahaye/79e4040abcd368524633e86addec1833 dmesg
> with "Linux system 6.6.28-1-lts #1 SMP PREEMPT_DYNAMIC Wed, 17 Apr 2024
> 10:11:09 +0000 x86_64 GNU/Linux" where thunderbolt does work
> - https://gist.github.com/ricklahaye/c9a7b4a7eeba5e7900194eecf9fce454
> boltctl with "Linux system 6.6.28-1-lts #1 SMP PREEMPT_DYNAMIC Wed, 17 Apr
> 2024 10:11:09 +0000 x86_64 GNU/Linux" where thunderbolt does work
> 
> 
> Kind regards,
> Rick
> 
> Ps: sorry for resend; this time with plain text format
> 
> 

Can you please share a log with 'thunderbolt.host_reset=0 
thunderbolt.dyndbg' on the kernel command line in a kernel that it 
doesn't work?  This should make the behavior match 6.6.28 and we can 
compare.

Maybe the best thing would be:
* 6.6.28 w/ thunderbolt.dyndbg
* 6.6.29 w/ thunderbolt.dyndbg thunderbolt.host_reset=0


