Return-Path: <stable+bounces-6456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D880EFB4
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96812814C5
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC64075402;
	Tue, 12 Dec 2023 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="qlsCeVLT"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2097.outbound.protection.outlook.com [40.107.96.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA4DB;
	Tue, 12 Dec 2023 07:09:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaJBaLgKKTEDi/uf7BqkZOnsF86VQliotfJIp8F0AyoZqlNajp1vxZdRMob9KVKzinpbXKYUdAqQIOXklSswSrjU7XQDp1JUbZU94c4CDCBlSjz3tUpOzRorxFRgo7VyDpda2WxQ5o2TjV/8N/Pa9CuZ09lZ1rU+SpZI2CV7GywPYudz6WhGzg87EHXHPSDaOmw6+xbotE7JTWsS3rklVMOkufxgjX0J+q8qyhS7MtAOjb80UVP9aWreXmb3R8RL+QVaehRavtQYclA/FbhnHerVfw/a9sr1i4Jk2MvqPZnRWNkUw2/Z7UtufApTmduvWO9bTCOyJm3Mb6h8TTiSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLEuQ34booPuomLbdm79z0w4a6KTTB8tiH6fjKqJTL4=;
 b=BoCqDjTe+A3ZBpxm6A8mu6EDZzyeJNBLHV4lCUfoNNXLZXcNQ1NNrWj0jrSDEPNF1uFXsfcIUp24TbXzJO8uKFGvQRylohluxmRbvcfoWCF7Z/Qs9rkPDYR2V7X2HTM0W2Pz7wiVKpQn6l4YcdMoWV5UVjax4kP+FZWyYetmPbxobijM4wyuRiIVmAZdTIvDH6tFn/kozsJkpdHFVOyC/0yJOSeBMRu7QiC0OEukdWDLDAReXeFfjTZkNxEMwW3HFapvr/OAAa5Qvrlyb8GxRT5hCHn5KzQ4f/GLmGZdUYuz45rQ+GLzzXVMZ8wyX7f0Swc01FSITDQDquTzVdktiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLEuQ34booPuomLbdm79z0w4a6KTTB8tiH6fjKqJTL4=;
 b=qlsCeVLTaf70mOPXwQf5TI8vB9VCH2h5jbka6PqgxJBoZqpeQId/2PFMGkLWxD9wjTHsHbgscrRS0F7TRfNEisxpbVt70DFZGAltbtblTqPn1JHXw/w3YdGOSC7ncvJfeWPMK4qabdWx2Oqjb7vcpXFYYdiDUVchhp5WU8fk5V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by SA1PR13MB5054.namprd13.prod.outlook.com (2603:10b6:806:184::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.36; Tue, 12 Dec
 2023 15:09:34 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.027; Tue, 12 Dec 2023
 15:09:33 +0000
Date: Tue, 12 Dec 2023 17:09:24 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Hui Zhou <hui.zhou@corigine.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net 2/2] nfp: flower: fix hardware offload for the
 transfer layer port
Message-ID: <ZXh3pLA6/bI5vO4K@LouisNoVo>
References: <20231208065956.11917-1-louis.peens@corigine.com>
 <20231208065956.11917-3-louis.peens@corigine.com>
 <20231211190849.6c7d5246@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211190849.6c7d5246@kernel.org>
X-ClientProxiedBy: JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|SA1PR13MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: a312285f-ff28-4881-ddf1-08dbfb24591c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3gu2/QOF6UYVEmN8vWA94pI1xDyPzTUtR5AUouTLl+9uIRqh2Ac6FRofrPeovIze+AKRCfXKiIz5/Hu5Hzhvoo9cT76Bij9TieQdE9tnkXfZPlRCQkI+IethNBkSzWgZJvODXL5u1ERNR8o8RLKE+Dyvr2x06s4T/OZlfrUXKhNQbPzpBKPEkaaaMWDtG+vCOlcw/bYJkghBa5uD7zEA05Py49IBEVWbOHKQzk5jMHglX8Gc5JS3PAPP2vkyZ/NprTBBTc47qm+95AGK1STx5fdxzgEc2c+bO9eEjkYJZ5AhVqk3sWWGbElJcocK6fgd/RtJ1XmukPGTIkbs7+0JYDTdXKlIJ/iykfkymoBSbCovM/Q3Plz3ninz7Ly+0/k+DwT6jr+4MloVL0PmItsjui+euwFnDN08oVQvIq8AYpzW/+aEZJlnXNtKD7y+wmKy48gppOFe9RxJIkbGwwW8CIHbIh6warUC3xnO33aOcJ3UwPlG062BrAc58govbR5mYwYuWhp743WZ6zPaNQUQoBo0A+zIOWjA0b3M8eGMr6Sm4kXXeTHI4u/Lm2Llwv5is142sKma+iLrGdHeO+uaKMOgt6FCHywkhieR3NfWE+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(346002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(54906003)(66556008)(66946007)(66476007)(9686003)(41300700001)(6506007)(6666004)(6512007)(107886003)(26005)(86362001)(38100700002)(33716001)(478600001)(6486002)(44832011)(8936002)(8676002)(4326008)(2906002)(5660300002)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRZWmlXzLdvxjBGXZrBCm7CeF3q1mU38X5ho/bqN+e7e5ciigujGkk4A4+nT?=
 =?us-ascii?Q?YqlfpUEzgoa19d5dAwmurtnlvAIkGQZ61tYs/VzAS/kMtj9w9phsBfPfS3Jl?=
 =?us-ascii?Q?R9I/odZirHh/d7f0ZwElRkREhGDyXDZcrJScP9ygtI9i1/4iSEiYEY41qAjP?=
 =?us-ascii?Q?uCzlZsv16h0+X/AsH53k5VXjWG+H/z+6qY7Ttsq1FYhfEQksVmUzxTqJyXuv?=
 =?us-ascii?Q?qUH6NWfqs6Yz2KXdHbpMdvdX9hX3dhQny2gqAHsrOvrkio3+YpOZPcJA5B9R?=
 =?us-ascii?Q?kURejCZ6lmhsL9GnegfJgIiW2LkeexubORMrpF28Fv72wo/D2iLgPtpIqjgq?=
 =?us-ascii?Q?2t3kOy8Yu/fuQgXvIPDcKDIINK7lRvBDZZAy4PibwN4/M8PKOSZxAkqjcW+X?=
 =?us-ascii?Q?SUQ6I9S04SkUSo6C92wAlwsvVaK3AJpxMNA7/mtkzI97tW7SnMO4/Is6J44q?=
 =?us-ascii?Q?QpgFAwGCRc6Oyjb0LqYabafGBrlzlXAsd026E4oSaTikws5f8TXZRTYNpAos?=
 =?us-ascii?Q?VdCv19f3d8WuMN283givKL6DsA2bwMqCygfwrRVaLNFEctTEDR6KLknYGhRV?=
 =?us-ascii?Q?ZHkXyd8ITgDVp4MQbsXO4vBKcdJTrx3Qv+N5qgiQoBNRwS6XBi8kup9ZW5eQ?=
 =?us-ascii?Q?iJgvwziVBZMV1J2kj3ePBNiGJw23IyuM+FKix5+Lv1L97/cQ4FuH7CwAwp/X?=
 =?us-ascii?Q?Caj+H6YmJk41mIi3GoeArXQi53HNG68qMASZyMq4u0WK7fJcjDJivh64cyRC?=
 =?us-ascii?Q?2B89nhe13LK5id8DbwVsQJb9iuzUZfQpKCyYIlV7QtUtZb5hky3WkPviFSHF?=
 =?us-ascii?Q?7sbs31uqmnXiLTRUwPk98nQWoPcA+rRzwVWPH9mimbaD9hXN2lnk5/sDGox7?=
 =?us-ascii?Q?Nj1nmY4TwqqPamS/WAMm17rjohaC2xhKSrdp1HMLKpjvPdx1U7aT/dzyryk2?=
 =?us-ascii?Q?QjsVzbr1hhS6cbGvBlnbn7XLMGUaZfleOFqKendxc07tSRbscERkMyTZLHZJ?=
 =?us-ascii?Q?RE0frSojx7PmnOdJNjDkTfTNZhDReFoUkORPtYWtGh0ZfSUCF2C92NE4JaSz?=
 =?us-ascii?Q?8yKXXwY9NgZ3hsUB5HDZBlqDINK+z2rjfn7/zFHN4jxKXEiJXiGc4kqYs9pC?=
 =?us-ascii?Q?auwjSBeFSvYCPgbd+9rZN1GPwy4zvBEw6J6Fkjfy9jbqukrzxZ/sog4cNvdS?=
 =?us-ascii?Q?sgKhQabr2uiFFVeZ5wWz2LGTjFS98gwLr8UyHSpTlS7azNbNbg/hZORYFthb?=
 =?us-ascii?Q?c0uKzD/x2JrVrYe9GJxTx99ov46WiGZlaUTm19nhqD5JRnf96abgEXgsF+3n?=
 =?us-ascii?Q?/M+4iqv2IpFVTNOIf3fCzs1myxUXCLyUPDnBwWzaexorkY+4bu+wP8j5Lkhh?=
 =?us-ascii?Q?dTtzvCdfOCpdx2XYiyhV6AqW6rlp5KFNlMCSbN7uP7aqhW0GBR8N7coLQHPT?=
 =?us-ascii?Q?cUeb+vdbYwj9nfcTkmSqusa+B2qKhaW9m6N9mYqfJrWdCLaXwwdX8f6ZrVb5?=
 =?us-ascii?Q?TvBtxDHeJb5M4DKyhfByfLc6rnzsk1gBeCKVqaRA5FpGsUJJS1x12XdlsQp/?=
 =?us-ascii?Q?KcNdr8bHA8yaETjm7cabBeoWSNoMM1BbyWbOyOfIHaAVgvFOTwamcy9U1xmv?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a312285f-ff28-4881-ddf1-08dbfb24591c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 15:09:33.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD8YU167cSknY9ALYB1ds9FOyGmSuUFlVdwXJXdrycnJmnULP4jFr4MHe+xJJ9bh3F5lq8/cFmbGx06jz61PA9k082pQcTDra+tzf2XU60c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB5054

On Mon, Dec 11, 2023 at 07:08:49PM -0800, Jakub Kicinski wrote:
> On Fri,  8 Dec 2023 08:59:56 +0200 Louis Peens wrote:
> > +		if (mangle_action->mangle.offset == offsetof(struct tcphdr, source)) {
> > +			mangle_action->mangle.val =
> > +				(__force u32)cpu_to_be32(mangle_action->mangle.val << 16);
> > +			mangle_action->mangle.mask =
> > +				(__force u32)cpu_to_be32(mangle_action->mangle.mask << 16 | 0xFFFF);
> 
> This a bit odd. Here you fill in the "other half" of the mask with Fs...
> 
> > +		}
> > +		if (mangle_action->mangle.offset == offsetof(struct tcphdr, dest)) {
> > +			mangle_action->mangle.offset = 0;
> > +			mangle_action->mangle.val =
> > +				(__force u32)cpu_to_be32(mangle_action->mangle.val);
> > +			mangle_action->mangle.mask =
> > +				(__force u32)cpu_to_be32(mangle_action->mangle.mask);
> > +		}
> 
> .. but here you just let it be zero.
> 
> If it's correct it'd be good to explain in the commit msg why.

Thanks for asking, it does indeed look a bit strange. It has to do with
act_ct using the inverse value of the mask, basically requiring a
rotate-left operation for the source field. It can definitely do with a
better explanation. Will submit a v2 doing so.

> -- 
> pw-bot: cr

