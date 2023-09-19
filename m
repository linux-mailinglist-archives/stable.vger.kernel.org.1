Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888C27A5AB9
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 09:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjISHUM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjISHUL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 03:20:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC568115
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 00:20:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6Tg60027621;
        Tue, 19 Sep 2023 07:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NF9RL+PhNHawNZaU/KFCdZAdA3H7opwjpIvv8VSIrQI=;
 b=ZZEEbqpThLtj04F09YK3dD+0lepL8oO0ewKJcbOQY/AUaMUrJ4WGN0oIbg7kAUCuxxL7
 6dYQn8jUZXSYYHi7ZfYcofVbxaPWG4npxZOnY1yOg02XeJHZ/tuZz6MRl4RDjzye0e46
 wi5U0quTgTuXja69ER0+8eDxhWMn1qPi009sKT/1YhTe0E51vme/tvtmwUbNYRYiMFXz
 RQc2RNnWhmuhPVa/SZn9AZUsnJZ7YUvz6qOhYWZ8GR4dfHMue6xappVPANRbYJyUfzdA
 lQXzBhWSZuGA7SCsHsggyDHSFgp+yIpb0WwkeajXxpp+38nA6iTCL3x7WEiWQ1zsojFZ TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t548bc5qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 07:19:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6uQJq030280;
        Tue, 19 Sep 2023 07:19:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t58uu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 07:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0rF5Uk/VdVt0LmHiWY2VKTCsgfsNHaBeRmuw9AbGTBup6s3p2ITrJFD1E+P3OdwiY81HAaH3I+b2MpULBeiRznVXZ1YcykKbODGXwUYhI4baipWGW/vPTCVMq/M/2/IMRf/yw01ohSeMCCIBLaYJMe4pWKImZBPtorYAoKilh476wwUMD0yDc+5l9NsSRIYPc9BmEcKRO8jP+ToF4pze1lXAKKUEaZamUHCzp9gEEyeFMXaMyXw/TaEadVQ9R3eUeZkM+Gz4f1fiABot8jyjrPGjdriGjlkPp+64Ulcuxsp5nPSQn6NreR6LwjwF05KlcfHX9bTDPLcOtKYgoZTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF9RL+PhNHawNZaU/KFCdZAdA3H7opwjpIvv8VSIrQI=;
 b=gcdY34Oz6NPN1CwAJ6kL0VtgIseU6bcwJdDpNh1JMuxejJ8Gy8yZBH9Slxb1g2jk+J9Ip832IjR7TL6BVdVCcnDigBBCRj793LNfBnygvu18ra/EYfHQOo2E/XPJNfsKWHgySQq4JQTApo7MomjcxJYg/gK6dgDBIi6zoao5EGphRjLMlO1tFxproxAQDnuASKmMFhtOjTTNLvJ7vG52irLkFpt64j/s31rMpybC8VRCHA3DNa/ADjmlxL5n+u74d/73C2qVnRWneNR2cxPy2WQYHSyvJ2yBtshHpZpMhRGIH1jnVXdyb0hWz4kjm8G4cyS1DFA1MEQGrMYGD4LVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF9RL+PhNHawNZaU/KFCdZAdA3H7opwjpIvv8VSIrQI=;
 b=MbuoOGm+B1aENYDYyQLofyTtEFv9tJB+2Dt7WjDd6O2JWHaLIwDFafJpEj48p32NNl36YJR3t2P4Kua42693D7Y62n+wehbZrj7e5nJAE4osS+P8QJNWjBhmKAnMyE+hbW0ukav4Gb/BZWMZbXFG7S0soiuzZwqCEilzXwLt3Mc=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH3PR10MB7433.namprd10.prod.outlook.com (2603:10b6:610:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Tue, 19 Sep
 2023 07:19:48 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 07:19:48 +0000
Message-ID: <08a02740-42d6-a02b-51ea-4f5b8845afce@oracle.com>
Date:   Tue, 19 Sep 2023 12:49:36 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATH 4.14.y] net/sched: cls_fw: No longer copy tcf_result on
 update to avoid use-after-free
To:     valis <sec@valis.email>, Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, Bing-Jhong Billy Jheng <billy@starlabs.sg>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        M A Ramdhan <ramdhan@starlabs.sg>,
        Jakub Kicinski <kuba@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230918180859.24397-1-luizcap@amazon.com>
 <CAEBa_SCoUVCwVAZOtYfdtinbnF85-0fCYVbT-KAiBi4f75fWtQ@mail.gmail.com>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <CAEBa_SCoUVCwVAZOtYfdtinbnF85-0fCYVbT-KAiBi4f75fWtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH3PR10MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f86d221-b010-4d78-f5a3-08dbb8e0ce62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpQGYAcP6hz2LauY1u8i/zfyq3CaWaMH+LQBI94NAkXW0yTSDC/G5v5a53ovpZcr5WLQAWRyvZVXRz+Qpx1TJFsbG0PjIC73TLs38DqRyOHjZHHdlIt5ViEcWgdSkdheiedDj/hKTmM2ZpS5F7NGbcX+9iaSepQv9LgGuMBjUa70osfLQ8kvsZZbv7nS4/qEej+bkmztcBpK1coHQ48jxN21VezG20+Kfxg07l6kV4WRSEPqI5IxqZxUFVDvDTpszc2F8ZkhnJO1RwKYz53wxoi0w6io4b2tkqS4NBwbGpXqCrq97UR3Pa0+mEs2EN3D848kqLVdg7ha5JsRfaR+uUkoB/Mdkx/3XXFPBQBl1/k63KauQk20GZJ8Gu2OdgdPTIVdiUGBOkSNv0H+bRTd4NKeDiJZa64n5xTd7djjBCUvP8vix2907VypGlrDzSVX1qf9t96sK6heE6ahUy6njDDyfVPhWKZ3eaMz0NFKGyyXyTCkB9efn1RQ0/YVfBClJSDO/pUzDq3xe1ZhoZzjbHuadjnBAV/NJxwpRiMsJ0GGvy2nuxmh4lA9TS1txZoo66zB80TJKvM2Uqybd59Pkr05tgQ57eDVuOi1k6HA6cTDwgqCZyh1PHqhmr7FPv92x6VFe+XGRB5w8BQy1oW2YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(26005)(2616005)(8936002)(107886003)(8676002)(15650500001)(83380400001)(2906002)(36756003)(4326008)(31696002)(5660300002)(86362001)(6506007)(53546011)(6486002)(966005)(478600001)(6666004)(110136005)(31686004)(316002)(54906003)(6512007)(66946007)(38100700002)(41300700001)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVM5N3dOUzYvaXFNam0vQTVNdGlCb2NuSG9yTEl4amVwVjlieHVObGZadWlR?=
 =?utf-8?B?SHp2WWhWdnhTTlA5MzhXVmoybnc1anJvWWxoaHdIMThCK1BMUXpSa2J4bUZY?=
 =?utf-8?B?VE9UclBTN3Q0ZXpFSis1OGF4ZVJDVWlJWExVZ0lMUEt0MnNocHdlclpqN1pF?=
 =?utf-8?B?cy8xc241WnNNT3NMUEJkd2ZVTHlndWhyUTQ3V05iUFpLOGVJVUZaZnd1S0NC?=
 =?utf-8?B?TGJSUTVRVTZURG1kbVJRMnQ3eWk4ZWlFYno0VnJ6Rk11UWpKUFU3ZTk2MUZF?=
 =?utf-8?B?ZnZaSUphQVpSV21UZ01qbWF4cjI4OUp2am12ZjA2M2JpUzJBWDc2eHk0RExL?=
 =?utf-8?B?ZnBoZFc0NitGMVBNdk10VS8vOHlsUnd4eXJpZEcxTnBhQnRzdDhpVGV3VEd5?=
 =?utf-8?B?clV1K004d0FaU2E5OFRiMGUwb3FKVEFSMHN1NlJMUnpMTFA2RWJicWIxTTNQ?=
 =?utf-8?B?b0JMaVlpOFVZWmlDcVZoUCticmVseEcrUjcwZ3NtbkxXU21pZDRNZ3lZZVJI?=
 =?utf-8?B?VVk1VzNPV0tTUExoSnNwTXRLc1g2YjdXd0c5Zk8waXFDcXpLQmt0M2UzeUlt?=
 =?utf-8?B?WHZkbjdHVW5OWGFjYXlZaTRMSGN2ZjJJaERjV2xyeThZTU9MUElTbURpNE1T?=
 =?utf-8?B?Q0lvbWNZWldTc2FpNSt5Y053SjVtT1dKTU5yRDYrMjJJbHpibEVaV21rNy8v?=
 =?utf-8?B?Rlo3OFdkMlFIYWJsOVBOMW9xdERvODhYd0RaWERINVEvNlk2SEVoTTNRMmZD?=
 =?utf-8?B?SU1CN2E0WTZTZ2xpOS9JZGpGd3A0NW5mTHdIT1NmNG5QdStSWkZPRkxpbTFS?=
 =?utf-8?B?cDdSa0kzQkFUbEZWOWQvRmRmTVA3OFB4dTRvSGxNWE1saFhwRkpKU2kyTXdQ?=
 =?utf-8?B?UTMrT003a01oYlQ2bWd3aTdneDRCU0M4UE54RFBlSzRQb09TVGJ2NldoeTdq?=
 =?utf-8?B?SXpKVkJodUdEYk1LQlY5VGt5SHg3blZDeEZVb2Nua0VyQjZSTzNYUTlsMzE2?=
 =?utf-8?B?OFh3RmZPOXBJenhCSTc0d09aR0lNaVF3Y0ppR3BPOCt5T0MxUWtSWDRhdXBB?=
 =?utf-8?B?Zk1LeUhTemY0Vng0SEpTemNiZko2Z2Z4aFU4OHM2ZWI2Rkl2SWwvQXFNaURl?=
 =?utf-8?B?VkEzYVhVb2Y0UFNjc1NSaTV4c3ljMGhqYyswRjk0Tm4yb21wTW9zb1djYUlW?=
 =?utf-8?B?SzRUL3NmNlVGclpwRTFneUFieTZHNXh0cG9wN3AyRXorOXBGakVYUnprMTJH?=
 =?utf-8?B?cXFmZUVTQlNZQVlta2ZJUFF1Z2Q1NGFwTTlBNWJCUUZacVY2QnNmTE4rQkVK?=
 =?utf-8?B?SStrRmV1d2hiWkdaTUtGSWovRFVJU242YURXVG4vSXVyTFF0Y21LV25oU08r?=
 =?utf-8?B?VW1zTmJIOWxDM3F6MFhxbm9kSW1nUkxYL2xhWEpPZXIzeFcrWEIveHNheVVO?=
 =?utf-8?B?Ylo3TThOR0ZBbWtUcktCclZScmlqVWhlUWVVeDMwSkpsVjRPQUthYkhEZXJr?=
 =?utf-8?B?Qm1DeEVXWC9GU3FCcHBlbW53dzh5UXdqcWI5NW0rUkVwM1JQYlNEYU1mVVhY?=
 =?utf-8?B?NExYSUwxN0l5YUR6K0g3dERWbFhjLzNoNDZsQ3l1aHZ0ZkFPTFBZL0VTSHBB?=
 =?utf-8?B?ZjVxaTRVT3NoY1ZrSEJnR29nMGpEN2MzT1lkYlNMZG9XUzBKU2ExM2JkS0kr?=
 =?utf-8?B?Ym1JWUpOK2JPYjk4U3Z4SysvWTlyYXhESVVoaEUyVk5qMU1rQnJEQ21STjBm?=
 =?utf-8?B?elFiSUg0b2RrSnYyQWlySmR6NlE2bHpkWUVlUjZMVW1zUGJmZG5HVVFFUXlk?=
 =?utf-8?B?VlBwdHdCaGVEaDhNc0FVMGNMbEFNYjNnSldJME51c3dSZ0xka2tJWWlrcjd6?=
 =?utf-8?B?UGdKdGlzYXZZcFpyYUFsamVwSnM3MlM5RmJ5U0xXUzdrYWxCZVFmYTE3dklB?=
 =?utf-8?B?aldyRXpSOThWNFZjak5YeEVBOEtVNUlPK2pGRHgySVY3Q3pqYjFjRkFwUW1J?=
 =?utf-8?B?WDA4NVV3K3JmUzBmeUwrTXNrM2JVK1ZFbGphbGFHVUl0d0pPOGlDZU5XeGYr?=
 =?utf-8?B?N0pXSURpMWJ1dVo5QkJ6WjNNZExWbk9lbUNzbmdyTnRZVk91cWxUYnhxaGtz?=
 =?utf-8?B?a3A5TXhPbTE2UkZiakt2bjF6VE9MQlhSZHRIaEtkV01RT09hMnlEamdaNDFQ?=
 =?utf-8?Q?ZexVIq5xrbO0lBK6kMCV0/A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VtPIAEe3H4XsZvm16h8+LC7JbRMuv7suOb2/gB9jhzSGnR7HmVQYnw7veME1Nsx5+MXymiaWjqNa/5ZTunj5+Ux1d8+gqVSBrJGOzOeVKEZ8XgBPhBuLuqVRWsybm5Wdm3dJ+y986TNDykfi9grQ211L+92wPq/rYgAFaip4V8J0W58LCZ2YuQd/KaISr8LfxETh8wg+CgIplcC+37miqKX3SGIN5dhsQ+sV6Jgs8WuRi5MArVfgsa3l8cp3MjcaY4PQPeLxftoOlDxOgwkhRsgdXmJ8/BKj4d9T7NP51ZzhKVSwLQqS3oDK5TBOtVZKEiroLj1xb8eAvR6wbK6IY578sXxvvfSpCp6ijDA7au2o1Tao2Zlj+aQ1pL+MbLhorfSglOjUNyqpm3wltFI0DxsKpXUxJ6fzozDP6vJJzae38zEL6TFevQ65Gy5TQHTtmVWIum+ly5bibiDM+GDKEMkvMyPj18yT6m6+dulGYlekUxuXfk/rlIlaS7a/5cPEwY1TQLB1K0E2kTilmvCwae5ALvuJcsewgWhyLKxCRnmDNbDmRyIu0fFbkTe09qvBd8Uu1evLUce+p4PdV70MvRo6dER5zx+c42GiUokVSFBpci1OJgvtAmQ5rEwAQSYItDAM3PfEuoAeFM4YTKOYJiSoh0pfh+1zWQxy2ZkNbmXCLVabDZrpHDHgacGl5485QFrdvMpioGwVs2xx2xbroQPob6RfFuUpYL0rlyericr0YRhkrcyugf4rIVhSpvQZWgq5dsQ0noopBC4/X/nbXtltIEXI2TEDBlzKLInfMYYkr5SZ++WkGxwOSo12q3TQQlCqIr/37F51HCDScI0xCqUQ1PMBHrKbgnUKIbMRhVH+6N5FVIK011DeX5P49lL+c9JGqygvHzlw3VANxoxkFhhszWkAATKJHx/SCfXuZ/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f86d221-b010-4d78-f5a3-08dbb8e0ce62
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 07:19:48.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aow6fw9Pj0XNKydRb+YJHa/JTIsWcFoGzpsErzPpZQortcRM6ACNjr5SGrp2yHulSgiJg8ProB/mM/Eud6pjNVxGw4AIh1Rr9J+LFGrztca2QGerEe6eeXgIXjiN65MK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190060
X-Proofpoint-GUID: misKYQ4LFqQ6ZwnI6OPe-6AiqcyR6Zjt
X-Proofpoint-ORIG-GUID: misKYQ4LFqQ6ZwnI6OPe-6AiqcyR6Zjt
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Luiz,

On 19/09/23 12:47 am, valis wrote:
> On Mon, Sep 18, 2023 at 8:09 PM Luiz Capitulino <luizcap@amazon.com> wrote:
> 
>> Valis, Greg,
>>
>> I noticed that 4.14 is missing this fix while we backported all three fixes
>> from this series to all stable kernels:
>>
>> https://lore.kernel.org/all/20230729123202.72406-1-jhs@mojatatu.com
>>
>> Is there a reason to have skipped 4.14 for this fix? It seems we need it.
> 
I think we need to apply this to 4.19.y as well.

Your backport patch applies there as well. I compiled the kernel after 
applying your patch to linux-4.19.y's tip.

Thanks,
Harshit
> Hi Luiz!
> 
> I see no reason why it should be skipped for 4.14
> I've just checked 4.14.325 - it is vulnerable and needs this fix.
> 
> Best regards,
> 
> valis
> 
> 
>>
>> This is only compiled-tested though, would be good to have a confirmation
>> from Valis that the issue is present on 4.14 before applying.
>>
>> - Luiz
>>
>> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
>> index e63f9c2e37e5..7b04b315b2bd 100644
>> --- a/net/sched/cls_fw.c
>> +++ b/net/sched/cls_fw.c
>> @@ -281,7 +281,6 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
>>                          return -ENOBUFS;
>>
>>                  fnew->id = f->id;
>> -               fnew->res = f->res;
>>   #ifdef CONFIG_NET_CLS_IND
>>                  fnew->ifindex = f->ifindex;
>>   #endif /* CONFIG_NET_CLS_IND */
>> --
>> 2.40.1
>>
