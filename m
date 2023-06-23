Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8991673B950
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjFWOAz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjFWOAy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 10:00:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED1810D2
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 07:00:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25eb58f4e70so135071a91.0
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687528852; x=1690120852;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcM9SMTAvwKPOltGwXuYmCm0oJSfVVb3mS/TEjMM41I=;
        b=NNPL4f8VMwkubDuWnxZshM6DbLq+AAN+MTlzA1vaqpDgNxDUgoRmIlZtGaiON4dPQh
         GxtXQfCdZ4nwpoWbera3bLLFUTIrz8sHH3nHXJ4bw4P4KTUzkzHUpnb3jO7ZTe8O3zh7
         nhE0mYai1+IJ0xG7tR4IIi7btdh9vN7SF5iS6hPs82vcMVYU2cR6F4DAFXfvz/anUyNm
         wN6E5aKPDKMKVRTLhgcRbV/8auPDSUnO9/GdHDKKRe/PVygwK2lV2ZUKZXBnntC3IcyF
         YmhKcymw6eMJ/YAV5ONjH3aXQT+XI5uuVqt+LIHPLbDqRyePNUSc8Ezhem10XcvY4dqu
         8CVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687528852; x=1690120852;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lcM9SMTAvwKPOltGwXuYmCm0oJSfVVb3mS/TEjMM41I=;
        b=KWHhhrBfukgosUgejI+OSEBGJJyVZInDdRxv/JZSqEUMsTU65iPXmhIqIlF/tk11fn
         ZYrLcQspb05rVI9uIy6BLqBlweZZg4MERn2qcsyTym1vuumsVjFx3jRkh8udWhdOgZyS
         QVOQp8NPYu7Pz8bpWEB4GdNzgdpxJ4sVAbQ8NyJ/w6K7xZ2A8RMfV+nfsH8PXi+DQ+ka
         /HzfrCOoCMV7VMnJD8O/s+Hx4avMNU0ebP8eE8RvmLtdHcgE3eUttX3UxlOecK39APg0
         8jNdHHjd+NYAkF+V5HYwXa9b4ibzOIqO2j0Ky6uVriUgh368pRINAisSq+OSLKbIadDp
         Aktw==
X-Gm-Message-State: AC+VfDw6dHcbCDxhRsS3pOmH0d7JhsMrV9gvqtA/7Y20bQhabDfuX4iH
        X+mOo2SGTPiF4iYZtWKz+kIzpom+9/IRGaVROvQ=
X-Google-Smtp-Source: ACHHUZ5DUbwSh15zP4tu8P3BY2lTg4rdbV8WmViEzB4R/41+hSVJKNYfqvW07p2/kXflEX0xBznThA==
X-Received: by 2002:a05:6a20:7da6:b0:11b:3e33:d2ce with SMTP id v38-20020a056a207da600b0011b3e33d2cemr26615017pzj.1.1687528852037;
        Fri, 23 Jun 2023 07:00:52 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l15-20020a62be0f000000b0066145d63b1asm6071506pff.138.2023.06.23.07.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 07:00:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------uWuCBzdmRZdYP006D40l4IwK"
Message-ID: <9eb39513-6c3b-adb1-dcec-930bc5e3bbd3@kernel.dk>
Date:   Fri, 23 Jun 2023 08:00:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: serialize poll linked timer
 start with poll" failed to apply to 6.3-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, querijnqyn@gmail.com
Cc:     stable@vger.kernel.org
References: <2023062306-omen-dance-80f0@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023062306-omen-dance-80f0@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------uWuCBzdmRZdYP006D40l4IwK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/23 3:29?AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.3-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
> git checkout FETCH_HEAD
> git cherry-pick -x ef7dfac51d8ed961b742218f526bd589f3900a59
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062306-omen-dance-80f0@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Here's this one for 6.3-stable.

-- 
Jens Axboe

--------------uWuCBzdmRZdYP006D40l4IwK
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-serialize-poll-linked-timer-start-with.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-serialize-poll-linked-timer-start-with.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2ZDQ2ODRlODFhMjhhOTY0N2UyNjNhNTMyMjgxYmIzYTAyMDI4MmZjIE1vbiBTZXAg
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
aW5nL3BvbGwuYwppbmRleCA1NTMwNmU4MDEwODEuLmUzNDZhNTE4ZGZjZiAxMDA2NDQKLS0t
IGEvaW9fdXJpbmcvcG9sbC5jCisrKyBiL2lvX3VyaW5nL3BvbGwuYwpAQCAtOTc3LDggKzk3
Nyw5IEBAIGludCBpb19wb2xsX3JlbW92ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWdu
ZWQgaW50IGlzc3VlX2ZsYWdzKQogCXN0cnVjdCBpb19oYXNoX2J1Y2tldCAqYnVja2V0Owog
CXN0cnVjdCBpb19raW9jYiAqcHJlcTsKIAlpbnQgcmV0MiwgcmV0ID0gMDsKLQlib29sIGxv
Y2tlZDsKKwlib29sIGxvY2tlZCA9IHRydWU7CiAKKwlpb19yaW5nX3N1Ym1pdF9sb2NrKGN0
eCwgaXNzdWVfZmxhZ3MpOwogCXByZXEgPSBpb19wb2xsX2ZpbmQoY3R4LCB0cnVlLCAmY2Qs
ICZjdHgtPmNhbmNlbF90YWJsZSwgJmJ1Y2tldCk7CiAJcmV0MiA9IGlvX3BvbGxfZGlzYXJt
KHByZXEpOwogCWlmIChidWNrZXQpCkBAIC05OTAsMTIgKzk5MSwxMCBAQCBpbnQgaW9fcG9s
bF9yZW1vdmUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFn
cykKIAkJZ290byBvdXQ7CiAJfQogCi0JaW9fcmluZ19zdWJtaXRfbG9jayhjdHgsIGlzc3Vl
X2ZsYWdzKTsKIAlwcmVxID0gaW9fcG9sbF9maW5kKGN0eCwgdHJ1ZSwgJmNkLCAmY3R4LT5j
YW5jZWxfdGFibGVfbG9ja2VkLCAmYnVja2V0KTsKIAlyZXQyID0gaW9fcG9sbF9kaXNhcm0o
cHJlcSk7CiAJaWYgKGJ1Y2tldCkKIAkJc3Bpbl91bmxvY2soJmJ1Y2tldC0+bG9jayk7Ci0J
aW9fcmluZ19zdWJtaXRfdW5sb2NrKGN0eCwgaXNzdWVfZmxhZ3MpOwogCWlmIChyZXQyKSB7
CiAJCXJldCA9IHJldDI7CiAJCWdvdG8gb3V0OwpAQCAtMTAxOSw3ICsxMDE4LDcgQEAgaW50
IGlvX3BvbGxfcmVtb3ZlKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNz
dWVfZmxhZ3MpCiAJCWlmIChwb2xsX3VwZGF0ZS0+dXBkYXRlX3VzZXJfZGF0YSkKIAkJCXBy
ZXEtPmNxZS51c2VyX2RhdGEgPSBwb2xsX3VwZGF0ZS0+bmV3X3VzZXJfZGF0YTsKIAotCQly
ZXQyID0gaW9fcG9sbF9hZGQocHJlcSwgaXNzdWVfZmxhZ3MpOworCQlyZXQyID0gaW9fcG9s
bF9hZGQocHJlcSwgaXNzdWVfZmxhZ3MgJiB+SU9fVVJJTkdfRl9VTkxPQ0tFRCk7CiAJCS8q
IHN1Y2Nlc3NmdWxseSB1cGRhdGVkLCBkb24ndCBjb21wbGV0ZSBwb2xsIHJlcXVlc3QgKi8K
IAkJaWYgKCFyZXQyIHx8IHJldDIgPT0gLUVJT0NCUVVFVUVEKQogCQkJZ290byBvdXQ7CkBA
IC0xMDI3LDkgKzEwMjYsOSBAQCBpbnQgaW9fcG9sbF9yZW1vdmUoc3RydWN0IGlvX2tpb2Ni
ICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAogCXJlcV9zZXRfZmFpbChwcmVx
KTsKIAlpb19yZXFfc2V0X3JlcyhwcmVxLCAtRUNBTkNFTEVELCAwKTsKLQlsb2NrZWQgPSAh
KGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdfRl9VTkxPQ0tFRCk7CiAJaW9fcmVxX3Rhc2tfY29t
cGxldGUocHJlcSwgJmxvY2tlZCk7CiBvdXQ6CisJaW9fcmluZ19zdWJtaXRfdW5sb2NrKGN0
eCwgaXNzdWVfZmxhZ3MpOwogCWlmIChyZXQgPCAwKSB7CiAJCXJlcV9zZXRfZmFpbChyZXEp
OwogCQlyZXR1cm4gcmV0OwotLSAKMi40MC4xCgo=

--------------uWuCBzdmRZdYP006D40l4IwK--
