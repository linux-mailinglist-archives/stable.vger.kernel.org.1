Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C93C7DE322
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjKAOyz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKAOyy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 10:54:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEA510F
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 07:54:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A19k16T001599;
        Wed, 1 Nov 2023 14:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=AasgEi7e+CM9+fz8QPoq/qTfUHAbYxHvg/87gwE9KcY=;
 b=ZkV09ywusl3LmRkjznuI+zbNNsYTH6jwiUTJZ3cHlt02gYPiMBUZ0XGzCvhYS7Fv+tI+
 vOI5cJiVmlED9mScAyerSqbTi7aAJpLxv30uJAeir5b5i6YNQH0/uT3ZYDhzLhT4E2Ia
 W18Ikn2aOzNMJuTezX/2t+CfC1Lc0YaEHQmwdbXomViZjIBEN2EwXgaVnDxCPiUd/H+y
 xTtMVxDiz8rOTTPFPW4mXbRUPmYKU5kXBvU+aoX/bQSS1VbcW+ILQ738eJ3Bld6Qf9fC
 2Hz7ACEEQyjJx0RggQxZRMS/jPuoB0+DI6FOVNAP/Bk6W5fk9PBHLkL5GTvCZW2i6w+P RA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtqpxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 14:54:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Dq06x020302;
        Wed, 1 Nov 2023 14:54:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrdcfjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 14:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfBElHST92QMmXtpS0N0bG6mxZnHXNOkgMwCRmjm1Vk63P78wjxX3Sj622/rx1rHMLxAPTAX385wzs1JWhl4/te09SJ9zwqgQgdQRavZillgi5vzycXyuLSOwq5LVW6haK78JMuInuoc5QW8AJH5ZBJqKWGrbrHSa70VpERCWAB/kFWh0/L+7LQwR2vux6Chgo/JjI/qlFuy302EEExRVEzQtbSnAEhcFoq0wshtNQT3QRxZ4Qi3ATCabGmFIIAwBy55sAe6cn9iSDzLdDN+VLxocmWqeXYvwn6G+MyjF6tOQI8SnwfrSur6BzrJzNcOcEj1NDG3Cm4ERaxNXeWwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AasgEi7e+CM9+fz8QPoq/qTfUHAbYxHvg/87gwE9KcY=;
 b=JUXVPaF3T7Tw4Lq3l4SIfLqjpA0Js4/Qcj0T+2odds7hQMTNBlOi6skZdqszB5vk4PGm2NCM236nkw0RHoiaeOR57XgmlzkOz0/St8IwJ2gwtFNjMMBjqUxCOhHQII6t7wduBf/t7vQ9mwK8VevFd2RSZIObCI9pzpaL8dNUTN0SIM8YXBA/lnYc+bhYD1QOvu08jdXXbIourhAJsO/DczM2NPXg0AR7/nh68t3tzEY7mQFDcoIXfYusa+e+X4IRp8DSusdU563kMHw3oGW01FJfSeDypJUfIZPsTi8SU8GnzfCPHBotmfTymBictT/vCakxuiW+qHM7l9r7fZ0yfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AasgEi7e+CM9+fz8QPoq/qTfUHAbYxHvg/87gwE9KcY=;
 b=Jv8Vc9KTPBxa/GO7Zfa73zCyHKjiL4buIG543eHSxFXmUtZ5oXPAUNTrwDuxQctnOBThsoJLgoqCTxKZq+02ZCf5aoxr/pspJVnXcwvW6ou5Fz/2ajxkSJ9voPvbbe430rf9K+1+dpjgIpayUvApGcgkpy+3YUbpKQWYx7Jar28=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN0PR10MB5911.namprd10.prod.outlook.com (2603:10b6:208:3cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 14:54:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 14:54:43 +0000
Date:   Wed, 1 Nov 2023 10:54:41 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, lstoakes@gmail.com,
        stable@vger.kernel.org, yikebaer61@gmail.com,
        Michal Hocko <mhocko@suse.com>
Subject: Re: FAILED: patch "[PATCH] mm/mempolicy: fix
 set_mempolicy_home_node() previous VMA" failed to apply to 6.1-stable tree
Message-ID: <20231101145441.nf6s6quyanrhvyga@revolver>
References: <2023102704-surrogate-dole-2888@gregkh>
 <20231031135111.y3awm4b3jvbybpca@revolver>
 <2023103117-wikipedia-tycoon-4b15@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023103117-wikipedia-tycoon-4b15@gregkh>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MN0PR10MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: f30bce1d-7c49-4a34-ae46-08dbdaea7bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTIxZuK0zss75J9AzNoZsAl2IkjEzLciWELC4mA6l6UBZ7Vyeq024wHBruNUfuHal37743izrKme6zSQ3GqIy4lTd9Kv0HfYk6+PxYyVNlqAtga4UO67PUDF8oniqdWMd4dAZEufrZVzrFlm49Y3IN7Pq8ed4z/CTEXa8DlLj0U/PbTjauN9gEk2I55ZlrW9Cde0kEQYlyYk0nsHgjCJQk+HPvNo63u19NNP4U/xY+wWEktTPkFaLo/LqvDYReTev1GWkl4Y4DtCJqOaOz0NTtnhnTe72w8x9QiC4rDs5StIC2S9jcfkDUnhBKUKQn1XeBeW/lzQWIN5U4fJuOHv2Gh2LORCJKE6ElxD7wkDUxdq4FkOP4PDtF8G2ti0AyhPBFrrd6Tx4t9IC/qD4olkC+0WERwiVFkG8ZvdPpcj69Eove1EQ7QOMk35UF54hJbB2nA4laG7r3V+jP6nEUJomV1Klk7SCA8/+Bpadui4tjWPOej4ah/QI0BM7/8p+zXBQ0+panIhcbnvYpiJ4H/rpGs7FCBYqDNfsmv4JXNuZN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(33716001)(6506007)(38100700002)(2906002)(4326008)(316002)(5660300002)(8936002)(8676002)(478600001)(41300700001)(86362001)(6916009)(66946007)(1076003)(6486002)(83380400001)(66556008)(6512007)(966005)(66476007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?znvfM6YYtrCeFhqSmM098TRLHBNJPeUCTj9hyBvUu1ncjvCNsBp+BRdA0QqM?=
 =?us-ascii?Q?T/6EsqcmLmRwmsJciP/JAGUXkSJwiyKojDMBtyAxYhz4IqPFkZZcrj/U2qWg?=
 =?us-ascii?Q?GTTookVuHJ5Pva983ovg3qsBhwbTJorYj+WWUYQnr+iLU+/DtkcXPXRnoMri?=
 =?us-ascii?Q?hMwdIYpAc77qelQPtChoNQ+pDXQTwFCrgtvsCJgctULVIKlxqA/fxR4HyI3A?=
 =?us-ascii?Q?EDOt5DH/NcI6z4Q24vBmV5XQfd/Vm73Nl7JL9qeQT546ynqKJjmceM+pnweq?=
 =?us-ascii?Q?Ded8ougZxaRq1PG87KGiRHPFHb6DK8VRaMod3LxNbjrBZ89t99dCccs4/wi4?=
 =?us-ascii?Q?X1I2jWwhlRsptgYU6WVdzWcNEEbdXzbmeNpm9a5L31fBPF/j13BKViwBni8n?=
 =?us-ascii?Q?ekn+l5wy6gqXk9UFMoOv+Yv/kBeWe2XcOTy+x1tSePN5AdSZXhrsRD1BdBC9?=
 =?us-ascii?Q?JRyooFWpuc2a5xKJd7yJSvd1R4d3dy4O9jMNwLIlVNkyed0MwllhEwE1Q1MO?=
 =?us-ascii?Q?BaOqC0vPuUMp+kXY6PLoU4G2VDNH1iALl5p/WfGwImLfljjZ3H55Ig+ZL3Y9?=
 =?us-ascii?Q?pSnBxcF3WEzou++aKO+sdiOlYUG/1JTuAEYbWp3NCZFenskm8svsnVTif+8i?=
 =?us-ascii?Q?gBLoxbdcR1ycdFlRgEwEa+5USqquAbV/xcboYRNXj6aKBsC1zz4zi0vda31w?=
 =?us-ascii?Q?hBvMaTmpLp+8/12mZROHT5yu82ek2dOSQsC4wQQKRA7iC3ZD8NRod3UVLbbE?=
 =?us-ascii?Q?Agxw/33GebrrRbJVzfZ1i3FegGpPrQQ4rLg2dZfLekqaLHHlmWRBFx15t3WU?=
 =?us-ascii?Q?xrg8klT1V5qGuM0lWCkj4IRUk5ommpdpSe8iumd9dQOuYh2nZSfoKSTHvXyw?=
 =?us-ascii?Q?1ZI93/X588gg3CN3WWJyyqybmTTO4Ecw52+pqlOxKZf+V+b9m/h/9PpQ0EgH?=
 =?us-ascii?Q?//0sLv2S28vFA1dLs8kO+++iDCS89eAo4V6tRGvapx3wD53rr840HO8g+B1a?=
 =?us-ascii?Q?u0jUaOmwXXg1Gw0Utmly7zfDYrTIJflFBvMBjgc6BiU4x0yJdi70uh/UYqhr?=
 =?us-ascii?Q?5jbV4x16j4DAPgDPngOfs34lLNSuH3BFVXyQGiyCYGbsK/dcaOt3rpMHNOCB?=
 =?us-ascii?Q?Mu85Ui/CX88v7guHyQdhNQOiP8LnLqmQiyCKrVvcxvanStOxhawLr2t/m/jl?=
 =?us-ascii?Q?f3gHF0jJtcO5ivBwLj4IszjgCJi1WJTD1RuMBNSlKp9iaeYUoVdph1FIP1xH?=
 =?us-ascii?Q?WijhAK4Vt0UtWXV2n9TwXSco0yM1qlWcnHN6yngcMpSPQHy6bimon3Isrw9U?=
 =?us-ascii?Q?Vd5WoekD2jehdF6s3FNlL2Es9l+ovFZpWuTyegTQN5vkUusQpmJSx+uoHWNb?=
 =?us-ascii?Q?lKbVzZ6EBaDBXsmHb6VvZMMHGtqfaj61wUKFlrv81u3oXmdDC4DEt+stkPma?=
 =?us-ascii?Q?0lGNxkgy1zi5bmJ2YgB9Ag3qnTr1Bo+MiSJhpHH/N8ytu3bDnpcSu90N9BDX?=
 =?us-ascii?Q?bDy0WJLWnrIMDqnUdk4w0HfK+NGCng3fAEPutJMLgGX/eRV1Ver+uOgHUiPf?=
 =?us-ascii?Q?ATdTeZQM+HIrnfqerX7BL+EPbmVoFxQl4MEHl0Oz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9qp3mrQi0rGr7xA/mPCxDa/oGndf91vqEhXRM8dXz1+LmEFDNPC9f9FJNRNyaatiRdTJgHRuYjh81uE6UHnO6eMRl0yrr7I46ThT7Yi2BpI3viPkDHAw10D2c5kw8YQd03Sp1ygIk7yBnpon3RExzXv5Clri/v5VbQU5+4RcxrZRvncfPAejLcQmtaaiMX4aR4dmzE/SZN+usFI3Jpomf+4gXvOdptl0GWSsL/BK+y6FckC8xzQBDj69Pp/2EfL2L4wBsXCcmBbkez0RZqwpNO6hJjl/tTuyn7LvOJsbtR7bYKRCbFM7m4oLg/zqYThK6LLv3Luj1sLmkMAZtsismj3g/YW/hskymR4lZKJbcAUfrRn0xEerQpKT4vrxtL0RX26ZsSwCzRw9CXlpa1mD9PRto1HP/u2+JxNJHoV3BoIgtEJ5/mrKIiBVoJmvA1ufIeHU4C0nsrN/H5QP0XOhUuM0qCw5EzlMZf2/HPv49ZP6wk7x6+HU/ANBQwtFQZSWpkMbmVjH3pyed3e5GEsUNw4Jkip8LNA4vWwVExuLyFqmFCd/rmFxHhD1Wj5GJnBsuDkg3HZyIFOIImyELTGzdsO5c27nkHvVEGbTVawcTwDzc0bBBvrK6EGgzx3BUUauP3pGtT6hnQ0AIsOfS2Gzx9ljh5wndnENhhj2v21ltMenBs02m8k+kAwZAm6XeCgL0xZ0XtJh1AcMK8Si2qA/wtypxYReSm4UznLkx8VZrSi+GcGYg02j47AAqxmoC0fXXU2DdEpHGtH61dhqE7JvcA7mi3Ik5Ge9hYqtfSWfLUEJwei14O4ADaxjP33cZufMnz3fWZc0PbN/Cs9x1kyBWD80FYJYtayqHdWiBCfty+r8rLjWtZOnl4qg2RVT1oIJMr75ycjCYrB3OfCZ4V/QzhJkSeBCIGB4CVKMIGo03Js=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30bce1d-7c49-4a34-ae46-08dbdaea7bd3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 14:54:43.8943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNk0STBwOmqVmAH02WDPnuz1hwpZrnwmo5jLYwA6jJt6iv8n4reC11HVneKBEIaASfRNj/EGzoPITGp+fSGHoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_13,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=736 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010124
X-Proofpoint-ORIG-GUID: -Xo9peVQJCLYHhXeQ1T3iA4GtLS-40uq
X-Proofpoint-GUID: -Xo9peVQJCLYHhXeQ1T3iA4GtLS-40uq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

* Greg KH <gregkh@linuxfoundation.org> [231031 10:50]:
> On Tue, Oct 31, 2023 at 09:51:11AM -0400, Liam R. Howlett wrote:
> > 
> > Added Michal to the Cc as I'm referencing his patch below.
> > 
> > * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [231027 08:14]:
> > > 
> > > The patch below does not apply to the 6.1-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 51f625377561e5b167da2db5aafb7ee268f691c5
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102704-surrogate-dole-2888@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > > 
> > > Possible dependencies:
> > 
> > Can we add this patch to the dependency list?  It will allow my patch to
> > be applied cleanly, and looks like it is close to a valid backport
> > itself.
> > 
> > e976936cfc66 ("mm/mempolicy: do not duplicate policy if it is not
> > applicable for set_mempolicy_home_node")
> 
> This commit does not apply to 6.1.y at all :(
> 

Sorry about that.  Yes, it looks like it is probably easier to re-work
my patch.  I'll take a closer look.

Thanks,
Liam
