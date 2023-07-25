Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A8E7621C8
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 20:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGYSur (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGYSur (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 14:50:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297C619AD
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:50:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD51F1F38C;
        Tue, 25 Jul 2023 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690311044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yflSHrM/7ZrA3cNrHkIst3Ykk290hSPumnqNEi5LzRs=;
        b=ZbBsGU11PvT1+oIS5U9p2+uZmPe3NrsR9Xyc4hTM2tsnXy1wqOA2aPT1aHlPDDEGyUprD+
        Fk4D58VKfaVdSDhe54bN7KqqGvPoz8BQfTD+vKC9c2X1qZ9ks6C2GsdcFZuzRJn3h3AGd5
        XCR+vxPdDBkUz24l3eXV60aqNKPRQd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690311044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yflSHrM/7ZrA3cNrHkIst3Ykk290hSPumnqNEi5LzRs=;
        b=Ku61Mn4xUD++n+ZcI0f300XV2tADC+3q4hvNzOsp/PFeAG9dEA1ZXSrIeYRZhO/jSlzPsu
        /R25oZaCicIPmxCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAB1613487;
        Tue, 25 Jul 2023 18:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bLOOLIQZwGQ9fgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 25 Jul 2023 18:50:44 +0000
Message-ID: <77a41226-b671-1895-6182-457f7fee9bda@suse.de>
Date:   Tue, 25 Jul 2023 20:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/shmem-helper: Reset vma->vm_ops before calling
 dma_buf_mmap()
Content-Language: en-US
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
References: <20230724112610.60974-1-boris.brezillon@collabora.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230724112610.60974-1-boris.brezillon@collabora.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2RAtmm0UdYst3US6QvqHJVbd"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2RAtmm0UdYst3US6QvqHJVbd
Content-Type: multipart/mixed; boundary="------------ivtOjhe6YB0FypaNcq46p9vk";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org,
 Roman Stratiienko <roman.stratiienko@globallogic.com>
Message-ID: <77a41226-b671-1895-6182-457f7fee9bda@suse.de>
Subject: Re: [PATCH] drm/shmem-helper: Reset vma->vm_ops before calling
 dma_buf_mmap()
References: <20230724112610.60974-1-boris.brezillon@collabora.com>
In-Reply-To: <20230724112610.60974-1-boris.brezillon@collabora.com>

--------------ivtOjhe6YB0FypaNcq46p9vk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjQuMDcuMjMgdW0gMTM6MjYgc2NocmllYiBCb3JpcyBCcmV6aWxsb246DQo+
IFRoZSBkbWEtYnVmIGJhY2tlbmQgaXMgc3VwcG9zZWQgdG8gcHJvdmlkZSBpdHMgb3duIHZt
X29wcywgYnV0IHNvbWUNCj4gaW1wbGVtZW50YXRpb24ganVzdCBoYXZlIG5vdGhpbmcgc3Bl
Y2lhbCB0byBkbyBhbmQgbGVhdmUgdm1fb3BzDQo+IHVudG91Y2hlZCwgcHJvYmFibHkgZXhw
ZWN0aW5nIHRoaXMgZmllbGQgdG8gYmUgemVybyBpbml0aWFsaXplZCAodGhpcw0KPiBpcyB0
aGUgY2FzZSB3aXRoIHRoZSBzeXN0ZW1faGVhcCBpbXBsZW1lbnRhdGlvbiBmb3IgaW5zdGFu
Y2UpLg0KPiBMZXQncyByZXNldCB2bWEtPnZtX29wcyB0byBOVUxMIHRvIGtlZXAgdGhpbmdz
IHdvcmtpbmcgd2l0aCB0aGVzZQ0KPiBpbXBsZW1lbnRhdGlvbnMuDQoNClRoYW5rcyBmb3Ig
eW91ciBwYXRjaC4gVGhpcyBidWcgY291bGQgYWZmZWN0IGEgbnVtYmVyIG9mIEdFTSANCmlt
cGxlbWVudGF0aW9ucy4gSW5zdGVhZCBvZiBmaXhpbmcgdGhpcyBpbmRpdmlkdWFsbHksIGNv
dWxkIHdlIHNldCB0aGUgDQpmaWVsZHMgY29uZGl0aW9uYWxseSBhdA0KDQogDQpodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni40L3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2dlbS5jI0wxMDQyDQoNCj8NCg0KU29tZXRoaW5nIGxpa2UNCg0KICAgaWYgKCFvYmpl
Y3QtPmltcG9ydF9hdHRhY2gpIHsNCiAgICAgdm1hLT5wcml2ID0NCiAgICAgdm1hLT5vcHMg
PQ0KICAgfQ0KDQpwbHVzIGEgZGVzY3JpcHRpdmUgY29tbWVudCBsaWtlIHRoZSBvbmUgeW91
IGhhdmUgaW4geW91ciBwYXRjaC4NCg0KQmVzdCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCj4g
Rml4ZXM6IDI2ZDNhYzNjYjA0ZCAoImRybS9zaG1lbS1oZWxwZXJzOiBSZWRpcmVjdCBtbWFw
IGZvciBpbXBvcnRlZCBkbWEtYnVmIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3Jn
Pg0KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4NCj4gUmVw
b3J0ZWQtYnk6IFJvbWFuIFN0cmF0aWllbmtvIDxyb21hbi5zdHJhdGlpZW5rb0BnbG9iYWxs
b2dpYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJl
emlsbG9uQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9kcm1f
Z2VtX3NobWVtX2hlbHBlci5jIHwgNiArKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9n
ZW1fc2htZW1faGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9zaG1lbV9oZWxw
ZXIuYw0KPiBpbmRleCA0ZWE2NTA3YTc3ZTUuLmJhYWYwZTBmZWIwNiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fc2htZW1faGVscGVyLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2RybV9nZW1fc2htZW1faGVscGVyLmMNCj4gQEAgLTYyMyw3ICs2MjMs
MTMgQEAgaW50IGRybV9nZW1fc2htZW1fbW1hcChzdHJ1Y3QgZHJtX2dlbV9zaG1lbV9vYmpl
Y3QgKnNobWVtLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QNCj4gICAJaW50IHJldDsNCj4gICAN
Cj4gICAJaWYgKG9iai0+aW1wb3J0X2F0dGFjaCkgew0KPiArCQkvKiBSZXNldCBib3RoIHZt
X29wcyBhbmQgdm1fcHJpdmF0ZV9kYXRhLCBzbyB3ZSBkb24ndCBlbmQgdXAgd2l0aA0KPiAr
CQkgKiB2bV9vcHMgcG9pbnRpbmcgdG8gb3VyIGltcGxlbWVudGF0aW9uIGlmIHRoZSBkbWEt
YnVmIGJhY2tlbmQNCj4gKwkJICogZG9lc24ndCBzZXQgdGhvc2UgZmllbGRzLg0KPiArCQkg
Ki8NCj4gICAJCXZtYS0+dm1fcHJpdmF0ZV9kYXRhID0gTlVMTDsNCj4gKwkJdm1hLT52bV9v
cHMgPSBOVUxMOw0KPiArDQo+ICAgCQlyZXQgPSBkbWFfYnVmX21tYXAob2JqLT5kbWFfYnVm
LCB2bWEsIDApOw0KPiAgIA0KPiAgIAkJLyogRHJvcCB0aGUgcmVmZXJlbmNlIGRybV9nZW1f
bW1hcF9vYmooKSBhY3F1aXJlZC4qLw0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFw
aGljcyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55
IEdtYkgNCkZyYW5rZW5zdHJhc3NlIDE0NiwgOTA0NjEgTnVlcm5iZXJnLCBHZXJtYW55DQpH
RjogSXZvIFRvdGV2LCBBbmRyZXcgTXllcnMsIEFuZHJldyBNY0RvbmFsZCwgQm91ZGllbiBN
b2VybWFuDQpIUkIgMzY4MDkgKEFHIE51ZXJuYmVyZykNCg==

--------------ivtOjhe6YB0FypaNcq46p9vk--

--------------2RAtmm0UdYst3US6QvqHJVbd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmTAGYMFAwAAAAAACgkQlh/E3EQov+CJ
Fw/+L8VLenUfBFUFhJfRDdgqlUzxi2WdsiD1wI56Pk7rYL5Fw/reJt68Na1jjvnht1mlHiAT6LUS
wdswkaDLemIurdgsM//0JB0sdMjsMG/T0AghuTOzj+zp1UvbvAw/92y92rrX6QHUagZ+ed/GigjA
zAPfwTdc2T4KapweDx8imXv/0QLGYxKugWFd6YEvQD2jdIJtZDHFPcVso5W4S2ZeFN0sGWPUJGUf
QGptSRLu7rNt9w79m5+7SiiKvmgabtWHry9/sRy1V3qr6ej7bF4lap6VDGDv1xKi97whDT7kJe2N
Hn+tNaD3M4qYBrV4eOmNtHQuUcxnDrQ5tNZTkqKAVhoCDbHk1wyBOiP1FhOC7wbJKo/656civjUf
YilTLONXQ6NbJixEd9XpINbGnIEHY06FBOzOj/xdN6t+MKoJU+tw8za7glUVFTjE6knb61lEg2+R
GBUX3vaL4uSys5t30YYYRy0Ts7rKfuzLNJ0j5qgwu4AzZEOamGQDy3DhmZJAoZyJzRJU91IqL02U
QPE3C01gHzl75MJ6shrMhHsf3DX5RiviBUP6IkS4uD2YKhEiXANBOvJU6B+Bm7HHbvij5dBd0/7n
o5534eXIMMRcAS1Py35yghnazRjHV+0L8IxbaVplYKMJ4zWpgPA1KV/qPAAEUS/Dei+vc8GAAJF1
2tE=
=UAUu
-----END PGP SIGNATURE-----

--------------2RAtmm0UdYst3US6QvqHJVbd--
