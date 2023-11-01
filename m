Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125137DE377
	for <lists+stable@lfdr.de>; Wed,  1 Nov 2023 16:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjKAOY5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 1 Nov 2023 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjKAOY4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 1 Nov 2023 10:24:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360B5110
        for <stable@vger.kernel.org>; Wed,  1 Nov 2023 07:24:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A19t1Bh001684;
        Wed, 1 Nov 2023 14:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=gyAu+iMTCDXa7RaCBQkllfYIwPW6spQ9D+tuKei1s30=;
 b=nx7zW8qk7r0PLGURQU810TZoyWUl1Elej83Q9YKJUKfsHj07EUvG10yMu70fopBeHEsn
 BnOWDm5sqOcK0IV3fkyfo0h5Dns+nLqhlt+8GCxyhc2OHOmx3aoWrlHULFKrjuUz2GhF
 wNGlJzBroP5XhjC8OPsH/4yB576cP8SfftwC/zRQNsGOW4nV0zo5EvFGpB7EO0XpGnke
 15vhqWo32mouEpTY9rP0UCqchVt/LB/RSuRzg8IZnmBLxiecFOZFaksZDWfaazf1ubBV
 8jYEhezWzzIxYE5mwf/+saSAzGTJTFF6yUYjMtrpHmO93mMhZwlPsE9JZI6ZUVQpo60v Cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swtqmk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 14:24:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1DevQn001089;
        Wed, 1 Nov 2023 14:24:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7f1xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 14:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMQYaDd61vllZK9223MZX0FJ+G7kruATB6g0wt0IhFNNT7opsyR13sFJq4tX8T61jULg7215982AgXJ/pIJFmPxCVXPFZrH9mkN2j7wxSgrnhyeeJxs94uEzKHY30sDqm/koxUbpqvYwN1YG3FWpsmU8qKZGKmdEd6+6EdC6Tl9xmHUCrH7MEWeOY1TjjgwPyaBXNdQyiHmSS55+6ENKVM4clAIdBlJ12Zwj69nyFddQKHby44EyUqXbuCcGyqCkmtNHjJDYJ2q4S6NjSvs6x5RpaAukw2u0SPFDTLHZnsyuTJB2iwbDxqh3GRj2q2uema1tFXMkwc3pC7a60jnvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyAu+iMTCDXa7RaCBQkllfYIwPW6spQ9D+tuKei1s30=;
 b=E3fBVmTi0GnMgQew/GUcvNZWVEGMkrE9A3IV/q+fuXV1d5ELXgP8ikbe9ywJ7Z4jNbeXwrEHigNGI2HWaCacn4X6nrRR0Tk8L05NZPlYRg3x0FTnyCjZ+x5Xx04AEbC9UAWDv4g+3uEj+avdTh9u5iPLAtA1N+y9+8Co2kabAvja+ciwvyeAw1qf5/qWIKTDCeq5g2gK6/vgxoroh9HbVh8HFkb4AbLUTSNLtGJoSgG+T7WmLwiQKgrgPxU17G0WEQESSYSq/p1/4kg1zgZqFSTU6ifuMgAsYQgpfzBIJPVtIWKE0uqHUthR12hms2X1YKsmqM7o2nYLXIq6Edysjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyAu+iMTCDXa7RaCBQkllfYIwPW6spQ9D+tuKei1s30=;
 b=TM/yxGuQpn7+beOdgDVoFbOdm7LeVNbNGeP9BcLHjjRKaKQdUB2n12/NnZCTAYg3Ys8kg5GViV6p2eeHIV34bI7qIK/zrkxiIx2wJnc7OjyPBON63y1sUjbbRM6Ni9URUfUtIxTIB6tax4IIcUbQgs5if9//pY7TCbdlKjE4fZk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4585.namprd10.prod.outlook.com (2603:10b6:806:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 14:24:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 14:24:31 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     stable@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5.y] mmap: fix vma_iterator in error path of vma_merge()
Date:   Wed,  1 Nov 2023 10:24:28 -0400
Message-Id: <20231101142428.3505465-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102731-olympics-bullpen-6897@gregkh>
References: <2023102731-olympics-bullpen-6897@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0064.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA2PR10MB4585:EE_
X-MS-Office365-Filtering-Correlation-Id: 912d6fd7-8d07-4e08-82cc-08dbdae643b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOkUwb1il5m8C2VP1Kiwmgb/Y0pSTvb7DRiTu9MuGBbYXykUczvJ6rYfrRSHY4WHMP3NWZaLxMMZYPJTS6pIyxshdPe+8BJZ7N40CvmZlLLvZ9owSZC8rNReWXXuha4DqlhLWLg/qDKwvVqmaKc0gGjkqI7er9tLOZfVgJE40bMWozYa0pl5SqZXtjzrSrvb/0E5PR9Y4C8UVbWzq0Au2fZqc4JdrzvLN9rnbzkyL4Kem65Zo34xbOLBXcqKPjSlKrISzwDJ6SIIvN04Bai+oZOrzr6vDPdIVTQk2iUDZV+rKPMSL166OkzAkZaETurwZklLrSNxFiMa+Wt/umSk7da1Y5G0eCZe0hHReTcJ2VgRLLKZEcZ1XwjVJFMwrqLc7snvl4SI40yqsG0yy8zWKSbNd46MsM/TXit3mpmorm2j31mxs0yIlLs5nfBhYm0LAJT1CKta9CmcyCalaepAgdEMuEFakdQFgbMuMVBWsquZTXUE7PufOlQLlRGul8ISatCp5++Oek0/NT7DFV7+pWgpvjWU3Sgwv/+/wdzIm0rbYUD98gK9MjDUPA6vLDzvEtUEB9q2unvFcHE8dkgrrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(86362001)(36756003)(1076003)(966005)(2906002)(6486002)(8676002)(6666004)(41300700001)(4326008)(6506007)(478600001)(8936002)(6512007)(26005)(83380400001)(2616005)(5660300002)(54906003)(316002)(6916009)(66556008)(66946007)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZPHVZ6iZRIODfrMekXux45h+0Ml4zk4TacWrEaUuyFDXAnzeiQeI7h05OW1?=
 =?us-ascii?Q?mCZFxw5l+NpsXzevZVzgCBIAypAc/WCet2+IXcjmZeXYBbCNphyi2hXDiY8R?=
 =?us-ascii?Q?zej5oRogRQUhwloZUM7jgnEhuR7/BRs6FrccSCdiyIIoW9+P/MvBBXUK4Y7f?=
 =?us-ascii?Q?UsPy8BKBzgKqOOh7VuVsIvKF22FY081pteBVfB3DHzOJKSyjxjLX1cVFbl0K?=
 =?us-ascii?Q?rH4ZEhuUulItDY3b/PhK5v3MDKVFWa5oJ3ic1TSDL7PGIsMAe/664rQcIcxY?=
 =?us-ascii?Q?mVpXwymIIplHj4mKLq4Iir6M4KT+J0hYfzVlrGaQYSIihZImBPMnJWp3u7C4?=
 =?us-ascii?Q?eT59itzP7gBHW93MgUfQlcgc0nG4HT1JDRgz9TsUooXGsy/0QarUpmmAqMdQ?=
 =?us-ascii?Q?6iPxPy17rY1Lek3Y8Eoknv9qysVpDCI8yJMwshfVs45bIUv9bHcUMrOMKNU3?=
 =?us-ascii?Q?TlisKfq8bymARC3g3aW6gcNwYb2NynZOGUJD12uSviutkHAbybsOLvzl/Ts/?=
 =?us-ascii?Q?4wR+dOFg2Mk8bdJhoqS8ggmqFo6thSRaERoLLraqa32lz2j/9JBPtTs6pFWu?=
 =?us-ascii?Q?EwszU5ECjYMeSffY+Rjdzl6J79qCCQvFaUH/m51Td7ma1WdTJoOthm4jp3KW?=
 =?us-ascii?Q?kgF9VGdpHozf/rQ1AkuVp0JR7x+qKlDzg5QGMae8fsg1TcVdzTyk9SvaPtJm?=
 =?us-ascii?Q?O389bhF6VgFmhZ+r109XsHWE6DGcEFxUZCv8wpKK72tkqK4PvQi2OEaqrrqH?=
 =?us-ascii?Q?YPgoLANYsLYM9t5yOaO5lRHOUVjfvirTviOjt6L0oKgAekystUIf5JDEaI4o?=
 =?us-ascii?Q?T05fp/Ujrnblg36QJ7Hx+d4TNAAKBWiWQbceU0i5dFfcgWzIV5jMoVCyaj6B?=
 =?us-ascii?Q?uOK6WXHnnLESrXVppP+mA0Ba4QrZ/iABoPoG6fCnPsCMLkyoRMLp/pwMFviQ?=
 =?us-ascii?Q?uJao4XuZEfa074ADx+sH2yUhyJ47vO8EyH4P03dQho53fSr1QQ5p/2GnULOc?=
 =?us-ascii?Q?R+T/Rs2EiTMEbG+Qn/F6/an0ij0ibUoe+JQkYuIBikq35CYvC+ghJ5POkxro?=
 =?us-ascii?Q?ywT7RnLAV8xWx2QZ9vKz5mSIPNRXTB6G/uzRwhGVr65njNw30D+WM8XvGvh/?=
 =?us-ascii?Q?vCRl4zpli+LvgPf1XgXo69seQbQMc6suFy9BzOVWC5CjGs4BzbdO0FUCQOad?=
 =?us-ascii?Q?CxlteYisMhv70A/JNB7SzXMnCUCW3zNiG9m53Jnb5r9j9wlMEmJAkF4ZoRWU?=
 =?us-ascii?Q?ywEKWMb0Fb73Jm7pg/FfqMwUTKjhX1oGaYV1HCLFf2erdSqaX3E6ngcq4vg4?=
 =?us-ascii?Q?EbJ2rdNHBYaqQ8eXgspIviMt0SljqMg8soqvTp6kOQhftCzOQf9IABWQYoJ+?=
 =?us-ascii?Q?tZvLinZqU8xL3sPRbFyhKYpW1UND3UXAovF91qIBd6pSrnQp8Kezaewjizax?=
 =?us-ascii?Q?RwXT6B6GlxX6i/K37HBYpGeshGZbwQAvXJF5oa6d6QfWGRARmvgoV5FTaX7H?=
 =?us-ascii?Q?6BG4juyGRJ1+R8VQ3V4rYw5Xv9iiIgnb0WIIrVPHn9oqodciugpvIo5TYmxV?=
 =?us-ascii?Q?ILmJWHOw5VryP6N+NvlvG4/DeBxdloaSOuvi3021?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TVTtoTMmrZ73rODByO2lJbFOgyrjgwjyVbJMI1E9BL3TOR7eqzo/9SWGIeJI?=
 =?us-ascii?Q?u7CQyTBcmRsnuD7E415tVwcuP4wZ+caJ0BjZk7cWlsjhfjXXIu+CX0TWyxbt?=
 =?us-ascii?Q?fh32nKAjL4Rma/6ApVCIIZFrGSK443yevWSOuNFIFnNmMpwSVf5PWxOibkdi?=
 =?us-ascii?Q?lKeQ+zeAgpcwdsUypddf6KcmfQ5M4prJ8NF1mKbN8QP9tcdk3X9qsh0ScT43?=
 =?us-ascii?Q?lyGiiAUAPDyVLVtfkJIG71S4E+o9oXYfVwSo2UcaMpz7x2EdChGDDHXXArKs?=
 =?us-ascii?Q?82XiIJg1Jt6p6OeQRDWvgo6KCMTpNcTiDc/iKMufxxfIgA6Scssqqk7xeOxg?=
 =?us-ascii?Q?VJTgGjGWfGpADrGm8epTYSzWUKEseWv8/o5yVv66leivmNWaTa/32YV30NK/?=
 =?us-ascii?Q?lvasBeTexeDIvMHsyUBmvnQ/heR56LMiCrpToOXRMuczfrsaZ333NbjnNxPA?=
 =?us-ascii?Q?cJ2g5Ph2KJvD2uKxojb+h+fjE5fMn7OdFbe+GoU/pH1XvKnOY+GDWXtuQnXE?=
 =?us-ascii?Q?uwtnxqw1KHa0U2bjfkjhXuL0jSUpZjm6njqi+zSCH+1GZ7UpId8kNiIarMwF?=
 =?us-ascii?Q?sM0QbwaPms4rhB10VQyklfzc7va5a2MXQrwr0ekj7B8JlzxY8GkgDILKEK74?=
 =?us-ascii?Q?31pIM/j7xwPpQTM2os+lLHM9k7vxvy9r5vVPA/tp3P2UXOaFYmRTkikrxELG?=
 =?us-ascii?Q?E3fBxpPiZboDSpZEwY7y5yeIman2M7XNs6DJNWfZj5k+IiYorimOXBT27mpX?=
 =?us-ascii?Q?2y6wCGwohpndERwSlae70NqlgIIsYG9WD6tNydyg6lnQQFHwSWAvBWR/YNmk?=
 =?us-ascii?Q?Pb3tcu1CIF5ORVZtFVCfSPbA/Hjz+KiMDEI7Jj0PMUozohRRidXMegpln3Ql?=
 =?us-ascii?Q?HOxlsUtFIhVvnoTfqlK1BSBcxgPDJb2uEmPIgw4lELs6g/BrOms/JSQXN6fQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912d6fd7-8d07-4e08-82cc-08dbdae643b2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 14:24:31.7502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izigTVt69nttTZwPIlOTZk9lPl3RvAC7bb4XcvfH+vRpCBikKAJJv71yiZuEc6D1O80xv1jWItosKZ0oFffspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4585
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_12,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=697 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010121
X-Proofpoint-ORIG-GUID: GiqTk2Z1dJJb0_f2wcR3bFeCuwIBDJ0B
X-Proofpoint-GUID: GiqTk2Z1dJJb0_f2wcR3bFeCuwIBDJ0B
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 1419430c8abb5a00590169068590dd54d86590ba upstream.

During the error path, the vma iterator may not be correctly positioned or
set to the correct range.  Undo the vma_prev() call by resetting to the
passed in address.  Re-walking to the same range will fix the range to the
area previously passed in.

Users would notice increased cycles as vma_merge() would be called an
extra time with vma == prev, and thus would fail to merge and return.

Link: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Link: https://lkml.kernel.org/r/20230929183041.2835469-2-Liam.Howlett@oracle.com
Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3937479d0e07..1e9fa969f923 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -988,10 +988,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	/* Error in anon_vma clone. */
 	if (err)
-		return NULL;
+		goto anon_vma_fail;
 
 	if (vma_iter_prealloc(vmi))
-		return NULL;
+		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
@@ -1024,6 +1024,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	khugepaged_enter_vma(res, vm_flags);
 
 	return res;
+
+prealloc_fail:
+anon_vma_fail:
+	vma_iter_set(vmi, addr);
+	vma_iter_load(vmi);
+	return NULL;
 }
 
 /*
-- 
2.40.1

