Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE6F787DD4
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 04:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbjHYCkr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbjHYCkg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 22:40:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2108.outbound.protection.outlook.com [40.107.237.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775A1AD
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 19:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mzy+Q9K7+/GSzzS25Vy8sQpGeZ+dtPeIL35f8u5U12yFwNEM2PlgLEVcIMmOgP7IcyumcGW8HXBTHmKuMYD/9R2MZu4N9jFAxeAoEX8u73GLy5GvPNq4fFS7TgWQb+Rb9dM+0trLizXnS6+EUQuo/WMpjzuNgW4n3zQSaKA7LlZ4RiwOdOp5wr7RoYuro2LwjNBYxSRnwiE0sljSg/FtaslQD+sbmSbb3XpWcY9630mNNkYaglRm+5orpaMuMBqh6ZoTgkAb3Hnd8Dq5JFLucOcOQP5YxPuuhsvXHHwmp8SGvK4GKZLXKKcW38LB+tv2l1f+SW9Hv9pF1uHCS5erPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gTL/n2wP5zMtEVNr0PG6+4Gaxaf3ZjKpHCLirgwIro=;
 b=Nkw5e77k7VfPJpCSimA+vB7vse+UMCwRcBFBgfZIWZ7E8w89hUTg5StZXXCvcrLCH8198VAIrhl8ZDGl73tOgoSkuqcOMypjZcjDQ2xqd63WJ3E0vtoaZmVeDrUkYdT/hhQIo0iT9+c7NqxuC/gff6YYsPBGcreHS5vKQRPMP4uSWq50wQ8KJqQK4omwf/ObPm5vBQjktx8CVoAAFl5BH7H+3QvWrt67ycCOVld6HLyZ1rlrQOhJkHe8o6mbYldpEMK5H7LnvPqT8kXq1faHysPD9B7P6+iWyb35ThP9NtETlqyI8RlhelbNlYgHZVeis2fsZ0b3LThO9Dl7D6e4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 201.217.50.26) smtp.rcpttodomain=mail.cgu.edu.tw smtp.mailfrom=ips.gov.py;
 dmarc=bestguesspass action=none header.from=ips.gov.py; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipspy.onmicrosoft.com;
 s=selector2-ipspy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gTL/n2wP5zMtEVNr0PG6+4Gaxaf3ZjKpHCLirgwIro=;
 b=1n+DPVGe1BEe65+lrgKbyaCCjpq81DiTDdJGRxivg4or2V1cXucPKHAh6FeR3CcSJNbnOqy3iZFnSF1LqtJu1uraQiKrEObXE3UVsqQcFtCDbcVQUjM1V5EJbOb+eGwqb+dXkE6rGuE6xuSwrdlvejAmRt1BTQpfnofNkcMghp0=
Received: from BN1PR10CA0011.namprd10.prod.outlook.com (2603:10b6:408:e0::16)
 by RO2P152MB4488.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.23; Fri, 25 Aug 2023 02:40:29 +0000
Received: from BN7NAM10FT072.eop-nam10.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::62) by BN1PR10CA0011.outlook.office365.com
 (2603:10b6:408:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 02:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 201.217.50.26)
 smtp.mailfrom=ips.gov.py; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=ips.gov.py;
Received-SPF: Pass (protection.outlook.com: domain of ips.gov.py designates
 201.217.50.26 as permitted sender) receiver=protection.outlook.com;
 client-ip=201.217.50.26; helo=mail.ips.gov.py; pr=C
Received: from mail.ips.gov.py (201.217.50.26) by
 BN7NAM10FT072.mail.protection.outlook.com (10.13.157.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.6723.19 via Frontend Transport; Fri, 25 Aug 2023 02:40:26 +0000
Received: from vs-w12-exch-02.ips.intranet.local (10.20.11.162) by
 vs-w12-exch-01.ips.intranet.local (10.20.11.161) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Thu, 24 Aug 2023 22:40:17 -0400
Received: from vs-w12-exch-02.ips.intranet.local ([fe80::51d8:6d9b:b423:434c])
 by vs-w12-exch-02.ips.intranet.local ([fe80::51d8:6d9b:b423:434c%14]) with
 mapi id 15.00.1497.048; Thu, 24 Aug 2023 22:40:17 -0400
From:   Silvia Veronica Haifuch Gonzalez <shaifuch@ips.gov.py>
Subject: =?big5?B?sXqqurZsvWOkd7qhoUM=?=
Thread-Topic: =?big5?B?sXqqurZsvWOkd7qhoUM=?=
Thread-Index: AQHZ1vybCjAfG6yz50G2ql/CmUEkEQ==
Date:   Fri, 25 Aug 2023 02:40:17 +0000
Message-ID: <1692930209159.16474@ips.gov.py>
Accept-Language: es-PY, es-ES, en-US
Content-Language: es-PY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [102.91.4.181]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7NAM10FT072:EE_|RO2P152MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: c191b722-aa2e-4f8c-8ead-08dba514a3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Slw80aSoee+fKVAHhkpVVaMXDgA1x/cxRGwZ04WbZI4m+08FN23A+9r6abNcllzxAlYM6UccRhYx37yPQ8iasdj+BRvY35tmGsIJj9mBqmf2skcbYS9DMXfphPSo0OoyIXbDoEfF3gTJubf9dqGm2fqa0ZxBiP8IYAX649RJpP0V0eW5V4M8asx3ltjeywbc/L3LLEwodCK+4niSdSAUMLQXbvConD+mGQHQoL084IF3SbtSqM9KR2z4Jc958l/pStnrx3A0bDuCCTQN704wF7toepIkL5eFD7sJ9OuHGLs7qewlT1Vwp/d0ssWp6PqKwdtG4Q6IDtPvIw/eJILEYKyEhMkZx4c/ClnYClPaCaFnjSgi1JziN8O38Epozh82Pkmeck758DRhMXALooM8D689yimA2zootAh6fOi2jU+mW9CmrvNx82HfLW69vIe7inxotmo1kpuANrRW3x1klOR+hDxDtNo5MnEQMGFnZWI44C0xjFrnT4XCd1z1phxacC5t1A3aa8RA//nf6/eVZhibSREy4x0VmTNJ+C5b4SGaTexBy/ILiqpkXuv6Q3cJzhHlw2tsz41uCUSHOHcf4Wbu+1oKtwQAuEF2qpDL8dLRLj0cqLDYT/hSElwkJqfQNb5wrzV+fnLSFKi1xjyEJAheNqmslqviLBHckc66PP6oGObeQyQeB54XAz5nd1PwNbIdGeRoZwgNEx4cbIDBV7baTbXze69kBTYgDApDtHE=
X-Forefront-Antispam-Report: CIP:201.217.50.26;CTRY:PY;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.ips.gov.py;PTR:mail.ips.gov.py;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(82310400011)(451199024)(109986022)(1800799009)(186009)(36840700001)(40470700004)(356005)(40460700003)(70206006)(336012)(7406005)(26005)(5009610100001)(2616005)(7366002)(7336002)(36860700001)(7416002)(5660300002)(7276002)(8936002)(2906002)(70586007)(478600001)(41300700001)(316002)(82740400003)(32650700002)(224303003)(36756003)(86362001)(558084003)(40480700001)(7596003);DIR:OUT;SFP:1102;
X-OriginatorOrg: ips.gov.py
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:40:26.2011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c191b722-aa2e-4f8c-8ead-08dba514a3b6
X-MS-Exchange-CrossTenant-Id: 601d630b-0433-4b64-9f43-f0b9b1dcab7f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=601d630b-0433-4b64-9f43-f0b9b1dcab7f;Ip=[201.217.50.26];Helo=[mail.ips.gov.py]
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT072.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: RO2P152MB4488
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

sXqqurZsvWOkd7qhoUMgIsJJwLuzb7jMPGh0dHA6Ly90YWkuYnVpbGRlci5oZW1zaWRhMjQuc2Uv
PiIgpUin87dzsXqqurZsvWOxYqThqMOxtaast3O2bKXzoUMNCg0KwcLBwiwNCqh0ss663rJ6rfuh
Qw0KDQo/DQoNCg==
