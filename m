Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1099C7C4C70
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 09:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbjJKH6e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJKH6d (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 03:58:33 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2066.outbound.protection.outlook.com [40.92.66.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9F792;
        Wed, 11 Oct 2023 00:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ny5MPnkbS5D2qTsEpgmgTpZdOnWlO3JDaeuKddtX2pxpWZbSHszPyZQEKmUg83XWnWs9ItySbtYPt82r+IBdOIwtkz9CGQ9kDFbK6wqW1eeo8ZDKw6D3UJ3mMCf1ZkEJrMPXw3LCZ4WfXACj+RegYOfnXHcNf0U95LtrhNY9kymuwWUbW+Sd9d7cxwCysZdi56OK0UixhrUx5b1BNksiQ+sUiT+oTBIc+KkW8omOwy12oGDAAzchjGYZU6e10e8aTtOZ3q1JKE0EK2GOzeSji5wNQjr0IjI4BVHWui4r7+TagGAtFKD4lkNab56QCAQHPqACxNCBMi6FXmSXXCjqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt3jCKF0v+Uk7RX0BS4ImLfYMkUF1tuR6/wfuaSZWIY=;
 b=VHA0lG2axMIahansaDiCHr/1AC+n9EHT1rlTik/mxvTQTJOQWmr0RsmT0HfWyPvcgs9wOE3xdLdUaBaUqkdBGlViSn5YGS5EdAkFWHwsU3z4tzPPUTVzI6aomcN73LwPToZdRkHsdvjHmIORhTFr5VsqjniO7MKJGIcnHwJr6cGwE8CQud02TxhCWf1c+sJVclTsoLEPb1t6Z+z/hgkh6cafjmZtL1uBk/zwLd/W6ZrmV5dRGPq4pUefbFbRbj14cmuH+U/tV67uYfvHa6pabp2Hc0XG5laWeuLlP1WEj66BENNj9pXnb/VW8jc3U9Xi2SYJfPkDyeTEGyQJ1LS+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt3jCKF0v+Uk7RX0BS4ImLfYMkUF1tuR6/wfuaSZWIY=;
 b=rQ2lRdOhA3a6CMf11HDYaWoaVGlDE5Q6u7OmCPkXWaXsBPJ8NSaE1lqGIOzSnwpEhaLy7RByRvcmmTdvci1BrkyyqH8NBC0KiA1PYQQkUr5C1QcGohJcfMGUCcA1WYBLrzGevyVHomxU/LpEEBEHYQH+OXW1PVZRIG1Bxm28cjZTF8lTui35qu9t3b7MvsxZGRkBvqFr/ao16+M0w4i0vmeztNdguSJLvPXi8yfA8ubrcVNdenjMbeECHNBu1cdSj68zYmt0PajK4cgEXhIWXpJlbg1+1zvOlEf9IIjH50Ylm98X1W9Yg8A6EbjmWSXfylN/yOMz3280Un7+iZToGw==
Received: from GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:97::11)
 by VI1PR10MB7736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 07:58:23 +0000
Received: from GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b03:a641:57ce:d126]) by GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b03:a641:57ce:d126%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 07:58:22 +0000
From:   Mr Louis Holland <mr.patricetalon@outlook.com>
Subject: Money-Gram Payment Notification!
Thread-Topic: Money-Gram Payment Notification!
Thread-Index: AQHZ/Biwia65fHW3GUibQx8DwTkUwA==
Date:   Wed, 11 Oct 2023 07:58:22 +0000
Message-ID: <GV1PR10MB614877CCAD35522265A10236EDCCA@GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [SjmsG84VRjGAegWqCyKppYzyYYZPA4ci]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR10MB6148:EE_|VI1PR10MB7736:EE_
x-ms-office365-filtering-correlation-id: 2bcf2c12-56b7-4fe9-0692-08dbca2fd741
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SYKJv0ROW6Y30RfJ4p+D3uP9vnGg8B36y67rkGKhfrFTiZSSiWGHDXIuRIRS5daPRmt05Rk7grURQGgQH9QDgP2AmMWM+QiRuqRmqI087RsA0ETLu8LEhEXGFCWLhu7zABY+O75pVvKi/dcwV3w4Tib1dpJB9L8/cRuFVEzYC/tl97EvqnC9MmMR9mhvOepnbqGx86B90uiPnaY5AwRmhdzkPxCSTf7QNIaaoDYsGDYLSLG/01SZB96FLdju2KgF93pA6nKIj2bgEYsGZ1xo3DZzrLsII+8S0rXGNO17UnFkMHx/kU0VL5i3m1myuV7avCp65BDhOnqb+9rErrTXRgNBayULEWlnmKv3uydixMIz1SkWXSbVF0BTtt0Egsbug/agwzVpBFD4WWvTiBJ7touAxxoIapcR3nX7hQctupqTR2Ccaqoj7QceWooxLdgRz70VUBYTWy9ues38Vs63DRlY35zbsOVw9a01R6SWt/bUiFJDm6AjrSPzjogWWsV5+DffqJgbJiMG5Sv2PWweVSgwfrgtEtsc/DYjiNWyl0vShhMILT6LuM1yuTyEC1Q5
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zph9mccsfmu2LG73B6/V8ULCeqvATPTnzSSkqcDmA7ZafBbmsuI+7TmI8P?=
 =?iso-8859-1?Q?7y9va6iQP8gq1somUHpGetkOsIK0t1uK7/CfNZ7YGJ+mhbst2PzoyjiAda?=
 =?iso-8859-1?Q?RRqJ+7tQwynkg5u20FbsrtpEOddwMuO33cWyd3d9SyffHWihtVX4JmzD6O?=
 =?iso-8859-1?Q?haaixtmwrzu4oPGgmSlPTmC3PWfohg/51+6G2AnKlVmRcU37vfdZFnNZp9?=
 =?iso-8859-1?Q?+NFDVNzWfrgG4wDZ/NZOU2ijoeVEiKcuEy0jPxcWa8epoSMWsIbprL3E0Y?=
 =?iso-8859-1?Q?kqlfJDRpicmUYv0/0wohNi0DFgLB20T7/pHAl+LR7vA3RQ5cHbX8grKppJ?=
 =?iso-8859-1?Q?2rpgXo0jG0RmrTOdPE7I13WRci2pEL3Znj+Iq6/woh3XHAPlGS6IIwzhSa?=
 =?iso-8859-1?Q?//hagjURy5xwtHC4ren8gmGCIG2sYBGiGB0hbovuhgH7FY0HzBXefYiOs7?=
 =?iso-8859-1?Q?rBoKoVYtNkB0LVZGBHkLCKcHpSAaMq9U1pbHDM9qV40Pvem9EKgoH20jAM?=
 =?iso-8859-1?Q?+tlMXTBi/NHoIZdV5VwbqAzi1Bt8YBGGDFXzEVHxNE2UCLQi7SbX8dXF03?=
 =?iso-8859-1?Q?Et59JVcDbRJRyD1dJiLjGCyO2Jtii5mrvpjnRDhqUcTW4r1bWIOLHnhoJ3?=
 =?iso-8859-1?Q?QLCK5Yf8eEl++cmdw5RFhHT2i+TxfesZC/xDyXc1I0XZIRmi8JB27X7N/0?=
 =?iso-8859-1?Q?IuMlVOh3DJQIR4oPTdvI9xc0BJrEh/hOFn7fuRyFsMr6nyREegq5jOG28n?=
 =?iso-8859-1?Q?tPasrRy9fUIxBmG3WD1IsUhA1hCGaB7Lf/UjutCYq/+a1QhUEiFU9WS6Pb?=
 =?iso-8859-1?Q?nQPtBtT80klgcP4guoioLjHtBGoj1LEI3fKf+DgIUpU8nF+u34/ZxNqtjf?=
 =?iso-8859-1?Q?C882VMAVERJGc3J1c9A2JiykT2JZlaw2fFLjtcbHsy4KdIHZoHKAR5Ov8h?=
 =?iso-8859-1?Q?rIKnvzheUfmnfTatC1FMX95AH/+rVkWTebW4LdVylz4p6Cz0xtpRwe3VI+?=
 =?iso-8859-1?Q?XlG06m0Qbi+Zvy3xDuIm3pjs6UKvBxgtcrakU/8PAQ23Es836N6c2vywUZ?=
 =?iso-8859-1?Q?KSNJ50QbhGQDgmiv5ZfVWj87HiIzfGA8rkX3qkrZxfnOcAGZN6zEQyEG2/?=
 =?iso-8859-1?Q?GwWT0mveS1r23apwLXwrC7f5Z9betLfgPGWyEUK3V0evs+ETJLO1viklMo?=
 =?iso-8859-1?Q?Tx+xgvgHz/GbJHbMcImEUldfLW5QZPcvKl/nEaPviGICSipcsbzqhGpNrE?=
 =?iso-8859-1?Q?7TYRZEx/ZRs3IzvWKHLSjighZcWZmOna4l7Y/FCek=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcf2c12-56b7-4fe9-0692-08dbca2fd741
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 07:58:22.6137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7736
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MILLION_HUNDRED,MILLION_USD,
        MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

=0A=
=0A=
Attention Dear Customer,=0A=
=0A=
This is to bring to your notice that your long awaited fund of USD$ 4,800.0=
00.00) Four Million Eight Hundred Thousand United State Dollars has been de=
posited with MoneyGram Global Money Transfer Services. New Delhi, INDIA. Af=
ter cross-checking your record last week Friday, we =A0noted that your reco=
rd is clear and you are free to receive your long awaited fund without dela=
y. Be advised to contact MoneyGram Global Money Transfer Services Manager N=
EW DELHI INDIA immediately for urgent access to your payment file so that y=
ou will start receiving your daily amount today.=0A=
=0A=
Find their contact email below:=0A=
=0A=
MR HASSANAND MASAND/ Manager MoneyGram=0A=
Address: 13&14 OLD MARKET TILAK NAGAR NEW DELHI=0A=
E-mail: officedesk1978@email.cz=0A=
=0A=
Please you have to contact the MoneyGram Office immediately you receive thi=
s message because your payment files are on their desk right now. They are =
waiting to hear from you to give you more details on how you will receive y=
our daily payment.=0A=
=0A=
Thanks for your time and patience.=0A=
Mr Louis Holland.=
