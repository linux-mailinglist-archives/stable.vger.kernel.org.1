Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB376B7D3
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjHAOkw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjHAOkv (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 10:40:51 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812EF9C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 07:40:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77dcff76e35so68501839f.1
        for <stable@vger.kernel.org>; Tue, 01 Aug 2023 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690900849; x=1691505649;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1L/yRfhczA+K9HTkdURfAmb9Sge6klhXvkwBfJM7Ug=;
        b=K8L9KJKVO6eqi3+ZPE/OcVTwWYGWUl+ifRjm7dvonBrrYuihfXPL4k5iCj3tjpbSTo
         c4xm278FGQPuah1P9H0mFS+rUnxsqXi90Mxp/W19RXuVH9dSv6gWNIyWzCbtObBZnWb6
         BOI8JFHUComeRaNPeyWJ+DkDs01TFW2kNAZMEQuih6BiUgcGkIUvVyUictjIlfq/AREs
         hpgLTg5/CMMY9FCFInxG+RfUV8mU5ZjcbWtYWr1Z0N/1J/tyJ6vuHHzBF4cpN0p+9+1T
         bQDyL5l2GjTf3L6A31yqhKSjHkQJgwgGZiRV6/IdAy4R+NFgJX8IZPuRef1OgbwhJrXA
         Lcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900849; x=1691505649;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a1L/yRfhczA+K9HTkdURfAmb9Sge6klhXvkwBfJM7Ug=;
        b=IE+ynAxwNi8f0d3G/E/cv47vAr/GZflBtzLwW5JO8NmcBKFgd9Y92uja6A3ZH6DXe1
         SSejvuBozi9X/wWfSGdN3K09nohmemUavtDPR9JtX4CjKZOpG91rL1F3WzHb8ualDRII
         g283qE1JNcoaA/Eawc+fo6ieZ0zwHwEWCkqG2Sv2ERE7qXBfY0AlfoOUu2MZnmOovhac
         R0AN9GL5WD4s0GRq+alCBzZ7YDEH/yl40UU0bKelmJANHIv9bG7CGhDN8lbmezrKnYWa
         0XUQrW5lkUtWILGhOFK3jnXCV2FC26Rn0y4SofqjHKcrn3ZHLGbuGrW3Qmjv2fti576o
         roHQ==
X-Gm-Message-State: ABy/qLa1v3YSZORnJKwvPL9MOD5S11TKkLYLiR6PBmEE0ayygzeV8Q2w
        nqXXZYh/JIykrqhdsUdT1befYA==
X-Google-Smtp-Source: APBJJlHWJbDb4UvNT+NfiEkNukviMlArbX99MP3a2IFpCfJtGGlxmdW4i9P3RNxqJniHdGgBBnDKew==
X-Received: by 2002:a6b:b797:0:b0:783:63e8:3bfc with SMTP id h145-20020a6bb797000000b0078363e83bfcmr11581279iof.0.1690900848852;
        Tue, 01 Aug 2023 07:40:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x6-20020a029706000000b0042b76deb22fsm3711201jai.92.2023.08.01.07.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 07:40:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------PsXVxCzCuYB4eAjR60MfDwAx"
Message-ID: <cba84dcc-8e49-7251-67ab-2befb4f7c985@kernel.dk>
Date:   Tue, 1 Aug 2023 08:40:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: patch "[PATCH] io_uring: gate iowait schedule on having
 pending requests" failed to apply to 5.15-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, andres@anarazel.de,
        oleksandr@natalenko.name, phil@raspberrypi.com
Cc:     stable@vger.kernel.org
References: <2023080154-handed-folic-f52f@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023080154-handed-folic-f52f@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------PsXVxCzCuYB4eAjR60MfDwAx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/23 11:53?PM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 7b72d661f1f2f950ab8c12de7e2bc48bdac8ed69
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080154-handed-folic-f52f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's one for both 5.10-stable ad 5.15-stable.

-- 
Jens Axboe

--------------PsXVxCzCuYB4eAjR60MfDwAx
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-gate-iowait-schedule-on-having-pending-requ.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-gate-iowait-schedule-on-having-pending-requ.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiY2E2Mzk1NGZlMDAyMmE5YzBkYzA2Yjk0ZjY4MjcxYzk1Njg3NWIyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMSBBdWcgMjAyMyAwODozOTo0NyAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nOiBnYXRlIGlvd2FpdCBzY2hlZHVsZSBvbiBoYXZpbmcgcGVuZGluZyByZXF1ZXN0
cwoKQ29tbWl0IDdiNzJkNjYxZjFmMmY5NTBhYjhjMTJkZTdlMmJjNDhiZGFjOGVkNjkgdXBz
dHJlYW0uCgpBIHByZXZpb3VzIGNvbW1pdCBtYWRlIGFsbCBjcXJpbmcgd2FpdHMgbWFya2Vk
IGFzIGlvd2FpdCwgYXMgYSB3YXkgdG8KaW1wcm92ZSBwZXJmb3JtYW5jZSBmb3Igc2hvcnQg
c2NoZWR1bGVzIHdpdGggcGVuZGluZyBJTy4gSG93ZXZlciwgZm9yCnVzZSBjYXNlcyB0aGF0
IGhhdmUgYSBzcGVjaWFsIHJlYXBlciB0aHJlYWQgdGhhdCBkb2VzIG5vdGhpbmcgYnV0Cndh
aXQgb24gZXZlbnRzIG9uIHRoZSByaW5nLCB0aGlzIGNhdXNlcyBhIGNvc21ldGljIGlzc3Vl
IHdoZXJlIHdlCmtub3cgaGF2ZSBvbmUgY29yZSBtYXJrZWQgYXMgYmVpbmcgImJ1c3kiIHdp
dGggMTAwJSBpb3dhaXQuCgpXaGlsZSB0aGlzIGlzbid0IGEgZ3JhdmUgaXNzdWUsIGl0IGlz
IGNvbmZ1c2luZyB0byB1c2Vycy4gUmF0aGVyIHRoYW4KYWx3YXlzIG1hcmsgdXMgYXMgYmVp
bmcgaW4gaW93YWl0LCBnYXRlIHNldHRpbmcgb2YgY3VycmVudC0+aW5faW93YWl0CnRvIDEg
Ynkgd2hldGhlciBvciBub3QgdGhlIHdhaXRpbmcgdGFzayBoYXMgcGVuZGluZyByZXF1ZXN0
cy4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2lvLXVyaW5nL0NBTUVHSkoyUnhvcGZOUTdHTkxocjdYOT1iSFhLbytHNU9PZTBM
VXE9K1VnTFhzdjFYZ0BtYWlsLmdtYWlsLmNvbS8KTGluazogaHR0cHM6Ly9idWd6aWxsYS5r
ZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc2OTkKTGluazogaHR0cHM6Ly9idWd6aWxs
YS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc3MDAKUmVwb3J0ZWQtYnk6IE9sZWtz
YW5kciBOYXRhbGVua28gPG9sZWtzYW5kckBuYXRhbGVua28ubmFtZT4KUmVwb3J0ZWQtYnk6
IFBoaWwgRWx3ZWxsIDxwaGlsQHJhc3BiZXJyeXBpLmNvbT4KVGVzdGVkLWJ5OiBBbmRyZXMg
RnJldW5kIDxhbmRyZXNAYW5hcmF6ZWwuZGU+CkZpeGVzOiA4YTc5NjU2NWNlYzMgKCJpb191
cmluZzogVXNlIGlvX3NjaGVkdWxlKiBpbiBjcXJpbmcgd2FpdCIpClNpZ25lZC1vZmYtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9pb191cmluZy5j
IHwgMjMgKysrKysrKysrKysrKysrKystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3Vy
aW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmluZGV4IGQ3Zjg3MTU3YmU5YS4uNzBmMzM3
N2Y2NzVjIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191cmluZy5jCisrKyBiL2lvX3VyaW5n
L2lvX3VyaW5nLmMKQEAgLTc3OTQsMTIgKzc3OTQsMjEgQEAgc3RhdGljIGludCBpb19ydW5f
dGFza193b3JrX3NpZyh2b2lkKQogCXJldHVybiAtRUlOVFI7CiB9CiAKK3N0YXRpYyBib29s
IGN1cnJlbnRfcGVuZGluZ19pbyh2b2lkKQoreworCXN0cnVjdCBpb191cmluZ190YXNrICp0
Y3R4ID0gY3VycmVudC0+aW9fdXJpbmc7CisKKwlpZiAoIXRjdHgpCisJCXJldHVybiBmYWxz
ZTsKKwlyZXR1cm4gcGVyY3B1X2NvdW50ZXJfcmVhZF9wb3NpdGl2ZSgmdGN0eC0+aW5mbGln
aHQpOworfQorCiAvKiB3aGVuIHJldHVybnMgPjAsIHRoZSBjYWxsZXIgc2hvdWxkIHJldHJ5
ICovCiBzdGF0aWMgaW5saW5lIGludCBpb19jcXJpbmdfd2FpdF9zY2hlZHVsZShzdHJ1Y3Qg
aW9fcmluZ19jdHggKmN0eCwKIAkJCQkJICBzdHJ1Y3QgaW9fd2FpdF9xdWV1ZSAqaW93cSwK
IAkJCQkJICBrdGltZV90ICp0aW1lb3V0KQogewotCWludCB0b2tlbiwgcmV0OworCWludCBp
b193YWl0LCByZXQ7CiAKIAkvKiBtYWtlIHN1cmUgd2UgcnVuIHRhc2tfd29yayBiZWZvcmUg
Y2hlY2tpbmcgZm9yIHNpZ25hbHMgKi8KIAlyZXQgPSBpb19ydW5fdGFza193b3JrX3NpZygp
OwpAQCAtNzgxMCwxNSArNzgxOSwxNyBAQCBzdGF0aWMgaW5saW5lIGludCBpb19jcXJpbmdf
d2FpdF9zY2hlZHVsZShzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwKIAkJcmV0dXJuIDE7CiAK
IAkvKgotCSAqIFVzZSBpb19zY2hlZHVsZV9wcmVwYXJlL2ZpbmlzaCwgc28gY3B1ZnJlcSBj
YW4gdGFrZSBpbnRvIGFjY291bnQKLQkgKiB0aGF0IHRoZSB0YXNrIGlzIHdhaXRpbmcgZm9y
IElPIC0gdHVybnMgb3V0IHRvIGJlIGltcG9ydGFudCBmb3IgbG93Ci0JICogUUQgSU8uCisJ
ICogTWFyayB1cyBhcyBiZWluZyBpbiBpb193YWl0IGlmIHdlIGhhdmUgcGVuZGluZyByZXF1
ZXN0cywgc28gY3B1ZnJlcQorCSAqIGNhbiB0YWtlIGludG8gYWNjb3VudCB0aGF0IHRoZSB0
YXNrIGlzIHdhaXRpbmcgZm9yIElPIC0gdHVybnMgb3V0CisJICogdG8gYmUgaW1wb3J0YW50
IGZvciBsb3cgUUQgSU8uCiAJICovCi0JdG9rZW4gPSBpb19zY2hlZHVsZV9wcmVwYXJlKCk7
CisJaW9fd2FpdCA9IGN1cnJlbnQtPmluX2lvd2FpdDsKKwlpZiAoY3VycmVudF9wZW5kaW5n
X2lvKCkpCisJCWN1cnJlbnQtPmluX2lvd2FpdCA9IDE7CiAJcmV0ID0gMTsKIAlpZiAoIXNj
aGVkdWxlX2hydGltZW91dCh0aW1lb3V0LCBIUlRJTUVSX01PREVfQUJTKSkKIAkJcmV0ID0g
LUVUSU1FOwotCWlvX3NjaGVkdWxlX2ZpbmlzaCh0b2tlbik7CisJY3VycmVudC0+aW5faW93
YWl0ID0gaW9fd2FpdDsKIAlyZXR1cm4gcmV0OwogfQogCi0tIAoyLjQwLjEKCg==

--------------PsXVxCzCuYB4eAjR60MfDwAx--
