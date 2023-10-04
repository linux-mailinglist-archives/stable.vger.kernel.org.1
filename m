Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B737B8297
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbjJDOoa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbjJDOo3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:44:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F25C0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:44:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-351265d0d67so2311365ab.0
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696430665; x=1697035465; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzQGhdNEK5Ha0W7GXJjIhIyUnIirquP3TFLkoonx4Kk=;
        b=2bX3j9RCfjbeM6Z4blRj8K2dWD6S2q3SAhjWsSiAHP2wxVhzQeq8h1rlR2Ihq3LFRW
         nqdLp1/dWjoEWQOh1EYEqo5eYfo2bx+Hbw+3M8bli+TYuYWesVcSa7Vll9P4Op2CTjc2
         9LK1SByZ0BdUe6Y1ovVtunAdnu2Qi1YbShHd2VbNYCQuPTo8SX66Cig9mNeeyv/mEvRW
         Qh0N/AlcIzqUbATO8tfw3/6dL70dJHZKEnJtPi9pg45siVpmh/pyoJHtir0ix96zGN3t
         vrAlL7euGlcg5BiDnk0Vbt0Tq8j0fg17qp6v3fKazCwCQllyPAHSufjp+c/My58+8CH/
         C1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430665; x=1697035465;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BzQGhdNEK5Ha0W7GXJjIhIyUnIirquP3TFLkoonx4Kk=;
        b=wAk/aNO324MPQJeWgQFsDCDI+kLGDDvDTr948Sg/LhZypX/IWvJQXtdSToovVptiUe
         4fzKBxAuxmsIzHsAvrsplkZlNqqZN07sHMq+U991ZMZinE/p8O0w/lGZCp93UV+EDa2s
         5BGTm7HI7ZUy1LG8zMdMs6uJ2Vm5tONkEKLr7asmiCVyNxYk1vT7h7tPdNRVg30iiAnh
         AFHnIRTXLV96xkg0RRgHBNei5j8v9ibX+iz8g4er09WshNfZvRyEg2YPEyvR1Ii5sCU9
         znw3BjTFrJJ+Ph72oXkkLOihO9lzWQgeBo3jJdbREtrZfirBFtfMxwgqZqTvtKZ19FCy
         UWKA==
X-Gm-Message-State: AOJu0Yy47XTcI9S3fGJK2kw6atrtlDgfmY79DehECXv24dHQ5UksfdjG
        vIrofsbem0/I+EUmpEqk0aT/qg==
X-Google-Smtp-Source: AGHT+IFh0vVEXhyLxa1BhE3LMsd8KsaljwcdmgKPOEcQGLC2UDKiAbydyYeJrS/YhD50efjBPXmoYA==
X-Received: by 2002:a6b:5d01:0:b0:794:cbb8:725e with SMTP id r1-20020a6b5d01000000b00794cbb8725emr2201954iob.2.1696430665129;
        Wed, 04 Oct 2023 07:44:25 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fq22-20020a056638651600b0041e328a2084sm983479jab.79.2023.10.04.07.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 07:44:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ICbHr0aRKOEKZ0drSUEY3ulR"
Message-ID: <2c6fec36-ec1c-418b-a40a-262ed3ce980d@kernel.dk>
Date:   Wed, 4 Oct 2023 08:44:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/fs: remove sqe->rw_flags checking
 from LINKAT" failed to apply to 5.15-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, talex5@gmail.com
Cc:     stable@vger.kernel.org
References: <2023100446-broiler-liquid-20a4@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023100446-broiler-liquid-20a4@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------ICbHr0aRKOEKZ0drSUEY3ulR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/23 8:33 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x a52d4f657568d6458e873f74a9602e022afe666f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100446-broiler-liquid-20a4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's one that applies (and works) against 5.15-stable, thanks.

-- 
Jens Axboe


--------------ICbHr0aRKOEKZ0drSUEY3ulR
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-fs-remove-sqe-rw_flags-checking-from-LINKAT.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-fs-remove-sqe-rw_flags-checking-from-LINKAT.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2ZjNkOTVmOGQ2OTFmMTQzNmM4YmEzYzE0MDYwY2RjZTI2N2JlYzM4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFdlZCwgNCBPY3QgMjAyMyAwODo0MzoxMyAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nL2ZzOiByZW1vdmUgc3FlLT5yd19mbGFncyBjaGVja2luZyBmcm9tIExJTktBVAoK
Y29tbWl0IGE1MmQ0ZjY1NzU2OGQ2NDU4ZTg3M2Y3NGE5NjAyZTAyMmFmZTY2NmYgdXBzdHJl
YW0uCgpUaGlzIGlzIHVuaW9uaXplZCB3aXRoIHRoZSBhY3R1YWwgbGluayBmbGFncywgc28g
dGhleSBjYW4gb2YgY291cnNlIGJlCnNldCBhbmQgdGhleSB3aWxsIGJlIGV2YWx1YXRlZCBm
dXJ0aGVyIGRvd24uIElmIG5vdCB3ZSBmYWlsIGFueSBMSU5LQVQKdGhhdCBoYXMgdG8gc2V0
IG9wdGlvbiBmbGFncy4KCkZpeGVzOiBjZjMwZGE5MGJjM2EgKCJpb191cmluZzogYWRkIHN1
cHBvcnQgZm9yIElPUklOR19PUF9MSU5LQVQiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZwpSZXBvcnRlZC1ieTogVGhvbWFzIExlb25hcmQgPHRhbGV4NUBnbWFpbC5jb20+Ckxpbms6
IGh0dHBzOi8vZ2l0aHViLmNvbS9heGJvZS9saWJ1cmluZy9pc3N1ZXMvOTU1ClNpZ25lZC1v
ZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9pb191
cmluZy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lv
X3VyaW5nLmMKaW5kZXggMTUxOTEyNWI5ODE0Li5kMDBiZWRmZGFkYmIgMTAwNjQ0Ci0tLSBh
L2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpAQCAtNDAz
OCw3ICs0MDM4LDcgQEAgc3RhdGljIGludCBpb19saW5rYXRfcHJlcChzdHJ1Y3QgaW9fa2lv
Y2IgKnJlcSwKIAogCWlmICh1bmxpa2VseShyZXEtPmN0eC0+ZmxhZ3MgJiBJT1JJTkdfU0VU
VVBfSU9QT0xMKSkKIAkJcmV0dXJuIC1FSU5WQUw7Ci0JaWYgKHNxZS0+aW9wcmlvIHx8IHNx
ZS0+cndfZmxhZ3MgfHwgc3FlLT5idWZfaW5kZXggfHwgc3FlLT5zcGxpY2VfZmRfaW4pCisJ
aWYgKHNxZS0+aW9wcmlvIHx8IHNxZS0+YnVmX2luZGV4IHx8IHNxZS0+c3BsaWNlX2ZkX2lu
KQogCQlyZXR1cm4gLUVJTlZBTDsKIAlpZiAodW5saWtlbHkocmVxLT5mbGFncyAmIFJFUV9G
X0ZJWEVEX0ZJTEUpKQogCQlyZXR1cm4gLUVCQURGOwotLSAKMi40MC4xCgo=

--------------ICbHr0aRKOEKZ0drSUEY3ulR--
