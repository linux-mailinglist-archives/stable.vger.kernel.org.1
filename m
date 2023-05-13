Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6D701694
	for <lists+stable@lfdr.de>; Sat, 13 May 2023 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbjEMM23 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 13 May 2023 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjEMM22 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 13 May 2023 08:28:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF692D55
        for <stable@vger.kernel.org>; Sat, 13 May 2023 05:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8At6Mpjdz+folw5bj5AQ9cvr6QqAuLNKG2mwWJaHLEmZ7sjVtWZGW6Vzr+O1NnZ1HPxnqsXXp86Mj/6oNZF+G2x4U0qv3ppOzOtLMVMXvRUM0FfcNF7btcfM/1z9pb8WqHIXWHVKLN8MlSrP+IH7/gzyxpUD9BmiF/sz7rl2fg/hlUROx8juFQvzW+ppF+1jTfYYiYMNxJYaW80Ch/iCGnwwyR2eXMpTQYotDPRnLM5PDhaRrkHPTunkll/t06Xxzet22LfBFxCDZ7YuYf89P56ZF5+fzjcxeR+ojNF4rJRpPoH2dujOq8c8YkjGMZOm/p+57AvEpfB8QTWitQXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8sH5BGPGxByic+i74cpPqrH0jDQWp11RPkBwg2H5Tw=;
 b=KNfeqT3qszm9qt5/Za+TMNZCTCN7HzsPv935Yd3gZ/gld49illYgj8oOPN++XczVSRF4M/b9XkYzJY7YnmRLpv8ZRD3N8xMLEaif5EOq+arcmB0R14Cs3lWwt4ckPp873UdpHrpA7TOhvHwZQnLeF+P26GxpBTxi+iUbsESNfjZE8x4JlQWK6kANsY1SlTFjA6Pd2Bie2hRYGkhURjlfkGlNDvnddOBpdsJItk7mugqIC3JzRs7BL+x6+Gifx0thut6FDyFKaGvLqDugTm1AMTged9/o81ExYwZmA32OOV7oz9EHy3MYHGj7mdavTsD5udJPDbbjBKQ6YGaAt7+HgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8sH5BGPGxByic+i74cpPqrH0jDQWp11RPkBwg2H5Tw=;
 b=Cv4Imd3tWjlC6l5xpZzM5+pchbM2tpW+JwB4s6wOp8SDtuADymv7a46QnR5Pb0aV4xZhbBRZlJzr8HCArP67FvKTLwTGEymwKPaIgHTG+RJuUiHam8iwNA1e3SNWwW3aUBuPa/yohcQRL2Mf2SUTy8AA3fUgchWBBFTT7UZV/aA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Sat, 13 May
 2023 12:28:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.027; Sat, 13 May 2023
 12:28:23 +0000
Message-ID: <cca06775-c451-0247-9262-71c67a215a60@amd.com>
Date:   Sat, 13 May 2023 07:28:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: fix double memory
 allocation" failed to apply to 6.3-stable tree
To:     gregkh@linuxfoundation.org, Martin.Leung@amd.com,
        Hanghong.Ma@amd.com, alexander.deucher@amd.com,
        daniel.wheeler@amd.com, mario.limonciello@amd.com,
        qingqing.zhuo@amd.com
Cc:     stable@vger.kernel.org
References: <2023051306-elves-dividers-01e7@gregkh>
Content-Language: en-US
From:   Mario Limonciello <mlimonci@amd.com>
In-Reply-To: <2023051306-elves-dividers-01e7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: cc70792d-6798-4363-2991-08db53ad8b07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IFEP3ueLMqjDlNurbXzP0kf5bw43Y2Fndv8KadL5rqFQq3cKc/ceU+qM5B+plDzhdF3uC0K7S9jE5zfZ9rnabkGcVo9wwH8vDLZhhD0LFzlyiU5r9Iwh61Uq/cA2S1uBtMhUQu4vL1OrtU2EOHr6kiC6aaYgGj1q6t6cH8mvO6fJrb1FgJB7313NluA2fmt7mPgEybF8S9/kGwVsBOR8hmlhzpkUPqXuSO7LLVmmV8nPmYAShXYj0PmIYtTFgTKXUtRWSNt2/OR6btelN0xXqA5K+KPat4iFkQ63U5dt66gO7i2bAqIQW8MBZwWv3VkUhh4vH9Qy69i+umRdQzkDsVXgXMZ4thKWO4Ym2Ioew5jEJO8Xf0PcSm+jfvMWW6zLalIj8Y0YNNQMnmb94ueSp7vSdGKHvHppwuDIQN+ou/59cEXrFDdkiUzqVguW5aDUiRN6cXF3MMY+QWs9EoYnGXRDfDU7avrtozdWL5jHz24GgTS+QSWF9sT0rdHPSivTcvQfvwPa6CrNsqm84Hl0VaEZf8RmQ9E+ws4Q+iTHaatmxFbU9Vn2z3Y0ISOMoHi3lVChRwU693mluSBAUYQnVWJo5pagovsnK2CJQhtjTyMuMYmeymMvvi6+sEdTtLZ+Ur6ln7OL0D+gvZBeacoyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199021)(478600001)(66946007)(66476007)(4326008)(8936002)(6636002)(66556008)(316002)(41300700001)(8676002)(966005)(5660300002)(31686004)(6486002)(2906002)(186003)(38100700002)(6506007)(2616005)(6512007)(36756003)(53546011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N05IazQrckI5LzVVdEdpTE8xM0U4QTdYdGkwU2lZMUJKRm5jS21TQS9meTFU?=
 =?utf-8?B?VE9IU1dEaDlCQ0J6WHNwaGphdHc3MFJBZnJ6NHZScmw0NFFneGxscWY4MUtC?=
 =?utf-8?B?QkVnTEFSL21ZcWtTVVVYSzlzN29CRFUwMFg5WVdlUFlINHhtVFBSZGU5ZkhM?=
 =?utf-8?B?bmpSMDN1OXRwNmZDWDRIS1YzSy9YRnRLbUQ3SzlOR1Bqc3lQUmQ4eHlrb2hD?=
 =?utf-8?B?TTZESnM3VzZmcHd5bVFnRGFkcEZpdm4zZmt1WG9QK08xK0VtQ2MzaEMwNkVi?=
 =?utf-8?B?cHZIV0hHaVpkQ2VaU2xFOEJzVSsrK2oxR01KS1NYOXQ0R01oanJ0YXFMWUU1?=
 =?utf-8?B?Rjh5SllJbE91SG9IM3YreHQ1dHE2Zk8xQitCcXJBS1NnRHJWVmFRcHJkNXE2?=
 =?utf-8?B?MGw0cFUzdlNmY1g0eW5kL1VTbXBkcWNnMmM4OEdXN3BSVGVGZ3d4VUx6VzE5?=
 =?utf-8?B?VkVkcDRsRjN0bkorTWlXZFFVY0NiNDVpY1dkb0xpZXJFTjBvcFp3cHFjZnNX?=
 =?utf-8?B?QW5tR2tmamhKbHltZkZtbjRoaXF3ZG5BV1hzazBzTWZZL0FOckFkTEFYdndy?=
 =?utf-8?B?cjUxU3R5VStTTTNrMyt1Y2ROZFAydHVDcVkvRnJTWXVTQmZPS1A5UDdMWE82?=
 =?utf-8?B?SkFqdmp4YlNDdlQvb25HME9zYlhtZXJ1eFpjUzIzVVBNK0ZnRkd2NzRtc3o5?=
 =?utf-8?B?bDRhd1lUUXFVZG1yNWJqMDhkRk96N2pJbktpcm56RDJ2NklIVG9aNE9EcnZv?=
 =?utf-8?B?MTlxdlpyQ3FQNERDdkd3Y0xiWWNJaG4vWEpyTFZOb2QwbGtRc2hBNGJXVlNp?=
 =?utf-8?B?cGhsWU04Q3lQdzk2alN0Rzg4ZHFBdWZrbCt5c1ZRekhZcjR4MnI4NXdyWG1x?=
 =?utf-8?B?TTNhekh5ZkZhYkpUZTdZcGRjS0JiNWlrQjBlYy9rQmxrOWFjQVQ1OWhEdno3?=
 =?utf-8?B?c1FyWWFERVpIK0tFSVVyOVYwd1JsN1orV0lkL1BPODU2V3JEeHMrSFdrL3o1?=
 =?utf-8?B?ZGQ5b2dsU2RCQ1pIeDZEQkgrQWlYZEpvRDBFbmRnWWhFaVJZS1ppRUNsZHpM?=
 =?utf-8?B?RnVSMndMM1FkTGM3anEvOHhlNHN2MWFrK2o1R05vYW9xOWVoczE5N2ljb0t4?=
 =?utf-8?B?K0lnYTBHSFZ3aU1TZ3ZLcjRPaFU4YjA2eE1CenE3R1pIeEZKbGh3ZEErYTll?=
 =?utf-8?B?ZFIwSVdHc3RCbFFMQzZidEM2V0NNZkNUUWRmaW0yTkE0N1I5RGlRaFhESFZK?=
 =?utf-8?B?N1Q1L3dCdFRnVVd5MXE1b1E5NjlSc1hJbUlJbW9sT1F0UDR5TlYzdlRPMERi?=
 =?utf-8?B?dzBoVkVMYWFRMXpmVjd0VzlNdlB0aGpZT2U5MlNqbDFXdHVFZVFHZEYvMkVR?=
 =?utf-8?B?MGlGdGJyS3R6ekJYS1ZKc0NaejFETHU0eUNTZE1JSkV0OW1CY3BqKzlMM2VJ?=
 =?utf-8?B?UlBKdXRsL0ZVSDdpdGk1OFZwYk9DRVRsbWIwM3R6bFVnNndIT0E0cCtIc2M5?=
 =?utf-8?B?TjRBNGY1Y3NIVVZLTHJqRkdpL1dLOENsS0I1bzIvYkR4d1AyVGF5N2E3dXlJ?=
 =?utf-8?B?b2FwZ0wzdHd3ZEFUdUwwalBuMlNpZGppaFhQQ3RFYUlUWmcxWDV5UGhaSk9s?=
 =?utf-8?B?bStkRm82UzlIdXdESWdaZGpDQ0lxS3R4NHdTQy9oUTRXWnhFS2I3Lzh5ZDNV?=
 =?utf-8?B?eHJ6cE1vTjh3Zm1MVkpJVUtHMHkwQ1A1VktDRmVXTkNaeHExelNnKzB2aVNq?=
 =?utf-8?B?bWNrTDJYZjQyOWZZOGJPa2Jod0orNmpoSmM1TU1XRFp5cE42L0psazlLOEhN?=
 =?utf-8?B?Y0tUZ2NzUjlYUEJaMHJ5Qys5WmFPeTVKSGZheWtHdDk1cXV1Vm9Ed1RaRlVR?=
 =?utf-8?B?dkZIeE9NNjlFanFZdEdrSkNtNXFMZUdXYm5jajNkbGFLV2NYL1Q1d1UwNVBC?=
 =?utf-8?B?NTJPTjltUk94RjZkYUd6ZHpyTTRrZU1HWG9qSHhkbnNueGJzckJLaUd2ajY3?=
 =?utf-8?B?cXdEMEtQWkNrWjdhdjgxZU4yb3NNTktaMm5nNEkyWGd0RktBNmdmUzhYZGhX?=
 =?utf-8?B?VXVZYVgvb2RORmxCTWZBSVRLTTRvN0FEeWV2aFliMWdudmZmUmVrRHNiM3V1?=
 =?utf-8?B?TVZ6VEc3aXNWTHg5NXZvdWh1cWd4dC9FV3BVaW1tQWs4RUc5TWtUdUZrWHV2?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc70792d-6798-4363-2991-08db53ad8b07
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 12:28:23.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDXRP+p0loYUPdE10jdX33oXcS5JQFt9UhEisy41tsAP34fl7WyZqwqZ3J/E1olbjMHtjSh9TpQ92JNoVLkI0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 5/13/23 02:20, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
> git checkout FETCH_HEAD
> git cherry-pick -x f5442b35e69e42015ef3082008c0d85cdcc0ca05
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023051306-elves-dividers-01e7@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..
> 
> Possible dependencies:
> 
> f5442b35e69e ("drm/amd/display: fix double memory allocation")
> b5006f873b99 ("drm/amd/display: initialize link_srv in virtual env")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
>  From f5442b35e69e42015ef3082008c0d85cdcc0ca05 Mon Sep 17 00:00:00 2001
> From: Martin Leung <Martin.Leung@amd.com>
> Date: Tue, 14 Mar 2023 09:27:20 -0400
> Subject: [PATCH] drm/amd/display: fix double memory allocation
> 
> [Why & How]
> when trying to fix a nullptr dereference on VMs,
> accidentally doubly allocated memory for the non VM
> case. removed the extra link_srv creation since
> dc_construct_ctx is called in both VM and non VM cases
> Also added a proper fail check for if kzalloc fails
> 
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Leo Ma <Hanghong.Ma@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Martin Leung <Martin.Leung@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 40f2e174c524..52564b93f7eb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -887,7 +887,10 @@ static bool dc_construct_ctx(struct dc *dc,
>   	}
>   
>   	dc->ctx = dc_ctx;
> +
>   	dc->link_srv = link_create_link_service();
> +	if (!dc->link_srv)
> +		return false;
>   
>   	return true;
>   }
> @@ -986,8 +989,6 @@ static bool dc_construct(struct dc *dc,
>   		goto fail;
>   	}
>   
> -	dc->link_srv = link_create_link_service();
> -
>   	dc->res_pool = dc_create_resource_pool(dc, init_params, dc_ctx->dce_version);
>   	if (!dc->res_pool)
>   		goto fail;
> 

FYI -
This particular commit didn't need to come back to any stable channels 
as the commit it fixed
b5006f873b99 ("drm/amd/display: initialize link_srv in virtual env")
is only present in 6.4.
