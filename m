Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446867DA744
	for <lists+stable@lfdr.de>; Sat, 28 Oct 2023 15:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJ1Nch (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 28 Oct 2023 09:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJ1Nch (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 28 Oct 2023 09:32:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE7F2
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 06:32:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ba8eb7e581so725928b3a.0
        for <stable@vger.kernel.org>; Sat, 28 Oct 2023 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698499953; x=1699104753; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T041ixxnvhafNcdpb+6fEk5vob14laLTIxwrb91Yvgs=;
        b=EXmiS4yxOn0FbWJlqs+r6lP3bcIwLVrglaXwTgKsttRhvaQvpkDL5ltEhaJk/1afvM
         v6nVnEK4sW3pRbH8OJLyH3kqGDDgoPW5bIJw6tKvGs7PSW1Zc5n2qa90aC0etz9wWnXb
         EKZs+sWbCJEx8OWnbDOK8fdqvoZSKxJWg1xFpndRflAMQRg/BTkyync9yoJEEURAaq0t
         j3MXXEY9WzBF7JeYzwsZXgYj8CuFrp5jexEq9GhSE54RgbCVkjAXdJUxiUE5qg+vSvrR
         5uUElgOuVWooMlbmXbkoijU2FH8d1zqmNaL1Da8MJXsBLCeyRqe/w/qc3exPQNsgTI9d
         Q4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698499953; x=1699104753;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T041ixxnvhafNcdpb+6fEk5vob14laLTIxwrb91Yvgs=;
        b=J2P79Kn1ReOx1JBYrl0CP6rFWMs+Jjq44Lh8LF+jYea697pvRwMqYlSfq7FRF8ZzuC
         pDpaGn6djAx9TXd8/3L7jnGx5CAAW73HT0ZJ5+MICLxtgM0l7xPxVp354Ux0fvr7AmgL
         HoGA5R6A7GJAbnRoi5UVnVhMGEP6FBJBLZbdDwG0H9fK9yutUUbe845wiJpkucyUMKKs
         YtehMLGYMB6+yQEQlbDZlN2/AnoNiPMwIM9jt2LFPRrpe4g/fmx98+CaZzT3Dl2GM2bH
         QSa9i8wNGBC/zYUvHR7AeyHNrM3cNiJ9xQe4/HAS1IcklmbraOGmv3KeQMj8Ij+XFNMs
         X1ug==
X-Gm-Message-State: AOJu0YwJfEyUj3hPSHM8+m+G1OT4W61liKF2mEXnk2/YFsv2r7UCeATl
        osU/NHPq31sOToeFhAv3cmu+ngtOY6nFsUU0X8Z30Q==
X-Google-Smtp-Source: AGHT+IGiGmj02+MJjsoyPABw4x77d4kFQ/jnS5p7IVOD/xVuriB5nVCHUHxMh8cZpnl5H8Wetwwv6w==
X-Received: by 2002:a05:6a20:5483:b0:17a:d292:25d1 with SMTP id i3-20020a056a20548300b0017ad29225d1mr7618795pzk.6.1698499953113;
        Sat, 28 Oct 2023 06:32:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id j20-20020a633c14000000b005703a63836esm2366094pga.57.2023.10.28.06.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 06:32:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------MkUO0tE4Apiin8h43Ry41aUh"
Message-ID: <5223b572-03a1-4e04-93ea-da4c2ed4d597@kernel.dk>
Date:   Sat, 28 Oct 2023 07:32:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/fdinfo: lock SQ thread while
 retrieving thread" failed to apply to 6.1-stable tree
Content-Language: en-US
To:     gregkh@linuxfoundation.org, krisman@suse.de
Cc:     stable@vger.kernel.org
References: <2023102835-margarine-credibly-e8ca@gregkh>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023102835-margarine-credibly-e8ca@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a multi-part message in MIME format.
--------------MkUO0tE4Apiin8h43Ry41aUh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/23 1:27 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This one applies to both 6.1 and 6.5-stable.

-- 
Jens Axboe


--------------MkUO0tE4Apiin8h43Ry41aUh
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-fdinfo-lock-SQ-thread-while-retrieving-thre.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-fdinfo-lock-SQ-thread-while-retrieving-thre.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3NDA4NjM0MTNlYTJkMTJhYjMxZjFiZTNkMjNiMDFlMjQ2YzJmYTFjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFNhdCwgMjggT2N0IDIwMjMgMDc6MzA6MjcgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9mZGluZm86IGxvY2sgU1EgdGhyZWFkIHdoaWxlIHJldHJpZXZpbmcgdGhyZWFk
CiBjcHUvcGlkCgpjb21taXQgNzY0NGIxYTFjOWE3YWU4YWI5OTE3NTk4OWJmYzg2NzYwNTVl
ZGI0NiB1cHN0cmVhbS4KCldlIGNvdWxkIHJhY2Ugd2l0aCBTUSB0aHJlYWQgZXhpdCwgYW5k
IGlmIHdlIGRvLCB3ZSdsbCBoaXQgYSBOVUxMIHBvaW50ZXIKZGVyZWZlcmVuY2Ugd2hlbiB0
aGUgdGhyZWFkIGlzIGNsZWFyZWQuIEdyYWIgdGhlIFNRUE9MTCBkYXRhIGxvY2sgYmVmb3Jl
CmF0dGVtcHRpbmcgdG8gZ2V0IHRoZSB0YXNrIGNwdSBhbmQgcGlkIGZvciBmZGluZm8sIHRo
aXMgZW5zdXJlcyB3ZSBoYXZlIGEKc3RhYmxlIHZpZXcgb2YgaXQuCgpDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwpMaW5rOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19i
dWcuY2dpP2lkPTIxODAzMgpSZXZpZXdlZC1ieTogR2FicmllbCBLcmlzbWFuIEJlcnRhemkg
PGtyaXNtYW5Ac3VzZS5kZT4KU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPgotLS0KIGlvX3VyaW5nL2ZkaW5mby5jIHwgMTggKysrKysrKysrKysrLS0tLS0t
CiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pb191cmluZy9mZGluZm8uYyBiL2lvX3VyaW5nL2ZkaW5mby5jCmluZGV4
IDg4MmJkNTZiMDFlZC4uZWEyYzJkZWQ0ZTQxIDEwMDY0NAotLS0gYS9pb191cmluZy9mZGlu
Zm8uYworKysgYi9pb191cmluZy9mZGluZm8uYwpAQCAtNTEsNyArNTEsNiBAQCBzdGF0aWMg
X19jb2xkIGludCBpb191cmluZ19zaG93X2NyZWQoc3RydWN0IHNlcV9maWxlICptLCB1bnNp
Z25lZCBpbnQgaWQsCiBzdGF0aWMgX19jb2xkIHZvaWQgX19pb191cmluZ19zaG93X2ZkaW5m
byhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwKIAkJCQkJICBzdHJ1Y3Qgc2VxX2ZpbGUgKm0p
CiB7Ci0Jc3RydWN0IGlvX3NxX2RhdGEgKnNxID0gTlVMTDsKIAlzdHJ1Y3QgaW9fb3ZlcmZs
b3dfY3FlICpvY3FlOwogCXN0cnVjdCBpb19yaW5ncyAqciA9IGN0eC0+cmluZ3M7CiAJdW5z
aWduZWQgaW50IHNxX21hc2sgPSBjdHgtPnNxX2VudHJpZXMgLSAxLCBjcV9tYXNrID0gY3R4
LT5jcV9lbnRyaWVzIC0gMTsKQEAgLTYyLDYgKzYxLDcgQEAgc3RhdGljIF9fY29sZCB2b2lk
IF9faW9fdXJpbmdfc2hvd19mZGluZm8oc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsCiAJdW5z
aWduZWQgaW50IGNxX3NoaWZ0ID0gMDsKIAl1bnNpZ25lZCBpbnQgc3Ffc2hpZnQgPSAwOwog
CXVuc2lnbmVkIGludCBzcV9lbnRyaWVzLCBjcV9lbnRyaWVzOworCWludCBzcV9waWQgPSAt
MSwgc3FfY3B1ID0gLTE7CiAJYm9vbCBoYXNfbG9jazsKIAl1bnNpZ25lZCBpbnQgaTsKIApA
QCAtMTM5LDEzICsxMzksMTkgQEAgc3RhdGljIF9fY29sZCB2b2lkIF9faW9fdXJpbmdfc2hv
d19mZGluZm8oc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsCiAJaGFzX2xvY2sgPSBtdXRleF90
cnlsb2NrKCZjdHgtPnVyaW5nX2xvY2spOwogCiAJaWYgKGhhc19sb2NrICYmIChjdHgtPmZs
YWdzICYgSU9SSU5HX1NFVFVQX1NRUE9MTCkpIHsKLQkJc3EgPSBjdHgtPnNxX2RhdGE7Ci0J
CWlmICghc3EtPnRocmVhZCkKLQkJCXNxID0gTlVMTDsKKwkJc3RydWN0IGlvX3NxX2RhdGEg
KnNxID0gY3R4LT5zcV9kYXRhOworCisJCWlmIChtdXRleF90cnlsb2NrKCZzcS0+bG9jaykp
IHsKKwkJCWlmIChzcS0+dGhyZWFkKSB7CisJCQkJc3FfcGlkID0gdGFza19waWRfbnIoc3Et
PnRocmVhZCk7CisJCQkJc3FfY3B1ID0gdGFza19jcHUoc3EtPnRocmVhZCk7CisJCQl9CisJ
CQltdXRleF91bmxvY2soJnNxLT5sb2NrKTsKKwkJfQogCX0KIAotCXNlcV9wcmludGYobSwg
IlNxVGhyZWFkOlx0JWRcbiIsIHNxID8gdGFza19waWRfbnIoc3EtPnRocmVhZCkgOiAtMSk7
Ci0Jc2VxX3ByaW50ZihtLCAiU3FUaHJlYWRDcHU6XHQlZFxuIiwgc3EgPyB0YXNrX2NwdShz
cS0+dGhyZWFkKSA6IC0xKTsKKwlzZXFfcHJpbnRmKG0sICJTcVRocmVhZDpcdCVkXG4iLCBz
cV9waWQpOworCXNlcV9wcmludGYobSwgIlNxVGhyZWFkQ3B1Olx0JWRcbiIsIHNxX2NwdSk7
CiAJc2VxX3ByaW50ZihtLCAiVXNlckZpbGVzOlx0JXVcbiIsIGN0eC0+bnJfdXNlcl9maWxl
cyk7CiAJZm9yIChpID0gMDsgaGFzX2xvY2sgJiYgaSA8IGN0eC0+bnJfdXNlcl9maWxlczsg
aSsrKSB7CiAJCXN0cnVjdCBmaWxlICpmID0gaW9fZmlsZV9mcm9tX2luZGV4KCZjdHgtPmZp
bGVfdGFibGUsIGkpOwotLSAKMi40Mi4wCgo=

--------------MkUO0tE4Apiin8h43Ry41aUh--
