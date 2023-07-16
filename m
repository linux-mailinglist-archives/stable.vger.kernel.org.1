Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CF75503B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGPSNu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPSNt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 14:13:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B17128
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 11:13:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb106ad293so7260595ad.0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689531227; x=1692123227;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVeO9gUvJPhcZyMnpAlnWCZVfR55JH97icWrsyGF0Rg=;
        b=mbMuJW3Cr3JNw4gsZkmh+08wz+CDCiAyPoskdd4xdqsyYrExcWAO/6tRn/kBUgDN6l
         7GK5+lkpzTzXc15HHIT9nA4gCep5onMgGnGj6jjoNF09hDxCdhB18JBClY9+hOShiayw
         Q6q4/Xz5vkRyDHnbmRVMtvpgc1oz3n8VgTfKsfoeDLVpYTo5a5EIkA9ybJZ57WC5KGQ+
         wyl2P/5oMUR3fQAqTs6vsj6OJAAIrFkxmk2Pn2ZYHDfOlfqWdOqRHXrFj1FQFhaywRmZ
         ASvt3GwXMdtL8W9fMFfr4/3ahiFPLgkKb3MAJN06SQoEXYuABRnptizJAvM+FubkKt77
         7G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689531227; x=1692123227;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jVeO9gUvJPhcZyMnpAlnWCZVfR55JH97icWrsyGF0Rg=;
        b=lCkrHrgQkZULM88+bHLDc0EitTIWAJuCCMnV9plsYmbX7vq/1wvCftMt3xCcv7gXO6
         W0iohzcleSC6xQS+A4V/bT/mQrGhFqv6u81XXzm/Pkrl+zAro3Fi9kHPvnIWsyvZpkqz
         kSCuuHXKLpKcPUMWCF8Sp0WXt5hoDDN6o3MrLaj4gcdVQ1vsEVw72oFm193u+4z+4iGn
         WkQtXYq60QmbR12h5h0huQR86r8QwppRLSTBJXSuDTy+XROKSVVBvIJ2zpsn/Qda7Y+n
         u6gWtm7xK12XHHSOvjd8SIsB2KJPVh2dU04IByd916ezehK+iuLg6a+7VnDwsgtAdMwt
         7FaQ==
X-Gm-Message-State: ABy/qLZUd+kIxdlKokiIOIo8ufKUtOCL3K4rlBuwRhResj1KJJ/B6USX
        NBaLIuKXC/6hnfwWH2TaOn195A==
X-Google-Smtp-Source: APBJJlE/+C1OyK0kIRUQAoDodvolbgoEUkQig7lbTaGCYkZjNXDYfEgrtJMUaEzY1kd59wOt+bWSsQ==
X-Received: by 2002:a17:903:2305:b0:1b8:b55d:4cff with SMTP id d5-20020a170903230500b001b8b55d4cffmr5428459plh.2.1689531227459;
        Sun, 16 Jul 2023 11:13:47 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902b20800b001b80ed7b66fsm11223134plr.94.2023.07.16.11.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 11:13:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------gNvwaVSfARbvSI64l35D8Dqe"
Message-ID: <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
Date:   Sun, 16 Jul 2023 12:13:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring wait"
 failed to apply to 6.1-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, andres@anarazel.de,
        asml.silence@gmail.com
Cc:     stable@vger.kernel.org
References: <2023071620-litigate-debunk-939a@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023071620-litigate-debunk-939a@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------gNvwaVSfARbvSI64l35D8Dqe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/23 2:41 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 8a796565cec3601071cbbd27d6304e202019d014
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071620-litigate-debunk-939a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's one for 6.1-stable.

-- 
Jens Axboe


--------------gNvwaVSfARbvSI64l35D8Dqe
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-Use-io_schedule-in-cqring-wait.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-Use-io_schedule-in-cqring-wait.patch"
Content-Transfer-Encoding: base64

RnJvbSA3MWZjNzZiMjM5YTFjOTgwYzExODIxOTE2ZDFkNjc4NWJjMTc3YzVjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXMgRnJldW5kIDxhbmRyZXNAYW5hcmF6ZWwu
ZGU+CkRhdGU6IFN1biwgMTYgSnVsIDIwMjMgMTI6MTM6MDYgLTA2MDAKU3ViamVjdDogW1BB
VENIXSBpb191cmluZzogVXNlIGlvX3NjaGVkdWxlKiBpbiBjcXJpbmcgd2FpdAoKSSBvYnNl
cnZlZCBwb29yIHBlcmZvcm1hbmNlIG9mIGlvX3VyaW5nIGNvbXBhcmVkIHRvIHN5bmNocm9u
b3VzIElPLiBUaGF0CnR1cm5zIG91dCB0byBiZSBjYXVzZWQgYnkgZGVlcGVyIENQVSBpZGxl
IHN0YXRlcyBlbnRlcmVkIHdpdGggaW9fdXJpbmcsCmR1ZSB0byBpb191cmluZyB1c2luZyBw
bGFpbiBzY2hlZHVsZSgpLCB3aGVyZWFzIHN5bmNocm9ub3VzIElPIHVzZXMKaW9fc2NoZWR1
bGUoKS4KClRoZSBsb3NzZXMgZHVlIHRvIHRoaXMgYXJlIHN1YnN0YW50aWFsLiBPbiBteSBj
YXNjYWRlIGxha2Ugd29ya3N0YXRpb24sCnQvaW9fdXJpbmcgZnJvbSB0aGUgZmlvIHJlcG9z
aXRvcnkgZS5nLiB5aWVsZHMgcmVncmVzc2lvbnMgYmV0d2VlbiAyMCUKYW5kIDQwJSB3aXRo
IHRoZSBmb2xsb3dpbmcgY29tbWFuZDoKLi90L2lvX3VyaW5nIC1yIDUgLVgwIC1kIDEgLXMg
MSAtYyAxIC1wIDAgLVMkdXNlX3N5bmMgLVIgMCAvbW50L3QyL2Zpby93cml0ZS4wLjAKClRo
aXMgaXMgcmVwZWF0YWJsZSB3aXRoIGRpZmZlcmVudCBmaWxlc3lzdGVtcywgdXNpbmcgcmF3
IGJsb2NrIGRldmljZXMKYW5kIHVzaW5nIGRpZmZlcmVudCBibG9jayBkZXZpY2VzLgoKVXNl
IGlvX3NjaGVkdWxlX3ByZXBhcmUoKSAvIGlvX3NjaGVkdWxlX2ZpbmlzaCgpIGluCmlvX2Nx
cmluZ193YWl0X3NjaGVkdWxlKCkgdG8gYWRkcmVzcyB0aGUgZGlmZmVyZW5jZS4KCkFmdGVy
IHRoYXQgdXNpbmcgaW9fdXJpbmcgaXMgb24gcGFyIG9yIHN1cnBhc3Npbmcgc3luY2hyb25v
dXMgSU8gKHVzaW5nCnJlZ2lzdGVyZWQgZmlsZXMgZXRjIG1ha2VzIGl0IHJlbGlhYmx5IHdp
biwgYnV0IGFyZ3VhYmx5IGlzIGEgbGVzcyBmYWlyCmNvbXBhcmlzb24pLgoKVGhlcmUgYXJl
IG90aGVyIGNhbGxzIHRvIHNjaGVkdWxlKCkgaW4gaW9fdXJpbmcvLCBidXQgbm9uZSBpbW1l
ZGlhdGVseQpqdW1wIG91dCB0byBiZSBzaW1pbGFybHkgc2l0dWF0ZWQsIHNvIEkgZGlkIG5v
dCB0b3VjaCB0aGVtLiBTaW1pbGFybHksCml0J3MgcG9zc2libGUgdGhhdCBtdXRleF9sb2Nr
X2lvKCkgc2hvdWxkIGJlIHVzZWQsIGJ1dCBpdCdzIG5vdCBjbGVhciBpZgp0aGVyZSBhcmUg
Y2FzZXMgd2hlcmUgdGhhdCBtYXR0ZXJzLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcg
IyA1LjEwKwpDYzogUGF2ZWwgQmVndW5rb3YgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+CkNj
OiBpby11cmluZ0B2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcKU2lnbmVkLW9mZi1ieTogQW5kcmVzIEZyZXVuZCA8YW5kcmVzQGFuYXJhemVsLmRl
PgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNzA3MTYyMDA3LjE5NDA2
OC0xLWFuZHJlc0BhbmFyYXplbC5kZQpbYXhib2U6IG1pbm9yIHN0eWxlIGZpeHVwXQpTaWdu
ZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcv
aW9fdXJpbmcuYyB8IDE1ICsrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9f
dXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggY2MzNWFiYTFlNDk1Li5kZTEx
N2QzNDI0YjIgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJp
bmcvaW9fdXJpbmcuYwpAQCAtMjM0Niw3ICsyMzQ2LDcgQEAgc3RhdGljIGlubGluZSBpbnQg
aW9fY3FyaW5nX3dhaXRfc2NoZWR1bGUoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsCiAJCQkJ
CSAgc3RydWN0IGlvX3dhaXRfcXVldWUgKmlvd3EsCiAJCQkJCSAga3RpbWVfdCAqdGltZW91
dCkKIHsKLQlpbnQgcmV0OworCWludCB0b2tlbiwgcmV0OwogCXVuc2lnbmVkIGxvbmcgY2hl
Y2tfY3E7CiAKIAkvKiBtYWtlIHN1cmUgd2UgcnVuIHRhc2tfd29yayBiZWZvcmUgY2hlY2tp
bmcgZm9yIHNpZ25hbHMgKi8KQEAgLTIzNjIsOSArMjM2MiwxOCBAQCBzdGF0aWMgaW5saW5l
IGludCBpb19jcXJpbmdfd2FpdF9zY2hlZHVsZShzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwK
IAkJaWYgKGNoZWNrX2NxICYgQklUKElPX0NIRUNLX0NRX0RST1BQRURfQklUKSkKIAkJCXJl
dHVybiAtRUJBRFI7CiAJfQorCisJLyoKKwkgKiBVc2UgaW9fc2NoZWR1bGVfcHJlcGFyZS9m
aW5pc2gsIHNvIGNwdWZyZXEgY2FuIHRha2UgaW50byBhY2NvdW50CisJICogdGhhdCB0aGUg
dGFzayBpcyB3YWl0aW5nIGZvciBJTyAtIHR1cm5zIG91dCB0byBiZSBpbXBvcnRhbnQgZm9y
IGxvdworCSAqIFFEIElPLgorCSAqLworCXRva2VuID0gaW9fc2NoZWR1bGVfcHJlcGFyZSgp
OworCXJldCA9IDA7CiAJaWYgKCFzY2hlZHVsZV9ocnRpbWVvdXQodGltZW91dCwgSFJUSU1F
Ul9NT0RFX0FCUykpCi0JCXJldHVybiAtRVRJTUU7Ci0JcmV0dXJuIDE7CisJCXJldCA9IC1F
VElNRTsKKwlpb19zY2hlZHVsZV9maW5pc2godG9rZW4pOworCXJldHVybiByZXQ7CiB9CiAK
IC8qCi0tIAoyLjQwLjEKCg==

--------------gNvwaVSfARbvSI64l35D8Dqe--
