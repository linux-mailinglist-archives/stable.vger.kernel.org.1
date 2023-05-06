Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA16F8D89
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 03:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjEFBb1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 5 May 2023 21:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEFBbZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 5 May 2023 21:31:25 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4800F7298;
        Fri,  5 May 2023 18:31:23 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345NXjLs003913;
        Fri, 5 May 2023 18:31:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Gzt34lMA5XnUbebI6guGqo7eaGtsgNFz8g4prrX/spU=;
 b=CaI0zMexCrQs9qD0A+D+Loiqnn7NJkjf6qaGf/iZK+eiwbqwESU8TAQEdMaDnWqdUl1x
 Uo0BgDFHYznul3e2M6G3lEc+pvV8KyvmxL8vPJO+FbHZkyCpH9Ux6KWaaBPnZbwRgSzy
 yNJcjGVjQwkWddC/8QwSgUQhtJDdLKAocGBkQvh7pa46ycbLeYD2DKfmgHSswXqrlMaw
 x+HxWgLGZTbsxRb0y68aLz4eFyCLUyv1FYn/LqJrRENDBeXaaG9JUEXSDSexLPg2Tkf+
 PsA3LstpavMCZjd/OO+/ZIueZ/Wu7VJKnVg79+BvjbdouCxwF/s5/Q2CgwC0HvZqoAZ1 hA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3q91vjsb9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 18:31:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683336666; bh=Gzt34lMA5XnUbebI6guGqo7eaGtsgNFz8g4prrX/spU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cYWeNsm1oskXxMhoGqxc3MtianasGGzeE96x8YKhlyqIsqWeGa1pWeAsJsZhoKBRE
         obgYhsPBq/CDgRPlnxlhWRHEJbi4+/sUnCzGpD34P+uI9sx4wA6fAe8497iep8Bq1B
         4M1AmCDeX2HRZ6kp4eMET7QDze+uPVTvWobpvsBxv5uWjT7bL8Z5H2Q9JMIlMF5PH0
         /yF2Nz3+uRKXyocuq3s2UjRtIUTZYBO52B2jiL8se5y8u7mI2vomdvpPGqvGcMohXi
         meovwwO+5BpHEULEBwsoB1KBpwKNwkRJ0pt8RBKVg/r37P5qzdw36gcwvHJk+7djzZ
         IUtl2LCDAOXag==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E79F44060B;
        Sat,  6 May 2023 01:31:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5F4A8A009D;
        Sat,  6 May 2023 01:31:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=hliXDaR0;
        dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3AC9A40407;
        Sat,  6 May 2023 01:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGb19FdNEfES0ih0+4tVsmHeYqRi34Xc3HaeYcadFhwRYimD125Of2LXGiYhjJR8NrmjE8ICcSe+sSrJVFY2dkO0rbzp0Oz83cX5yN917ZB+rssjXd3WcVIjySpA6BLErEimCeY1qkLnMI1ucjncztujjw7/QkV1QZhIxN1b46ucRLDgupoirjhCXQXbxeyk+fodeaw/FGdtGSzMyr+j0jQgOZjA9VgM4c9WeBU4qj/3F6QUoclupBAqVid90ZbUet/MEApg+5Dm2iCsticShstHSMnKWBNlLHPPVjLr6onYItKxN13mMrnF9SdVqehRmDU/nzKTtbCjrAVsP2Fv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gzt34lMA5XnUbebI6guGqo7eaGtsgNFz8g4prrX/spU=;
 b=h5493Semv1HHyFL1s8j8xiGHfHGk1pM0NCRkLV79K+EsFCpON4TpsN/w3Te6z67X0KVp8j4g5JIZ4ZqD04jpoX34Zutlys8mACvoRhdvXkQrxUyzr5SWmP+MJ2Uwbv7nrNLS9TWMR8ZevnbPtw1KdvBxXXlYpWp4fIjctESFtGXjjvb1yEb54z+YNAFWJpXeiHFe8PXI/6B4bttpFuUf4skodayjQshVwFnUtzNGALHdF2jT6cBofgu2ZNu7XxYn5UjJu2rFjSCxaBZfg6+pimBSMYt0O90jMMd29ibGClCNwuJg7CkgitqW4Vo3q7ROCi1/sz3AXi9lR805Wh7GVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gzt34lMA5XnUbebI6guGqo7eaGtsgNFz8g4prrX/spU=;
 b=hliXDaR0y7AdpfLtjnziX/2PWdzoIrL4/pcpPD1GK5OhRTY+aq0gLr1SMcjtcHkSytdGzx99xqtIVG0MCEKqKcN/37QNdSbIKvyhkinRR8pz4zttUpneXpfOgnpt5/huBmxAZzyrMGL4kFWuyOclnQgN73rREFYiI3GPS2t4DFs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 01:30:59 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6363.026; Sat, 6 May 2023
 01:30:52 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Udipto Goswami <quic_ugoswami@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v9] usb: dwc3: debugfs: Prevent any register access when
 devices is runtime suspended
Thread-Topic: [PATCH v9] usb: dwc3: debugfs: Prevent any register access when
 devices is runtime suspended
Thread-Index: AQHZf2l4kcoPHu1YZ0iajCwW37QBSq9MdeQA
Date:   Sat, 6 May 2023 01:30:52 +0000
Message-ID: <20230506013036.j533xncixkky5uf6@synopsys.com>
References: <20230505155103.30098-1-quic_ugoswami@quicinc.com>
In-Reply-To: <20230505155103.30098-1-quic_ugoswami@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SA3PR12MB8048:EE_
x-ms-office365-filtering-correlation-id: 58c3962a-aba6-4772-5671-08db4dd187b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KTQa5soyBd19sGs08k8VXYgi3G16j1hM2+5TzdOiy9bTdTkPTtqfJyd5PZGvtRzzLIJji4nkw2mrEzSzFKPiKJ459Ba3zR4+nJ3vWSA6sL7Ib49sTA8CEwMJ+CxmvQCWR6ngPEjoUkY3uPRAkWrv8SIlCIpfQWvKdQ174nP4HKm9FT1Jl9Gr95JpnD7XXlNpqYUDHzerpxpi/NTQC1iO+qIgLwbun928XV6T0s6dAqOf/zp6iE9eiNRq8cyrBswNsLtlCbiG2FvIYAysO0YpjZ+YHDfSSF6hrag2wUcE+YBmMIACOAWsjMN50M6nN+Xu6IldzwmFA3uNxFQ2C0wbRGJGpkjl3Wb3xyU/02V+o0OcXf6WKQ2+pOZH7y/dunCKB1/meYcqmgoAeQ/fNFnLgnGzxhk6uAb+dvufpTxBMO/hvbZ44a7wLQbjkDrfFvGt5vZoBvuiHpCe8hmikW59ft3RuanpeosQV9hYeQg0YLaULro4hYh+aZRy9jYfVYTjBTTIUKKkiHFeUdHra1uvVj0jOAeJFwFGe4vKciuu4bo6M8QIF7FDhOjEQ1r8PRSVbhwcsoiCXAjqae+wGCoVQIDRcgstc9FywGihwbCB4YKIi3fYBCRwcv4pQqvjlitK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(478600001)(6486002)(316002)(54906003)(86362001)(36756003)(83380400001)(2616005)(6512007)(6506007)(1076003)(26005)(71200400001)(8676002)(8936002)(5660300002)(41300700001)(15650500001)(30864003)(2906002)(38070700005)(186003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3RKSldUYmpuTFdCT1VQVzdUVjFVU3F0SHNkK2tDOWt4ZUNkWlQybHFiUVpS?=
 =?utf-8?B?U2lnLytNMnR2Z3BGNVJ1QUlQVFNmK2ZWUFFab2VDUnN0Uzh1emtpSjhGSTVy?=
 =?utf-8?B?bmJqSjZCdVA5RkcwR2JwV1ZGQjlaRHg5OEw0N1RKNUJXSko3R3QyUmMwL0Y2?=
 =?utf-8?B?WVhwNTZsYndhU1B2blY5QkJQSzlYbjdWUHVyNm9PVGNVeTdVNVlDRUEwSkxR?=
 =?utf-8?B?encxdWlHMEdRSU9uUDd1NGQyaHV0ZG5nTUFOQmw5cmd4TS9KVnc5UllmUndi?=
 =?utf-8?B?MnF2emZ5YjIxdTRyUHBVQ0c2QU8wRzFsK0Z3Qk0vTFFIUGtHUGoxQ0N4TEw0?=
 =?utf-8?B?WnhWR2dRN1M0QnZWZXZiTys4QkxGazRsUUhrOVNKaUYwYWIyN3J2eGthcVlU?=
 =?utf-8?B?d3BlOTF1ZzZYR09EQ3BtTnZUTnFSdVMrdTloRzRoMkRwOW1oUXBvZmczQVhl?=
 =?utf-8?B?SjZjTlZZOXJPcDdIL1cvRnNKQmJGR3RkWHhtVHZDdGtFNk5hbXIzQS8vTWJJ?=
 =?utf-8?B?N2VWR0hNR2htMlNCSlZLc2ZtcHpURjA2VmNUMTZEMkJHeU9NaTB0cWdkSG1h?=
 =?utf-8?B?c2ZHbE0vSUttMFAxa1RWNUQ0Z09VblFBNGFhVHZBU0lUQjJKRGJieVZFZzRE?=
 =?utf-8?B?ZnZVakx4c1dPbVpPWmt6VmxSbjdCcWd2YjNqQmNlTFppMWlUcUdac0hLcjVl?=
 =?utf-8?B?b3NQU1A1c3ZVdnB3QXJpWFV1RVAxcnNUY0ZYK0prL3F5YXB4QXY2UXlndUFG?=
 =?utf-8?B?T2RUb3VoT3hEMzlmNktYRElkVHBrU2tEVFE1ZjlBWEhDQ2lrWjd0ZC9MV3hq?=
 =?utf-8?B?d2c4SDM3TnVETlQwME9FZXRRYTZ6eEpWcThsNnNnTktSck1xUGdSZnlkR3Jw?=
 =?utf-8?B?SXpmTDBNZWVYNXB5N2IxOFBoRG51eEhpOVB3eWJMTXhkZVEybVVCVU9GWmM0?=
 =?utf-8?B?WjhOTW02UzYvNUVJN2xMNlYrV3hvRTRwMDY0WEFmRklCMzRxenZ6YlZiVjVJ?=
 =?utf-8?B?TE1PYStXa2MzQlBNK0h3QzZVcnlFOFM4aXBDaHF1OFAvTkFTQmtTWDJ4Rjlz?=
 =?utf-8?B?eW41WmtEMXF6elZnWmlwa25ncjRhMmpsZmk5MEVyQStxL3FpSGdFTzZHZ3p2?=
 =?utf-8?B?M2lwRTdmWUhSMjBNeXk4OXNlZk9VSUtxanhuOU9sNGNEZ1UvS2NKK3U0OUNE?=
 =?utf-8?B?SDlhVVlpL3VsVDB4UzJFOHRsWXhscmZyTlZzdExndjNCWXFCZGNMNlZjZXBG?=
 =?utf-8?B?S0U2ZVFDVStDOGVVbzZ2bzhTcDBZcUhaSzBFSjZsUmVuc24rNzFFc2RkZzFO?=
 =?utf-8?B?bEh6cFphWHcxQk5ZQnRCN21EeDVYb2VGUDhXOStoK3FHQzhTNTYxVTR2UVB4?=
 =?utf-8?B?MWNXNTBreXdaMHc2YjNrRmRyWjdkWEJRN1VKRmhiNVowa2JPZmtBL1lTZnQw?=
 =?utf-8?B?cVRYdittNjJzdENDNkdkeUR4VXlkQ1UwQ1VlVDZRdnZ1YWR0L0NnTlM3Q0NL?=
 =?utf-8?B?Qk85cmNhQzFlOHlxeWVlYU1qS2RTeXRlbGI3RWd0YVp3eElGWCtWQ25TaVYv?=
 =?utf-8?B?TkVleTMwNDFIa1d0a255eHViYTlMVzUvNHc3c3R3K2dxRDZhd21YY1B5YjlN?=
 =?utf-8?B?bXhOT2xTQmw1RUVrMFZzMlR4K2pVM2o5T3JmWElHbEh1d3VwRUI1Wk9RN0dR?=
 =?utf-8?B?QVByUzFXdmhNZ0VOUld2WTNMYjZYczUwdnJ4Ti94T29ZZm45cDNOV1Y2bGJr?=
 =?utf-8?B?RFFSZFRBcXkvVlJZNGEydzhTaEtVTzUybWRZd3pTTXpNK2w5d3F3TStUZ2py?=
 =?utf-8?B?eEJEL1dWbnFxY3RydzZFSVN6bjFoQ0hGWHpuWXpFdUgyVDJHamVjMDUxazlv?=
 =?utf-8?B?SktDYUNKQzVmaDlJNEVWVm53KzYvOXN1NXpaQlJrbGxuUmpBeDlqellrc1pT?=
 =?utf-8?B?ZlRMU0NnQmZrWnFGMGNQWCtoK0JaT0JDK2x0MTZuUzNwMy9CODlsdDQwaEVK?=
 =?utf-8?B?b05IWWxVYzFEQ2VBcGEwMDgxR3ZFZ1NMMXhYN0RtZ20zMk16MjUwSklURENW?=
 =?utf-8?B?UWNhZkpTNURqaXJHSnBKT2MwT2xzdHNEM3hONjEwUFdmTkJ6T2NZWEdaWm1z?=
 =?utf-8?Q?lLKeayBKXMpkq/nF7/vBM6+X5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB398E916FBB0D4DB37B8BADBEABB53A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ejZVck5sSUVBVzRMWEw2blJjMG9ZVms4NXJtWFZ3ODEreTFCZzFvSUxtcG9u?=
 =?utf-8?B?STFkaGxGaWNwYVk4Q253a2FKOVhvU3dmRk9wZXkyTlBoYmpXOVBockI2cHNw?=
 =?utf-8?B?aTNMcXlxbXV1LzRlMjdtUVhSMVNMT3M3VFJsOXhUQXpBT0diL203aFM3WXVM?=
 =?utf-8?B?Ry9xL1Zjd0tFTzE1N3ZlNWEwdEl4cFZOOWVJam5kN3ArMmQ0WWU2am1LMzcr?=
 =?utf-8?B?Vkhzcjh1UStjOXNsSjcxSDFuS1Y1Z0hzTEVDNXp6SEtuWXU5eEZTMzR1RnNi?=
 =?utf-8?B?RWlHc1RNeGlBWlhmQ2JSVlphMnRsQURDdlZOYzc2aEFXaTh3MUhIQU9FbEZq?=
 =?utf-8?B?MDNxZmtzUU1SMDlpV0twdjdlTUtlU2ZxdE9Ba1ROb3E3MzVqSjdONDRiOFlO?=
 =?utf-8?B?Z3NmZHNyT2RMQW9jYW9PSFd0cE53eEF0cXMzWmd2RENDQTZjVm1YNkwvbmdU?=
 =?utf-8?B?VjBva1dIbndSM2xJN1JtcjUvYjZrcDZZSFY0UExpaThDZDZUQVhzeVo5ZE1h?=
 =?utf-8?B?NzlhUDkxbHlZdGVwZXFSNGxWcTF6bFV5cHlmUUtqai9lMUt2a2dTZzhrUUpi?=
 =?utf-8?B?aEQ4VGd6eDh4Z0U2MjAxa0hHSExtY2l5eWdjVVg4RmRlMzltMlFVNlRkWGgz?=
 =?utf-8?B?REdzZ3dtdjdTYmQ5N3Z0QnhnQldUOUJ6ZjFwUFJ5OUhsU25KMnhvbzFDS1B5?=
 =?utf-8?B?UWlvKzZmai9YY25TUnZWSVhUTWFDZWhPcmpQVlc3WmFhSURaVDN3ZlRNS0lM?=
 =?utf-8?B?aFQwb2JNVnIvMjJmc3JXU0ZtaXcycmlxdUMvTS84OEYyc3BCeHpXNE5uZWFo?=
 =?utf-8?B?WTQwZXV5Qmg1UHFvbkxDajFVTVJwMXJDaVJQZkVVQkxkNnRQek81UWo5SWhZ?=
 =?utf-8?B?K3VXMm10VzRQNmk3MFBBZ0RXeTVjM1JkbXhKSDBwQTRYYXBpVjNpdk91ejdC?=
 =?utf-8?B?L3BYNmR4eHFVVFdkQnphcElBWC9VN0pKVy9hVVpESGZ3SHdzT3VlK3V5aFA5?=
 =?utf-8?B?UUhRc3dNNHZmNnhZMnRrN1RlTmQza1Q4T3ExVWxNWGJsMzVmcmhCaWdLSlJi?=
 =?utf-8?B?bTRxaGJoRTBRcnZiakJQc3VjdmR3YTBMQkx2WVRXUnNINGdNcEFMU0VBWFlk?=
 =?utf-8?B?K3U4Uy9xYllEdE5uekx5QmRjdlF0ZlBEdW5hN3VwM1ZiWHlzbHliY1RHaWNy?=
 =?utf-8?B?eHh2a3BBSC9LclBRMC9OOEdndllTNk9mcUVMektZRXlnSGtHd1lXa2NwUll1?=
 =?utf-8?Q?QjUxM0jjTIiyG7P?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c3962a-aba6-4772-5671-08db4dd187b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 01:30:52.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zb13uPXPB1s063ZQCbRSg9dB9TqVg3d6hP2a5BTKsukxRZnS3vgYleazlg03NZ8X88DvyTbkdtcV0SDlEPM9NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
X-Proofpoint-GUID: Tktwby2b0JoNbGdoPp26yue-WEtdtJPv
X-Proofpoint-ORIG-GUID: Tktwby2b0JoNbGdoPp26yue-WEtdtJPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_29,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305060009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

T24gRnJpLCBNYXkgMDUsIDIwMjMsIFVkaXB0byBHb3N3YW1pIHdyb3RlOg0KPiBXaGVuIHRoZSBk
d2MzIGRldmljZSBpcyBydW50aW1lIHN1c3BlbmRlZCwgdmFyaW91cyByZXF1aXJlZCBjbG9ja3Mg
d291bGQNCj4gZ2V0IGRpc2FibGVkIGFuZCBpdCBpcyBub3QgZ3VhcmFudGVlZCB0aGF0IGFjY2Vz
cyB0byBhbnkgcmVnaXN0ZXJzIHdvdWxkDQo+IHdvcmsuIERlcGVuZGluZyBvbiB0aGUgU29DIGds
dWUsIGEgcmVnaXN0ZXIgcmVhZCBjb3VsZCBiZSBhcyBiZW5pZ24gYXMNCj4gcmV0dXJuaW5nIDAg
b3IgYmUgZmF0YWwgZW5vdWdoIHRvIGhhbmcgdGhlIHN5c3RlbS4NCj4gDQo+IEluIG9yZGVyIHRv
IHByZXZlbnQgc3VjaCBzY2VuYXJpb3Mgb2YgZmF0YWwgZXJyb3JzLCBtYWtlIHN1cmUgdG8gcmVz
dW1lDQo+IGR3YzMgdGhlbiBhbGxvdyB0aGUgZnVuY3Rpb24gdG8gcHJvY2VlZC4NCj4gDQo+IEZp
eGVzOiA2MmJhMDlkNmJiNjMgKCJ1c2I6IGR3YzM6IGRlYnVnZnM6IER1bXAgaW50ZXJuYWwgTFNQ
IGFuZCBlcCByZWdpc3RlcnMiKQ0KDQpUaGlzIGZpeCBnb2VzIGJlZm9yZSB0aGUgYWJvdmUgY2hh
bmdlLg0KDQpUaGlzIGFsc28gdG91Y2hlcyBvbiBtYW55IHBsYWNlcyBhbmQgaXMgbW9yZSB0aGFu
IDEwMCBsaW5lcy4gV2hpbGUgdGhpcw0KaXMgYSBmaXgsIEknbSBub3Qgc3VyZSBpZiBDYyBzdGFi
bGUgaXMgbmVlZGVkLiBQZXJoYXBzIG90aGVycyBjYW4NCmNvbW1lbnQuDQoNClRoYW5rcywNClRo
aW5oDQoNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogVWRp
cHRvIEdvc3dhbWkgPHF1aWNfdWdvc3dhbWlAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiB2OTogRml4
ZWQgZnVuY3Rpb24gZHdjM19yeF9maWZvX3NpemVfc2hvdyAmIHJldHVybiB2YWx1ZXMgaW4gZnVu
Y3Rpb24NCj4gCWR3YzNfbGlua19zdGF0ZV93cml0ZSBhbG9uZyB3aXRoIG1pbm9yIGNoYW5nZXMg
Zm9yIGNvZGUgc3ltbWV0cnkuDQo+IHY4OiBSZXBsYWNlIHBtX3J1bnRpbWVfZ2V0X3N5bmMgd2l0
aCBwbV9ydW50aW1lX3Jlc3VtZV9hbmQgZ2V0Lg0KPiB2NzogUmVwbGFjZWQgcG1fcnVudGltZV9w
dXQgd2l0aCBwbV9ydW50aW1lX3B1dF9zeW5jICYgcmV0dXJuZWQgcHJvcGVyIHZhbHVlcy4NCj4g
djY6IEFkZGVkIGNoYW5nZXMgdG8gaGFuZGxlIGdldF9keW5jIGZhaWx1cmUgYXBwcm9wcmlhdGVs
eS4NCj4gdjU6IFJld29ya2VkIHRoZSBwYXRjaCB0byByZXN1bWUgZHdjMyB3aGlsZSBhY2Nlc3Np
bmcgdGhlIHJlZ2lzdGVycy4NCj4gdjQ6IEludHJvZHVjZWQgcG1fcnVudGltZV9nZXRfaWZfaW5f
dXNlIGluIG9yZGVyIHRvIG1ha2Ugc3VyZSBkd2MzIGlzbid0DQo+IAlzdXNwZW5kZWQgd2hpbGUg
YWNjZXNzaW5nIHRoZSByZWdpc3RlcnMuDQo+IHYzOiBSZXBsYWNlIHByX2VyciB0byBkZXZfZXJy
LiANCj4gdjI6IFJlcGxhY2VkIHJldHVybiAwIHdpdGggLUVJTlZBTCAmIHNlcV9wdXRzIHdpdGgg
cHJfZXJyLg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvZGVidWdmcy5jIHwgMTA5ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMDkgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZGVidWdmcy5j
IGIvZHJpdmVycy91c2IvZHdjMy9kZWJ1Z2ZzLmMNCj4gaW5kZXggZTRhMjU2MGI5ZGMwLi5lYmYw
MzQ2OGZhYzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZGVidWdmcy5jDQo+ICsr
KyBiL2RyaXZlcnMvdXNiL2R3YzMvZGVidWdmcy5jDQo+IEBAIC0zMzIsNiArMzMyLDExIEBAIHN0
YXRpYyBpbnQgZHdjM19sc3Bfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKnVudXNlZCkN
Cj4gIAl1bnNpZ25lZCBpbnQJCWN1cnJlbnRfbW9kZTsNCj4gIAl1bnNpZ25lZCBsb25nCQlmbGFn
czsNCj4gIAl1MzIJCQlyZWc7DQo+ICsJaW50CQkJcmV0Ow0KPiArDQo+ICsJcmV0ID0gcG1fcnVu
dGltZV9yZXN1bWVfYW5kX2dldChkd2MtPmRldik7DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJl
dHVybiByZXQ7DQo+ICANCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7
DQo+ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1NUUyk7DQo+IEBAIC0zNTAs
NiArMzU1LDggQEAgc3RhdGljIGludCBkd2MzX2xzcF9zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywg
dm9pZCAqdW51c2VkKQ0KPiAgCX0NCj4gIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxv
Y2ssIGZsYWdzKTsNCj4gIA0KPiArCXBtX3J1bnRpbWVfcHV0X3N5bmMoZHdjLT5kZXYpOw0KPiAr
DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gQEAgLTM5NSw2ICs0MDIsMTEgQEAgc3RhdGlj
IGludCBkd2MzX21vZGVfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKnVudXNlZCkNCj4g
IAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IHMtPnByaXZhdGU7DQo+ICAJdW5zaWduZWQgbG9uZwkJZmxh
Z3M7DQo+ICAJdTMyCQkJcmVnOw0KPiArCWludAkJCXJldDsNCj4gKw0KPiArCXJldCA9IHBtX3J1
bnRpbWVfcmVzdW1lX2FuZF9nZXQoZHdjLT5kZXYpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQly
ZXR1cm4gcmV0Ow0KPiAgDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3Mp
Ow0KPiAgCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dDVEwpOw0KPiBAQCAtNDE0
LDYgKzQyNiw4IEBAIHN0YXRpYyBpbnQgZHdjM19tb2RlX3Nob3coc3RydWN0IHNlcV9maWxlICpz
LCB2b2lkICp1bnVzZWQpDQo+ICAJCXNlcV9wcmludGYocywgIlVOS05PV04gJTA4eFxuIiwgRFdD
M19HQ1RMX1BSVENBUChyZWcpKTsNCj4gIAl9DQo+ICANCj4gKwlwbV9ydW50aW1lX3B1dF9zeW5j
KGR3Yy0+ZGV2KTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC00NjMsNiAr
NDc3LDExIEBAIHN0YXRpYyBpbnQgZHdjM190ZXN0bW9kZV9zaG93KHN0cnVjdCBzZXFfZmlsZSAq
cywgdm9pZCAqdW51c2VkKQ0KPiAgCXN0cnVjdCBkd2MzCQkqZHdjID0gcy0+cHJpdmF0ZTsNCj4g
IAl1bnNpZ25lZCBsb25nCQlmbGFnczsNCj4gIAl1MzIJCQlyZWc7DQo+ICsJaW50CQkJcmV0Ow0K
PiArDQo+ICsJcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChkd2MtPmRldik7DQo+ICsJ
aWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICANCj4gIAlzcGluX2xvY2tfaXJxc2F2
ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERX
QzNfRENUTCk7DQo+IEBAIC00OTMsNiArNTEyLDggQEAgc3RhdGljIGludCBkd2MzX3Rlc3Rtb2Rl
X3Nob3coc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJCXNlcV9wcmludGYo
cywgIlVOS05PV04gJWRcbiIsIHJlZyk7DQo+ICAJfQ0KPiAgDQo+ICsJcG1fcnVudGltZV9wdXRf
c3luYyhkd2MtPmRldik7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiBAQCAtNTA5
LDYgKzUzMCw3IEBAIHN0YXRpYyBzc2l6ZV90IGR3YzNfdGVzdG1vZGVfd3JpdGUoc3RydWN0IGZp
bGUgKmZpbGUsDQo+ICAJdW5zaWduZWQgbG9uZwkJZmxhZ3M7DQo+ICAJdTMyCQkJdGVzdG1vZGUg
PSAwOw0KPiAgCWNoYXIJCQlidWZbMzJdOw0KPiArCWludAkJCXJldDsNCj4gIA0KPiAgCWlmIChj
b3B5X2Zyb21fdXNlcigmYnVmLCB1YnVmLCBtaW5fdChzaXplX3QsIHNpemVvZihidWYpIC0gMSwg
Y291bnQpKSkNCj4gIAkJcmV0dXJuIC1FRkFVTFQ7DQo+IEBAIC01MjYsMTAgKzU0OCwxNiBAQCBz
dGF0aWMgc3NpemVfdCBkd2MzX3Rlc3Rtb2RlX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLA0KPiAg
CWVsc2UNCj4gIAkJdGVzdG1vZGUgPSAwOw0KPiAgDQo+ICsJcmV0ID0gcG1fcnVudGltZV9yZXN1
bWVfYW5kX2dldChkd2MtPmRldik7DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7
DQo+ICsNCj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJZHdj
M19nYWRnZXRfc2V0X3Rlc3RfbW9kZShkd2MsIHRlc3Rtb2RlKTsNCj4gIAlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIA0KPiArCXBtX3J1bnRpbWVfcHV0X3N5
bmMoZHdjLT5kZXYpOw0KPiArDQo+ICAJcmV0dXJuIGNvdW50Ow0KPiAgfQ0KPiAgDQo+IEBAIC01
NDgsMTIgKzU3NiwxOCBAQCBzdGF0aWMgaW50IGR3YzNfbGlua19zdGF0ZV9zaG93KHN0cnVjdCBz
ZXFfZmlsZSAqcywgdm9pZCAqdW51c2VkKQ0KPiAgCWVudW0gZHdjM19saW5rX3N0YXRlCXN0YXRl
Ow0KPiAgCXUzMgkJCXJlZzsNCj4gIAl1OAkJCXNwZWVkOw0KPiArCWludAkJCXJldDsNCj4gKw0K
PiArCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZHdjLT5kZXYpOw0KPiArCWlmIChy
ZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3
Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dT
VFMpOw0KPiAgCWlmIChEV0MzX0dTVFNfQ1VSTU9EKHJlZykgIT0gRFdDM19HU1RTX0NVUk1PRF9E
RVZJQ0UpIHsNCj4gIAkJc2VxX3B1dHMocywgIk5vdCBhdmFpbGFibGVcbiIpOw0KPiAgCQlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKwkJcG1fcnVudGltZV9w
dXRfc3luYyhkd2MtPmRldik7DQo+ICAJCXJldHVybiAwOw0KPiAgCX0NCj4gIA0KPiBAQCAtNTY2
LDYgKzYwMCw4IEBAIHN0YXRpYyBpbnQgZHdjM19saW5rX3N0YXRlX3Nob3coc3RydWN0IHNlcV9m
aWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJCSAgIGR3YzNfZ2FkZ2V0X2hzX2xpbmtfc3RyaW5n
KHN0YXRlKSk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7
DQo+ICANCj4gKwlwbV9ydW50aW1lX3B1dF9zeW5jKGR3Yy0+ZGV2KTsNCj4gKw0KPiAgCXJldHVy
biAwOw0KPiAgfQ0KPiAgDQo+IEBAIC01ODQsNiArNjIwLDcgQEAgc3RhdGljIHNzaXplX3QgZHdj
M19saW5rX3N0YXRlX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLA0KPiAgCWNoYXIJCQlidWZbMzJd
Ow0KPiAgCXUzMgkJCXJlZzsNCj4gIAl1OAkJCXNwZWVkOw0KPiArCWludAkJCXJldDsNCj4gIA0K
PiAgCWlmIChjb3B5X2Zyb21fdXNlcigmYnVmLCB1YnVmLCBtaW5fdChzaXplX3QsIHNpemVvZihi
dWYpIC0gMSwgY291bnQpKSkNCj4gIAkJcmV0dXJuIC1FRkFVTFQ7DQo+IEBAIC02MDMsMTAgKzY0
MCwxNSBAQCBzdGF0aWMgc3NpemVfdCBkd2MzX2xpbmtfc3RhdGVfd3JpdGUoc3RydWN0IGZpbGUg
KmZpbGUsDQo+ICAJZWxzZQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIA0KPiArCXJldCA9IHBt
X3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZHdjLT5kZXYpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxh
Z3MpOw0KPiAgCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dTVFMpOw0KPiAgCWlm
IChEV0MzX0dTVFNfQ1VSTU9EKHJlZykgIT0gRFdDM19HU1RTX0NVUk1PRF9ERVZJQ0UpIHsNCj4g
IAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJCXBtX3J1
bnRpbWVfcHV0X3N5bmMoZHdjLT5kZXYpOw0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+
ICANCj4gQEAgLTYxNiwxMiArNjU4LDE1IEBAIHN0YXRpYyBzc2l6ZV90IGR3YzNfbGlua19zdGF0
ZV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4gIAlpZiAoc3BlZWQgPCBEV0MzX0RTVFNfU1VQ
RVJTUEVFRCAmJg0KPiAgCSAgICBzdGF0ZSAhPSBEV0MzX0xJTktfU1RBVEVfUkVDT1YpIHsNCj4g
IAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJCXBtX3J1
bnRpbWVfcHV0X3N5bmMoZHdjLT5kZXYpOw0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+
ICANCj4gIAlkd2MzX2dhZGdldF9zZXRfbGlua19zdGF0ZShkd2MsIHN0YXRlKTsNCj4gIAlzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIA0KPiArCXBtX3J1bnRp
bWVfcHV0X3N5bmMoZHdjLT5kZXYpOw0KPiArDQo+ICAJcmV0dXJuIGNvdW50Ow0KPiAgfQ0KPiAg
DQo+IEBAIC02NDUsNiArNjkwLDExIEBAIHN0YXRpYyBpbnQgZHdjM190eF9maWZvX3NpemVfc2hv
dyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKnVudXNlZCkNCj4gIAl1bnNpZ25lZCBsb25nCQlm
bGFnczsNCj4gIAl1MzIJCQltZHdpZHRoOw0KPiAgCXUzMgkJCXZhbDsNCj4gKwlpbnQJCQlyZXQ7
DQo+ICsNCj4gKwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGR3Yy0+ZGV2KTsNCj4g
KwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFz
YXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIAl2YWwgPSBkd2MzX2NvcmVfZmlmb19zcGFjZShk
ZXAsIERXQzNfVFhGSUZPKTsNCj4gQEAgLTY1Nyw2ICs3MDcsOCBAQCBzdGF0aWMgaW50IGR3YzNf
dHhfZmlmb19zaXplX3Nob3coc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJ
c2VxX3ByaW50ZihzLCAiJXVcbiIsIHZhbCk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
ZHdjLT5sb2NrLCBmbGFncyk7DQo+ICANCj4gKwlwbV9ydW50aW1lX3B1dF9zeW5jKGR3Yy0+ZGV2
KTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC02NjcsNiArNzE5LDExIEBA
IHN0YXRpYyBpbnQgZHdjM19yeF9maWZvX3NpemVfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZv
aWQgKnVudXNlZCkNCj4gIAl1bnNpZ25lZCBsb25nCQlmbGFnczsNCj4gIAl1MzIJCQltZHdpZHRo
Ow0KPiAgCXUzMgkJCXZhbDsNCj4gKwlpbnQJCQlyZXQ7DQo+ICsNCj4gKwlyZXQgPSBwbV9ydW50
aW1lX3Jlc3VtZV9hbmRfZ2V0KGR3Yy0+ZGV2KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0
dXJuIHJldDsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsN
Cj4gIAl2YWwgPSBkd2MzX2NvcmVfZmlmb19zcGFjZShkZXAsIERXQzNfUlhGSUZPKTsNCj4gQEAg
LTY3OSw2ICs3MzYsOCBAQCBzdGF0aWMgaW50IGR3YzNfcnhfZmlmb19zaXplX3Nob3coc3RydWN0
IHNlcV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJc2VxX3ByaW50ZihzLCAiJXVcbiIsIHZh
bCk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAN
Cj4gKwlwbV9ydW50aW1lX3B1dF9zeW5jKGR3Yy0+ZGV2KTsNCj4gKw0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiAgDQo+IEBAIC02ODgsMTIgKzc0NywxOSBAQCBzdGF0aWMgaW50IGR3YzNfdHhfcmVx
dWVzdF9xdWV1ZV9zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdW51c2VkKQ0KPiAgCXN0
cnVjdCBkd2MzCQkqZHdjID0gZGVwLT5kd2M7DQo+ICAJdW5zaWduZWQgbG9uZwkJZmxhZ3M7DQo+
ICAJdTMyCQkJdmFsOw0KPiArCWludAkJCXJldDsNCj4gKw0KPiArCXJldCA9IHBtX3J1bnRpbWVf
cmVzdW1lX2FuZF9nZXQoZHdjLT5kZXYpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4g
cmV0Ow0KPiAgDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAg
CXZhbCA9IGR3YzNfY29yZV9maWZvX3NwYWNlKGRlcCwgRFdDM19UWFJFUVEpOw0KPiAgCXNlcV9w
cmludGYocywgIiV1XG4iLCB2YWwpOw0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+
bG9jaywgZmxhZ3MpOw0KPiAgDQo+ICsJcG1fcnVudGltZV9wdXRfc3luYyhkd2MtPmRldik7DQo+
ICsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiBAQCAtNzAzLDEyICs3NjksMTkgQEAgc3Rh
dGljIGludCBkd2MzX3J4X3JlcXVlc3RfcXVldWVfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZv
aWQgKnVudXNlZCkNCj4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGRlcC0+ZHdjOw0KPiAgCXVuc2ln
bmVkIGxvbmcJCWZsYWdzOw0KPiAgCXUzMgkJCXZhbDsNCj4gKwlpbnQJCQlyZXQ7DQo+ICsNCj4g
KwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGR3Yy0+ZGV2KTsNCj4gKwlpZiAocmV0
IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZkd2Mt
PmxvY2ssIGZsYWdzKTsNCj4gIAl2YWwgPSBkd2MzX2NvcmVfZmlmb19zcGFjZShkZXAsIERXQzNf
UlhSRVFRKTsNCj4gIAlzZXFfcHJpbnRmKHMsICIldVxuIiwgdmFsKTsNCj4gIAlzcGluX3VubG9j
a19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIA0KPiArCXBtX3J1bnRpbWVfcHV0
X3N5bmMoZHdjLT5kZXYpOw0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gQEAgLTcx
OCwxMiArNzkxLDE5IEBAIHN0YXRpYyBpbnQgZHdjM19yeF9pbmZvX3F1ZXVlX3Nob3coc3RydWN0
IHNlcV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJc3RydWN0IGR3YzMJCSpkd2MgPSBkZXAt
PmR3YzsNCj4gIAl1bnNpZ25lZCBsb25nCQlmbGFnczsNCj4gIAl1MzIJCQl2YWw7DQo+ICsJaW50
CQkJcmV0Ow0KPiArDQo+ICsJcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChkd2MtPmRl
dik7DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICANCj4gIAlzcGluX2xv
Y2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICAJdmFsID0gZHdjM19jb3JlX2ZpZm9f
c3BhY2UoZGVwLCBEV0MzX1JYSU5GT1EpOw0KPiAgCXNlcV9wcmludGYocywgIiV1XG4iLCB2YWwp
Ow0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgDQo+
ICsJcG1fcnVudGltZV9wdXRfc3luYyhkd2MtPmRldik7DQo+ICsNCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCj4gIA0KPiBAQCAtNzMzLDEyICs4MTMsMTkgQEAgc3RhdGljIGludCBkd2MzX2Rlc2NyaXB0
b3JfZmV0Y2hfcXVldWVfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKnVudXNlZCkNCj4g
IAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGRlcC0+ZHdjOw0KPiAgCXVuc2lnbmVkIGxvbmcJCWZsYWdz
Ow0KPiAgCXUzMgkJCXZhbDsNCj4gKwlpbnQJCQlyZXQ7DQo+ICsNCj4gKwlyZXQgPSBwbV9ydW50
aW1lX3Jlc3VtZV9hbmRfZ2V0KGR3Yy0+ZGV2KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0
dXJuIHJldDsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsN
Cj4gIAl2YWwgPSBkd2MzX2NvcmVfZmlmb19zcGFjZShkZXAsIERXQzNfREVTQ0ZFVENIUSk7DQo+
ICAJc2VxX3ByaW50ZihzLCAiJXVcbiIsIHZhbCk7DQo+ICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICANCj4gKwlwbV9ydW50aW1lX3B1dF9zeW5jKGR3Yy0+
ZGV2KTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC03NDgsMTIgKzgzNSwx
OSBAQCBzdGF0aWMgaW50IGR3YzNfZXZlbnRfcXVldWVfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMs
IHZvaWQgKnVudXNlZCkNCj4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGRlcC0+ZHdjOw0KPiAgCXVu
c2lnbmVkIGxvbmcJCWZsYWdzOw0KPiAgCXUzMgkJCXZhbDsNCj4gKwlpbnQJCQlyZXQ7DQo+ICsN
Cj4gKwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGR3Yy0+ZGV2KTsNCj4gKwlpZiAo
cmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZk
d2MtPmxvY2ssIGZsYWdzKTsNCj4gIAl2YWwgPSBkd2MzX2NvcmVfZmlmb19zcGFjZShkZXAsIERX
QzNfRVZFTlRRKTsNCj4gIAlzZXFfcHJpbnRmKHMsICIldVxuIiwgdmFsKTsNCj4gIAlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIA0KPiArCXBtX3J1bnRpbWVf
cHV0X3N5bmMoZHdjLT5kZXYpOw0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gQEAg
LTc5OCw2ICs4OTIsMTEgQEAgc3RhdGljIGludCBkd2MzX3RyYl9yaW5nX3Nob3coc3RydWN0IHNl
cV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJc3RydWN0IGR3YzMJCSpkd2MgPSBkZXAtPmR3
YzsNCj4gIAl1bnNpZ25lZCBsb25nCQlmbGFnczsNCj4gIAlpbnQJCQlpOw0KPiArCWludAkJCXJl
dDsNCj4gKw0KPiArCXJldCA9IHBtX3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQoZHdjLT5kZXYpOw0K
PiArCWlmIChyZXQgPCAwKQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgDQo+ICAJc3Bpbl9sb2NrX2ly
cXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCWlmIChkZXAtPm51bWJlciA8PSAxKSB7DQo+
IEBAIC04MjcsNiArOTI2LDggQEAgc3RhdGljIGludCBkd2MzX3RyYl9yaW5nX3Nob3coc3RydWN0
IHNlcV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICBvdXQ6DQo+ICAJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICANCj4gKwlwbV9ydW50aW1lX3B1dF9zeW5j
KGR3Yy0+ZGV2KTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBAIC04MzksNiAr
OTQwLDExIEBAIHN0YXRpYyBpbnQgZHdjM19lcF9pbmZvX3JlZ2lzdGVyX3Nob3coc3RydWN0IHNl
cV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJdTMyCQkJbG93ZXJfMzJfYml0czsNCj4gIAl1
MzIJCQl1cHBlcl8zMl9iaXRzOw0KPiAgCXUzMgkJCXJlZzsNCj4gKwlpbnQJCQlyZXQ7DQo+ICsN
Cj4gKwlyZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGR3Yy0+ZGV2KTsNCj4gKwlpZiAo
cmV0IDwgMCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAgCXNwaW5fbG9ja19pcnFzYXZlKCZk
d2MtPmxvY2ssIGZsYWdzKTsNCj4gIAlyZWcgPSBEV0MzX0dEQkdMU1BNVVhfRVBTRUxFQ1QoZGVw
LT5udW1iZXIpOw0KPiBAQCAtODUxLDYgKzk1Nyw4IEBAIHN0YXRpYyBpbnQgZHdjM19lcF9pbmZv
X3JlZ2lzdGVyX3Nob3coc3RydWN0IHNlcV9maWxlICpzLCB2b2lkICp1bnVzZWQpDQo+ICAJc2Vx
X3ByaW50ZihzLCAiMHglMDE2bGx4XG4iLCBlcF9pbmZvKTsNCj4gIAlzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gIA0KPiArCXBtX3J1bnRpbWVfcHV0X3N5bmMo
ZHdjLT5kZXYpOw0KPiArDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gQEAgLTkxMCw2ICsx
MDE4LDcgQEAgdm9pZCBkd2MzX2RlYnVnZnNfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3
Yy0+cmVnc2V0LT5yZWdzID0gZHdjM19yZWdzOw0KPiAgCWR3Yy0+cmVnc2V0LT5ucmVncyA9IEFS
UkFZX1NJWkUoZHdjM19yZWdzKTsNCj4gIAlkd2MtPnJlZ3NldC0+YmFzZSA9IGR3Yy0+cmVncyAt
IERXQzNfR0xPQkFMU19SRUdTX1NUQVJUOw0KPiArCWR3Yy0+cmVnc2V0LT5kZXYgPSBkd2MtPmRl
djsNCj4gIA0KPiAgCXJvb3QgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoZGV2X25hbWUoZHdjLT5kZXYp
LCB1c2JfZGVidWdfcm9vdCk7DQo+ICAJZHdjLT5kZWJ1Z19yb290ID0gcm9vdDsNCj4gLS0gDQo+
IDIuMTcuMQ0KPiA=
