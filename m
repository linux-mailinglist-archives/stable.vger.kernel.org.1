Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C667A0E7D
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjINTtJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjINTtJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 15:49:09 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96BA26AB
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 12:49:04 -0700 (PDT)
Message-ID: <536c792d-984c-439b-8ee9-25b1bfc5c791@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694720939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=w/AIvj4DyFs/ZDfYfUMdqcUdtouJHAW5IALBmLksUdA=;
        b=cTvxtVmwSwP06OOU++8l68oZXmLkHUNGDHVCRBPKlYQwxV6eldcyi6vfDojkIssVzhLOwD
        D1/ILvyoU+R7YxuoGRIOmEP5SvP3zAITKRtLDfyVjxoLU63cyFzwZ3L/7ULRMOIHvzWi5M
        A55UOdv58LaLb+WrzR7JIVeaMgDGr2JAIcz4/8+9ix4w+lQDheP44kyEZ/1RLQXM80gVrw
        rR7lxy7Shb4QMvQsJPqbrq8vemWSQVT1mk5j9BuaiXlspV5AYrLw3DsrSC5/4PrwM6Q4VY
        ytmEyf58m4qfz9WilXyyQvXW4yLyQYcn+J7yb6aXj2qPc8NOkzMBhwDcuDNBSI0/KGTfem
        /nvWw3ktiPZBrvTTaV1J8vtpyGSVSVYnrQ9nL5Ckaz7sAO3NpqRQB52EZ97pgN6ATbWHH9
        1xYdeBysGdE+o5Hw1iBvV722wFGl2Od6fhk0S8JN1MRV23Y0fzU7RGAX6g9Hvb77vi/Pl3
        Yyd6PZdkheUrX+Kn9j5Eb3Zg4npmB/Xrvz3oS5WvyS/E+3udXDZmHTxy+Nw0zF/nZW0JHX
        n9nBjPFEGWVfDPy6nEM21N4KfB2DZ+J+Vxkhwnab64uXB++oq3Wq26+1mXHmeIUyGV7ghq
        BJqUZOIvfRURdLRXqg/US0kKrq+CrDHJfUGHSMBhk0c/6WoMRoHgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694720939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=w/AIvj4DyFs/ZDfYfUMdqcUdtouJHAW5IALBmLksUdA=;
        b=BuxdSX7tNOuhTgwt5/8X2AcCr3j1t+y7RMgia1C/ZsF8hpasFSsS48wc76K+Z69IMorT/C
        sIEFS0j+O8m+0JBg==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date:   Thu, 14 Sep 2023 22:48:55 +0300
MIME-Version: 1.0
Subject: Re: [PATCHv2] nvme: avoid bogus CRTO values
Content-Language: en-US-large
To:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        hch@lst.de
Cc:     Keith Busch <kbusch@kernel.org>,
        =?UTF-8?Q?Cl=C3=A1udio_Sampaio?= <patola@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
References: <20230913202810.2631288-1-kbusch@meta.com>
From:   Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <20230913202810.2631288-1-kbusch@meta.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ppRiPWleYur8X8XZFUS1AtwL"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ppRiPWleYur8X8XZFUS1AtwL
Content-Type: multipart/mixed; boundary="------------wwuRpET0ElFPKeRQ8rkp8WOD";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, =?UTF-8?Q?Cl=C3=A1udio_Sampaio?=
 <patola@gmail.com>, Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Message-ID: <536c792d-984c-439b-8ee9-25b1bfc5c791@archlinux.org>
Subject: Re: [PATCHv2] nvme: avoid bogus CRTO values
References: <20230913202810.2631288-1-kbusch@meta.com>
In-Reply-To: <20230913202810.2631288-1-kbusch@meta.com>

--------------wwuRpET0ElFPKeRQ8rkp8WOD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS8xMy8yMyAyMzoyOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1
c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFNvbWUgZGV2aWNlcyBhcmUgcmVwb3J0
aW5nIENvbnRyb2xsZXIgUmVhZHkgTW9kZXMgU3VwcG9ydGVkLCBidXQgcmV0dXJuDQo+IDAg
Zm9yIENSVE8uIFRoZXNlIGRldmljZXMgcmVxdWlyZSBhIG11Y2ggaGlnaGVyIHRpbWUgdG8g
cmVhZHkgdGhhbiB0aGF0LA0KPiBzbyB0aGV5IGFyZSBmYWlsaW5nIHRvIGluaXRpYWxpemUg
YWZ0ZXIgdGhlIGRyaXZlciBzdGFydGVkIHByZWZlcnJpbmcNCj4gdGhhdCB2YWx1ZSBvdmVy
IENBUC5UTy4NCj4gDQo+IFRoZSBzcGVjIHJlcXVpcmVzIENBUC5UTyBtYXRjaCB0aGUgYXBw
cm9wcml0YXRlIENSVE8gdmFsdWUsIG9yIGJlIHNldCB0bw0KPiAweGZmIGlmIENSVE8gaXMg
bGFyZ2VyIHRoYW4gdGhhdC4gVGhpcyBtZWFucyB0aGF0IENBUC5UTyBjYW4gYmUgdXNlZCB0
bw0KPiB2YWxpZGF0ZSBpZiBDUlRPIGlzIHJlbGlhYmxlLCBhbmQgcHJvdmlkZXMgYW4gYXBw
cm9wcmlhdGUgZmFsbGJhY2sgZm9yDQo+IHNldHRpbmcgdGhlIHRpbWVvdXQgdmFsdWUgaWYg
bm90LiBVc2Ugd2hpY2hldmVyIGlzIGxhcmdlci4NCj4gDQo+IExpbms6IGh0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3ODYzDQo+IFJlcG9ydGVkLWJ5
OiBDbMOhdWRpbyBTYW1wYWlvIDxwYXRvbGFAZ21haWwuY29tPg0KPiBSZXBvcnRlZC1ieTog
RmVsaXggWWFuIDxmZWxpeG9ubWFyc0BhcmNobGludXgub3JnPg0KPiBCYXNlZC1vbi1hLXBh
dGNoLWJ5OiBGZWxpeCBZYW4gPGZlbGl4b25tYXJzQGFyY2hsaW51eC5vcmc+DQo+IFJldmll
d2VkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2No
QGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiB2MS0+djI6DQo+ICAgIFdhcm4gb25jZSBpZiBkcml2
ZXIgaXNuJ3QgcmVseWluZyBvbiBDUlRPIHZhbHVlcw0KPiANCj4gICBkcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMgfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBpbmRleCAzN2I2ZmE3NDY2NjIwLi4wNjg1ZWQ0
ZjJkYzQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gKysr
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+IEBAIC0yMjQ1LDI1ICsyMjQ1LDggQEAg
aW50IG52bWVfZW5hYmxlX2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gICAJZWxz
ZQ0KPiAgIAkJY3RybC0+Y3RybF9jb25maWcgPSBOVk1FX0NDX0NTU19OVk07DQo+ICAgDQo+
IC0JaWYgKGN0cmwtPmNhcCAmIE5WTUVfQ0FQX0NSTVNfQ1JXTVMpIHsNCj4gLQkJdTMyIGNy
dG87DQo+IC0NCj4gLQkJcmV0ID0gY3RybC0+b3BzLT5yZWdfcmVhZDMyKGN0cmwsIE5WTUVf
UkVHX0NSVE8sICZjcnRvKTsNCj4gLQkJaWYgKHJldCkgew0KPiAtCQkJZGV2X2VycihjdHJs
LT5kZXZpY2UsICJSZWFkaW5nIENSVE8gZmFpbGVkICglZClcbiIsDQo+IC0JCQkJcmV0KTsN
Cj4gLQkJCXJldHVybiByZXQ7DQo+IC0JCX0NCj4gLQ0KPiAtCQlpZiAoY3RybC0+Y2FwICYg
TlZNRV9DQVBfQ1JNU19DUklNUykgew0KPiAtCQkJY3RybC0+Y3RybF9jb25maWcgfD0gTlZN
RV9DQ19DUklNRTsNCj4gLQkJCXRpbWVvdXQgPSBOVk1FX0NSVE9fQ1JJTVQoY3J0byk7DQo+
IC0JCX0gZWxzZSB7DQo+IC0JCQl0aW1lb3V0ID0gTlZNRV9DUlRPX0NSV01UKGNydG8pOw0K
PiAtCQl9DQo+IC0JfSBlbHNlIHsNCj4gLQkJdGltZW91dCA9IE5WTUVfQ0FQX1RJTUVPVVQo
Y3RybC0+Y2FwKTsNCj4gLQl9DQo+ICsJaWYgKGN0cmwtPmNhcCAmIE5WTUVfQ0FQX0NSTVNf
Q1JXTVMgJiYgY3RybC0+Y2FwICYgTlZNRV9DQVBfQ1JNU19DUklNUykNCj4gKwkJY3RybC0+
Y3RybF9jb25maWcgfD0gTlZNRV9DQ19DUklNRTsNCj4gICANCj4gICAJY3RybC0+Y3RybF9j
b25maWcgfD0gKE5WTUVfQ1RSTF9QQUdFX1NISUZUIC0gMTIpIDw8IE5WTUVfQ0NfTVBTX1NI
SUZUOw0KPiAgIAljdHJsLT5jdHJsX2NvbmZpZyB8PSBOVk1FX0NDX0FNU19SUiB8IE5WTUVf
Q0NfU0hOX05PTkU7DQo+IEBAIC0yMjc3LDYgKzIyNjAsMzkgQEAgaW50IG52bWVfZW5hYmxl
X2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gICAJaWYgKHJldCkNCj4gICAJCXJl
dHVybiByZXQ7DQo+ICAgDQo+ICsJLyogQ0FQIHZhbHVlIG1heSBjaGFuZ2UgYWZ0ZXIgaW5p
dGlhbCBDQyB3cml0ZSAqLw0KPiArCXJldCA9IGN0cmwtPm9wcy0+cmVnX3JlYWQ2NChjdHJs
LCBOVk1FX1JFR19DQVAsICZjdHJsLT5jYXApOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVy
biByZXQ7DQo+ICsNCj4gKwl0aW1lb3V0ID0gTlZNRV9DQVBfVElNRU9VVChjdHJsLT5jYXAp
Ow0KPiArCWlmIChjdHJsLT5jYXAgJiBOVk1FX0NBUF9DUk1TX0NSV01TKSB7DQo+ICsJCXUz
MiBjcnRvLCByZWFkeV90aW1lb3V0Ow0KPiArDQo+ICsJCXJldCA9IGN0cmwtPm9wcy0+cmVn
X3JlYWQzMihjdHJsLCBOVk1FX1JFR19DUlRPLCAmY3J0byk7DQo+ICsJCWlmIChyZXQpIHsN
Cj4gKwkJCWRldl9lcnIoY3RybC0+ZGV2aWNlLCAiUmVhZGluZyBDUlRPIGZhaWxlZCAoJWQp
XG4iLA0KPiArCQkJCXJldCk7DQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCQl9DQo+ICsNCj4g
KwkJLyoNCj4gKwkJICogQ1JUTyBzaG91bGQgYWx3YXlzIGJlIGdyZWF0ZXIgb3IgZXF1YWwg
dG8gQ0FQLlRPLCBidXQgc29tZQ0KPiArCQkgKiBkZXZpY2VzIGFyZSBrbm93biB0byBnZXQg
dGhpcyB3cm9uZy4gVXNlIHRoZSBsYXJnZXIgb2YgdGhlDQo+ICsJCSAqIHR3byB2YWx1ZXMu
DQo+ICsJCSAqLw0KPiArCQlpZiAoY3RybC0+Y3RybF9jb25maWcgJiBOVk1FX0NDX0NSSU1F
KQ0KPiArCQkJcmVhZHlfdGltZW91dCA9IE5WTUVfQ1JUT19DUklNVChjcnRvKTsNCj4gKwkJ
ZWxzZQ0KPiArCQkJcmVhZHlfdGltZW91dCA9IE5WTUVfQ1JUT19DUldNVChjcnRvKTsNCj4g
Kw0KPiArCQlpZiAocmVhZHlfdGltZW91dCA8IHRpbWVvdXQpDQo+ICsJCQlkZXZfd2Fybl9v
bmNlKGN0cmwtPmRldmljZSwgImJhZCBjcnRvOiV4IGNhcDolbGx4XG4iLA0KPiArCQkJCSAg
ICAgIGNydG8sIGN0cmwtPmNhcCk7DQo+ICsJCWVsc2UNCj4gKwkJCXRpbWVvdXQgPSByZWFk
eV90aW1lb3V0Ow0KPiArCX0NCj4gKw0KPiAgIAljdHJsLT5jdHJsX2NvbmZpZyB8PSBOVk1F
X0NDX0VOQUJMRTsNCj4gICAJcmV0ID0gY3RybC0+b3BzLT5yZWdfd3JpdGUzMihjdHJsLCBO
Vk1FX1JFR19DQywgY3RybC0+Y3RybF9jb25maWcpOw0KPiAgIAlpZiAocmV0KQ0KDQpUaGFu
a3MsIHZlcmlmaWVkIHRoYXQgaXQgd29ya3Mgd2VsbCBoZXJlLg0KDQpJIG5vdGljZWQgb25s
eSBvbmUgdmVyeSBzbWFsbCBpc3N1ZTogZGV2X3dhcm5fb25jZSBzZWVtcyB0byBvbmx5IHBy
aW50IA0Kb25jZSB3aGVuIG11bHRpcGxlIGRldmljZXMgYXJlIGFmZmVjdGVkLiBJdCBtYXkg
YmUgbW9yZSBpZGVhbCBpZiBpdCANCnByaW50cyBvbmNlIGZvciBlYWNoIGRldmljZSwgYnV0
IEkgZG9uJ3Qga25vdyBob3cgdG8gcmVhbGx5IGFjaGlldmUgdGhhdC4uLg0KDQotLSANClJl
Z2FyZHMsDQpGZWxpeCBZYW4NCg0K

--------------wwuRpET0ElFPKeRQ8rkp8WOD--

--------------ppRiPWleYur8X8XZFUS1AtwL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmUDY6cFAwAAAAAACgkQeGxj8zDXy5Jv
kA/9GqdOq8LwTMuKfHJVWfwWxxTi82iv34BfqhkEo0vKmylEGFI3KtYAibHJjM4VAjqqNvFFQC/k
VY9wM2hgsv+1GGJxqX1hFu12JtG8sLiiBuwxGbNf/dw7MQKT/74zb+9eeKxJlcb46XVPtogVobMZ
6SIJyyCAqaA/DBYjTo3+fvmJRl2NXtNEukGqjSinR8YrFFeBap3mdk/IgaYBN2UMQTcpjuu4YrJ/
GXZPxfOc2xnsgEY14bc7B9kGd+VU3U1accw+N+ZWoX8vRx5B4KCTKh59ZQ1RmidTyl8kLo+VXc77
CnxPS2cQ7E4KNjJYiATVmr9d/XrXl/TP1jsshIG3J+HeHl33yATikelSdxeeoczgR/xEZVYrU/ya
4FeGRkaRPKeH8xQOuu2dIv+o6DmZJz/MhzPFkYOEjVqE27Z7BhbZCgqRk4zqAuGiAGjfW2JDpHym
ZGUeEVY2Z4WAH6hEp4NqDITDeEs3HVy7jbAOAjow0DY8f55Rbww+DsquzUomdEtkOGc7D9fMXZcR
qd9JFSxz4VebiAy6cujCRPgIOimDxC2fj8HZdWnM/DJvyJJMlDiuoV/bZ1s/P6DprFLwryyRcyRw
Oz+OoqpQAeFIJrh1mfq5xbkwqXmcJFnUwnJp2cfp9kkA/tnrM9xhJc2WJ4DJfmzkgjWqcYniivxR
PpQ=
=hP+e
-----END PGP SIGNATURE-----

--------------ppRiPWleYur8X8XZFUS1AtwL--
