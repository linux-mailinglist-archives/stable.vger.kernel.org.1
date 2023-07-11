Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B1674EA11
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjGKJQz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGKJQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 05:16:06 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC3B19BA
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 02:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMxYcBbcnPsmfC9BzMincNn/uccJDpVrBhsl9LcFSACcf3I9x8yYD6ZLYq1EU9jjYgfXX7Hw71H8DSU0ttQ5PJ4aEdAjs87YmCMCrOMO4cZ7/xIbwjtzGBf3AKCTpLCxLs6bfNi4RrlK0TnIHR3tQo7MbaSoPjg3EoSCZTzRHpE8NXenw4A1IEv6Xyqq2ihdYnmg7Or3PbwNBSU9xmKymyWPakqBJHlriUxzE6XbOjioKq+CLoAPIaJTJRWT/u/WGhni094oJh1MkBrjbXwDpsKRPsfu/Dvl7MCjqSJMg2qFpJGDRMwY/mQ+/hvaZvRL+Qrjq+eXp12IfURtkOZD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Vpozi5tBGYV6jCwqnwGiTcz9TA1MJQDNiFZrPwvTlQ=;
 b=LiD38vQfzBbJKYuFvOkDxEmrM4/l09FA6A7n8Gd3LJ0644bg6occCPgv8SjZ+yiC+QUeTRsdgF6nvM6DhvTOW4dNjS+2np5fVMEvDO2vEY1OwIuzPcm6mu8Qws3REwIIy+zq708g3nuKqR+ku1AktPYvhqjB4kDXlfMgHG0wuHjLE4CrhuLKehMz9lSt2zJug9vLHgcWCGSFIqUimhBeAcmOQOfDWyIRg6GzvrxbbtSiTi60FHxWY/75sHhqge16poUFNI3bNzMJfI+jxYlVuhgbGwNx3/7lEnUykqhQKW2+Y3XyPH8ZYcBFVpeFQuR4snrYSwVw7PRaq+9nZwj7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Vpozi5tBGYV6jCwqnwGiTcz9TA1MJQDNiFZrPwvTlQ=;
 b=fsYhBDE+PMchP1XQtSd7dWW/QCU1iVtRS88mHOC3wvgRvhG8aTGeUNFvG2MzBwNqR2RqAs/buuRqHekciooafhWiJvOwXzB9DDqNQv9ykipYYzmXDuGUvAJCccxcEZuGmfuwHpM/cOieJyqqba9Ty1SX7y52ANOAjVXmQPEt8h4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.31; Tue, 11 Jul 2023 09:15:43 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8802:ee44:4940:8be%6]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 09:15:43 +0000
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
Thread-Index: AQHZs5h1/PIyT+/rqkKfO2l1eT25a6+0R4mAgAABU8A=
Date:   Tue, 11 Jul 2023 09:15:42 +0000
Message-ID: <DM5PR12MB24692FEDD2317DF87B8DCD45F131A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230711013831.2181718-1-guchun.chen@amd.com>
 <2a71b5c0-a79d-16e7-cba4-37018f2ebecf@gmail.com>
In-Reply-To: <2a71b5c0-a79d-16e7-cba4-37018f2ebecf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d031feb8-259e-4c99-84c2-8de61cabdb48;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-11T09:14:03Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS0PR12MB8341:EE_
x-ms-office365-filtering-correlation-id: 221d371a-51a8-467f-61cf-08db81ef66be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQdgkeiTFAmalbQ1fJ/zvsLCTBmGuAyOofswGil7KK4pLnVoPZ/+ECbiVl0CuO/+vP/PTPE58oVjzFpZcpxcvt45PnGHWHqNPujFK/3HIkViThwgQmimI+w7HpXzoDocea0SZzZVsYc4oShiYUseVGEp4x5osYHXlMKSDmFffzqjBIbBchJwJf3B05fJlYBQX0+B+Cn54WaDxBH/NPtbMNnP3qbou1JUE2weMOL+LLSr283O7BunSJFORm+9z947DExC9nOPlD5jVEu5LLFFCQPHsv/DhMOoiiyMSiiu8uwRHWrT6qPy2L8CK1oOM2fAn3XlX+wetN34lCUdkSOGE27D1QWth84yMw6bV2SDq4jsE2Q/MOeN2rO0DSkNhSn2FoApbXcq0ZBXSIBxDnrmqP6XV0yJZQuxVfd090BYiVsQqKECaMBtPd9cPo9lHC83o/hiAWZD199Z0Rd4HQ2+bcfM5suzp7TQ4ONESFSV+NZYv4bXQWkvb9p9al2fFXgjdQHIkILfsP9TMUBGrzOGIHOi0nxPH0nJoqQMDd05mtk6o2nRaah2mGR26A333d7WFNyqJMGsUqbAxsdU5SGxL6bBObFflynwySRkTzHKsAzn5XiJlEDEJNHuz/fJmuteqd5HISOq/uuh6r6F+HPN0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(86362001)(5660300002)(52536014)(8936002)(8676002)(38070700005)(41300700001)(38100700002)(316002)(2906002)(66446008)(64756008)(6636002)(66946007)(66556008)(4326008)(76116006)(921005)(122000001)(66476007)(110136005)(33656002)(83380400001)(7696005)(478600001)(71200400001)(9686003)(26005)(186003)(6506007)(53546011)(66574015)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFlzVUtsK200NmFidG84c1RDNlJuNXBJU2t1K2pnMWNiTjA4dEFyOGFNM0Zh?=
 =?utf-8?B?MDJRbmU2SE8xVmptaDAydVp4NjVvc3BnRXlDdW1kUVI0YTYrdzRIeDNuM21y?=
 =?utf-8?B?ZTdiam9adytXa0NQdVpDMjhqTXErU1NONzNRRE1adHdndjhXaW93OFdTZzRw?=
 =?utf-8?B?YUd2TU4zTWRLenJueVM2bFQ3Z1JyL1pCMUR3NEhrMUp6OTgyTmQ0QURNN29r?=
 =?utf-8?B?dTNpOUlIOVdPMk1PZkNHUkNYUmFmVXd6bnJ3dWs2aEZOTG9nOFNqMkZXQnNy?=
 =?utf-8?B?R3dzWDBGWC9qMVd6K2s1bUFuWkI4REIxcE9DbGk1ajNCVjQrK09DUVRWYXBO?=
 =?utf-8?B?M1NBeFVHcnJPOFdyOWsrV21rQWpQU2xlMVlzOXZPV2ZZcWNnSk9LcU5zdjNz?=
 =?utf-8?B?MU9wSXZqQzNoblVleEx4aDUvVU9NNnJHekFOaE0yZWc4VFZMZWkzSjNudTA2?=
 =?utf-8?B?KzRYQ3ZxSnA0T0JndG4rODBtbE5McS9ISjBRZGtxMk80TGg0YTNIeVdBYVFF?=
 =?utf-8?B?dWxTTXF1SU84VnkzaUs3ZUkxVEZPT3NTMU9aUFdINmtUL0YxbkRRaGQyZTRH?=
 =?utf-8?B?Nk1PcWU2NW9tcTdOcEd5ak55WHdVYksxZExzam1oelN1RzFuYmhGNFZjbG1W?=
 =?utf-8?B?RlQwb1FTeVlPQ1VyOU8xbzF2NnRZRVc3NEx3M0I1V3BNV1R3em4yM3drZnNG?=
 =?utf-8?B?QmFYQXFTY25GNTg5Q3UzUmhGcEsweUk5a3MrRXZrMEs0ZDdPRnFIRk5rL3hJ?=
 =?utf-8?B?NndhOHVrS1NqL3BCL04vd3RTRklzK1BQWFI3UGpSdlFsOUE5ZER0bzAzS29j?=
 =?utf-8?B?OGhDbGZiaFM1NDd1aVdvMklzcnF5OVVvNWQ2Z05ENDRmRGtwZXg4RFUwSnl5?=
 =?utf-8?B?WkZxQmZVUDdRcG05Ui9ZUlBMWTRlTEpSS3RRZlJjeEtyMDRCMW5ZV1pINUoz?=
 =?utf-8?B?cEdkU0EzWk8rSytmQ2dpVzBBRzEvQlZsY0cweXpiMDFGU0UwRnRNQ3hsSitq?=
 =?utf-8?B?cGNuS2cwK3owNldDM0tuRWU5SkpmeFo1ckRKeHRsTG4vcWQ2ckExL0RYN1FB?=
 =?utf-8?B?NGo4eFZQZ25uc2JOc2hRNDhYMnlSVTdEN3d4c1JCUHhiY2IyK3RqaDRLeXZO?=
 =?utf-8?B?SDNheEhPMm5PUVErbWFSWm9yWDlQR3FhUjBwSDFMMzczNTEyZkYyTUI5aEFi?=
 =?utf-8?B?USt0QlpsT0MyMmdnWEl3YzZGbnZYQkhRbXdacVZVazh1eFBYOTZvR1h5MWNW?=
 =?utf-8?B?aGxsdDFMQzdHb1VlSFN0OUxVdVNBWFdLMzV5czEyN3NaOFV1TlBCZk1jRmhE?=
 =?utf-8?B?VUlJZHNtZFRpN0EvRXZnL0lianhCbkZ6cW92WnlDZmdYdTNGWWQ5WkNsMTZi?=
 =?utf-8?B?VHBMNHdaOVk3NERDQUYxYWtOUi80YTFUWllEcG9oTGVzSnNZbXhkMk1xbUZY?=
 =?utf-8?B?Y29lcERSaU83aXBTSnU2R0oxSmlUdStpN2VXTDJRM3h0ckJMUGxFblFHTzRD?=
 =?utf-8?B?YXRteDNobGdLcXYzcHpkZm1YZzBGVzc2cXBRSW5ZbElwUlJIaUtDSEdBa0sy?=
 =?utf-8?B?Q1ZiOXQ1Wmc2aXZPWCswM0czVVNxU09YUlhxUnBFUWl3Q1dQQlluZmpMbkor?=
 =?utf-8?B?QlpPMFhCUWo5Z05IZDl1OE1jMXJkWDZObGQxdmphc2xpVGRiRGloajBTM25a?=
 =?utf-8?B?VnVoRzdsbkF4MUFhL09zNkY3N2lqMHl3eS9FK2F5cmtMdUdqdnA0d0Z1OUVp?=
 =?utf-8?B?ZFB0anlhcnh5RXo2cXZVMmRBd25QeWJUL3laY2Q2TTNibzNsTU1CcmxCUnZV?=
 =?utf-8?B?a3YrMzBKTTQvY0c1ZXhJclVxQ2lQeUxpSTdwaUsrYWxNOUYyKzlyMGpEdUFw?=
 =?utf-8?B?VFpCOUZKWXVBanJsakFkY0Y3Mm5mOWIzQUgvMmIvRW1TdzJUZy9QRndkbWlx?=
 =?utf-8?B?RHJXbUZSV0lONmQyYU5KTHFuVGZkWkUzLzJFampMY01LdWZOb0pVdHBKTUFJ?=
 =?utf-8?B?eEJodHR3RmJTeEp6c3pxRW04bGxBL0dxSUZ4VjFLWXoreHVkc0pocjdBSnVp?=
 =?utf-8?B?NnZPekhGdW41YXJ2RlFDQ1VCeHVVb25aalJMTUxrRHJ4SEJVYlk1UFFxQzFa?=
 =?utf-8?Q?3CSc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221d371a-51a8-467f-61cf-08db81ef66be
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 09:15:42.3679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9tuExHUerFKm6mtWQYUxI8lSk9AVgab26ASbCKzaOg6ZtY1J2gvVGOUO+abL5M4xqOp3eOqZFgjjhnTPb3czg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3Rp
YW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgSnVseSAxMSwgMjAyMyA1OjA5IFBNDQo+IFRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5D
aGVuQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIs
IEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5n
DQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0
aWFuLktvZW5pZ0BhbWQuY29tPjsgTWlsaW5rb3ZpYywgRHVzaWNhDQo+IDxEdXNpY2EuTWlsaW5r
b3ZpY0BhbWQuY29tPjsgUHJpY2EsIE5pa29sYSA8Tmlrb2xhLlByaWNhQGFtZC5jb20+OyBDdWks
DQo+IEZsb3JhIDxGbG9yYS5DdWlAYW1kLmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZHJtL2FtZGdwdS92a21zOiByZWxheCB0aW1l
ciBkZWFjdGl2YXRpb24gYnkNCj4gaHJ0aW1lcl90cnlfdG9fY2FuY2VsDQo+DQo+DQo+DQo+IEFt
IDExLjA3LjIzIHVtIDAzOjM4IHNjaHJpZWIgR3VjaHVuIENoZW46DQo+ID4gSW4gYmVsb3cgdGhv
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
cnRpbWVyX2NhbmNlbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3Jh
YiBkZXYtPmV2ZW50X2xvY2sNCj4gPg0KPiA+IFNvIENQVTEgc3R1Y2tzIGluIGhydGltZXJfY2Fu
Y2VsIGFzIHRpbWVyIGNhbGxiYWNrIGlzIHJ1bm5pbmcgZW5kbGVzcw0KPiA+IG9uIGN1cnJlbnQg
Y2xvY2sgYmFzZSwgYXMgdGhhdCB0aW1lciBxdWV1ZSBvbiBDUFUyIGhhcyBubyBjaGFuY2UgdG8N
Cj4gPiBmaW5pc2ggaXQgYmVjYXVzZSBvZiBmYWlsaW5nIHRvIGhvbGQgdGhlIGxvY2suIFNvIE5N
SSB3YXRjaGRvZyB3aWxsDQo+ID4gdGhyb3cgdGhlIGVycm9ycyBhZnRlciBpdHMgdGhyZXNob2xk
LCBhbmQgYWxsIGxhdGVyIENQVXMgYXJlDQo+IGltcGFjdGVkL2Jsb2NrZWQuDQo+ID4NCj4gPiBT
byB1c2UgaHJ0aW1lcl90cnlfdG9fY2FuY2VsIHRvIGZpeCB0aGlzLCBhcyBkaXNhYmxlX3ZibGFu
ayBjYWxsYmFjaw0KPiA+IGRvZXMgbm90IG5lZWQgdG8gd2FpdCB0aGUgaGFuZGxlciB0byBmaW5p
c2guIEFuZCBhbHNvIGl0J3Mgbm90DQo+ID4gbmVjZXNzYXJ5IHRvIGNoZWNrIHRoZSByZXR1cm4g
dmFsdWUgb2YgaHJ0aW1lcl90cnlfdG9fY2FuY2VsLCBiZWNhdXNlDQo+ID4gZXZlbiBpZiBpdCdz
DQo+ID4gLTEgd2hpY2ggbWVhbnMgY3VycmVudCB0aW1lciBjYWxsYmFjayBpcyBydW5uaW5nLCBp
dCB3aWxsIGJlDQo+ID4gcmVwcm9ncmFtbWVkIGluIGhydGltZXJfc3RhcnQgd2l0aCBjYWxsaW5n
IGVuYWJsZV92YmxhbmsgdG8gbWFrZSBpdCB3b3Jrcy4NCj4gPg0KPiA+IHYyOiBvbmx5IHJlLWFy
bSB0aW1lciB3aGVuIHZibGFuayBpcyBlbmFibGVkIChDaHJpc3RpYW4pIGFuZCBhZGQgYQ0KPiA+
IEZpeGVzIHRhZyBhcyB3ZWxsDQo+ID4NCj4gPiB2MzogZHJvcCB3YXJuIHByaW50aW5nIChDaHJp
c3RpYW4pDQo+ID4NCj4gPiBGaXhlczogODRlYzM3NGJkNTgwKCJkcm0vYW1kZ3B1OiBjcmVhdGUg
YW1kZ3B1X3ZrbXMgKHY0KSIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBT
dWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92a21zLmMgfCAx
MyArKysrKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmttcy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmttcy5jDQo+ID4gaW5kZXggNTNmZjkxZmM2Y2Y2Li5iODcwYzgyN2NiYWEgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92a21zLmMNCj4gPiBAQCAt
NDYsNyArNDYsMTAgQEAgc3RhdGljIGVudW0gaHJ0aW1lcl9yZXN0YXJ0DQo+IGFtZGdwdV92a21z
X3ZibGFua19zaW11bGF0ZShzdHJ1Y3QgaHJ0aW1lciAqdGltZXIpDQo+ID4gICAgIHN0cnVjdCBh
bWRncHVfY3J0YyAqYW1kZ3B1X2NydGMgPSBjb250YWluZXJfb2YodGltZXIsIHN0cnVjdA0KPiBh
bWRncHVfY3J0YywgdmJsYW5rX3RpbWVyKTsNCj4gPiAgICAgc3RydWN0IGRybV9jcnRjICpjcnRj
ID0gJmFtZGdwdV9jcnRjLT5iYXNlOw0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X3ZrbXNfb3V0cHV0
ICpvdXRwdXQgPQ0KPiA+IGRybV9jcnRjX3RvX2FtZGdwdV92a21zX291dHB1dChjcnRjKTsNCj4g
PiArICAgc3RydWN0IGRybV92YmxhbmtfY3J0YyAqdmJsYW5rOw0KPiA+ICsgICBzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2Ow0KPiA+ICAgICB1NjQgcmV0X292ZXJydW47DQo+ID4gKyAgIHVuc2lnbmVk
IGludCBwaXBlOw0KPiA+ICAgICBib29sIHJldDsNCj4gPg0KPiA+ICAgICByZXRfb3ZlcnJ1biA9
IGhydGltZXJfZm9yd2FyZF9ub3coJmFtZGdwdV9jcnRjLT52YmxhbmtfdGltZXIsDQo+ID4gQEAg
LTU0LDkgKzU3LDEzIEBAIHN0YXRpYyBlbnVtIGhydGltZXJfcmVzdGFydA0KPiBhbWRncHVfdmtt
c192Ymxhbmtfc2ltdWxhdGUoc3RydWN0IGhydGltZXIgKnRpbWVyKQ0KPiA+ICAgICBpZiAocmV0
X292ZXJydW4gIT0gMSkNCj4gPiAgICAgICAgICAgICBEUk1fV0FSTigiJXM6IHZibGFuayB0aW1l
ciBvdmVycnVuXG4iLCBfX2Z1bmNfXyk7DQo+ID4NCj4gPiArICAgZGV2ID0gY3J0Yy0+ZGV2Ow0K
PiA+ICsgICBwaXBlID0gZHJtX2NydGNfaW5kZXgoY3J0Yyk7DQo+ID4gKyAgIHZibGFuayA9ICZk
ZXYtPnZibGFua1twaXBlXTsNCj4gPiAgICAgcmV0ID0gZHJtX2NydGNfaGFuZGxlX3ZibGFuayhj
cnRjKTsNCj4gPiAtICAgaWYgKCFyZXQpDQo+ID4gLSAgICAgICAgICAgRFJNX0VSUk9SKCJhbWRn
cHVfdmttcyBmYWlsdXJlIG9uIGhhbmRsaW5nIHZibGFuayIpOw0KPiA+ICsgICAvKiBEb24ndCBx
dWV1ZSB0aW1lciBhZ2FpbiB3aGVuIHZibGFuayBpcyBkaXNhYmxlZC4gKi8NCj4gPiArICAgaWYg
KCFyZXQgJiYgIVJFQURfT05DRSh2YmxhbmstPmVuYWJsZWQpKQ0KPiA+ICsgICAgICAgICAgIHJl
dHVybiBIUlRJTUVSX05PUkVTVEFSVDsNCj4NCj4gV2hlbiBkcm1fY3J0Y19oYW5kbGVfdmJsYW5r
KCkgcmV0dXJucyBmYWxzZSB3aGVuIHZibGFuayBpcyBkaXNhYmxlZCBJIHRoaW5rDQo+IHdlIGNh
biBzaW1wbGlmeSB0aGlzIHRvIGp1c3QgcmVtb3ZpbmcgdGhlIGVycm9yLg0KPg0KPiBSZWdhcmRz
LA0KPiBDaHJpc3RpYW4uDQoNClNvcnJ5LCBJIGRpZG4ndCBnZXQgeW91LiBXaGF0IGRvIHlvdSBt
ZWFuIGJ5ICJyZW1vdmluZyB0aGUgZXJyb3IiPw0KDQpSZWdhcmRzLA0KR3VjaHVuDQo+ID4NCj4g
PiAgICAgcmV0dXJuIEhSVElNRVJfUkVTVEFSVDsNCj4gPiAgIH0NCj4gPiBAQCAtODEsNyArODgs
NyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdmttc19kaXNhYmxlX3ZibGFuayhzdHJ1Y3QNCj4gZHJt
X2NydGMgKmNydGMpDQo+ID4gICB7DQo+ID4gICAgIHN0cnVjdCBhbWRncHVfY3J0YyAqYW1kZ3B1
X2NydGMgPSB0b19hbWRncHVfY3J0YyhjcnRjKTsNCj4gPg0KPiA+IC0gICBocnRpbWVyX2NhbmNl
bCgmYW1kZ3B1X2NydGMtPnZibGFua190aW1lcik7DQo+ID4gKyAgIGhydGltZXJfdHJ5X3RvX2Nh
bmNlbCgmYW1kZ3B1X2NydGMtPnZibGFua190aW1lcik7DQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0
YXRpYyBib29sIGFtZGdwdV92a21zX2dldF92YmxhbmtfdGltZXN0YW1wKHN0cnVjdCBkcm1fY3J0
YyAqY3J0YywNCg0K
