Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B850674E370
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 03:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGKB1z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 21:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGKB1s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 21:27:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009EFA1
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 18:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqzwKgxwj/cOyPRGcJyg6sk+Y9UHVwOwgWb9nQP4bTD2Mk0MwH8gMRHwip3iLSRp5e6xYessAn7QmQ/KFfhxMEwZjvs5LTFKVVejLIRpm0mfrutJ0tq13csqu4AsjtTlsz6K59O72bRsz2C5DzokK6W0jWaA2St1orqV1qT1tWl+EqHhBT32yaaOKiEV16rkiWDnLkpfN5Rl/RSEQLVg0kR4oaTues8CDmca6zipihu7hJvge5FXpJd7qyviltqg/E9nMvBTmnw96GGsU97i2eyWMaSl1VxJYAelWnZ6kWLKPRnY4gTfTs1BiLpdzuVUW99lHR5OQxHAC543WLbl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMtMtWSTveMdVVwKvEPsSUn3gTqVAEm9ELfpdBb3tnw=;
 b=GKk/Lhy2xRkf9h6eYzpHXhHhG8UWsuMYgrRC48O8nT+zHgFZ9/LXDS5d85uqimJQ7YJ+8scOb+6AsNRUbxnZ2CTU4rYcjJ4cTakPuNYew6jQ1K5C+Psm1IhNO2oUKloj+bMhRfQlOrDfHH5BDCMZFkbOtq6sOomhx4SOxtBSncvLGasXyNq52z/KepZwCRRmNMsj1Msoow5i0hY6MTuaJRXMSCejtn7obeGrklXGwSXDMpFpUe7kQL+iVYaTxRLfzLeC9WYj/SG1r80M48+G3lE+RZOjhBxmCvtOHviCZ9ttSQGe4TUyokC157iAG5Hk7Rprfa30jbi7Us/yoJND+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMtMtWSTveMdVVwKvEPsSUn3gTqVAEm9ELfpdBb3tnw=;
 b=MdJ9ah0oTRpXVmQ8SZAliOn77XAOU202Fx/dWEHJA1i17QEJ4RVLnSV4BAshOzP4Cvf/+H7thpLLoa6I2yq4nXqf1hegP20p6tZ2SlRXaEDZqrQzj2UeTPH5cvZxuQT/mXago9gSDh7vXISXCzsRXojNi5DnspWp/+8g+eRfm3Y=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 01:27:37 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 01:27:37 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>,
        "Prica, Nikola" <Nikola.Prica@amd.com>,
        "Cui, Flora" <Flora.Cui@amd.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Thread-Topic: [PATCH v2] drm/amdgpu/vkms: relax timer deactivation by
 hrtimer_try_to_cancel
Thread-Index: AQHZsvklF4qbyuOCR0al8NZLiYrr3q+yySmAgAD9/ZA=
Date:   Tue, 11 Jul 2023 01:27:37 +0000
Message-ID: <DM5PR12MB2469B7E118B3C8A55C0417B5F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230710063808.1684914-1-guchun.chen@amd.com>
 <0f034282-240d-684b-6677-a351e98d557e@amd.com>
In-Reply-To: <0f034282-240d-684b-6677-a351e98d557e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bdd08b4b-b219-4915-ae42-7d896a421cb4;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-11T01:27:21Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN6PR12MB8592:EE_
x-ms-office365-filtering-correlation-id: f9fb9d1a-25b7-442c-e176-08db81ae02a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7w8QoeOPx9x8o+W9jMBiDSjP4Ow91FuFcqNh+oU7ybaVS0xB9bTnWJ5j0rJQ0r0+h6jzonQeDNHyot2PomA5u+hgINoHNrNyEuCm+IV3uhz2ekfpcTMSZT7p7Dli/BreFGsXPRKMxeOHNVCsxLYWuaUsiPAogQacCU52a6QMnvaQlwGM7Ni+HiZJ4rG9WDLMav/dy42Xr1ZM7bP7axcrSSP1KN0qMWiPiUORJsIRqZH0Tbcte/V8IOfK8hpDIS9CUvClJcgE70Ie2g9ZBIktP5r0RLdwWf43HN4mZUdV1ScDXm3Dcpd4pZ/HpSLEKESGy9L+9zILt3ZHgslZalOsQvjYHbb/esFCCVXXiOAsf/iknkCyCXUKhvWXeqwHbBg9TKKfTuBRU0ydSQyPamk+AY/baO2wbWMGXibnJcDGte+BVpLWY0VnaUA5M5dKUdLWeZN+m57+41WzD+lF4FCZpLf/jKlcGoRb6xh2GrYhf4pqFl2OCuhrOBtFryS+nijSJCgOy2esJYOFAmYjqP8w+Gec5GlddXQHb37PO38TjYBCWifNaoFp4tuZ0WuOOC8B2YGtAp+4iaAxvINIU2mmrFb+q2TEMg7Bc82w+cj5AVvPFJdHEFjyMzCFNsTnI/ZERX1Wb7KMctFrOFmVhDLoug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(186003)(26005)(9686003)(53546011)(6506007)(478600001)(66574015)(83380400001)(64756008)(66446008)(41300700001)(4326008)(6636002)(66556008)(316002)(2906002)(52536014)(5660300002)(8676002)(66476007)(66946007)(8936002)(7696005)(76116006)(110136005)(55016003)(71200400001)(33656002)(122000001)(921005)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YllxejZrMmdSWUJRREVadnBtOWZUVENkWGRIc2Z3WkxTZmVFZndlVElTMndI?=
 =?utf-8?B?S0s2eGdRV1p1UytwdW85blVRTWd0Ti9WVzB6M28weW03MXNEQzQ3NExCaTJF?=
 =?utf-8?B?NmoyUFNEbng0YjZSM3FnMDVxeFFOY243Y2VMRE8yait5RDhFMWU5T0JDNkVu?=
 =?utf-8?B?RElkWXdkTDVvY0pSWitMdXAwQklWZEZKU29GalVsamR3K3p5Q2ppdEZidHpF?=
 =?utf-8?B?Q2puR0I0UGhZNzJJUS9pbDVxWE1oOStJRnNWR2FXWjZqN0loQ0NHODM1clNz?=
 =?utf-8?B?Y3dOUit4ejBqd09TQ2ZGd0w5UHUvaEhOOW82dmxBaDZpNXJleGdFVHFqZVox?=
 =?utf-8?B?cnYxaTEvNmxSZ04wV0tvTkxYNkRRbmpadzFOTHhkeDByV2piRWc0anZBWUl1?=
 =?utf-8?B?UkNhb0FtcXFpQzltQlJ3SUZTTkN0Sk5PNEFoc2VWaGZXYUxQY1RKSFZpcjFP?=
 =?utf-8?B?WmVZUU5tVVlQUGY3SjIwMHgxYXdxQVg2M2lGSDFTNTAwR2VtakJXWDJUT2c4?=
 =?utf-8?B?Z3ZrbU10SFQ5QUxPMC84UFZ1TXA5S1l2aFFHTE1MMmVadEpOTmhFS3F1cFlB?=
 =?utf-8?B?b00vRzJPdVcybkN1a3I2MU1FNk9NUWhuR1E1eSt4SXlrK1k1ZW8xRXplbENl?=
 =?utf-8?B?ZEVnNkU5OWkrOEJpZUpoUnBaTW9vcDdxSjZPY0ZYeFh0azNJMGYyTzFoNHhC?=
 =?utf-8?B?b25ieFI5WWs0ZS9YbEtZejZwdWhNTFNuSXAxYjdDNVJDTzQyT1VzMVJwQUs1?=
 =?utf-8?B?Mk9VZTlWa2JMMEI0ME03eWVuUG5XcVZuMHdrZHVvMWJkYkl5amR6QzIwVy9Y?=
 =?utf-8?B?cGRod3ZzNHRTSUs2YkJub1U2YXBwOVp6eXhxemNkNzB6dDNCc0c5TnFUOU5E?=
 =?utf-8?B?RXdlaURLd0VYM3E1S3N0YnJOcFN6T09kdlU4Q1o2UWgrUkx2bzRld0NYb3Ir?=
 =?utf-8?B?YlByVENKYzg5L3ZtZkMxQkl5UG9tMmtyTEJ0K1Z2RlVFczNhV1BCa2J6Qlc2?=
 =?utf-8?B?S1dVNnR4eldSZDl3c0IxYUxjSmpzTnYrMm44WTdyTDZGU0d2UHVsK3JrcnpO?=
 =?utf-8?B?OWhTbjNXVlBoMEIvTk95OHE4L2pyTVNqSjdHZ2xhMFloTEp2eWp2ODA5VTBT?=
 =?utf-8?B?MGFsN3dDM0h1UnRkUUZrdDNxb3UvSDRrNEdpdUhzaFViZ1NYY01Td1ZPOTN6?=
 =?utf-8?B?WG91bDBZL1RRdy9kQ1ExUUh4WUU5Y3pjcnVOQmNPWGt1TDJLY1FTYVBIMXZr?=
 =?utf-8?B?cDZDS0EvQzNqTS9VVkZhMldaa0twK0JBaVdqOWszSzd2REZQeDIycmdGZHpM?=
 =?utf-8?B?R1FMazdnRVRpYkNyL1V5Unh4ZUJsUW9wMGJ6S0lrb2xLWVZFVnFPbTFFU1Ns?=
 =?utf-8?B?U05WUkpsWEhzYVpHcGFJNHdiM1JnRFM2OVQ1QzV3RXMwWDRib0lpWitJQm43?=
 =?utf-8?B?Y3V0VXBGNFNBcmhCR2IrRUFSY3hvZXBVVU1IWkZ4a3hnei8vN3B5N0o3TXNn?=
 =?utf-8?B?V3ZPRWxIVmYzcTdhRzA4OVlqNituZHA5a1d2WUlub3Y5NDFwQVhqRzlEWVB0?=
 =?utf-8?B?Wkg3STE1YUpueDIyMWFTMDNoTzd6aFFkQVFDZE1BTXFhNGxDa0kweVRhWFRG?=
 =?utf-8?B?dU5hZTJSNFlCazZWdmlGVklHTHM3TzVkUXhYbWdkRVVZTWtGaXJKa3BUNE51?=
 =?utf-8?B?bmhXK3c4aFBMdThhN0VXSTQ0Zkh0VW1EdnZnSXlWWDVYWmZybDd1ZXZJVVVl?=
 =?utf-8?B?SmVDSVFUeFNxb1pHaUo4S0pnc3cvSkxaV1puc0hzRnM0bkFGWWl1ZXcwRXZx?=
 =?utf-8?B?eW00TENsbXU0L3hzeGQ5TDZ3NC9hYkt6ZTBmWGtqSys5WVhYZFJIeVRqVVlP?=
 =?utf-8?B?cEdKZUVyTmJLODZVeS9YdmRWWDZPYXppZEVjREwzYXpOamNISUZqT2hLVUNX?=
 =?utf-8?B?SnhibFA2YlA5bFdiMFR2YVczdTdXV2NVa3FwU1I0WDFJbkFiS2dMZEZKUFBO?=
 =?utf-8?B?OUhYdVlSWmNZZnpsWGZuVFBETERveXM3MWt5NFN5ZUJmcFU2S3R2ZyswTlpj?=
 =?utf-8?B?bGR6YUVhUmZnU0FqcGExYnI2N1dRVVpFa1Y5Y05qRHlLc041Z205TzVrR29i?=
 =?utf-8?Q?8tIE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fb9d1a-25b7-442c-e176-08db81ae02a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 01:27:37.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QADpzyUphRV3aruHKEwEW+Zz5sVrj4qgEEHVp55+dnv/otMvLmxV/hMG6mWqed20+7iHLGoqF7oTywS9+hn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1
bHkgMTAsIDIwMjMgNjoxNiBQTQ0KPiBUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQu
Y29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZw0KPiA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgTWlsaW5rb3ZpYywgRHVzaWNhDQo+IDxEdXNpY2EuTWlsaW5r
b3ZpY0BhbWQuY29tPjsgUHJpY2EsIE5pa29sYSA8Tmlrb2xhLlByaWNhQGFtZC5jb20+OyBDdWks
DQo+IEZsb3JhIDxGbG9yYS5DdWlAYW1kLmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdS92a21zOiByZWxheCB0aW1l
ciBkZWFjdGl2YXRpb24gYnkNCj4gaHJ0aW1lcl90cnlfdG9fY2FuY2VsDQo+DQo+DQo+DQo+IEFt
IDEwLjA3LjIzIHVtIDA4OjM4IHNjaHJpZWIgR3VjaHVuIENoZW46DQo+ID4gSW4gYmVsb3cgdGhv
dXNhbmRzIG9mIHNjcmVlbiByb3RhdGlvbiBsb29wIHRlc3RzIHdpdGggdmlydHVhbCBkaXNwbGF5
DQo+ID4gZW5hYmxlZCwgYSBDUFUgaGFyZCBsb2NrdXAgaXNzdWUgbWF5IGhhcHBlbiwgbGVhZGlu
ZyBzeXN0ZW0gdG8NCj4gPiB1bnJlc3BvbnNpdmUgYW5kIGNyYXNoLg0KPiA+DQo+ID4gZG8gew0K
PiA+ICAgICB4cmFuZHIgLS1vdXRwdXQgVmlydHVhbCAtLXJvdGF0ZSBpbnZlcnRlZA0KPiA+ICAg
ICB4cmFuZHIgLS1vdXRwdXQgVmlydHVhbCAtLXJvdGF0ZSByaWdodA0KPiA+ICAgICB4cmFuZHIg
LS1vdXRwdXQgVmlydHVhbCAtLXJvdGF0ZSBsZWZ0DQo+ID4gICAgIHhyYW5kciAtLW91dHB1dCBW
aXJ0dWFsIC0tcm90YXRlIG5vcm1hbCB9IHdoaWxlICgxKTsNCj4gPg0KPiA+IE5NSSB3YXRjaGRv
ZzogV2F0Y2hkb2cgZGV0ZWN0ZWQgaGFyZCBMT0NLVVAgb24gY3B1IDENCj4gPg0KPiA+ID8gaHJ0
aW1lcl9ydW5fc29mdGlycSsweDE0MC8weDE0MA0KPiA+ID8gc3RvcmVfdmJsYW5rKzB4ZTAvMHhl
MCBbZHJtXQ0KPiA+IGhydGltZXJfY2FuY2VsKzB4MTUvMHgzMA0KPiA+IGFtZGdwdV92a21zX2Rp
c2FibGVfdmJsYW5rKzB4MTUvMHgzMCBbYW1kZ3B1XQ0KPiA+IGRybV92YmxhbmtfZGlzYWJsZV9h
bmRfc2F2ZSsweDE4NS8weDFmMCBbZHJtXQ0KPiA+IGRybV9jcnRjX3ZibGFua19vZmYrMHgxNTkv
MHg0YzAgW2RybV0NCj4gPiA/IHJlY29yZF9wcmludF90ZXh0LmNvbGQrMHgxMS8weDExDQo+ID4g
PyB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQrMHgyMzIvMHgyODANCj4gPiA/IGRybV9jcnRj
X3dhaXRfb25lX3ZibGFuaysweDQwLzB4NDAgW2RybV0gPw0KPiA+IGJpdF93YWl0X2lvX3RpbWVv
dXQrMHhlMC8weGUwID8NCj4gPiB3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGUrMHgx
ZDcvMHgzMjANCj4gPiA/IG11dGV4X3VubG9jaysweDgxLzB4ZDANCj4gPiBhbWRncHVfdmttc19j
cnRjX2F0b21pY19kaXNhYmxlDQo+ID4NCj4gPiBJdCdzIGNhdXNlZCBieSBhIHN0dWNrIGluIGxv
Y2sgZGVwZW5kZW5jeSBpbiBzdWNoIHNjZW5hcmlvIG9uDQo+ID4gZGlmZmVyZW50IENQVXMuDQo+
ID4NCj4gPiBDUFUxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Q1BVMg0KPiA+IGRybV9jcnRjX3ZibGFua19vZmYgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBocnRpbWVyX2ludGVycnVwdA0KPiA+ICAgICAgZ3JhYiBldmVudF9sb2NrIChpcnEgZGlzYWJs
ZWQpICAgICAgICAgICAgICAgICAgIF9faHJ0aW1lcl9ydW5fcXVldWVzDQo+ID4gICAgICAgICAg
Z3JhYiB2YmxfbG9jay92YmxhbmtfdGltZV9ibG9jaw0KPiBhbWRncHVfdmttc192Ymxhbmtfc2lt
dWxhdGUNCj4gPiAgICAgICAgICAgICAgYW1kZ3B1X3ZrbXNfZGlzYWJsZV92YmxhbmsgICAgICAg
ICAgICAgICAgICAgICAgIGRybV9oYW5kbGVfdmJsYW5rDQo+ID4gICAgICAgICAgICAgICAgICBo
cnRpbWVyX2NhbmNlbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdyYWIg
ZGV2LT5ldmVudF9sb2NrDQo+ID4NCj4gPiBTbyBDUFUxIHN0dWNrcyBpbiBocnRpbWVyX2NhbmNl
bCBhcyB0aW1lciBjYWxsYmFjayBpcyBydW5uaW5nIGVuZGxlc3MNCj4gPiBvbiBjdXJyZW50IGNs
b2NrIGJhc2UsIGFzIHRoYXQgdGltZXIgcXVldWUgb24gQ1BVMiBoYXMgbm8gY2hhbmNlIHRvDQo+
ID4gZmluaXNoIGl0IGJlY2F1c2Ugb2YgZmFpbGluZyB0byBob2xkIHRoZSBsb2NrLiBTbyBOTUkg
d2F0Y2hkb2cgd2lsbA0KPiA+IHRocm93IHRoZSBlcnJvcnMgYWZ0ZXIgaXRzIHRocmVzaG9sZCwg
YW5kIGFsbCBsYXRlciBDUFVzIGFyZQ0KPiBpbXBhY3RlZC9ibG9ja2VkLg0KPiA+DQo+ID4gU28g
dXNlIGhydGltZXJfdHJ5X3RvX2NhbmNlbCB0byBmaXggdGhpcywgYXMgZGlzYWJsZV92Ymxhbmsg
Y2FsbGJhY2sNCj4gPiBkb2VzIG5vdCBuZWVkIHRvIHdhaXQgdGhlIGhhbmRsZXIgdG8gZmluaXNo
LiBBbmQgYWxzbyBpdCdzIG5vdA0KPiA+IG5lY2Vzc2FyeSB0byBjaGVjayB0aGUgcmV0dXJuIHZh
bHVlIG9mIGhydGltZXJfdHJ5X3RvX2NhbmNlbCwgYmVjYXVzZQ0KPiA+IGV2ZW4gaWYgaXQncw0K
PiA+IC0xIHdoaWNoIG1lYW5zIGN1cnJlbnQgdGltZXIgY2FsbGJhY2sgaXMgcnVubmluZywgaXQg
d2lsbCBiZQ0KPiA+IHJlcHJvZ3JhbW1lZCBpbiBocnRpbWVyX3N0YXJ0IHdpdGggY2FsbGluZyBl
bmFibGVfdmJsYW5rIHRvIG1ha2UgaXQgd29ya3MuDQo+ID4NCj4gPiB2Mjogb25seSByZS1hcm0g
dGltZXIgd2hlbiB2YmxhbmsgaXMgZW5hYmxlZCAoQ2hyaXN0aWFuKSBhbmQgYWRkIGENCj4gPiBG
aXhlcyB0YWcgYXMgd2VsbA0KPiA+DQo+ID4gRml4ZXM6IDg0ZWMzNzRiZDU4MCgiZHJtL2FtZGdw
dTogY3JlYXRlIGFtZGdwdV92a21zICh2NCkiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+ID4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmttcy5jIHwgMTUgKysrKysrKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4gaW5kZXggNTNmZjkxZmM2Y2Y2Li40NGQ3MDQz
MDZmNDQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZrbXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92a21z
LmMNCj4gPiBAQCAtNDYsNyArNDYsMTAgQEAgc3RhdGljIGVudW0gaHJ0aW1lcl9yZXN0YXJ0DQo+
IGFtZGdwdV92a21zX3ZibGFua19zaW11bGF0ZShzdHJ1Y3QgaHJ0aW1lciAqdGltZXIpDQo+ID4g
ICAgIHN0cnVjdCBhbWRncHVfY3J0YyAqYW1kZ3B1X2NydGMgPSBjb250YWluZXJfb2YodGltZXIs
IHN0cnVjdA0KPiBhbWRncHVfY3J0YywgdmJsYW5rX3RpbWVyKTsNCj4gPiAgICAgc3RydWN0IGRy
bV9jcnRjICpjcnRjID0gJmFtZGdwdV9jcnRjLT5iYXNlOw0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1
X3ZrbXNfb3V0cHV0ICpvdXRwdXQgPQ0KPiA+IGRybV9jcnRjX3RvX2FtZGdwdV92a21zX291dHB1
dChjcnRjKTsNCj4gPiArICAgc3RydWN0IGRybV92YmxhbmtfY3J0YyAqdmJsYW5rOw0KPiA+ICsg
ICBzdHJ1Y3QgZHJtX2RldmljZSAqZGV2Ow0KPiA+ICAgICB1NjQgcmV0X292ZXJydW47DQo+ID4g
KyAgIHVuc2lnbmVkIGludCBwaXBlOw0KPiA+ICAgICBib29sIHJldDsNCj4gPg0KPiA+ICAgICBy
ZXRfb3ZlcnJ1biA9IGhydGltZXJfZm9yd2FyZF9ub3coJmFtZGdwdV9jcnRjLT52YmxhbmtfdGlt
ZXIsDQo+ID4gQEAgLTU0LDkgKzU3LDE1IEBAIHN0YXRpYyBlbnVtIGhydGltZXJfcmVzdGFydA0K
PiBhbWRncHVfdmttc192Ymxhbmtfc2ltdWxhdGUoc3RydWN0IGhydGltZXIgKnRpbWVyKQ0KPiA+
ICAgICBpZiAocmV0X292ZXJydW4gIT0gMSkNCj4gPiAgICAgICAgICAgICBEUk1fV0FSTigiJXM6
IHZibGFuayB0aW1lciBvdmVycnVuXG4iLCBfX2Z1bmNfXyk7DQo+ID4NCj4gPiArICAgZGV2ID0g
Y3J0Yy0+ZGV2Ow0KPiA+ICsgICBwaXBlID0gZHJtX2NydGNfaW5kZXgoY3J0Yyk7DQo+ID4gKyAg
IHZibGFuayA9ICZkZXYtPnZibGFua1twaXBlXTsNCj4gPiAgICAgcmV0ID0gZHJtX2NydGNfaGFu
ZGxlX3ZibGFuayhjcnRjKTsNCj4gPiAtICAgaWYgKCFyZXQpDQo+ID4gLSAgICAgICAgICAgRFJN
X0VSUk9SKCJhbWRncHVfdmttcyBmYWlsdXJlIG9uIGhhbmRsaW5nIHZibGFuayIpOw0KPiA+ICsg
ICBpZiAoIXJldCAmJiAhUkVBRF9PTkNFKHZibGFuay0+ZW5hYmxlZCkpIHsNCj4gPiArICAgICAg
ICAgICAvKiBEb24ndCBxdWV1ZSB0aW1lciBhZ2FpbiB3aGVuIHZibGFuayBpcyBkaXNhYmxlZC4g
Ki8NCj4gPiArICAgICAgICAgICBEUk1fV0FSTigiYW1kZ3B1X3ZrbXMgZmFpbHVyZSBvbiBoYW5k
bGluZyB2YmxhbmtcbiIpOw0KPg0KPiBZb3Ugc2hvdWxkIHByb2JhYmx5IG9ubHkgcHJpbnQgdGhl
IHdhcm5pbmcgd2hlbiByZWFsbHkgYW4gZXJyb3IgaGFwcGVuZWQuDQo+DQo+IERpc2FibGluZyB0
aGUgdmJsYW5rIGFuZCBub3QgZmlyaW5nIHRoZSB0aW1lciBhZ2FpbiBpcyBhIHBlcmZlY3RseSBu
b3JtYWwNCj4gb3BlcmF0aW9uLg0KPg0KPiBBcGFydCBmcm9tIHRoYXQgbG9va3MgZ29vZCB0byBt
ZSwNCj4gQ2hyaXN0aWFuLg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudCwgQ2hyaXN0aWFuLiBU
aGVuIEkgdGhpbmsgSSBjYW4gZHJvcCB0aGUgcHJpbnRpbmcsIGFzIGRybV9jcnRjX2hhbmRsZV92
YmxhbmsgaGF2ZSB0d28gcmV0dXJuIGNhc2VzLCBvbmUgaXMgZmFsc2Ugd2hlbiB2YmxhbmsgaXMg
ZGlzYWJsZWQsIGFuZCB0aGUgb3RoZXIgaXMgYWx3YXlzIHRydWUuDQpJIHdpbGwgZml4IHRoaXMg
aW4gcGF0Y2ggdjMuDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KPiA+ICsgICAgICAgICAgIHJldHVy
biBIUlRJTUVSX05PUkVTVEFSVDsNCj4gPiArICAgfQ0KPiA+DQo+ID4gICAgIHJldHVybiBIUlRJ
TUVSX1JFU1RBUlQ7DQo+ID4gICB9DQo+ID4gQEAgLTgxLDcgKzkwLDcgQEAgc3RhdGljIHZvaWQg
YW1kZ3B1X3ZrbXNfZGlzYWJsZV92Ymxhbmsoc3RydWN0DQo+IGRybV9jcnRjICpjcnRjKQ0KPiA+
ICAgew0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X2NydGMgKmFtZGdwdV9jcnRjID0gdG9fYW1kZ3B1
X2NydGMoY3J0Yyk7DQo+ID4NCj4gPiAtICAgaHJ0aW1lcl9jYW5jZWwoJmFtZGdwdV9jcnRjLT52
YmxhbmtfdGltZXIpOw0KPiA+ICsgICBocnRpbWVyX3RyeV90b19jYW5jZWwoJmFtZGdwdV9jcnRj
LT52YmxhbmtfdGltZXIpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgYm9vbCBhbWRncHVf
dmttc19nZXRfdmJsYW5rX3RpbWVzdGFtcChzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQoNCg==
