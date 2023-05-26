Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6207A711E37
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 05:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbjEZDD2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 25 May 2023 23:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEZDD1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 25 May 2023 23:03:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2023.outbound.protection.outlook.com [40.92.52.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A819EBB
        for <stable@vger.kernel.org>; Thu, 25 May 2023 20:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHd3Atz7Xv2bad9+w/YlNzYNRIfHc8yIaY8nwUee7Wh8lTC55w5N427uE6b+AmLQ3JQJb8XEBM94skaqiEAx4VALwCHJSfEVAaTT0+HFmpuoVNgMZWp0+17JNYyRCttZTo8EobqlG5FedOsLsOHUsyn1qTPijMlzUKsimgmnim0peIf6QKRQ5T/fiPUEpxR2yhXYjb8Pg7giw2AjdMhx7OA5l2hoFaGOuSuyIHCyp4Y7EIELnftrXBial+gfXh3aQh4gfrA1kmV3Fjvke1OapWl2iRylmyNZycg2X8xV3Ex6iaOmZWrq+ATr0jBxMquZPutELZEgenuvEbo5/gJRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=NIwSqiX1iMI2zDPQT7W2V9I4MnBytZVsvLjqQqGYkRqL5da3bT+8eqRfbsMPMNC6e4lGrrOUL+XQgSIFRoSBOH+Cb2Blvne0oftsHsfI3fR4WFVamfMd2jbai8MzVRo0muVbm/m9gzIPHYPSQWgL0TdfAm/zIqJeHmDCYqBljbGY59TH2O6iSHX3gXCLeldhZJFHGAApWELcksba9iyoB9TAMSPJiAl60xenRtXLaJC5/iBoig7vmbyK/hGsZBR5ll8GTO4pCzcDg/hv/OXbcbZ4qK+SjOvrf4GGdQm9AHgdReGIvjIyJeLeWo10C5TgRRNSlEFpQbyJqNBI5YkpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=mrb0EMuqXMfNFtdTdMjDpteDkrVqQH5hXxBm4GLAddFiKoOBlfVYFqZbe57dmMXYCLyafrunXKwj7bWDvpa3vLldhgYWbfTOJZsnitVoAaiNumB0pVAivrjf5SnHk8LovasQ9iAniN644THqUNAog2qiTCBow/hEFM/rZ+lCEPNyZCODDB2E2EDcy07E2ntZoLWqYFIlYp/pNsLhEbW5vtYgqKhMrRJSovev7Ko/uYe/t+Je6aMk54fZrLDSv4qkrwYS3KV9zu3JjCN7iCUsP6U3z7k1mQnYAnOdc3eqlsy0FMGFrkJHhL6m7NRw2JWw77pULBgXfvGy5Eg/m8D/pw==
Received: from PS1PR03MB4650.apcprd03.prod.outlook.com (2603:1096:300:7e::13)
 by TYZPR03MB7409.apcprd03.prod.outlook.com (2603:1096:400:41e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Fri, 26 May
 2023 03:03:22 +0000
Received: from PS1PR03MB4650.apcprd03.prod.outlook.com
 ([fe80::d5d2:c0e4:7984:d038]) by PS1PR03MB4650.apcprd03.prod.outlook.com
 ([fe80::d5d2:c0e4:7984:d038%6]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 03:03:22 +0000
Content-Type: text/plain
From:   <dxkmwu@hotmail.com>
To:     Undisclosed recipients:;
Date:   Fri, 26 May 2023 03:03:21 +0000
X-TMN:  [vnkZaNEIjIWXmLheIn2/FKEIvWbqCqvO]
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PS1PR03MB4650.apcprd03.prod.outlook.com
 (2603:1096:300:7e::13)
Message-ID: <PS1PR03MB4650992605D764B8AAC956F3D7479@PS1PR03MB4650.apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR03MB4650:EE_|TYZPR03MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ed84f1-2ee3-44d6-2dfa-08db5d95c402
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjV0n2+i5FmRma9N6L5nRHq4XV/ijsVdOj+foHtfDIIj+3JYHOiao2bieUNt/c5bKSxzQP+IbVDXA8lGZ0s2UnnaC1Ujf/VBB9b5vIrKvI/xeUfalTc8/jjohrfq9mvfTDgb3UqSggXWS96Zr1B1cNzcZVY7n3Rf0huvqlc7jbflWM6ViipOZznEGcoP8qHWexTf7pEpfHdH+B0yjsG1+A4SYnZNUD2JP+hhyaJxjEUeM5pp+Eguy3DrNcrk+fti/2DtZkkjUAST3xD7uL3TQOTfK2Op5J1TZ1KjpFhNPGI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8njise7i8aortR4O7RLyDpjrVdfyE83Y50K+yGUmjV7ywIVBelNE2pqWDEF?=
 =?us-ascii?Q?DmgOgBeHq8I2KwODOSEe9hjfTcluDtPwvksEeUfHM4TUK7vila6bXrvZA0uW?=
 =?us-ascii?Q?fd7VH9eqRspNVmQCc4wR5tyopXALWLbeapL2SYUTb2JsQ2lgLCzx7UztkNCN?=
 =?us-ascii?Q?YKoDGM2N7TGbO6ciz1zbmr9qE/hnfbLaA3FxKsmd4r3FliUqp1m1bq12Zoky?=
 =?us-ascii?Q?tFgiJ8ILqeNwi2mT/lAoN5sFQAK8PC9P5Yjh1HyWlfBZM4kT2c5qL2UoU8TF?=
 =?us-ascii?Q?F68Jxm3ukNTYAPY+Y/E9Rl/FMnjHPSg+ZAh9uucKaxPHq2Mxnr2rV/0jrbfI?=
 =?us-ascii?Q?AtcwTno3VetKvzwOTk37C957Nf8+6bnkYe7oYetAkA7qypCkATgBWqyF1M/Y?=
 =?us-ascii?Q?knXHTjWGvZDMeswZTUQrURugudP6pN+3YIndgJVczWTzIE6QLZ6PCYgDKFjP?=
 =?us-ascii?Q?K3qJXzh5BX/W/vEvz5J1BfiHnK4PhaQzJY9saaoUdQjfRz8LAaxxZec/379W?=
 =?us-ascii?Q?na9jRHnuXe3P+J/Mf5hwJVBSjA2gWEyUjZMPhUAcwuENLHp3TL7DBmLj0MCC?=
 =?us-ascii?Q?GLXTIJg3STm/NXYHFe9TZKiw2PZBNFhF6ZzeZm6ZPkqxGLThRAQu+2mvmxSK?=
 =?us-ascii?Q?/ZTOHhrW3Vmqbys8U3cv9knFHQhmJWZZ4eOzV2ZBPkJSjj9WsZgRkp+p7UQ6?=
 =?us-ascii?Q?KKqs9KKoYnecZHYkb1Ux+DQFWFED5xYlppPMz3ysCkrFcRWdG2Fj9ZN4NZAW?=
 =?us-ascii?Q?SdanyYbOjsNvchadnu0jQ0P3DoOPHGlyxGgc8DZxWKXjMHBRQ7d+qLmElpFo?=
 =?us-ascii?Q?HoISTHSnF1M3tNddeAmmgD+6ZK0x1x2/MelS6e0zGHI32bTXit3X8CbktTMz?=
 =?us-ascii?Q?fLD4nzaX/5wcv6AwwF0CdrNQ/I6lUNSy//sr1WcL2/SfBSfyF3TanyEmhK+D?=
 =?us-ascii?Q?GbPnDxEKY7W3cs0q8/qdHfwLf51wZ1KzakRiVEkfPDL+P2xJdBvJVVG436jv?=
 =?us-ascii?Q?97FhIGxxiaR5gmBy1s8j8bwvgzsP+uTjsxqgZjVK5phWOrSQojYJIwupYW78?=
 =?us-ascii?Q?Klm2X4uGNpz08bSLgYXJ3n/MtnjF7cBgtapWPyU2b8S+et+yRNmdgBivMGHi?=
 =?us-ascii?Q?h8Ak9UWoqCzE2taZwcKILTa/t6p3w+hIKY5bxgpwuN7nXLd3qOgyz3bEVSU9?=
 =?us-ascii?Q?B4DdGnFyUtbS+wBz54D3jNX32ZiJQ4RxSOqJKg=3D=3D?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c0b75.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ed84f1-2ee3-44d6-2dfa-08db5d95c402
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4650.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 03:03:22.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7409
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

