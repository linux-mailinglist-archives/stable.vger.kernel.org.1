Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59BD7186EE
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjEaQAr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjEaQAp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 12:00:45 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400489D
        for <stable@vger.kernel.org>; Wed, 31 May 2023 09:00:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-339fca7da2aso2013315ab.0
        for <stable@vger.kernel.org>; Wed, 31 May 2023 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685548841; x=1688140841;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e0Zipm4ryRBI1WKLQmzQw4c+87NxMQRn5k+gdSwpxFg=;
        b=RC90Lmvp+H9Atm4kAyp/3JJPIATNrh28/llVB3QlEVZDfDfbl+b3Dvq3pNsWrsNjjx
         Ly9CkFtEmoHXDNLtqLPe6i3AUm6B7AXw4Kcm9X+NeaF7u6teomnDXns86oQZQMbHh1i2
         AlyHc0vbdPidl96I2MIe5yP677+iA4FYmVZ5axbDFRQQifWkv290tVoKHe7WuPSfEvyb
         rIcz8zTlCnTkDNukAN+x/e75TxudTptBAbm//Ibf4/xeErCPcclxIrL8vneknqixLuGT
         SmHFHtBplcUlUiBdQy0U8N+fN58rf08vHB8GsBP6eA2plTGH7sQBqih2JNHmnMw4QGoc
         eIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548841; x=1688140841;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0Zipm4ryRBI1WKLQmzQw4c+87NxMQRn5k+gdSwpxFg=;
        b=ETR0RS11nq69WHKVU0wIZsA12Ul2W4HQdSzbbyJWVzDzcea/Qv7ACdrejDkTfQOI9D
         8uMHNtLWSbVUMmo7PBDTmm4vE0efdurzPSYSdWB5ulBitE5pF9C2tStmeXmf2BwwiIDx
         E/nbYge8rXgOE80yB+bAB5TlaDzBz2JQ6OmOiK9ndxL93pcetomKamF5n9NH5AUxmb+d
         oUBOy5mWSkhY48qgjCVlgNbp1u0+96n7uiW6iOHlxeS9o+822Dxuk6l6koWvBe5hK2gE
         DTgfeoytbKH5kIoaJW2/j/lFr+5hJsMLwn3tfgWnPtkCTFW2Zyszmrz+6h1kI6ukCqjG
         cwdw==
X-Gm-Message-State: AC+VfDwM88fesNnS3MWHKDTIenbbl+/cD2DV3RPGLN0DroCLOepvMiEi
        k2mNspCVj0EphLwMTQriQA8z9iEEzXS2Zu0SLWM=
X-Google-Smtp-Source: ACHHUZ6tl3tVFjco9AGAXzGTbWFiQOPrl8YxvN42zQqYvdXJY/rDuAkIOrflaKtrw+A2+BAiAW+iUg==
X-Received: by 2002:a6b:c9d1:0:b0:774:8d63:449c with SMTP id z200-20020a6bc9d1000000b007748d63449cmr1880869iof.0.1685548840948;
        Wed, 31 May 2023 09:00:40 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n14-20020a056638210e00b0040f8d42c110sm1521476jaj.95.2023.05.31.09.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 09:00:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------h1o9A55vxrZ28NfI0buD3XCp"
Message-ID: <6a5172c0-de90-d582-baae-37b8c4de1d91@kernel.dk>
Date:   Wed, 31 May 2023 10:00:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: 5.4-stable patches
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------h1o9A55vxrZ28NfI0buD3XCp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Greg, can you include these in the 5.4-stable batch for the next
release? Lee reported and issue that really ended up being two
separate bugs, I fixed these last week and Lee has tested them
as good. No real upstream commits exists for these, as we fixed
them separately with refactoring and cleanup of this code.

-- 
Jens Axboe

--------------h1o9A55vxrZ28NfI0buD3XCp
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-always-grab-lock-in-io_cancel_async_work.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-always-grab-lock-in-io_cancel_async_work.patch"
Content-Transfer-Encoding: base64

RnJvbSA0MmE5YjVmNjQ5MTI0NzYxYTRmZmQyNjBkMjY3Mjk1MDU2ZWVhMTEzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjMgTWF5IDIwMjMgMDg6MjM6MzIgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
M10gaW9fdXJpbmc6IGFsd2F5cyBncmFiIGxvY2sgaW4gaW9fY2FuY2VsX2FzeW5jX3dvcmso
KQoKTm8gdXBzdHJlYW0gY29tbWl0IGV4aXN0cyBmb3IgdGhpcyBwYXRjaC4KCkl0J3Mgbm90
IG5lY2Vzc2FyaWx5IHNhZmUgdG8gY2hlY2sgdGhlIHRhc2tfbGlzdCBsb2NrbGVzc2x5LCBy
ZW1vdmUKdGhpcyBtaWNybyBvcHRpbWl6YXRpb24gYW5kIGFsd2F5cyBncmFiIHRhc2tfbG9j
ayBiZWZvcmUgZGVlbWluZyBpdAplbXB0eS4KClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IExl
ZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4
Ym9lQGtlcm5lbC5kaz4KLS0tCiBmcy9pb191cmluZy5jIHwgMyAtLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2lvX3VyaW5nLmMgYi9mcy9p
b191cmluZy5jCmluZGV4IGU4ZGY2MzQ1YTgxMi4uY2M0YjY2MzUwNjhhIDEwMDY0NAotLS0g
YS9mcy9pb191cmluZy5jCisrKyBiL2ZzL2lvX3VyaW5nLmMKQEAgLTM3MzgsOSArMzczOCw2
IEBAIHN0YXRpYyB2b2lkIGlvX2NhbmNlbF9hc3luY193b3JrKHN0cnVjdCBpb19yaW5nX2N0
eCAqY3R4LAogewogCXN0cnVjdCBpb19raW9jYiAqcmVxOwogCi0JaWYgKGxpc3RfZW1wdHko
JmN0eC0+dGFza19saXN0KSkKLQkJcmV0dXJuOwotCiAJc3Bpbl9sb2NrX2lycSgmY3R4LT50
YXNrX2xvY2spOwogCiAJbGlzdF9mb3JfZWFjaF9lbnRyeShyZXEsICZjdHgtPnRhc2tfbGlz
dCwgdGFza19saXN0KSB7Ci0tIAoyLjM5LjIKCg==
--------------h1o9A55vxrZ28NfI0buD3XCp
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-don-t-drop-completion-lock-before-timer-is-.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-don-t-drop-completion-lock-before-timer-is-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2NjUxMmU5NTk2MDQ0MDU3ZmUyY2MxNzNhYzVjMzJlNGZiOGFlZDVjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjMgTWF5IDIwMjMgMDg6MjQ6MzEgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
M10gaW9fdXJpbmc6IGRvbid0IGRyb3AgY29tcGxldGlvbiBsb2NrIGJlZm9yZSB0aW1lciBp
cwogZnVsbHkgaW5pdGlhbGl6ZWQKCk5vIHVwc3RyZWFtIGNvbW1pdCBleGlzdHMgZm9yIHRo
aXMgcGF0Y2guCgpJZiB3ZSBkcm9wIHRoZSBsb2NrIHJpZ2h0IGFmdGVyIGFkZGluZyBpdCB0
byB0aGUgdGltZW91dCBsaXN0LCB0aGVuCnNvbWVvbmUgYXR0ZW1wdGluZyB0byBraWxsIHRp
bWVvdXRzIHdpbGwgZmluZCBpdCBpbiBhbiBpbmRldGVybWluYXRlCnN0YXRlLiBUaGF0IG1l
YW5zIHRoYXQgY2FuY2VsYXRpb24gY291bGQgYXR0ZW1wdCB0byBjYW5jZWwgYW5kIHJlbW92
ZQphIHRpbWVvdXQsIGFuZCB0aGVuIGlvX3RpbWVvdXQoKSBwcm9jZWVkcyB0byBpbml0IGFu
ZCBhZGQgdGhlIHRpbWVyCmFmdGVyd2FyZHMuCgpFbnN1cmUgdGhlIHRpbWVvdXQgcmVxdWVz
dCBpcyBmdWxseSBzZXR1cCBiZWZvcmUgd2UgZHJvcCB0aGUKY29tcGxldGlvbiBsb2NrLCB3
aGljaCBndWFyZHMgY2FuY2VsYXRpb24gYXMgd2VsbC4KClJlcG9ydGVkLWFuZC10ZXN0ZWQt
Ynk6IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhi
b2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBmcy9pb191cmluZy5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvaW9fdXJpbmcuYyBiL2ZzL2lvX3VyaW5nLmMKaW5kZXggY2M0YjY2MzUwNjhhLi43ZGJj
MDllNGM1ZTkgMTAwNjQ0Ci0tLSBhL2ZzL2lvX3VyaW5nLmMKKysrIGIvZnMvaW9fdXJpbmcu
YwpAQCAtMjA3OSwxMiArMjA3OSwxMiBAQCBzdGF0aWMgaW50IGlvX3RpbWVvdXQoc3RydWN0
IGlvX2tpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBpb191cmluZ19zcWUgKnNxZSkKIAlyZXEt
PnNlcXVlbmNlIC09IHNwYW47CiBhZGQ6CiAJbGlzdF9hZGQoJnJlcS0+bGlzdCwgZW50cnkp
OwotCXNwaW5fdW5sb2NrX2lycSgmY3R4LT5jb21wbGV0aW9uX2xvY2spOwogCiAJaHJ0aW1l
cl9pbml0KCZyZXEtPnRpbWVvdXQudGltZXIsIENMT0NLX01PTk9UT05JQywgSFJUSU1FUl9N
T0RFX1JFTCk7CiAJcmVxLT50aW1lb3V0LnRpbWVyLmZ1bmN0aW9uID0gaW9fdGltZW91dF9m
bjsKIAlocnRpbWVyX3N0YXJ0KCZyZXEtPnRpbWVvdXQudGltZXIsIHRpbWVzcGVjNjRfdG9f
a3RpbWUodHMpLAogCQkJSFJUSU1FUl9NT0RFX1JFTCk7CisJc3Bpbl91bmxvY2tfaXJxKCZj
dHgtPmNvbXBsZXRpb25fbG9jayk7CiAJcmV0dXJuIDA7CiB9CiAKLS0gCjIuMzkuMgoK
--------------h1o9A55vxrZ28NfI0buD3XCp
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-io_uring-have-io_kill_timeout-honor-the-request-refe.patch"
Content-Disposition: attachment;
 filename*0="0003-io_uring-have-io_kill_timeout-honor-the-request-refe.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjODM1MDUzYzk5MDc0MTk3ZDU1ODU3YzZkYjU1NzZhM2YwYWMxYzA4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjMgTWF5IDIwMjMgMDg6MjY6MDYgLTA2MDAKU3ViamVjdDogW1BBVENIIDMv
M10gaW9fdXJpbmc6IGhhdmUgaW9fa2lsbF90aW1lb3V0KCkgaG9ub3IgdGhlIHJlcXVlc3QK
IHJlZmVyZW5jZXMKCk5vIHVwc3RyZWFtIGNvbW1pdCBleGlzdHMgZm9yIHRoaXMgcGF0Y2gu
CgpEb24ndCBmcmVlIHRoZSByZXF1ZXN0IHVuY29uZGl0aW9uYWxseSwgaWYgdGhlIHJlcXVl
c3QgaXMgaXNzdWVkIGFzeW5jCnRoZW4gc29tZW9uZSBlbHNlIG1heSBiZSBob2xkaW5nIGEg
c3VibWl0IHJlZmVyZW5jZSB0byBpdC4KClJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IExlZSBK
b25lcyA8bGVlQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9l
QGtlcm5lbC5kaz4KLS0tCiBmcy9pb191cmluZy5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9pb191
cmluZy5jIGIvZnMvaW9fdXJpbmcuYwppbmRleCA3ZGJjMDllNGM1ZTkuLjM2ODNkZGViNjI1
YSAxMDA2NDQKLS0tIGEvZnMvaW9fdXJpbmcuYworKysgYi9mcy9pb191cmluZy5jCkBAIC01
NTEsNyArNTUxLDggQEAgc3RhdGljIHZvaWQgaW9fa2lsbF90aW1lb3V0KHN0cnVjdCBpb19r
aW9jYiAqcmVxKQogCQlhdG9taWNfaW5jKCZyZXEtPmN0eC0+Y3FfdGltZW91dHMpOwogCQls
aXN0X2RlbCgmcmVxLT5saXN0KTsKIAkJaW9fY3FyaW5nX2ZpbGxfZXZlbnQocmVxLT5jdHgs
IHJlcS0+dXNlcl9kYXRhLCAwKTsKLQkJX19pb19mcmVlX3JlcShyZXEpOworCQlpZiAocmVm
Y291bnRfZGVjX2FuZF90ZXN0KCZyZXEtPnJlZnMpKQorCQkJX19pb19mcmVlX3JlcShyZXEp
OwogCX0KIH0KIAotLSAKMi4zOS4yCgo=

--------------h1o9A55vxrZ28NfI0buD3XCp--
