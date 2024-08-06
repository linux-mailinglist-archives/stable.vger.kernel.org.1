Return-Path: <stable+bounces-65473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6393948BDC
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 11:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E07D28750B
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458911C3F02;
	Tue,  6 Aug 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="JV6623P4"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D311C3796;
	Tue,  6 Aug 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934884; cv=fail; b=rvurLogB6YU5ggZNoIZzJehQCg9Qil1AEpUwKCFG/5FDtWb7aeV/Ld38cFkluO4IgWEv/Q5ROyJxalZE/QKO7seuFNtB4AYbKdtolwo5A3zBJEd7TpX0B763ZFMe5ICTvBIq/eH6PvrBUzhDA5LIe9qFBqKtob6M+PMZvxMb9BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934884; c=relaxed/simple;
	bh=L+qq36JmYB3LiSW+2CLgTLHinTKeC/yMUhGCP0Il6Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P2yGV2Mlt+JojD8vUjIR53sycVIzM5BQzlWw44HWCsfb+CYmhK8hr+hwPqzVVyvcGRwvhM313akYgiFKLavoenUOy/yPJKQs9j552qbRRR+dOc/VL8YvIgzIset6rihq0awJplhDYv42VRRQwPLls/fS//6JP/S4RYQ49DgSrLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=JV6623P4; arc=fail smtp.client-ip=40.107.104.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6FUGQGiIiz1qjdGDSs5YAgpynO80GiL2WoZ7fEt7gl5k6YOpwEInM51fVIQ32mB+tGu1U22r7aazPoCT8vzPuBYZ5MMS+GuOe5BHaHQA8ftd9a0D8KV51xpHnxeOtjKUNyLsOAhtELNlrMuqy/xZO0FCq//HLdJJlhnaJYdUIfcibcC91I6NZwor3lYn/rWq60EKVAwGWlI2D/eEiSCBBELOzqpRHLgg3h1P5sRsDR17uDcjJaRV42UV0EOrM13j702ahcKYafxxE6OA2eppV4I17RxqVbUDOctRUeBq4GBT/+GBV/aggOuQIj0Ecb8bbuMsYuTuJEkpeMb1hEoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLcZkPxmcZtLbktEy2ZlWMM00pLuVAuYlGgQwwJiKIs=;
 b=QnqybXcl3lYUCCTUq1DPGJiJO63XWlj+7EYPki28eNXdv8Q5D2PXzh+DK4xLKd53sq/Kwngtf10U4URt3Ru+AGvjpbXCGXofBpOMVO/dwQ0FyOf0hSH0zDhWhqSJMaZKuscws5ihDGAZBfZvImG7wQtDv8lZ60sOqOj0KqN87skB8WGkusuLFIoNAn0RPyw8Nv5j3Qqq6Akt57ILrPBVQd5sTKoJCvGLmbE4is47Om+tbr7t0gVjkOwWI839+yQO40W5JUqStsnS7MVd2JH0AOwIa98IN/qQ3nG7nzAp8B+nfNCxgaAvq8jdsi91PVwhdDgf0wZzHwkZvk3pji1BHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=intel.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLcZkPxmcZtLbktEy2ZlWMM00pLuVAuYlGgQwwJiKIs=;
 b=JV6623P4uyer/qyE1HPL5PsulHjBlTVsG/nc9/lvuLzeilj+ko897gPbGv07fIr2W8wPlHA+Z0C+DBI4YLldLpUB5CtXUaTMeQxgtaYtBPJ/20VoaLECF1CCs3dBm7LYCe5Y8fkME4Q/9KlliDR0pWIjFtIphLnch3tnJdrYeXammfvF9T50rXdONcFfIsMYd7lYw7EbP2LW5ccNztBOSvWdSvIdNNr8ApmoeByiH6GxDfPzswV2w14t8FCKj88mxDvWB5YgYXa8tCQgNuDSyWbJhpieio7iYMawOpzb3P4p4ffg28YsStF/s0QNu/bPisXkj+rOJkqFn24zZrdI8g==
Received: from DB7PR03CA0103.eurprd03.prod.outlook.com (2603:10a6:10:72::44)
 by VI0PR10MB9076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Tue, 6 Aug
 2024 09:01:16 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::22) by DB7PR03CA0103.outlook.office365.com
 (2603:10a6:10:72::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Tue, 6 Aug 2024 09:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 09:01:15 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 6 Aug
 2024 11:00:59 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2001.de.bosch.com
 (10.139.217.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 6 Aug
 2024 11:00:59 +0200
Message-ID: <3cfa6f82-1eee-4119-8314-f4b1d12bc228@de.bosch.com>
Date: Tue, 6 Aug 2024 11:00:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Fix uevent_show() vs driver detach race
To: Dan Williams <dan.j.williams@intel.com>, <gregkh@linuxfoundation.org>
CC: <syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com>, Tetsuo Handa
	<penguin-kernel@I-love.SAKURA.ne.jp>, <stable@vger.kernel.org>, "Ashish
 Sangwan" <a.sangwan@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
References: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|VI0PR10MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: 05779984-1004-4a85-d0b3-08dcb5f653e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFA2OGU4aHdnNVVRanJHNWIvbjh1eFl2d0pqcDBoSEgzc1dJOWhiN1duSGhG?=
 =?utf-8?B?RVpCYjBmWW1uT0RuRGxqRTl2WkJHQTk1dnNLbWY0RHBNa1ZjRHZucWkrRlpi?=
 =?utf-8?B?M3I3TDlXeVJGRXBMUmlRTDVtc0lPdDJrZEpucktkRENxc3ZiZmIraWUrQXRh?=
 =?utf-8?B?enc4cWMwQnlJZWdhRXBZeWtrRmlYSFRNODkwR3JpM2QzN2NxZnRHdUdLd1FY?=
 =?utf-8?B?dzhZbHpnaXNDM3huaWxra05rc1plSlFDayttWWIxcno5a2pCYS9HUzlTbTN2?=
 =?utf-8?B?Z2VIM3pocHhiTEhnVU9kamJjUUppZVpCY25iZ0ZjckdreFlXQnRVdzhka0Fm?=
 =?utf-8?B?OEg4eFRrRDFibWw4UDM3elp2OXVFbGpYYVpKTHovYUxzRzlyL0krZzBMMDIw?=
 =?utf-8?B?SHBNRzlvMnJYVERqSWwzekg0R3dVdWYyaDhEY1F6UndBWGZ0aXNadFEzV0dl?=
 =?utf-8?B?NTB1OW5NRytaQWEzL2Z4T1FLa2VqdWIwMUxBL0pwaEJhQ1lVWGROb1ovZ2ZG?=
 =?utf-8?B?c1dHQWNuNVFmRkVRcHZZZUpzMzVibk9hdlRraEhPWHBBTEVtcW1XNkV6OFR5?=
 =?utf-8?B?bVVGQUJjSXFURS9KdmFvcUpsMnJQa2N3MWlLUGR1ajJwdEJrcG5WRlFRYzZE?=
 =?utf-8?B?eGVxNXVZb2dCZTR3Y2ZERFNIc2txeGdlRy9RS0lzam9EQkJBMGVwOUdHNk1n?=
 =?utf-8?B?b201NmFhQ2FDVE5OOU1wR3Ztckw2S1J6MWpLNDlZalZZVG9UdVo3ZGZ5TjZJ?=
 =?utf-8?B?aDZhOGwzT29ENCtHU3dJeTR1eFNlM2hEOWVRM3NjSjd1ZHBUR0QzRncwdTRX?=
 =?utf-8?B?RGZySFBOTjMvS3JQSm1qZ0YvZnliV096WERMYnloVHcyNDNNdnQwemtMMmRM?=
 =?utf-8?B?NUZQODFHM0dHRmVxMDZYTVA0YS9ISU1YeUJZMlVCUFZPU1hYUnBWR2JjU3Fm?=
 =?utf-8?B?QWdzK0gzdUlYUkRKZi9GSlRFZzUxV0xXejUxTGNHTzJYbGRQQm5UQlFqUUlP?=
 =?utf-8?B?cXBwV1Zid0QwYXFnd09ETTMvWk1sd2E3WkxPRm5XVmFEdWoyVWVLSzFqb3JY?=
 =?utf-8?B?R215Q0xhck1KR21WRGZlM0t0dU52dW5LRG03aU81L0N2L2ZRSmJ4aWNaQWRo?=
 =?utf-8?B?SStoVXVKTmNHbFVmSzk3M0c5RndUVElMMVZveE5kU011R1lnNDRFUFJ0c1ky?=
 =?utf-8?B?Vm82UndZSmY5Mlp0VEphR3F5VmNVRi85eldtbU1ia3N5NitiSzJRSU1WT25s?=
 =?utf-8?B?Vm93MUtIMUdXZUtYT2lmR3lUNCtXQ3dQQVVYbzFnVlhMR2dYVjFpUjREVHFy?=
 =?utf-8?B?RGczMjJQWnM2dWFqcC9jSGNPdWJiOUphOE9GNEJNelB5Qzd6bE9MMGRWOWZZ?=
 =?utf-8?B?dmpLK2lXb1ZtSlFKclpRcDZ1RWRHYXk5WnNhdmpZay9vc294cUc4VlNHYjJW?=
 =?utf-8?B?MHM3Sk5NMS9RUnBpU2Z3UGVKRFlQRlZwLzBJZUpoUE1OREFWRTFRWjcrYkFm?=
 =?utf-8?B?WVNXMmYrQVRRSlR1MmI4cEVGY1pJekJrZ05DSFBEZlBsVjdiUDg0VTBDbFAv?=
 =?utf-8?B?b3BzcEJObTc3a1piS1ZwSDlva1A5NHlsZWZ3V21LS21idXUycDRRMGNkRy9S?=
 =?utf-8?B?dUNDaTJ4Y2xPVkpRSERwMmdtek5wYnZLcW44MTV2aDFSOWY1ODFvakhwVHAr?=
 =?utf-8?B?VVdLQmdtKzBIMnVNOTBoSFJUNkF5MDVzUWJQRSt6QlVpMVU1Z1JRWFZLU0Ri?=
 =?utf-8?B?a2srb0JaeG9jTTBLbVkxNFBmMkI4QWJFV212RFVseG40TW5MazVLSno5eldS?=
 =?utf-8?B?NlZJcUhpRUdaUzd4bUpNWkZMa0NRcUpRTG1ta09nNmV1cFB2R2ZPamdjZEhm?=
 =?utf-8?B?RDZuaFQwVVlKazhDNWtEWWF2THRKTUk3TWRuTFJSZTlBd2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 09:01:15.3048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05779984-1004-4a85-d0b3-08dcb5f653e6
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9076

On 12.07.2024 21:42, Dan Williams wrote:
> uevent_show() wants to de-reference dev->driver->name. There is no clean
> way for a device attribute to de-reference dev->driver unless that
> attribute is defined via (struct device_driver).dev_groups. Instead, the
> anti-pattern of taking the device_lock() in the attribute handler risks
> deadlocks with code paths that remove device attributes while holding
> the lock.
> 
> This deadlock is typically invisible to lockdep given the device_lock()
> is marked lockdep_set_novalidate_class(), but some subsystems allocate a
> local lockdep key for @dev->mutex to reveal reports of the form:
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   6.10.0-rc7+ #275 Tainted: G           OE    N
>   ------------------------------------------------------
>   modprobe/2374 is trying to acquire lock:
>   ffff8c2270070de0 (kn->active#6){++++}-{0:0}, at: __kernfs_remove+0xde/0x220
> 
>   but task is already holding lock:
>   ffff8c22016e88f8 (&cxl_root_key){+.+.}-{3:3}, at: device_release_driver_internal+0x39/0x210
> 
>   which lock already depends on the new lock.
> 
> 
>   the existing dependency chain (in reverse order) is:
> 
>   -> #1 (&cxl_root_key){+.+.}-{3:3}:
>          __mutex_lock+0x99/0xc30
>          uevent_show+0xac/0x130
>          dev_attr_show+0x18/0x40
>          sysfs_kf_seq_show+0xac/0xf0
>          seq_read_iter+0x110/0x450
>          vfs_read+0x25b/0x340
>          ksys_read+0x67/0xf0
>          do_syscall_64+0x75/0x190
>          entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>   -> #0 (kn->active#6){++++}-{0:0}:
>          __lock_acquire+0x121a/0x1fa0
>          lock_acquire+0xd6/0x2e0
>          kernfs_drain+0x1e9/0x200
>          __kernfs_remove+0xde/0x220
>          kernfs_remove_by_name_ns+0x5e/0xa0
>          device_del+0x168/0x410
>          device_unregister+0x13/0x60
>          devres_release_all+0xb8/0x110
>          device_unbind_cleanup+0xe/0x70
>          device_release_driver_internal+0x1c7/0x210
>          driver_detach+0x47/0x90
>          bus_remove_driver+0x6c/0xf0
>          cxl_acpi_exit+0xc/0x11 [cxl_acpi]
>          __do_sys_delete_module.isra.0+0x181/0x260
>          do_syscall_64+0x75/0x190
>          entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The observation though is that driver objects are typically much longer
> lived than device objects. It is reasonable to perform lockless
> de-reference of a @driver pointer even if it is racing detach from a
> device. Given the infrequency of driver unregistration, use
> synchronize_rcu() in module_remove_driver() to close any potential
> races.  It is potentially overkill to suffer synchronize_rcu() just to
> handle the rare module removal racing uevent_show() event.
> 
> Thanks to Tetsuo Handa for the debug analysis of the syzbot report [1].
> 
> Fixes: c0a40097f0bc ("drivers: core: synchronize really_probe() and dev_uevent()")
> Reported-by: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Closes: http://lore.kernel.org/5aa5558f-90a4-4864-b1b1-5d6784c5607d@I-love.SAKURA.ne.jp [1]
> Link: http://lore.kernel.org/669073b8ea479_5fffa294c1@dwillia2-xfh.jf.intel.com.notmuch
> Cc: stable@vger.kernel.org
> Cc: Ashish Sangwan <a.sangwan@samsung.com>
> Cc: Namjae Jeon <namjae.jeon@samsung.com>
> Cc: Dirk Behme <dirk.behme@de.bosch.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


Many thanks for this fix! Looks good to me:

Acked-by: Dirk Behme <dirk.behme@de.bosch.com>

Dirk


> ---
>   drivers/base/core.c   |   13 ++++++++-----
>   drivers/base/module.c |    4 ++++
>   2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2b4c0624b704..b5399262198a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -25,6 +25,7 @@
>   #include <linux/mutex.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/netdevice.h>
> +#include <linux/rcupdate.h>
>   #include <linux/sched/signal.h>
>   #include <linux/sched/mm.h>
>   #include <linux/string_helpers.h>
> @@ -2640,6 +2641,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
>   static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>   {
>   	const struct device *dev = kobj_to_dev(kobj);
> +	struct device_driver *driver;
>   	int retval = 0;
>   
>   	/* add device node properties if present */
> @@ -2668,8 +2670,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>   	if (dev->type && dev->type->name)
>   		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
>   
> -	if (dev->driver)
> -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> +	/* Synchronize with module_remove_driver() */
> +	rcu_read_lock();
> +	driver = READ_ONCE(dev->driver);
> +	if (driver)
> +		add_uevent_var(env, "DRIVER=%s", driver->name);
> +	rcu_read_unlock();
>   
>   	/* Add common DT information about the device */
>   	of_device_uevent(dev, env);
> @@ -2739,11 +2745,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
>   	if (!env)
>   		return -ENOMEM;
>   
> -	/* Synchronize with really_probe() */
> -	device_lock(dev);
>   	/* let the kset specific function add its keys */
>   	retval = kset->uevent_ops->uevent(&dev->kobj, env);
> -	device_unlock(dev);
>   	if (retval)
>   		goto out;
>   
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index a1b55da07127..b0b79b9c189d 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -7,6 +7,7 @@
>   #include <linux/errno.h>
>   #include <linux/slab.h>
>   #include <linux/string.h>
> +#include <linux/rcupdate.h>
>   #include "base.h"
>   
>   static char *make_driver_name(struct device_driver *drv)
> @@ -97,6 +98,9 @@ void module_remove_driver(struct device_driver *drv)
>   	if (!drv)
>   		return;
>   
> +	/* Synchronize with dev_uevent() */
> +	synchronize_rcu();
> +
>   	sysfs_remove_link(&drv->p->kobj, "module");
>   
>   	if (drv->owner)
> 
> 

-- 
======================================================================
Dirk Behme                      Robert Bosch Car Multimedia GmbH
                                 CM/ESO2
Phone: +49 5121 49-3274         Dirk Behme
Fax:   +49 711 811 5053274      PO Box 77 77 77
mailto:dirk.behme@de.bosch.com  D-31132 Hildesheim - Germany

Bosch Group, Car Multimedia (CM)
              Engineering SW Operating Systems 2 (ESO2)

Robert Bosch Car Multimedia GmbH - Ein Unternehmen der Bosch Gruppe
Sitz: Hildesheim
Registergericht: Amtsgericht Hildesheim HRB 201334
Aufsichtsratsvorsitzender: Dr. Dirk Hoheisel
Geschäftsführung: Dr. Steffen Berns;
                   Dr. Sven Ost, Jörg Pollak, Dr. Walter Schirm
======================================================================


