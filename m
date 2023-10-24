Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C80C7D50E8
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 15:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjJXNFS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjJXNFF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 09:05:05 -0400
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2103.outbound.protection.outlook.com [40.107.24.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720913851
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 06:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKsH4Bz8y3Un7Ts+XdguJ3d/qNylXgpFQCiArzV0BxQ=;
 b=nkWWppHr6fQVBfZ8Bj9rFWPcQogvVSivEqyizf5/TQWu3YXyAZ+11Odhe6WU4DjW2l0mV40qE8bPoQ54GAiJFfsBm5vAYEI9jqmvjjAJzplQwouoJFqWFmks+Kw+V9YWhaRnCqOt3H1nzs/THX18kzyBnp28m1Pzp37E42wS7Is=
Received: from AS4PR09CA0002.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::9)
 by GV0P278MB0736.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 13:02:47 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::3f) by AS4PR09CA0002.outlook.office365.com
 (2603:10a6:20b:5e0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 13:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 13:02:47 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4SFC070dmhzxpC;
        Tue, 24 Oct 2023 15:02:47 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Tue, 24 Oct 2023 15:02:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKsH4Bz8y3Un7Ts+XdguJ3d/qNylXgpFQCiArzV0BxQ=;
 b=nkWWppHr6fQVBfZ8Bj9rFWPcQogvVSivEqyizf5/TQWu3YXyAZ+11Odhe6WU4DjW2l0mV40qE8bPoQ54GAiJFfsBm5vAYEI9jqmvjjAJzplQwouoJFqWFmks+Kw+V9YWhaRnCqOt3H1nzs/THX18kzyBnp28m1Pzp37E42wS7Is=
Received: from AM6P194CA0071.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::48)
 by ZR0P278MB0025.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:17::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 13:02:43 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:209:84:cafe::62) by AM6P194CA0071.outlook.office365.com
 (2603:10a6:209:84::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 13:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 13:02:43 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.104) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 24 Oct 2023 13:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZAuSKqJ9ePuGJpQmmyfpR3klik9ONAhSwnBxRs/HB7E1M0Tu9Bf8EkQ5R81tDiBtm/Z7WiJ+EnRjTrpGnI4MVZIkWGEdHIZRjti7EoWCr+n7QW79UHeIg9Kovfp72wA0mHxWbF2BJHkx3kSwX0I1AyEi1yFgdpuWmsJuzINOixyjAn5pKYZRvXkkYiB/2/lIBH/tz+MjCJODrQBmsnP6ClGPv3p5MXY6RtNhDOiGV9Q7sUum9yAFwna+uFzmniEMvyB2w5fMsv5hj56YC9biU1yzXM7EgRXojFmqvJW6Mq+QF4nEAMUryUdqjTi0xi63NxHrGu6RATqUyZ632yDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKsH4Bz8y3Un7Ts+XdguJ3d/qNylXgpFQCiArzV0BxQ=;
 b=TG/P3yZi/lgdwrkWgzXQ1YrCPEYlo5nDyMO7UvavFJdMCnqnMKEAVRrMV2b9QB87fLKb/JYDo7V54+t+L24HKCLXzze8ucflhjkuntyhCQhblSNa068CB17YUxwpvFmmCZNw1jr0r1obcUgfWeSsO0nk0fdi+ke4+9o2wdKe++VtJFychjT0DmQ9nYixSrmn+mvhVHXFADAAXJa81xFZYLeymqMtgGRRboiMOTZD0Loq9Ydajug23Y4qKmD6RJugGMSaVzZQNRPkr8J0Durnwlfo8S0/txQEe5HjNlkDLwzENGdAkOnYnB8Dl3lsl4jwHFcP4jyHR1LeC4HHD9eDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKsH4Bz8y3Un7Ts+XdguJ3d/qNylXgpFQCiArzV0BxQ=;
 b=nkWWppHr6fQVBfZ8Bj9rFWPcQogvVSivEqyizf5/TQWu3YXyAZ+11Odhe6WU4DjW2l0mV40qE8bPoQ54GAiJFfsBm5vAYEI9jqmvjjAJzplQwouoJFqWFmks+Kw+V9YWhaRnCqOt3H1nzs/THX18kzyBnp28m1Pzp37E42wS7Is=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR2P278MB1129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 13:02:40 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::abd9:4b84:39df:6980]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::abd9:4b84:39df:6980%5]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 13:02:40 +0000
From:   =?utf-8?B?Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kgSmF2aWVy?= 
        <josejavier.rodriguez@duagon.com>
To:     "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        =?utf-8?B?Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kgSmF2aWVy?= 
        <josejavier.rodriguez@duagon.com>
Subject: Missing patches of a patch series during AUTOSEL backport
Thread-Topic: Missing patches of a patch series during AUTOSEL backport
Thread-Index: AQHaBnpekPaDiMCt40yF5yZdV146WA==
Date:   Tue, 24 Oct 2023 13:02:39 +0000
Message-ID: <aa7145b39b72237a7cfd9ab8ba92ad26271f4881.camel@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR2P278MB1129:EE_|AMS0EPF00000197:EE_|ZR0P278MB0025:EE_|AM3PEPF0000A78F:EE_|GV0P278MB0736:EE_
X-MS-Office365-Filtering-Correlation-Id: 03538a45-fd03-4d54-1085-08dbd491855e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qMcLTHkZUmpKHl/iabR9vvLMTazIcdRPLOdcgZr6RBH4Q8ibUDkxyczRVCOCvNoGmdczqHkkKYobLLZrDbgVzM1av8TZSfUJWXp711Uc5Boy7D8wr9KromN6LAlWtYJU4wtjw0SiCSUYXrhEyAh3/c6x71oB6LKEJuRe3IufFFR2n0hTtVmSiHATBi1MBSrNjcmrdzvT+40rZTJvFWp/AIRZpvBU7oaiKRr0g0aF1Szz0+7QE2RnNcZgIvmrNeMIJYtBN99XKkTI3P3wxfca6MSuABNQuws9ccK6hmOV7pGlLuj9DdtD2s5QOeLQrw5K2D3fBa63oRpoy05leXG9daD7Zg/CHmfS4PllqfbCMVfbA673iYJ1uIyLWvaAmQ8JbbeQOdPJo2Cz10XDvu3qmNKAsvRBwoOXeH+/LsfBV7A0YDfli4L3IhQoj0NYxYetrrJ4IxHp6ZRX7MPuDZn+T7PIkP6nPClfO4N8xp1WBSIm3P8NWDoifzKmiaoSYrwFtHDkM9XckOdAekD4vCw/oeTnfwtz4b5a1ftH0jqUywDk9OvUDYnrhCU/PKyn0Qf7SMKPFVNoknaIOimQlDaogvOGxeVMb+yRAScZt/gddlJR86CxtHbBKTbtA1KxYIXNI9NZadTe0CWkhga9NoRhzQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(396003)(346002)(366004)(230922051799003)(1800799009)(1590799021)(64100799003)(451199024)(186009)(26005)(38070700009)(1580799018)(38100700002)(2906002)(122000001)(107886003)(86362001)(85202003)(5660300002)(36756003)(8936002)(8676002)(4326008)(6506007)(478600001)(91956017)(71200400001)(110136005)(54906003)(2616005)(66946007)(316002)(66476007)(66446008)(76116006)(64756008)(66556008)(41300700001)(83380400001)(85182001)(966005)(6512007)(6486002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <C57E715DBB28EC48BE19AF363BDAE2DA@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1129
X-CodeTwo-MessageID: 6edf0718-2301-46f6-b983-66dc320c629f.20231024130241@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c891b7c6-0bbc-4246-56eb-08dbd491809e
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 695loFuLGuHqr4G5S7y0K7iJiUk4q9EDrpzaZF+whbuHYvOFlKdJjc2eLszq7Ze8VSVp9Sq5zrfauExqGmqM9zKn+dkerjmlGqLb8kLefu1uF5kkWBbqmt6ZV1ccKixS7uLnz7XLGoInRizRj0TRDe2bbPsQIQ75/7z0GymeLcSqxleVU2VS9x+RjGuub8Tv2TSrDuM4PFXaprPN5ithOqaPtDr4Tu0kQZmON0mIjsRL6/S5kp3kgjk+xsSSzljcdIoyae6VG8U97DIuW4xMKm8JSuTuITTNUjK/C585QnnSZ89FrUlQ0AQ8jJNtDI0KNdZaX424yjwfKXSftqTLOH2/aazf71u4hNDg03t6SvHw6pkhxZ1B0gSjet6OOAXZ22OJULovTvA6poYFBIi6lfZOUi2wKwsUnEgfnHEADtUGYKSQ4qj5xZvFxvZO6dlbLABH1W5XOQr9hoKW1oVwoDZk6mWvzVME6tcx4zo0VXhqsZmuQXCP6rfRj1JiZFEVGvBZuWF/aNJ9FVU7HkGUolDathV3oQ1BSrSMvQwPjjNEZ3Vpl6w2j9g1tH3MUMHLwU5/NyaLuDHtLUMYhUZSdIi9cxeMULhst0QcJOliSKCPKNcVFKgvAhw1wak3OCWserlh72q7rVORuieeqara9FQTzOCZEzzFJC1EZS/HiCCXNKJEVWCEy/gLcFWSi9GixQE/H7Nx9MVLLpQEznGuRJdIkzj3D+8Xuntm10x9As0=
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(346002)(230922051799003)(82310400011)(451199024)(1590799021)(1800799009)(186009)(64100799003)(36840700001)(46966006)(6512007)(6506007)(6486002)(316002)(70586007)(478600001)(54906003)(70206006)(5660300002)(8676002)(8936002)(4326008)(966005)(110136005)(107886003)(41300700001)(1580799018)(2906002)(85202003)(40480700001)(83380400001)(82740400003)(36860700001)(2616005)(26005)(336012)(7596003)(7636003)(356005)(85182001)(86362001)(36756003)(47076005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0025
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4446db80-64e0-4922-61e1-08dbd49182de
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 080cPFI7jzJKfOmKKY1l3u9R7MICe6obXYqHnbL4FczOeZtEZmzhX3NZM1SpyApUEFEYIjV1mVq2US1zDmsdYIcRc9vGBHj0xuueej+610LSE2/t3+1SDlFjApirUSFXgw5VKfqjiXoI7aEtybas6xKgYqfyvy19sYGqZvIH5SkCBbZ4N/1LkNDYS5zL8V3EHrEmjtt5m+AGGjWh+RDQ01y5AmLJLXlTkMXog3FcOmklrrGRUti9WNQAZVhERIOnXVTVQkyjPx23UfN9PfK/HimeMBSFXntn4mdX9UjzfmGYaZ7KljtL56IxUagrI47M22KBrl2EFATm1RxuXFSiIoYrtiCp9Y45neLYTqmyOD8CIxT437er189E26QAWBUvBLeMsdzXE4/9cC1GcxMlC2CmHRXgBp1ECX/tqWAram8ENakprQ4o1exXVSh4mLF2dDsJGtsxQyu8YQI1HRgRWpynkhn1Pjy992pfvyQBsdPp5bjjQVTQ89KytYFBIXeJRQ9jfSDMdTi4OQxny1sfsYI01V9yJfIXr3IrpRjTXJHKkv+Uos9Ukhj2Eu4bp5GrzJ+ndAubN1pzG9fqIRsRBsFrJBd1ezzfW5yVwT0rPRXJqPS8YOtCe71llfvdjJ/e52ZBZnYI+sMIy59lLPsFJ/sE1KtYetJAlAKpOG8DmYpShL0+1OGpRifwJU0/ImSGIMoNyCq2WjrA0e/yEcVnOxNCAGZbyIcc2ypgCRtjVhiMEoq622VLQKZfKjHANxZYRBUcj/tqFBgD0XebDHtReKHsIZ+yZ/7P60jStKLDoLM=
X-Forefront-Antispam-Report: CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(1590799021)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(36860700001)(1580799018)(2906002)(81166007)(82740400003)(316002)(2616005)(54906003)(6506007)(70586007)(70206006)(107886003)(85182001)(110136005)(478600001)(40480700001)(6486002)(336012)(6512007)(47076005)(966005)(83380400001)(40460700003)(5660300002)(85202003)(41300700001)(86362001)(4326008)(8676002)(36756003)(8936002)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:02:47.3437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03538a45-fd03-4d54-1085-08dbd491855e
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0736
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

RGVhciBTYXNoYSBMZXZpbiwNCg0KSSBhbSB0aGXCoGF1dGhvciBvZiBhIHBhdGNoIHNlcmllcyBh
bmQgSSBhbSB3cml0dGluZyB5b3UgYmVjYXVzZSBJIGhhdmUNCmRldGVjdGVkIGFuIGlzc3VlIHdp
dGggYSBwYXRjaCBzZXJpZXMgSSBoYXZlIHN1Ym1pdHRlZCBpbiBNYXknMjMuDQoNCkkgc2VudCBh
IHNlcmllcyBvZiAzIHBhdGNoZXMgdG8gdGhlIG1haW50YWluZXIuIFdoZW4gaGUgYXBwcm92ZWQg
dGhlbSwNCmhlIHNlbnQgYW4gZW1haWwgdG8gR3JlZywgcmVxdWVzdGluZyBoaW0gdG8gaW5jbHVk
ZSBzdWNoDQpwYXRjaCBzZXJpZXMgaW4ga2VybmVsIDYuNC4NCg0KWW91IGNhbiBjaGVjayB0aGUg
ZW1haWwgdGhyZWFkIGhlcmU6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDQx
MTA4MzMyOS40NTA2LTEtanRoQGtlcm5lbC5vcmcvDQoNCkZvciBhIHJlYXNvbiBJIGNhbm5vdCB1
bmRlcnN0YW5kLCB0aGUgQVVUT1NFTCBvbmx5IGNob3NlIDEgb2YgMyBwYXRjaGVzDQpvZiB0aGUg
c2VyaWVzLCBzbyBvbmx5IDEgd2FzIGJhY2twb3J0ZWQgdG8gc3RhYmxlIGtlcm5lbCB2ZXJzaW9u
cy4NCg0KW1BBVENIIEFVVE9TRUwgNi4zIDI0LzI0XSBtY2ItcGNpOiBSZWFsbG9jYXRlIG1lbW9y
eSByZWdpb24gdG8gYXZvaWQNCm1lbW9yeSBvdmVybGFwcGluZw0KW1BBVENIIEFVVE9TRUwgNi4y
IDIwLzIwXSBtY2ItcGNpOiBSZWFsbG9jYXRlIG1lbW9yeSByZWdpb24gdG8gYXZvaWQNCm1lbW9y
eSBvdmVybGFwcGluZw0KW1BBVENIIEFVVE9TRUwgNi4xIDE5LzE5XSBtY2ItcGNpOiBSZWFsbG9j
YXRlIG1lbW9yeSByZWdpb24gdG8gYXZvaWQNCm1lbW9yeSBvdmVybGFwcGluZw0KW1BBVENIIEFV
VE9TRUwgNS4xNSAxMC8xMF0gbWNiLXBjaTogUmVhbGxvY2F0ZSBtZW1vcnkgcmVnaW9uIHRvIGF2
b2lkDQptZW1vcnkgb3ZlcmxhcHBpbmcNCltQQVRDSCBBVVRPU0VMIDUuMTAgOS85XSBtY2ItcGNp
OiBSZWFsbG9jYXRlIG1lbW9yeSByZWdpb24gdG8gYXZvaWQNCm1lbW9yeSBvdmVybGFwcGluZw0K
W1BBVENIIEFVVE9TRUwgNS40IDkvOV0gbWNiLXBjaTogUmVhbGxvY2F0ZSBtZW1vcnkgcmVnaW9u
IHRvIGF2b2lkDQptZW1vcnkgb3ZlcmxhcHBpbmcNCltQQVRDSCBBVVRPU0VMIDQuMTkgOS85XSBt
Y2ItcGNpOiBSZWFsbG9jYXRlIG1lbW9yeSByZWdpb24gdG8gYXZvaWQNCm1lbW9yeSBvdmVybGFw
cGluZw0KW1BBVENIIEFVVE9TRUwgNC4xNCA4LzhdIG1jYi1wY2k6IFJlYWxsb2NhdGUgbWVtb3J5
IHJlZ2lvbiB0byBhdm9pZA0KbWVtb3J5IG92ZXJsYXBwaW5nDQoNCkluIGtlcm5lbCA2LjQgYW5k
IGFib3ZlLCB0aGUgMyBwYXRjaGVzIHdlcmUgaW5jbHVkZWQuDQoNCkluY2x1ZGluZyBvbmx5IDEg
cGF0Y2ggaXMgY2F1c2luZyBjcmFzaGVzIGluIHBhcnQgb2Ygb3VyIGRldmljZXMuDQoNClBsZWFz
ZSwgY291bGQgeW91IGJhY2twb3J0IHRoZSByZW1haW5pbmcgMiBwYXRjaGVzIHRvIHRoZSBzdGFi
bGUNCnZlcnNpb25zPw0KDQpUaGFuayB5b3Ugc28gbXVjaC4NCg0KQmVzdCBSZWdhcmRzLA0KDQo=
