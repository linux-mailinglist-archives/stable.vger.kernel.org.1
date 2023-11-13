Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA97E9965
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 10:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjKMJtI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 13 Nov 2023 04:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjKMJtH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 13 Nov 2023 04:49:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506DF10D
        for <stable@vger.kernel.org>; Mon, 13 Nov 2023 01:49:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A9E491F6E6;
        Mon, 13 Nov 2023 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699868942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=eJ1XxVjUPdIch79xOrWvKprVhBF71uCYC38FSHapmMI=;
        b=j4FyAbuA6SU/as4QIcx8NLvHoMLgPeQWubZNMZnIPAQbsRGndyYnihuhf2WNLH+7iIyiHQ
        e7ZrcZXw3cV5DzcBtofkw4o1z2n7ecR2mnPrHZKmQHnc3V+xaXs6v1HGOqZOXASZPfPYID
        846i5jCC8UTfmnU9xCdgeECiSuEotlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699868942;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=eJ1XxVjUPdIch79xOrWvKprVhBF71uCYC38FSHapmMI=;
        b=18aEWIss2ZSD8sCrWyxKpNSC3bIkTQDUG8cBN0W/W+a7AkCQC6ZksWH9pDIp9dkacTeIwm
        qJckO4Lec3+ChJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7786213398;
        Mon, 13 Nov 2023 09:49:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5I8DGw7xUWUmGAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 13 Nov 2023 09:49:02 +0000
Message-ID: <9dc39636-ff41-44d7-96cb-f954008bfc9d@suse.de>
Date:   Mon, 13 Nov 2023 10:49:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete stable drm/ast backport - screen freeze on boot
Content-Language: en-US
To:     Jocelyn Falempe <jfalempe@redhat.com>,
        Keno Fischer <keno@juliahub.com>, stable@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     sashal@kernel.org, airlied@redhat.com,
        dri-devel@lists.freedesktop.org, regressions@lists.linux.dev
References: <CABV8kRwx=92ntPW155ef=72z6gtS_NPQ9bRD=R1q_hx1p7wy=g@mail.gmail.com>
 <32a25774-440c-4de3-8836-01d46718b4f8@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <32a25774-440c-4de3-8836-01d46718b4f8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------O4ekZA3FmvbKuf3X5OfBT0UV"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------O4ekZA3FmvbKuf3X5OfBT0UV
Content-Type: multipart/mixed; boundary="------------gs6Xbxwa7Czd2l52BEOTMYxI";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Jocelyn Falempe <jfalempe@redhat.com>, Keno Fischer <keno@juliahub.com>,
 stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc: sashal@kernel.org, airlied@redhat.com, dri-devel@lists.freedesktop.org,
 regressions@lists.linux.dev
Message-ID: <9dc39636-ff41-44d7-96cb-f954008bfc9d@suse.de>
Subject: Re: Incomplete stable drm/ast backport - screen freeze on boot
References: <CABV8kRwx=92ntPW155ef=72z6gtS_NPQ9bRD=R1q_hx1p7wy=g@mail.gmail.com>
 <32a25774-440c-4de3-8836-01d46718b4f8@redhat.com>
In-Reply-To: <32a25774-440c-4de3-8836-01d46718b4f8@redhat.com>

--------------gs6Xbxwa7Czd2l52BEOTMYxI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

KGNjOiBncmVna2gpDQoNCkhpIEpvY2VseW4NCg0KQW0gMTMuMTEuMjMgdW0gMTA6MzYgc2No
cmllYiBKb2NlbHluIEZhbGVtcGU6DQo+IE9uIDEzLzExLzIwMjMgMDk6MzQsIEtlbm8gRmlz
Y2hlciB3cm90ZToNCj4+IEdyZWV0aW5ncywNCj4+DQo+PiBXaGVuIGNvbm5lY3RlZCB0byBh
IHJlbW90ZSBtYWNoaW5lIHZpYSB0aGUgQk1DIEtWTSBmdW5jdGlvbmFsaXR5LA0KPj4gSSBh
bSBleHBlcmllbmNpbmcgc2NyZWVuIGZyZWV6ZXMgb24gYm9vdCB3aGVuIHVzaW5nIDYuNSBz
dGFibGUsDQo+PiBidXQgbm90IG1hc3Rlci4NCj4+DQo+PiBUaGUgQk1DIG9uIHRoZSBtYWNo
aW5lIGluIHF1ZXN0aW9uIGlzIGFuIEFTcGVlZCBBU1QyNjAwLg0KPj4gQSBxdWljayBiaXNl
Y3Qgc2hvd3MgdGhlIHByb2JsZW1hdGljIGNvbW1pdCB0byBiZSAyZmI5NjY3DQo+PiAoImRy
bS9hc3Q6IHJlcG9ydCBjb25uZWN0aW9uIHN0YXR1cyBvbiBEaXNwbGF5IFBvcnQuIikuDQo+
PiBUaGlzIGlzIGNvbW1pdCBmODFiYjBhYyB1cHN0cmVhbS4NCj4+DQo+PiBJIGJlbGlldmUg
dGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgcHJldmlvdXMgY29tbWl0IGluIHRoZSBzZXJpZXMN
Cj4+IGUzMjljYjUgKCJkcm0vYXN0OiBBZGQgQk1DIHZpcnR1YWwgY29ubmVjdG9yIikNCj4+
IHdhcyBub3QgYmFja3BvcnRlZCB0byB0aGUgc3RhYmxlIGJyYW5jaC4NCj4+IEFzIGEgY29u
c2VxdWVuY2UsIGl0IGFwcGVhcnMgdGhhdCB0aGUgbW9yZSBhY2N1cmF0ZSBEUCBzdGF0ZSBk
ZXRlY3Rpb24NCj4+IGlzIGNhdXNpbmcgdGhlIGtlcm5lbCB0byBiZWxpZXZlIHRoYXQgbm8g
ZGlzcGxheSBpcyBjb25uZWN0ZWQsDQo+PiBldmVuIHdoZW4gdGhlIEJNQydzIHZpcnR1YWwg
ZGlzcGxheSBpcyBpbiBmYWN0IGluIHVzZS4NCj4+IEEgY2hlcnJ5LXBpY2sgb2YgZTMyOWNi
NSBvbnRvIHRoZSBzdGFibGUgYnJhbmNoIHJlc29sdmVzIHRoZSBpc3N1ZS4NCj4gDQo+IFll
cywgeW91J3JlIHJpZ2h0IHRoaXMgdHdvIHBhdGNoZXMgbXVzdCBiZSBiYWNrcG9ydGVkIHRv
Z2V0aGVyLg0KPiANCj4gSSdtIHNvcnJ5IEkgZGlkbid0IHBheSBlbm91Z2ggYXR0ZW50aW9u
LCB0aGF0IG9ubHkgb25lIG9mIHRoZSB0d28gd2FzIA0KPiBwaWNrZWQgdXAgZm9yIHRoZSBz
dGFibGUgYnJhbmNoLg0KPiANCj4gSXMgaXQgcG9zc2libGUgdG8gYmFja3BvcnQgZTMyOWNi
NSB0byB0aGUgc3RhYmxlIGJyYW5jaCwgb3Igc2hvdWxkIEkgDQo+IHB1c2ggaXQgdG8gZHJt
LW1pc2MtZml4ZXMgPw0KDQpJIHRoaW5rIHN0YWJsZSwgd2hpY2ggaXMgaW4gY2MsIHdpbGwg
cGljayB1cCBjb21taXQgZTMyOWNiNSANCnNlbWktYXV0b21hdGljYWxseSBub3cuIE90aGVy
d2lzZSwgbWF5YmUgcGluZyBncmVna2ggaW4gYSBmZXcgZGF5cyBhYm91dCBpdC4NCg0KQmVz
dCByZWdhcmRzDQpUaG9tYXMNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiANCg0KLS0gDQpU
aG9tYXMgWmltbWVybWFubg0KR3JhcGhpY3MgRHJpdmVyIERldmVsb3Blcg0KU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJIDQpGcmFua2Vuc3RyYXNzZSAxNDYsIDkwNDYx
IE51ZXJuYmVyZywgR2VybWFueQ0KR0Y6IEl2byBUb3RldiwgQW5kcmV3IE15ZXJzLCBBbmRy
ZXcgTWNEb25hbGQsIEJvdWRpZW4gTW9lcm1hbg0KSFJCIDM2ODA5IChBRyBOdWVybmJlcmcp
DQo=

--------------gs6Xbxwa7Czd2l52BEOTMYxI--

--------------O4ekZA3FmvbKuf3X5OfBT0UV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmVR8Q0FAwAAAAAACgkQlh/E3EQov+Az
OxAAlavDdzFJiGFtFVc7iTpzWgu233Ia5HOnF708ieC9ZdRl4sCQXLTFOyRRTc+Ld8tZgJGIioj+
GKw6Rtah1Mopy4+xAVscD7VBWKDZudsWO1zaDPRYwocZU+KFvO18vCVZgRu5pud/VEIdIXXZF6jR
KA59iWexm4dgd5kDItvwknwNjlkSJrn8ByugzaGcsytKNtYgaD/f3U8mlri27yEQ8aVUYUvjssrE
XoFymBoL8EuMAV0Ll0DAmPzmqiP0ClyU1t5dR6XSxbm2sWWl8zqupgJiYerjixDDyEXneA+mFNn7
0yQ4k4iPBdjAMTOUKivj3EmIaOuelt8yfmq1XxnqwIWKQNfc+UUbdWGAl8MVIbpD/BwHQK2WprE+
BWB3AcMcejfA0DtwnX6q68LNawgpZTdyN0reQ4wEHU7hjR38TQI+3KElJz2M4zQKgOkwujBtxBei
nUB56tH9qy1ikiLIILI833UjuzOxNEDyJTbxfHIM+C/OBVifgawp8ZOx8CH896mb6F2JFQMsBRDi
wWx56ilXtpg9hGUG80LNHWyoql52WFyn+PapBX1pyF4WKV857MQT3YNwILw1L4BpyKaqlx85s85D
1J0ANLSs/YIXCr3xxEuBKmA4sym2fkFMYS4Z56nwxXN1LZPepx0XXGL01QOO3PPomQE4clqNdXXV
hK0=
=Amj3
-----END PGP SIGNATURE-----

--------------O4ekZA3FmvbKuf3X5OfBT0UV--
