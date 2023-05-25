Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B04171025B
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 03:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjEYB1G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 24 May 2023 21:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjEYB1F (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 24 May 2023 21:27:05 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2048.outbound.protection.outlook.com [40.92.107.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC6F5
        for <stable@vger.kernel.org>; Wed, 24 May 2023 18:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUTKyfze2JUw+Mh4CUIgNW3TFTcZjwugtY0it9DMFDljxw/+WJtFOLYXNg3CavSOE47IkYwbEoXuetBDsx3DjhQ6n/SuI4xiav/pD2S3kNyHKc4lYVEelgTaLkr2KyxQuTPbkh7K7ypKljmRKa4sqBV43Jrh8w3GKXmgZ2Y1wyzMzP6pxCzsvXBE4VlHYpS2TqjD1xBzbzKn0Gpf9QieOOVcZGLXIieurnSTaeW1N4LKqX9JeIocHXJlnLLFuZCB7KbJUBitPy17kRldlrrCX+5cgfruYK5VkJI6te1oTG/776UVVqP6DbwSPee/UcH9ocY8tlrLbjkS6IRlnKXh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=bB8nwxZpm/AkxhrGe0OQo7tjM9dgVEb3N7weMwirIZMRrMuMnfOrP6ExZIv9twqv1OaIXmszACxF0J6OgjkfUZHW4y8yzuOigVUsnq602WaPaA5BVgwCVWTAnI6E38Zw7AJ0r3BvrfDOPwbf0UJhkwqs1fBWtvUfqCda9PMKKB8zKpk+aoy4ofwEobZtdAXBTHGEeuhTuxPhFh5aT6NLJ8pRRI+wWNdpAQyHALv7y4/C0DXce6m7cMbiwRdqQgWx8e8u2FfuM/+98ZKIMAgsWY1YBjIxIWhB+1WbL2WKFHoGrICXI3sST6bQvTAYu2C/QVpjFgg0ieIuCO9qnlXwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=Uqc5zr67FeQ0MCFUmFlr+NMCXy+04cAYorclXM838YNYVGp5jh5f39frVAbVjC/kWMuTT7gwfmZ1yj4I9XHh0BhehbZQnLePOcFKzfQEx0lfp9si5AMFeTSRJAf+bktK7SdyEWrJ7Du5gx1M0iCmIH44FxEFYAUR0ACMGrPUlAfS1jVSSljeucxE4BQ2PfEi3/6s3x9utZuMKx/+UPvsFMLUc0VSLnjBjNz9lsTZHrrK9v73fY2DBumnHRP4nVOJFDCly6VBHgV7zD2jJfaLC5leUM9MkMGVFN79KIuQjRxojgAUcbf/4dtzpDoDfj54Nm8kKmGdXT7tjM6H+kUYPw==
Received: from PSBPR01MB3638.apcprd01.prod.exchangelabs.com
 (2603:1096:301:a::11) by TYZPR01MB3887.apcprd01.prod.exchangelabs.com
 (2603:1096:400:31::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 01:27:01 +0000
Received: from PSBPR01MB3638.apcprd01.prod.exchangelabs.com
 ([fe80::e8d8:af7e:6516:3dc6]) by PSBPR01MB3638.apcprd01.prod.exchangelabs.com
 ([fe80::e8d8:af7e:6516:3dc6%4]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 01:27:00 +0000
Content-Type: text/plain
From:   <tsbugepuu@hotmail.com>
To:     Undisclosed recipients:;
Date:   Thu, 25 May 2023 01:26:59 +0000
X-TMN:  [xHGV7OQJv9ZpaPEq9waB4GhJFi7Hgk2RIcwIDopkcK4=]
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To PSBPR01MB3638.apcprd01.prod.exchangelabs.com
 (2603:1096:301:a::11)
Message-ID: <PSBPR01MB363880C5BDE4A29B579F1E9EAD469@PSBPR01MB3638.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSBPR01MB3638:EE_|TYZPR01MB3887:EE_
X-MS-Office365-Filtering-Correlation-Id: a8437685-6f5d-4a04-1159-08db5cbf22c3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrtYAHhFK0Fl3yfMixWYxLMYKNvBh+1I3qWtqr0UKPyY1YjV21oNx4MwVqf2o3vjMaVKjf5B1DDl9tOiY9jA4ARdL5mRZioZ+oEQkMTnqj1rVaOKw2f3pXfph53YMOGLIcivfpjCD4qcDKOExCV7s1Lq+tPjvjFOZtBaYyfi8qyv2mr0pSAPD6khYrEO/kO7ZVq6EfJwpjTLkmobjukxYF+PlGAEZM3L/TGgAAKtekDp8R44gF3Z5P/1sB0I69er4vP+snKoEzgOKjVgILVvNzuEtgoi0zz9AifUDxbXRzs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cmCbkxKjlxRsnxeUWv1uMm3nekz+U00H48aZ8YPTgDVfCYZAwghJyjDKsH2b?=
 =?us-ascii?Q?/AzYT3/L1bXHR1uyyjScIEEgxosG/gHdx00tffrRs9fv2pDdnWIrmi+dCUOX?=
 =?us-ascii?Q?czMRpoKsxidlnEsTiKxkMe5Y7CHIHHHhGsibncy935A0zuTMDt8mTSMFW1k0?=
 =?us-ascii?Q?xEGB33Ib72quRryeBTglN8CrqMJ/EiCfaZCWD+k7if7xyMHdW3z1WqKaOrFJ?=
 =?us-ascii?Q?Ip1WFhCmF0mYcoKVVp7yLz8hSEZ23TrJrcyphOQauVs7RVpcsPukVBxwTqvx?=
 =?us-ascii?Q?lypvMBS4KI4FZORGjYS8BlnSm3tTsJQHsAYFfEgWuS6cDuwmA4IFEH27RHJv?=
 =?us-ascii?Q?tzDLeOVIgSOusGKatX4BDznasznGzzwLN1z+YRIBMPPjTj6Vz5z9lyETy91s?=
 =?us-ascii?Q?dh/bVgUgMH4NQqVFCBSGBgkCvP9uNarDs7v+A0ARoGVy8iITvgR7rJrvinAz?=
 =?us-ascii?Q?jpQ7oSP4L4uVDIN0Vajj8K4RRLAc5dUBG3YPr3vZx6OZ038faK/jsJLxHsY0?=
 =?us-ascii?Q?Ht8ffcc7wO0/WE7ZY5u3EotIiQWiOICvNprZjYT45m7fxS0DZwWClVQKWt5U?=
 =?us-ascii?Q?oUnVTbMW2xdvPJRwV6OlZNG4QJviJ+HSfUj4lvgWIBwgXfSNW/WpwkUkIHpU?=
 =?us-ascii?Q?/KE3o4M5vCqAZoj0TtG8rZ4udZDDr4E2UcngYkDUJRSdnmpN+3FxjUS8j8rd?=
 =?us-ascii?Q?4swA91/FoLAS5xO/pgI7VaSz1qdKImV+b5qdqdahtBvU4kvi+MJkF7Bry+qC?=
 =?us-ascii?Q?gU90U5zfGxQxReVgpsE3OM4K4Lj1K2JcSMl929YowXi5l7HmePBvqbeyG/nD?=
 =?us-ascii?Q?qsTBVrvNu9qjuzHhK+pxBnkqWRDXcZkqj9k+ep8VYEstLR8bK95rt6iCzyrp?=
 =?us-ascii?Q?LBkqsS7GpLasQysqtYfNu2e4OXNs8phnignfrtCGuimLIxSfpOcrHWApnKG6?=
 =?us-ascii?Q?tjY27Kj7HOFFwHVd5J6elwkr5tPjnxdZtOEa72eib0POQK4CmCANaGgpKmvb?=
 =?us-ascii?Q?GeBhM8I/AN/RU4gThfAGgIEYX8dk/NoHqh4SLOzPnlHICurNjtsHEA3ls3yi?=
 =?us-ascii?Q?G8XeqfPbzwOzBC4uLdWDscNdYhUakcylJunHXIEbY2Y9MpxUbNXl++Rp/qYE?=
 =?us-ascii?Q?deKkoH9+xhCuNNwxhSLTgbS6x7VXlyNO5V/tDsxPeGg1gvsBYjt+DaQKM3Rn?=
 =?us-ascii?Q?W6jGiI+CBbqLSbxiDx1JePfRM0Dy38KIeKEkFeKWrLs/NKzr9xLuZAJK/10?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a8437685-6f5d-4a04-1159-08db5cbf22c3
X-MS-Exchange-CrossTenant-AuthSource: PSBPR01MB3638.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 01:27:00.9033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB3887
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        MISSING_SUBJECT,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

