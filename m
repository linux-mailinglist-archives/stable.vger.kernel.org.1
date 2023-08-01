Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DFD76B9B3
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjHAQeg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjHAQee (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 12:34:34 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7D52108
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:34:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2b703a0453fso89465741fa.3
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690907669; x=1691512469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc82kojdaqyd+xCXovsKafxAFudlMfSjCmPbISb0d8U=;
        b=WNKHgoB3CqjvfLbiAHVgIS7IlInjEXf/OSCwNsQeto78AISCsztuAmCDbR9Y18shrU
         GvtLblk8ecZYbeihE42tEKkeuqc3awwItjlpXY++6L2MC4en29WquLuTsLoPdPze3Wfd
         QfaJmfz7Yv4eyewmTu0PA4QK+yeCM9btM7lsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690907669; x=1691512469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jc82kojdaqyd+xCXovsKafxAFudlMfSjCmPbISb0d8U=;
        b=Ctc30w9xi20MwtZgbiRUuye+mW7DZNb6t6zyhp6IL84zJv+VlYtX5OXN+EjDPJ9VJ1
         acWv5u9c83GORc7xK/nhUSdQYmONnTDboxehgQGpn4U1ekzwG2brA0MWcCYkmnae3C3w
         cjKvl7AmfhJk+4fTQJByO2WWpB7sza1zJojib2HX2R+mC5l+Q7u0KRkVEhcp7mElqNlZ
         ApYjYj3GKzfnq0UFcrc7kwJHS0T17/xUnoAXLB14wKPsynU2QgoMEPI3WCC4OTY4IMSh
         PhqB3J0bOUOfOpAzhM4sh5J+ZBMfJ0cFYgV3g3U2LfegOij10ylaBPXdYKhVAU0E/oIE
         6B8A==
X-Gm-Message-State: ABy/qLZUAIVZRuutj5AaEajMowfHl6EJxlewvTcnhaq6tUPakWy2Cgn8
        CY3K3T0T3nlcQZ4sVmio+h1XK5/VyWoLp6+Bq9vagYLHijM=
X-Google-Smtp-Source: APBJJlHkeiORCF+dkEnHkp2m7XjYriP1TCmA3G8hbIuyUA3O2jk/kW5cC1eomL8xqyRK/jtkzfWbSg==
X-Received: by 2002:a2e:7e0b:0:b0:2b4:65ef:3af5 with SMTP id z11-20020a2e7e0b000000b002b465ef3af5mr2860172ljc.30.1690907669418;
        Tue, 01 Aug 2023 09:34:29 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2-20020a05651c008200b002b9f4841913sm590505ljq.1.2023.08.01.09.34.28
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 09:34:28 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso4975785e87.1
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 09:34:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3147:b0:4f8:76ba:ad3c with SMTP id
 s7-20020a056512314700b004f876baad3cmr2339380lfi.55.1690907667960; Tue, 01 Aug
 2023 09:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <2023080129-surface-stench-5e24@gregkh>
In-Reply-To: <2023080129-surface-stench-5e24@gregkh>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Aug 2023 09:34:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfdPq6=rwECsYaSzFaehBoGxGEHwyJmAVK0ekXoS89FQ@mail.gmail.com>
Message-ID: <CAHk-=wjfdPq6=rwECsYaSzFaehBoGxGEHwyJmAVK0ekXoS89FQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] mm: lock_vma_under_rcu() must check
 vma->anon_vma under vma" failed to apply to 6.4-stable tree
To:     gregkh@linuxfoundation.org
Cc:     jannh@google.com, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e670d30601df1ef0"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--000000000000e670d30601df1ef0
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Jul 2023 at 23:28, <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.4-stable tree.

Ahh. The vma_is_tcp() checks are new.

I think you can literally just remove all occurrences of

     && !vma_is_tcp(vma)

in that patch to make it apply.

The end result should look something like the attached, afaik.

            Linus

--000000000000e670d30601df1ef0
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lksiqsr90>
X-Attachment-Id: f_lksiqsr90

ZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggZjY5ZmJjMjUxMTk4
Li5hZGRmNTdhNDI3ODUgMTAwNjQ0Ci0tLSBhL21tL21lbW9yeS5jCisrKyBiL21tL21lbW9yeS5j
CkBAIC01Mjg0LDI3ICs1Mjg0LDI4IEBAIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbG9ja192bWFf
dW5kZXJfcmN1KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAogCWlmICghdm1hX2lzX2Fub255bW91cyh2
bWEpKQogCQlnb3RvIGludmFsOwogCi0JLyogZmluZF9tZXJnZWFibGVfYW5vbl92bWEgdXNlcyBh
ZGphY2VudCB2bWFzIHdoaWNoIGFyZSBub3QgbG9ja2VkICovCi0JaWYgKCF2bWEtPmFub25fdm1h
KQotCQlnb3RvIGludmFsOwotCiAJaWYgKCF2bWFfc3RhcnRfcmVhZCh2bWEpKQogCQlnb3RvIGlu
dmFsOwogCisJLyoKKwkgKiBmaW5kX21lcmdlYWJsZV9hbm9uX3ZtYSB1c2VzIGFkamFjZW50IHZt
YXMgd2hpY2ggYXJlIG5vdCBsb2NrZWQuCisJICogVGhpcyBjaGVjayBtdXN0IGhhcHBlbiBhZnRl
ciB2bWFfc3RhcnRfcmVhZCgpOyBvdGhlcndpc2UsIGEKKwkgKiBjb25jdXJyZW50IG1yZW1hcCgp
IHdpdGggTVJFTUFQX0RPTlRVTk1BUCBjb3VsZCBkaXNzb2NpYXRlIHRoZSBWTUEKKwkgKiBmcm9t
IGl0cyBhbm9uX3ZtYS4KKwkgKi8KKwlpZiAodW5saWtlbHkoIXZtYS0+YW5vbl92bWEpKQorCQln
b3RvIGludmFsX2VuZF9yZWFkOworCiAJLyoKIAkgKiBEdWUgdG8gdGhlIHBvc3NpYmlsaXR5IG9m
IHVzZXJmYXVsdCBoYW5kbGVyIGRyb3BwaW5nIG1tYXBfbG9jaywgYXZvaWQKIAkgKiBpdCBmb3Ig
bm93IGFuZCBmYWxsIGJhY2sgdG8gcGFnZSBmYXVsdCBoYW5kbGluZyB1bmRlciBtbWFwX2xvY2su
CiAJICovCi0JaWYgKHVzZXJmYXVsdGZkX2FybWVkKHZtYSkpIHsKLQkJdm1hX2VuZF9yZWFkKHZt
YSk7Ci0JCWdvdG8gaW52YWw7Ci0JfQorCWlmICh1c2VyZmF1bHRmZF9hcm1lZCh2bWEpKQorCQln
b3RvIGludmFsX2VuZF9yZWFkOwogCiAJLyogQ2hlY2sgc2luY2Ugdm1fc3RhcnQvdm1fZW5kIG1p
Z2h0IGNoYW5nZSBiZWZvcmUgd2UgbG9jayB0aGUgVk1BICovCi0JaWYgKHVubGlrZWx5KGFkZHJl
c3MgPCB2bWEtPnZtX3N0YXJ0IHx8IGFkZHJlc3MgPj0gdm1hLT52bV9lbmQpKSB7Ci0JCXZtYV9l
bmRfcmVhZCh2bWEpOwotCQlnb3RvIGludmFsOwotCX0KKwlpZiAodW5saWtlbHkoYWRkcmVzcyA8
IHZtYS0+dm1fc3RhcnQgfHwgYWRkcmVzcyA+PSB2bWEtPnZtX2VuZCkpCisJCWdvdG8gaW52YWxf
ZW5kX3JlYWQ7CiAKIAkvKiBDaGVjayBpZiB0aGUgVk1BIGdvdCBpc29sYXRlZCBhZnRlciB3ZSBm
b3VuZCBpdCAqLwogCWlmICh2bWEtPmRldGFjaGVkKSB7CkBAIC01MzE2LDYgKzUzMTcsOSBAQCBz
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKmxvY2tfdm1hX3VuZGVyX3JjdShzdHJ1Y3QgbW1fc3RydWN0
ICptbSwKIAogCXJjdV9yZWFkX3VubG9jaygpOwogCXJldHVybiB2bWE7CisKK2ludmFsX2VuZF9y
ZWFkOgorCXZtYV9lbmRfcmVhZCh2bWEpOwogaW52YWw6CiAJcmN1X3JlYWRfdW5sb2NrKCk7CiAJ
Y291bnRfdm1fdm1hX2xvY2tfZXZlbnQoVk1BX0xPQ0tfQUJPUlQpOwo=
--000000000000e670d30601df1ef0--
