Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83127BFFE1
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjJJPAq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 11:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjJJPAo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 11:00:44 -0400
Received: from m1383.mail.163.com (m1383.mail.163.com [220.181.13.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2EEEAF
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=Ksp/y2ZnPi6ieUph/Vuz6ex2at4304SeVYo01V5Rubc=; b=j
        WS5ZfG9bmQJEw3cHssPmRsrL28snaJIcLN2cy5UGigy0CXX6NlZtLkwKOIVG7zTl
        c/Hx8RcJ+AE6Y0UM0hElOo4dvAHrt9GF4dK5LzcUyWCR9TmFe8+MHdtNOdma/vm+
        fcwn0sFeZlnC4DKKHdSf87xM2OguIMvAamfBKLJMmQ=
Received: from zyytlz.wz$163.com ( [111.206.145.21] ) by
 ajax-webmail-wmsvr83 (Coremail) ; Tue, 10 Oct 2023 23:00:04 +0800 (CST)
X-Originating-IP: [111.206.145.21]
Date:   Tue, 10 Oct 2023 23:00:04 +0800 (CST)
From:   =?GBK?B?zfXV9w==?= <zyytlz.wz@163.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        "Alexandre Mergnat" <amergnat@baylibre.com>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Sasha Levin" <sashal@kernel.org>
Subject: Re:Re: [PATCH 6.1 407/600] media: mtk-jpeg: Fix use after free bug
 due to uncanceled work
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <2023101047-pumice-diligent-a08d@gregkh>
References: <20230911134633.619970489@linuxfoundation.org>
 <20230911134645.689607572@linuxfoundation.org>
 <5f19d638.6fa5.18b19f1d4fd.Coremail.zyytlz.wz@163.com>
 <2023101047-pumice-diligent-a08d@gregkh>
X-NTES-SC: AL_QuySBPWev0gr4iifYOkXkksRj+o/X8G3uvgi2odeOJ80iirQ4SAKXlxtF0Xo8fyVGxu9kzuUUjhe5vxzb4t5U77frLvvCamdIhiGUKF0B135
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <3356a38f.710e.18b1a1a2c8e.Coremail.zyytlz.wz@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: U8GowACXH6P0ZiVleY0RAA--.46744W
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQgFU1WBqqXKWAABsL
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

CgpBdCAyMDIzLTEwLTEwIDIxOjU0OjU0LCAiR3JlZyBLcm9haC1IYXJ0bWFuIiA8Z3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOgo+T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTA6MTY6
MDFQTSArMDgwMCwgzfXV9yB3cm90ZToKPj4gCj4+IEhpLAo+PiAKPj4gU29ycnkgdG8gYm90aGVy
IHlvdSBmb3IgSSBkaWRuJ3Qga25vdyBob3cgdG8gc3VibWl0IHBhdGNoIHRvIGEgc3BlY2lmaWMg
YnJhbmNoLgo+PiBDb3VsZCB5b3UgcGxlYXNlIHB1c2ggdGhpcyBwYXRjaCB0byA1LjEwIGJyYW5j
aD8gVGhlIGNocm9tZS1vcyBpcyBhZmZjdGVkIGJ5IHRoaXMgaXNzdWUuCj4KPgo+Cj5UaGlzIGlz
IG5vdCB0aGUgY29ycmVjdCB3YXkgdG8gc3VibWl0IHBhdGNoZXMgZm9yIGluY2x1c2lvbiBpbiB0
aGUKPnN0YWJsZSBrZXJuZWwgdHJlZS4gIFBsZWFzZSByZWFkOgo+ICAgIGh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5odG1s
Cj5mb3IgaG93IHRvIGRvIHRoaXMgcHJvcGVybHkuCj4KPgoKR2V0IGl0ISBUaGFua3MgdmVyeSBt
dXNoOikKCkJlc3Qgd2lzaGVzLApaaGVuZyBXYW5nCg==
