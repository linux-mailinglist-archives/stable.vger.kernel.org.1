Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABD7C4C90
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJKIBu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjJKIBt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 04:01:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2065.outbound.protection.outlook.com [40.92.73.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B826091;
        Wed, 11 Oct 2023 01:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nhrc4ocmXgQ8x8ONBB1fJ+/6EYdkJWv3QlDgFgZCmZSd3Bc4/LL3cZKcoEDlD5MsXhGME/RvqEnOpix7Oqi8R08DNoObYnLWKrx5w3zRJn5tHsnMkNHOaSOAPhnj2e1PHKnm2t+mihxRFvAII9j9tKsY1BJr57sAaylIxve9rlGcJWRZuYLiH4iPT7KLDACK1rBvIKG7rsm3obc1JGEzQgndWHykGVqXEy9Ok3MEPnoq947jkxsgn8ONRrfIIsJcQFTzV58tBO8WPT3UyMw4xvzFovsCjz8WBzOHbEXRArU122DY6Q1ilsgavPOfuPpThUQxtdaD/pKk+4BOHhd+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt3jCKF0v+Uk7RX0BS4ImLfYMkUF1tuR6/wfuaSZWIY=;
 b=XdCDK83uSAKN3HEUrzzOec2K3l1UGNdXXFnibt2g9M5AUh69b48cRLFB35xdf4a0bfcH9rWgvAxXw271g6bZ0ZDUk3Dc+z7AWLDzmY8cjiwNa/K+GR6aVL/w0aFUgcDeFgA9RgjkVkCSmWsEgq9tTczS/zH6xZybJXZvJafQQ9OfJX8Jb8x6pL6EKxcdT3cCJRvfES6tZyog0HoAHiTausU7a2wa3UO9M9On+BHVw2vSZCU39rSOWgByjb2g7scjLjFFdBYR8VYwGzE/FdDvaN4kGGoWPTgw/miWEsJssltsuEEmrQGGUn35XuahvmcdSQyra+Dhw9tp2WnjdMetMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt3jCKF0v+Uk7RX0BS4ImLfYMkUF1tuR6/wfuaSZWIY=;
 b=fFUT2J0+S9UxIOjmR+7G4G6q6y0w+pnUMnmkqXsmVwA0Ub2Tkq6e98U945qFbZIxj3fBCf8nuVzS9EZq37kbGgfQGtmp8IlXb0UBjV3B/BxF3zFnVsNyRG9TQc8aZEMqZ+scZdgDYYaEoPeoWt5iAM+y1pAbLkgViwP+pwD/rdv3so5ImCNCP+jTI75dg8s97pCtz6999IMAYET8Lx/ShY/JvbFOGjJgQ5rXIVwK50vhWFFZ4QVSodie3UxsJPwinG0A8u8uLOhJCzsrWoHt9b4w5TrTKmNeFfenpScvwqMJGwEVP9SWM0sfe1Z2ajAEvM5kWP/5DelGaIM+vwfX8w==
Received: from GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:97::11)
 by AS2PR10MB7155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 08:01:43 +0000
Received: from GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b03:a641:57ce:d126]) by GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b03:a641:57ce:d126%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 08:01:43 +0000
From:   Mr Louis Holland <mr.patricetalon@outlook.com>
Subject: Money-Gram Payment Notification!
Thread-Topic: Money-Gram Payment Notification!
Thread-Index: AQHZ/BksSUiLOQYtQkSN+kwRJ6oQ5A==
Date:   Wed, 11 Oct 2023 08:01:42 +0000
Message-ID: <GV1PR10MB61486E9A5DDD69198C8628EFEDCCA@GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [hKi5+eOmBWVYTPVzC/iGys1fdkM24J9l]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR10MB6148:EE_|AS2PR10MB7155:EE_
x-ms-office365-filtering-correlation-id: 82bc38a0-526b-4dc5-c319-08dbca304e9f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wiXEI423aOEgy0A1lew7vnOogTV29rPGw36GIHspIRU9rfKF43sT8EUfQO4IHACVV5r2Maz3DcFxFyikOuOPgHxn89+hHsgq1T9P4GoYDHKbLiOo/s49z7J0jsVgu2SJT7zBB/GcZ+wy+oGo5L51sCdt7FnrqMEDjsdUqkstAcWQTL3rG1/XfS0JZ/xmT9ISytQc3gJuul8e0yOwzmL1pkBRB0nYuH1keZ/3ACZDp89SIRmSo7xDxr9kHaGAKGfGVfWLAOzdSFgowyZ3MSIb5zl155QoXNMx1KfZYBph+Q2kQpc8/AbvJc2+SLnktXtiXAO0hciAJjrWep+I46pq7d44PUlhC/sgSBHwMJkirZoeHAymeapPiLe0cdoPtTzGNomU9uBNoXqtDUTPUNCTIo2XP7PT1TsQR4m+PvWoOpBI5GbsExgQ07yl1Dt6T086CwWQ5L0P4nt+2vN4DMfLDnjTw92s98l/HM98h/O/RXB6Jt/7Gzk98c8G78v0ZDIwfL6LWYLSdc9oBP0+leRhYPBMEoEZn36wmoXg5vIXRwncYx+RB1gE9Cfhrcn+TmJE
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lfOpYo5GVbhUXo55b1ngucrT2WVpq75DlWH1DFAZyzF2gFz/XVpVDAEuXF?=
 =?iso-8859-1?Q?e5xHPxOjjDBw56Ef7qSkIsoaIGveLq18pUcukXTrF/53FGXDgQMqkWSt9N?=
 =?iso-8859-1?Q?pfoBkhTAeo6Hy1PLcaOT5KRTmyUW4LXZ9aOuP0c1tdL9cLomg6N7Wh2MlO?=
 =?iso-8859-1?Q?u9ZxHCEZ3oZnhpCEDe+UwTO0qSps6SiF6YGXBH06sze47sAd+O15fMIz32?=
 =?iso-8859-1?Q?+Ky5B5ABmseXsdP+VMUmxnnrQBxGGgj0Hd35abr6sFa0iPxbFDnclItDB1?=
 =?iso-8859-1?Q?AeR1jl2PDw1f/nAC/2+EVyE9ja1VaakKBV6zBp3GgBgYcRqbSs24dG0Xgb?=
 =?iso-8859-1?Q?WDfVqd5tJftMh02SH1KegllSPTvamkwdtb1PBJhXQUnJJsqJFxM6hzUyYP?=
 =?iso-8859-1?Q?hdBq8wRZDWpV5l6rOJ8kHXG4VXhXlgBsS/Lxyk0AzS7/sA0ds4TfRH9Sbu?=
 =?iso-8859-1?Q?eTCpYBmzIy7+DrhHbDHp8mYSynUsvFXeCQ2PMOvCfxw554sFpbIz1N8zBH?=
 =?iso-8859-1?Q?BxUaXrB6lnMbMspJr57tLhRbqU4EtLeVXCT1s+fN/Vz32dW+erdx7MKq+J?=
 =?iso-8859-1?Q?/e5nJ+24bgxpYfKOQyVig8GSbzSE7wjlcQnQQ1ArDrZzw/6iOSftQfF7vh?=
 =?iso-8859-1?Q?2Lt++4WrblBJhG8bu4/Yx1njgOFY2Bu85CnsRfP+KlmE2thm+PXVFNqIHE?=
 =?iso-8859-1?Q?a51AGLd0cbIBxy8nB9e+dgGlZQHcdQcCQOOdO0ssaFf0qrmS4fKY/mnGYX?=
 =?iso-8859-1?Q?zEx633y+YVQniti2HbX64e75UKCtkKEmjJZ3SFz3RW8/Et/H2BzSDDbl9a?=
 =?iso-8859-1?Q?+s6AgDTcx7tjqYAa/vc6qxveedG/A+2MpV7obQNaUf02sFpreVAPayVTzq?=
 =?iso-8859-1?Q?jGsx121k7IKWK26EVRDO2qWkxoc3osx0ntPZzqodCdHwulMfu9HoDx7x8m?=
 =?iso-8859-1?Q?fweQT1nQWmRfpJjrjS85icV8uoZC2Lcu52+CZazYcx0m5/fJwYxsV9Jo0A?=
 =?iso-8859-1?Q?i2mZSKfHURFd59c9yohpxys/FT2phtPMeFtkpwtcgMJor4+UOxXWZumf6t?=
 =?iso-8859-1?Q?Xj/ky8eMKBLYbhHhXALtatTCWV680LO6T/90Jorh4XsrRa4e2umGaXBaUt?=
 =?iso-8859-1?Q?Vq/WGhs4RrTUzafSfDnwRsOw813hyvEzYycg/PdGs+4/rgri6qqOMJeEAL?=
 =?iso-8859-1?Q?Azu2H9OC6xkAy+sEIgxUHwqv5tG7Jc457hQ/6i49mXqV1iSNhnAVQ5cklH?=
 =?iso-8859-1?Q?xe2BsL8ov3tGyH6uIxXSYn8X05fzhDcK7G93knQ+s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bc38a0-526b-4dc5-c319-08dbca304e9f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 08:01:42.9099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7155
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
