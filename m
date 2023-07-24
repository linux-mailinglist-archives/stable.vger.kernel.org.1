Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D375FF39
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGXSiy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGXSiy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 14:38:54 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7439A6
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:38:52 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-348d1c94fdaso919125ab.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690223932; x=1690828732;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Tmd+V1vZinfatIWray3UIbAuDXYUxv2v4EwTwDE088=;
        b=MT9N/5a7TQ22gmZr+ueqHlKphorPj15rVsAF5hjCK0tCIj3gwdTjkFyIlbZ1rvdWTW
         XrkQP9VFC4Kh/VgKSVuUoeVuCwyDCvCAXqJ/rcpcGlxia/eYZ0aypp+Qtrwx1AZ6fAeG
         6twrKUg64R7N6V89zvhSl9n987fTWjouK3WNVY/QA5tSSJB8d65Lq/aDEqp3DqLpQskd
         roKCjTCg8EN9D88jZqHxm89lneygYczBiIXacAZl8kJiV4rAeR/R5NLZVCv6F4S6+F5U
         kyD55aIf+jjTYLYqh2B5wmuevynIqEc8ro5b4Ez0XmMagsJJOIxTZo2/FpqLvsqd8k5X
         ihgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223932; x=1690828732;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Tmd+V1vZinfatIWray3UIbAuDXYUxv2v4EwTwDE088=;
        b=QBdV6r8B0wdmnbUDTnmGA4V75Vd/PKep5wrnKv3bGu4DFNgxN+0sq+2hga83kWJrI7
         sU5zysLLQec6UhGf8KZMhEp+4kB0+7yzbFEcTzTc9bshfovUeHJ02J6eF0GTEGwvdu8U
         9nFQzQcfbAzIWBda8uc12l8Mpef8rQ3uu4ImiblsiHWReZLhlfEHELgvw7zuYpb9kCCc
         QzlzKlKr3FyMmGwIPqmHiv/a94ZjcAUoPYcBvBojLed9YucoiNEwhUHUEvnZ4MKWvyHK
         W4zyCbzCm3fmgC0w+ank11ZaXhZbAisAKsYzU6Io0UEs6l/f9ztdEfzxx/6rpD0KRWwf
         SmDg==
X-Gm-Message-State: ABy/qLYpjkVXS53yDHtFQQfdyIgy/5AwjhDgkJ4iTY8UxgQE541tCLjb
        s7xUewIGMTWHYBSOCtAE9D5QTGPxkt7rwnRDUa8=
X-Google-Smtp-Source: APBJJlE1vgh31p0r2+dvYH4wMx+wLfchZ+R8hAQIBEACrWjKCcZp+VRqcqbV4E3KlB12EGCtQH3T2w==
X-Received: by 2002:a92:d748:0:b0:345:e55a:615f with SMTP id e8-20020a92d748000000b00345e55a615fmr7426201ilq.2.1690223932194;
        Mon, 24 Jul 2023 11:38:52 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c8-20020a92c8c8000000b00342f537e3c3sm3174929ilq.2.2023.07.24.11.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 11:38:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------iIblCcotm8Kw6GdJWfY8SaCJ"
Message-ID: <5d947e59-19a1-7844-c60b-d8408333c1b3@kernel.dk>
Date:   Mon, 24 Jul 2023 12:38:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: treat -EAGAIN for REQ_F_NOWAIT
 as final for io-wq" failed to apply to 5.15-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     stable@vger.kernel.org
References: <2023072352-cage-carnage-b38a@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023072352-cage-carnage-b38a@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------iIblCcotm8Kw6GdJWfY8SaCJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/23 6:54 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x a9be202269580ca611c6cebac90eaf1795497800
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072352-cage-carnage-b38a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's a tested backport for 5.10-stable and 5.15-stable. Thanks!

-- 
Jens Axboe


--------------iIblCcotm8Kw6GdJWfY8SaCJ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-treat-EAGAIN-for-REQ_F_NOWAIT-as-final-for-.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-treat-EAGAIN-for-REQ_F_NOWAIT-as-final-for-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3ZTFhNTZlZjE0ODBmZWRlMzVlYWNhODRiOWU1ZmNkMmNmYjk5ZTVhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMjQgSnVsIDIwMjMgMTI6Mjc6MzcgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZzogdHJlYXQgLUVBR0FJTiBmb3IgUkVRX0ZfTk9XQUlUIGFzIGZpbmFsIGZvciBp
by13cQoKQ29tbWl0IGE5YmUyMDIyNjk1ODBjYTYxMWM2Y2ViYWM5MGVhZjE3OTU0OTc4MDAg
dXBzdHJlYW0uCgppby13cSBhc3N1bWVzIHRoYXQgYW4gaXNzdWUgaXMgYmxvY2tpbmcsIGJ1
dCBpdCBtYXkgbm90IGJlIGlmIHRoZQpyZXF1ZXN0IHR5cGUgaGFzIGFza2VkIGZvciBhIG5v
bi1ibG9ja2luZyBhdHRlbXB0LiBJZiB3ZSBnZXQKLUVBR0FJTiBmb3IgdGhhdCBjYXNlLCB0
aGVuIHdlIG5lZWQgdG8gdHJlYXQgaXQgYXMgYSBmaW5hbCByZXN1bHQKYW5kIG5vdCByZXRy
eSBvciBhcm0gcG9sbCBmb3IgaXQuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDUu
MTArCkxpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9heGJvZS9saWJ1cmluZy9pc3N1ZXMvODk3
ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191
cmluZy9pb191cmluZy5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9p
b191cmluZy5jCmluZGV4IGVhZTdhM2Q4OTM5Ny4uMGQ4MGRjZDBhYzMyIDEwMDY0NAotLS0g
YS9pb191cmluZy9pb191cmluZy5jCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTcw
NTUsNiArNzA1NSwxNCBAQCBzdGF0aWMgdm9pZCBpb193cV9zdWJtaXRfd29yayhzdHJ1Y3Qg
aW9fd3Ffd29yayAqd29yaykKIAkJCSAqLwogCQkJaWYgKHJldCAhPSAtRUFHQUlOIHx8ICEo
cmVxLT5jdHgtPmZsYWdzICYgSU9SSU5HX1NFVFVQX0lPUE9MTCkpCiAJCQkJYnJlYWs7CisK
KwkJCS8qCisJCQkgKiBJZiBSRVFfRl9OT1dBSVQgaXMgc2V0LCB0aGVuIGRvbid0IHdhaXQg
b3IgcmV0cnkgd2l0aAorCQkJICogcG9sbC4gLUVBR0FJTiBpcyBmaW5hbCBmb3IgdGhhdCBj
YXNlLgorCQkJICovCisJCQlpZiAocmVxLT5mbGFncyAmIFJFUV9GX05PV0FJVCkKKwkJCQli
cmVhazsKKwogCQkJY29uZF9yZXNjaGVkKCk7CiAJCX0gd2hpbGUgKDEpOwogCX0KLS0gCjIu
NDAuMQoK

--------------iIblCcotm8Kw6GdJWfY8SaCJ--
