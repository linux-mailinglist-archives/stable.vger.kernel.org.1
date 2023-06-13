Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9972DB05
	for <lists+stable@lfdr.de>; Tue, 13 Jun 2023 09:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbjFMHcv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 13 Jun 2023 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbjFMHc1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Jun 2023 03:32:27 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01olkn0161.outbound.protection.outlook.com [104.47.20.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92A1FC9;
        Tue, 13 Jun 2023 00:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxmwZ0fEb+aVIrgBbngHeWXmxBD7CDPW8m8ebLRaKi4d50jxxHdlu5W82SU1EC0sPasMU4UUYoaRVwKQbE+KpozWlU15gKJH68mfDH3MinVi6dTANaDR9tJ9qnLIJd4D++0YopP09E279rie8yADAYs3BUM4bOAre6InkIrncWPhAzkr66d3f4hEa5hmQbyGzcwx/xo2tptHIa3cmRthUqH3mVppBGUi8A0dzSdH9p4L2lRXlYrnRU/LZwn7wgskPkWtVc4osN1cBHMIxo6VpbogUvzfWuZHIrPQ8d9elYULrS4rDzaJV0GMmjal4/dhPUtxQ0X3iCwTKR+evt/hJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFB6SsorpZcpkR3Iykjui7DltCai+UkTLr/+0R7OwcM=;
 b=X7lGEK9RScVvTFr0gKWA1H0k9IA87Bnve6qv0U4tIu9oXTyWp2Qu2rKfW3LGy05NY6h67pqAqyaq7w6b7nF3ylvDycAT+Lm4g/UySTaN11HJtGGOEYjS0pBgvhQNLUk5D3CyTYIEFhYLB9Lh89gW6ZpWZclDEUtnttrSRgpuSEkBSDLrkMnDhqaKmwdf0w5qh87dXk0ylfLHIsOnHWNx57ew61WxAey0WJigaEh6D3sDh24QiUCVUSVXV9eDu8Th/4GqqN6usiI5LJnyvMAzWr0FDI4HvRQHX5h9UGaE90jvmkwkIg/z6w8D0HjL4KUIzwGJWxPSqKP1XFb6KvYZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFB6SsorpZcpkR3Iykjui7DltCai+UkTLr/+0R7OwcM=;
 b=YYuZ30Q2XfBsvOsrK7VZrZg1MLPwrUGlvi5HOY0bEB8QYWVgTupz90Dqap2werOwOEBL8YXL+wD/ZmvezrQMPC6VH2O0+ylgnV2wzlA++FSzGz6oevOd0wUhd4DpAlv2+ApI5sNKHmVfQ3GGkpbknSLyEKqSzR+0qLnkgjyonjHL6JyoAMpb3D5xVeCWN9Rk2ckmOScc+M7rmQ4opxcEsgcjZfLzL2ylHqKRJ1z3ax/CBbFSV1JIRSlKmR+FPPMKL06SL8l0WxSB6Uo+sx1HmMhI/c4mThEfyhENDwTTWYFO5WB4dz+zZZMOTC41h+IkVFjWlMxIoooN/w2jO165OA==
Received: from CWLP123MB4083.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:8c::13)
 by CWLP123MB3364.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:65::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:32:09 +0000
Received: from CWLP123MB4083.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c4d4:56fc:e3d7:56c0]) by CWLP123MB4083.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c4d4:56fc:e3d7:56c0%5]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 07:32:09 +0000
From:   "Salman S ..." <ndmz34354480@msn.com>
Subject: .Re: Matter Of INTEREST.
Thread-Topic: .Re: Matter Of INTEREST.
Thread-Index: AQHZnckpO3t9HflrNUGT1ajXE00pTQ==
Date:   Tue, 13 Jun 2023 07:32:09 +0000
Message-ID: <CWLP123MB4083B064907D00716214B170D155A@CWLP123MB4083.GBRP123.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [GAxfZtVR/LP09Q3P4HAA044+crVyMRTP]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP123MB4083:EE_|CWLP123MB3364:EE_
x-ms-office365-filtering-correlation-id: b8658a7e-bc26-4b4b-4828-08db6be04bd7
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmfgmcX/ypbo8bQjslcPWBzadKKIkR8az1u3slJAOSc1Cpf7ALW//9k1dTvLgKc4fwa2XaRs6eHFu86JuJx2TJMn9ZnLDw0wxMMT36l6JVKhmjvwBbTUUFrm/Wi7b1DuyaQ5tLRNxv1yyXRehy0ZQMXRynChrWsbAmgdD0qGc/gR/Ys8DbP5Jc1llTQejE6qPj2lbXvpmuEAENausNGOwF86Pov3llBKK142yBIL4R9jNvyBsOiPV92ThGc+evDePWlf6TOIVy/vIfErZaYFVhlpsdvu3vhlImdLsdPg+Q+EH2HCR41ka1AK8dtoomOmKgExgR/cvTYwsw4OhFcGm9rtJHbFhGYH5Oy/M0jKIpet8d2ykzOsfZbOebK5WNq5FvNegLXLVfyP9tZ47TR1KMi56lRRq4BwWzI5vdFfMhh4+stvPyyTIv8P/TPAY4XKm8QcEYHS3TvpT3DtBITXw1rgkr0SGp/Npl66BgbKMCC52fl5ep4qeLpx9RC3Jg/JU7aB3h/IN1y6nrjdErys2Z9O5zXJXnjVS9sVN5sCenYduG1mXs/5gCkAHgvgcDPP
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d2VhJk/pH+cuPj+yVifnovCkUad1putGGQyRWL2MEDrvOonLGQjtxS87fu?=
 =?iso-8859-1?Q?5bctz3ou7VJKLV7pf2fmrWHT89juZzCZv0rrTiZCBINxAGhe5XqqMEDyGf?=
 =?iso-8859-1?Q?pzcl37P55kqfXMfB8hKJZGpVz+hkJKIXJ7DEbhOF2xgTaq/8+Uh+LtMkz4?=
 =?iso-8859-1?Q?l3pVr5Jp3N44bUfcwIOynHrJB8/8kZeNXdqlp2XZiWfb5slS725L0Bjj5a?=
 =?iso-8859-1?Q?MH/Brp77KnktHiuJ7/FmrKx46e6Iu4wda12oQnXuaVIEkjT+BWO7yiiONd?=
 =?iso-8859-1?Q?2BOnfZtijlb2wmX0DwnR3YLc6OwgyI3OBEvRbNB1W2/+xGdZCITEPsye+V?=
 =?iso-8859-1?Q?+QDclbkuKuYGbcs+cYLPtBgnpXeZn+oRMwDfPJEXqa5o6CpaE+N2TD37eW?=
 =?iso-8859-1?Q?iVmO6OIRa9OBjh2j4+7W1S4VSE2Q2DCl+mlGQpH2svcPgmg4kTK7eZB+GD?=
 =?iso-8859-1?Q?bNo6jzkUsswJoxEIHAsn+qN3PyXJUWTUTxBVDmMkVWghVeQFs6BLZOaEWm?=
 =?iso-8859-1?Q?5wT+w7+9UujPLb66qvqun53my31NmGRb5+gs6HAPfykBqkYY7b42fqMlsp?=
 =?iso-8859-1?Q?Nb+hhABah2a8bh4iES7m8PkG1Ekb6g94lA46/iWoFJwswlVIFfIcoJhGHw?=
 =?iso-8859-1?Q?HWrmYxwjMRPk2zD5u6gg8r8z7XKwHG41s4y/ZYmIbkLGg80NO+HLriHsXy?=
 =?iso-8859-1?Q?ugQ2xUfCasEk3+3UjI/peTAZysM8WnjU1n/eRlQGb/0g5CuZtR0JWvtqHR?=
 =?iso-8859-1?Q?MWz9m1E6fLt+IhfVrZ/conoU6V0vgoFnOAbev8i7iT0nRyERTvdZKmumP1?=
 =?iso-8859-1?Q?Ia7o9/wxNe588mr0jGm4SlBnI+IMNNZEUkBSepcYjgg2t8589EqXOA2B12?=
 =?iso-8859-1?Q?/cBWq4rtrLtmF+a+FMKpHZK88Q87hokkAMhMTcyLkDlBwITb+1EIhyOR+7?=
 =?iso-8859-1?Q?KJAdSeLOf5r12QzhzReKS+RgswPom3cz16F07rR8cFhVM6+DgPNRcNDmpe?=
 =?iso-8859-1?Q?27J3IP2V/54dreL2YiScrOkVh5yjUEiwC7b4oXPnUNzrAHWlK/uO1DsaLm?=
 =?iso-8859-1?Q?8H4sb1kyIANj5pLhRvLcjTfqgvBkRX2dwATPxWyE864sxjcJwhAS7O/nDZ?=
 =?iso-8859-1?Q?YPBOCR786WLDyEkx8V8sHAN7021QYOAbH4uGE2REZDxcYVyEE2s/Jk1hWa?=
 =?iso-8859-1?Q?oirRwfr65T+BFAMHP3aN1pygBwUZyzGbHwq2TVYPkgqZxDlyXZkpJLos48?=
 =?iso-8859-1?Q?xcIyIuipQax/3WV3d8Ng=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-2ec8f.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB4083.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b8658a7e-bc26-4b4b-4828-08db6be04bd7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:32:09.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3364
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

=0A=
=0A=
Hello,=0A=
Did you receive the previous message I sent you from our office?=0A=
Please let me know.=0A=
=0A=
Yours Sincerely,=0A=
Salman AH.Tel: +9733375408=
