Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99F67A0EB9
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjINUHe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjINUHd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 16:07:33 -0400
X-Greylist: delayed 1106 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 13:07:28 PDT
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B9B26BC
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 13:07:28 -0700 (PDT)
Message-ID: <a20e76c4-5fb4-41c9-8dc1-59a197838c47@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694722046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DCgKLMy9qvO8lS7Qp2PDjr0RDp8ymv3FRohZ9pSj9Hs=;
        b=QKaDvpexZExza4syKftnwttiIe5ja2ol6GIjKOgrakLBNQpR/B42fUuUhgKTZwTjoMlB7d
        uyqAbq+cbzQO5c8PxkQHDyBr29AuHIu9X/6iXh7af7G4WbhmiAZwNQZ4BnXDCAzuTbGZLl
        VeatwzCLXDqgi+ryGu/JBEUD4AOfiXJy3PsXa69dVg1gQdP4B6ofUaCRX9fM53uLat7ZJ8
        dh1Tj5ogDM6VK1Q5BpuojkjuN47z/uEOewBvQx4/rr0w+w1FU80V8MloD6bk/pM8LVpV/u
        aqGyAFF7YkgEouOQFU6zXUOt6r4iSOxLgnLMeWbjkzWnVTXXvHQqi18t1atJ7SYq87UC61
        xbIfoW7MnBKNASLukuWQcpdD0BugD55qb5UVx9ylXgxZLTDbyxfAdUdqby1pQZGEVLNdoL
        zmbKodzaV87EI9IDg8C1uo9+97I0Uhj4q3bA8iJt69CNLVMAk5O6o0fXW9FJnLVTza8/ga
        Uj1H/2DDDvlw9ANRbpl8NB+7fO/kqD7NOI6lovO3qkjdi1YCfqj6Id00rdGJMD/ZdBZ3Ap
        MhaF0i3BJP+fwOcDaa+w0MGgGuE0e1N8hiRm7+muDtygJjo9LF2b4zkQ6JSGeUyOFaENuG
        b6yGXQPoyAofH3HBxKgt31fJgaPTgDUGTUeZcx7BvLkQ6ekQqHauU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694722046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DCgKLMy9qvO8lS7Qp2PDjr0RDp8ymv3FRohZ9pSj9Hs=;
        b=plqMf3gVXGOzziiD3GyqELNVGoACNseD8hl4Njk+4FqyTUqZfjAS+BzvRkNWIngYYlm7qK
        ekgtVU0EtAHizdDw==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date:   Thu, 14 Sep 2023 23:07:23 +0300
MIME-Version: 1.0
Subject: Re: [PATCHv2] nvme: avoid bogus CRTO values
Content-Language: en-US-large
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
        hch@lst.de, =?UTF-8?Q?Cl=C3=A1udio_Sampaio?= <patola@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
References: <20230913202810.2631288-1-kbusch@meta.com>
 <536c792d-984c-439b-8ee9-25b1bfc5c791@archlinux.org>
 <ZQNl0WMd9E8obFcs@kbusch-mbp>
From:   Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <ZQNl0WMd9E8obFcs@kbusch-mbp>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Iy5g7lxavsPxxan0ZeK5l8OY"
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Iy5g7lxavsPxxan0ZeK5l8OY
Content-Type: multipart/mixed; boundary="------------7AI7dNAN2YwzmtKs0rUkT90J";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, =?UTF-8?Q?Cl=C3=A1udio_Sampaio?= <patola@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Message-ID: <a20e76c4-5fb4-41c9-8dc1-59a197838c47@archlinux.org>
Subject: Re: [PATCHv2] nvme: avoid bogus CRTO values
References: <20230913202810.2631288-1-kbusch@meta.com>
 <536c792d-984c-439b-8ee9-25b1bfc5c791@archlinux.org>
 <ZQNl0WMd9E8obFcs@kbusch-mbp>
In-Reply-To: <ZQNl0WMd9E8obFcs@kbusch-mbp>

--------------7AI7dNAN2YwzmtKs0rUkT90J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS8xNC8yMyAyMjo1OCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFRodSwgU2VwIDE0
LCAyMDIzIGF0IDEwOjQ4OjU1UE0gKzAzMDAsIEZlbGl4IFlhbiB3cm90ZToNCj4+DQo+PiBU
aGFua3MsIHZlcmlmaWVkIHRoYXQgaXQgd29ya3Mgd2VsbCBoZXJlLg0KPiANCj4gVGhhbmtz
LCBva2F5IGlmIEkgYXBwZW5kIHlvdXIgVGVzdGVkLWJ5OiBpbiB0aGUgcGF0Y2g/DQoNClN1
cmUgOikNCg0KPj4gSSBub3RpY2VkIG9ubHkgb25lIHZlcnkgc21hbGwgaXNzdWU6IGRldl93
YXJuX29uY2Ugc2VlbXMgdG8gb25seSBwcmludCBvbmNlDQo+PiB3aGVuIG11bHRpcGxlIGRl
dmljZXMgYXJlIGFmZmVjdGVkLiBJdCBtYXkgYmUgbW9yZSBpZGVhbCBpZiBpdCBwcmludHMg
b25jZQ0KPj4gZm9yIGVhY2ggZGV2aWNlLCBidXQgSSBkb24ndCBrbm93IGhvdyB0byByZWFs
bHkgYWNoaWV2ZSB0aGF0Li4uDQo+IA0KPiBUaGVyZSdzIG5vIGdvb2Qgd2F5IHRvIGRvIHRo
YXQsIHVuZm9ydHVuYXRlbHkuIFdlJ2QgaGF2ZSB0byBjcmVhdGUgYQ0KPiBjdXN0b20gInBy
aW50IG9uY2UiIGJhc2VkIG9uIHNvbWUgZHJpdmVyIHNwZWNpZmljIGZsYWcgZm9yIHRoaXMg
cGF0aCwNCj4gYnV0IHRoYXQncyBvdmVya2lsbCBmb3IgdGhpcyBpc3N1ZSwgSU1PLiBJIGZl
ZWwgaXQgc2hvdWxkIGJlIHN1ZmZpY2llbnQNCj4ganVzdCB0byBrbm93IHRoYXQgdGhlIGZh
bGxiYWNrIGlzIGhhcHBlbmluZywgYW5kIGRvZXNuJ3QgcmVhbGx5IG1hdHRlcg0KPiBmb3Ig
YW4gYWRtaW4gc2Nhbm5pbmcgdGhlIGxvZ3MgdG8gc2VlIGl0IGFwcGVhciBmb3IgZWFjaCBk
ZXZpY2UuIE15IG1haW4NCj4gY29uY2VybiB3YXMgcHJpbnRpbmcgaXQgb24gZXZlcnkgcmVz
ZXQ7IHRoYXQgbGV2ZWwgb2YgcmVwaXRpdGlvbiB3b3VsZA0KPiBkZWZpbml0ZWx5IGNhdXNl
IGFsYXJtIGZvciBzb21lIHBlb3BsZS4NCg0KSSBzZWUuIEknbSBva2F5IHdpdGggdGhlIGN1
cnJlbnQgc29sdXRpb24gdGhlbi4NCg0KLS0gDQpSZWdhcmRzLA0KRmVsaXggWWFuDQoNCg==


--------------7AI7dNAN2YwzmtKs0rUkT90J--

--------------Iy5g7lxavsPxxan0ZeK5l8OY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmUDZ/wFAwAAAAAACgkQeGxj8zDXy5Kz
nQ/+MPNwCtrANAIeD6ETFJp3wUP0eKRRDINlVsoqZEm/bR3LAO04lz/UvhhBMKBlZsJrxnMX6ix3
r9YBW4YNL6XVqlvL7GA9fSlvYNJpej2LsCgKYXqur7XRDZtiL+YRZGwUmTzwBQbjkDHs1fnVXsRj
oH0tyerWs0QmIGc3MqNsZ8oMpqEcDCAy7wY+9hRJw4hjxElTi/OHjm0m8cAwaaj1QX1NK8hMI3ou
bFQwQbhtAP1di8ZNiqa/zkVRN2NUilPN5yjWkXBOTyskN+Qb1ZAh7T3XrWEqDG8kuRbgU554Y7fK
7Pt8jlTf7jgPPVyZrAs82lfn1OschqHNaD3sAlyPJM1L8i+GVFCyzN9ERbBY/sMIbqjHojS+x85f
BH4X234aJupQzALTOUg9exRIACU97VcZziO/3kqMN+p02xC0NxHIAokcnOCo+Ea5hKF7kV+M1oie
GTKGhgfcqgjLAYe1z2nqhv8/GcRPrMRJUv8WdG13/O15BYuMpKhNOUGvnuLpracbwkOZ5c+zEHOG
Wm5msrq0NNLSprUDpdosuBGPNeKN4voVQ/mutiOseVYL6O114gxYyHfWjKDSlVO1EcLd5FtqxZwD
Zq0/Jeq86CXKkWLzGY2ihxO0yAGGIwiwn5I7C6v0AUCbpusedwn0WUjQI+Ady449NfAo4Lg90nTv
1is=
=oZq4
-----END PGP SIGNATURE-----

--------------Iy5g7lxavsPxxan0ZeK5l8OY--
