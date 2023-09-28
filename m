Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABD07B23E2
	for <lists+stable@lfdr.de>; Thu, 28 Sep 2023 19:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjI1R0x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 13:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjI1R0u (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 13:26:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA9A1A8
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 10:26:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SGiXcV025463;
        Thu, 28 Sep 2023 17:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=XNgv7Nv5FNfEnJVZeBYpKQhTiZjxPWJKUID2Gz4Ru0Y=;
 b=AGIIwIb5DcIjMnTDGcOYLb1EoqoZFmjvaghvtF6ztQTkNwg12Vz2WHD/442B2i2rRBJg
 HMcTsnjpc7SXizG4DAFICFyjIkx3trSqcuJc4jmo0dgpKKFQjretfv44OCiozjBBV/E1
 y7dBQLggp8++zs0Knu+4H/UfomUA0h5RebEUf3vU7cdOr3yNX5BqbX2PAgWMv/msuIk8
 UKxI1t9bFwxCgevpCTrQ2hISYfUe/SxFBRP9S9WwuO/soktwUlPLy0aLH3Y18HNAx9nh
 wpJKScRS0lY0xdTH9pinjGMbiZvnLp5lX7fMuRJ0ZgfgdDSx4oN297TkCvhUw8LYcGuF gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2d5w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:26:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SH0tIc014021;
        Thu, 28 Sep 2023 17:26:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfae8wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiCd/VGg3zmit4tD3dp6kVGAGDyXnwsEK/xwTwmx2YYlQHF9CIg4lwm0qocAlSKxw6gORCCo/dBit3oyBo95ouHxurIZHVLXgQb4tJ3X407lL3391IW1wUIAth53nfq+7FphH7E3p5uiIHFQNndhUfQ0FVlR1j3jJkvbChuzZqa1JqKCg1jcwyfNOmnzpn7t7hqJI264GgWbUwtDCCQ8X5pLGmgoyjo6/i03MMZZvdp1IKQjTo6ealUjU0lBOg001WYZjYRAaSk8t9np6A/iSToiYAyj5+j6h3+8UO7rgh+dq9foUtty0eYeZ3oS4/gh2m0sPU+AowLuj2OfZPnc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNgv7Nv5FNfEnJVZeBYpKQhTiZjxPWJKUID2Gz4Ru0Y=;
 b=hq5su4DslUpwltDOviijbgZteK95KUufLNq8oQHZ+Wl4L+k3LrLqLOI0Shg9i6zWvi+TMobmOKFvkDWzOwtGD27205b025C3UfNSTorFlHifpdkgzjfovdlL0KCxcnt+1hZ8YkC6xQ/UycRb1niXAc0Xtx4E7ZohpxlIJiB4V+t8+YWgg5cIjBg2ceh6iOAgWrxZ16WZhwZNBgcexwpS2t+VkS6bw/t/aHGjAeaipVUfH9raKWeZZL8j5b0Sb3GUSN4XA8ydbq+604rFLRzy+m5Zp1LkTyFyt14toJOIi8PlLzTVJpSj6qqKrNFBp7gxAhm/f8Q1CYy5jF42OccxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNgv7Nv5FNfEnJVZeBYpKQhTiZjxPWJKUID2Gz4Ru0Y=;
 b=G++k6D64XkJi7nde/jobzyMRYAp3QKaC4JuQbrDX1qCYI9BykAQCgxg6eg+mBcSrP5CW13RXWfbLF9PpeQI+jmo+ocFxeQz5er5DlER/VyLYc/cK3mdRV2fq+KCVBi8zNkjtRTIh/IWW3ek6w2YkREUxX7XQTgnA1ZNPfBkpPQM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 17:26:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 17:26:42 +0000
Date:   Thu, 28 Sep 2023 13:26:39 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     kernel test robot <lkp@intel.com>
Cc:     stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mmap: Add clarifying comment to vma_merge() code
Message-ID: <20230928172639.hmnzdsk3y4snjkwe@revolver>
References: <20230928171634.2245042-4-Liam.Howlett@oracle.com>
 <ZRW1MBvWCCFevIg1@f61ccfac960a>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRW1MBvWCCFevIg1@f61ccfac960a>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0405.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a808a1e-7944-41e3-348c-08dbc048149c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8tq4XumdSq5/Yw3ocmAs+0ogD94L3kIzfS2Cn+awLgQOyFJBRCA1ZU2pm0JJ+65BRaGkGVdIAN5MQyQmB8JS8kmwh/c+GRUK75fssd1jbaTSs6RrWU8tl3FvEoPygtdL8K964Tmi0DyLI7h81WfnzxADODC0k0vW18+ON0OmGu4iBYVZMJaI+BWV9M9650PuB0Qlh3dTHr6Rv3r2BKGFmJila4dQulUrsrNBjwN0qtDIHNsW7W5UrYUnrz8Bg2qQSg7wD4s4ZTzjB5jYtz5GPmOiT3UXw3WSIweDpye5A13LXaEMOJOXY7z9yHD/Eu8FscKriHWlaxRqzoHmoV6xfDV+wszPUNlMXa8KtHj1A+6M1HCVoRN+jcmIUzXssiURL1KhNkTho24piW+968OMOSzANNMlhV72bWZ/LvKraj1YoffU2Xt55kVUDfdeAHNSUWpSnVrHSYsbLODgIfOcuIx+SGx65zCXsk7wwIZV2vZ0eWKptkfRFaRB8vP5uAwrxnSN6ISZbN3ToXh0aQTaGyTsMdiHYvClEQuJzbWeqPzMoROjmK0Ddbr7rIz2SbnEpzhmfowQuerrSMy4PNh+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(5660300002)(66556008)(26005)(83380400001)(1076003)(66476007)(8936002)(316002)(478600001)(66946007)(2906002)(6916009)(966005)(41300700001)(9686003)(6486002)(6666004)(8676002)(6512007)(6506007)(4744005)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g2wIVuAwkbcqvK9g8Kyc7ry1QmncHmEz3FciSPqpz8lBn8hH/FbJNL/cCVjB?=
 =?us-ascii?Q?/e+V7g3XWxMXCysKLUoYiP+7sc+CeUmdTzrps66YY+trf6WXvI954kO5sL+h?=
 =?us-ascii?Q?GKfNs5TJ1TMlLORJY9HcJBueVUjkHX1E0h+IPj39zP7wAAVX0oK2Eq1MrV7i?=
 =?us-ascii?Q?2FX0SflcoEtPAoYVxP3OsScyWmMeBKKRmU7h688oGnZU+iKRWoQAQib4EQDM?=
 =?us-ascii?Q?nsg2ZMiBtdYG2dIkIMkMjAzHQ33LpSp5WTQZIhC2S6PMEYoD0n4NiSKF2EK/?=
 =?us-ascii?Q?s5ebLXOOyro4h1nL+4nL+afgCxfkoEorHVeu29Y4bsESytWKRz6vOJtOvj/5?=
 =?us-ascii?Q?oqFZ3STlzaiFxqsuz2X0+xwuA2qqiDm/IXk3b2EVGcB+R/BDAaHhZg0QM/xK?=
 =?us-ascii?Q?HNRGYxNKQj2SV2y5NNtonQergQRK6MYDpa5o559XJ72LW4y0nAnqseRsVgrJ?=
 =?us-ascii?Q?qzp8T+8pLooJTAoFBhjKTbIXUQZbWmBL7r8coDBF6vuClMYcN/bJw4D1OHlF?=
 =?us-ascii?Q?ubZi2Dgsi4Z95WqfsEq+bHHbdkc9oBF8J0ujLY4/MhkqZIoyhEE5iYEaPl2d?=
 =?us-ascii?Q?QzW7G6qICclQzgJe+AcQIZkaHPncTSTNb6EYI/90GEvBVjZ5d00DWXrZW9eW?=
 =?us-ascii?Q?+LjVBjeMYHjseIMu3fkf/krsV2GcNg5bXRs+gSmcfrvBhzlD7ypS168f3uV1?=
 =?us-ascii?Q?/eIUdlnQ3WKhNpvV+lcFhbp3cugFLHvf85kEFrs55HGfq80Ne5XVbXE2jKUF?=
 =?us-ascii?Q?c6BDsXkmhicYHoMi/tRXeVlYogUD3Zk4TtFKGaBZuRrlCEyCQqWihwSxe/6U?=
 =?us-ascii?Q?W09rRxVZUU5DR5Wm8MGgtLLGDRs2dNtDFGM2qMMUg/G+e2I9rmCx0bdHVXyS?=
 =?us-ascii?Q?cumDVadQ9+ysoKq6S2e0oiNKBCFVaeaUgOQTWzhpsq4Enw8g1R+p2cZGAMUh?=
 =?us-ascii?Q?R9GRZg5zM/OtyORIr9wfHOy0YL2DGqAenvq27WmzzqtSWRYo6qzGnJuI76Bz?=
 =?us-ascii?Q?w6KTUPLwp2xQe7wpAvRrrra6l9CKAvGu2COpmtez7awu8AUPYMK+KKj0qmoc?=
 =?us-ascii?Q?KER1jdqDHDqxZ3YJPIFR6nCU+RnLVeXTb/QRzP1pI+MpJlrIyYwJkpenOMH0?=
 =?us-ascii?Q?CI5V0rH2rKOpWt8a5Zb22PsHrYj0JISaNvAGu7fNJ+6MD3P29EYWMMEfYsZB?=
 =?us-ascii?Q?p2o23IvqqBaIOoXq03wFLKCMARwAR81Q8tF9QYxVnYDl1kaYhDgrajX8WRMi?=
 =?us-ascii?Q?WXrsXSeS+wlMjvKXJBMsf3mJQRzrQWRO1iHeakjsFqNadf0f6pzTsrhf7HbN?=
 =?us-ascii?Q?cdTAMb4YCvKnm7cMz61PhqFBNTrSHwkkLDv9OmRjfB9U+IPXek5rP0kLUMU2?=
 =?us-ascii?Q?guV2gc9ae70dxKsdORXkYJF1j8odBzl5O/RW+HDfMa5LMYw/k+ca5kXQcrwk?=
 =?us-ascii?Q?WeggqvHUeoB3ijLPdXtR4p67e7zV1W6Qw4SOKGigcj4BHFK1oCu0T8J6ryt3?=
 =?us-ascii?Q?7KXY5y3PxjZ34DSCGbAKvRPQYzS5Nd9rZXVQjIJdyB9RzYjkLlTUgLmYDCDO?=
 =?us-ascii?Q?phrN6P4FS1SAu0Q5oslAZk0SWl7LHkiglV3CT8Vf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gfxZLketoL+ypLHt1DkfjJGKXhpF7/tmoa+zUgo4tKcCL4cJuDJTEFiFAiXTti9Vtk8UNxn6MyU9TnhIMZrFhz3seR3B6BwSZUK5KkCt4xdGBBhM+Q4ObfWXc2cbkNKjNO/Tblgx6Bob5icqReG+yh94zW7ul6RvG/2W07A0oPf5WtSK8CpzEEPmLO1e0+b2SQ5R4u6s5zya2D0EkHFhdrHTN6xelOBc21VR0PPj1rBwwpQKFakbjigM3yta9HML2RWSngi81E/es90ipXV/jSz5TUaW6v/k8smz+JJvP2RlJT8XAylQzcVFMaHvaA6aPn1/Dq/DedDXyMlD1SBhPnrW6RyYok1EJKgpXKNKjKF9uyZGtDbv5U0FLOuLudgaN1tSAiXBa1BhaGHmGhAtsrpSrJ/i6nA+e6m8/iPI2u/pFHYoIPcnl2QADvfHE1AaFNMYzeqDd716DobOIodjzplrL1O7gVt8iG/x86v3pJ8rR9ph6GVYqwi3RswameOY3EjgQLQD76H1A54kOg6ferjPItxT98THOrn/2DgVEsinv/8bn7vx0xWBf/a8EcAauUrYT8rovfWOZtBKuGTTHO72kYbTqsQR/VoJi2B5MgsGGRS5JTb02ZpagyuvdMPaIE02bqfVXqHNdSyEZ2HRmcwzrnxmBK3bpakmoTKmG3rr3NvjgO/SFva89Kpq2w7ufMK/vxBkHYw/vVFIz5+t9KtARvO26wUYOgUzUe8HiC6v17FOIHRA5DqQtfVMQoQkSG5qcFEAymybBTC/Tno2SWA/Ff5i/ehLU17aOScMQCHfn/GbF8DX2NldDhCsgHu50PK5OR2u3x3whu5V1vkPdQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a808a1e-7944-41e3-348c-08dbc048149c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:26:42.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLeON51xf+sBiWK+eZnXEIqCchpMJUA0puFcq9HGnuadU+hrbKriTzn25eHa1Zqr5k+4x5o/rF5NI18NgaP1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=269 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280152
X-Proofpoint-ORIG-GUID: oOLyjBIy5QNHLDLlv1lXbbgDx2kcq45w
X-Proofpoint-GUID: oOLyjBIy5QNHLDLlv1lXbbgDx2kcq45w
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

* kernel test robot <lkp@intel.com> [230928 13:18]:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> The check is based on https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html/*option-1__;Iw!!ACWV5N9M2RV99hQ!Oav0h0ZRmSJZ5mOjG5-prYR3nJYyas32Z8AfSgTboijdcVMSWzmyOVzI-s1RuIdzGakIiSzdg1vB$ 
> 
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH v2 3/3] mmap: Add clarifying comment to vma_merge() code
> Link: https://urldefense.com/v3/__https://lore.kernel.org/stable/20230928171634.2245042-4-Liam.Howlett*40oracle.com__;JQ!!ACWV5N9M2RV99hQ!Oav0h0ZRmSJZ5mOjG5-prYR3nJYyas32Z8AfSgTboijdcVMSWzmyOVzI-s1RuIdzGakIiRhQUpN6$ 

Right, thanks.  This is part of the series but stable does not need to
backport this one.

Sorry for Cc'ing stable on the last patch of the series.

