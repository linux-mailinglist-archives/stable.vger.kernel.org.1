Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4216FDA7D
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjEJJPm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 10 May 2023 05:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjEJJPk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 10 May 2023 05:15:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BE930CF
        for <stable@vger.kernel.org>; Wed, 10 May 2023 02:15:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42EDE219F8;
        Wed, 10 May 2023 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683710136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2E3B7UCZEK+yd6Abi3HxDEbHxV/uOyadhCzRHgJYa4=;
        b=CV50ljoMj1yefTb2u1WLwF2lpdSoQ2QS4DIO46O3pLj+dxT8m0rsJczULlsNnXo3stTLZP
        8IH9cNWHzXfzqeXk6T94TqzGcOfEv7IMagWt7R7DsROPYQCUNQd9KFi5KKjMlGm841JFT/
        M43UkYfHTwFRN73pdwm3YuzuP6vsXBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683710136;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q2E3B7UCZEK+yd6Abi3HxDEbHxV/uOyadhCzRHgJYa4=;
        b=OtSP9+KoPeBst0+M0EygDIXHM2WTCvMM0rcxxmeXtErHPDzeAdkU76hMYGEFixe2xpaTFe
        we1n2wm898mVxEDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C3FF138E5;
        Wed, 10 May 2023 09:15:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xpziBbhgW2QECQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 10 May 2023 09:15:36 +0000
Message-ID: <3efea3e4-09e2-a9f6-a4a2-365b48b1e63b@suse.de>
Date:   Wed, 10 May 2023 11:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] drm/mgag200: Fix gamma lut not initialized.
To:     Jocelyn Falempe <jfalempe@redhat.com>,
        dri-devel@lists.freedesktop.org, airlied@redhat.com,
        javierm@redhat.com, lyude@redhat.com
Cc:     Phil Oester <kernel@linuxace.com>, stable@vger.kernel.org
References: <20230510085451.226546-1-jfalempe@redhat.com>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230510085451.226546-1-jfalempe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4bEn7bXcdCOPa8tBeKe4eW6J"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4bEn7bXcdCOPa8tBeKe4eW6J
Content-Type: multipart/mixed; boundary="------------cWUgerY3RYcUmqupyIMpRQtd";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 airlied@redhat.com, javierm@redhat.com, lyude@redhat.com
Cc: Phil Oester <kernel@linuxace.com>, stable@vger.kernel.org
Message-ID: <3efea3e4-09e2-a9f6-a4a2-365b48b1e63b@suse.de>
Subject: Re: [PATCH] drm/mgag200: Fix gamma lut not initialized.
References: <20230510085451.226546-1-jfalempe@redhat.com>
In-Reply-To: <20230510085451.226546-1-jfalempe@redhat.com>

--------------cWUgerY3RYcUmqupyIMpRQtd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCm9oIGdyZWF0ISBUaGFuayB5b3UgZm9yIGZpeGluZyB0aGlzIGJ1Zy4gQW5kIHNv
cnJ5IHRoYXQgSSBicm9rZSBpdC4NCg0KQW0gMTAuMDUuMjMgdW0gMTA6NTQgc2NocmllYiBK
b2NlbHluIEZhbGVtcGU6DQo+IFdoZW4gbWdhZzIwMCBzd2l0Y2hlZCBmcm9tIHNpbXBsZSBL
TVMgdG8gcmVndWxhciBhdG9taWMgaGVscGVycywNCj4gdGhlIGluaXRpYWxpemF0aW9uIG9m
IHRoZSBnYW1tYSBzZXR0aW5ncyB3YXMgbG9zdC4NCj4gVGhpcyBsZWFkcyB0byBhIGJsYWNr
IHNjcmVlbiwgaWYgdGhlIGJpb3MvdWVmaSBkb2Vzbid0IHVzZSB0aGUgc2FtZQ0KPiBwaXhl
bCBjb2xvciBkZXB0aC4NCj4gDQo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNv
bS9zaG93X2J1Zy5jZ2k/aWQ9MjE3MTE1NQ0KPiBGaXhlczogMWJhZjkxMjdjNDgyICgiZHJt
L21nYWcyMDA6IFJlcGxhY2Ugc2ltcGxlLUtNUyB3aXRoIHJlZ3VsYXIgYXRvbWljIGhlbHBl
cnMiKQ0KPiBUZXN0ZWQtYnk6IFBoaWwgT2VzdGVyIDxrZXJuZWxAbGludXhhY2UuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBKb2NlbHluIEZhbGVtcGUgPGpmYWxlbXBlQHJlZGhhdC5jb20+
DQoNCkFsc28gbmVlZHM6DQoNCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni4x
Kw0KDQpJbiB0ZXJtcyBvZiB3aGF0IGl0IGRvZXM6DQoNClJldmlld2VkLWJ5OiBUaG9tYXMg
WmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4NCg0KYnV0IHRoZSBwYXRjaCBpcyBh
cHBhcmVudGx5IGZvciBhZ2FpbnN0IGFuIG9sZCB2ZXJzaW9uLiAodjYuMT8pIFRoZSBjb2Rl
IA0KaW4gbWdhZzIwMF9jcnRjX2hlbHBlcl9hdG9taWNfZW5hYmxlIGhhcyBjaGFuZ2VkIHF1
aXRlIGEgYml0Lg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IC0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9tZ2FnMjAwL21nYWcyMDBfbW9kZS5jIHwgNSArKysrKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX21vZGUuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZ2Fn
MjAwL21nYWcyMDBfbW9kZS5jDQo+IGluZGV4IDQ2MWRhMTQwOWZkZi4uOTExZDQ2NzQxZTQw
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX21vZGUu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWdhZzIwMC9tZ2FnMjAwX21vZGUuYw0KPiBA
QCAtODE5LDYgKzgxOSwxMSBAQCBzdGF0aWMgdm9pZCBtZ2FnMjAwX2NydGNfaGVscGVyX2F0
b21pY19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiAgIAllbHNlIGlmIChtZGV2
LT50eXBlID09IEcyMDBfRVYpDQo+ICAgCQltZ2FnMjAwX2cyMDBldl9zZXRfaGlwcmlsdmwo
bWRldik7DQo+ICAgDQo+ICsJaWYgKGNydGNfc3RhdGUtPmdhbW1hX2x1dCkNCj4gKwkJbWdh
ZzIwMF9jcnRjX3NldF9nYW1tYShtZGV2LCBmb3JtYXQsIGNydGNfc3RhdGUtPmdhbW1hX2x1
dC0+ZGF0YSk7DQo+ICsJZWxzZQ0KPiArCQltZ2FnMjAwX2NydGNfc2V0X2dhbW1hX2xpbmVh
cihtZGV2LCBmb3JtYXQpOw0KPiArDQo+ICAgCW1nYWcyMDBfZW5hYmxlX2Rpc3BsYXkobWRl
dik7DQo+ICAgDQo+ICAgCWlmIChtZGV2LT50eXBlID09IEcyMDBfV0IgfHwgbWRldi0+dHlw
ZSA9PSBHMjAwX0VXMykNCj4gDQo+IGJhc2UtY29tbWl0OiAxYmFmOTEyN2M0ODJhM2E1OGFl
ZjgxZDkyYWU3NTE3OThlMmRiMjAyDQoNCi0tIA0KVGhvbWFzIFppbW1lcm1hbm4NCkdyYXBo
aWNzIERyaXZlciBEZXZlbG9wZXINClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkg
R21iSA0KRnJhbmtlbnN0cmFzc2UgMTQ2LCA5MDQ2MSBOdWVybmJlcmcsIEdlcm1hbnkNCkdG
OiBJdm8gVG90ZXYsIEFuZHJldyBNeWVycywgQW5kcmV3IE1jRG9uYWxkLCBCb3VkaWVuIE1v
ZXJtYW4NCkhSQiAzNjgwOSAoQUcgTnVlcm5iZXJnKQ0K

--------------cWUgerY3RYcUmqupyIMpRQtd--

--------------4bEn7bXcdCOPa8tBeKe4eW6J
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmRbYLcFAwAAAAAACgkQlh/E3EQov+BF
lQ//dt4c/YLy9dzZS898z+pqogTxGWUazCHNJosRNyF0xaQpcvYH/HPGhLPySbuwfYYcgeufv3gv
7wGFb95YgAQoRAZFABTYPZ5MeAYqHfNMEw4R9anfEr+Xrh9kZiQmLFy5AAnKXNFWzoAa+UuLK1oJ
9d4Ja0bsJra38ZsiI1Q8U+HrNqg6qwFy86d/Bt4uArGa9zvv2UD/e7RwVZdg3IREhdkzko25VUv9
byUgzCh4oyJEpIDWnlF/v2KxAxR2GIDueQ0i9Obgg1otDp1Ueaee9OD4uuTrbA8SWKxswgyLPH/B
uruXmMuD2aodz2HNX90pSdI3TDg0PveVZrpb5ltIAg7mmV+6pmdCSNIJsTstdFMWH610IvrgFMUT
8p4mYbs3ZZU4P5hW1XAwmpy4yMfJH+MXZxIJUPbz62gsuQxPWXI9TpZA5MYFoPzU1zGEkhgJPVtx
pjEQbBuxOAXvtV6t+hfMGN9Q1/rmBUOFe6d/kGAvtM9Wr8caBSu2VZD8WCwuStFwJSfQBE9tvfVS
97fJmo/0mJsxY+Ce6/tUOGJPjo1HR+TfpkqQcPBcSmFIliebQmiKSx9lIvWj9bOFh3nxZx50Ao9Y
2rtkOKIuEBKVikXmwe3nBtH34jC0VOeIcV2nyNGQk80sKbMSI6IFXXo6KcLnHlUaUvMKJb/Y+LEE
T28=
=JrD4
-----END PGP SIGNATURE-----

--------------4bEn7bXcdCOPa8tBeKe4eW6J--
