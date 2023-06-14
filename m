Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA5C730980
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 22:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjFNU7G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 16:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjFNU7F (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 16:59:05 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 13:58:19 PDT
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC58E19B5
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1686776298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vWSalC71SPVHF2pdl0zKmtPOi4NVL87qzqQK5/SeIi0=;
        b=ArD7A5pZRvX6AcnF6K+z+O8x473+f6880t8Kssu9VXSRMrWntgvonGZ6R9/tUxh7GTDleC
        9p+AR7vHyPYHuEzTKxDj29l/65ZUy7l95lLD70u6XdWuKUMYdbcFku+fxinM40tvEu5xgu
        cJdOlMRuKcBLDC5mb2ZTRrEhJhzrVwE=
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-VWkgU9_0MDu3Tyyxj79whg-1; Wed, 14 Jun 2023 16:52:10 -0400
X-MC-Unique: VWkgU9_0MDu3Tyyxj79whg-1
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by DM4PR84MB1687.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 20:52:06 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::16ce:e8de:5682:15b3]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::16ce:e8de:5682:15b3%5]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 20:52:06 +0000
From:   "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "Zhang, Eniac" <eniac-xw.zhang@hp.com>
Subject: [PATCH] drm/amdgpu: Don't set struct drm_driver.output_poll_changed
Thread-Topic: [PATCH] drm/amdgpu: Don't set struct
 drm_driver.output_poll_changed
Thread-Index: AQHZnwCNwegv30wmp0uwuovLGQwTEg==
Date:   Wed, 14 Jun 2023 20:52:06 +0000
Message-ID: <SJ0PR84MB20882EEA1ABB36F60E845E378F5AA@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|DM4PR84MB1687:EE_
x-ms-office365-filtering-correlation-id: 3155c361-9e00-474b-c6f2-08db6d1936eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: ZxT2H3Hztpp0QFru2vugVZu4yll9RY7X6N8Vz6fEQJcLqoTp9q5Ma/6XS3wDVmXXvY+HgzGoi/JYB0jEUGH/s/EwvryWexcEu964PeDb3VcFnPmP8aHkcwl7GD/V/r8k20iTpgclkc4LDXVQ40nuGjB1R/eZppvTCpLuhxelAoTfcyOR82Cix65nY4qpMJTiSwJSCao4uGQMjaIGOwS6MgwoOEakEWbuSbxUTrIBTZPSWWHPuUFk51yspD7gvoPz4FxVH4QnwbRM4wCXlC5F8lxKxO9ogH7h87pCbYaZTpLbIYBh0YRmJzdzy1qxs0nJmCV2YWnHUSSaqkGeDNvu9LZnM6cpg76SeTbQ8hJQD4+SUhIuCAxhG3Dwzz+HLs/S6eACMZtxoYOSIY7HcPf5qiPhXArct+M7znaLgPCkXR3D6YIXSFxj8cp2WsxztZgPksgweay8OMm8BKWK1ghUmWT/ZhdBiLnSZGMr8HC8P++vtSFkoizj/IkYcUhX5g2G33g1paSGBTrVAdFuJyBRGajTq2ZHSVNKnOO2NRh7xP2zVWDSHmFV92ofnX9+Yf6FneILM3jDakrpmKZ4BzNsUZqx1DBKCMBNY7pibURNR6u32xjaUS9oraMFAX8/8GIY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199021)(55016003)(4326008)(66946007)(64756008)(76116006)(316002)(5660300002)(91956017)(66446008)(52536014)(66476007)(9686003)(26005)(8676002)(8936002)(6506007)(41300700001)(86362001)(122000001)(33656002)(38100700002)(558084003)(2906002)(6916009)(82960400001)(66556008)(38070700005)(478600001)(71200400001)(186003)(7696005);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2ro+YLVIgsTR0M+OD1rE88Jo5XzvEvro3+kYZ5SdpVa2qzI0w4HtRcSvA4?=
 =?iso-8859-1?Q?wFY3y9t2oh9lTIGY07psvmAoguhHZk4vUZawRRXHfKnzeZEeZExxhfz6Ls?=
 =?iso-8859-1?Q?vLgXzAq7BAasJZUDrrdarW63DceOUKmo0Wukzy2EkA91X2May7ZqAA8hdL?=
 =?iso-8859-1?Q?ItaR5tszT6vZErtJeO02tLRyADl2vsfW9ZpoWdlDpg9Vh9woq0GEwP+FPs?=
 =?iso-8859-1?Q?uAlp2hO+amUDgJv2bovSH1amtizh3bIqBq8HdPhM8fPzfrYN/ZOAmo2U1y?=
 =?iso-8859-1?Q?mOP4Vsoqpi73cDiD60dRSrfsxPkvxYHkR6XMKhfwkW2cjbjazzepbseFZF?=
 =?iso-8859-1?Q?z+jKiuRwCmZZJWAWu5Srz9si3nXQcDCho+FaWG1VadaCFyVe3QUfITwk83?=
 =?iso-8859-1?Q?9y6ApgaX6H6uM4iCReMv7rwz1eEds6g5S6gQlIx2sricIvIwdzhMXYX1VB?=
 =?iso-8859-1?Q?8tGyRH/R8WMevUlGv+sW4zhSUdD9wKnoyvtDmeaPaCFFWy0rJTaPAw18Vi?=
 =?iso-8859-1?Q?OkRSV66kpz5CEjbw7t9eYfn1EwriHAHiZFqSknu3gdbk0HZ6p4nNBn21Wu?=
 =?iso-8859-1?Q?lkAOJzeGCS8gu50X+d52ooniClkT3uqkV4nFALV1M3CVKcLmLS0FueVT7B?=
 =?iso-8859-1?Q?dlzapkS2cxFzYq7mDzI2QLOp4+9r3s0bjIh6JPqDBczU2ecuHeuwdC4QL9?=
 =?iso-8859-1?Q?P2qy+altRUsxzKBgk+hNKR5VqNHWB2EsQMpddxxgUPugdFMNAT4Ychfi/J?=
 =?iso-8859-1?Q?/if3gKAuHrzfYIc9sQT+tugfGjLFCyY/8BUVj25/t5b4JKudsXDBlyc567?=
 =?iso-8859-1?Q?O5GsUpGe2BVkxJ1eVeIck7DOrkTL+cXm+m7eEIMJtmJlRSm2VFFbYPJZsC?=
 =?iso-8859-1?Q?D38yCopadcz3aduXBOOWMbg4eauA58u5rDQqNOI+eHHcS73gVkcmL9ObuB?=
 =?iso-8859-1?Q?3GT57exYWYSL5/OUgm+BCRSVpDfq0Sz2AVFeIed7jYNYV0lRKpnvNhD2TM?=
 =?iso-8859-1?Q?kJTX692bKzEtEEWChnnoKN+G0kLi1BMFSmXg7WTjtsuztgjLSB76zDGP6H?=
 =?iso-8859-1?Q?u8eEI7vHUOog5CAdJggC9ee+KXqzEKYaNTuFv2pYl611PBHcnngjs5MzK9?=
 =?iso-8859-1?Q?wosLKq4qwEFZ00CXAiYCZ9Kc9p7L0piWJ7JJdWzL0t1biWmNYgWSrBxjMi?=
 =?iso-8859-1?Q?yKVJskKtBHxm1HJzHJusw1tkcxTrzZEvqxDYax7wgdTHSKFpt4RTF7TXPy?=
 =?iso-8859-1?Q?YS47G/M9a+UdedtDs8O+YfcdbylTdsXVjjwnfBDJ/AW7QzZXY8V1qcAMl4?=
 =?iso-8859-1?Q?lJpaHQNUPiUtJbrCOCkwljjSVg4yg/CPJTc8FX+/KnUjDQY+nayXt/gHLq?=
 =?iso-8859-1?Q?EvfPyMasyf3y/EM7grpedlXIzdNPy22uymb5ibN8ANNlsCFeb0Z4zZwB2q?=
 =?iso-8859-1?Q?7nG7KopK1uTl0u26n/vc/cOm2nCm4XB5SmHFs/8HlztIK4i8qRjFpUbsQ6?=
 =?iso-8859-1?Q?/uo+syaLoeTTGtTivjU8/6hT64sKjDLZOnE5DIrGEAc6dALjwX9v7UmJeC?=
 =?iso-8859-1?Q?IiQvrq8vIcWmeZ83XTgeXbTf5QxKeN75MW/6LV0ZuZ8E38CCK+PCUyk6pw?=
 =?iso-8859-1?Q?ERR1xd9OD0CZnb0zL1aiYqARxgQTfhr7IN?=
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3155c361-9e00-474b-c6f2-08db6d1936eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 20:52:06.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ULtdJDfYCfRbE4c5fQV8tGb1nF7604PzPuMIhXFmwUjNaz/sPOhR+HzEtQVRGup27ThGPufme1Uo/YIofFwcZwljvtRVhACL+iL4FGVFlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1687
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please consider adding the following commit to v6.1.x:=0A=0A0e3172bac3f4 ("=
drm/amdgpu: Don't set struct drm_driver.output_poll_changed")=0A=0AThis fix=
es a few issues where a system resuming may end up with a black screen if t=
he display topology has changed. It would be great to have it in 6.1 branch=
.=0A=0AAlex

