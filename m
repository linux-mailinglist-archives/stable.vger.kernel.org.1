Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB47C64B0
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 07:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjJLFnl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 01:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjJLFnk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 01:43:40 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2099.outbound.protection.outlook.com [40.92.99.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5559D
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 22:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXywbMR+1fdpHVJjxY72deJLzUjCak4PlrGzTbkkox/xV9lYXKvKwzSV8ui4Kul1I2qZ8qf3H/Mb7Y96SlV4dFC3DrwZQdFb1I0/RNvLQTwGw6wR01agX/6LN6GUL5Qrn4BeO9bOTTcyaW+8tX2901IM6sbJWBbgKNbocG4tjRW8Y4pREAIQ+OlZjb9JBeEvTpKou+y89P93XSq7AbXuZCqAyF5CEM4dIjzenfe25GzJYaZ0KpqqlU4ya/26TiRYtz7TiUsoK/dCoCZjJ+clg9GeRT8jfbUmKTCSljkzMDa+wJ47vXnbsiWpf+UOOBIvZZ0WzBirqWKenmNNuLkNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj6+RhINqI2G4almNAEtBxni6Rx6HEckJh1OmuAPXbo=;
 b=R8zygRvUmHYR1btSaNW9+YzM/MA/5pf2SuT0Ju3V9LUyBbyux3mM2+l14uyDfhukfk57/8N0atlBs2vYM96d92bMIgJMYY1B2Pp2GBN+XQak2nb/3cfYo+jMrT3Ae655OzVrkvyuJ/YDPIBX8S2KsSpPXDfMC44zkV8XK7th5vhPwTqA3oo23hqOzm5H/Lu/lJQe1Rp8N4qEAg8a8BKLQMWNx3Dr2apxeqdZJBfFkg+qCVkDiB/vETlwZQWeLKM+f7zV8kdq/+j3ZH/ha7ZFkZv45IecqOj897PMRYEOoiSlFPZeGuYe39MK0shzZ7dKBkWPIbdWc6K93LRBrhpPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj6+RhINqI2G4almNAEtBxni6Rx6HEckJh1OmuAPXbo=;
 b=fG1eLpz3+SPv6k4/ywMSlmTjjkRxHimz6HA2DPFOHT0jFFHz7IcZIaBUImBPWP6qVEtkOQE/f8tTNZTLYB/g4wF0wovf5wl5BX2vrch9rV4O/Rdf3PbwE1oPbSh/2noKwuWk7SZ+DMBH4nR5Fl5X97S0hgEY1xB8Z6Op0LVowDaKLbj4JtfOKtVU/mvfaa3H1PjvtAeDOvFHHB5eSHWfLpAhzKpzGimKztOH0qTaLj1zpmsAlfYS1zq9u4dvP/+CJ/VjKrFL/ZxWi/sjdMNtZxZ9UPTdoaVsWyn76dN9tGrzr0wp45e5Gauo0yoFvRbtQra18C7e2ngtiEU79jg47Q==
Received: from TYCPR01MB9507.jpnprd01.prod.outlook.com (2603:1096:400:195::9)
 by OS3PR01MB10359.jpnprd01.prod.outlook.com (2603:1096:604:1fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 05:43:33 +0000
Received: from TYCPR01MB9507.jpnprd01.prod.outlook.com
 ([fe80::3e75:99d4:dac4:beb]) by TYCPR01MB9507.jpnprd01.prod.outlook.com
 ([fe80::3e75:99d4:dac4:beb%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 05:43:33 +0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Empowerment Grant
To:     Recipients <bigfootdelivery@outlook.com>
From:   "IN FO" <bigfootdelivery@outlook.com>
Date:   Thu, 12 Oct 2023 11:13:11 +0530
Reply-To: info@imf-grant.org
X-TMN:  [IrXIZmPskRS4ZHRY+nXpu0frp5QONIvb]
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To TYCPR01MB9507.jpnprd01.prod.outlook.com
 (2603:1096:400:195::9)
Message-ID: <TYCPR01MB9507C03B95D7CC7886436E2EBED3A@TYCPR01MB9507.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB9507:EE_|OS3PR01MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8b5d5b-a516-4c23-b844-08dbcae62b97
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1dszHOQYnd5j3zz5iVno4WnIKj7Pygrf+JuVOZIO0/nKMh/MFcLH6IvRBfV4EuZXPly3Le6NP8y1XaO9usW9Z5HttVW++smqfRPiUpnR5Gk35JosQi/IKuI6/6biRuNp2cgEsyRYMgjW1nTdDYNgV4UWqLTF+vgQLSRDbbHJmo2g+bUx6mDSM/9aZHR4rV+FX5izn+HaQtUMF91W6xohvv+SyjQTVtxUQuftEYeiyPIsq96Vre04U8U2J8g2qMmp2oz+qjro8NUFpEPEaha3XXFN0/JaoAcB4cHSzrQTSYYRzAL8FKkGkam05OdMXtsWGzwJW4c3r6K8/TVMTCtgmHTR5H22jYApiJaT7jWvVLD1gan23EUq1rLvRGv6ri4PfJaKsMaeLdnXBNlseLhgpvPrfy+71uwPid17xF4dzAfvDxV9ZW314pgdH9iqC//Ug2JlcbHtkCz8sQKTqY7fKO8/IBvJECHnSp0wbvACpVM1/mjpK3g8cQtD8ihoQ8bsee1fB2VpGGAzloUHHoEEC16VULx4ANc1hv/P9zX4htxUcYV+9lcatxeC4b+AN/kptydHX/VnkAZPbWFkdu/mgSJafhj09+MsjF/b3TqHLFHMGYPdK91zlY0mMscClCL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fFl9h5gng6vOztEgawyJqK+OywTZq2JyA44xmGy+leUljVqS0yPPGEW5Yp?=
 =?iso-8859-1?Q?ehEu+HTXyeAkW5JaOqXVLU/mzyRZGWVmKjM56sRh590dQPaf6zkTQxZZ7b?=
 =?iso-8859-1?Q?TughsgrkvuV+8FfDOsfbDQykNqLfW04GVGZ8VEBncTeLKDUJHT9SGhknZT?=
 =?iso-8859-1?Q?j+N+/dFvMKQjQyp6Yiaf2pX/7Lc8KYGMKA5FQfXNRKLjn/WiCyI+he7J/r?=
 =?iso-8859-1?Q?MHv2RL9Assccc0acWhlZJ9jXdB5WKgWDHmldOOHK4NMG1/eUHE18IRicti?=
 =?iso-8859-1?Q?qREgIfMCq4lqKssajDYDUM8QxnNAxP7wr1YY3ctq9gqEQJKxi4vwJ5kqUg?=
 =?iso-8859-1?Q?gA6YnvKi4S4qCegcB3dOvWm2hTGv6dlnWRvXs77YCGfI0WQ0QHk+QPYTrs?=
 =?iso-8859-1?Q?uWBoNsqpV4ZpKVJrjlv38K4YpSxtJsjP3JcHunEqrkHUFEZEgOOavx8zdZ?=
 =?iso-8859-1?Q?0tlowlXBQTvix3P1ppwUIcKOl0QXSkAzsKHlT5GfyYRsmBwGN/hgIZ/xTz?=
 =?iso-8859-1?Q?sNNZ6qQq1h31hTi36dSKx+NJ/PVPtz4RghBQ2bLar3+99zYovqBrJXW1zl?=
 =?iso-8859-1?Q?+PWihvxsHRNkcmREKgxE7+XZ5NWLEtJeutPYifmhVryzmpzJCVDWRyU+57?=
 =?iso-8859-1?Q?UQekgwGXbYUyNQXpv8xW6RNfN3fjhak6THBDWtoAS6JeiP1oyNkSH6XKJe?=
 =?iso-8859-1?Q?ON/KjG5i6B4jM/IHgqhQMfw43YeujmHlA5RSUTliDF3a7+pylALqUfCqpI?=
 =?iso-8859-1?Q?fJmIMkQgRYbj8S8PrHLCpBhVjwcyEHok6rEZlXIoksAwkZvLGYTEv/V2tK?=
 =?iso-8859-1?Q?Y8uIoduEckHWG9vwESJn8xIsqbiK5jPaJdTx2ALiJPzjr8nnpJ2itZ9RbQ?=
 =?iso-8859-1?Q?/oVxpLT7mVpsEbEbV3tqt+F56bFh2IlWKpMFeqRi8B+rYld1UBe0JfH5Ru?=
 =?iso-8859-1?Q?gi0b6h2H2kg9PjoleKHUfpiZ+fIot10pTMOQe7Nfn6r86s4nBDuM9reWf0?=
 =?iso-8859-1?Q?gtHa8UDaMwNvy2P6ODnp3ataSp4FjGmTwrVRBcA47rlkrQHe9AhMzTbmGZ?=
 =?iso-8859-1?Q?fzXmOGjYIk3qXVuPWPsyX3SJeTPrdd7jjlhkBwd/8e+vVBpTP8PVYOrl5J?=
 =?iso-8859-1?Q?IKxHOtTMxVj3hT7ZScnAqecs2N8/yDXLmsrbPN9WIZ3TYwfWmkfKVARkD5?=
 =?iso-8859-1?Q?R0iYktQv2OvkoSwIhu8goIia9TOCs1gi8ceTCZUvNTWFj2um0y2R6kyHJT?=
 =?iso-8859-1?Q?IL3OniwAnpNPlwF0k5ggJreABrQqLcE/LbXER1I08=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8b5d5b-a516-4c23-b844-08dbcae62b97
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9507.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 05:43:33.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10359
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

 =20
Final Notice:=20

Congratulations!!! You are among the 50 beneficiaries of 2023 IMF-UN-World =
Bank Grant. Reconfirm if this email id is active for more details

Regards,
Mrs. Oliva Pathe
Communication Secretary
