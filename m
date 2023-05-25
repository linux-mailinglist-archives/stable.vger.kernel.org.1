Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972C2710F52
	for <lists+stable@lfdr.de>; Thu, 25 May 2023 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbjEYPR4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 11:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241652AbjEYPR4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 11:17:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2100.outbound.protection.outlook.com [40.92.107.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05EE191
        for <stable@vger.kernel.org>; Thu, 25 May 2023 08:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7RETVa7oWMuuJana0Mlq4yNNh22Ip5WphoDSoeRUgu1B5H5Nh0qWDBpbaup2NZxhIvHR33gm4RIc9eCo6tOcA8SN+1jwEBX5TqVUECC7sCDzs3fU3shhxvClcBHaHdp6X8v9t1x9XJACrtuGSBvkuoWJV5tzzTyGQbbGT+AQZOf4B45L84XVm1wUtkidu8XyalmYiZYTVqd+cipkz1UStJB8N6nAiDuhRL8VFUIrIZ4C6P4Z/9RMzL3+r7aa7GuUvj/jsBIlRS7Z+TPerS/WlN/Gtz1+cHvs+Js+lccqEf1EZPH3CZhz17c9s9v2eRbp7uib80xsTUhHOM+wLu8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=jMMhIc7zCqC1Di9u+os7L5l70cqmkYIIOILto8xImLFOCMU+UehBft1jty3d3lGVtLPdPzFn/vij6nR+oCYjWlg+9JVRfcVWGWYpeymlaQaNgaTF1XjJNuoirGwNlTFAIxOmy43grRyiT2WqRVhxYQ39D1eGIMOgm+ewEu5Pf4RbqlliRB+Jdbnm+9oiP7PrsoXeSxBJDPE5WmqMGwZgYkyfVbFobFUILXGPc2FgQAQCJsRI7Rg870lUMcwBVUUJWSpjFBszTVrHSen6ir5rhNhrFJrxt2LoeE8IEOGzvd9koUS/HJdXXvXSmHJN7y1GZyDHslLy+ygvpQpAlIKSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=HRRDz8Ikj7ks6uSkLdyRrCefHGc5jvRm8fLQ/CGqCiT75Y8Nat+nF/QhZnwpTPHmE2wqokJfeafXS20DAkL4jhPhCfd5z8DDQNPLfhOCLimOB9X37ZMjgyf8NT3cGpTz2PbCMKxUMk+U+wsAW61nMwd4jELGEFg1X5qFaytZ+pidsiNk7MPGAzQCea0St/d3oQONLY1qKDM13VC2F5IodesoqYa6d1c2K6VmZOUKAIS5J9KBeoRxCM3uyTODi1uABHwCQBvela3BuTqWLKLh/hFcl8hCgeHcz1En8AN11wFiA1oGnhm4OekaYV1ecIbYuWWz65ypXmxJZoAtiQHqKA==
Received: from KL1PR02MB5403.apcprd02.prod.outlook.com (2603:1096:820:ae::5)
 by TY2PR02MB4285.apcprd02.prod.outlook.com (2603:1096:404:8007::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 15:17:52 +0000
Received: from KL1PR02MB5403.apcprd02.prod.outlook.com
 ([fe80::40f3:6f38:be69:e119]) by KL1PR02MB5403.apcprd02.prod.outlook.com
 ([fe80::40f3:6f38:be69:e119%5]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 15:17:52 +0000
Content-Type: text/plain
From:   <ercvpr@hotmail.com>
To:     Undisclosed recipients:;
Date:   Thu, 25 May 2023 15:17:51 +0000
X-TMN:  [U4ZBksWvxNWHmC3BdQyChO0KLmKnTnHv]
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To KL1PR02MB5403.apcprd02.prod.outlook.com
 (2603:1096:820:ae::5)
Message-ID: <KL1PR02MB540384EECD0405800206019ECF469@KL1PR02MB5403.apcprd02.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB5403:EE_|TY2PR02MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9ba4d4-7f93-46fb-5274-08db5d33351c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bk52RHGHFgEYYv1aX4NQ9UjPQ1GW+fRxxmN1ASGbU3CHmAYewrNM5kSA69JAF5RipMG9OUXvfeY4cZPSVAODBON8uv+NOEEgo9dMjM8OnAyeGLAoobJhbSgXJW2Bx6UQyq8JbtH2pRmmXdffjTBiHSALfGWyxuHCiWincEGeCNiM3hXzBTNXPr61LXP9t7bX9tBKvQvPtQLJBLc1EDi2nZ2Pj7WGEtAGqSOGUSu0eX5AdkvMjCn5ABqBxUVKMe+qMVgaNw56ndB4hgJuRiU1YUScCTvLpOTQX712xFmKG3k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eHwkqjPyiMwATuNj65B3dxlxuy5TPI9PHc95sEMltxhV/VVlK+p7OZ+zDsDK?=
 =?us-ascii?Q?FuU6/jfA9Eij/SjtuqUoQUthGyoj6tXyjQj9+YLVafKcOX+0PQBihwBRCsst?=
 =?us-ascii?Q?Ckvt6sG7oE/yB5g2NgyvdjV7OyK1JukTJnWBDlXxxi7Um8j4TwuU1o/MqwAP?=
 =?us-ascii?Q?Q3X7Xv1qpHyIuhXm+SQ24VCDmKcr50fBo5RPomx6mNKtVNxZqZqLDNNDCvf3?=
 =?us-ascii?Q?mFZnuFhSMa6yE4OhVWiFPS1qVYGSB3oPbj8Y1Ma5Doby9fFNc2F4yIiavHcC?=
 =?us-ascii?Q?JRATOWQ+q1e4clVoGVj+oXtFx4GyQrkQylPfkCfPznD7YEEiZqE3YkrIlKtf?=
 =?us-ascii?Q?qRR4q225YqlIzfVRY7qrWvEZTRR+RSeQC8R0MuZHonPq6js0s3REb5Sa0vP+?=
 =?us-ascii?Q?8H9Rc/LumIvATKiuiIqUfg5NIFLn2iAYybValIuFwwFBM6A247SsnkSiZ+3n?=
 =?us-ascii?Q?obY124yg7OBrtDQEOVSLiTWaUPhTKi8FamrY8kD7pY2gBMVDYNzmrFA7ZcQ9?=
 =?us-ascii?Q?qU+9o5nYROENUgSPM0Okmsm2svmYcz9BX9kpeIMnrWFKk0P0y8ko0S9qczGJ?=
 =?us-ascii?Q?rRbsqmNPaefcCXuWRvIdU3IaZQkiX10Oz5e/bP+xOlXTMQONp4ZyGILDgCO2?=
 =?us-ascii?Q?0fe1IhEC1cMXr8OmJ+/Q/duJ+prn06NmXbUPm9tlkw81yk/JVNs1NiAOUgrn?=
 =?us-ascii?Q?lAwtuRf7fFydm+IMhqBzQoAY22lk0g1GLqaMydDCwV1xwPvbu/I+y5YqDm5p?=
 =?us-ascii?Q?Mu+Ep2yg7/jyg0Yz7EVg4ldH6URXDYFWu0ceqrv1u7Za0qD5g40n4PloJEMV?=
 =?us-ascii?Q?E8nvGrZ5+n87T+ZhniOoyNSoKBIP1AxE9muX7KR6pGbPvFs+j6F5sZg0FTQi?=
 =?us-ascii?Q?bxufIgP1Yvx79awWbmp0fVOylmXs41gRTbg1oEtI0VOAKGxf7x691QWw4m3l?=
 =?us-ascii?Q?8hMi0pGVg0BP7/jnPonuc97Ois6v5963B3pL5jGyeL0bMve04r8wkUTAKiE+?=
 =?us-ascii?Q?HujxMedg4k21d59vbpKiwDRzWxpMm5nMYKBOFFziS0fXDnrjYgAObLXZv+fh?=
 =?us-ascii?Q?nvm8m9/Yk/fXGX9+oCSqzYoeqhDzsItwWD9JRK1fnoAxJj3npTNObyS8c1GV?=
 =?us-ascii?Q?kp1QjI5IFooTZ8Cm/kljHGbOqTC8NvLfypX6M8XbAzZa5sZYE0AuvpMek3sD?=
 =?us-ascii?Q?oxOx9C/JSSaR9sB4nYIaP8TWDXYsk/YzylKqHw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-20e34.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9ba4d4-7f93-46fb-5274-08db5d33351c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB5403.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:17:52.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR02MB4285
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_FROM,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,MISSING_SUBJECT,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

