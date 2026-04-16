Return-Path: <stable+bounces-238340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JazAlIa4WmmpAAAu9opvQ
	(envelope-from <stable+bounces-238340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:20:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5244128C8
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A186E3016509
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8593264DF;
	Thu, 16 Apr 2026 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EBrMU9w8"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6C2264A9;
	Thu, 16 Apr 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360013; cv=fail; b=ooQ8KJGMCfriVoCpAXv/0vUIVBLpuxdR23X3SIka8SJJHjw3gdXNEwEMMsn7AGVobWIJDSs0rJlY05kqfx/rtMEXbi7Zl2HUJIk0HtVANUpHAgWsiLRJngSlHODp0zpDhkZ0sjMUdGfIqidAUhI2eqUbbW4bCKewXxlFPFK71k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360013; c=relaxed/simple;
	bh=qZcAjS6d3Ply+wFttR+Tvfnz7rfysfcxVpn0kVP1seo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fPKuviGG86xBsDwoCRSh7t1+kU5F4jP15fOp++7P2NKniyCzsdSvuqPF0OQFUx4hgDGz90xBaGA3S3cvB2PXkW3m/DsIDSOPSKqJh5svtKu3KOyVWHYO0vQXUlOUhKVMSbRwKVuvKNqjzFFrrbjeDhyETMyjaRFubnTRqpoGDU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EBrMU9w8; arc=fail smtp.client-ip=52.101.53.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKzKsXt1xWybhi8Ex8xjJVqU1U+aA05qBrkUlCizure4bA96cIiS62NQ9rDNO4TNrdstTXR3PHrmCeYfErs5up44TuLQnMvDhkyVFOYSRpjcIet/lQBpE/PRjWvGoIRqJNILXJNhk9BDQdUZ8JYIbr1WRr2DhkVGaQVaC2wgEi4LhIpae0RRAdGh47SekCYaectl0CpGuHLqFhIzuzNo4Qpwh1tPHV7AOxlhgZRM5/ey17N31234fjaJOqZMPO7NmjXfk60NT+Ew96lwN4wjt/gXsKu0hfC4AKLKXZvPyFPC6pj3OpZ3QqD5KhWtHbHjj3t7Bza/odYEdKUB/exZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EynX7LWe0jADze8xwwyGtRY20HODjvbHdumAOUoPCFI=;
 b=fDTpp+102OvlG9/RXk/nnYVPrhqji5x5RwgZI63AWVDcUS02SPV4+x26ZTml2M63ffGUQ6dQFXSQFMja/1KnVd2JBdRTgorlJoe175xmaYyit/j3e6OBTxTgPH9IuebbdV1dWWq/RH6Qjvk/u1Dym0K+/Yqa2nGVbPZ5pXhAQsUqB3LC4I1pqLy50CHeoNWjPYBKap1gF19TwAWGSxLDtbo7K6u2X3TV255j52c2GhpZNl+t/hSIbTtSNQ7HNBKwdBhKt18EtwAoHSAPcdyHiTXGTSVLckiz2iUlRtrjLLRHTRjjA1/zjcugiyog0H2cY9ZSn/YCUcwItydoKhxc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EynX7LWe0jADze8xwwyGtRY20HODjvbHdumAOUoPCFI=;
 b=EBrMU9w8h/rMynGF1teTb9Fj3xfH7cAdjddAd5xqhJAYZ3Pl1nViQb3i1u5spqjfFTsTr38jJZI7YmAibe1FYKm192Qx5YJMXYI0mPm7QV74hdvBoHhZfsiFdf+1lvwXt6DOdxZvlv24trGn50VOrMDQQnCsVMcT8C2QPbMTbf4nJl/qAZzVRn6WTzgovZSpQco+UKaaJBXFS9rTISWYOEJkSNgCNs/eIgyp8PvfDmLuNuUt9/s+ctwTr/ke0ANQzbmutB/8uDr9FeELmsYC8Bh2qzro/Rqxe9tgYZ2XLbqvRmWEztORTq1DMYBStYW1ovuNlG8whbkbANtRYROhog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 17:20:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 17:20:07 +0000
Date: Thu, 16 Apr 2026 14:20:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	kevin.tian@intel.com, joro@8bytes.org, praan@google.com,
	baolu.lu@linux.intel.com, miko.lenczewski@arm.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v2 0/5] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <20260416172005.GB761338@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <3eaf217f-8e1e-4d64-983a-6b888886f157@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eaf217f-8e1e-4d64-983a-6b888886f157@arm.com>
X-ClientProxiedBy: MN0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:52c::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF84D37DD5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f5cb78-4da9-41b3-41a4-08de9bdc67bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003|18096099003;
X-Microsoft-Antispam-Message-Info:
	G5OemyOQyGyzLvIRlr+edWqnSwlp8g1O5YyKmmnrTwKTdU9txF5s8oYWjQYkWCigA1oA6Vgn43pja29bZ1B2B02cpQZfg6/a8OX6Msa4iNEsGckp7uV/W3wBkKxT6u9ukYfOl5pC6lX4B6H7/PwlcrDRoR2uz+BIS4oxzLbCsCZgs3yfAeujKyghZJ3LN2kpgS+avV8AP2w6I4iyigdrpSGQKXpd5WXSpkZ3KWCCi1ReLdin5lhyL7PMBmdReSri78bpcC4zYDuewRZ3CjmXyWByjl6TLyXn+EIg7AUyQrazlUQsNFWwMn95TNSR7BpqJwMf+awg8p08SUzgyp6aWt4f3NGO8IYOT4B+prpDmS+oBER4wKeIf8/sMbuJB1wFVaJc8VarXxU7CjFHhVx+zeWefejGyvL6VTY39/D1BbRIYknK6/O1ZiaW3zdGwQqH63clRKFg475V/4/MxVoywBYsXYL8zI3SrSCdtViz8eJRTEmQB5rNbxWdpe6meZbwCrvGpzqpWtrtaUDdO+CNCiCLagpjB7yn29Fj82ZfudUEwXLdYoPs2YlJex1rdViOMfgepeaCKP2VbpeKlSO8qav9gEXsrkrALmzTj13dkq1J09GPCghsxVLAemzEgqxguT3+c/9zYGz447pb1SsH9uiMHQ5XM18AOSu/Y2Muxh3x+eNZoMywGNMhYC3A/UJqJ9wX9QXqfxpMxlfgoK50R6yyhbYwdIBVjdXiuknOhys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(18096099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sd77nMoFRN8mXODcPmQhY7umLB1xjyHzfWXHyi+AsszQgb5y/lUtzdRv+2Cg?=
 =?us-ascii?Q?bVLTyG6CutPdSgcEeShk8q0OuwCRsyEMiPXfQSehby/CErx6h3G7xgsd8o8U?=
 =?us-ascii?Q?MhqC/XKQl1L9KQxhhkfJA2kFwKkO9Od69UAQFa5dJKiQHMVsrG/eDrTtRxhw?=
 =?us-ascii?Q?MgJh9XUBD0Zr709UPTNva4IFtFM9G7B9UicaoyZrnKEK0VTevol6D76uWMEE?=
 =?us-ascii?Q?MUyPH9sezQMygMGbIGQxrAifdHzWbX5Mg4gtj9loTIOADZZuiOhkvZMVotLP?=
 =?us-ascii?Q?ZB1Ey6Gro9zJy2KKyphOluOEfb+/Hfo+4b5KcrNpi9UpwjV+XBCrPafbSOkg?=
 =?us-ascii?Q?1Xw8cXOAwjfoFoVi+6HCILwJS3vODBZo/73nodP1JNz5XZcC6bO5GsniCTvY?=
 =?us-ascii?Q?JERQZfb9Zalc+zzM9+SCuGMkfnGsBgJHlG8GCxvNAAj33U9zd3xfYJi80c1W?=
 =?us-ascii?Q?0C0YJGxkT7aOcPfn8M0BjQoxHtndScZ6wQM/wz0ri5CUmsT+nIiMkVbp0H5R?=
 =?us-ascii?Q?y9M9kvHFg3jm9p/es4NMwXCQg3Rtd4hEj7Zx00a4NeDc+gD4IIvFsUSkSsWL?=
 =?us-ascii?Q?x4I5Ar2o9vK/kTMGSHnKG4gl57DCuICEqhpLqYMIufFeTdbp/T0APho04fnU?=
 =?us-ascii?Q?HENUI98R5fdyEaKuIifAwkHq+6VV3fv2XWlCR62dlVtGw/f25hiy1LNpqHlV?=
 =?us-ascii?Q?2Uw/WoGep+cfhGlVAK87TLge4Il5hA84HM+FAQMg5c+8RKqH40pbB7+eRq+T?=
 =?us-ascii?Q?FGqoicvlHGYYpIjH4ydeLIY/075YoMWq2eJyCYe3nXngZDEcmbcaJOFsQo24?=
 =?us-ascii?Q?7z7U16kmEStQ/ZPFdiLVVyR1SECUmsyT8Kys03q1kYwndeot/YGrOwKOgrDN?=
 =?us-ascii?Q?5VamwaUEhjVR4e9PW4L7+oqqIb8rEXWR9cuVELFjyQtWnJp1VvaEd2bHBFPA?=
 =?us-ascii?Q?68ZJUO+zNJABs6LbAqsOLGg2xxK/avkUW6UcDbYnnaJdeaGe0RbCMsmb+4e5?=
 =?us-ascii?Q?qwT+VvU4yswpkISIka/+bYGhtq7imI6ukrHmKNao1/Lha47caE8H8IUq1ISI?=
 =?us-ascii?Q?3bbpAO4piwSAy3UAygJxS+qwBfBwaEoAxnigmqu0Xido/WQ6AgmWQlEqdU/P?=
 =?us-ascii?Q?IhrSmnAw5h1bWvZNsstvHyS+jd+d0GuNwTjO853XULf9TvEOPF2A0AF9hCKe?=
 =?us-ascii?Q?hxlLpQKOzkhYKTon2JhkOEMq5FvmpHygxu69+gLhanSqygfMmVR/VoL0WvlE?=
 =?us-ascii?Q?4HFJCOn4O2bRl6JnRTd8HDgM9KFODMsqZHe9TP16Q9/HT+IR4I82cVbzabho?=
 =?us-ascii?Q?OlyG6otoY9k4sgbpW9Hfgukro/3ClcTkGOtJzvwgvb0/DB07YwKqEtIed6QS?=
 =?us-ascii?Q?VTuutIdJl+u5kY/rDY8b6O2jI6zRb1so1lxPl/yAN3F/a74ZuFc+dNxzRNNK?=
 =?us-ascii?Q?l+R/u+vkx/trXo9u7znfU54QIqoueyDAuF9WmQSg3LznQtoHxs+hSNxr/grh?=
 =?us-ascii?Q?nYxKPkFxiV1tc3fFLby2mEoA1P3kBuV374VD35ZR00lIDLW9G4/QLOZs+sWn?=
 =?us-ascii?Q?RGpYNY7gvF4+El6X6AmTSOewgXYG5skcMuWCbW6pqqDeOrVawXwVG5vFn8CR?=
 =?us-ascii?Q?ELROtPTOMobRBOJ80NO831oui+Ik6sYsI6fiM3kXu9WEZbn5OwsdMNsBYFeB?=
 =?us-ascii?Q?uFM9s4ToCxptB0A7Mcdb7eznqgp2VbMBzEGvqPaohN8U1M6Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f5cb78-4da9-41b3-41a4-08de9bdc67bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 17:20:06.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8t5EXH5rXXLcUdOecMx72Jh5RL4YDdMC63pI90Ff3tjWT4Z2mILOlzxXmqtayEg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238340-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F5244128C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 05:49:24PM +0100, Robin Murphy wrote:
> On 15/04/2026 10:17 pm, Nicolin Chen wrote:
> > When transitioning to a kdump kernel, the primary kernel might have crashed
> > while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> > driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> > and setting the Global Bypass Attribute (GBPA) to ABORT.
> > 
> > In a kdump scenario, this aggressive reset is highly destructive:
> > a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
> >     PCIe AER or SErrors that may panic the kdump kernel
> > b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
> >     the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> 
> But wasn't that rather the point? Th kdump kernel doesn't know the scope of
> how much could have gone wrong (including potentially the SMMU configuration
> itself), so it just blocks everything, resets and reenables the devices it
> cares about, and ignores whatever else might be on fire.

The purpose of kdump is to have the maximum chance to capture a dump
from the blown up kernel.

Yes, on a perfect platform aborting the entire SMMU should improve the
chance of getting that dump.

But sadly there are so many busted up platforms where if you start
messing with the IOMMU they will explode and blow up the kdump. x86
and "firmware first" error handling systems are particularly notorious
for nasty behavior like this.

Seems like there are now ARM systems too. :(

So, the iommu drivers have been preserving the IOMMU and not
disrupting the DMAs on x86 for a long time. This is established kdump
practice.

> If AER can panic a kdump kernel, that seems like a failing of the kdump
> kernel itself more than anything else (especially given the likelihood that
> additional AER events could follow from whatever initial crash/failure
> triggered kdump to begin with).

Probably the kdump wasn't triggered by AER. You want kdump to not
trigger more RAS events that might blow up the kdump while it is
trying to run.. That increases the chance of success

> And frankly if some device getting a
> translation fault could directly SError the whole system, then I'd say that
> system is pretty doomed in general, kdump or not.

Aborting the SMMU while ATS is enabled also fails all ATS and
translated requests which is a catastrophic event for a CXL type
device that a correct OS should never trigger. The catastrophic
explosion of the CXL device also unplugs all it's RAM from the system
and the kdump kernel just cannot handle the resulting cascade of RAS
failures. Plus you loose all that CXL RAM you may have wanted to dump..

Regardless, the platform has this flaw and to make kdump work it has
to avoid triggering these errors like x86 does.

Jason

