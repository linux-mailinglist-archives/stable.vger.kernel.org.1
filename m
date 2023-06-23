Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69373B934
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjFWN6V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFWN6T (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 09:58:19 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC526A4
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 06:58:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b52418c25bso980785ad.0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687528695; x=1690120695;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMh92v7FmJIet/D7o4GtdhwQSs63s9qUb+QIp/5HgSg=;
        b=lfgJFZEepYFpQjn72g1qn3fLou0URBwVNXw5zGA3SgbTAJfzzjUECcjdT5ZTTjbWyD
         PyDYyS+fbgno6LP/QuGdvd46nTdEY2FkuARDJkxjA/d6xIlCn1aEfZQG0Mc9t8z3ycu+
         zeD3hKP2MRnrqjc4m986TssZdQUz4MT5bx9+100Bspuj/hd5V6pESA/vJiTCHKnovE8E
         tyY4ltWqiJAy1gyQG4Q3i8iIFMQ7YLGjJeNiQKFEPRnNuopeHf6zkSf6SXe6/JSHVu88
         qT8anihZ6jU3zpfcR369lO72zVe/DyYc6kq26zKs1Oidt5EUFlQy87Hz2HyGJE0YzaAj
         0KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528695; x=1690120695;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SMh92v7FmJIet/D7o4GtdhwQSs63s9qUb+QIp/5HgSg=;
        b=HLKhQi+0OmDhfks50lj6iuVnnQsHLkg+EA5ptpx9P4NWQSQKpCqXsRargZTZ8bd2Ej
         LBgbKWhbYlwPtPXv/oaIts3LmAT6VM3tFcvgoLa/hgyivnpgpMTcxysiMTlriNeRl1Vr
         /t02POu5nkQ89n1e7Lj9gVjI0Bc4FCZ+aoWwrOWK86i/EPrvhDYhT8Khr0tgz0EHHJbO
         pzRb54ggPiEhm2VzsgcSjhrQjtk4Opi+mWObqO0O93HB9jzAaTw1591S/RaZCi62GzpY
         MUUuf4775gA2URdY+I6odBkyc3s9ymMcj4+2CttWPohfYi5ApewhFXlSjWpljk8N60nU
         kE4Q==
X-Gm-Message-State: AC+VfDxHc6eD0Y3EIIR6FmOwMGZgMMiktEFAd9d/+lC+tBaK8kutsOPQ
        zubQhGpLCmWzdVanXz2tTjEazw==
X-Google-Smtp-Source: ACHHUZ4WC7SaMctOlL1+50OVWJQATlqQckiOQw3TfZt1akyLazGStau7wenVXJzJgJvE5JgxKjua4A==
X-Received: by 2002:a17:902:c945:b0:1ae:3ff8:7fa7 with SMTP id i5-20020a170902c94500b001ae3ff87fa7mr26133943pla.4.1687528695505;
        Fri, 23 Jun 2023 06:58:15 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001b5640a8874sm7228532plk.293.2023.06.23.06.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:58:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------lla0zGc0x6zfXmABeVukiT8m"
Message-ID: <b615f12d-dfe8-a613-f8b5-33b844179b68@kernel.dk>
Date:   Fri, 23 Jun 2023 07:58:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: serialize poll linked timer
 start with poll" failed to apply to 6.1-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, querijnqyn@gmail.com
Cc:     stable@vger.kernel.org
References: <2023062307-taco-nurture-70a2@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023062307-taco-nurture-70a2@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------lla0zGc0x6zfXmABeVukiT8m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/23 3:29?AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x ef7dfac51d8ed961b742218f526bd589f3900a59
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062307-taco-nurture-70a2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's this one for 6.1-stable, thanks.

-- 
Jens Axboe

--------------lla0zGc0x6zfXmABeVukiT8m
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-serialize-poll-linked-timer-start-with.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-serialize-poll-linked-timer-start-with.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0MzcyMWRlNGFhMzQ5YWRjZjc4NWUwMGNlZWNkZGNjNGE3MGFjOWYyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFNhdCwgMTcgSnVuIDIwMjMgMTk6NTA6MjQgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9wb2xsOiBzZXJpYWxpemUgcG9sbCBsaW5rZWQgdGltZXIgc3RhcnQgd2l0aCBw
b2xsCiByZW1vdmFsCgpDb21taXQgZWY3ZGZhYzUxZDhlZDk2MWI3NDIyMThmNTI2YmQ1ODlm
MzkwMGE1OSB1cHN0cmVhbS4KCldlIHNlbGVjdGl2ZWx5IGdyYWIgdGhlIGN0eC0+dXJpbmdf
bG9jayBmb3IgcG9sbCB1cGRhdGUvcmVtb3ZhbCwgYnV0CndlIHJlYWxseSBzaG91bGQgZ3Jh
YiBpdCBmcm9tIHRoZSBzdGFydCB0byBmdWxseSBzeW5jaHJvbml6ZSB3aXRoCmxpbmtlZCB0
aW1lb3V0cy4gTm9ybWFsbHkgdGhpcyBpcyBpbmRlZWQgdGhlIGNhc2UsIGJ1dCBpZiByZXF1
ZXN0cwphcmUgZm9yY2VkIGFzeW5jIGJ5IHRoZSBhcHBsaWNhdGlvbiwgd2UgZG9uJ3QgZnVs
bHkgY292ZXIgcmVtb3ZhbAphbmQgdGltZXIgZGlzYXJtIHdpdGhpbiB0aGUgdXJpbmdfbG9j
ay4KCk1ha2UgdGhpcyBzaW1wbGVyIGJ5IGhhdmluZyBjb25zaXN0ZW50IGxvY2tpbmcgc3Rh
dGUgZm9yIHBvbGwgcmVtb3ZhbC4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNi4x
KwpSZXBvcnRlZC1ieTogUXVlcmlqbiBWb2V0IDxxdWVyaWpucXluQGdtYWlsLmNvbT4KU2ln
bmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5n
L3BvbGwuYyB8IDkgKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3BvbGwuYyBiL2lvX3Vy
aW5nL3BvbGwuYwppbmRleCA0Nzg4MDczZWM0NWQuLjg2OWUxZDJhNDQxMyAxMDA2NDQKLS0t
IGEvaW9fdXJpbmcvcG9sbC5jCisrKyBiL2lvX3VyaW5nL3BvbGwuYwpAQCAtOTkzLDggKzk5
Myw5IEBAIGludCBpb19wb2xsX3JlbW92ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWdu
ZWQgaW50IGlzc3VlX2ZsYWdzKQogCXN0cnVjdCBpb19oYXNoX2J1Y2tldCAqYnVja2V0Owog
CXN0cnVjdCBpb19raW9jYiAqcHJlcTsKIAlpbnQgcmV0MiwgcmV0ID0gMDsKLQlib29sIGxv
Y2tlZDsKKwlib29sIGxvY2tlZCA9IHRydWU7CiAKKwlpb19yaW5nX3N1Ym1pdF9sb2NrKGN0
eCwgaXNzdWVfZmxhZ3MpOwogCXByZXEgPSBpb19wb2xsX2ZpbmQoY3R4LCB0cnVlLCAmY2Qs
ICZjdHgtPmNhbmNlbF90YWJsZSwgJmJ1Y2tldCk7CiAJcmV0MiA9IGlvX3BvbGxfZGlzYXJt
KHByZXEpOwogCWlmIChidWNrZXQpCkBAIC0xMDA2LDEyICsxMDA3LDEwIEBAIGludCBpb19w
b2xsX3JlbW92ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2Zs
YWdzKQogCQlnb3RvIG91dDsKIAl9CiAKLQlpb19yaW5nX3N1Ym1pdF9sb2NrKGN0eCwgaXNz
dWVfZmxhZ3MpOwogCXByZXEgPSBpb19wb2xsX2ZpbmQoY3R4LCB0cnVlLCAmY2QsICZjdHgt
PmNhbmNlbF90YWJsZV9sb2NrZWQsICZidWNrZXQpOwogCXJldDIgPSBpb19wb2xsX2Rpc2Fy
bShwcmVxKTsKIAlpZiAoYnVja2V0KQogCQlzcGluX3VubG9jaygmYnVja2V0LT5sb2NrKTsK
LQlpb19yaW5nX3N1Ym1pdF91bmxvY2soY3R4LCBpc3N1ZV9mbGFncyk7CiAJaWYgKHJldDIp
IHsKIAkJcmV0ID0gcmV0MjsKIAkJZ290byBvdXQ7CkBAIC0xMDM1LDcgKzEwMzQsNyBAQCBp
bnQgaW9fcG9sbF9yZW1vdmUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBp
c3N1ZV9mbGFncykKIAkJaWYgKHBvbGxfdXBkYXRlLT51cGRhdGVfdXNlcl9kYXRhKQogCQkJ
cHJlcS0+Y3FlLnVzZXJfZGF0YSA9IHBvbGxfdXBkYXRlLT5uZXdfdXNlcl9kYXRhOwogCi0J
CXJldDIgPSBpb19wb2xsX2FkZChwcmVxLCBpc3N1ZV9mbGFncyk7CisJCXJldDIgPSBpb19w
b2xsX2FkZChwcmVxLCBpc3N1ZV9mbGFncyAmIH5JT19VUklOR19GX1VOTE9DS0VEKTsKIAkJ
Lyogc3VjY2Vzc2Z1bGx5IHVwZGF0ZWQsIGRvbid0IGNvbXBsZXRlIHBvbGwgcmVxdWVzdCAq
LwogCQlpZiAoIXJldDIgfHwgcmV0MiA9PSAtRUlPQ0JRVUVVRUQpCiAJCQlnb3RvIG91dDsK
QEAgLTEwNDMsOSArMTA0Miw5IEBAIGludCBpb19wb2xsX3JlbW92ZShzdHJ1Y3QgaW9fa2lv
Y2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCiAJcmVxX3NldF9mYWlsKHBy
ZXEpOwogCWlvX3JlcV9zZXRfcmVzKHByZXEsIC1FQ0FOQ0VMRUQsIDApOwotCWxvY2tlZCA9
ICEoaXNzdWVfZmxhZ3MgJiBJT19VUklOR19GX1VOTE9DS0VEKTsKIAlpb19yZXFfdGFza19j
b21wbGV0ZShwcmVxLCAmbG9ja2VkKTsKIG91dDoKKwlpb19yaW5nX3N1Ym1pdF91bmxvY2so
Y3R4LCBpc3N1ZV9mbGFncyk7CiAJaWYgKHJldCA8IDApIHsKIAkJcmVxX3NldF9mYWlsKHJl
cSk7CiAJCXJldHVybiByZXQ7Ci0tIAoyLjQwLjEKCg==

--------------lla0zGc0x6zfXmABeVukiT8m--
