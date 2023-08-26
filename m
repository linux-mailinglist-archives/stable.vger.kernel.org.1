Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FF37896EA
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjHZNeZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 09:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjHZNeY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 09:34:24 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5FF2110
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 06:34:22 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37QDLjU6016460;
        Sat, 26 Aug 2023 06:34:02 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sqgwk8576-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Aug 2023 06:34:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyNuwPJ8iNJHNHup1RDiPJ1wRMfDjwh8aIwLxilFMpx+zIw8Hz1TvyLmcRoWjomNXgfkarpWZbahA0lXgMaQT+xfMNkIZ1quIgIKXk7G5yibnsK2kPr0RZhMDV8H0wL2Y2TVvkp0eA+89Gdw4NXkxkzDIFHnjUMk2D5yoT3/IRAQA6zgL3QFXRaL/Fpq2pLdW9sr9jPQBChKf8hoOjS/HojZzKhO/oZh/E8agi7nw/GZWO79/KdSIs1XlA+d0m9+Nm5ZGWxZuc1Hr+dV05ga4skNQUZR1MDInyNEfg1PNvKpserKgpLbcgGAW5nmughzB4jfbajJxnkKZiOv9xb/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M02UY8+f4wnDfWvQO4u/VaNEnNLFwP6b4tfLSQ7UjsM=;
 b=XJtpgUKRe6HF7xc0sgqrF+JpHjg23MtzMiFHRih5S3EWuLqctX1iMkQZ6YLX3/JUdhw6iSdzuo2QpzV3KmRf/x0+6EZZDhwIwAFnrMWL+uXEqy+aLbpbvAFFBUbvZOfQRpqdlBz30r1wqTlsQaqBZ3gaOidM+3lziUWm14asvYj8D2sNpxcn3vbLgRbgx/q9nhNRpjixOFNOdgE/48pkdf3mv/pgIDbJJstS+k0M0ZApWc/+1O99hfmknCcukuchkC0ozEX8wO+wX8PTHQMg+1TQvzcIPbCzNVblEjK+XhO9f6JqbNTmWd2y1QAZPz5ysVg8IZAgmYynwKMC48c0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M02UY8+f4wnDfWvQO4u/VaNEnNLFwP6b4tfLSQ7UjsM=;
 b=blLuAjW+k0iy2xQkuy4gyK8I2O2k1knKjRIP9gfuByY+6h8PkSUO8lLEHfmfYefAA5svd7N0ppdRcLHmAdV4Hi4dS/b5LFoq/zQ5mnDz2vUEEfgSgCWliBAm3D5W4z7WetCEwmqaXvIazBsiF0Hv1huSUDlTO82ijGlXoVpMSMU=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by SA1PR18MB5690.namprd18.prod.outlook.com (2603:10b6:806:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 13:33:58 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::662:efb1:8152:2052]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::662:efb1:8152:2052%4]) with mapi id 15.20.6699.034; Sat, 26 Aug 2023
 13:33:58 +0000
Message-ID: <6aa27627-2e1a-6fb2-caa8-843a3e97b2de@marvell.com>
Date:   Sat, 26 Aug 2023 06:33:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] mtd: rawnand: marvell: Ensure program page operations
 are successful
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org, Aviram Dali <aviramd@marvell.com>
References: <20230717194221.229778-1-miquel.raynal@bootlin.com>
From:   Ravi Minnikanti <rminnikanti@marvell.com>
In-Reply-To: <20230717194221.229778-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:a03:80::28) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|SA1PR18MB5690:EE_
X-MS-Office365-Filtering-Correlation-Id: b028076f-245d-44bf-7a91-08dba63919d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09PBPc0k38oCGme0xMoPvqOvL1vMip0mBSkepdIRTq9pPcacx56pbPTSYt5J34ZfXyJzsCvNgnBFnC/Ew9FokNsqPzei+lrQmuHmSoNpD24i+GPg5835rslqXC1bd2WXU/EgD1FM0WEDbwvBPl0Sur205nDQuYrRgqBRn5G2h3xJTvuCKMOaCyXwhpRHwZDGHqWR6TRo+LDc2trK/mdNcQowEwblj4KAtZ1rUETCifnrnhjO5lLBtV9SJ/SDNFRTJjBS2s7w0cqa3qU09P//Xl9xzo07qEMDNIZgRZ313Ch79xy4FcSqJ+3tQy19zidkZ2gczMqZcd2FAtPPHLsfis1rrw1VtlCfEF57eM3jiWOMnswj/hW5vsjGMf9dZ6dtgJ8ud1NCR8w55NFkAczDJ/jgWyNyTRx6VeFq1PK94xW3ItVOTXxvxntl75eG7bym7Mu3/QC6ePGtBKxMlN+kukaxG6qRjdecfZAz6Xq+Lcb71BSpDYDSGC+pMzRHrEExZcGmQ1qxSFtW6+5P4xTDXF4X1U7bmpxO8XLOov0dhtKEPNRZoRIjY0ZZj19oVOR4JvHKGfTxlcm7D0t+aBvEk8PiAjpMyBqfsv1aIgRWN6gYDbLHQpdY+ZupfsN5IjhHt6F6WME5j2oRMAQeb8DIAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4451.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(83380400001)(478600001)(26005)(31686004)(66574015)(2616005)(6486002)(6512007)(107886003)(66899024)(53546011)(6506007)(6666004)(31696002)(86362001)(5660300002)(2906002)(316002)(38100700002)(66946007)(66556008)(66476007)(54906003)(41300700001)(36756003)(110136005)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWNxSEhManYxZFBGZDlnRjNvRndFVlpDWjZGRjVmRVJ2YzNJVVBTODZsTjA0?=
 =?utf-8?B?Z0x6bWNjWjBpcFZGdm54MVRqOE1TdTNsN3poalY0YjVSSnEvYVk3V252RitO?=
 =?utf-8?B?RTNqcFFMVyt6ZWJCb2Y2YTFSaGtCNVF0QndzNWpkcFZBNy82YVhrRUdpR1JB?=
 =?utf-8?B?eWlVb2NTQTB5V1RrcWRod01odUJJMjhLSlNWNngzRzgyaVJMY3dtS1ZFb2xS?=
 =?utf-8?B?TmRWU1I2NjI2Mk55TDdnQ010SzMvUVJLcUdHSWd5WGdBTFhiY0lNZFlMTjJQ?=
 =?utf-8?B?NnFocXdsM2dEcnRWc1A2ZkRGc3dKUGpPZHJVYituTUFrUGFmUWVEQmJieGV0?=
 =?utf-8?B?eStEWmRKeHJxMm0wSUxvQzMzb1Q2amw2SFhVVUxZeEx4TmxTaGpwdFIrS3Jn?=
 =?utf-8?B?U1dkeURUUTF5V2dIYmdLNndQNDNyNzFLVEtVRzlnSjlnalM2SWtFdzFYQlJG?=
 =?utf-8?B?dFlXSDFWVHlIekR3UmF3NDZFVG1GSWdBRlJLMDZCYXo3VFo5OUlMaGFRMnBZ?=
 =?utf-8?B?N3hHNXg2MjRFMjRJNmxROGV6YkxYMzc1MDFPdTJaLzluTFV1YlVsc2l6R2U2?=
 =?utf-8?B?VVlKUVFFS0hWTXlCUCtEN0RuZUo1M1VrN3RPNHN1a2t3ZDFOVXh5VitkNUpv?=
 =?utf-8?B?RElSYUNiUHc0Tmw0czdBVXRKcUY1VDc2eVlJaEk5Sjh4azF1T2VuVGJ2eDdJ?=
 =?utf-8?B?UTNBNTdXTDQ4Nmd3ODJvcWlhOTg3NmZGNmsxN0dNS3I4dkVGaG9GMGdJNVhS?=
 =?utf-8?B?NllSQmFVb3hxNEgvTTE4Mkl3bTVYN0IyeFA5L2FXVU42MmdoVUo3RnAvVDJR?=
 =?utf-8?B?VWJ3R25UdWRsRytJV3VaMUFONGszdXpRZEY3Y1ZGTXdXU2ZCeHFIMGZmcjh4?=
 =?utf-8?B?ODdYY1NYdG5QVGZlc2p0UEQvT25sWHNSK3FENFNBTHp0a0paYTF3bFY2aUhU?=
 =?utf-8?B?MVBoWVo5VHZPL09aQTJKMFVuTU5ZMnlWZmlpaVd2TVpDU3greXhFbU95QkF1?=
 =?utf-8?B?Q1J4WEk0VHQvM2RLYzhRUGpNb2FIYWFTbDlrd0g2eFh3bHN2SmhPcTJMZURV?=
 =?utf-8?B?N09ldzQwdk80QzFkVnRudGRBUW96TUdxNzRFUXVuYnpsbElCOWxESG4wZGVC?=
 =?utf-8?B?ME9LR05LaHNpektobm55QmNZeWYxb09uVWlJazVrRTJLRXpTd0RidmhVVEpt?=
 =?utf-8?B?cWpCc2d4NEFyamhLaXR1anhSTy9YODV6Ymk3M1o1TXEzRTFJcmJzZG5MZDdT?=
 =?utf-8?B?WVBNZVRSQUU4cEhKVXA3S3AvcGFNN1hHcmpZTG9WNmVLdG8rUm5HY1hoQm9a?=
 =?utf-8?B?TUdsZHg4UWFCWS9ucnZ4VjE2cU9QOVovYjE5c3EvdS9UbXVsMHFmS3FMRW00?=
 =?utf-8?B?VjQyYWlvSk45SHRzQ05YL1E0Y2didVFRQWE4aHZTU0gwTGc1UWkydUdPeGhV?=
 =?utf-8?B?cUdXR25jUG53VENMOG9iaUdydVhaTXUyV211OWtrdDR1SzVzVEZpWWcxbGVP?=
 =?utf-8?B?dDIwNnRlRkdxOEYyZy9ZU2crYTB6US9GZ2IwRDdSNExUMGxvb0JkbnJta21L?=
 =?utf-8?B?VXRGdGV4NDRGY1p6dU5idFhMaGxINmxMMitXREtlQXRoS1l5S3ZFaGpUL3Yr?=
 =?utf-8?B?Rlo5QURsUFpRWUJMSFFhZFYvQm4zL3ZXdS9FZmcyWU5qcDVGUm1jb0FWU3hH?=
 =?utf-8?B?dzgrQyt0UlNaR1k5YVV2WE5qR05yTFVkOUYvMmpLVDVvTlhmMUxreHc5RDRJ?=
 =?utf-8?B?dzdnWTZXTE4xZEttZGt0dmswZGlPKzBoNXdnc20zR3k5bWJXVHJsYlJNUzEz?=
 =?utf-8?B?d3hnK1kvWmR4NVhIdnRRR2h4NS9qRm9QcGhYUkU2V0s2RmwvU3BIbndoYXdK?=
 =?utf-8?B?RENLUEFvY0Znd0pQb2FVd29ycmhhSDNlbmJ0Z1dKZnRmTFJTZHlyajFSNit1?=
 =?utf-8?B?VFBuM3FuRzRzNTdHbHpQUzFyLzR0TmRZVWdaZWxkWWFZYkR5OUVYMTlka2FN?=
 =?utf-8?B?ckM1TE1UbWIvSVdpMWxkdThaekwySzdIci9QOStQZmR0RURKK0pUR0Rwc3Zm?=
 =?utf-8?B?STdwSnZ6V2ZKcUpsMW9YalBySERjcWo3aUtCa09YM05BUm0xMy84R0ZiNFBH?=
 =?utf-8?B?Y2xVY1Fta2Eycm85Ykdhck1scnU2WjVoKzNKU3FFMmtPOHQ0YkhyREhqdFhR?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b028076f-245d-44bf-7a91-08dba63919d6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 13:33:58.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5a0hm+iTZ3m6oC1V+kFN2AtvWor2P3QFro1d0+pWQJXF4sGphm/jgUiSar2iPWSOh+j4i0r5hzmFzda4RFrtsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5690
X-Proofpoint-GUID: MXghaSJV-d6atdF4U9ZkqM0VA3jqKg7q
X-Proofpoint-ORIG-GUID: MXghaSJV-d6atdF4U9ZkqM0VA3jqKg7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-26_10,2023-08-25_01,2023-05-22_02
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 7/17/23 12:42, Miquel Raynal wrote:
> The NAND core complies with the ONFI specification, which itself
> mentions that after any program or erase operation, a status check
> should be performed to see whether the operation was finished *and*
> successful.
> 
> The NAND core offers helpers to finish a page write (sending the
> "PAGE PROG" command, waiting for the NAND chip to be ready again, and
> checking the operation status). But in some cases, advanced controller
> drivers might want to optimize this and craft their own page write
> helper to leverage additional hardware capabilities, thus not always
> using the core facilities.
> 
> Some drivers, like this one, do not use the core helper to finish a page
> write because the final cycles are automatically managed by the
> hardware. In this case, the additional care must be taken to manually
> perform the final status check.
> 
> Let's read the NAND chip status at the end of the page write helper and
> return -EIO upon error.
> 
> Cc: stable@vger.kernel.org
> Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
> Reported-by: Aviram Dali <aviramd@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> ---
> 
> Hello Aviram,
> 
> I have not tested this, but based on your report I believe the status
> check is indeed missing here and could sometimes lead to unnoticed
> partial writes.
> 
> Please test on your side and reply with your Tested-by if you validate
> the change.
> 
> Any backport on kernels predating v4.17 will likely fail because of a
> folder rename, so you will have to do the backport manually if needed.
> 
> Thanks,
> Miquèl
> ---
>  drivers/mtd/nand/raw/marvell_nand.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> index 30c15e4e1cc0..576441095012 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -1162,6 +1162,7 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
>  		.ndcb[2] = NDCB2_ADDR5_PAGE(page),
>  	};
>  	unsigned int oob_bytes = lt->spare_bytes + (raw ? lt->ecc_bytes : 0);
> +	u8 status;
>  	int ret;
>  
>  	/* NFCv2 needs more information about the operation being executed */
> @@ -1195,7 +1196,18 @@ static int marvell_nfc_hw_ecc_hmg_do_write_page(struct nand_chip *chip,
>  
>  	ret = marvell_nfc_wait_op(chip,
>  				  PSEC_TO_MSEC(sdr->tPROG_max));
> -	return ret;
> +	if (ret)
> +		return ret;
> +
> +	/* Check write status on the chip side */
> +	ret = nand_status_op(chip, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status & NAND_STATUS_FAIL)
> +		return -EIO;
> +
> +	return 0;
>  }
>  
>  static int marvell_nfc_hw_ecc_hmg_write_page_raw(struct nand_chip *chip,
> @@ -1624,6 +1636,7 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
>  	int data_len = lt->data_bytes;
>  	int spare_len = lt->spare_bytes;
>  	int chunk, ret;
> +	u8 status;
>  
>  	marvell_nfc_select_target(chip, chip->cur_cs);
>  
> @@ -1660,6 +1673,14 @@ static int marvell_nfc_hw_ecc_bch_write_page(struct nand_chip *chip,
>  	if (ret)
>  		return ret;
>  
> +	/* Check write status on the chip side */
> +	ret = nand_status_op(chip, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status & NAND_STATUS_FAIL)
> +		return -EIO;
> +
>  	return 0;
>  }
>  

Patch working as expected. Tested on 3 different NAND chips.

Tested-by: Ravi Chandra Minnikanti <rminnikanti@marvell.com>

