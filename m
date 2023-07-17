Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED24756959
	for <lists+stable@lfdr.de>; Mon, 17 Jul 2023 18:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjGQQj5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 17 Jul 2023 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjGQQjy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 17 Jul 2023 12:39:54 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618231B6
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 09:39:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-785ccd731a7so48439139f.0
        for <stable@vger.kernel.org>; Mon, 17 Jul 2023 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689611992; x=1690216792;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXlYK9vjAJHMAJNdZ2Wemt/sBTAlGE4AiZSYmB0lFzI=;
        b=r4Y9RL3sQcbv2A8dhwNCb5SiOulQ//O1WngWAzZsdO7z5FZsAN8WVlaG3Kovfh0xQ1
         Qgc25KaOMggMDj7y2EQjvdW7AqS11SRHGJbWp7xFhTVk1ZgfwAocwGt0YlsD/auezMMD
         T54J9S/vCBk1KGY6FDXhvDyBW5pVek2Eoz0dJAHZeCqi74jmsyK8fi8FE8iQvLAnB9Z0
         SIMGYboruXpb4NgYO7WrSI/OnjK9AWpipK4+pFkofCWbYTMlH/bdIN2Q/qo4gi7xzFT1
         EiB8hcFF2D2RnAUHv1SXoMvevc+GHPhBgsl4DCVBg7o1rG+25VVHoGViF3Mm5jCo6TBz
         Wo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611992; x=1690216792;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uXlYK9vjAJHMAJNdZ2Wemt/sBTAlGE4AiZSYmB0lFzI=;
        b=e16+P1EJS29x35nOv7fqBruCyznjtEax62YUxTZNVP741L+91RTa+6Y1TTsrePoYGb
         WMde9zv4IYo1VB4Pp2AEES3fr3/iusRdIVYGsX7KgLUPgbOxNrF9u4IG2uYMLlg4X/eC
         wk4NBGfor5YsRLHdc/UQJP9Kmk2rW3Svui/WZSV47xBe0yGdhmcs7K6+kHrEC7DyQGBJ
         nlWY3vH5g8F8/bl8zmuemCTpu+fdeorTrGPvgChBxnAA0AfqerhdDJugjw5zd8LeU08K
         rYwmDNLLQWWZQwQf/Sz6X1Kg01bmVYHbbZ1qgxFxqXd9FG/cukZdYFT5boR0Dcj2uMH3
         V9zQ==
X-Gm-Message-State: ABy/qLav+A0NI50tn/griakxjwg8gzz5zHe1qipv/1Y6lqmlsAfcXDoS
        YOeaxfuhiQGyxJbvcx+QqZ/R0g==
X-Google-Smtp-Source: APBJJlHEJchjd5xZ0yDOmswsVxW4c6bdBfJnG3in4anF9jeUTgb4sEO8KTdzMrPVV0OHgqDsFT+0aQ==
X-Received: by 2002:a05:6602:3f04:b0:780:d65c:d78f with SMTP id em4-20020a0566023f0400b00780d65cd78fmr340000iob.2.1689611992634;
        Mon, 17 Jul 2023 09:39:52 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d10-20020a056602228a00b00786fd8e764bsm4971820iod.0.2023.07.17.09.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 09:39:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------LxjbaAmPEZuBXZzjjU0p0yiD"
Message-ID: <222ae139-33a6-a522-0deb-dcdf044edd19@kernel.dk>
Date:   Mon, 17 Jul 2023 10:39:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring wait"
 failed to apply to 6.1-stable tree
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     gregkh@linuxfoundation.org, andres@anarazel.de,
        asml.silence@gmail.com
Cc:     stable@vger.kernel.org
References: <2023071620-litigate-debunk-939a@gregkh>
 <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
In-Reply-To: <0cfb74bb-c203-39a1-eab7-abeeae724b68@kernel.dk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------LxjbaAmPEZuBXZzjjU0p0yiD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/23 12:13 PM, Jens Axboe wrote:
> On 7/16/23 2:41 AM, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 6.1-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following commands:
>>
>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 8a796565cec3601071cbbd27d6304e202019d014
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071620-litigate-debunk-939a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Here's one for 6.1-stable.

And here's a corrected one for 6.1.

-- 
Jens Axboe


--------------LxjbaAmPEZuBXZzjjU0p0yiD
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-Use-io_schedule-in-cqring-wait.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-Use-io_schedule-in-cqring-wait.patch"
Content-Transfer-Encoding: base64

RnJvbSBmNWYyNGVjMjczNDBkYWYxMjE3N2ZkMDljMmQxMDdhNTg5Y2JmNTI3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXMgRnJldW5kIDxhbmRyZXNAYW5hcmF6ZWwu
ZGU+CkRhdGU6IFN1biwgMTYgSnVsIDIwMjMgMTI6MTM6MDYgLTA2MDAKU3ViamVjdDogW1BB
VENIXSBpb191cmluZzogVXNlIGlvX3NjaGVkdWxlKiBpbiBjcXJpbmcgd2FpdAoKQ29tbWl0
IDhhNzk2NTY1Y2VjMzYwMTA3MWNiYmQyN2Q2MzA0ZTIwMjAxOWQwMTQgdXBzdHJlYW0uCgpJ
IG9ic2VydmVkIHBvb3IgcGVyZm9ybWFuY2Ugb2YgaW9fdXJpbmcgY29tcGFyZWQgdG8gc3lu
Y2hyb25vdXMgSU8uIFRoYXQKdHVybnMgb3V0IHRvIGJlIGNhdXNlZCBieSBkZWVwZXIgQ1BV
IGlkbGUgc3RhdGVzIGVudGVyZWQgd2l0aCBpb191cmluZywKZHVlIHRvIGlvX3VyaW5nIHVz
aW5nIHBsYWluIHNjaGVkdWxlKCksIHdoZXJlYXMgc3luY2hyb25vdXMgSU8gdXNlcwppb19z
Y2hlZHVsZSgpLgoKVGhlIGxvc3NlcyBkdWUgdG8gdGhpcyBhcmUgc3Vic3RhbnRpYWwuIE9u
IG15IGNhc2NhZGUgbGFrZSB3b3Jrc3RhdGlvbiwKdC9pb191cmluZyBmcm9tIHRoZSBmaW8g
cmVwb3NpdG9yeSBlLmcuIHlpZWxkcyByZWdyZXNzaW9ucyBiZXR3ZWVuIDIwJQphbmQgNDAl
IHdpdGggdGhlIGZvbGxvd2luZyBjb21tYW5kOgouL3QvaW9fdXJpbmcgLXIgNSAtWDAgLWQg
MSAtcyAxIC1jIDEgLXAgMCAtUyR1c2Vfc3luYyAtUiAwIC9tbnQvdDIvZmlvL3dyaXRlLjAu
MAoKVGhpcyBpcyByZXBlYXRhYmxlIHdpdGggZGlmZmVyZW50IGZpbGVzeXN0ZW1zLCB1c2lu
ZyByYXcgYmxvY2sgZGV2aWNlcwphbmQgdXNpbmcgZGlmZmVyZW50IGJsb2NrIGRldmljZXMu
CgpVc2UgaW9fc2NoZWR1bGVfcHJlcGFyZSgpIC8gaW9fc2NoZWR1bGVfZmluaXNoKCkgaW4K
aW9fY3FyaW5nX3dhaXRfc2NoZWR1bGUoKSB0byBhZGRyZXNzIHRoZSBkaWZmZXJlbmNlLgoK
QWZ0ZXIgdGhhdCB1c2luZyBpb191cmluZyBpcyBvbiBwYXIgb3Igc3VycGFzc2luZyBzeW5j
aHJvbm91cyBJTyAodXNpbmcKcmVnaXN0ZXJlZCBmaWxlcyBldGMgbWFrZXMgaXQgcmVsaWFi
bHkgd2luLCBidXQgYXJndWFibHkgaXMgYSBsZXNzIGZhaXIKY29tcGFyaXNvbikuCgpUaGVy
ZSBhcmUgb3RoZXIgY2FsbHMgdG8gc2NoZWR1bGUoKSBpbiBpb191cmluZy8sIGJ1dCBub25l
IGltbWVkaWF0ZWx5Cmp1bXAgb3V0IHRvIGJlIHNpbWlsYXJseSBzaXR1YXRlZCwgc28gSSBk
aWQgbm90IHRvdWNoIHRoZW0uIFNpbWlsYXJseSwKaXQncyBwb3NzaWJsZSB0aGF0IG11dGV4
X2xvY2tfaW8oKSBzaG91bGQgYmUgdXNlZCwgYnV0IGl0J3Mgbm90IGNsZWFyIGlmCnRoZXJl
IGFyZSBjYXNlcyB3aGVyZSB0aGF0IG1hdHRlcnMuCgpDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZyAjIDUuMTArCkNjOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdtYWlsLmNv
bT4KQ2M6IGlvLXVyaW5nQHZnZXIua2VybmVsLm9yZwpDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBBbmRyZXMgRnJldW5kIDxhbmRyZXNAYW5hcmF6
ZWwuZGU+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzA3MDcxNjIwMDcu
MTk0MDY4LTEtYW5kcmVzQGFuYXJhemVsLmRlCltheGJvZTogbWlub3Igc3R5bGUgZml4dXBd
ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191
cmluZy9pb191cmluZy5jIHwgMTUgKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmlu
Zy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCBjYzM1YWJhMWU0OTUu
LjZkN2IzNThlNzFmMSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9p
b191cmluZy9pb191cmluZy5jCkBAIC0yMzQ2LDcgKzIzNDYsNyBAQCBzdGF0aWMgaW5saW5l
IGludCBpb19jcXJpbmdfd2FpdF9zY2hlZHVsZShzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwK
IAkJCQkJICBzdHJ1Y3QgaW9fd2FpdF9xdWV1ZSAqaW93cSwKIAkJCQkJICBrdGltZV90ICp0
aW1lb3V0KQogewotCWludCByZXQ7CisJaW50IHRva2VuLCByZXQ7CiAJdW5zaWduZWQgbG9u
ZyBjaGVja19jcTsKIAogCS8qIG1ha2Ugc3VyZSB3ZSBydW4gdGFza193b3JrIGJlZm9yZSBj
aGVja2luZyBmb3Igc2lnbmFscyAqLwpAQCAtMjM2Miw5ICsyMzYyLDE4IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGlvX2NxcmluZ193YWl0X3NjaGVkdWxlKHN0cnVjdCBpb19yaW5nX2N0eCAq
Y3R4LAogCQlpZiAoY2hlY2tfY3EgJiBCSVQoSU9fQ0hFQ0tfQ1FfRFJPUFBFRF9CSVQpKQog
CQkJcmV0dXJuIC1FQkFEUjsKIAl9CisKKwkvKgorCSAqIFVzZSBpb19zY2hlZHVsZV9wcmVw
YXJlL2ZpbmlzaCwgc28gY3B1ZnJlcSBjYW4gdGFrZSBpbnRvIGFjY291bnQKKwkgKiB0aGF0
IHRoZSB0YXNrIGlzIHdhaXRpbmcgZm9yIElPIC0gdHVybnMgb3V0IHRvIGJlIGltcG9ydGFu
dCBmb3IgbG93CisJICogUUQgSU8uCisJICovCisJdG9rZW4gPSBpb19zY2hlZHVsZV9wcmVw
YXJlKCk7CisJcmV0ID0gMTsKIAlpZiAoIXNjaGVkdWxlX2hydGltZW91dCh0aW1lb3V0LCBI
UlRJTUVSX01PREVfQUJTKSkKLQkJcmV0dXJuIC1FVElNRTsKLQlyZXR1cm4gMTsKKwkJcmV0
ID0gLUVUSU1FOworCWlvX3NjaGVkdWxlX2ZpbmlzaCh0b2tlbik7CisJcmV0dXJuIHJldDsK
IH0KIAogLyoKLS0gCjIuNDAuMQoK

--------------LxjbaAmPEZuBXZzjjU0p0yiD--
