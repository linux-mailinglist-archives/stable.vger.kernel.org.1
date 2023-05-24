Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD270EC7E
	for <lists+stable@lfdr.de>; Wed, 24 May 2023 06:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjEXEWI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 00:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEXEWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 00:22:07 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2030.outbound.protection.outlook.com [40.92.107.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92145C1
        for <stable@vger.kernel.org>; Tue, 23 May 2023 21:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYo7ZZYWMSOfKHDPKYuLXrtarZhiNxNeHB1Au6Gx9RgMXbkprtocOKgIdEtALhuyBeDiHuSKR2v6RT7l76GTv7ORbuUX64IEQvOYhmK0r0S1tvjloAw9dBGf2cEG5zlaX3QDVA8b8MngT5AWH5ojC4jJxYFzzX8EjUMMna1SDb5fxBQ6reVscm0CzhjMgX97x0lFQ1z3Kf88CJaZDfAXROindUZGaJZWcpYWSOvFuI0G2uCgpBagX1OTGfcpfClmjgFcMqQF1Eltt6671LCCXTsWQfvP3zrds5PwJW0GjAYmRIgHEo/Z+h/V+qy0XkfdfS0RjNq00veKKgUjt0bTXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=h+vgDCgsrIr4j/zXCM8ugzKx3VlzY3G0YO/mfgiDrd8IBAMGO86nmq+0FFCCPoLeRNHnwSe8adEFAXUGJfh+p/4t16hJDEZ+5PQDvvvLaFAFY7e5aaFWn7sTN1aum3ICH89XmhMAXbqKC22SKLKe0zIWMIoIeTMDwk/7P+jQsSFXZkuyvMF+OreJ82DrYLBdPNhANtynaRr3WdwTc/0+bjENluyFQWCIvFoLQ8N+AGEQMztjeePM9/UMpQh0G6HZno5RmtlvWqII9qWW3ags3MTgHKJyYgwD1zNMf4j0Pe4ZFd/csJCOCllBCRHzDWxiOawAn074gYGKHZTVA1o5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=KPFCfYHmnfBRPvnki1F/4rlVeJJThLNzzOe8Z48lBq5yj8J2RDd/n6Spk9HgmMGdHkLJrGSxd5omBLRsNZwINtap7RmLUH41fqbjFsLmjoefnwKJWsqQSYZPpo28pxu/9GouKo5uGzADg8s9eZNOlBK5In38avlYyQDJ6msHC86YlcuBCWAMxZokoaRC+6t+XbZq6ZK4I/ZDqa+Fj7fkIY4EpkHlPkum/J/xyDZ87obJjo/M+lF4W9Oupl7E1x30zzxjeQCDjce8RSOJKt5ncrHrhnhtSkyFMaAdcUeDe9eCbDDWhYwht9sPQ9b0+xGYwNyubDK9YeqGZ7zaxeEQew==
Received: from TYUPR01MB5233.apcprd01.prod.exchangelabs.com
 (2603:1096:400:354::16) by KL1PR01MB5116.apcprd01.prod.exchangelabs.com
 (2603:1096:820:dd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 04:22:02 +0000
Received: from TYUPR01MB5233.apcprd01.prod.exchangelabs.com
 ([fe80::e579:3b14:2979:8563]) by TYUPR01MB5233.apcprd01.prod.exchangelabs.com
 ([fe80::e579:3b14:2979:8563%3]) with mapi id 15.20.6411.027; Wed, 24 May 2023
 04:22:01 +0000
Content-Type: text/plain
From:   <uywhddtycf@hotmail.com>
To:     Undisclosed recipients:;
Date:   Wed, 24 May 2023 04:22:00 +0000
X-TMN:  [ExPRYR0L8oI+SEcabz1aKDCGmXe/8iR7nT34T7ZO6wU=]
X-ClientProxiedBy: TYCP286CA0039.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::13) To TYUPR01MB5233.apcprd01.prod.exchangelabs.com
 (2603:1096:400:354::16)
Message-ID: <TYUPR01MB523347EE94ECF53B051271F2D4419@TYUPR01MB5233.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR01MB5233:EE_|KL1PR01MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a7c2e7-52ac-4290-bbe9-08db5c0e6bfe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1N/dw8uQvVAR40Tv3OhGetQbVwrCDX7y6pFhmCqHYyo5fnXOwFc+aqY/iztpt0Jaix2td8e49G6rskM8dInwFZnm5QbfuK9mHqYg06nUVZTTKDrOhHSnAnEDEKKIENdkH3ucgpMcVkhKuayTVdTkLQCl7kav7pLkVx7HVOxox9uWzZ2pWtUrx8U4tOXB9KPWdz92qg1ulTlJ1fK/VG4EFXusUx2b17QacS9JPY/4+i8GSGnruJkymr4ny7HgACwH3MwKhX1jAtPyyR8gfzfI4fPkJZhtBcnYnmDBVzs8EHM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owePdeNCC8iQOAkZVi0iF3ADa7eJDHJAjZT+03shVy4SKwo+pcJRjYdYmphk?=
 =?us-ascii?Q?4pp6wCYfJTF97lRdhIU/wxWqy4AW6lgoB4Exxyknt76YVPxaVKFSg5vD0RFt?=
 =?us-ascii?Q?CnBjD99m86g6aWI/Fs7NwEu5LF9nYg8j5tFNtJ0CJwT/dSkMU0cfOjJPoaeZ?=
 =?us-ascii?Q?2n/geFazApOhDBB2L3I0bJ2pwo8haa+S3teN7NPcQks1BdxRRBI0yA+j0DbF?=
 =?us-ascii?Q?U5nE4oeA6JoyGyMysIPGTkhuwsGEE3+Feh1F0WNZMAd0N/utTLQeGMGqhHjj?=
 =?us-ascii?Q?a84AAQQmeAp3XrUwwJXQo6RfkjyuDE2WqYbpcPBqs9w1CF4qr0761tcBuPzH?=
 =?us-ascii?Q?cOFzqUd+ZmzLQufiMV4l4dVnGv000u/SvE+7ZQ6pihwsI7DJ1LIHjnjQ5Iqo?=
 =?us-ascii?Q?BDARcbPK6zBU+QjwIh0OGL9er8nBTVhpoY3PL0NTXtfpTJUzwh0+EnZdFPZB?=
 =?us-ascii?Q?/NsY1K8z9cibSr8LJaweN5npN4x/ajXglajcTGRnAs7+0VodWX6VLJ80W4hU?=
 =?us-ascii?Q?cl9Tjra2PlRdoDOj4qG1l+EqaHR1xzqoabr6jAnNdoMBv83iI7lxV6pwK540?=
 =?us-ascii?Q?qNTbWxYwXiLNkE79k0ILEhUl394St77opqO6wj/aYMuI84H1KpKcdRe0Drp8?=
 =?us-ascii?Q?1pJLC8Mpyy2AT1NiaLxS3a9HJkQLdesH85Gj9MFEjiH8jBeiUNTPDK3owzlc?=
 =?us-ascii?Q?GjlMOA04leAojxuXNTnzrrtWnSgYVBjFHJrbopUDLOGf9DAxkm3AHy4MiZiy?=
 =?us-ascii?Q?wZCZM5EXz7GTTfD4uP8Uo6vxdYo2/uFKsEhdjUrDwSWnpikwJs0iMPUzX8QO?=
 =?us-ascii?Q?3/Oo+gGRHQr9zGKpb4RrWXpX7Q4bql2KKX9OxJ3AFhtRadpZAOjTENRP8Za+?=
 =?us-ascii?Q?pSy3lr2uyLI5KzztdW0PgKavh8KXQMtA9MUSQTxDUXp2ikq4Q1heq+oWW4kQ?=
 =?us-ascii?Q?bp7M82NZPGwFfW5k4IH10QcT+j+i/82dNTEGT+GgS6rOZFlfESz/EjOwvWhQ?=
 =?us-ascii?Q?LKLNh5v+fUz56wql0bradPOJPYReJ8fAUK4CeEG+LgADxtQC+WPwuqbYooOX?=
 =?us-ascii?Q?wgZGnkEcPAb/Opx00FPX/0C7EKgdpvgGay0LaRv7dCxjpN681z+Bol7d8ats?=
 =?us-ascii?Q?dGqZ8O0/4mClKx531NVP9K8PCkpn6uCq9jVZa9ocvA+ee6dwxpY7tOJqGI91?=
 =?us-ascii?Q?OLyd90EpOqCNtuI4742UT5qVALbK4aT7mYV/VBbu9sY9PDVQx4daNPp9P8I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a7c2e7-52ac-4290-bbe9-08db5c0e6bfe
X-MS-Exchange-CrossTenant-AuthSource: TYUPR01MB5233.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 04:22:01.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5116
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        MISSING_SUBJECT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

