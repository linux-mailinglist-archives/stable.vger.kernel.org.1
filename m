Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6B7624B8
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGYVpk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGYVpj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 17:45:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417B22126
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 14:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZEl0RbRXcPIZ13W4ZWb8L/ZBqBdGZIeobjNQJQ1LG9e3X5h7+hvOab0xceJF1XTDmotyxyL24BHwtQ7ifpvuUseoID6vAB0BBuj58sNd/hHHzEsqspqLWPxjkhHNWsTPqjWF5yfHLGW/H88WgLinPj91Nns1MlLZzmcYOCL50Vn9iAba7bTyFPGV30EsNvOtU5lpkfoVLDbM29RJVY8OkrMuO2NRiex/BOjvAdfMVJBs+8oGfAB+l7Bw/d+H0uUZCv42kfH+x3WbXuBeg5pApfhX16VcidBPaotJ3adTIt57srhomCD4PZSLd3tpGo8HOFJQj7ZZ7u7dI0ncaKcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n20mpiGB1blLl+zVq0e5jefHvsU6o19inj9JXSbXp4s=;
 b=GOlZxwHH4pMdftMcFBXJhpOIMbuutMKJ3Wj0U3NmmqFHXobaf4gg7im4TZ9vUdup1x7GiEds4tR3RSDnCb63OEWbwM/7tyKFqn4VMJqBVXL3XDjeZDXyaT8QCxRrTGXfKr4PmwdILLIDNNjyGikca4dHjiAD7hkKAgg7CGRF6KqCcO1w/Bx7vMWgZKjwP//uIRYFCFQgPDzDeLICvDYYjKQqVUiz8bldUm+3u/B3td6W7YKMl+OXqjzp8q2fql8jDjwkcp5Qg00b58o08859+C/QNGuDu3t5hH3tZNnCF/XLn7D1Vs131SVtXdsGL5YmIjoJM16S80asyFk0BC+fLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n20mpiGB1blLl+zVq0e5jefHvsU6o19inj9JXSbXp4s=;
 b=LIf4fnbxa/gUAOL/6Ppc4QEzIePBjrCZzL+ci7rW0OyiVb7RDEUfjHiMqXseORhouaGWBXRzMSHoSDTlTJ7mhr+NcylTs0e3cE8uoZCEsAL9B54iiCzUesb6fmGa4I/yNQFA8fYL9TpTtwIFtXiFeig/lKr/Uvbz2ODxUznkgLNpK15pFGMx5L62wkOEDEB6EW6z4hebKC4WxxRS/KR0A5XxmWSrheHmKJViEbfKrIWovY5R+4+Kx4vP382LnAtN66NlzwTFLMtjH8Lzs9Kznx+siCl75eKXAOchljQNECh+g9c58JvwjEFpGrvrXdqsjvBKGLQVD2yh//wUZ8yGaQ==
Received: from DS7PR05CA0045.namprd05.prod.outlook.com (2603:10b6:8:2f::7) by
 IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Tue, 25 Jul 2023 21:45:35 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::9b) by DS7PR05CA0045.outlook.office365.com
 (2603:10b6:8:2f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Tue, 25 Jul 2023 21:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 21:45:34 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 14:45:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 25 Jul 2023 14:45:26 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Jul 2023 14:45:26 -0700
Date:   Tue, 25 Jul 2023 14:45:24 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Kevin Tian" <kevin.tian@intel.com>,
        Lixiao Yang <lixiao.yang@intel.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        <stable@vger.kernel.org>,
        <syzbot+7574ebfe589049630608@syzkaller.appspotmail.com>,
        Terrence Xu <terrence.xu@intel.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH rc 1/3] iommufd/selftest: Do not try to destroy an access
 once it is attached
Message-ID: <ZMBCdNIneapDbjUS@Asurada-Nvidia>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <1-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ad737b-f533-477d-65a3-08db8d587a3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVCz9SkvU89fc1krFSnUFub+jxSjvZ2sacFnuhKKLhQ2E9pr/WjJ6Tr8swPli5yMtETgKC6orM7uPAFJ2jSrgcGIa5k/fFO1WbPrULKKO+vb571LGI2631Mp3FWeYi+TlYdcIekQCIEIgUF/QvcMjZENEfnzgCvYDWSSfEtXqn0jYLkuKHLLddpFfnZQ72OHeucxkOJVjP3RAIded7qWC867FCovBf1q5V4KLF+7JzbuRGj0w1rJNccayrXYitLxFL0h2rQQamCYgrWIAFPh62Zmzd9cWzmuKBekE63BIWD+cwZsMMwtA05wRLGnTaix+S5DubIhMZp3xc85YdpqPpZJXSV1KP9ss7ejze9W1ybKt1W5EbStoirl3X4yO1oMFplPv7VILSQpRv8isE5vQu4B8z4pjnWAERmDqRICVIlShNGNkCbf+Ft1mbmU3CPJ+y/0VyuZx+VviZaHOK0igYotu0Wgry1Jip2KUTaCyc31eSpG6MM5mJHl87fLHZHBZe300e4SguRrfJRVB+bkvuYisHdfwP4MPgoL6A08iz4K2QrWwySQI5rAsmG4UhhRFhZMHO9Ov9agwp42M+anx2AybQAXx+ckoo6lRonSY7dYnIJ6zY003HmVLHJKczKNfARFGkpc/5W8S0pad7hGK1/53fuV10dfpCmVRJQBWFSq3I5vfWm737dv4R8qANxGKsFiogNoYFucYnA283JlhLYO18gGz6Ho6T2kRzh1xYCH1hHyzYuDz05Vkjcch+JQ
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(33716001)(40480700001)(86362001)(82740400003)(40460700003)(7636003)(55016003)(356005)(2906002)(4744005)(54906003)(336012)(26005)(478600001)(9686003)(186003)(8936002)(5660300002)(8676002)(7416002)(6862004)(316002)(41300700001)(70206006)(4326008)(6636002)(70586007)(426003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 21:45:34.9355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ad737b-f533-477d-65a3-08db8d587a3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 04:05:48PM -0300, Jason Gunthorpe wrote:
> The access must be detached first.
>
> To make the cleanup simpler copy the fdno to userspace before creating the
> access in the first place. Then there is no need to unwind after
> iommufd_access_attach.
>
> Fixes: 54b47585db66 ("iommufd: Create access in vfio_iommufd_emulated_bind()")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Hmm, I was expecting that the iopt_remove_access() call in the
iommufd_access_destroy_object() could "detach" the access. If
calling iopt_remove_access() isn't enough, it means that we'd
need the full routine from the iommufd_access_detach() in cdev
series, i.e. we are missing the unmap part?

In that case, though this patch can fix the issue in selftest,
yet does the emulated pathway potentially have the same issue?

Thanks
Nic
