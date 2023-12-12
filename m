Return-Path: <stable+bounces-6510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C294980F877
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 21:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD10284BC8
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9065A6E;
	Tue, 12 Dec 2023 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pifhiErx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D1173E
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 12:52:57 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCIO0Wq021169;
	Tue, 12 Dec 2023 20:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=PPS06212021; bh=oaIP/fRlY/u6y50uQiv
	mcCUXuGzpaKOVwRUXq8nzSfg=; b=pifhiErxe/0b1UIHEG5oguWcVzXvHYIKcK8
	DE7O5tCzHkcLudTYavW/n0NEaPmvN8LHuVdYdaEeEQ1HKRn9NWQ31hZxy6r6bZ1U
	ZOqgUv/Ghta7LHNUM7An8fPQv61JExko1MYF6V48cdFN1KTez57IxIJrDZzEdhIx
	zPeu0pcT3E7HOI+pZMqkQYA0isJoduFyYbQXCMu1yglzHxu7XTmennBqKmu1tBQ6
	xaPFjqBmOd+Sf2H1XuZfO42CRBFYoZT/yV6O5p/lYgctW19zY4v19nVaz2FzVZ9s
	R66VV+fl4VgaOQyWL2N31OH392El59pfsCJZJH8RylxLGb7CS9Q==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uvdexud94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 20:52:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9z9fHxsM4tqSdh2z9mk2CkSRV+E/qYBP/vvSLG0iuEIFBHYiHfJcEenvxG6dE9Ti4kybmhK5eCZMndHNTbAvZDMBEVsCIYrp2XFJhz042cH+fSyEXWQqI7tI+46O48ojVD97ijw183ZkFhg3wYc4FNYAh/XMukMj2GDhnATuDGECdA4aBkGsY0VWhPaaN+wqZUwZKPiSZbHmNb87350zQGOwsGRhWBnd2xum2c759tVdX3jN56Y55Bj5U9DfCTv1zfFLjTwYZHc8j60GaYKT3r8IBNHMghWkIOFy1fsvlHgl4VwPceIThRXTXvZ6meAFLZkOWbmEhfNWg8miaI2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaIP/fRlY/u6y50uQivmcCUXuGzpaKOVwRUXq8nzSfg=;
 b=hnY1+89GwCMfp4fTutu6GWQ0BateEe0WFlesSh4/5pMijvC65My/plqJ/XMk/SkaxLwKpB8Fls8eZTAYIR+aZamUHGlhzMlQdptw7VoU3TYHUhcqossnzVerTx3LCATWGYsalcWMIJCeQDu/PABNdyKV/EaJyLbLxeZt4HbV6dyN/qF1Ja22uU7Bjtyui/xs1hXwE52Q1eM5lWflgOzmLTQNooaIolxyKO1MpfD2evTljH74RsjXcxWwFGlOWqe/jgqWvZFC7vmF/3lsV2lWuaTHMPkrNtCXcZC7t0TCxQHZiPIeX1BQq98pufR9ZovekAwzWTHXaHGnMD102xTwkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by SA0PR11MB4704.namprd11.prod.outlook.com (2603:10b6:806:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 20:52:39 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 20:52:39 +0000
Date: Tue, 12 Dec 2023 15:52:35 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven French <Steven.French@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Namjae Jeon <linkinjeon@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for
 CVE-2023-38431
Message-ID: <ZXjIEyiEvrISjsX/@windriver.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|SA0PR11MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d77c65-21f7-462a-cd99-08dbfb544739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kcbtAhVYLWtCBrnegibPZ6Obo6mwoQ51CIBpDIvyRwelf5OVCWczve6ZwU17eEpXaQKsKis4hIWiCSptDs9+nSA310BeIMD4AhyZcTrgcP9HBQYi+iOxAzG+njoJ71EQ4FGemzLkBeWYdyWIWMcQjGLa4/xJLFNkJG6I86XtO1ixCEpm3rvso3zaMCTJ1422uG4R4yysDLnCjAfajYJnu/RfbLiVq4jzvcLmPPMHyt41L5B+G6nFVsQSGXQ6zZTgpedP6uI+37I2nyhkXMqiOspvzy8MBCnktlgIe4/SjsPwo1DDeBjTHAT7ZsuiQVdFqAsVUqy0CxONuFyPk/beYicV6eJ51aZ3bXWt5CmKv8BsRhBrBjykkqlLBiko2VZ1sbTl0b5D4yhu+JGThWzlVEAhv7BaJTsDHWJAuyuUW3ScnmXlZIKLyjk7eMinGINeV9s8t5W/3FMpzDcIeFcgE/5OVl3iZyUvvPkOnAPG4eJGI6Pzlm+ViCBmpwolcosiw/j4PWiFELHDrB6GZwlHxLVZuY5mE/kUthIPJrvuqpLATi6qFc5KC2EZElTVouCVkU9V1JCgpRs34DSzBCnHnYEpz7ZKzcNQ0mo19a/QbK24R0VD53cfBV87n59xWEUw
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(366004)(346002)(376002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(2906002)(41300700001)(66946007)(54906003)(86362001)(36756003)(6916009)(66476007)(66556008)(38100700002)(45080400002)(6512007)(6506007)(2616005)(478600001)(6486002)(6666004)(26005)(83380400001)(53546011)(44832011)(5660300002)(8676002)(316002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cWIWrWzSPAR/vOAinZXi8YENXlW7ucZqWGw/hjeu+ALMf/hTpuqffaqcP/Kp?=
 =?us-ascii?Q?/aI1gbTgMD44QF7X3gZc6sPcdj42csZ7e+/r0wI1Tc1RHExHGANxq6Bfougw?=
 =?us-ascii?Q?jmgsi/ZZwM5lEQ4Hqp83EIV9q2lrsU96APSKioyMmECphsSzetdMEVeuFHtw?=
 =?us-ascii?Q?R+JQtdVlXY4AjruOnEjm7EzhItnoDN6cl8+89d3vDn8JCtBKsG23kugg1pTr?=
 =?us-ascii?Q?pOFToWIm0mSeRY8UNN891YlTBeUXJjG2uoLzsEN3RJqR6K3hxQmyucTyx61w?=
 =?us-ascii?Q?+SkPfQr7cJHlVQMcTY6nxT325v4wXL5xiMW+LUAOvxdAOjurIq00kdz62Ydw?=
 =?us-ascii?Q?7W4ceIa4Xl3ms40qG49qzZHcEZwHOQ+TuNAT68N+Mfc4MD6hJEUH/mKPG8CV?=
 =?us-ascii?Q?cfBcGSsrCiWDoQb6HN0mua5gNp/v8PxNnKfCX5Rk0LtyMK5yoGDaWbvX9SJY?=
 =?us-ascii?Q?5Zqlmfiw0S6niRVhbXsAe7nYvA2aIwsJvtvTleL1hhNJ82sjJ/b3Rz8Ro06m?=
 =?us-ascii?Q?mNnO4MWxGm12ybyroOXIqsB6A5tV9Hjz/NUJTysP8uKSO1VS1zwH+ODXokS3?=
 =?us-ascii?Q?4Q/YPGXVsvBvs8nj7earZLxaoNojwuIuGS72uP6PBR1LfIKa7gnWlPsz9aUM?=
 =?us-ascii?Q?4tkiA+kCyCqkej/VQoWlfyMRHRZUfpD4ZCQyAsBb7Qxgs4qjDpDFnwlY1vqN?=
 =?us-ascii?Q?YzdQvws+7X/8qbxyY6goi8s22oxNuz5uHYKf5NWzyol2x2VpJPpBQnHMS9Q4?=
 =?us-ascii?Q?9y+KBxc3lYJADfGtEkHAavZIe++mgW8lMhJtFEssQEvRWRPEKijKBgCLBwE+?=
 =?us-ascii?Q?wnV/AEZ3eqDiuSwvMpg12H+CHq5ylLHio5PBUPYXb/G7mS/cv/f5ooCl4zzG?=
 =?us-ascii?Q?EMpOqqDOfsEZn+mEidOcnBXawOirGZDqPJoepSYFKtf1ybKwKgZPUWt177pj?=
 =?us-ascii?Q?8ZnK/xytVsn9xaka5Dc2h6B4vePwu7nRdkkFpoFBWpX93g+zyHhnVl2mNU26?=
 =?us-ascii?Q?272uPqRpGrr6FIwzYztWxKbHBoK9fssiiUMbUs5uvoy+4kuET/rLrVHVeOmH?=
 =?us-ascii?Q?CF95pSmvLUpXepXFymHuFDapudre1L0qm6Gx9JtMxRmk6zWSZzQ2DDkerzwL?=
 =?us-ascii?Q?kP+vNVpWcDzT0wivz0D/WDAq8WMvV5n9Y6nf/j1c9YQ7+tvtbp4DHJVLBKEF?=
 =?us-ascii?Q?XdsngkZ+ELqa43guTWEC1hfUiuu+y2H+xEoNVXM4WmTB4Zd8GzT8QTSFx26b?=
 =?us-ascii?Q?iOeFFV9dO8Tze5vxgpqIl2dWQ+dhyJ5Ia+Ig7d48ZgS9hY7hayGgYF2dm7Ig?=
 =?us-ascii?Q?fZQV567HR0Z540WObNhKINkaTxgNkAahqi7cf2nyB5RaiGVjm0ZMu1gGm9hN?=
 =?us-ascii?Q?3vYxslXNyGIEhTqjbvR8lnXrftN9pRz3wP51sXHdjKn+KiG0Z+leKFt/Bebj?=
 =?us-ascii?Q?cRQhlrvLO2Gqacq85xEN6PlnRpRg6jAlwKW/ZkesRSNnM3HhCs3xbqbfs0IZ?=
 =?us-ascii?Q?8eb6tklU9zZlTWTNagjxqt+wepPsQp5leQqLxEcbmzOPqFz0SI+wWuRlQKTj?=
 =?us-ascii?Q?DKewhIXiyDIxXOQDwgi/PXVcPHN46cBJf3NqS5GRkK1tXLUbOzlIvxZlTYRz?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d77c65-21f7-462a-cd99-08dbfb544739
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 20:52:39.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F27FqwmAIcjqBQSnUW47ZIJxC4SJIwAdoCJFUEC5e4v4psXddlr1NDbLTWHv9UVMwsWtVvyK8ISRIHkLTsq3zTzB3Ax4vo0YJv3SWUq9Pe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4704
X-Proofpoint-ORIG-GUID: k_hxSIF1DV3ipm1JGL-3h3OxAp_Sk7-n
X-Proofpoint-GUID: k_hxSIF1DV3ipm1JGL-3h3OxAp_Sk7-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=911 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120161

[RE: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431] On 12/12/2023 (Tue 20:13) Steven French wrote:

> Out of curiosity, has there been an alternative approach for some backports, where someone backports most fixes and features (and safe cleanup) but does not backport any of the changesets which have dependencies outside the module (e.g. VFS changes, netfs or mm changes etc.)  to reduce patch dependency risk (ie 70-80% backport instead of the typical 10-20% that are picked up by stable)?
> 
> For example, we (on the client) ran into issues with 5.15 kernel (for the client) missing so many important fixes and features (and sometimes hard to distinguish when a new feature is also a 'fix') that I did a "full backport" for cifs.ko again a few months ago for 5.15 (leaving out about 10% of the patches, those with dependencies or that would be risky).
> 
> There are arguments to be made for larger backports when test infrastructure is good and lots of good functional tests (due to risk of subtle dependencies when cherrypicking 1 patch out of 5 to backport).   In general, Namjae has access to excellent functional/regression suites for SMB server (not just from Samba "smbtorture") so it is theoretically possible to do larger "very safe" backports for ksmbd (or at least make these available as an alternative for users who hit serious roadblocks on older kernels), if the test automation were well trusted.   Is there a precedent for this?

Larger backports like that can make sense for a target audience who are
invested in some feature but don't want to move anything else - then it
becomes a deliverable in itself, typically from a professional services
group.  But linux-stable is definitely not the place for things like that.

Paul.
--

> 
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org> 
> Sent: Tuesday, December 12, 2023 2:05 PM
> To: paul.gortmaker@windriver.com
> Cc: Namjae Jeon <linkinjeon@kernel.org>; Steven French <Steven.French@microsoft.com>; stable@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
> 
> On Tue, Dec 12, 2023 at 01:47:44PM -0500, paul.gortmaker@windriver.com wrote:
> > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > 
> > This is a bit long, but I've never touched this code and all I can do 
> > is compile test it.  So the below basically represents a capture of my 
> > thought process in fixing this for the v5.15.y-stable branch.
> 
> Nice work, but really, given that there are _SO_ many ksmb patches that have NOT been backported to 5.15.y, I would strongly recommend that we just mark the thing as depending on BROKEN there for now as your one backport here is not going to make a dent in the fixes that need to be applied there to resolve the known issues that the codebase currently has resolved in newer kernels.
> 
> Do you use this codebase on 5.15.y?  What drove you to want to backport this, just the presence of a random CVE identifier?  If that's all it takes to get companies to actually do backports, maybe I should go allocate more of them :)
> 
> thanks,
> 
> greg k-h

