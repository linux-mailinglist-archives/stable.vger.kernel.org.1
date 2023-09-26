Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E297AF3FF
	for <lists+stable@lfdr.de>; Tue, 26 Sep 2023 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbjIZTRL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 26 Sep 2023 15:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZTRK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 26 Sep 2023 15:17:10 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC5910A;
        Tue, 26 Sep 2023 12:17:03 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230926191700usoutp021543cfedd8dc67c24bc29e9caabf72d2~IiO8Zf4hH0350603506usoutp02w;
        Tue, 26 Sep 2023 19:17:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230926191700usoutp021543cfedd8dc67c24bc29e9caabf72d2~IiO8Zf4hH0350603506usoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695755820;
        bh=ly98DkW7nGTDsxy3526v+PK1TTe2hIrkoD3U6k0H9fk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=aMONmGVQ6H5ffRdAUm7qpCaEtvdNogL0dl6DIsyTzyFPpoadKw7d7USFngCoqKkka
         xiwDKg2T9UmQxPqy0rDZM4pvTLd9CeYHsQH6ScP7ZpJLMZH7CgZwITMQNyGm9V/LvV
         tZUP4vOPd1z3E2TDN0B2Umr8G8ezwHCqWUsld49c=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230926191700uscas1p156769b1a2e22f809d827522aa53e0854~IiO8Qvepe3137531375uscas1p1r;
        Tue, 26 Sep 2023 19:17:00 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id B7.DA.50148.B2E23156; Tue,
        26 Sep 2023 15:16:59 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230926191659uscas1p1db1b3f40732b6ca8231d405c98953181~IiO7m4ynW3133731337uscas1p1w;
        Tue, 26 Sep 2023 19:16:59 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-8c-65132e2b9795
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id D3.AD.28590.B2E23156; Tue,
        26 Sep 2023 15:16:59 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 26 Sep 2023 12:16:58 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        26 Sep 2023 12:16:58 -0700
From:   Jim Harris <jim.harris@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/port: Fix cxl_test register enumeration regression
Thread-Topic: [PATCH] cxl/port: Fix cxl_test register enumeration regression
Thread-Index: AQHZ8K4FtDD4/vW5GUqlewTTfjFEVQ==
Date:   Tue, 26 Sep 2023 19:16:58 +0000
Message-ID: <8a58bace-765b-4492-8866-5b907907c346@samsung.com>
In-Reply-To: <169476525052.1013896.6235102957693675187.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0FF7335A588F246889F158838F1F3FD@ssi.samsung.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzreV1tPeFUg4dzrS3uPr7AZjF96gVG
        i/OzTrFYLNj4iNGBxWPxnpdMHp83yQUwRXHZpKTmZJalFunbJXBlLD+wh6ngmVDFhtetTA2M
        K4S6GDk5JARMJL5em8zUxcjFISSwklHi9Nob7BBOK5PEqtXzGGGqTq+YwAKRWMso8ejLdSjn
        E6PE9td3oFqWMUrsnXmaFaSFTUBT4teVNUwgtohAmsTXXy+AbA4OZiB73YE0kLCwgLfEr7U9
        7CBhEQEfif6v9RCmnsSvW34gFSwCqhJ39kwAG8IrYCfRunI50Fp2Dk6BcIldpiBRRgExie+n
        INYwC4hL3HoynwniYkGJRbP3MEPYYhL/dj1kg7AVJe5/f8kOcYqmxPpd+hCtdhLn+k4yQ9iK
        ElO6H7JDLBWUODnzCQtEq6TEwRU3wP6WEFjJITFt52ZWiISLxI9pzewQtrTE1etTofZmS6xc
        3wH2toRAgUTDkSCIsLXEwj/rmSYwqsxCcvUshItmIbloFpKLZiG5aAEj6ypG8dLi4tz01GLD
        vNRyveLE3OLSvHS95PzcTYzAtHL63+HcHYw7bn3UO8TIxMF4iFGCg1lJhPfhbaFUId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4ryGtieThQTSE0tSs1NTC1KLYLJMHJxSDUwZkjMXvNz+wXFizRoF
        7tUN9Wud7s/NDo//pbJ/bXHP93M1rFJ59wXO36qfcmtB96FL8V6HthYwMEzmCG74cDlAad4z
        +94VLntat6l8mbVkftMH26OONkLaNvd2Xj/88coJh+NTNZRVRXXLHMu9lhuVfVrjpXLM37Dr
        0eFbn/nONIq0ZSpxTPjW6P/15vnJ6pu5DGTqJuqdPqHyMTdRN3hVSOHvRw8c91f5Tr/6Ymry
        uWvyq6P5J58QfpOrGOmyNSDzhcX8FRmcaS2ipiYybG88P4lWL93/XSXSsNdPTH27s41RvfbX
        1bUnHn2OvpRY/KO+8gyvzN+Y3t12IvPfacwtyzi4sygycP+Xjj9KXPeVWIozEg21mIuKEwFh
        HZYdmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWS2cA0SVdbTzjVoGU1n8XdxxfYLKZPvcBo
        cX7WKRaLBRsfMTqweCze85LJ4/MmuQCmKC6blNSczLLUIn27BK6M5Qf2MBU8E6rY8LqVqYFx
        hVAXIyeHhICJxOkVE1i6GLk4hARWM0ocP7KXDcL5xCgx8etTqMwyRol7q28xg7SwCWhK/Lqy
        hgnEFhFIk/j66wWQzcHBDGSvO5AGEhYW8Jb4tbaHHSQsIuAj0f+1HsLUk/h1yw+kgkVAVeLO
        nglgQ3gF7CRaVy5nAbGFBMIkTh35DLSInYNTIFxilylIlFFATOL7KYiVzALiEreezGeCuF5A
        Ysme88wQtqjEy8f/WCFsRYn731+yQ5ylKbF+lz5Eq53Eub6TzBC2osSU7ofsEAcISpyc+YQF
        olVS4uCKGywTGCVmIdk2C2HSLCSTZiGZNAvJpAWMrKsYxUuLi3PTK4oN81LL9YoTc4tL89L1
        kvNzNzECY/L0v8OROxiP3vqod4iRiYPxEKMEB7OSCO/D20KpQrwpiZVVqUX58UWlOanFhxil
        OViUxHl3TLmYIiSQnliSmp2aWpBaBJNl4uCUamBqyu1sMjz+ynFdoWmfxRPWZIFPBW4KFx9p
        7Hwn5bD96LTaCHnfL8s/B7ZHt7jX23QEF32J3v5F6h9jd+9U4ZVXz1Yez9x26k2XjUI6v8Oy
        9kTvO2d35L3zWpIoa11peNLTY+GJZa8tFq7c3zprvVkZt0XRzYfmgi1fI36tqrgX+FEqfuVa
        q6tFz+brrmb4YbinPnbZXWPWsm8OmarLY6cmCdVn8z+xFT94xeH39qXdrMvW+5jncrcsmv9Q
        9Lb3LsaapQudknwuPWBZL3iTuTfXZ+/V748LZwhk7Xi7teD5p/Wqe+9Y1R9+n77r/wn11Gbf
        idd470qt+9BoOH/qj1cfrD9uePu87wA/r+bbx7kXlViKMxINtZiLihMBjavRTTgDAAA=
X-CMS-MailID: 20230926191659uscas1p1db1b3f40732b6ca8231d405c98953181
CMS-TYPE: 301P
X-CMS-RootMailID: 20230926191659uscas1p1db1b3f40732b6ca8231d405c98953181
References: <169476525052.1013896.6235102957693675187.stgit@dwillia2-xfh.jf.intel.com>
        <CGME20230926191659uscas1p1db1b3f40732b6ca8231d405c98953181@uscas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

DQoNCk9uIDkvMTUvMjAyMyAxOjA3IEFNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IFRoZSBjeGxf
dGVzdCB1bml0IHRlc3QgZW52aXJvbm1lbnQgbW9kZWxzIGEgQ1hMIHRvcG9sb2d5IGZvcg0KPiBz
eXNmcy91c2VyLUFCSSByZWdyZXNzaW9uIHRlc3RpbmcuIEl0IHVzZXMgaW50ZXJmYWNlIG1vY2tp
bmcgdmlhIHRoZQ0KPiAiLS13cmFwPSIgbGlua2VyIG9wdGlvbiB0byByZWRpcmVjdCBjeGxfY29y
ZSByb3V0aW5lcyB0aGF0IHBhcnNlDQo+IGhhcmR3YXJlIHJlZ2lzdGVycyB3aXRoIHZlcnNpb25z
IHRoYXQganVzdCBwdWJsaXNoIG9iamVjdHMsIGxpa2UNCj4gZGV2bV9jeGxfZW51bWVyYXRlX2Rl
Y29kZXJzKCkuDQo+DQo+IFN0YXJ0aW5nIHdpdGg6DQo+DQo+IENvbW1pdCAxOWFiNjlhNjBlM2Ig
KCJjeGwvcG9ydDogU3RvcmUgdGhlIHBvcnQncyBDb21wb25lbnQgUmVnaXN0ZXIgbWFwcGluZ3Mg
aW4gc3RydWN0IGN4bF9wb3J0IikNCj4NCj4gLi4ucG9ydCByZWdpc3RlciBlbnVtZXJhdGlvbiBp
cyBtb3ZlZCBpbnRvIGRldm1fY3hsX2FkZF9wb3J0KCkuIFRoaXMNCj4gY29uZmxpY3RzIHdpdGgg
dGhlICJjeGxfdGVzdCBhdm9pZHMgZW11bGF0aW5nIHJlZ2lzdGVycyBzdGFuY2UiIHNvDQo+IGVp
dGhlciB0aGUgcG9ydCBjb2RlIG5lZWRzIHRvIGJlIHJlZmFjdG9yZWQgKHRvbyB2aW9sZW50KSwg
b3IgbW9kaWZpZWQNCj4gc28gdGhhdCByZWdpc3RlciBlbnVtZXJhdGlvbiBpcyBza2lwcGVkIG9u
ICJmYWtlIiBjeGxfdGVzdCBwb3J0cw0KPiAoYW5ub3lpbmcsIGJ1dCBzdHJhaWdodGZvcndhcmQp
Lg0KPg0KPiBUaGlzIGNvbmZsaWN0IGhhcyBoYXBwZW5lZCBwcmV2aW91c2x5IGFuZCB0aGUgImNo
ZWNrIGZvciBwbGF0Zm9ybQ0KPiBkZXZpY2UiIHdvcmthcm91bmQgdG8gYXZvaWQgaW5zdHJ1c2l2
ZSByZWZhY3RvcmluZyB3YXMgZGVwbG95ZWQgaW4gdGhvc2UNCj4gc2NlbmFyaW9zLiBJbiBnZW5l
cmFsLCByZWZhY3RvcmluZyBzaG91bGQgb25seSBiZW5lZml0IHByb2R1Y3Rpb24gY29kZSwNCj4g
dGVzdCBjb2RlIG5lZWRzIHRvIHJlbWFpbiBtaW5pbWFsbHkgaW5zdHJ1c2l2ZSB0byB0aGUgZ3Jl
YXRlc3QgZXh0ZW50DQo+IHBvc3NpYmxlLg0KPg0KPiBUaGlzIHdhcyBtaXNzZWQgcHJldmlvdXNs
eSBiZWNhdXNlIGl0IG1heSBzb21ldGltZXMganVzdCBjYXVzZSB3YXJuaW5nDQo+IG1lc3NhZ2Vz
IHRvIGJlIGVtaXR0ZWQsIGJ1dCBpdCBjYW4gYWxzbyBjYXVzZSB0ZXN0IGZhaWx1cmVzLiBUaGUN
Cj4gYmFja3BvcnQgdG8gLXN0YWJsZSBpcyBvbmx5IG5pY2UgdG8gaGF2ZSBmb3IgY2xlYW4gY3hs
X3Rlc3QgcnVucy4NCj4NCj4gRml4ZXM6IDE5YWI2OWE2MGUzYiAoImN4bC9wb3J0OiBTdG9yZSB0
aGUgcG9ydCdzIENvbXBvbmVudCBSZWdpc3RlciBtYXBwaW5ncyBpbiBzdHJ1Y3QgY3hsX3BvcnQi
KQ0KPiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFJlcG9ydGVkLWJ5OiBBbGlzb24g
U2Nob2ZpZWxkIDxhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+DQpUaGlzIHBhdGNoIGhh
cyBhbHJlYWR5IGhpdCB1cHN0cmVhbSwgYnV0IEknZCBsaWtlIHRvIHJlcG9ydA0KdGhpcyBhbHNv
IGZpeGVkIGEgMTAwJSByZXByb2R1Y2libGUgaXNzdWUganVzdCBsb2FkaW5nDQpjeGxfdGVzdCBt
b2R1bGVzIGluIGEgUGFyYWxsZWxzIEFSTSBWTSBvbiBhIE1hY0Jvb2sgUHJvLg==
