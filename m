Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6247BAB2A
	for <lists+stable@lfdr.de>; Thu,  5 Oct 2023 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjJET74 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 5 Oct 2023 15:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjJET7y (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Oct 2023 15:59:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525EFE9
        for <stable@vger.kernel.org>; Thu,  5 Oct 2023 12:59:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395IihnC026776;
        Thu, 5 Oct 2023 19:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=XgR2Mjt4nTdvEXbvcwsKsIlnrwGlOWJGZ3WpWO+xDR0=;
 b=4OW8Yh2lBRSHG2/J+gpDljJ5mQ5hBZkbXfBSV9s4w9QIvIY0ky89h6veBUdlKgtT0FEk
 HnB1BkuhTBAMbOP95VomopM7+ufBbnIoePEK/hRVihaeAXSpDTecKhc+iPTC4Z7cuGVm
 m8Swtb3Jq93tpAeXAaB87o8w1pNh4HjxTgzsvPPCfTEmt6r3yuoHTLFHW9MQ15duOBtt
 rQhtO4r8+I08reGTiS/QssPESELEEy4kNL9iULRwjKdUuOPu4C6g+buRWSi95tUodSQu
 /OHeGlUXDy6JbVUgA6nLNWMQKO1vS47ICpNpJLGF1GPM08Jb4V+gyKPMarUmy5u5aWkg jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ejfb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 19:59:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395Ju3wi000499;
        Thu, 5 Oct 2023 19:59:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49hc8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 19:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eniVoBRCQg29KBd42/ZpMTKl1wBNAgtUXu+/9kN5tBDJV/pTgYiSqKRSmpFyD++9QbVR9C3rnz7DSHaGibXV0yWX5gAtsgbZiuxPxK67SjJUD7TydsDeNbGbbJsziQn4I0o47toMucswRzfx6YgxNS+LnnGDML04l4f/iUDDRVgqvK/jRmGS5eicleyuVDGJGtPvYI9aZoCDN8ERZsJceH32y3QVFCTseivK34OZzGChSudnjK4YX4jdRbAe+4WPCKQnn0L56dzzhQWm/Rk+nTywx3huwywIQYyAef157LsuMNOwVFU288D4aJumXIuAe2msgnHcph8xARrWRr8JLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgR2Mjt4nTdvEXbvcwsKsIlnrwGlOWJGZ3WpWO+xDR0=;
 b=ZPK72div7wYF3RhV93My9j4+dWDXT4X5tjpD9b5xz1TfEXvg3W1WXUga8O8Mu3fA6PtpHUtAAzqEAr6dhcG5OCtfFoItZQSUDdHjyfCxoEXDJSZvr8Ro+egnpq7PfrBks7vdsUo6pb+o2M7iL2fVe8IX3daVKsmSRmWoCVaqciF+4/MKKio0aCP88dm4/pRG7fyJcPaX3C60JO3pNzVGFuuYDbJyAzNISz/4S5XBudYjbpW2hNfopusQvEnmuLJk9uahZjH7m/fUCVixErPC3BX2ZSZSPrgvhoS7hfWiUYWpp4yvs/0muhvknbtYR8mtAIhjSwpFWpUb1Jl17FbVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgR2Mjt4nTdvEXbvcwsKsIlnrwGlOWJGZ3WpWO+xDR0=;
 b=Tt0NOjr7J51/r5NPEjpIYtd1xhSNBaM34AqI3KYAYBl4lOCPBSC1AIiI+JKOhJbZrAGvA/qpiH9YVblXmt2kww8Qs3SfbXZHRnP5UyT2EDnL24YD9NZ7gmsDRPK41j35A1/ttNH8YbKYiBkM6aSVxcLJr3fs8XCFjNR8un/G6Qw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Thu, 5 Oct
 2023 19:59:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:59:45 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     stable@vger.kernel.org
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5.y 3/3] maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states
Date:   Thu,  5 Oct 2023 15:59:00 -0400
Message-Id: <20231005195900.252077-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195900.252077-1-Liam.Howlett@oracle.com>
References: <2023100439-obtuse-unchain-b580@gregkh>
 <20231005195900.252077-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: d816f4fd-f233-4beb-b49a-08dbc5dd9f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTFseLjQd4He6IKUkU7H8d7UNkInhx11mpSnkN0eetL1ww2aw5IGibqL3Ejdqgfjm/51ipv2CLI9UtdOZ7VsKpKNVXMAhqqXyvfMrsAsWDxrzv9rtapUrlDYB3nm443IqWHlMgVz//VOysQ9lL2keI3x9/MKbPbn2rnMNmX/5c5OU0TxSQ/HZ6jCve9hnqHVbhiRUGpjCLTNBypNyMgP5JGuGUZbair2Ypw0wEs6nOM3a4ClfcCRBWI9QSnYd9neWs25L9xryLzzmjUUIGcoN/2LsgLRTC0IAqEvc5X2jGg6/4zQtM8HxPFcJ/zOkjBEqbONTGGBpRqlkH2Bc3rMkBRNuQqoh4ykDZpL+jCuBHfuL+Y+2U9NWVk9YzYIsEMDuBOnONaFyTQ885PZ3J17e9FhsFPnaSplZJWT5Wa6R3+AmHpOBee1g6lBYOtPf0cs34FCl0pXhcnh155rmEjC63uGjZkOdoSNrEtpPgSF0YEyc2e9E/vIHbuwaWvHyOSNF/AKIKXegnFuemaDziW/tqlC2PtqgFfoB+kiC99mzTGwi+TgiXpITG6JLjcbCXzHbOyOHNLfHgOhh27aV/J58Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(26005)(8936002)(8676002)(4326008)(5660300002)(2906002)(30864003)(41300700001)(66946007)(6916009)(316002)(66556008)(66476007)(54906003)(36756003)(6666004)(6506007)(2616005)(1076003)(6512007)(83380400001)(86362001)(6486002)(478600001)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Z4raHPGmrdKbs0p+Xsebfmgcxl9HWDj/Aj43BS5yYFgzMSe8QZVoXV9alo5?=
 =?us-ascii?Q?VnpCU2mNdojPo4gTCh5TVwfoDiNWwIk1t9X5Fpb8Tj/rEAoausLiPr+2d2nc?=
 =?us-ascii?Q?kw5NjJQhG2/vopZ8M6lq6y6QMZ8qVOkTmB7GT5asuOKdpsW8LxmrFNlctHht?=
 =?us-ascii?Q?oatOB7VInzseoYqDAmLy+2Yo+V0SQaikXC84z2YXa2uJSKIevjzTf5ZGJDIO?=
 =?us-ascii?Q?grZV2ILBh0alHQZumtSu+pdr1HbJpARWZ7NavKtY9x4nrBLpIm7rTz6lqFiZ?=
 =?us-ascii?Q?SmyjkEiU97eMBLWiTliAbCt+hQ6+J5bPhBFwcYLva1NDM3HYDm3PvJqB6CLC?=
 =?us-ascii?Q?VqOVO8b4IV92yF4gfsmeuDrnaL+py7vZbxhbonpy83XE/v4Cf2mF9cq4hqck?=
 =?us-ascii?Q?FXcT5OX7yMV7MlwR8efRSkcjHh5t3Lp5r4cu7ypiT+LF3B2WDDRjjlpL7rvq?=
 =?us-ascii?Q?iLynijY4Dwku5hKh/6xlwUPHriOCLPMTc4ogF7YY+o/6U+OOmEiuuKmdorVp?=
 =?us-ascii?Q?hR7DXbT47TZJHmwYVrluj9AnNWJIaC2yI6TthA0A7cWB/qBDAZHTUvy18RLI?=
 =?us-ascii?Q?nyFIWBFg363UrJiiXZkDaFWI99p1VmFz8r4X4I1bhIWtDunBgO8s+F01uHp0?=
 =?us-ascii?Q?rLkx3B0e1gn7uZk94AFhVhwy0DxRDTvAboMQIfflwkif4hr/liv4mLRnrl+t?=
 =?us-ascii?Q?d7A6nZ4mkPyzIg31mR379doykRp6bhUdnSJROlhZ8RcPEDzZvD6z+cMXKcRg?=
 =?us-ascii?Q?d82XY7X5i3RQ11IXIrrXu/VEw37IG4K6QCiH2NkZX8tDmkUg3v3yvPfOuvhx?=
 =?us-ascii?Q?Zv2AlCSfv57vYoy36/VyKpPIGeEbgqGnxtHiHq6+pqxncEHYh0ve+UuV1tHO?=
 =?us-ascii?Q?vL9xqtn+Ndub/AJGLrXOKpNgDs0mED6Ehkwtt0fQs8bRKalwaYO+/ncRG56L?=
 =?us-ascii?Q?IiVVZrpsKTMFZib44j0K+Cl3AH2VoN8xdhmqHJ9MRlOtfe/eZsG/O4iF0wg+?=
 =?us-ascii?Q?tMCpFHugSbzgkh078cfv7MzGoiO6By2WEddAASKTnWNNVGswjZkKEvPhTTTo?=
 =?us-ascii?Q?/raDpB52Z6zbf1CexZiCCq+oXMGYEybeJBQk6bwvN9BvxB+kSEnUpcyb7XQf?=
 =?us-ascii?Q?HF1vptaDOxAe69MNoJZieVJG+LdeOpve26LEKMlFEZVAHlGwRtrWf+o846n3?=
 =?us-ascii?Q?3Pe44PdR5+KI4tCgHuChAi3geMP/tH5U1h5VprT7OXpkBrVZyz8ztcnFoQni?=
 =?us-ascii?Q?k1bAmFFACkcD6BsTKKsMw/dSxXAoEiyj8kccI/NH4lvRrJhvrYUDYpcUNj1h?=
 =?us-ascii?Q?9GjVVJ/1m+vnv+EV3pVJtSaVME1gPrgLvdiIsgd0mJSrThC2HQxPO00CFwZz?=
 =?us-ascii?Q?ihzpyeLwomsPH7lpx8yCYG3zgJR+nihgwvP97j9zN0D8lNsinOf71bHulZco?=
 =?us-ascii?Q?Yh1RGsCFzrg7hz9SHLO0r3eAzT3v+bNfv0DBbYSq0CEacPJf4tk22zLDXWSa?=
 =?us-ascii?Q?QjV3PmgpCJHr7jpx/EDzn2f8pXMAqfAcCFZ7QXx/HHFklIE1X1c3JX9k2BB2?=
 =?us-ascii?Q?NfUqfU/PnR/YFhq7PwSO/8CBQJ7gzS+dpU1irckQw6pUrS6fv7e3AqRFIKUW?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7dCAgKxqyvS/ZYHZLKOrhvWVSLiVkcekqeIm5CkthSp4H63TnY3niEwKTA62wFlXtdFRVBYg28xau17iwgrKOGPhA7YcgSfv81pW31mnB2+4nBpS/v8DYqAter38c2zgMiGPZMVGA6iGrd5cx1e02Nycvzj/kwg9uTBeUORBsuKsYvWus1SK6SNE8bakxQhyE4xThIFFHaZfqUTCQOmsF9YwFrMV0tt2PTtUtQkMaMLeBU28aQqNp8EmKqCp+GbfhvmZvrB9v2Q+IZRZ1NppdrZjbPnf1k1RFRr9QZLZWPbfgR3Ha7z/CUjM7MbGXlByEia1xLgI7N34E3OYRzbwUqX2GuwXIci4n/qS9We7v/teoKBcLgstoAnkNVPlaNCAQs2x8Ba7Blo/FzmJ+/B8vnDdqFmmwjXmqLfAxAmv/CvU26RhG1T+AkwzuhOFHqw6M/q8dNGK8vMqS7XfyxGOdp3rAMIV1uvoWT7PbOtqM2kZ8+Kj+j9geutuSfAUoZQQXrMw2LpuUhCfToxODGQBP9wFicm0SdqNibSpevgi94x56idTZeNGF7hyvBEinrVEIbDpFpy6+QJMab5aXEoIw0olkHYh7AqLO55jjMZGFyRFgiTJAGuK7es1ajVQVMS9pavi6azunfCDCrX0arR5bIATqq/uAT4dGqe+fkUIIYe1LnQBpF4p9sOTJ80BbpNn/zHu3OndoOedJd26bEpVkdDzaDpA+0CC6jRorCywQL7y25m3xslj21+o3OIe2pTTBbTn49lyub3cPPKly4wihtC60R+x/EvbFA1mSZXn+EfkoHIFNa2UAJqAatlWim8XeYGQ5xfJsE5VWGQ6/5fnRA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d816f4fd-f233-4beb-b49a-08dbc5dd9f63
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:59:45.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGj+eWbRZF9JqSwin34AXesQp46lvej3Qme0xAgSB1HHTzvNbSwN49QGOJz7xbgI/UqmpBbhMvtGf4ZasGSxaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_15,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050152
X-Proofpoint-ORIG-GUID: ix-TXkiUvc-QiC2kN8T-vSN7AhNKnXrs
X-Proofpoint-GUID: ix-TXkiUvc-QiC2kN8T-vSN7AhNKnXrs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When updating the maple tree iterator to avoid rewalks, an issue was
introduced when shifting beyond the limits.  This can be seen by trying to
go to the previous address of 0, which would set the maple node to
MAS_NONE and keep the range as the last entry.

Subsequent calls to mas_find() would then search upwards from mas->last
and skip the value at mas->index/mas->last.  This showed up as a bug in
mprotect which skips the actual VMA at the current range after attempting
to go to the previous VMA from 0.

Since MAS_NONE may already be set when searching for a value that isn't
contained within a node, changing the handling of MAS_NONE in mas_find()
would make the code more complicated and error prone.  Furthermore, there
was no way to tell which limit was hit, and thus which action to take
(next or the entry at the current range).

This solution is to add two states to track what happened with the
previous iterator action.  This allows for the expected behaviour of the
next command to return the correct item (either the item at the range
requested, or the next/previous).

Tests are also added and updated accordingly.

Link: https://lkml.kernel.org/r/20230921181236.509072-3-Liam.Howlett@oracle.com
Link: https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b
Link: https://lore.kernel.org/linux-mm/20230921181236.509072-1-Liam.Howlett@oracle.com/
Fixes: 39193685d585 ("maple_tree: try harder to keep active node with mas_prev()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
Closes: https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b
Closes: https://bugs.archlinux.org/task/79656
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit a8091f039c1ebf5cb0d5261e3613f18eb2a5d8b7)
---
 include/linux/maple_tree.h |   2 +
 lib/maple_tree.c           | 221 +++++++++++++++++++++++++++----------
 lib/test_maple_tree.c      |  87 ++++++++++++---
 3 files changed, 237 insertions(+), 73 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e1e5f38384b2..c6a19ff5fb43 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -420,6 +420,8 @@ struct ma_wr_state {
 #define MAS_ROOT	((struct maple_enode *)5UL)
 #define MAS_NONE	((struct maple_enode *)9UL)
 #define MAS_PAUSE	((struct maple_enode *)17UL)
+#define MAS_OVERFLOW	((struct maple_enode *)33UL)
+#define MAS_UNDERFLOW	((struct maple_enode *)65UL)
 #define MA_ERROR(err) \
 		((struct maple_enode *)(((unsigned long)err << 2) | 2UL))
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 86e06ec6ec35..b2f1c90c18fa 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -255,6 +255,22 @@ bool mas_is_err(struct ma_state *mas)
 	return xa_is_err(mas->node);
 }
 
+static __always_inline bool mas_is_overflow(struct ma_state *mas)
+{
+	if (unlikely(mas->node == MAS_OVERFLOW))
+		return true;
+
+	return false;
+}
+
+static __always_inline bool mas_is_underflow(struct ma_state *mas)
+{
+	if (unlikely(mas->node == MAS_UNDERFLOW))
+		return true;
+
+	return false;
+}
+
 static inline bool mas_searchable(struct ma_state *mas)
 {
 	if (mas_is_none(mas))
@@ -4560,10 +4576,13 @@ static inline int mas_prev_node(struct ma_state *mas, unsigned long min)
  *
  * @mas: The maple state
  * @max: The minimum starting range
+ * @empty: Can be empty
+ * @set_underflow: Set the @mas->node to underflow state on limit.
  *
  * Return: The entry in the previous slot which is possibly NULL
  */
-static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
+static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty,
+			   bool set_underflow)
 {
 	void *entry;
 	void __rcu **slots;
@@ -4580,7 +4599,6 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-again:
 	if (mas->min <= min) {
 		pivot = mas_safe_min(mas, pivots, mas->offset);
 
@@ -4588,9 +4606,10 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 			goto retry;
 
 		if (pivot <= min)
-			return NULL;
+			goto underflow;
 	}
 
+again:
 	if (likely(mas->offset)) {
 		mas->offset--;
 		mas->last = mas->index - 1;
@@ -4602,7 +4621,7 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 		}
 
 		if (mas_is_none(mas))
-			return NULL;
+			goto underflow;
 
 		mas->last = mas->max;
 		node = mas_mn(mas);
@@ -4619,10 +4638,19 @@ static void *mas_prev_slot(struct ma_state *mas, unsigned long min, bool empty)
 	if (likely(entry))
 		return entry;
 
-	if (!empty)
+	if (!empty) {
+		if (mas->index <= min)
+			goto underflow;
+
 		goto again;
+	}
 
 	return entry;
+
+underflow:
+	if (set_underflow)
+		mas->node = MAS_UNDERFLOW;
+	return NULL;
 }
 
 /*
@@ -4712,10 +4740,13 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
  * @mas: The maple state
  * @max: The maximum starting range
  * @empty: Can be empty
+ * @set_overflow: Should @mas->node be set to overflow when the limit is
+ * reached.
  *
  * Return: The entry in the next slot which is possibly NULL
  */
-static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
+static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
+			   bool set_overflow)
 {
 	void __rcu **slots;
 	unsigned long *pivots;
@@ -4734,22 +4765,22 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
-again:
 	if (mas->max >= max) {
 		if (likely(mas->offset < data_end))
 			pivot = pivots[mas->offset];
 		else
-			return NULL; /* must be mas->max */
+			goto overflow;
 
 		if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 			goto retry;
 
 		if (pivot >= max)
-			return NULL;
+			goto overflow;
 	}
 
 	if (likely(mas->offset < data_end)) {
 		mas->index = pivots[mas->offset] + 1;
+again:
 		mas->offset++;
 		if (likely(mas->offset < data_end))
 			mas->last = pivots[mas->offset];
@@ -4761,8 +4792,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 			goto retry;
 		}
 
-		if (mas_is_none(mas))
+		if (WARN_ON_ONCE(mas_is_none(mas))) {
+			mas->node = MAS_OVERFLOW;
 			return NULL;
+			goto overflow;
+		}
 
 		mas->offset = 0;
 		mas->index = mas->min;
@@ -4781,12 +4815,20 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
 		return entry;
 
 	if (!empty) {
-		if (!mas->offset)
-			data_end = 2;
+		if (mas->last >= max)
+			goto overflow;
+
+		mas->index = mas->last + 1;
+		/* Node cannot end on NULL, so it's safe to short-cut here */
 		goto again;
 	}
 
 	return entry;
+
+overflow:
+	if (set_overflow)
+		mas->node = MAS_OVERFLOW;
+	return NULL;
 }
 
 /*
@@ -4796,17 +4838,20 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty)
  *
  * Set the @mas->node to the next entry and the range_start to
  * the beginning value for the entry.  Does not check beyond @limit.
- * Sets @mas->index and @mas->last to the limit if it is hit.
+ * Sets @mas->index and @mas->last to the range, Does not update @mas->index and
+ * @mas->last on overflow.
  * Restarts on dead nodes.
  *
  * Return: the next entry or %NULL.
  */
 static inline void *mas_next_entry(struct ma_state *mas, unsigned long limit)
 {
-	if (mas->last >= limit)
+	if (mas->last >= limit) {
+		mas->node = MAS_OVERFLOW;
 		return NULL;
+	}
 
-	return mas_next_slot(mas, limit, false);
+	return mas_next_slot(mas, limit, false, true);
 }
 
 /*
@@ -4982,7 +5027,7 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
-	if (mas_is_none(mas) || mas_is_paused(mas) || mas_is_ptr(mas))
+	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->node = MAS_START;
 retry:
 	entry = mas_state_walk(mas);
@@ -5439,14 +5484,22 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
-	if (mas_is_start(wr_mas->mas))
-		return;
+	if (!mas_is_active(wr_mas->mas)) {
+		if (mas_is_start(wr_mas->mas))
+			return;
 
-	if (unlikely(mas_is_paused(wr_mas->mas)))
-		goto reset;
+		if (unlikely(mas_is_paused(wr_mas->mas)))
+			goto reset;
 
-	if (unlikely(mas_is_none(wr_mas->mas)))
-		goto reset;
+		if (unlikely(mas_is_none(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_overflow(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_underflow(wr_mas->mas)))
+			goto reset;
+	}
 
 	/*
 	 * A less strict version of mas_is_span_wr() where we allow spanning
@@ -5697,8 +5750,25 @@ static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
 {
 	bool was_none = mas_is_none(mas);
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (unlikely(mas->last >= max)) {
+		mas->node = MAS_OVERFLOW;
+		return true;
+	}
+
+	if (mas_is_active(mas))
+		return false;
+
+	if (mas_is_none(mas) || mas_is_paused(mas)) {
+		mas->node = MAS_START;
+	} else if (mas_is_overflow(mas)) {
+		/* Overflowed before, but the max changed */
 		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas)) {
+		mas->node = MAS_START;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+	}
 
 	if (mas_is_start(mas))
 		*entry = mas_walk(mas); /* Retries on dead nodes handled by mas_walk */
@@ -5717,6 +5787,7 @@ static inline bool mas_next_setup(struct ma_state *mas, unsigned long max,
 
 	if (mas_is_none(mas))
 		return true;
+
 	return false;
 }
 
@@ -5739,7 +5810,7 @@ void *mas_next(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return mas_next_slot(mas, max, false, true);
 }
 EXPORT_SYMBOL_GPL(mas_next);
 
@@ -5762,7 +5833,7 @@ void *mas_next_range(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true);
+	return mas_next_slot(mas, max, true, true);
 }
 EXPORT_SYMBOL_GPL(mas_next_range);
 
@@ -5789,18 +5860,31 @@ EXPORT_SYMBOL_GPL(mt_next);
 static inline bool mas_prev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	if (mas->index <= min)
-		goto none;
+	if (unlikely(mas->index <= min)) {
+		mas->node = MAS_UNDERFLOW;
+		return true;
+	}
 
-	if (mas_is_none(mas) || mas_is_paused(mas))
+	if (mas_is_active(mas))
+		return false;
+
+	if (mas_is_overflow(mas)) {
 		mas->node = MAS_START;
+		*entry = mas_walk(mas);
+		if (*entry)
+			return true;
+	}
 
-	if (mas_is_start(mas)) {
-		mas_walk(mas);
-		if (!mas->index)
-			goto none;
+	if (mas_is_none(mas) || mas_is_paused(mas)) {
+		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas)) {
+		/* underflowed before but the min changed */
+		mas->node = MAS_START;
 	}
 
+	if (mas_is_start(mas))
+		mas_walk(mas);
+
 	if (unlikely(mas_is_ptr(mas))) {
 		if (!mas->index)
 			goto none;
@@ -5845,7 +5929,7 @@ void *mas_prev(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, false);
+	return mas_prev_slot(mas, min, false, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev);
 
@@ -5868,7 +5952,7 @@ void *mas_prev_range(struct ma_state *mas, unsigned long min)
 	if (mas_prev_setup(mas, min, &entry))
 		return entry;
 
-	return mas_prev_slot(mas, min, true);
+	return mas_prev_slot(mas, min, true, true);
 }
 EXPORT_SYMBOL_GPL(mas_prev_range);
 
@@ -5922,24 +6006,35 @@ EXPORT_SYMBOL_GPL(mas_pause);
 static inline bool mas_find_setup(struct ma_state *mas, unsigned long max,
 		void **entry)
 {
-	*entry = NULL;
+	if (mas_is_active(mas)) {
+		if (mas->last < max)
+			return false;
 
-	if (unlikely(mas_is_none(mas))) {
+		return true;
+	}
+
+	if (mas_is_paused(mas)) {
 		if (unlikely(mas->last >= max))
 			return true;
 
-		mas->index = mas->last;
+		mas->index = ++mas->last;
 		mas->node = MAS_START;
-	} else if (unlikely(mas_is_paused(mas))) {
+	} else if (mas_is_none(mas)) {
 		if (unlikely(mas->last >= max))
 			return true;
 
+		mas->index = mas->last;
 		mas->node = MAS_START;
-		mas->index = ++mas->last;
-	} else if (unlikely(mas_is_ptr(mas)))
-		goto ptr_out_of_range;
+	} else if (mas_is_overflow(mas) || mas_is_underflow(mas)) {
+		if (mas->index > max) {
+			mas->node = MAS_OVERFLOW;
+			return true;
+		}
 
-	if (unlikely(mas_is_start(mas))) {
+		mas->node = MAS_START;
+	}
+
+	if (mas_is_start(mas)) {
 		/* First run or continue */
 		if (mas->index > max)
 			return true;
@@ -5989,7 +6084,7 @@ void *mas_find(struct ma_state *mas, unsigned long max)
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, false);
+	return mas_next_slot(mas, max, false, false);
 }
 EXPORT_SYMBOL_GPL(mas_find);
 
@@ -6007,13 +6102,13 @@ EXPORT_SYMBOL_GPL(mas_find);
  */
 void *mas_find_range(struct ma_state *mas, unsigned long max)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_setup(mas, max, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_next_slot */
-	return mas_next_slot(mas, max, true);
+	return mas_next_slot(mas, max, true, false);
 }
 EXPORT_SYMBOL_GPL(mas_find_range);
 
@@ -6028,26 +6123,36 @@ EXPORT_SYMBOL_GPL(mas_find_range);
 static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
 		void **entry)
 {
-	*entry = NULL;
-
-	if (unlikely(mas_is_none(mas))) {
-		if (mas->index <= min)
-			goto none;
+	if (mas_is_active(mas)) {
+		if (mas->index > min)
+			return false;
 
-		mas->last = mas->index;
-		mas->node = MAS_START;
+		return true;
 	}
 
-	if (unlikely(mas_is_paused(mas))) {
+	if (mas_is_paused(mas)) {
 		if (unlikely(mas->index <= min)) {
 			mas->node = MAS_NONE;
 			return true;
 		}
 		mas->node = MAS_START;
 		mas->last = --mas->index;
+	} else if (mas_is_none(mas)) {
+		if (mas->index <= min)
+			goto none;
+
+		mas->last = mas->index;
+		mas->node = MAS_START;
+	} else if (mas_is_underflow(mas) || mas_is_overflow(mas)) {
+		if (mas->last <= min) {
+			mas->node = MAS_UNDERFLOW;
+			return true;
+		}
+
+		mas->node = MAS_START;
 	}
 
-	if (unlikely(mas_is_start(mas))) {
+	if (mas_is_start(mas)) {
 		/* First run or continue */
 		if (mas->index < min)
 			return true;
@@ -6098,13 +6203,13 @@ static inline bool mas_find_rev_setup(struct ma_state *mas, unsigned long min,
  */
 void *mas_find_rev(struct ma_state *mas, unsigned long min)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_rev_setup(mas, min, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, false);
+	return mas_prev_slot(mas, min, false, false);
 
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
@@ -6124,13 +6229,13 @@ EXPORT_SYMBOL_GPL(mas_find_rev);
  */
 void *mas_find_range_rev(struct ma_state *mas, unsigned long min)
 {
-	void *entry;
+	void *entry = NULL;
 
 	if (mas_find_rev_setup(mas, min, &entry))
 		return entry;
 
 	/* Retries on dead nodes handled by mas_prev_slot */
-	return mas_prev_slot(mas, min, true);
+	return mas_prev_slot(mas, min, true, false);
 }
 EXPORT_SYMBOL_GPL(mas_find_range_rev);
 
diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 8d4c92cbdd0c..4e7fd364f0f1 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -2039,7 +2039,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 5);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
 
 	mas.index = 0;
 	mas.last = 5;
@@ -2790,6 +2790,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		exists	MAS_NONE	active		range
  *		exists	active		active		range
  *		DNE	active		active		set to last range
+ *		ERANGE	active		MAS_OVERFLOW	last range
  *
  * Function	ENTRY	Start		Result		index & last
  * mas_prev()
@@ -2818,6 +2819,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		any	MAS_ROOT	MAS_NONE	0
  *		exists	active		active		range
  *		DNE	active		active		last range
+ *		ERANGE	active		MAS_UNDERFLOW	last range
  *
  * Function	ENTRY	Start		Result		index & last
  * mas_find()
@@ -2828,7 +2830,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	MAS_NONE	0
  *		DNE	MAS_PAUSE	MAS_NONE	0
  *		DNE	MAS_ROOT	MAS_NONE	0
- *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	1
  *				if index ==  0
  *		exists	MAS_START	MAS_ROOT	0
  *		exists	MAS_PAUSE	MAS_ROOT	0
@@ -2840,7 +2842,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	active		set to max
  *		exists	MAS_PAUSE	active		range
  *		DNE	MAS_PAUSE	active		set to max
- *		exists	MAS_NONE	active		range
+ *		exists	MAS_NONE	active		range (start at last)
  *		exists	active		active		range
  *		DNE	active		active		last range (max < last)
  *
@@ -2865,7 +2867,7 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
  *		DNE	MAS_START	active		set to min
  *		exists	MAS_PAUSE	active		range
  *		DNE	MAS_PAUSE	active		set to min
- *		exists	MAS_NONE	active		range
+ *		exists	MAS_NONE	active		range (start at index)
  *		exists	active		active		range
  *		DNE	active		active		last range (min > index)
  *
@@ -2912,10 +2914,10 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
 
 	mas_lock(&mas);
-	/* prev: Start -> none */
+	/* prev: Start -> underflow*/
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
-	MT_BUG_ON(mt, mas.node != MAS_NONE);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
 
 	/* prev: Start -> root */
 	mas_set(&mas, 10);
@@ -2942,7 +2944,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.node != MAS_NONE);
 
-	/* next: start -> none */
+	/* next: start -> none*/
 	mas_set(&mas, 10);
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, mas.index != 1);
@@ -3141,25 +3143,46 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* next:active -> active out of range*/
+	/* next:active -> active beyond data */
 	entry = mas_next(&mas, 0x2999);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x2501);
 	MT_BUG_ON(mt, mas.last != 0x2fff);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* Continue after out of range*/
+	/* Continue after last range ends after max */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
 	MT_BUG_ON(mt, mas.last != 0x3500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* next:active -> active out of range*/
+	/* next:active -> active continued */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active -> overflow  */
 	entry = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x3501);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+
+	/* next:overflow -> overflow  */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_OVERFLOW);
+
+	/* prev:overflow -> active  */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
 	/* next: none -> active, skip value at location */
@@ -3180,11 +3203,46 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev:active -> active out of range*/
+	/* prev:active -> active spanning end range */
+	entry = mas_prev(&mas, 0x0100);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active -> underflow */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* prev:underflow -> underflow */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* next:underflow -> active */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:first value -> underflow */
+	entry = mas_prev(&mas, 0x1000);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, mas.node != MAS_UNDERFLOW);
+
+	/* find:underflow -> first value */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
 	/* prev: pause ->active */
@@ -3198,14 +3256,14 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2500);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev:active -> active out of range*/
+	/* prev:active -> active spanning min */
 	entry = mas_prev(&mas, 0x1600);
 	MT_BUG_ON(mt, entry != NULL);
 	MT_BUG_ON(mt, mas.index != 0x1501);
 	MT_BUG_ON(mt, mas.last != 0x1FFF);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* prev: active ->active, continue*/
+	/* prev: active ->active, continue */
 	entry = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, entry != ptr);
 	MT_BUG_ON(mt, mas.index != 0x1000);
@@ -3252,7 +3310,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.last != 0x2FFF);
 	MT_BUG_ON(mt, !mas_active(mas));
 
-	/* find: none ->active */
+	/* find: overflow ->active */
 	entry = mas_find(&mas, 0x5000);
 	MT_BUG_ON(mt, entry != ptr3);
 	MT_BUG_ON(mt, mas.index != 0x3000);
@@ -3637,7 +3695,6 @@ static int __init maple_tree_seed(void)
 	check_empty_area_fill(&tree);
 	mtree_destroy(&tree);
 
-
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_state_handling(&tree);
 	mtree_destroy(&tree);
-- 
2.40.1

