Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6F76559B
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjG0OKq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjG0OKo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 10:10:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DFE1BD6
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 07:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0ENTfYzrAa7YN4mY8rnXOBSkHDaxiaEd9+5BziKLbV5O+ufUp8MvkSpCmVzfjNaeuuHLIME8jAgAzQq472hs9OUfMFZGVfqCiaQq+rzwZe3AuU3cMW1IUCZXWN7BqxTFujqfeRf82We6fAQzGd4fz/qMQB6E5F68UbqLumPZVGze/samDOj7Ocpn3897mhSkmRVWUKViU/1I/tPVSvTwi6qd+Z/J0OCreZqTS65TjYt5APF+ckqZMbVTFhTQgNBo68sFKfFDQJjWd9Fw8qgVGvH/2ZCNmDF+N19ExOSUkI/6D3TGUmdoFmNI3hmMN+VJB44JSyneq1VpYiQgyLRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMWxQjCF4mnD0Hiaq97Qwbu/T8Vj65lsKMVUw2TFt2w=;
 b=EJcNYK3gr65pYZI78vKjbYobr+8iswa90y/AMTMJF/CrV/QV5Uc89G4we6ZMEkfvJxCJMvEIvVIc8CwP4fen8m5K1DF8pHuPiV8cnHZCRyul7sfsPWraJb/2vxuPG3URvsJAon/uw6k5waECXYzir41iEUpIbF6d+jjoX0Vdmm/ie2xnGZeEnXBYZOFP3h1n7wOZVsOdKLqoMLCxcg/RMb4/30iLOMRqk+ymr3N8LsRF7QVVLKc//xBBrH8g5D2tdKMDtxuA9wemfpyJ8Ow/1AB9jMqjcR8un/k6y3r3CuHkrOo2zh0moluwcnbtqLilstL3mtU2u+o9E4S8J0RtzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMWxQjCF4mnD0Hiaq97Qwbu/T8Vj65lsKMVUw2TFt2w=;
 b=k8Wp6Bmd9ttKQvbxAQI52BNaBMgSxBXu1CnjzSgvG8QyoPdeAJ0wugEKOFXm7IuG91N4kNgzBz8jj21r9u1W49LtbylZ1zA6jxAX3rEdjlwp0pHj5tq7BuTd29tWHU5PWdjG50q3647XcUKdQXBAFsgtPi3EQ7VfzcfPDo3inFIjqdGiqAAU1wGLUurMON1Ksfnn6vc3uEFbQKE8twoGd75T91+cxSRrciksljIfrhVo22UysO66CMasiRtkN7m5ctnSKKL/OsBTPpdNjMdUml1olB2KQQmPpKpWRbPXiWu5PooaQ9xTmHnjrzxMwm3o+Lwh4bQ0k14YyxJaCiUD1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 14:10:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 14:10:41 +0000
Date:   Thu, 27 Jul 2023 11:10:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "syzbot+7574ebfe589049630608@syzkaller.appspotmail.com" 
        <syzbot+7574ebfe589049630608@syzkaller.appspotmail.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH rc 2/3] iommufd: IOMMUFD_DESTROY should not increase the
 refcount
Message-ID: <ZMJ63kri52HHXgBL@nvidia.com>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <2-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <BN9PR11MB5276133645CE4B8FDAFD22638C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276133645CE4B8FDAFD22638C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9c484b-ef12-4618-df1e-08db8eab4260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soSIUvUwNOOiaQ/MfaAx/y48hv8dWTPOIaYxXjPSko4A7GHYG8faXmOjDNh/43xmvFIIlaNPjhuobRz8dZ2OocXNEQuY2LX6zn28rRa842Z3EW28PB0e9dTEKNzPS/xV6ueuyQouOEQDQBfjkUEM83/PkWN5xeqqbMJao8O5lRyF2IQvyWnS+fkcoxJK8eqOZe+Y/e41/abzSKf2uBKk1fxNVPJM6KdxBpoBj/+7yPRdgBiLTOoscSzMUxRCorfKJ9qgSy4zRYZxGaHuw4OoxGRLfpdm1S1g5FuGUg+obGIIsgQLb6dpLxKnRNKvff9fTaks/G97Z0G0+YvrjgX5i7vrvDNCL/6liicuSdaTdSX6NcJbGCRA+/WcqbpJu33dQt8m24Aq9GYGWIVGNFsD7J8AKV256unusm+nlO3czhSiW3NkcZnIsRPA0bfE2/JeuSR0i0ON1UVFB8zYXoZuuALEdyt9Bm6wD1XM3d3l/6Q+gS88PJwJsyJXbzlgJJj73Xwccf+POlIHzt//fRgNTNg1SnaXJ09i+E6NyR5wB7GLryWAMAUB9RHkpAKGyKOd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(6666004)(6512007)(6486002)(83380400001)(36756003)(186003)(2616005)(86362001)(38100700002)(6506007)(26005)(66556008)(6916009)(4326008)(66476007)(66946007)(2906002)(316002)(5660300002)(7416002)(41300700001)(8676002)(8936002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upqE4JC7ZozMCtMcGxMzlqPyKcig8pC9H6yWbtUiqCySZq8/oB+lx8r2OcWM?=
 =?us-ascii?Q?yFyzzgnCddaY8Nrm22QT+VwsgxAEcXhXAnT18ZrFxGNIFbbam8oF5wnFrNA7?=
 =?us-ascii?Q?HZ6GfkjDYDjltgXqnPNKvEcfDRX7Unzil1LJ0v90JmygP1Uhe5KWIvWJFioR?=
 =?us-ascii?Q?kwtB6qth4Yz3DboOBgFv9goEhp9GBIoeAEldcmcUqIld9P0qj29Qe5J6kxs9?=
 =?us-ascii?Q?vZWA/BY0jl9mc9yAYFgnfzVulDn8fvjEpDM2QCzMzuQnrlawwCBr+tilnwsY?=
 =?us-ascii?Q?DxOthFyH98dNSS6LI4KfRdVuScWDsGNY2zjSsaAliRZk/CeNkcUKO8Rubr8+?=
 =?us-ascii?Q?SjOum7TckTZvAm/8QwO/g4NODY4TWCBvPPk67JndcB85j/agcL7LjWFVl7H6?=
 =?us-ascii?Q?RNj+d0AlNrWuwzeNSwKCszataPIF1JMzsNBaGLRQXziIgj5uXX2badArHGGa?=
 =?us-ascii?Q?caat3K+26/JRXavhKFFXkW9Bak4zlqibJaCL44E7e30GYZcExXY7YcjJosfo?=
 =?us-ascii?Q?3tXv1U8qHg+MXYwt9FnLN7gkQAyeL9ERCMjv3n9FYfeBZ7TvEkQ5dDTR8h/6?=
 =?us-ascii?Q?6sdpBv0+XHAByzVLiU2joCRdR0D9hE15hBizarzxWlcC85Fv12SLV89kUKwM?=
 =?us-ascii?Q?vABQ5+6TNInC8GCeJBs9w0DA2Yg2QZ0jY8Y2Q5RoJ82tzfhu13W9Tw2yJVZj?=
 =?us-ascii?Q?u0dDr9GmfjzbPg8YwAuqAIz/EYb5QJ3IJFsv3Zz6+svLbUwgTPS+B/DZDA5h?=
 =?us-ascii?Q?dfOQID53tduGWTN/9Sq8bLT4TqJZSLhZxzmU8Ad7BgMuFEMBVs7XTEjAMiRL?=
 =?us-ascii?Q?katL8vyy7K8J4bSr1i1E8vkWnnpx+UeEoI504SFJ3wuK/fxIx25LN/BLg2cl?=
 =?us-ascii?Q?w/zEsGBfCPwN2AdqPwgqyWuxCeNfI5c367fDVTQiPHsayz/DBYlYJRZIvPEg?=
 =?us-ascii?Q?GH98EwN6BHjm4ySkukRoDp1DMpXKZItwLac4SwJByOpPiG7lZDtwE8vXham8?=
 =?us-ascii?Q?uHCFePVGpkQMGeguEY+bM12b4ZJ7o+6WxUZfrmkAG7X9F/dW6M9CnPiE6kIw?=
 =?us-ascii?Q?FQIaoE3vy8ZkMzej8KvDtK5ccVCLeJ/toUHp4b1vnHY7jRqfgVAulsg0zO07?=
 =?us-ascii?Q?1zZDs8GJSoThSyT2S0lYBei/DC7scdxvsK3MoMIS7oVcYmGtj4Z+I7nUDv1X?=
 =?us-ascii?Q?NazhltA7GLJmQuerPDPuiXXcZ6CMZtLS4PZ1A4HuroYgsiIFj6hEz307WrCw?=
 =?us-ascii?Q?Vjl2y5RYU2Ww5B2ejrH3vHdWigiuSom6HOmxVNUjXKzMPV3ofB+kPeooJkDq?=
 =?us-ascii?Q?H8LqpIn/yZ0l9mKz6Q2xjBCgy9F2sqndkwxlVMZyqB3sAKu8Dtb6IFE4Cxzl?=
 =?us-ascii?Q?U26umgQcAmw9D3QU5GKCVkYZL/JUdiNJBWjkHhooCXG9RwHZnb8oUWpSla7w?=
 =?us-ascii?Q?d4ZqrciitZ2F1UGEIG4dfyLig7pqVTFT3pIQPussMN8E2tnriS+J6MQhOjv9?=
 =?us-ascii?Q?7YwQQ9Q8WPyfoU2OnQ6xXtMDb1bm2AKRI79hsGfZoP7sPeVgq16FIssHVEQy?=
 =?us-ascii?Q?f3RDFI4RwNrzjdFvRQsXl8sQh9dc6394WDLVEjN9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9c484b-ef12-4618-df1e-08db8eab4260
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 14:10:41.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IpTcGnDmqp9tAd+SUM+3lqBwqm3j5gDiCJe119oekF/jbl1FzTIEc5fcAsg5pUH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 27, 2023 at 05:25:33AM +0000, Tian, Kevin wrote:

> > It has the downside that if userspace races destroy with other operations
> > it will get an EBUSY instead of waiting, but this is kind of racing is
> > already dangerous.
> 
> it's not a new downside. Even old code also returns -EBUSY if
> iommufd_object_destroy_user() returns false.

It sort of is, previously you could race ioctls and destroy would wait
for the ioctl to finish, now it returns -EBUSY


> > +
> >  /*
> >   * The caller holds a users refcount and wants to destroy the object. Returns
> 
> s/users/user's/

'users' is the name of the variable
 
> > +	/*
> > +	 * If there is a bug and we couldn't destroy the object then we did put
> > +	 * back the callers refcount and will eventually try to free it again
> 
> s/callers/caller's/

Yep
 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> btw,
> 
> > -	iommufd_ref_to_users(obj);
> > -	/* See iommufd_ref_to_users() */
> > -	if (!iommufd_object_destroy_user(ucmd->ictx, obj))
> > -		return -EBUSY;
> 
> I wonder whether there is any other reason to keep iommufd_ref_to_users().
> Now the only invocation is in iommufd_access_attach(), but it could be
> simply replaced by "get_object(); refcount_inc(); put_object()" as all other
> places are doing.

Hmm, yes, the replace series could probably be tweaked to comfortably
do this.

Jason
