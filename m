Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344EC77EDBB
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 01:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbjHPXP6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 19:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHPXP0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 19:15:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BED2690
        for <stable@vger.kernel.org>; Wed, 16 Aug 2023 16:15:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GLENBV022386;
        Wed, 16 Aug 2023 23:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=J/jW8yInwmm4ettxADYrbbVBEPPRJ5y1gXpXtFAV+Q0=;
 b=yoLuOKwdU7nwt7UebQRXy7reJ5xV9ZxVxmpMouIdX2jkJ1gIRiYgmfHvaSw6ZaAKpaIN
 Sn9ZyFnrhbFZkm7Hb1yU3EIUjH2bwuiqOMNsM7aS6BsS87F028wTWSaCagODlph+Z45k
 yX64rp1q9sG3DZ5ioU/or3YEIZdVF5N/VhCZ9H5zsl701sByMYy1MDXoJoZON6vO3Hss
 dEAbZkjKGzXSVx+k0KSK8AOJMlMrcbYQXVWR81apSLtZsMzLbPhqUwnewOuiGllz9fvg
 6FMLQt3TvjGo48wX2RPz303jl8GFsjn46p05mdBJ7vheRNHGXSXrTYfTSBjacoHDKIBF 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3148b58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 23:14:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GMmPlw003743;
        Wed, 16 Aug 2023 23:14:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexykw5tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 23:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuuuaybhCRvIhI+AoN7CsaVHOlE1cq82FSFjfzdhJiPZO5KcIlENwvXlOd5+8/7/27XKpqXyASg0mS9DBf7Mkt2kEFOaudKo4s0n27ma9hVTBWc/npD+/GsClK+q3+Kgzmws2gO+M2DWnKUEoy0J/ZoRprJKLK7ucl3Us43YMf5ymOuh31wuwRRDL6N5mgaWvfnLkskVkt/pZVFSBSbrmATCOyJ2N2URQzKfh1Zo2u7Rtqtj3XLZ+ZNC5v2sBOWuZeP4UjTL5ziThAAsVyhZRN+/hdlYG4TJWnSraKe6TMkS6YXJWYokHXPZhWC9zK/96KpUcIYD7wWtCPrPFHcBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/jW8yInwmm4ettxADYrbbVBEPPRJ5y1gXpXtFAV+Q0=;
 b=Gt1lUwJV+n5tHd2EymUBiMWXzSVvi5Cn8PWC3/0K7aihl2RGtfO+rIw4UXAYMdVuUSJPjfLNWrSNMcborEc2Ov12bkgShPgjDa7k96P8duk2VflsojA/eOhhiCteXOISEykfcVhULnvtjU9/ujODjE+UKqa3UTF0s2X/z+N6NIY5lEp3w12G/dujz3ordCh6dJ2HKMhuXGPAqZIxBuYVrkZqdh/5SeyVGa/kg0KUwY4/iEBuq6BybhSSoVQ4JFfxJ4klmReFc24RMKO1PGnDTsUQ9JUMK0KknBjJxqCUoAYdKqkDyxP4ueLf12G8VCLsnc2s1f7kQ/NRq/1f60E35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/jW8yInwmm4ettxADYrbbVBEPPRJ5y1gXpXtFAV+Q0=;
 b=SmjVqNiVJSZv/8n3wrUYHxg8rn52RDPkqqni0/FxCf3FBEqLojzoRGklquwpdR0s3bO009OQA5D+y4dTpzSzVDLuYLkwG+RrPkWFmBMEzp90MANsIMBcqOq1OOk+lIH9qvjRAO3K4nf3m36GBf1phbZe7VJnu4aKEatyHjYTA8c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 23:14:41 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 23:14:41 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     stable@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] hugetlb: do not clear hugetlb dtor until allocating vmemmap
Date:   Wed, 16 Aug 2023 16:14:28 -0700
Message-ID: <20230816231428.112294-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023081202-unloader-t-shirt-eb23@gregkh>
References: <2023081202-unloader-t-shirt-eb23@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: a377c105-8a29-4f07-e67e-08db9eae9187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DeLObwr1yc/3extUhvMSw+6pbPLWOQ1MLbKV9QdzVGQjCTOxmUv7fPVzvId1sbChS+eM92d7XTkRnaviaJe88yGy25pw0XwEktScXk7BaKGr4aA67P2aH35R3w5tF30LCkWJvVg9XB/vc4nZ76Nh2MZG+EtiESlNDk+4HWhCWSu3v69btX9AOEW+PyJtUJKXgzX2b4h9/snkX8HP5u9bYGheqsovY0JruvuEnGS9Gwrod9rOOkgUSukkOoEGI1Ea2xTe/pFZBKdI7ASyBLDQfnBKm4FW+sQi/RzttPyJtk9TLHwJD1YQxWAo2WUj9QYO8PZfQK3a54lC6YmZIT8Yp9rHDA+ubHSNKabla8mCL9zGFLd0BhgpxAq4J+Vn1GQbiSNbqxHUrVSJDfY9O2gliMRfanHJxV3v2iyHN7bzlnq5Z7XzLvb4qTiQtmzw0W1fCr+gjU5HYZh+7JC9CXBw7Th5Yl42ZVa9Dalv0Tgw2nJZifl/JZ2do6jIypizTSv7qQjQeDL+JQ+eZlmgn0p6Bwex2qObe0fC5RG31geOT2cL6/W0DXd/oMT6kWm+b8wDPQE3O2XLn0odn9rMy9LpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(1800799009)(186009)(451199024)(2906002)(2616005)(1076003)(26005)(6506007)(86362001)(36756003)(6486002)(6666004)(6512007)(38100700002)(83380400001)(478600001)(966005)(54906003)(66556008)(66476007)(66946007)(6916009)(8676002)(44832011)(316002)(8936002)(4326008)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7NfL11cC8xbEtT+DYcxtBJTVcLJ6HB1+7fCTI+9ADmKeGEGAU3xx0GTO9jUy?=
 =?us-ascii?Q?kjKuTAURJQFEAnQa03QVaKu8iQU9O2x5xXn/InT98+7/mcc/ENCOvLp0a8Hn?=
 =?us-ascii?Q?xPOPQXAdGeFjQJHrBcGw9k+3JffG7lmYkZfsz19Sa3QUHNvtz34ZcmOqEWbE?=
 =?us-ascii?Q?w0F1MyMtIBj2TxY9mZvNI5F42KUHG7uC72Kq5t7GV/dd9HOUBAk+xmAan3ul?=
 =?us-ascii?Q?Ivg/cEsbKsTH5mVnv2bB1MjI/+1pvkvdUaCBu4+qXkrHS+i2bhqK0N3uVeMo?=
 =?us-ascii?Q?hFDLblS8b9+EWHAllNSOynWO6ke6MKjb0pMU177ErcPAhrvnTjd96HtFj0rq?=
 =?us-ascii?Q?bKT0kUrSIKJy2n6tLYo0Vvko6JPAgMTshHGOzn7GfUl0B43BQxrsNtKOHpLM?=
 =?us-ascii?Q?a2aQA6mwSo7r84t328Gsx4YCo7+TUbyTF6GkYjCfVaS2XfnJq1+yDbsKotsM?=
 =?us-ascii?Q?OQS9tzeqlidxPgxHVlfmk2nIU+oNBPPNPniFu0eePq4b4lapzxJCiPmFByI9?=
 =?us-ascii?Q?nnYE8EbLmWtPjQk/4Ap1PRINrB/7HcQ9bx2SoEtFNNZ1AxxaSCDpQSgLXdhk?=
 =?us-ascii?Q?KPovx+pLs1pfYSusOQ6rQya1z+W873Zm+UbBSl5ha0DEQA9lya53yPhU9bB6?=
 =?us-ascii?Q?Qk4cO1Xr0CbCjsvoRETtUjv76WjhE/DlferHlhrEkFkWR2iyh2v/ri7u/6ml?=
 =?us-ascii?Q?38QVB6LIhnP4l+QRalZoCk/cn6uw7npBZ3Es2OLj3TcTKCMYVOEVEdP2UdqY?=
 =?us-ascii?Q?qA8DdpKM5w66TIgvpW7ShuySsxK+ybUGjJTvrRkC/LKubfCopT7bozFtaL7l?=
 =?us-ascii?Q?PXNiFwblHig4ubkBNX/kYhaLaMQqmxMZdaBG3pY0yKg2ZS5H4QpGwmtrGbgz?=
 =?us-ascii?Q?g9a6cTcO7ezooMxtZTA+hBkqHkoTOS6gCZ3bjw7Y5zvNUWaopD+InNSKpKOd?=
 =?us-ascii?Q?MTr6Z+/eb09cP8MLOHTvz9LjZui+hDQLRbH3UWl0BItzjmlUZggzv26MOWZT?=
 =?us-ascii?Q?/YxqbbjcOMsKVIacBBajCGV9kpNiGMA5ZtczwNfmrL8D09qpMhd7XdIWuHTW?=
 =?us-ascii?Q?fnr5kCT/BbQfx7cJjmbJfNKHyta4qLxbcqhRyQme1fvVP4IPubSmRApn656W?=
 =?us-ascii?Q?b9KE/895fRX4ceopVNqM2rX5aIHGR5r9TnFIewyGkS+ovdd6g+toYr+m2L/z?=
 =?us-ascii?Q?QtU9GdsVuu8RZ6RE3Cgi3AhChUOZwaLRlstoleHxuqh7m8o8WpRZEiQ5tfD0?=
 =?us-ascii?Q?8qWN1Ss34aetCpE/2in8ljJnVwz1dHa++zglZEV1w0kflZ0LBnGHTcZALYpC?=
 =?us-ascii?Q?jWkffdRlzNTHADWKMop/F7M7zBvMWzAkGFOtJ5fKWIfdLLDc7mvx9zfvSkj3?=
 =?us-ascii?Q?Yr8pP/xjIucINn5a1LpaMeNM1+ddFfl3KgzE1QCkkVbkEgASmu0Mv28As6xK?=
 =?us-ascii?Q?nM+Cyy/eXN06GOQva8SFDxFe9DEMC5Wc0MCycpRZc59AulOtcKARH/cQ73v8?=
 =?us-ascii?Q?h3g3hfYa0fCucQZAYv4yth72SDEnLCrSy8ko4bDx8SFi5gA87EIuM3Wjd2JY?=
 =?us-ascii?Q?xRT8EIPph9zIAUmUzlpOsGk0jhrKLmwJ8Zjy6wJkaQmWtK9g9AA5QaNH2HT8?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1SWqiKMgOmFOFpm2ibB1AXuWXpZnsaP7qILdjLzDzJH9fNPwV9BtxFA2h2gK?=
 =?us-ascii?Q?YPU04BpL9mGs1xxwShHsrnESRT62hUr2MSjXENInaUfsq6mX62lcTKA356/Z?=
 =?us-ascii?Q?Z+0HCx0gjaKvPx2ni/mdQH0n+HynRbqkb6TcXIxwIMDp2lS5vpH9TMsGbnGx?=
 =?us-ascii?Q?UjUiydZmalhHhQkljhirQA4k2Veu9SKprfVA9qLzxOXf2mjnEVr/AcOAnOF0?=
 =?us-ascii?Q?b7ULyD5Hgoz2VXsf4pFk/7x6a0bFquGSgkTLQQwNW4gUNH1sqGOKq550iFrg?=
 =?us-ascii?Q?P5VEuD7ljk96Vzisob9UyVnRuz26ljmBUxXBbT5VsyzcCkcyxKFogOEq6Ch5?=
 =?us-ascii?Q?j9C3MLER0WXtGUMKRcoY0WjQvCFiB94pD8wZk7xqsSEqfiea98rkS4t+azrT?=
 =?us-ascii?Q?D3BNXKW8LaRS+VCsNcSNq+juBv1GEF9biV6ULh5wqweHqY+H3OgebAyaKp3h?=
 =?us-ascii?Q?cPKJ0fQX1uhRbzwMkFdzvdHJ16Bytqns4n1+5W/kWekyPgqT17ifwBDKjzML?=
 =?us-ascii?Q?IA6drbbNcaru6puuGL82D6oP996+ERzkoOsEOBqfcoglZeMyIYTX890B8Vun?=
 =?us-ascii?Q?GM1wQhqebFt48Uyt9KPMDoPlXvsfMLHMKBFGmouzlTR8aPul7YUDehrT0VLs?=
 =?us-ascii?Q?rOrw8EesQlPmyw/+Jse7Du9CdibV2dwtTc5FHAxS6JAf5xIvcDoNhsr5Lxyo?=
 =?us-ascii?Q?zlxNt4D0sClG/AjfhFqdL0uk7qFIAVkZ3gwO9I8ZiAU6hysEDGmc7rDBcxEJ?=
 =?us-ascii?Q?qrPbkyZlBlgcYudXCxfLzryUn6gI+eoEquqgi5PvkmuWjsKzLQnRn/s2j4fT?=
 =?us-ascii?Q?e/QYfzRXfw9y4yp0aUr0RUqENSDux+8XxoKAf/TeqSdk9h5UyeHDL4IJapR8?=
 =?us-ascii?Q?kpVsepBk6nLxaQ7Sxp0NtL17jIh//IaridLBv/LeHphLHL+nlKeaotU5bqLX?=
 =?us-ascii?Q?DpnnP1wfPNCczV5aLoIrAA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a377c105-8a29-4f07-e67e-08db9eae9187
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 23:14:40.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AXdSVXosdWNL9dKu1BCboH8vngl+FUlAXuNZIh7215CRlPFkVqHIYtJIEtrAcCrQmabeoj6Zd6wTtxp2cFAlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160206
X-Proofpoint-GUID: 1vpG8oi_J9HGqCLGKOIouSo9mdb64Gnr
X-Proofpoint-ORIG-GUID: 1vpG8oi_J9HGqCLGKOIouSo9mdb64Gnr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 32c877191e022b55fe3a374f3d7e9fb5741c514d upstream.

Patch series "Fix hugetlb free path race with memory errors".

In the discussion of Jiaqi Yan's series "Improve hugetlbfs read on
HWPOISON hugepages" the race window was discovered.
https://lore.kernel.org/linux-mm/20230616233447.GB7371@monkey/

Freeing a hugetlb page back to low level memory allocators is performed
in two steps.
1) Under hugetlb lock, remove page from hugetlb lists and clear destructor
2) Outside lock, allocate vmemmap if necessary and call low level free
Between these two steps, the hugetlb page will appear as a normal
compound page.  However, vmemmap for tail pages could be missing.
If a memory error occurs at this time, we could try to update page
flags non-existant page structs.

A much more detailed description is in the first patch.

The first patch addresses the race window.  However, it adds a
hugetlb_lock lock/unlock cycle to every vmemmap optimized hugetlb page
free operation.  This could lead to slowdowns if one is freeing a large
number of hugetlb pages.

The second path optimizes the update_and_free_pages_bulk routine to only
take the lock once in bulk operations.

The second patch is technically not a bug fix, but includes a Fixes tag
and Cc stable to avoid a performance regression.  It can be combined with
the first, but was done separately make reviewing easier.

This patch (of 2):

Freeing a hugetlb page and releasing base pages back to the underlying
allocator such as buddy or cma is performed in two steps:
- remove_hugetlb_folio() is called to remove the folio from hugetlb
  lists, get a ref on the page and remove hugetlb destructor.  This
  all must be done under the hugetlb lock.  After this call, the page
  can be treated as a normal compound page or a collection of base
  size pages.
- update_and_free_hugetlb_folio() is called to allocate vmemmap if
  needed and the free routine of the underlying allocator is called
  on the resulting page.  We can not hold the hugetlb lock here.

One issue with this scheme is that a memory error could occur between
these two steps.  In this case, the memory error handling code treats
the old hugetlb page as a normal compound page or collection of base
pages.  It will then try to SetPageHWPoison(page) on the page with an
error.  If the page with error is a tail page without vmemmap, a write
error will occur when trying to set the flag.

Address this issue by modifying remove_hugetlb_folio() and
update_and_free_hugetlb_folio() such that the hugetlb destructor is not
cleared until after allocating vmemmap.  Since clearing the destructor
requires holding the hugetlb lock, the clearing is done in
remove_hugetlb_folio() if the vmemmap is present.  This saves a
lock/unlock cycle.  Otherwise, destructor is cleared in
update_and_free_hugetlb_folio() after allocating vmemmap.

Note that this will leave hugetlb pages in a state where they are marked
free (by hugetlb specific page flag) and have a ref count.  This is not
a normal state.  The only code that would notice is the memory error
code, and it is set up to retry in such a case.

A subsequent patch will create a routine to do bulk processing of
vmemmap allocation.  This will eliminate a lock/unlock cycle for each
hugetlb page in the case where we are freeing a large number of pages.

Link: https://lkml.kernel.org/r/20230711220942.43706-1-mike.kravetz@oracle.com
Link: https://lkml.kernel.org/r/20230711220942.43706-2-mike.kravetz@oracle.com
Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Tested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Ported upstream commit 32c877191e02 as it depends on folio based
interfaces not present in v6.1.y.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 75 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d3ffa0fd49e5..c38ec6efec0f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1581,9 +1581,37 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+static inline void __clear_hugetlb_destructor(struct hstate *h,
+						struct page *page)
+{
+	lockdep_assert_held(&hugetlb_lock);
+
+	/*
+	 * Very subtle
+	 *
+	 * For non-gigantic pages set the destructor to the normal compound
+	 * page dtor.  This is needed in case someone takes an additional
+	 * temporary ref to the page, and freeing is delayed until they drop
+	 * their reference.
+	 *
+	 * For gigantic pages set the destructor to the null dtor.  This
+	 * destructor will never be called.  Before freeing the gigantic
+	 * page destroy_compound_gigantic_folio will turn the folio into a
+	 * simple group of pages.  After this the destructor does not
+	 * apply.
+	 *
+	 */
+	if (hstate_is_gigantic(h))
+		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
+	else
+		set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
+}
+
 /*
- * Remove hugetlb page from lists, and update dtor so that page appears
- * as just a compound page.
+ * Remove hugetlb page from lists.
+ * If vmemmap exists for the page, update dtor so that the page appears
+ * as just a compound page.  Otherwise, wait until after allocating vmemmap
+ * to update dtor.
  *
  * A reference is held on the page, except in the case of demote.
  *
@@ -1614,31 +1642,19 @@ static void __remove_hugetlb_page(struct hstate *h, struct page *page,
 	}
 
 	/*
-	 * Very subtle
-	 *
-	 * For non-gigantic pages set the destructor to the normal compound
-	 * page dtor.  This is needed in case someone takes an additional
-	 * temporary ref to the page, and freeing is delayed until they drop
-	 * their reference.
-	 *
-	 * For gigantic pages set the destructor to the null dtor.  This
-	 * destructor will never be called.  Before freeing the gigantic
-	 * page destroy_compound_gigantic_page will turn the compound page
-	 * into a simple group of pages.  After this the destructor does not
-	 * apply.
-	 *
-	 * This handles the case where more than one ref is held when and
-	 * after update_and_free_page is called.
-	 *
-	 * In the case of demote we do not ref count the page as it will soon
-	 * be turned into a page of smaller size.
+	 * We can only clear the hugetlb destructor after allocating vmemmap
+	 * pages.  Otherwise, someone (memory error handling) may try to write
+	 * to tail struct pages.
+	 */
+	if (!HPageVmemmapOptimized(page))
+		__clear_hugetlb_destructor(h, page);
+
+	 /*
+	  * In the case of demote we do not ref count the page as it will soon
+	  * be turned into a page of smaller size.
 	 */
 	if (!demote)
 		set_page_refcounted(page);
-	if (hstate_is_gigantic(h))
-		set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
-	else
-		set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
@@ -1706,6 +1722,7 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
 	struct page *subpage;
+	bool clear_dtor = HPageVmemmapOptimized(page);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
@@ -1736,6 +1753,16 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
 	if (unlikely(PageHWPoison(page)))
 		hugetlb_clear_page_hwpoison(page);
 
+	/*
+	 * If vmemmap pages were allocated above, then we need to clear the
+	 * hugetlb destructor under the hugetlb lock.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		__clear_hugetlb_destructor(h, page);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = nth_page(page, i);
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
-- 
2.41.0

