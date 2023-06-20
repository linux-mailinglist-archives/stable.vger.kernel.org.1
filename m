Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4973755F
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 21:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFTTvP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 15:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFTTvN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 15:51:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431961726
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 12:51:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGE0wo019924;
        Tue, 20 Jun 2023 19:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cqj9Qo2dRQKVqccfOi0M/khihaIfPdvS55FBDgLhHIA=;
 b=fETUeOxPs9izXvZQVeqBnAH53lRn6lcWXn2RQyZsYz1SF5kIU5i1KBCCGJGaYqOq/WfT
 SmqU+nAwo6cuxnYbNoBHcrZKVeA+GIqXzpBISbe0DPfiOZbPoij9CLYEx7kVHRntZmFq
 CMcUqa59u4KGuOnjzvdQq7iY5SBAJ+hv1tbkBHX5AyzmjHH6Mb2TQQIQYbXetye2opeI
 1qkQjBeehCRWHIPesHCZrnA/qPtQLgivdnby9U14+qJmf540xZPXKQqUJkOokd6eH9ic
 UTWipEd4KYtQIWCZuwlxJ7AhahdpJnRdAjHQC93gNSiJbYdH3S2QHQ940n9Aj3wgi7NR bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r938dnp58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 19:51:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KJSCZD006101;
        Tue, 20 Jun 2023 19:50:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394un2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 19:50:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5k30WFz9eN9Azqvxy9AcgACW7mLL52ZF9j7nPY2HwO9J0aWnPED2k3hz0L3yuwC+up2TkJFJOXGtuIL+alg0XyV44XRK5YzTM0+ZxSsqc7ANVqaaA9DzBfsHp8qA1epVnaiJfJCROQ0r++pfaYFYK09uBx3f73VkB7hi6oiL07JxMmnr9v0CP4lojCn3wRmcyS8VoF2Reap+P5PaAvnSnWk/8Wq+F07SOirgP6j+Rhuaz3MyvlRL60PQJz3iCYaLGc6bmnsozB8mjajXXK7fpvqooqrj5vUacQiR6NyuWFScjuIV+zP8S6KnfrYj3A4gbmO89Q8E42nuS9uSM8RZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqj9Qo2dRQKVqccfOi0M/khihaIfPdvS55FBDgLhHIA=;
 b=NDqQGfrftjP0vPCDPq/jvtIo4v37SBDnMSRaMoG/MM2HZ2wkRDNJsq8r7LMe7DXpQzoSwCIY9WiUDj7fy+EruPvnIqITp1EhaXtO64zeyD6z+4vvvrUDCaX65GjfN9brFW7R6IoGAZz9IQ21hnLCL7S+iSXS6pRIn0xkS+ve3wF/XtvoK9M3PCYnxwRV+VZNv76S1KNIOBSZfVet+fiaq/2ycQn5NMdLvs5GdlbaU5VWMkGku6QbPXBDa77dHfMxfdP4Cxm3NN9HcBzMyQTrsX2suEnhCm7HtHstZnRsN7m8bt/6McqyXV8teAjuE3WalNjM5zvOpjMmn0NEmB4j3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqj9Qo2dRQKVqccfOi0M/khihaIfPdvS55FBDgLhHIA=;
 b=J0jzIbVlzSniegojkvQFfDvxsVjpoH6TS1mBOrazvYjLOV09Zp9GIJ6HmoT90J/g5D1qNwvBidlEcrqZb4uvtcHmpo5VJ1NIn6oWp1w+Lz1Aec40/JRcxFjRsCu4OWrUMmsYeD4mN3LxuSKx6TfpqZq/f0XEJzFvOex5d5RANvo=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CH2PR10MB4342.namprd10.prod.outlook.com (2603:10b6:610:a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 19:50:55 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a81e:2d31:5c2d:829]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a81e:2d31:5c2d:829%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:50:55 +0000
Message-ID: <4201d8f5-3e33-9fae-d6d8-471ecc3fee19@oracle.com>
Date:   Tue, 20 Jun 2023 12:50:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [5.15-stable PATCH 0/2] Copy-on-write hwpoison recovery
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, tony.luck@intel.com,
        dan.j.williams@intel.com, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, glider@google.com
References: <20230615015255.1260473-1-jane.chu@oracle.com>
 <2023061926-copied-glowworm-8cee@gregkh>
 <ce871e44-cd07-9f6f-8668-7ebe503b470a@oracle.com>
 <2023062047-confront-spleen-a9a5@gregkh>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <2023062047-confront-spleen-a9a5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0135.namprd11.prod.outlook.com
 (2603:10b6:806:131::20) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CH2PR10MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce23cc3-8a3d-442b-0d2c-08db71c7a953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wj42Mc/wb2BcWTBlreq2G43JdSM451VI4Cf8kquaib1wuY+Us5fu07gaW7D+zvbbEU9A0HMbCWscPfHgvUnSdTti69WrBmISzzLoKncCa81AGi0bgqGJ1zvAq8xxBuW83RAlUPZ2YV5caceeKeRFmh/bz2L2RnIh3pmCKQGcAUuQ0Kj69KDEvyqRVNtVNl7e75+1b1AG1NVxXm+5tIS6+5bPmIszLle86BqR+W7OnoA9cWu5d009RMM1QXNDRZhylQiGEgoJZHToQ9yg7QsUXsguHqou2PznqOJoP+Z6VLTVSnPpHF6WZRZ3W7CRoBC9niuWyUvIfV7CdnV7rnR8hYkA/KSxKkCR34EsOT6bRuDmXYUwygqR6LvkHeBLpQCUkLHjnJ6Im+W3XrfW0xRLwMQ+w7liHhIW8S0aCBpbt3JkCq15nVqTJkj1j+7TcREIMl1sT4CGaL8YZ93uJaELpuBCQ9GGHATWmHZv9vT13XWLtFF08aE188iWMldIJxEDt7Ar27romNzdZoiGP1CDsa7OeIX7x0qOhjEMpCM/B22A9P68NA6Hwe5oiX06+hDZyDBbA1zuODW0z+EO41sBfw8DfYS0Ll0SIDtIL1/CEbK+0JZjo8z51EUlgi9qTMofPGwZzLbQh83r+ngIvKIrgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(4326008)(66946007)(66556008)(6916009)(66476007)(86362001)(38100700002)(316002)(2906002)(5660300002)(31696002)(8676002)(8936002)(44832011)(186003)(36756003)(53546011)(26005)(83380400001)(41300700001)(2616005)(31686004)(6512007)(6506007)(15974865002)(478600001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUptWG1RQVhLVEZrQVdrb3djTldMNWdCL2M3QzIyYm1IMmpRNjFrN20yUzJ1?=
 =?utf-8?B?d1NaM3VuSzlmcFY0RVNha3dwS3RUcWpCWk9EaDV4MHNScmUvbytJV3FqK213?=
 =?utf-8?B?ZzdYbEt4cnZWMTN2aGQ0TDZFQndwQkZYSkdUQ3RiOVg3UGRUMVEzYWJtcW5z?=
 =?utf-8?B?YVgrSWF3NVdkazNvMlNldkdIb2x5MTBHcFdycnJ2SXpQQlY0N3dzVFNxM0tp?=
 =?utf-8?B?OXBNM3V0dGJmSzdpVU9qeEpVNVYxSUwvdFcxSmRoelZkOWl6eFV3VnpRYmor?=
 =?utf-8?B?R0hqRklzbmwyRjl5bjkzM1YvMWRpLzhOdkVkeGdyWXkrWDZUWmQwY0dhOXFy?=
 =?utf-8?B?bGE4T2d4d25JaDAyemxMS3Z4aDFlWHhkaG5YTVBRNnBzM1RhM3hiWFV1dGFa?=
 =?utf-8?B?NnRLTiswcFBPUG8wTmFTbS9pMys4MnNUbmV0VVJLTTd4SEZERUFTUGdQZnIy?=
 =?utf-8?B?Q2RtdXdIUnhZalg1d3R1T3hUKzI3S1F0b3E3Zng5VHNLcDJxQVRtY0hBUUxI?=
 =?utf-8?B?UDBLOVZyaTEveHlQRTZ1Y0tWSHNMeUFGNzRJL0NIbDI5QjJScWR6SUwyWDdE?=
 =?utf-8?B?Wnl1ays4MFhYVEFNRmdkMiszaG1CNXNrMWxnVlVQdjBHNzF1MWJ1L1ZtT0Jo?=
 =?utf-8?B?eEtBeWRjeXlaaWR0VmJwR1dtUHpUdUFxdEd6cjEramZ5cGFWQ3VXMW5HNG00?=
 =?utf-8?B?VTJhNmdnclNpRTBaWUxTTm53aFQ3ZnY3a2RUNWdLSUoxMjl5Wk04a2NTZTVE?=
 =?utf-8?B?SEdKMlJXOVA4RllBdnJuMXBjQmVQRnhzSFlDRUZTU0poa1QzZlFGL3EwMGZO?=
 =?utf-8?B?bmR4dWZCS1lxL2NFN2xqYzFpekpaK0NlMlJ1bmFHSjVzdVRFcmlyTmFUNk5Q?=
 =?utf-8?B?bTltY1FLNzN4K2kvR29Nc24xRDkxSlgzeWRNTXNDOVU2bGVsLzRKbmVyYXBK?=
 =?utf-8?B?YlU2UUVYUVUwNThNc1hPMWRvSEFGVGdVbDJjOCtsYkp5cGkzTHB4YVhsSlox?=
 =?utf-8?B?YzBObjVEdU4xelYwdmFDL1ZXT1BuakJwYkNrWTdqTGIrbTJkRlV0cUJ5SUgr?=
 =?utf-8?B?Z0c5MlpuV3ltODFjQmRTUWxTanBDU1VGVjdrbU9uN21zVVc2ZC9aRVdHNWN0?=
 =?utf-8?B?VHhYamt1a0ZEWTFCY0h5azJ5T25SdUVpUU9GbGx6Y3JzeHQ4eFF3QWMvNzIx?=
 =?utf-8?B?KzJETEVxTlpXVnhhSGY3blBTWUQ3dGJ5RHRlOTB6K20zZlV2c1lqdW9Yek5i?=
 =?utf-8?B?OGdnczJieGVOV05Va3AwakM0VzhSOSsxQTdSOTVlbzErdTVpYzgvaGlHYWhN?=
 =?utf-8?B?Q1R1dlF2NGNCMVFzM1dUTWptSzk3UlM0VGVjb2tXcTlnYXFFMFNrK3NsUnFS?=
 =?utf-8?B?VDVtTjhEMlBnSWNrNm1TUmtSd0gvQk1LK2VTQjRscGNEbmYrSDNzc2RucGlX?=
 =?utf-8?B?VWNxUXZyeVg4RHdLUEdxYjB3NzUwR1NXMEUvMUtQbDIvODVXdlQvUkppN293?=
 =?utf-8?B?NXZTc0YvekFEQ21KVWVvMFRMR0tobjkyNkg4QWt0WE5DY3llYksyYWpUMG0x?=
 =?utf-8?B?MXFOZmtSTUVEbXM1Z2ZEbU5UQUxyY0I1dTNTZG9FZkdHNURmSTMyOUYwMG1O?=
 =?utf-8?B?TnVXRDdHdytsZExwKzF6eG5ocE9lWFBVUUZNV1QyMG1yeHZNOWgvZDBiMndM?=
 =?utf-8?B?UStuT1lidTNrTHozY0xKbzN6ZkY0bGJIODVsd0dxTDhYN0hieU5vR2VxbERj?=
 =?utf-8?B?b1NrajA2NUpTWm5jVDhtMnpuTjhiRERYUkdVeERDRXJROVVJZWJXUThDNS9O?=
 =?utf-8?B?bXlJOHpQT3RPZThpK3E1c01NQk82ZW5tcVFZR2s3ODlYbUdHenljNTBWRzZ0?=
 =?utf-8?B?MStjYXN5L0lNckt3VVhBUXRtMitVUmwyenhOVVBkUjE0Mkg0WUZNU3R5TmpH?=
 =?utf-8?B?M3Joc3VsTEFLMUFMSCtxVmNkMVRBVDBldFc1ejFqaVRXdDBielI3SWdLQW4v?=
 =?utf-8?B?UVN6UEs1YjBIMCtiRDN6QUo2QzhpQnpQeWxqU0c2Z09idHd0cmxBWDlDZnFj?=
 =?utf-8?B?YWJUSE5CQldtbHlZZjdjQmdOaHFXb1J3eUZWbW9yNGsrZitmcE1CTE0rM3F5?=
 =?utf-8?Q?EPZ5JiWNVu/zYT4T4th/dOEKZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HuWMRDic2sEHFdBcQMoScqj848Zfg8IBXyaqz0pKP73a+cthj3yHQFshZATEta9UYDmqM+SLt4DtptEiXTXUJn0copGfMd9Db+u1F25m3v/lWPe876Rq8RPRP4ax2aYjTQqX+w8dUjSCXWbBNcMC2qNgGxREGOaxJnpVEwVS8mFDnqX2qIXha/nyuKQBdhUrvbcKN29TohpOtFWsTkgdyr+Cgw2axU6k7p9IHnvW50QKuQMLISr3exzO0sJCMbDZ1DaRbvSo8trc9GvDWEAzYtguf/RXoyFvtAJ2Y23leJ0FTB3Mw32GEij7jeBmj8v8sBJAEdlk8HRnNRRtOhdfFtPSAAWUu6GoN4Cpr0KvxcTJSdT7P2XhUICOzcxg8wrO044FfYr9y8yt3fRJpctJ04W+2WcX+yAIJRIVWvjGXKUpNfNfGcmmaNMcQE/ZPte7/hPh74YHtEokj8jSar8S8EFM400+3H3YxDtL6tXNGkHrkd4wFWc34KVIJ0hmEdkiSoj//sJNR8ee8Tp3CK/eXckiMBCH2cAucQ/B3YAxaa5V0O9yKxOjnKM6aYyISpFrCjiAOtwL9KNaH7p+XlDikF8Bt9sW3lGNSc94yBMHqhSwTxxkK5XR+VQiNdWwRWOCWYp5gDNEywa7jnBxTwFZFdpN9PqjYHDhn92Bd0M0TkPsWJBrOptg1Q8H5A17O83Ji3olr96+17D4t39XK1bde/VwuiVQhkwY1r0ROzu527FxTpUPtYzE1hYkbiKfxiAtn+Aa3Z61/q/s9mOnNrKCfVUA4ZrRvtQ5rZVoHH0gYNlEbDF0+K9Y/telIVyyCGOsn/VR6PEfY+B2mkAEzUvzBSXuo999Y947ZTxqoFOx70eP2izJHnsHf6gvNi7/rAbuoiJTnM2eB5jTI2UCxBnk4+uNz1X5UofWDj+IWWX0de4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce23cc3-8a3d-442b-0d2c-08db71c7a953
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:50:55.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJx+RophSOTKxJWls1id6p1f7MOlzd7RkQtsFoVhWQSs+F6vCGxnnPBfstwuTGVMhPdfxnsalEtkkkRXJLkbIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=810 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200179
X-Proofpoint-GUID: bxaZNat-VqkpL9J1C-4zGZgBMiUKrabZ
X-Proofpoint-ORIG-GUID: bxaZNat-VqkpL9J1C-4zGZgBMiUKrabZ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/20/2023 11:42 AM, Greg KH wrote:
> On Tue, Jun 20, 2023 at 11:36:13AM -0700, Jane Chu wrote:
>> Hi, Greg,
>>
>> On 6/19/2023 1:28 AM, Greg KH wrote:
>>> On Wed, Jun 14, 2023 at 07:52:53PM -0600, Jane Chu wrote:
>>>> I was able to reproduce crash on 5.15.y kernel during COW, and
>>>> when the grandchild process attempts a write to a private page
>>>> inherited from the child process and the private page contains
>>>> a memory uncorrectable error. The way to reproduce is described
>>>> in Tony's patch, using his ras-tools/einj_mem_uc.
>>>> And the patch series fixed the panic issue in 5.15.y.
>>>
>>> But you are skipping 6.1.y, which is not ok as it would cause
>>> regressions when you upgrade.
>>>
>>> I'll drop this from my review queue now, please provide working
>>> backports for this and newer releases, and I'll be glad to take them.
>>>
>>
>> Thanks for the guidance, will do.
>> To confirm, you're looking for backport to both 6.1.y and 5.15.y, and
>> nothing else, correct?  Just curious, why 6.1.y in particular?
> 
> 
> If you don't think it needs to go to any kernels older than 5.15.y, that would
> be fine.
> 
> And as for 6.1.y, look at the front page of www.kernel.org, it shows the
> active kernel versions.  We can't apply a change to an older kernel tree
> only because if you upgrade to a newer one (i.e. from 5.15.y to 6.1.y),
> you would have a regression which we don't ever want.
> 

Got it, thanks!

-jane

> thanks,
> 
> greg k-h
