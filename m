Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F5C73B909
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjFWNrx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjFWNri (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 09:47:38 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D703E2D5A
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 06:47:23 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3420d8ad7feso965105ab.0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687528043; x=1690120043;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0e+KEoEBLJpXQLCrabbHrqsev5OZD1FIQ0a5uDwj+M=;
        b=jSMZK8zzgqPrtf8vitKHa+8Ti2y/43+E4d6zwVan1xQVdGGVk7Hw14/UgdJSUdIzpq
         8wUpCNshIE1h1kiIpkokLH3qZuU2m+xbvh6LyYfm3GjoALBKZj4JCuVmSwDZPcRGZ06F
         m+bNkAkjquu4IcFXYPlwh93b9H7yuZo765QfBzwrmdRymChVuQK0dWx+pLl2/x3H6kJ7
         KJbHqZMOIiLEMilkz2yJLjZLV6nA2HOH9dbTsldg7xI8IUQD4cY60gGppO28PTbCjAUC
         pTleeq5CS8kG61fi2or/KTSLwlVPAqSnlp31545P02m63VcC1CEK8M/geoX9+kd1dDje
         aNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528043; x=1690120043;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V0e+KEoEBLJpXQLCrabbHrqsev5OZD1FIQ0a5uDwj+M=;
        b=a59pnFc4tZ9yS3hnr6AjbjBeX3niL/+rCRXuYwvsKNFliWMuvQRNee7e1b2hMNJUFN
         o+EXzru9FQnn/t5s1EDl6H/6rGvpQBTHbQq/Sxu9ypVfujmeeM1NtyFTKLjMVCxOE5jl
         l7d7MUZJAVeX/1UWe6vBu02P6adVepPr96V6JwenYWIo2SqYWdNBxuxcbL8taqC38th6
         /4kyoYlAs657ImXGusdb4LraYTaIjQAaaRv1gpwe7mE7P4eEU4KFbDMORnwRl3rhEoKu
         MDP0H8MGI0sNhQ8Zo7B9gVL/NgFSjRud7iDCPHkDQA14Q3OyTAYmEdBwONWA+IJ8Ke0p
         M/vQ==
X-Gm-Message-State: AC+VfDzEUNYUSX3lE4eJVEPgRRMfJUx5On3pXFDVr2gtCm3ek2UA6k6m
        1Xw/P7LsaNKXcWwgjubKu5kRVw==
X-Google-Smtp-Source: ACHHUZ5xgKcspsQzP8R5PrepeUFQfx/ziPT4hGSc8chjk2f2NpbtkncRQcaNouAaOW6R0bo96K0vTw==
X-Received: by 2002:a92:7c05:0:b0:340:ae63:38a4 with SMTP id x5-20020a927c05000000b00340ae6338a4mr19547416ilc.2.1687528042992;
        Fri, 23 Jun 2023 06:47:22 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z124-20020a636582000000b00553d96d7feesm6504894pgb.35.2023.06.23.06.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:47:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------5whT6VfXqSlmkDyHQYoOlaPm"
Message-ID: <8b2f4b74-0a5c-c2c8-de45-81ce47a4ad74@kernel.dk>
Date:   Fri, 23 Jun 2023 07:47:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] io_uring/net: save msghdr->msg_control for
 retries" failed to apply to 5.10-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, marek@cloudflare.com
Cc:     stable@vger.kernel.org
References: <2023061721-shaft-lion-f22c@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023061721-shaft-lion-f22c@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------5whT6VfXqSlmkDyHQYoOlaPm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/23 2:11?AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x cac9e4418f4cbd548ccb065b3adcafe073f7f7d2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061721-shaft-lion-f22c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Greg, here's this (and the two followup patches that I just emailed
about), for the 5.10-stable and 5.15-stable branches. Thanks!

-- 
Jens Axboe

--------------5whT6VfXqSlmkDyHQYoOlaPm
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-net-clear-msg_controllen-on-partial-sendmsg.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-net-clear-msg_controllen-on-partial-sendmsg.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzMDlmZDhhYTA4ZGE4NjVhMmZhODkzNWQwMDZjOTMyYmNkNGFlMjE2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IEZyaSwgMjMgSnVuIDIwMjMgMDc6Mzk6NDIgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
M10gaW9fdXJpbmcvbmV0OiBjbGVhciBtc2dfY29udHJvbGxlbiBvbiBwYXJ0aWFsIHNlbmRt
c2cKIHJldHJ5CgpDb21taXQgYjFkYzQ5MjA4N2RiMGYyZTVhNDVmMTA3MmE3NDNkMDQ2MThk
ZDZiZSB1cHN0cmVhbS4KCklmIHdlIGhhdmUgY21zZyBhdHRhY2hlZCBBTkQgd2UgdHJhbnNm
ZXJyZWQgcGFydGlhbCBkYXRhIGF0IGxlYXN0LCBjbGVhcgptc2dfY29udHJvbGxlbiBvbiBy
ZXRyeSBzbyB3ZSBkb24ndCBhdHRlbXB0IHRvIHNlbmQgdGhhdCBhZ2Fpbi4KCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnICMgNS4xMCsKRml4ZXM6IGNhYzllNDQxOGY0YyAoImlvX3Vy
aW5nL25ldDogc2F2ZSBtc2doZHItPm1zZ19jb250cm9sIGZvciByZXRyaWVzIikKUmVwb3J0
ZWQtYnk6IFN0ZWZhbiBNZXR6bWFjaGVyIDxtZXR6ZUBzYW1iYS5vcmc+ClJldmlld2VkLWJ5
OiBTdGVmYW4gTWV0em1hY2hlciA8bWV0emVAc2FtYmEub3JnPgpTaWduZWQtb2ZmLWJ5OiBK
ZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcuYyB8
IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9p
b191cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCBmN2M0MWQz
ZDc3NTIuLjFkMThhYTE3ZTcxYiAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYwor
KysgYi9pb191cmluZy9pb191cmluZy5jCkBAIC00OTQ5LDYgKzQ5NDksOCBAQCBzdGF0aWMg
aW50IGlvX3NlbmRtc2coc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1
ZV9mbGFncykKIAkJaWYgKHJldCA9PSAtRVJFU1RBUlRTWVMpCiAJCQlyZXQgPSAtRUlOVFI7
CiAJCWlmIChyZXQgPiAwICYmIGlvX25ldF9yZXRyeShzb2NrLCBmbGFncykpIHsKKwkJCWtt
c2ctPm1zZy5tc2dfY29udHJvbGxlbiA9IDA7CisJCQlrbXNnLT5tc2cubXNnX2NvbnRyb2wg
PSBOVUxMOwogCQkJc3ItPmRvbmVfaW8gKz0gcmV0OwogCQkJcmVxLT5mbGFncyB8PSBSRVFf
Rl9QQVJUSUFMX0lPOwogCQkJcmV0dXJuIGlvX3NldHVwX2FzeW5jX21zZyhyZXEsIGttc2cp
OwotLSAKMi40MC4xCgo=
--------------5whT6VfXqSlmkDyHQYoOlaPm
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-net-save-msghdr-msg_control-for-retries.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-net-save-msghdr-msg_control-for-retries.patch"
Content-Transfer-Encoding: base64

RnJvbSA3NjUxM2Q5Zjk5NzY0ZTZhY2Y5ZjBlMmU1M2I3ZDQyZDk1ZDY2MzBkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IEZyaSwgMjMgSnVuIDIwMjMgMDc6Mzg6MTQgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
M10gaW9fdXJpbmcvbmV0OiBzYXZlIG1zZ2hkci0+bXNnX2NvbnRyb2wgZm9yIHJldHJpZXMK
CkNvbW1pdCBjYWM5ZTQ0MThmNGNiZDU0OGNjYjA2NWIzYWRjYWZlMDczZjdmN2QyIHVwc3Ry
ZWFtLgoKSWYgdGhlIGFwcGxpY2F0aW9uIHNldHMgLT5tc2dfY29udHJvbCBhbmQgd2UgaGF2
ZSB0byBsYXRlciByZXRyeSB0aGlzCmNvbW1hbmQsIG9yIGlmIGl0IGdvdCBxdWV1ZWQgd2l0
aCBJT1NRRV9BU1lOQyB0byBiZWdpbiB3aXRoLCB0aGVuIHdlCm5lZWQgdG8gcmV0YWluIHRo
ZSBvcmlnaW5hbCBtc2dfY29udHJvbCB2YWx1ZS4gVGhpcyBpcyBkdWUgdG8gdGhlIG5ldApz
dGFjayBvdmVyd3JpdGluZyB0aGlzIGZpZWxkIHdpdGggYW4gaW4ta2VybmVsIHBvaW50ZXIs
IHRvIGNvcHkgaXQKaW4uIEhpdHRpbmcgdGhhdCBwYXRoIGZvciB0aGUgc2Vjb25kIHRpbWUg
d2lsbCBub3cgZmFpbCB0aGUgY29weSBmcm9tCnVzZXIsIGFzIGl0J3MgYXR0ZW1wdGluZyB0
byBjb3B5IGZyb20gYSBub24tdXNlciBhZGRyZXNzLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcgIyA1LjEwKwpMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vYXhib2UvbGlidXJpbmcv
aXNzdWVzLzg4MApSZXBvcnRlZC1hbmQtdGVzdGVkLWJ5OiBNYXJlayBNYWprb3dza2kgPG1h
cmVrQGNsb3VkZmxhcmUuY29tPgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcuYyB8IDExICsrKysrKysrKystCiAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmluZGV4
IDFkOGFkYzU3YTQ0YS4uZjdjNDFkM2Q3NzUyIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191
cmluZy5jCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTU4MSw2ICs1ODEsNyBAQCBz
dHJ1Y3QgaW9fc3JfbXNnIHsKIAlzaXplX3QJCQkJbGVuOwogCXNpemVfdAkJCQlkb25lX2lv
OwogCXN0cnVjdCBpb19idWZmZXIJCSprYnVmOworCXZvaWQgX191c2VyCQkJKm1zZ19jb250
cm9sOwogfTsKIAogc3RydWN0IGlvX29wZW4gewpAQCAtNDg2NCwxMCArNDg2NSwxNiBAQCBz
dGF0aWMgaW50IGlvX3NldHVwX2FzeW5jX21zZyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwKIHN0
YXRpYyBpbnQgaW9fc2VuZG1zZ19jb3B5X2hkcihzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwKIAkJ
CSAgICAgICBzdHJ1Y3QgaW9fYXN5bmNfbXNnaGRyICppb21zZykKIHsKKwlzdHJ1Y3QgaW9f
c3JfbXNnICpzciA9ICZyZXEtPnNyX21zZzsKKwlpbnQgcmV0OworCiAJaW9tc2ctPm1zZy5t
c2dfbmFtZSA9ICZpb21zZy0+YWRkcjsKIAlpb21zZy0+ZnJlZV9pb3YgPSBpb21zZy0+ZmFz
dF9pb3Y7Ci0JcmV0dXJuIHNlbmRtc2dfY29weV9tc2doZHIoJmlvbXNnLT5tc2csIHJlcS0+
c3JfbXNnLnVtc2csCisJcmV0ID0gc2VuZG1zZ19jb3B5X21zZ2hkcigmaW9tc2ctPm1zZywg
cmVxLT5zcl9tc2cudW1zZywKIAkJCQkgICByZXEtPnNyX21zZy5tc2dfZmxhZ3MsICZpb21z
Zy0+ZnJlZV9pb3YpOworCS8qIHNhdmUgbXNnX2NvbnRyb2wgYXMgc3lzX3NlbmRtc2coKSBv
dmVyd3JpdGVzIGl0ICovCisJc3ItPm1zZ19jb250cm9sID0gaW9tc2ctPm1zZy5tc2dfY29u
dHJvbDsKKwlyZXR1cm4gcmV0OwogfQogCiBzdGF0aWMgaW50IGlvX3NlbmRtc2dfcHJlcF9h
c3luYyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKQEAgLTQ5MjQsNiArNDkzMSw4IEBAIHN0YXRp
YyBpbnQgaW9fc2VuZG1zZyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlz
c3VlX2ZsYWdzKQogCQlpZiAocmV0KQogCQkJcmV0dXJuIHJldDsKIAkJa21zZyA9ICZpb21z
ZzsKKwl9IGVsc2UgeworCQlrbXNnLT5tc2cubXNnX2NvbnRyb2wgPSBzci0+bXNnX2NvbnRy
b2w7CiAJfQogCiAJZmxhZ3MgPSByZXEtPnNyX21zZy5tc2dfZmxhZ3M7Ci0tIAoyLjQwLjEK
Cg==
--------------5whT6VfXqSlmkDyHQYoOlaPm
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-io_uring-net-disable-partial-retries-for-recvmsg-wit.patch"
Content-Disposition: attachment;
 filename*0="0003-io_uring-net-disable-partial-retries-for-recvmsg-wit.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiM2Y5NDQyZmI1YjUwNGQyNDBlNjcxMGY0ODMyMzI2NDFiZWIxYjhmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IEZyaSwgMjMgSnVuIDIwMjMgMDc6NDE6MTAgLTA2MDAKU3ViamVjdDogW1BBVENIIDMv
M10gaW9fdXJpbmcvbmV0OiBkaXNhYmxlIHBhcnRpYWwgcmV0cmllcyBmb3IgcmVjdm1zZyB3
aXRoCiBjbXNnCgpDb21taXQgNzhkMGQyMDYzYmFiOTU0ZDE5YTE2OTZmZWFlNGM3NzA2YTYy
NmQ0OCB1cHN0cmVhbS4KCldlIGNhbm5vdCBzYW5lbHkgaGFuZGxlIHBhcnRpYWwgcmV0cmll
cyBmb3IgcmVjdm1zZyBpZiB3ZSBoYXZlIGNtc2cKYXR0YWNoZWQuIElmIHdlIGRvbid0LCB0
aGVuIHdlJ2QganVzdCBiZSBvdmVyd3JpdGluZyB0aGUgaW5pdGlhbCBjbXNnCmhlYWRlciBv
biByZXRyaWVzLiBBbHRlcm5hdGl2ZWx5IHdlIGNvdWxkIGluY3JlbWVudCBhbmQgaGFuZGxl
IHRoaXMKYXBwcm9wcmlhdGVseSwgYnV0IGl0IGRvZXNuJ3Qgc2VlbSB3b3J0aCB0aGUgY29t
cGxpY2F0aW9uLgoKTW92ZSB0aGUgTVNHX1dBSVRBTEwgY2hlY2sgaW50byB0aGUgbm9uLW11
bHRpc2hvdCBjYXNlIHdoaWxlIGF0IGl0LApzaW5jZSBNU0dfV0FJVEFMTCBpcyBleHBsaWNp
dGx5IGRpc2FibGVkIGZvciBtdWx0aXNob3QgYW55d2F5LgoKTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvaW8tdXJpbmcvMGIwZDQ0MTEtYzhmZC00MjcyLTc3MGItZTAzMGFmNjkx
OWEwQGtlcm5lbC5kay8KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA1LjEwKwpSZXBv
cnRlZC1ieTogU3RlZmFuIE1ldHptYWNoZXIgPG1ldHplQHNhbWJhLm9yZz4KUmV2aWV3ZWQt
Ynk6IFN0ZWZhbiBNZXR6bWFjaGVyIDxtZXR6ZUBzYW1iYS5vcmc+ClNpZ25lZC1vZmYtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9pb191cmluZy5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5n
LmMKaW5kZXggMWQxOGFhMTdlNzFiLi5jYmZjOWJiZTg3YjAgMTAwNjQ0Ci0tLSBhL2lvX3Vy
aW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpAQCAtNTIwMSw3ICs1
MjAxLDcgQEAgc3RhdGljIGludCBpb19yZWN2bXNnKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1
bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAJZmxhZ3MgPSByZXEtPnNyX21zZy5tc2dfZmxh
Z3M7CiAJaWYgKGZvcmNlX25vbmJsb2NrKQogCQlmbGFncyB8PSBNU0dfRE9OVFdBSVQ7Ci0J
aWYgKGZsYWdzICYgTVNHX1dBSVRBTEwpCisJaWYgKGZsYWdzICYgTVNHX1dBSVRBTEwgJiYg
IWttc2ctPm1zZy5tc2dfY29udHJvbGxlbikKIAkJbWluX3JldCA9IGlvdl9pdGVyX2NvdW50
KCZrbXNnLT5tc2cubXNnX2l0ZXIpOwogCiAJcmV0ID0gX19zeXNfcmVjdm1zZ19zb2NrKHNv
Y2ssICZrbXNnLT5tc2csIHJlcS0+c3JfbXNnLnVtc2csCi0tIAoyLjQwLjEKCg==

--------------5whT6VfXqSlmkDyHQYoOlaPm--
