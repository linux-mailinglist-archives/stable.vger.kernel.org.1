Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736696FFB40
	for <lists+stable@lfdr.de>; Thu, 11 May 2023 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjEKU0W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbjEKU0T (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 16:26:19 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93135265
        for <stable@vger.kernel.org>; Thu, 11 May 2023 13:26:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-76c304efb8fso28105339f.1
        for <stable@vger.kernel.org>; Thu, 11 May 2023 13:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683836777; x=1686428777;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nu6ZmfGsXYKtKmIBgJ35NYo+cgmXHkC35cIp1EvsM5o=;
        b=Ezd8sK9Pw9nWMX0gXcPwUZ/s0IlhWkY/BmbAIfRoQzHqssewJDBa3Oi3zVgOFsGKk0
         NDSk/KBz6WP1qy1cYXoUFIhMjp8Lk2tf8f7mpsWtE6Qp8rP3AWoFJOnLD5xtX+YQLqmh
         nUH2zodd7XTB7ydeetFe9dDY3Z6+Dt53+nNJ1pyRayzJhsHZd9yZ6QzSsLcbs0BFJyZQ
         rONQWejiOUFivAQo8vWCNdZItMN/sxLyUQnxLrX43DDIwS1PrvUFD/OS/x/752cB1/ho
         t1FhEMw2/sA9c1utChdwghE+anU+cP6FJcnsHypHI7DAwq6Nw9kBNO6uocckXtteb9F1
         vGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683836777; x=1686428777;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nu6ZmfGsXYKtKmIBgJ35NYo+cgmXHkC35cIp1EvsM5o=;
        b=KtwfuBCYR2ERB3GKwtgzmTX1OdsjNumpqFy+wK3BLRaUctvTUPNV1Mo9Ddi7LdC1dX
         bw/3ZgfwLbG2yML7jsOD9TzrFIxYz4y7KRKFe29z+cU3olaWTB7nwwMknStHt+PHdPbY
         SeZq28PNqKh6RR+tK1wGan3Q+n2/7lfilPEUqEBqqRyfW3qor/DOrnqNKbTy8O7RyXs4
         3Ta43FT1NjP65FRNwC7tNQU1IcT22Zj8/pUqk03AmfCK3J3VY9bTeOBULAPfliT8HndK
         4/O3Y594ucppJmdKvZTf8XATzMKU6CA0d/bJmKX7M6vEOiLqzYAVoYoCCz3FcFZCE/Mh
         c2tA==
X-Gm-Message-State: AC+VfDy5+6bX7NRYGsMi3eW1j7F7atkCG8+f6Iki8egG0GwWyrmT4gXy
        AefhrJxe4Cra3z/aAwZj2x7hmdWHhaKbfNotTokSj33V
X-Google-Smtp-Source: ACHHUZ7UmWFWvv19zLwi34ajlcGT/ixziAyFQM6IkRmV5evVT5DMZEAbE1BR85tjJVwVrH2KAT31eff+vOwyvO/JETU=
X-Received: by 2002:a6b:3b49:0:b0:76c:5c79:81bf with SMTP id
 i70-20020a6b3b49000000b0076c5c7981bfmr4553008ioa.2.1683836776810; Thu, 11 May
 2023 13:26:16 -0700 (PDT)
MIME-Version: 1.0
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Thu, 11 May 2023 13:23:14 -0700
Message-ID: <CAF8JNhLT+Gk76Wwo6c3xE-7aLPTLvdfc2P-+0okpQodn3d6YCg@mail.gmail.com>
Subject: HID: wacom: insert timestamp to packed Bluetooth (BT) events
To:     "stable # v4 . 10" <stable@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000f12f6405fb70cce9"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--000000000000f12f6405fb70cce9
Content-Type: text/plain; charset="UTF-8"

Hi Stable maintainers,

This patch, ID 17d793f3ed53, inserts timestamps to Wacom bluetooth
device events. The upstream patch applies to kernels 6.1 and later as
is.

The attached patch applies to kernel 5.4 to 5.15 stable versions. Let
me know if you have other questions.

Thank you,
Ping

--000000000000f12f6405fb70cce9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-HID-wacom-insert-timestamp-to-packed-Bluetooth-BT-ev.patch"
Content-Disposition: attachment; 
	filename="0001-HID-wacom-insert-timestamp-to-packed-Bluetooth-BT-ev.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lhjktxmv0>
X-Attachment-Id: f_lhjktxmv0

RnJvbSA0NWNhNjIwZjVmZWMxZmJlN2RhZjRlMWY5ZDM2ZTMwYWE1ZTE1ZmJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaW5nIENoZW5nIDxwaW5nLmNoZW5nQHdhY29tLmNvbT4KRGF0
ZTogV2VkLCAxMCBNYXkgMjAyMyAxNzozMTowOSAtMDcwMApTdWJqZWN0OiBbUEFUQ0ggZm9yIGxv
bmd0ZXJtIDUuNC01LjE1XSBISUQ6IHdhY29tOiBpbnNlcnQgdGltZXN0YW1wIHRvIHBhY2tlZCBC
bHVldG9vdGggKEJUKSBldmVudHMKClRvIGZ1bGx5IHV0aWxpemUgdGhlIEJUIHBvbGxpbmcvcmVm
cmVzaCByYXRlLCBhIGZldyBpbnB1dCBldmVudHMKYXJlIHNlbnQgdG9nZXRoZXIgdG8gcmVkdWNl
IGV2ZW50IGRlbGF5LiBUaGlzIGNhdXNlcyBpc3N1ZSB0byB0aGUKdGltZXN0YW1wIGdlbmVyYXRl
ZCBieSBpbnB1dF9zeW5jIHNpbmNlIGFsbCB0aGUgZXZlbnRzIGluIHRoZSBzYW1lCnBhY2tldCB3
b3VsZCBwcmV0dHkgbXVjaCBoYXZlIHRoZSBzYW1lIHRpbWVzdGFtcC4gVGhpcyBwYXRjaCBpbnNl
cnRzCnRpbWUgaW50ZXJ2YWwgdG8gdGhlIGV2ZW50cyBieSBhdmVyYWdpbmcgdGhlIHRvdGFsIHRp
bWUgdXNlZCBmb3IKc2VuZGluZyB0aGUgcGFja2V0LgoKVGhpcyBkZWNpc2lvbiB3YXMgbWFpbmx5
IGJhc2VkIG9uIG9ic2VydmluZyB0aGUgYWN0dWFsIHRpbWUgaW50ZXJ2YWwKYmV0d2VlbiBlYWNo
IEJUIHBvbGxpbmcuIFRoZSBpbnRlcnZhbCBkb2Vzbid0IHNlZW0gdG8gYmUgY29uc3RhbnQsCmR1
ZSB0byB0aGUgbmV0d29yayBhbmQgc3lzdGVtIGVudmlyb25tZW50LiBTbywgdXNpbmcgc29sdXRp
b25zIG90aGVyCnRoYW4gYXZlcmFnaW5nIGRvZXNuJ3QgZW5kIHVwIHdpdGggdmFsaWQgdGltZXN0
YW1wcy4KClNpZ25lZC1vZmYtYnk6IFBpbmcgQ2hlbmcgPHBpbmcuY2hlbmdAd2Fjb20uY29tPgpS
ZXZpZXdlZC1ieTogSmFzb24gR2VyZWNrZSA8amFzb24uZ2VyZWNrZUB3YWNvbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEppcmkgS29zaW5hIDxqa29zaW5hQHN1c2UuY3o+Ci0tLQogZHJpdmVycy9oaWQv
d2Fjb21fd2FjLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVycy9oaWQv
d2Fjb21fd2FjLmggfCAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2hpZC93YWNvbV93YWMuYyBiL2RyaXZlcnMvaGlkL3dhY29tX3dh
Yy5jCmluZGV4IGFhNDc3YTQzYTMxMi4uZWMwY2ViOWJhYmM3IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2hpZC93YWNvbV93YWMuYworKysgYi9kcml2ZXJzL2hpZC93YWNvbV93YWMuYwpAQCAtMTI2NSw2
ICsxMjY1LDkgQEAgc3RhdGljIHZvaWQgd2Fjb21faW50dW9zX3BybzJfYnRfcGVuKHN0cnVjdCB3
YWNvbV93YWMgKndhY29tKQogCiAJc3RydWN0IGlucHV0X2RldiAqcGVuX2lucHV0ID0gd2Fjb20t
PnBlbl9pbnB1dDsKIAl1bnNpZ25lZCBjaGFyICpkYXRhID0gd2Fjb20tPmRhdGE7CisJaW50IG51
bWJlcl9vZl92YWxpZF9mcmFtZXMgPSAwOworCWludCB0aW1lX2ludGVydmFsID0gMTUwMDAwMDA7
CisJa3RpbWVfdCB0aW1lX3BhY2tldF9yZWNlaXZlZCA9IGt0aW1lX2dldCgpOwogCWludCBpOwog
CiAJaWYgKHdhY29tLT5mZWF0dXJlcy50eXBlID09IElOVFVPU1AyX0JUIHx8CkBAIC0xMjg1LDEy
ICsxMjg4LDMwIEBAIHN0YXRpYyB2b2lkIHdhY29tX2ludHVvc19wcm8yX2J0X3BlbihzdHJ1Y3Qg
d2Fjb21fd2FjICp3YWNvbSkKIAkJd2Fjb20tPmlkWzBdIHw9ICh3YWNvbS0+c2VyaWFsWzBdID4+
IDMyKSAmIDB4RkZGRkY7CiAJfQogCisJLyogbnVtYmVyIG9mIHZhbGlkIGZyYW1lcyAqLwogCWZv
ciAoaSA9IDA7IGkgPCBwZW5fZnJhbWVzOyBpKyspIHsKIAkJdW5zaWduZWQgY2hhciAqZnJhbWUg
PSAmZGF0YVtpKnBlbl9mcmFtZV9sZW4gKyAxXTsKIAkJYm9vbCB2YWxpZCA9IGZyYW1lWzBdICYg
MHg4MDsKKworCQlpZiAodmFsaWQpCisJCQludW1iZXJfb2ZfdmFsaWRfZnJhbWVzKys7CisJfQor
CisJaWYgKG51bWJlcl9vZl92YWxpZF9mcmFtZXMpIHsKKwkJaWYgKHdhY29tLT5oaWRfZGF0YS50
aW1lX2RlbGF5ZWQpCisJCQl0aW1lX2ludGVydmFsID0ga3RpbWVfZ2V0KCkgLSB3YWNvbS0+aGlk
X2RhdGEudGltZV9kZWxheWVkOworCQl0aW1lX2ludGVydmFsIC89IG51bWJlcl9vZl92YWxpZF9m
cmFtZXM7CisJCXdhY29tLT5oaWRfZGF0YS50aW1lX2RlbGF5ZWQgPSB0aW1lX3BhY2tldF9yZWNl
aXZlZDsKKwl9CisKKwlmb3IgKGkgPSAwOyBpIDwgbnVtYmVyX29mX3ZhbGlkX2ZyYW1lczsgaSsr
KSB7CisJCXVuc2lnbmVkIGNoYXIgKmZyYW1lID0gJmRhdGFbaSpwZW5fZnJhbWVfbGVuICsgMV07
CisJCWJvb2wgdmFsaWQgPSBmcmFtZVswXSAmIDB4ODA7CiAJCWJvb2wgcHJveCA9IGZyYW1lWzBd
ICYgMHg0MDsKIAkJYm9vbCByYW5nZSA9IGZyYW1lWzBdICYgMHgyMDsKIAkJYm9vbCBpbnZlcnQg
PSBmcmFtZVswXSAmIDB4MTA7CisJCWludCBmcmFtZXNfbnVtYmVyX3JldmVyc2VkID0gbnVtYmVy
X29mX3ZhbGlkX2ZyYW1lcyAtIGkgLSAxOworCQlpbnQgZXZlbnRfdGltZXN0YW1wID0gdGltZV9w
YWNrZXRfcmVjZWl2ZWQgLSBmcmFtZXNfbnVtYmVyX3JldmVyc2VkICogdGltZV9pbnRlcnZhbDsK
IAogCQlpZiAoIXZhbGlkKQogCQkJY29udGludWU7CkBAIC0xMzAzLDYgKzEzMjQsNyBAQCBzdGF0
aWMgdm9pZCB3YWNvbV9pbnR1b3NfcHJvMl9idF9wZW4oc3RydWN0IHdhY29tX3dhYyAqd2Fjb20p
CiAJCQl3YWNvbS0+dG9vbFswXSA9IDA7CiAJCQl3YWNvbS0+aWRbMF0gPSAwOwogCQkJd2Fjb20t
PnNlcmlhbFswXSA9IDA7CisJCQl3YWNvbS0+aGlkX2RhdGEudGltZV9kZWxheWVkID0gMDsKIAkJ
CXJldHVybjsKIAkJfQogCkBAIC0xMzM5LDYgKzEzNjEsNyBAQCBzdGF0aWMgdm9pZCB3YWNvbV9p
bnR1b3NfcHJvMl9idF9wZW4oc3RydWN0IHdhY29tX3dhYyAqd2Fjb20pCiAJCQkJCQkgZ2V0X3Vu
YWxpZ25lZF9sZTE2KCZmcmFtZVsxMV0pKTsKIAkJCX0KIAkJfQorCiAJCWlmICh3YWNvbS0+dG9v
bFswXSkgewogCQkJaW5wdXRfcmVwb3J0X2FicyhwZW5faW5wdXQsIEFCU19QUkVTU1VSRSwgZ2V0
X3VuYWxpZ25lZF9sZTE2KCZmcmFtZVs1XSkpOwogCQkJaWYgKHdhY29tLT5mZWF0dXJlcy50eXBl
ID09IElOVFVPU1AyX0JUIHx8CkBAIC0xMzYyLDYgKzEzODUsOSBAQCBzdGF0aWMgdm9pZCB3YWNv
bV9pbnR1b3NfcHJvMl9idF9wZW4oc3RydWN0IHdhY29tX3dhYyAqd2Fjb20pCiAKIAkJd2Fjb20t
PnNoYXJlZC0+c3R5bHVzX2luX3Byb3hpbWl0eSA9IHByb3g7CiAKKwkJLyogYWRkIHRpbWVzdGFt
cCB0byB1bnBhY2sgdGhlIGZyYW1lcyAqLworCQlpbnB1dF9zZXRfdGltZXN0YW1wKHBlbl9pbnB1
dCwgZXZlbnRfdGltZXN0YW1wKTsKKwogCQlpbnB1dF9zeW5jKHBlbl9pbnB1dCk7CiAJfQogfQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvd2Fjb21fd2FjLmggYi9kcml2ZXJzL2hpZC93YWNvbV93
YWMuaAppbmRleCBjYTE3MmVmY2YwNzIuLjg4YmFkZmJhZTk5OSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9oaWQvd2Fjb21fd2FjLmgKKysrIGIvZHJpdmVycy9oaWQvd2Fjb21fd2FjLmgKQEAgLTMyMCw2
ICszMjAsNyBAQCBzdHJ1Y3QgaGlkX2RhdGEgewogCWludCBiYXRfY29ubmVjdGVkOwogCWludCBw
c19jb25uZWN0ZWQ7CiAJYm9vbCBwYWRfaW5wdXRfZXZlbnRfZmxhZzsKKwlpbnQgdGltZV9kZWxh
eWVkOwogfTsKIAogc3RydWN0IHdhY29tX3JlbW90ZV9kYXRhIHsKLS0gCjIuNDAuMQoK
--000000000000f12f6405fb70cce9--
