Return-Path: <stable+bounces-249649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGTDKTCiDGq8jwUAu9opvQ
	(envelope-from <stable+bounces-249649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:47:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC4158348B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48E093030D2A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD63546D4;
	Tue, 19 May 2026 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BypFHKvf"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673A3438BD;
	Tue, 19 May 2026 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212634; cv=fail; b=t2qUWENZME9Ms1ixvGGR6TrQx3bzW90lMy6njfsU5JK8U5zRTdNnEHlh6W4Z/iz6uLaOF0hRsJkdGF74UGvqRK4mRI+ydiF7iLYwsRIDjAB1kxzcIEspL/OHeKFg4fCXje5TMrEJOfdkqDD7++QPHcXi7ljluA0gPrlBnhUGGI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212634; c=relaxed/simple;
	bh=CYCCmCHmMJBfp+/ne37AUUOKDUB9fSTiZkDwUqmj0QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OhMW9oGg/ohdvND1TetmxLKjTjeRRNF2t3x806EIEmYB2GJNCdgPVYDmyCnLtNvDurM2DYuwZwfkqIq9T1k+6NsXBkpq0gRRMsbBSLJc2oVkDancnyOQ9OhkeplbyfIjfexTTVexmKbS1Rwmij2Pw4UjP93iFpGDtQStY2JRFp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BypFHKvf; arc=fail smtp.client-ip=40.107.208.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GH5WrI2ngRKLv1iO/Z+iLnclYfOYxz4tXogR1Z3O1YWAHevDAuVUaTWLHmnqZtEbjyT58pdEEY3Drz+TQnJGSB4ZNUFJx+RQtgz21aMNUP7VL7Z2Nl9tYAT0YsF7lIJOa8o92m6ICpQ0DqnRvyCABrqxYFQLriIyTqMYAC8x8OLh6nzyui0ith66b475RtOyI81pIg5zveKOVK9uLbRlgXYWHToJfY8CAlsCIhykhYZQBem0PfzNj5ZtFMRHwBBOQlCg4DbDq7tWoxKSGoXFydmUb3oquBsT3atVWw42+h1sA7XH9gz7CORKR+iGWNpP8ytZg666N4AxuJuC9QRdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeAy9qvpYcyOOii7qXUPrZ8WmoR+SWkh7SbakPtKTgs=;
 b=CkFfP+C/C8UpznTsUxoNaAXgpUKUHGqPKJPRzlH3pOLHBn1kRgSDpFbKWFe9gQPIhlLgsl3zBibVfbaJPRDrWj8Z99ce1p5+qMsNQ6y5pkMwJH5ytuJ282ruJbRYiyJcvMs69xSt8ZNh492RHdfV/HrsXCZdZ2qjcinho/Ja0uYDHW+KBpJ0a6kl0JlaYtjaRmDwhrfL9YRCZjKuoLrdaWZYnT+IpSfootl6SY1T/XiB47PCos0AQRRl9lJn4b8DKd8236xXIRdSN8yayZYwFLZ5A/eE8kAf3QsQi+85HDcutxFOboru3WexZ9JhTwzjvXgDA7KXVNwPUCJbMvXgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeAy9qvpYcyOOii7qXUPrZ8WmoR+SWkh7SbakPtKTgs=;
 b=BypFHKvfz+11fQWJZTQp7d6Fp5uRL28k5P1ANqm4cDkiF9VPluBNu/gQU0Vfy+Fo+j4Jrj8o9FxQo+42vWRTishKkHraEL1G+UqVIQeD+hdxbYd9rnBwJu1BP23hdHiUkOnOJAc5zYV6U7XrWU9b5nREViI0PhnfuHwX1HQL4P6bhHoKrF+HFH/K6h06schWYQMNQzPfjUvuvPMJC9SADqKN17QsjJv/sm0OEJKvkFeplXgsqGwxlrF50n9Ewna8PBmRJMPjBDA7bA5DojaYnBLdB6P3akwnHv79uhAzqetiCMn6yoZ9269xTLLY0m0xApOgHzC1acf2hT8ZJ9Pu5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPF4ACC15C0E.namprd12.prod.outlook.com (2603:10b6:f:fc00::64c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 17:43:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 17:43:48 +0000
Date: Tue, 19 May 2026 14:43:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, kees@kernel.org,
	baolu.lu@linux.intel.com, miko.lenczewski@arm.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH v5 2/6] iommu/arm-smmu-v3: Implement is_attach_deferred()
 for kdump
Message-ID: <20260519174347.GE3602937@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
 <43fd9986b085cf5bfba2c9bc06c0411693a361e5.1778416609.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43fd9986b085cf5bfba2c9bc06c0411693a361e5.1778416609.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPF4ACC15C0E:EE_
X-MS-Office365-Filtering-Correlation-Id: 5047b1a0-e6f2-4c64-6910-08deb5ce2e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|11063799006|22082099003|56012099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	xbnculT9dIDboyBZQwKRuEE7eSw/IjnyLY2/DuPT7gP5o2UkxFiDG6WKYzVhqR4CgTNLHlYMHn1ya+Db5W23YHgzrGe/Nrg1OBruHkrJQyxjfzsJYGlWw2MlHzvLBy6LGIKcRGqYqk2XMS7KG7VgSRS9Bsp8TIpo3oLVD+ncyzG5wg04pj1fbH/p8SaKJQAIaqt/V7gkJeZdU6YVw0kc/MQcgbxkAqVMTdJg3kO845PSLa7PCFVyqNjjfmeQ+Ka96AcMX6Nj2TD8YqWEl1Q1mBghstXZ2vZdMHrcd1z6bGRyRyNviez1eWAEjPl1we+aXxvlO7pws/EhU0WtmDQzHlwql5AoShhadS5XfyWWntIj5kptJxztFdubqC4iKM4/21h8OHQ3xJzr9ybbE9sPBQQB77GBDTrZrqGt7IL85CeIb7VXjnu+r5wpcINm0yQx8xiwmsZ7oCgqHCpoMZ0CSFi54K5D5mYvo/M4+X7y8/qd0iAL0I1qG7vlvP2uUEdNr+5JajyNMeEa1nUXGVxoYWG/QwuT2L1xm8EPTlNzwzy/HF/nR2MQapmjovrVZ/keahq4GqkGiV8REe0OAXy4Vrgnwx7oMlcuUgK3JcWcUiDFD7Mt+hwlJmjr9+CZjInd+DMGfMXn5AiKc77nt/lyeef07xJ/OXi64f+EXNaLyivq+vMEAI14P3mqF6WhO2Y8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(11063799006)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?92Sol7dly5ycoPQXLZMDEEuXvLpL0MTUqvPd73eH6jznhMoDMXkJmPix9IGc?=
 =?us-ascii?Q?cwUf6ixktIPILGEG8FEGam45TXsXqNsUqKwomPb0uBzE7WTPFc/zIaj4Xppo?=
 =?us-ascii?Q?Dwpllb3w+eZI6zT9NNRkPkE7hGCPcq/1UR8lNDfEetFpSRccidows5EiqjA+?=
 =?us-ascii?Q?+22fjNkFIv4nOMwY3WGQ6pWK7i3FHTmjeom5SVDQXCsHLxjELseNabjRdGrL?=
 =?us-ascii?Q?s++8cUAnc3YKxQqn6bwVIZ3hm0C/FlQMSqbYOIZEPrrFASNhfgM2gBVokyho?=
 =?us-ascii?Q?bW/COZMwYD10tAib6O//xQaga2JolBAgTxkeh7qHTwhFAJ42n5pmWINNTv20?=
 =?us-ascii?Q?aKXNZMe6yZ7esI423IeOhIqMbzzKYSgT07OreRFH4V6EbSI/bpbd/Y9WpLoT?=
 =?us-ascii?Q?fv784azshcpu7crPlIyv7LvGXauFWX8Q3B1U+HWmrYdhnPppZ5/d461KUPBe?=
 =?us-ascii?Q?4UxDChE0JdLVQfrSpxPWT0IVFeKIR7OsneHiM8KC7CX5aXOVkg9+CuyOc9RZ?=
 =?us-ascii?Q?TXNNR+gqII+tye/ZM+f6gqDoAt/6x08RI8f6PLxojiDfvcTPCeXt2aED8rOk?=
 =?us-ascii?Q?PpN1NNUa6gZCPmoL5Vvvv0VqmXJUkiX+VM/CWOt+W0A1h7M/7VWcovaVpYed?=
 =?us-ascii?Q?iL1/SAVbH1mn48NFlcv8cEULGATZMASrYOjFEsgnBv9LRVhgSldYSSvkO/SF?=
 =?us-ascii?Q?m5gOKegQ1+4k3zVxcmR4eHFdK8yIPjKpJv/0PK25SEs5BQsdm8Ij2Vp1wwhq?=
 =?us-ascii?Q?UkRghyyfgS9iKfeTfeqz8dnxnICrO8okBZ4r03/K5Aph4rBJKsVtijp5dSaK?=
 =?us-ascii?Q?ZVovpM525UpZCyRRs4Afse5eRHOid882C7jdb0TPnuasblfnpxotUDgD9qBu?=
 =?us-ascii?Q?D6QbKRD+1y5ZOCW2SJZGC3oLNhAsJeajZ2mDpjkVtMQ1hFXv8ZWslpP9tybd?=
 =?us-ascii?Q?YMKHXgjEpdMLd9OTgilamQUIzGeo93HGutCOhv4gklmLQClp+HAcQZ2rTCgm?=
 =?us-ascii?Q?K30RHhDLbMUeqrN2vYpnuVpmVu3mSIw5O0KF+QjGvzFrmDp4XUfk8rVYboMK?=
 =?us-ascii?Q?y7tCuElzgh5TcC4eqkF89mZS5r+IU9g4e/pi1jIELR2TNaA67gtG4rZoP/xr?=
 =?us-ascii?Q?gxFjfHfgW4O3+MraOOtWjpfxAsN7ZSDx4DHb2+Igbrt0KvAOOsTUAX1D2hTw?=
 =?us-ascii?Q?NzLgpt+hCHjMTvm7MkYmYHDR0068iQKSLOG65mIvpHXZwrHds5GoL09ttifB?=
 =?us-ascii?Q?vOev1ZiR5/qkeGGSdp5Tu5KCVB0DtWgr2mfuE6fnTHJtIfNGnSQrH7eiu1a+?=
 =?us-ascii?Q?+LzPRFZ2dzkx2+B/o80v2GuE8HOJB3UcBKMfGKyC0m+4LUU9bA2Bdj/X8JU3?=
 =?us-ascii?Q?kB5hMgWplmsuvmxzHhmS6vPDILjmx/XTQFQN/YckxEigdQFTtstyDulzl+Os?=
 =?us-ascii?Q?MZqTzr7xmmTDrBL/+o2UfPKcbgOaop2onHBM1RqaDm/XZT7C3CneNy/f40Qe?=
 =?us-ascii?Q?U29iYICS7tmV/iJkWsY1+3jL/iR43tyNeQq0j5t5YwKTsz9a6ltdELgOro7f?=
 =?us-ascii?Q?88e6Y7osm6FszW4jegfAXDXy09V3iTldSAz6AC5mJPZ6IWb7DdkQZeXhV9Aq?=
 =?us-ascii?Q?mw9UIm4FHKZ1N8aEMeuV0TcOXnorI+10i9pIwGDAy2UHC/S+gyzZ42GAVQ3m?=
 =?us-ascii?Q?/SNO2IBa3Eaz74BRjDzVxbNYxxkqvK7P3zBEsjU2aotHc4iM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5047b1a0-e6f2-4c64-6910-08deb5ce2e73
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:43:48.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufWrl39B7+ux2fywQtnIbq7KqABIlAoYbdsObilqbvC3u8AWX/g480HKdRhKabFY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF4ACC15C0E
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249649-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 4AC4158348B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 10, 2026 at 02:23:01PM -0700, Nicolin Chen wrote:
> Though the kdump kernel adopts the crashed kernel's stream table, the iommu
> core will still try to attach each probed device to a default domain, which
> overwrites the adopted STE and breaks in-flight DMA from that device.
> 
> Implement an is_attach_deferred() callback to prevent this. For each device
> that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
> domain attachment, until the device driver explicitly requests it.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

