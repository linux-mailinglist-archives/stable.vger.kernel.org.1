Return-Path: <stable+bounces-241042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLltHMfX62lISAAAu9opvQ
	(envelope-from <stable+bounces-241042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:51:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851E463557
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D5BD3008633
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853A3FBEA5;
	Fri, 24 Apr 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTzC3Sv3"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010060.outbound.protection.outlook.com [52.101.61.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C3B3FBED0
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063871; cv=fail; b=XCGZERdkTVexQc7VfZmNhnSBdq1hDp7XMVKu6EksBuq58T7/Z76l2p6zm4j/C8Q2o2yS+kE5saDg+L5jbVmARsQ1KTbbndRwqPbW1QLdb1Gvf/6plMOYpPSqrMJSX50r4x2RXVCHmqOWQZ+b4NddwyqZ5WCFEUfa1SuLsajyvRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063871; c=relaxed/simple;
	bh=i8BigMXi2TjXSwtq2NskQAeBB2NhH1lkjgsYSashgWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cnSDnf1oDxtj7UZPFMEON+DdnYj+o7kiHAaQ/CpUjOCdjwHCQvXvEIS2yuOiZQJ7VcJrtIXr1UBDR3CrXKBR8MssDyop8dwRjVSJ7XfdzS273nY5XO/9N4i37AorYIU4rxpkeMjmlZ/JXyb2hT/22wTDFHfZIHyzCejqeKCbxYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTzC3Sv3; arc=fail smtp.client-ip=52.101.61.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJTGeZLah8VBJcTccmriX7n+3LNcXYEX3ZktjuncC5GgpFtC9kH8btUObbDq2Fas6IkJhrVkLTa4edUCdNf84PEe9KgQcjFxpQpI+6Ozp44WQz/9RFK+mTgL657MYOnb1bi5mQGdfmeB37ESoGfd8Bkc9OszorsKB0AxgFZTvjXQyrKoT34Kwn2KeRtx0EWKV1mte/5GAJFelISAUlZ4e7ch4s/w0e3VOjz5Sy3eEYng7HQTqHEHeSQc+VTdQLAPiLPfowf5MJh44ZJpeSMVQ23tKEOdh+ovCjGjzHYOxxSQ9dQqsz6QWUtbGiHwKfndJLVeoVbAI1dPqN8E4UAC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrFFVQJFoSFKzwZv0bd4I3UIGIPRzK+St9TtX/c2Vgs=;
 b=ZeHaHcztpZeSVjuEwpMj6I1LUTnRLGWzM/3CudhuMKk4nsV1bnZbASqoYLQRRvKfVqfc88XPw8dAmYmXymiITJjUGJcGvyjIOmXymvFInP6pSc/XIqaACZ2RIPcziwgJwXKsQna687nWqaXJtZO15RZb6v3Fo/nQBzImlEEQJNTUloz7VgAkzBN8+ebTYLPZRr1MoSlVZMgg4cbO6Z25lhuLYkkWrY7juEAtgBDWi97u7mo/9jTF5YT28N8VpADuTsLeP4cy8QIgh+GRM9XpjpX6MyVYl7VY5y3gW9VjWzO+dX+bB/mLvlbA3G0U+pRGwjMJShb8xzWP+Nn+b7I1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrFFVQJFoSFKzwZv0bd4I3UIGIPRzK+St9TtX/c2Vgs=;
 b=BTzC3Sv3fYsd2OgNHEG0r5I9QLJqnB3cN5iGcoxKrrVk97wvAaBueWWQvJC2rcZvA98eNhQbHJPD2Jhd3nrcskf9UvdlSSou/vjzkgcbdZPQeFkss2k9Y9CbXhurIcbZTQC+vtOu5/NCw6heCZE38LzQYyXsRCk+BOP6bscdTkRxTvCKsEKTlVsNrwjHbBc3L9Ds/F4M37CDczhXDJTYHgaZVRv6qwmcjMSZZ47oi923xr7YvJe9IGpuUT7mxl9cJt1sEG+M7YyP6ctCjXraUo180osb03cdjPQA7IluPbTXbslXEnwfTXb2DxI7SoLyXWP5rHFmTz/YExzm9E3nGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 20:51:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 20:51:06 +0000
Date: Fri, 24 Apr 2026 17:51:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v2 2/5] iommu/arm-smmu-v3: Implement
 is_attach_deferred() for kdump
Message-ID: <20260424205105.GL3444440@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <7637d66c0f6c1fb16da4b5c9c4cec71752cf4d23.1776286352.git.nicolinc@nvidia.com>
 <20260424165927.GD3444440@nvidia.com>
 <aeu5/HsLwfhNWpbm@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeu5/HsLwfhNWpbm@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:c0::41) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 2676993b-fcee-40bc-8fcc-08dea2433489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C+PKvJRDe0tdX1bN+3SmDHjRU2BxXs7r3/opEnl+vCcKikUrjMNh3wgtZv4RnSoADEpjH4xDmcTapcpCEjII/sXUxYBlY3X6ADmOJl92CCUenjFxVjDSzOjvTFu+S4UbK+Rrj+523742tbcd5a2clR7g5T3FoXALxOOkXMZksPRvIhrCP+sy+9h5+G9tVik8avaaTlW7MZxNefeFfw5lIG40szOWB0Xc6rt98IwF01nxdwcSEHc7duoTAyo8E4RRFOK7Ecq2PglX6xk4OoJRCodwuGDMLNp8zfBJNT1rTO3pNRsd8pHlXEv0Qh81O7Y+6i5UtRXyfQYO28uXjc0xKD0iGf2BZ/M1vvPVVn4+m64IUlIZ6PKwDyD7jlbVZkQ9eMxL3coUKBQ1/cyGKN8vJp7Yr/U8xXZC3WpCD+ftUObu6Yhi8RJ1/g0D6DOc4npA0FsEwqaa6zvqqVaZKzVU3p2vroo7cgy4Ro4Jx8aLEI3L4i1lrH24O+WmDMQiltATLeMUWI9vD0HQNlvKjy0fOHYZBaYpC98ecVbU/O1OyqN1WNWFhTIro9ffInBlI7yKy4PpT6SQPxxOk/zNIQ9zrEuZYgYIpbX0kZ3AwQTZ5mAODM3pmrmwyRvXqbXPnOeiKL04TOSvZ/EOECjqv/PgldKiDt2/Ld3Q359SHxhYrqTAXjQpoW2k0S2GSqao8zObHS9GzVOfI+HVTJyIgjh1c1GmcCRRkpduvrhgPPNB40k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5z38jkTC2fOJ836CMpE+++WvYPdGWEqESK9LmkTydS/Pwj8fWcivUDnrlSU3?=
 =?us-ascii?Q?NE5wsKLpbGjtKWJ5eKDAZIE0SETMFcZg7zxCocTtdJrO6SuofP9PvIxnedi0?=
 =?us-ascii?Q?2wZes6MHKPAwkU9jxi/i2GcB7/oNvWZWMlFtOAEYelMOuWEcCg2MQetBc+Zz?=
 =?us-ascii?Q?RBL8VR5NN0LIFRIxydPOcJ4N6O9CzcPVS30CHUDzTRyX3le8nFzGGvnHJgqG?=
 =?us-ascii?Q?JcbRelPEj7i6aCEVXf0VEUj94jIekT1R7Dlp7wvE5+jrjKBPDbvsOBmA6KCS?=
 =?us-ascii?Q?/swtka+H2r6lNsoiFP+LGVnQHM6we3gJkpgMmg7hg/DUbHTCwbw4lS+1K9h2?=
 =?us-ascii?Q?UClgHuePJ876VwqKzMrt8AGta7fD1AWDxylzRQiDgSGHFAlig64v4NWk7cUw?=
 =?us-ascii?Q?cq22ltPN1jIzthd5l4yl1TEB5239ovfX4MrKt4W38UukgKK40g1YZ4s+mce9?=
 =?us-ascii?Q?Y0x+IySRY72DLG+Slh0vE+tnmcAxuUFMSAoZYNoouR2CTctBo/tXJ2lFaHa+?=
 =?us-ascii?Q?eRH0I+rxruTkNHPGtjja8quc7vLqQieEuF399jzHG2A7pcofNHf0fo1Yyi8/?=
 =?us-ascii?Q?k/1N/a4trSfaHq9BM3tRjspASYExhjuPlFDsG3bnW/Fx3ECwg8FG4SQ2GvMY?=
 =?us-ascii?Q?OioR/IQS1z5R6tc2tDty58eK9VD+rZ2RoSLJWS6JCguUIRwnSNbvBeae/YKG?=
 =?us-ascii?Q?1/X/vgtpA0DNYuTPmA4/Q4ViDXsmmeOKJeKX2JoZL4PhnrBIXPCvMGAyo9f7?=
 =?us-ascii?Q?ZMV4ybJxM9tJZMYqT2LtuaOGp1q9RvdHQY8LN3EWiPBxzZ41elt3IzRaw/wV?=
 =?us-ascii?Q?fjGkaXmUkMNafEE5BtMSMpyv8sVGoco94kd1vS4biIr5zrF/JwtUYe+4m8J4?=
 =?us-ascii?Q?JusYdzorBJOVrw4ij9CzOZ6sboweYQ28E6iOMBIg64yGBjiMAbVTBK8m700r?=
 =?us-ascii?Q?N2TVXiJYUT6KGy3h66eoreGjTN77a3tFqd1niqpqJDDSZ7+PE7Odnf5ZTHlm?=
 =?us-ascii?Q?mAwMWlPg56XBHi0iLgfKuWS+9BmMzPDPfmSgeR+jVfONrKgYUghrH0rzXvfg?=
 =?us-ascii?Q?JVa2EhfQTisdYihQD5gF5z+lPB1nZO3OyOhJCsLdzwk0QQQ6+DzeDx7/2bZm?=
 =?us-ascii?Q?q9dymxr8oDn+klOetNk4YHHNb75Renx7Hk4fcvnVBIQ9N5WgIJSTCUAu8L33?=
 =?us-ascii?Q?V3ZvqR+SbWxxxHhAyhB9QlpQ1V2FzaNBY/3ZuypN/QNoixM04y3pzu3PE6sc?=
 =?us-ascii?Q?pWgUzgBYtTVMnjDIpJKRABDkQpyb29QdIVe3seqjtM5446XINkzpHgEoOuA1?=
 =?us-ascii?Q?twLJLsWb21xo3nQ3M98HlT7wGyTq5aKRZves1dmgDHWyUeDbnWa1d74EYO97?=
 =?us-ascii?Q?Lf0aLTDCXTgqPpoP86nqAUIwuLaBZ5mAkP7zLPLhDVmLBP6BtZeKy/cM/1lQ?=
 =?us-ascii?Q?pOmEvu879gVRzG2CORIHbjagE6JZkRBp9RF7E71phXYIr7ISA6CQSKid5mZS?=
 =?us-ascii?Q?ibluP6CLU/uzaiTAUNsdqu+sUd06qMcS+D0Y9B9+NyY8WT/g0x0voA1twqtE?=
 =?us-ascii?Q?tW0WlysqorKeshvNnYcknzNjUOxbYadJvE730yS3r9ftjr1pvf1z4H8P/v5s?=
 =?us-ascii?Q?Bbtwb/3njh11O9WosGTlRqlo7Su0g8jSccMW8LSFDQRe3dY3qWwzMG6itKsp?=
 =?us-ascii?Q?SL5NlpX+M14k0VxVVmtcNqYxt1yooYiWJEx/w/SzEAT5tFjs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2676993b-fcee-40bc-8fcc-08dea2433489
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 20:51:06.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U71m+xCqF9Ij0JDZT30xYqqjSRvmBC/FrLRv4L+E0jXZgCLSxW27y982jljT8S9K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
X-Rspamd-Queue-Id: 7851E463557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241042-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]

On Fri, Apr 24, 2026 at 11:44:12AM -0700, Nicolin Chen wrote:
> On Fri, Apr 24, 2026 at 01:59:27PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 15, 2026 at 02:17:37PM -0700, Nicolin Chen wrote:
> > > +static bool arm_smmu_is_attach_deferred(struct device *dev)
> > > +{
> > > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > +	struct arm_smmu_device *smmu = master->smmu;
> > > +	int i;
> > > +
> > > +	if (!(smmu->options & ARM_SMMU_OPT_KDUMP))
> > > +		return false;
> > > +
> > > +	for (i = 0; i < master->num_streams; i++) {
> > > +		u32 sid = master->streams[i].id;
> > > +		struct arm_smmu_ste *step;
> > > +
> > > +		/* Guard against unpopulated L2 entries in the adopted table */
> > > +		if ((smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) &&
> > > +		    !smmu->strtab_cfg.l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)])
> > > +			continue;
> > 
> > This can probably just call arm_smmu_init_sid_strtab()
> > 
> > I think it is OK to allocate another level 2 here and it also has
> > protections for SID out of range..
> 
> Actually, sashiko pointed out that this guard is a dead code.
> 
> arm_smmu_init_sid_strtab() is called in arm_smmu_insert_master().

Even better

Jason

