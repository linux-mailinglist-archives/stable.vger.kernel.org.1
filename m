Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C27D5479
	for <lists+stable@lfdr.de>; Tue, 24 Oct 2023 16:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjJXOyo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 24 Oct 2023 10:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJXOym (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Oct 2023 10:54:42 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2095.outbound.protection.outlook.com [40.107.23.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C61A6
        for <stable@vger.kernel.org>; Tue, 24 Oct 2023 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKFhw95pgjmkypKEzRadc1htYwTiM7GI6XQrL4wtvRQ=;
 b=DUvg7MIa+Eh3hzeXnBMWsmyV4VmJAWEr1SRwerZQ1xQNhYHmBPILVLQrJOnY2fkrOrdVC4JZHt5o8sVZpLfWYObCx4hSmo7UtqD5C9NWjMi1H31Hl9iCkA6PSt+QqKT7ZVaFZq7irwn0dKaGAsLexAHoex/ksOyl+eEFh+e+NNs=
Received: from AM0PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:208:1::25)
 by ZRAP278MB0755.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:54:36 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:208:1:cafe::bc) by AM0PR04CA0048.outlook.office365.com
 (2603:10a6:208:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 14:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 14:54:36 +0000
Received: from securemail (localhost [127.0.0.1])
        by securemail.duagon.com (Postfix) with SMTP id 4SFFT763mNzxpC;
        Tue, 24 Oct 2023 16:54:35 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Tue, 24 Oct 2023 16:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKFhw95pgjmkypKEzRadc1htYwTiM7GI6XQrL4wtvRQ=;
 b=DUvg7MIa+Eh3hzeXnBMWsmyV4VmJAWEr1SRwerZQ1xQNhYHmBPILVLQrJOnY2fkrOrdVC4JZHt5o8sVZpLfWYObCx4hSmo7UtqD5C9NWjMi1H31Hl9iCkA6PSt+QqKT7ZVaFZq7irwn0dKaGAsLexAHoex/ksOyl+eEFh+e+NNs=
Received: from AM6PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:20b:92::27)
 by ZR0P278MB0990.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:54:33 +0000
Received: from AMS0EPF000001B7.eurprd05.prod.outlook.com
 (2603:10a6:20b:92:cafe::34) by AM6PR04CA0014.outlook.office365.com
 (2603:10a6:20b:92::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Tue, 24 Oct 2023 14:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 AMS0EPF000001B7.mail.protection.outlook.com (10.167.16.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 14:54:33 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 24 Oct 2023 14:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPF3BMys/nQMYnpdbGR0svLZrB9Ur90uIi4fq2ec9pBE96ClgDUrh/aD9BP88o2nmMzd8towc56sw/TCPuHxsod8pn6+rhrTp4rBUW7Pr4bBxiER76lhRJ9H4Qj8k5GlN3CGluZ5xYhw67GLDsRe0h0so4kYl5roS1mj7/lzp6A8MaCIm5FHH6GpMgH1GTiix4H0qAgcx/IKn/JmW7I4iKNAqkHVWSa7cSZICyYD9MGK+0yMIAEy/L+LfxZx7vwkitzL0JXzjxTZX/fF2x9zpZcRO0FT4ZxkvkCFVdPFNPx/hUNvh2Vd08ZnFJdzMlRa/9ZXydJXRty/M5guc0Kyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKFhw95pgjmkypKEzRadc1htYwTiM7GI6XQrL4wtvRQ=;
 b=e9XfHLeekfd4DCTO7Rq0jwGZ69nE1ahxrk8PdOGy6Asc3aIkQSA+60nVcWhdOPxPvQWg1HucENx7AWEyz5tZsqrIvtLmuOd5YYxCLSLiryvxo4Jq4r3Fsoqn3SmA2SkZajrhHeUXGQzKyGMiN39kZhAk4QwW14QoUpc8JyIg2cl1SjFsacRRa2jaQsHzD/pF5P58mtSTuoFm1Z6qV3rq6M6xC7Bd5ZizUJ2GJPIN5qscb+fghrbGqFUGP8raS3I6optVzYjcOrkT3uFbnjwzVCfugVcFJrRtpzP0qHQQ6/k1KLKEKkbA4SpjIiylAWD/GFzUUYpbdcBaEjT9VKiltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKFhw95pgjmkypKEzRadc1htYwTiM7GI6XQrL4wtvRQ=;
 b=DUvg7MIa+Eh3hzeXnBMWsmyV4VmJAWEr1SRwerZQ1xQNhYHmBPILVLQrJOnY2fkrOrdVC4JZHt5o8sVZpLfWYObCx4hSmo7UtqD5C9NWjMi1H31Hl9iCkA6PSt+QqKT7ZVaFZq7irwn0dKaGAsLexAHoex/ksOyl+eEFh+e+NNs=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by GV0P278MB1176.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:54:29 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::abd9:4b84:39df:6980]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::abd9:4b84:39df:6980%5]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 14:54:29 +0000
From:   =?utf-8?B?Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kgSmF2aWVy?= 
        <josejavier.rodriguez@duagon.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "jth@kernel.org" <jth@kernel.org>,
        =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        "morbidrsa@gmail.com" <morbidrsa@gmail.com>
Subject: Re: Missing patches of a patch series during AUTOSEL backport
Thread-Topic: Missing patches of a patch series during AUTOSEL backport
Thread-Index: AQHaBnpekPaDiMCt40yF5yZdV146WLBY96OAgAAPYQA=
Date:   Tue, 24 Oct 2023 14:54:29 +0000
Message-ID: <56733d113d0e29f92b39dadd41d4ea5c4666dfb2.camel@duagon.com>
References: <aa7145b39b72237a7cfd9ab8ba92ad26271f4881.camel@duagon.com>
         <2023102450-designed-cosmic-1bb2@gregkh>
In-Reply-To: <2023102450-designed-cosmic-1bb2@gregkh>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|GV0P278MB1176:EE_|AMS0EPF000001B7:EE_|ZR0P278MB0990:EE_|AM3PEPF0000A79A:EE_|ZRAP278MB0755:EE_
X-MS-Office365-Filtering-Correlation-Id: 727b6305-b6f6-4065-35f7-08dbd4a12410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: kmPHuWzunchWwXPhgYEwqZP+SuP1+QnPUoTyMu1j3Z8H5tEhxweqJhkHItLfmDViQD/J/Y8G9KLZhB7LaEERTUbySFsfVXtDi8HCMNpUdgu0OjrCQdQkcsWDMrc8vQiN5a3pPGGihpeE5I7zOHW4yHgqHOEhSc3J+LaZtBXzDVsZ5ZUVhNHG9mSUvm4exCV7pUVW6MpmtcrY9xRgLYDkGMAkYGgfQvwNfc/ZSYZPUx5QU+HIcN4+yr7Y57yuHXrfnxEg+DExb0E7E4jiWA2TwCOn8Nl0OXK7NLVoqplbZcfecSODmZwwPSA/UWtF3G/CvZMJKSslcptdXCnRgvbHtOT7a7fwliwFMcym9ANDou3Yj5i6MTnOLPvwxYchse+1GNz/Zs9mpkTjXm3WH3yKv4FsHK0h37cRsdHCkE0nivNaa2R1VSbZ/3ATgc1umhm6Q8uw/4FRg0Rdfvt7YhbPfK70dQs5F46is0DbKnSbIxYSxkfJvE2NOFwP/Si6P53EYOt9F+nuv8UMbcHPyydCI+b0dmwoud5M2LIXsO13EyRIqTLE6MlhA5YZfW4+SaHqrGd7m9WsY1DDI3haVsCaCtkqjx9cpBH1w/us/cJahiIL5TpV7Tl6xqjAYq2JasJO7wI2vNMzce1Qhn+Cvo+lHw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(366004)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(1590799021)(64100799003)(26005)(38070700009)(4001150100001)(1580799018)(2906002)(86362001)(36756003)(85202003)(5660300002)(41300700001)(8936002)(4326008)(8676002)(85182001)(478600001)(316002)(2616005)(6506007)(71200400001)(66556008)(91956017)(64756008)(122000001)(54906003)(66476007)(38100700002)(6916009)(76116006)(66446008)(66946007)(83380400001)(6512007)(6486002)(966005);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <17A8C6F524247F4FBBE5E692D38E0482@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1176
X-CodeTwo-MessageID: b5711649-bffd-445e-bc9b-4e7e355fef39.20231024145431@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001B7.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: dcc42cfd-240d-49a8-29ba-08dbd4a11fd0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vx/h76PM/IaIU3igAkz9OIF1TzpaIFyl/pooF3iN7k/mcaJgfX1DPRC45tmHfCGQTYR7Q32NsOrC58+zzWNZBmb6l0mXTHe2Jj057kYLR2PVA9im1Sq7BuRyB43notE7rFdB/PVmdo7PDA8Eu/Wa2vNUc6QTEqKnu1N3srmJd3WNZYCLFM3WQ6IGaj97OWVTTffKjM1q8Lfwqzw689UDS83YfUh8Ggda1IKellKm0T8gibunKoO6q2c/4tSQOa9KPslQ4aaCqdhelkKI40vbQcXhb/O9sI8tsr9JtUlwJ46JIit2BkIJEkQ3g3ANXygn+yUFpFoKaSmS6eOB9TGoaNrExZV3kd9zdwCFH1Mku6qKNjzhV8bU8KSfmccd1wobQqVMnCcqMuKhjY9NalgJqSf4ZrmR0L5IOSddnv3F/C+bX7BJEoRi/1sPak5ckDV84VJdWTgwlGdgEyk9wSA+rJRjW6QnKKHXLP7uwBOYOmoEJQUq76aSS5Yrs+oGXIc7y231V5X6DtHLTOkYugrDL+gUxC7k/GmJ+c06QPUrbpiZCSKVNwWxNyzkAk7lrjF//gMlzDhIze4PD+VIAVwmWVuOzlK0d+ANmz47MJNeC+HYpWft6BzRXlcSWgTCaS58dJRNxsGLxblFhCbuywb1PPpWM4VtWr4zhZoJQ7wUAmHc+Pg3t7Lz+mU0U/KleRzNYVH61JkrD62LkSA6A8c3927y1gnfJg31Ms6Mf7F+vTk=
X-Forefront-Antispam-Report-Untrusted: CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39850400004)(230922051799003)(1590799021)(1800799009)(186009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(26005)(4001150100001)(1580799018)(41300700001)(2906002)(356005)(86362001)(85202003)(5660300002)(36756003)(8936002)(8676002)(4326008)(85182001)(2616005)(7596003)(478600001)(7636003)(6506007)(36860700001)(54906003)(70206006)(82740400003)(70586007)(6916009)(316002)(83380400001)(40480700001)(47076005)(966005)(6486002)(6512007)(336012);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0990
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 105c6f14-54fb-4e4f-95aa-08dbd4a1222a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AO6sCZHTSpbVrmt0205s7GQMEYDupLR0Wa8qnnoGkxI0IeBWacWraRXhXOLhdKFtnhcyARWbuSnFfyl+A5jKMNwbCqPkQvSIO1m2BWT5tpInGCONBk3BlTe4oIPI+3FeJFNzerV6as3EIYeMD/bVDV5nG69yXx1TYS/F4YVp2iRI9dQCAxxscaA/nSlPDF3wVTF2KFJIjEbULVkdZshMR/yvRMZPGeRk+38FhKAO9UdLvgu7iEQA8xDkdqXjp0JIOCU/O/WbutdsvUWhlaFnJAhKoMjfyXdxmUv83v2cjFcyFxo5/pIc7zEGykAS6WkAWlG4k6c99A91ALpAww4yFNs/GlqpILocF4NI7Lel/98VyM2wkMR11DJBgTnwbVHXDGdiWcCFODEwxSd2JuTiCd5hAjGcNRS1z9KOJkUiIvTslNkosOf8jByFe5f5Z5Qa0kK6bvxlpnZx3XuktKnP9yRK1VQjYNpelpr+oy4hUZmJpsiGcAHfGGvFHX3lUpTHICcJUp2OrPsDfJsFpmMR3tHJSkE/PSPUEakKBUv3d55e1kh78p/Sx0g3r8eqEp4zLgXqKj4FySgAzevkbKxEfQdX8N4Cwgn9m90LErJHkS9HFlDA+M+ErD/EXQVJ9RmL63H52b65TEKNKlZSK/owYYxRBOdNvBhoUEdKqvpdApLFDx0WLcCsJzwcz8EzGot8oM0/PKt37DR0A21rZT3vpRwcZATIsnEDWeqM4pp3fg1y7+47Q3NlAHi2zx+o5PwhxJBPtpG0ERB2kO/fQXi6A0UkAWuO+dZXUP2JNcPOLw=
X-Forefront-Antispam-Report: CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(1590799021)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(36756003)(1580799018)(2906002)(40460700003)(316002)(81166007)(2616005)(82740400003)(6916009)(70586007)(54906003)(478600001)(6506007)(70206006)(6486002)(966005)(47076005)(6512007)(336012)(40480700001)(83380400001)(5660300002)(86362001)(85202003)(4326008)(8676002)(36860700001)(85182001)(8936002)(26005)(4001150100001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:54:36.0422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727b6305-b6f6-4065-35f7-08dbd4a12410
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0755
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTI0IGF0IDE1OjU5ICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gVHVlLCBPY3QgMjQsIDIwMjMgYXQgMDE6MDI6MzlQTSArMDAwMCwg
Um9kcsOtZ3VleiBCYXJiYXJpbiwgSm9zw6kNCj4gSmF2aWVyIHdyb3RlOg0KPiA+IERlYXIgU2Fz
aGEgTGV2aW4sDQo+ID4gDQo+ID4gSSBhbSB0aGXCoGF1dGhvciBvZiBhIHBhdGNoIHNlcmllcyBh
bmQgSSBhbSB3cml0dGluZyB5b3UgYmVjYXVzZSBJDQo+ID4gaGF2ZQ0KPiA+IGRldGVjdGVkIGFu
IGlzc3VlIHdpdGggYSBwYXRjaCBzZXJpZXMgSSBoYXZlIHN1Ym1pdHRlZCBpbiBNYXknMjMuDQo+
ID4gDQo+ID4gSSBzZW50IGEgc2VyaWVzIG9mIDMgcGF0Y2hlcyB0byB0aGUgbWFpbnRhaW5lci4g
V2hlbiBoZSBhcHByb3ZlZA0KPiA+IHRoZW0sDQo+ID4gaGUgc2VudCBhbiBlbWFpbCB0byBHcmVn
LCByZXF1ZXN0aW5nIGhpbSB0byBpbmNsdWRlIHN1Y2gNCj4gPiBwYXRjaCBzZXJpZXMgaW4ga2Vy
bmVsIDYuNC4NCj4gPiANCj4gPiBZb3UgY2FuIGNoZWNrIHRoZSBlbWFpbCB0aHJlYWQgaGVyZToN
Cj4gPiANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA0MTEwODMzMjkuNDUw
Ni0xLWp0aEBrZXJuZWwub3JnLw0KPiANCj4gSSB0b3RhbGx5IG1pc3NlZCB0aGF0IHBhdGNoIHRo
cmVhZCBhcyB0aGVyZSB3YXMgbm8gZ2l0IGNvbW1pdCBpZHMgaW4NCj4gaXQsDQo+IHNvcnJ5Lg0K
PiANCj4gPiBGb3IgYSByZWFzb24gSSBjYW5ub3QgdW5kZXJzdGFuZCwgdGhlIEFVVE9TRUwgb25s
eSBjaG9zZSAxIG9mIDMNCj4gPiBwYXRjaGVzDQo+ID4gb2YgdGhlIHNlcmllcywgc28gb25seSAx
IHdhcyBiYWNrcG9ydGVkIHRvIHN0YWJsZSBrZXJuZWwgdmVyc2lvbnMuDQo+ID4gDQo+ID4gW1BB
VENIIEFVVE9TRUwgNi4zIDI0LzI0XSBtY2ItcGNpOiBSZWFsbG9jYXRlIG1lbW9yeSByZWdpb24g
dG8NCj4gPiBhdm9pZA0KPiA+IG1lbW9yeSBvdmVybGFwcGluZw0KPiA+IFtQQVRDSCBBVVRPU0VM
IDYuMiAyMC8yMF0gbWNiLXBjaTogUmVhbGxvY2F0ZSBtZW1vcnkgcmVnaW9uIHRvDQo+ID4gYXZv
aWQNCj4gPiBtZW1vcnkgb3ZlcmxhcHBpbmcNCj4gPiBbUEFUQ0ggQVVUT1NFTCA2LjEgMTkvMTld
IG1jYi1wY2k6IFJlYWxsb2NhdGUgbWVtb3J5IHJlZ2lvbiB0bw0KPiA+IGF2b2lkDQo+ID4gbWVt
b3J5IG92ZXJsYXBwaW5nDQo+ID4gW1BBVENIIEFVVE9TRUwgNS4xNSAxMC8xMF0gbWNiLXBjaTog
UmVhbGxvY2F0ZSBtZW1vcnkgcmVnaW9uIHRvDQo+ID4gYXZvaWQNCj4gPiBtZW1vcnkgb3Zlcmxh
cHBpbmcNCj4gPiBbUEFUQ0ggQVVUT1NFTCA1LjEwIDkvOV0gbWNiLXBjaTogUmVhbGxvY2F0ZSBt
ZW1vcnkgcmVnaW9uIHRvIGF2b2lkDQo+ID4gbWVtb3J5IG92ZXJsYXBwaW5nDQo+ID4gW1BBVENI
IEFVVE9TRUwgNS40IDkvOV0gbWNiLXBjaTogUmVhbGxvY2F0ZSBtZW1vcnkgcmVnaW9uIHRvIGF2
b2lkDQo+ID4gbWVtb3J5IG92ZXJsYXBwaW5nDQo+ID4gW1BBVENIIEFVVE9TRUwgNC4xOSA5Lzld
IG1jYi1wY2k6IFJlYWxsb2NhdGUgbWVtb3J5IHJlZ2lvbiB0byBhdm9pZA0KPiA+IG1lbW9yeSBv
dmVybGFwcGluZw0KPiA+IFtQQVRDSCBBVVRPU0VMIDQuMTQgOC84XSBtY2ItcGNpOiBSZWFsbG9j
YXRlIG1lbW9yeSByZWdpb24gdG8gYXZvaWQNCj4gPiBtZW1vcnkgb3ZlcmxhcHBpbmcNCj4gPiAN
Cj4gPiBJbiBrZXJuZWwgNi40IGFuZCBhYm92ZSwgdGhlIDMgcGF0Y2hlcyB3ZXJlIGluY2x1ZGVk
Lg0KPiANCj4gYXV0b3NlbCBjb21lcyBhbG9uZyBsYXRlciBhbmQgZGVjaWRlZCB0aGF0IHNvbWUg
b2YgdGhlbSB3ZXJlIHRvIGJlDQo+IGluY2x1ZGVkLCB0aGF0IHdhcyBpbmRlcGVuZGVudCBvZiB5
b3VyIGVtYWlsLg0KPiANCj4gPiBJbmNsdWRpbmcgb25seSAxIHBhdGNoIGlzIGNhdXNpbmcgY3Jh
c2hlcyBpbiBwYXJ0IG9mIG91ciBkZXZpY2VzLg0KPiA+IA0KPiA+IFBsZWFzZSwgY291bGQgeW91
IGJhY2twb3J0IHRoZSByZW1haW5pbmcgMiBwYXRjaGVzIHRvIHRoZSBzdGFibGUNCj4gPiB2ZXJz
aW9ucz8NCj4gDQo+IFdoYXQgaXMgdGhlIGdpdCBjb21taXQgaWRzIHRoYXQgeW91IGFyZSBhc2tp
bmcgZm9yIHRvIGJlIGFwcGxpZWQ/DQo+IFRoYXQncyBhIHJlcXVpcmVtZW50IGZvciB1cyB0byB0
YWtlIHN0dWZmLg0KPiANClN1cmUsIHRoZSBjb21taXQgaWRzIGFyZToNCg0KYTg4OWMyNzZkMzNk
MzMzYWU5NjY5NzUxMGYzMzUzM2Y2ZTlkOTU5MSAobWNiOiBSZXR1cm4gYWN0dWFsIHBhcnNlZA0K
c2l6ZSB3aGVuIHJlYWRpbmcgY2hhbWVsZW9uIHRhYmxlKQ0KDQoyMDI1YjJjYTgwMDRjMDQ4NjE5
MDNkMDc2YzY3YTczYTBlYzZkZmNhIChtY2ItbHBjOiBSZWFsbG9jYXRlIG1lbW9yeQ0KcmVnaW9u
IHRvIGF2b2lkIG1lbW9yeSBvdmVybGFwcGluZykNCg0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGst
aA0KDQpUaGFuayB5b3Ugc28gbXVjaC4NCg0KUmVnYXJkcywNCg==
