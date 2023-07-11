Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1A74EA90
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGKJbu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjGKJbh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 05:31:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AFF10C2
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 02:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8THeVAro1Pvat5Y5OOl6wK1b+H/8QCjFeejtf2kfeXW57kw8Gzr0in62GDaI/Ffy3gZZYa4f3BoUyBY9t523qOKNBCkfERxH02WPQ17bNP8rcuot4zjaSnqB6cj6oZhbqKb67J3nzR0EApIXrVlAoBGCdkInVBya+1qpt7zBPHjUSiZcCaWN3dIWf4JS4D8XPEy3hV/6tAolLzDxYjJARG6P5MPFM04odmqWRUAYnArHa/tUDi8TOsWg3bQ/ovBNt6AePGpCI3knsLM2ZtppZQVmSGXdwHU1Ss8k+7nrk340BrN2GUxoMHxK3uVvH9SswUDamRP9e/B2e9iP2wZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGb3/lsJDoRksZ6h1NSeS1pUzTl7RThgXvtVcOuHsuU=;
 b=EPajcORa9N4jfUbEkUFZhmMMxbYsfebt93U36DhwCEPn3Psze1lepRH150AksB54TwClVwDjMDU30heDwq6velRUgP1nuVbFtA5bz5vS/pu7M2WEQQVVXX3yKRclYoyiWOgG63/o1JNzShENP5J4mZ9C3iitGyiqIJH7ltBM1ZHSyWyASjckR3w6zHetqkJT66/NeFz1uYFyywXbhYqvLnQqjEnc1gzCq8p3Edi8tXUdQTr/Ux4cKZyMMJV1beadCB07PqCvqeRUP5SOlvulSlgApuUqgFPrdvFWcJ8oqFWG9XcrV9tEvqoJK//Eb5h8bt08M2R3VVPv3a2sGuirpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGb3/lsJDoRksZ6h1NSeS1pUzTl7RThgXvtVcOuHsuU=;
 b=tjCJANQy6z8uVCx4DfobudX2G48dSQkyKzNsZMuq7j3L5dCukFzEiuPTDNzWjhoT5/7BE5r26GLtIc7pq9jghbNRqooOW16qFz2U+qHyhCT3r0Q3GwaVUgi7OBcAxIn+NEoZkwJEHqb7EAr1Tza60rWtc+klaxgdmmGNc/znsSE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 09:31:23 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 09:31:23 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>,
        "Prica, Nikola" <Nikola.Prica@amd.com>,
        "Cui, Flora" <Flora.Cui@amd.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Thread-Topic: [PATCH v3] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Thread-Index: AQHZs5h1/PIyT+/rqkKfO2l1eT25a6+0R4mAgAABU8CAAAJ7AIAAAPGw
Date:   Tue, 11 Jul 2023 09:31:22 +0000
Message-ID: <DM5PR12MB2469C1707C855DEFAC306744F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230711013831.2181718-1-guchun.chen@amd.com>
 <2a71b5c0-a79d-16e7-cba4-37018f2ebecf@gmail.com>
 <DM5PR12MB24692FEDD2317DF87B8DCD45F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
 <8f8d56be-eb2f-3a4d-edb6-34640faeaea2@gmail.com>
In-Reply-To: <8f8d56be-eb2f-3a4d-edb6-34640faeaea2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a7fec1a1-aaa6-4d8e-87ee-5a6ee17190e3;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-11T09:26:18Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|BL1PR12MB5731:EE_
x-ms-office365-filtering-correlation-id: 202d9131-98f6-424c-5e8f-08db81f19733
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pBuHTIIkX+Z5eBGk9xZBoOLAoV5ZgFsUf4EjfxYcCRHFNjt6ctyVUBjQaCpRsbnTl5/smjzl3Ezlv8fL4FT6J9JFJmc4/1twpzqbIpHOCPmdVbsGqvaHyZZgLVOeKdnL1jokiSL1qljgzzsFIBzwOlL/KFYZCQwvmp7rxucs09QbFLfBj1U8MQckktcnzWQKgK1LW0yAuhkJicluF/FUJakLCiotG70aGxs3WPDaiIRn1YHkLs2M/79zgAVaa3/BQznL+XryPWtDjAtamJYaYkBT1CuI6kkt5clRYpNEqcE9ZyYkmurkyk2YWRd8T96/cGplt1Fgyr4M1W7u1fN50CWPlx2K9VyVB4TP8a17LuqBEsSGhKu27ZaTkw9dEcyc+6heCp1VgXVmsqcK8hSfrdt3VWEhy8BGho2A+suIshv95hRGEMSb+/hx9MtxKxzDM4YTOi5jVvorElUX+pzQJdvCpIA7UU84lc2VfkUsALnJ6tw/0+yjW6vZixmQlBpZ4/mW01tIKFMZLbXtNgCTIHuTHNVu/Payz4zx6BTiaSKNa3+cMB2uiyyLL/JlDP3T3INqJTGaBBET4XcoXA96UrBB7JkjCrL80nId+pBJXi2KqAgsdZGjP37rZ0uJlCo8Gqm0gbkZ0HPAu2n4RhJnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(8676002)(41300700001)(5660300002)(8936002)(52536014)(26005)(66574015)(64756008)(76116006)(6636002)(4326008)(316002)(53546011)(71200400001)(66556008)(186003)(66446008)(6506007)(66946007)(66476007)(83380400001)(55016003)(38070700005)(110136005)(478600001)(86362001)(921005)(33656002)(122000001)(2906002)(7696005)(9686003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3FBUFhOOHNNNGFkbHM1ZmlmUGJiRUpYbGdyQ09UWFd3L2RrMm4vU0plOGVu?=
 =?utf-8?B?TXBXY1A1eWU4VFp0Z2xueFVoZmcvNXgyOFU5OG9DL3ViU3RoV2psUUFBUzlJ?=
 =?utf-8?B?SVpncHUxa2NWcFhubStyTUk1dFEyMTdjdi84SXlKdzVjR2J2b1dnZUhzUlEy?=
 =?utf-8?B?dTV1MTJ4S2Q5WDR2UFJzdjcxSWpUS0czZHpLbVNQRFU3QjNhRFY1Y0hYMGRV?=
 =?utf-8?B?RFQxM0pQek5pdkk1dWlucFVhMFI4ZittcUxCc3QwV1Q2SnhMZEQrbGY5SFhr?=
 =?utf-8?B?c0lqSTZ5QlBuQXhNeWRMTTZ4aEVMek00eWFXSkZIRWNlcUp4RmtKNFNpNFpY?=
 =?utf-8?B?Nk0vMjNiUjBWY2ZueEY1ZDhxNTdCUGpNenZYSWpIYUFRWEZIOTc4ZHAwNjZh?=
 =?utf-8?B?a2pXT3lkeUxrdmN0NWlmSUMxalpablJoMTUvZ2pFMnI4WkZxV2N1ZEVyZnhF?=
 =?utf-8?B?MmxSMCtFRzkvSG52aXlwYU12eEZVQWFKeGJLbWw4QmJ2RFNsS20ycVJHVkFD?=
 =?utf-8?B?eTVhbzVZWVVJdnhjQk9YbnVNQ0lKNlE3RnBTZDFZbDh4U0VhMU9Xa0RQM2pz?=
 =?utf-8?B?K2ViQkJSUkZUL3ZTU3p5YnArOXN6aGVOaDNkcnh5NTVNbHJ3bWlMajFRUml4?=
 =?utf-8?B?dE9NL1cwUWZtaXJ0ZmRMaGhPYy9zZzNQR043UkVPcndyWFFEY2dpUVNtTHN2?=
 =?utf-8?B?Z3lVc1AvbURRUG9mdDFXM0J2WlVEYWNLQVNzMHlWMGVFWUJrYnNjd04yNVox?=
 =?utf-8?B?RWUvY010bnJ6TUdGVlVzVDJPczR1UmZiTmlXeU5lSVY2ZldjN2ttRWtqZi85?=
 =?utf-8?B?dWN1QWk3eTlIU2dyVGVyVk1oSHNyVG1NdnFmcmwxZFBmVmRiQzVCZ2Vheklz?=
 =?utf-8?B?b0U4Z2ZGQnhXdnZpdFRoWlNKV2FwYWw3dTFHS0NsYVBuMmYreVBaTFlTZ0Yv?=
 =?utf-8?B?L1NJZmI0Q1VDMlVDUjRVNFVRZGt1cUIzNnEyY2dlbXlRTE1lbzIzanNBOW15?=
 =?utf-8?B?THoxZG9nN3VkTGtEcWwxYlI4MUhDWjN2d3NkMEQ0QnBTWU1DWTRzQzNxS3Mx?=
 =?utf-8?B?RGMzTkJTcU1FNUJyMTcrNUtkVDNuZzhOTE5mc3IxbXllUUM4c0Y3Nm9sdlZ3?=
 =?utf-8?B?MkJRVVJLUktibVZGeFg2WjRpbUVCNGx2MDdBZ2VxMUk2dFRITm1ydHBYRFZz?=
 =?utf-8?B?dk5IWTcrZG0yWVlCRnUzeTBiSDl5ZkhHZmFlVC96T1M5T2ZEbmVBcThDTDk1?=
 =?utf-8?B?QUNxRisrUGFOangwL3ZMSUpCZTZwa1Z6T1Fqa2MzVzhzS1RGZWk5NFllYXk5?=
 =?utf-8?B?cmQ2NGNuYTMvZGM0OEt4ZzMwWS9zVXJ6UG5kSjV5WE13VkpaeERoWG1mdER5?=
 =?utf-8?B?MnAvWE8zUlJ2Z2FQZ1o0SXRHUlZvVlppcmIydFFWU2orUmMzV2hyMUlKSUtv?=
 =?utf-8?B?M2FKYWxHZEh0SkhseWdEcVV0ODM5OEtlUGZvQXNCRUxPSUt1QnRkUHVUbkJR?=
 =?utf-8?B?NXBDOU9DL3RLc1dQejgrbjkwbDRhUkd0K1JNNEVGR0J3Ull0MFFsODNObEZo?=
 =?utf-8?B?NGE2NGQrOXBoRGRGSHdFQU96NlpmeXRXa091cm56Y1pldy9obUM4dEtjU3VD?=
 =?utf-8?B?c2dPakRkSThXSEpxblJhL0NSc1R5TklmaXU1N0M3OFNhOVllS0s0ZEJ1dytj?=
 =?utf-8?B?VzFTdnBDZHNYTW1tVmFlR0RWRmJHRjhKTHNtWWJweXNyM0FqR3BtSDBnRHBs?=
 =?utf-8?B?QzVSNkN0aTdmdDN4emZpZXZWQzB4QThLdXhhaFhUZi82S1hGTDNYdm1mK3o0?=
 =?utf-8?B?cmUvZWhuWHVpL2tmeU1jNXRrMHVwVDJpenJHNEMwSER6NWVoWjhGREJSSWtt?=
 =?utf-8?B?cjR4M1QvS0wwTHZiODlEeXhTUEY1WHNYMVVJbGhVYjE3MXVvMVpjdEdUb0pa?=
 =?utf-8?B?V2NtWmRHOTh1aUFxSnFHcHNjeE9ZRVozWTd0VFBLVGxjRWhrZUVLYnRYcVIx?=
 =?utf-8?B?MmsxUlhqYWsrZFBYK0ErenFUVUJzbzNkUENJMEVCcjBjcklKQU1sd2I4MTRm?=
 =?utf-8?B?dlp4aGRKMUxxZUhQQkZvRGFrV0RoejJ5WXRPNWVZQWdaSUNMRU5iQi9BQkhu?=
 =?utf-8?Q?nm+Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202d9131-98f6-424c-5e8f-08db81f19733
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 09:31:22.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwPXW8fpgYJHMOx/vcx+FmK/U0LhjsrWy92jabCRztRY4CUx9G+gWFUdpTIJ9QbVy0YK/+PUVjzIBnnJEXlfUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3Rp
YW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgSnVseSAxMSwgMjAyMyA1OjIzIFBNDQo+IFRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5D
aGVuQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIs
IEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5n
DQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPjsgTWlsaW5rb3ZpYywgRHVzaWNhDQo+IDxEdXNpY2EuTWlsaW5r
b3ZpY0BhbWQuY29tPjsgUHJpY2EsIE5pa29sYSA8Tmlrb2xhLlByaWNhQGFtZC5jb20+OyBDdWks
DQo+IEZsb3JhIDxGbG9yYS5DdWlAYW1kLmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZHJtL2FtZGdwdS92a21zOiByZWxheCB0aW1l
ciBkZWFjdGl2YXRpb24gYnkNCj4gaHJ0aW1lcl90cnlfdG9fY2FuY2VsDQo+DQo+IEFtIDExLjA3
LjIzIHVtIDExOjE1IHNjaHJpZWIgQ2hlbiwgR3VjaHVuOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4g
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXks
IEp1bHkgMTEsIDIwMjMgNTowOSBQTQ0KPiA+PiBUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hl
bkBhbWQuY29tPjsgYW1kLQ0KPiA+PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVy
LCBBbGV4YW5kZXINCj4gPj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3
a2luZw0KPiA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsNCj4gPj4gS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IE1pbGlua292aWMsIER1c2ljYQ0KPiA+PiA8RHVz
aWNhLk1pbGlua292aWNAYW1kLmNvbT47IFByaWNhLCBOaWtvbGEgPE5pa29sYS5QcmljYUBhbWQu
Y29tPjsNCj4gPj4gQ3VpLCBGbG9yYSA8RmxvcmEuQ3VpQGFtZC5jb20+DQo+ID4+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGRybS9hbWRn
cHUvdmttczogcmVsYXggdGltZXIgZGVhY3RpdmF0aW9uIGJ5DQo+ID4+IGhydGltZXJfdHJ5X3Rv
X2NhbmNlbA0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBBbSAxMS4wNy4yMyB1bSAwMzozOCBzY2hy
aWViIEd1Y2h1biBDaGVuOg0KPiA+Pj4gSW4gYmVsb3cgdGhvdXNhbmRzIG9mIHNjcmVlbiByb3Rh
dGlvbiBsb29wIHRlc3RzIHdpdGggdmlydHVhbA0KPiA+Pj4gZGlzcGxheSBlbmFibGVkLCBhIENQ
VSBoYXJkIGxvY2t1cCBpc3N1ZSBtYXkgaGFwcGVuLCBsZWFkaW5nIHN5c3RlbQ0KPiA+Pj4gdG8g
dW5yZXNwb25zaXZlIGFuZCBjcmFzaC4NCj4gPj4+DQo+ID4+PiBkbyB7DQo+ID4+PiAgICAgIHhy
YW5kciAtLW91dHB1dCBWaXJ0dWFsIC0tcm90YXRlIGludmVydGVkDQo+ID4+PiAgICAgIHhyYW5k
ciAtLW91dHB1dCBWaXJ0dWFsIC0tcm90YXRlIHJpZ2h0DQo+ID4+PiAgICAgIHhyYW5kciAtLW91
dHB1dCBWaXJ0dWFsIC0tcm90YXRlIGxlZnQNCj4gPj4+ICAgICAgeHJhbmRyIC0tb3V0cHV0IFZp
cnR1YWwgLS1yb3RhdGUgbm9ybWFsIH0gd2hpbGUgKDEpOw0KPiA+Pj4NCj4gPj4+IE5NSSB3YXRj
aGRvZzogV2F0Y2hkb2cgZGV0ZWN0ZWQgaGFyZCBMT0NLVVAgb24gY3B1IDENCj4gPj4+DQo+ID4+
PiA/IGhydGltZXJfcnVuX3NvZnRpcnErMHgxNDAvMHgxNDANCj4gPj4+ID8gc3RvcmVfdmJsYW5r
KzB4ZTAvMHhlMCBbZHJtXQ0KPiA+Pj4gaHJ0aW1lcl9jYW5jZWwrMHgxNS8weDMwDQo+ID4+PiBh
bWRncHVfdmttc19kaXNhYmxlX3ZibGFuaysweDE1LzB4MzAgW2FtZGdwdV0NCj4gPj4+IGRybV92
YmxhbmtfZGlzYWJsZV9hbmRfc2F2ZSsweDE4NS8weDFmMCBbZHJtXQ0KPiA+Pj4gZHJtX2NydGNf
dmJsYW5rX29mZisweDE1OS8weDRjMCBbZHJtXSA/DQo+ID4+PiByZWNvcmRfcHJpbnRfdGV4dC5j
b2xkKzB4MTEvMHgxMSA/DQo+ID4+PiB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQrMHgyMzIv
MHgyODANCj4gPj4+ID8gZHJtX2NydGNfd2FpdF9vbmVfdmJsYW5rKzB4NDAvMHg0MCBbZHJtXSA/
DQo+ID4+PiBiaXRfd2FpdF9pb190aW1lb3V0KzB4ZTAvMHhlMCA/DQo+ID4+PiB3YWl0X2Zvcl9j
b21wbGV0aW9uX2ludGVycnVwdGlibGUrMHgxZDcvMHgzMjANCj4gPj4+ID8gbXV0ZXhfdW5sb2Nr
KzB4ODEvMHhkMA0KPiA+Pj4gYW1kZ3B1X3ZrbXNfY3J0Y19hdG9taWNfZGlzYWJsZQ0KPiA+Pj4N
Cj4gPj4+IEl0J3MgY2F1c2VkIGJ5IGEgc3R1Y2sgaW4gbG9jayBkZXBlbmRlbmN5IGluIHN1Y2gg
c2NlbmFyaW8gb24NCj4gPj4+IGRpZmZlcmVudCBDUFVzLg0KPiA+Pj4NCj4gPj4+IENQVTEgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUyDQo+ID4+PiBkcm1f
Y3J0Y192Ymxhbmtfb2ZmICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHJ0aW1lcl9pbnRl
cnJ1cHQNCj4gPj4+ICAgICAgIGdyYWIgZXZlbnRfbG9jayAoaXJxIGRpc2FibGVkKSAgICAgICAg
ICAgICAgICAgICBfX2hydGltZXJfcnVuX3F1ZXVlcw0KPiA+Pj4gICAgICAgICAgIGdyYWIgdmJs
X2xvY2svdmJsYW5rX3RpbWVfYmxvY2sNCj4gPj4gYW1kZ3B1X3ZrbXNfdmJsYW5rX3NpbXVsYXRl
DQo+ID4+PiAgICAgICAgICAgICAgIGFtZGdwdV92a21zX2Rpc2FibGVfdmJsYW5rICAgICAgICAg
ICAgICAgICAgICAgICBkcm1faGFuZGxlX3ZibGFuaw0KPiA+Pj4gICAgICAgICAgICAgICAgICAg
aHJ0aW1lcl9jYW5jZWwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdy
YWIgZGV2LT5ldmVudF9sb2NrDQo+ID4+Pg0KPiA+Pj4gU28gQ1BVMSBzdHVja3MgaW4gaHJ0aW1l
cl9jYW5jZWwgYXMgdGltZXIgY2FsbGJhY2sgaXMgcnVubmluZw0KPiA+Pj4gZW5kbGVzcyBvbiBj
dXJyZW50IGNsb2NrIGJhc2UsIGFzIHRoYXQgdGltZXIgcXVldWUgb24gQ1BVMiBoYXMgbm8NCj4g
Pj4+IGNoYW5jZSB0byBmaW5pc2ggaXQgYmVjYXVzZSBvZiBmYWlsaW5nIHRvIGhvbGQgdGhlIGxv
Y2suIFNvIE5NSQ0KPiA+Pj4gd2F0Y2hkb2cgd2lsbCB0aHJvdyB0aGUgZXJyb3JzIGFmdGVyIGl0
cyB0aHJlc2hvbGQsIGFuZCBhbGwgbGF0ZXINCj4gPj4+IENQVXMgYXJlDQo+ID4+IGltcGFjdGVk
L2Jsb2NrZWQuDQo+ID4+PiBTbyB1c2UgaHJ0aW1lcl90cnlfdG9fY2FuY2VsIHRvIGZpeCB0aGlz
LCBhcyBkaXNhYmxlX3ZibGFuayBjYWxsYmFjaw0KPiA+Pj4gZG9lcyBub3QgbmVlZCB0byB3YWl0
IHRoZSBoYW5kbGVyIHRvIGZpbmlzaC4gQW5kIGFsc28gaXQncyBub3QNCj4gPj4+IG5lY2Vzc2Fy
eSB0byBjaGVjayB0aGUgcmV0dXJuIHZhbHVlIG9mIGhydGltZXJfdHJ5X3RvX2NhbmNlbCwNCj4g
Pj4+IGJlY2F1c2UgZXZlbiBpZiBpdCdzDQo+ID4+PiAtMSB3aGljaCBtZWFucyBjdXJyZW50IHRp
bWVyIGNhbGxiYWNrIGlzIHJ1bm5pbmcsIGl0IHdpbGwgYmUNCj4gPj4+IHJlcHJvZ3JhbW1lZCBp
biBocnRpbWVyX3N0YXJ0IHdpdGggY2FsbGluZyBlbmFibGVfdmJsYW5rIHRvIG1ha2UgaXQNCj4g
d29ya3MuDQo+ID4+Pg0KPiA+Pj4gdjI6IG9ubHkgcmUtYXJtIHRpbWVyIHdoZW4gdmJsYW5rIGlz
IGVuYWJsZWQgKENocmlzdGlhbikgYW5kIGFkZCBhDQo+ID4+PiBGaXhlcyB0YWcgYXMgd2VsbA0K
PiA+Pj4NCj4gPj4+IHYzOiBkcm9wIHdhcm4gcHJpbnRpbmcgKENocmlzdGlhbikNCj4gPj4+DQo+
ID4+PiBGaXhlczogODRlYzM3NGJkNTgwKCJkcm0vYW1kZ3B1OiBjcmVhdGUgYW1kZ3B1X3ZrbXMg
KHY0KSIpDQo+ID4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+Pj4gU3VnZ2VzdGVk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4gPj4+IC0t
LQ0KPiA+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYyB8IDEz
ICsrKysrKysrKystLS0NCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92a21zLmMNCj4gPj4+IGluZGV4IDUzZmY5MWZjNmNmNi4uYjg3MGM4Mjdj
YmFhIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZrbXMuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zr
bXMuYw0KPiA+Pj4gQEAgLTQ2LDcgKzQ2LDEwIEBAIHN0YXRpYyBlbnVtIGhydGltZXJfcmVzdGFy
dA0KPiA+PiBhbWRncHVfdmttc192Ymxhbmtfc2ltdWxhdGUoc3RydWN0IGhydGltZXIgKnRpbWVy
KQ0KPiA+Pj4gICAgICBzdHJ1Y3QgYW1kZ3B1X2NydGMgKmFtZGdwdV9jcnRjID0gY29udGFpbmVy
X29mKHRpbWVyLCBzdHJ1Y3QNCj4gPj4gYW1kZ3B1X2NydGMsIHZibGFua190aW1lcik7DQo+ID4+
PiAgICAgIHN0cnVjdCBkcm1fY3J0YyAqY3J0YyA9ICZhbWRncHVfY3J0Yy0+YmFzZTsNCj4gPj4+
ICAgICAgc3RydWN0IGFtZGdwdV92a21zX291dHB1dCAqb3V0cHV0ID0NCj4gPj4+IGRybV9jcnRj
X3RvX2FtZGdwdV92a21zX291dHB1dChjcnRjKTsNCj4gPj4+ICsgICBzdHJ1Y3QgZHJtX3ZibGFu
a19jcnRjICp2Ymxhbms7DQo+ID4+PiArICAgc3RydWN0IGRybV9kZXZpY2UgKmRldjsNCj4gPj4+
ICAgICAgdTY0IHJldF9vdmVycnVuOw0KPiA+Pj4gKyAgIHVuc2lnbmVkIGludCBwaXBlOw0KPiA+
Pj4gICAgICBib29sIHJldDsNCj4gPj4+DQo+ID4+PiAgICAgIHJldF9vdmVycnVuID0gaHJ0aW1l
cl9mb3J3YXJkX25vdygmYW1kZ3B1X2NydGMtPnZibGFua190aW1lciwNCj4gPj4+IEBAIC01NCw5
ICs1NywxMyBAQCBzdGF0aWMgZW51bSBocnRpbWVyX3Jlc3RhcnQNCj4gPj4gYW1kZ3B1X3ZrbXNf
dmJsYW5rX3NpbXVsYXRlKHN0cnVjdCBocnRpbWVyICp0aW1lcikNCj4gPj4+ICAgICAgaWYgKHJl
dF9vdmVycnVuICE9IDEpDQo+ID4+PiAgICAgICAgICAgICAgRFJNX1dBUk4oIiVzOiB2Ymxhbmsg
dGltZXIgb3ZlcnJ1blxuIiwgX19mdW5jX18pOw0KPiA+Pj4NCj4gPj4+ICsgICBkZXYgPSBjcnRj
LT5kZXY7DQo+ID4+PiArICAgcGlwZSA9IGRybV9jcnRjX2luZGV4KGNydGMpOw0KPiA+Pj4gKyAg
IHZibGFuayA9ICZkZXYtPnZibGFua1twaXBlXTsNCj4gPj4+ICAgICAgcmV0ID0gZHJtX2NydGNf
aGFuZGxlX3ZibGFuayhjcnRjKTsNCj4gPj4+IC0gICBpZiAoIXJldCkNCj4gPj4+IC0gICAgICAg
ICAgIERSTV9FUlJPUigiYW1kZ3B1X3ZrbXMgZmFpbHVyZSBvbiBoYW5kbGluZyB2YmxhbmsiKTsN
Cj4gPj4+ICsgICAvKiBEb24ndCBxdWV1ZSB0aW1lciBhZ2FpbiB3aGVuIHZibGFuayBpcyBkaXNh
YmxlZC4gKi8NCj4gPj4+ICsgICBpZiAoIXJldCAmJiAhUkVBRF9PTkNFKHZibGFuay0+ZW5hYmxl
ZCkpDQo+ID4+PiArICAgICAgICAgICByZXR1cm4gSFJUSU1FUl9OT1JFU1RBUlQ7DQo+ID4+IFdo
ZW4gZHJtX2NydGNfaGFuZGxlX3ZibGFuaygpIHJldHVybnMgZmFsc2Ugd2hlbiB2YmxhbmsgaXMg
ZGlzYWJsZWQgSQ0KPiA+PiB0aGluayB3ZSBjYW4gc2ltcGxpZnkgdGhpcyB0byBqdXN0IHJlbW92
aW5nIHRoZSBlcnJvci4NCj4gPj4NCj4gPj4gUmVnYXJkcywNCj4gPj4gQ2hyaXN0aWFuLg0KPiA+
IFNvcnJ5LCBJIGRpZG4ndCBnZXQgeW91LiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJyZW1vdmluZyB0
aGUgZXJyb3IiPw0KPg0KPiBXZSBzaG91bGQganVzdCByZW1vdmUgdGhlICJEUk1fRVJST1IoImFt
ZGdwdV92a21zIGZhaWx1cmUgb24gaGFuZGxpbmcNCj4gdmJsYW5rIik7IiBtZXNzYWdlLg0KPg0K
PiBXaGVuIHRoZSBkcm1fY3J0Y19oYW5kbGVfdmJsYW5rKCkgcmV0dXJucyBmYWxzZSBpdCBkb2Vz
bid0IHJlYWxseSBpbmRpY2F0ZSBhDQo+IGZhaWx1cmUsIGl0IGp1c3QgaW5kaWNhdGVzIHRoYXQg
dGhlIHZibGFuayBpcyBkaXNhYmxlZCBhbmQgc2hvdWxkbid0IGJlIHJlLWFybWVkLg0KPg0KPiBS
ZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQoNCmRybV9jcnRjX2hhbmRsZV92Ymxhbmsgd2hpY2ggaXMg
YSB3cmFwcGVyIG9mIGRybV9oYW5kbGVfdmJsYW5rLCBoYXMgdHdvIGVhcmx5IHRlc3QgY2FsbHMg
dG8gY2hlY2sgaWYgdmJsYW5rIGlzIGluaXRpYWxpemVkLiBUaG91Z2ggdGhpcyB3aWxsIG5ldmVy
IGhhcHBlbiBpbiBvdXIgY2FzZSwgSSBzdGlsbCBjaGVjayB0aGUgdmFsdWUgb2YgdmJsYW5rLT5l
bmFibGVkIHdoZW4gZHJtX2NydGNfaGFuZGxlX3ZibGFuayByZXR1cm5zIGZhbHNlLCBhbmQgd2hl
biBpdCdzIGluZGVlZCBkaXNhYmxlZCwgcmV0dXJuIEhSVElNRVJfTk9SRVNUQVJUIHRvIG5vdCBy
ZS1hcm0gdGltZXIsIG90aGVyd2lzZSwgcmV0dXJuaW5nIEhSVElNRVJfUkVTVEFSVCB3aGVuIGl0
J3MgZ29pbmcgYXMgZXhwZWN0ZWQuDQoNCkFueXRoaW5nIHdyb25nIG9yIGFtIEkgbWlzdW5kZXJz
dGFuZGluZyBpdD8NCg0KUmVnYXJkcywNCkd1Y2h1bg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBH
dWNodW4NCj4gPj4+ICAgICAgcmV0dXJuIEhSVElNRVJfUkVTVEFSVDsNCj4gPj4+ICAgIH0NCj4g
Pj4+IEBAIC04MSw3ICs4OCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92a21zX2Rpc2FibGVfdmJs
YW5rKHN0cnVjdA0KPiA+PiBkcm1fY3J0YyAqY3J0YykNCj4gPj4+ICAgIHsNCj4gPj4+ICAgICAg
c3RydWN0IGFtZGdwdV9jcnRjICphbWRncHVfY3J0YyA9IHRvX2FtZGdwdV9jcnRjKGNydGMpOw0K
PiA+Pj4NCj4gPj4+IC0gICBocnRpbWVyX2NhbmNlbCgmYW1kZ3B1X2NydGMtPnZibGFua190aW1l
cik7DQo+ID4+PiArICAgaHJ0aW1lcl90cnlfdG9fY2FuY2VsKCZhbWRncHVfY3J0Yy0+dmJsYW5r
X3RpbWVyKTsNCj4gPj4+ICAgIH0NCj4gPj4+DQo+ID4+PiAgICBzdGF0aWMgYm9vbCBhbWRncHVf
dmttc19nZXRfdmJsYW5rX3RpbWVzdGFtcChzdHJ1Y3QgZHJtX2NydGMNCj4gPj4+ICpjcnRjLA0K
DQo=
