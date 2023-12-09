Return-Path: <stable+bounces-5170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8E780B54C
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03701C2083A
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA276171AB;
	Sat,  9 Dec 2023 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KyySwrAh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A01B7
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 08:52:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2866b15b013so705904a91.0
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702140723; x=1702745523; darn=vger.kernel.org;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnSgp4jbbRFW8+w5jO++v9JyW3DJF7gi3fpOc3hEZss=;
        b=KyySwrAh68xkDp3EDgnDtEd1t1f584Gbx6v9iCCd19MM36SYbZVE7O9ZsQdqH4GgbH
         ynlUat0k52KjduszYt964UTGx+FrsGjo7LK3PI+XsCuhhe1IjvhT1PF5huDcgOrdAyEK
         90xe/RWM9BSrc9V/sdY7IHjSZdn0/rjxYXA3zHgh+iccGmfk6/in6eUjoBdqKFw5JQST
         ByJXF8LrT6lTV3cCRHLJzOUiGzjcX8bcqbI/baB2hSm77QBVQOmZvPrxt1C8TMq6pvcK
         h1pECl7rd4Z6bjgRKVI6H0hYGh3rSmIa32d+iokKNrwCJ2EaPgwx7R3d8KEBZ7rPHQiZ
         ljIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702140723; x=1702745523;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nnSgp4jbbRFW8+w5jO++v9JyW3DJF7gi3fpOc3hEZss=;
        b=eaFsc7O4WDRm8HxFqZIxHJtIt6SeO5ZyG9PeuxcH4g8QoWOWBlh1zvuWuP4rqLxMhZ
         Yn0gA/bdKmxHXex3XFu+tqYuf4bW9gkOI2FV2Gr+Vm1Qqo88J8eMpsBgPdX83r4CLL0S
         XxilADH0e193zFerW6ZSr5VssyUhDUruM54u1kz2X9cpxlYTLVoWvMwMeBEnI/Rf1nDf
         izoGzSRMZQeOFSBO9TnmE/tQBse45xMA/Sr5fNbs8fRHYSalpDUmGBTadcFyX9g0Ij/W
         /WZ24fvxTex9mUBgoHUjMwG9Js7UA3SGI0JRSdGDUh69EbRmqCF4MfbZHZwbC4R/U7as
         qR7A==
X-Gm-Message-State: AOJu0YzbvgoM5Ai+Celgdahv2oUhPjJWMUbNp/+4pvOm042m7ZIr0cB7
	eb07D+qeBSJYfWN+dNT6Sn1tIA==
X-Google-Smtp-Source: AGHT+IHMdOWXEsMvUMeAAfYX51Yvc1hBDZ9OKiil4zukoTNh43cg5PLVgm90MBzLDnYBknNWX4BLpg==
X-Received: by 2002:a17:90a:5207:b0:286:a502:e1c0 with SMTP id v7-20020a17090a520700b00286a502e1c0mr3310020pjh.3.1702140723296;
        Sat, 09 Dec 2023 08:52:03 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id gb21-20020a17090b061500b002804af3afb7sm5301119pjb.49.2023.12.09.08.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 08:52:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------NXf2AoFsHOvwo4GXrycGhGu4"
Message-ID: <21079c31-f48a-4616-a976-c4421113f5fd@kernel.dk>
Date: Sat, 9 Dec 2023 09:52:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/af_unix: disable sending io_uring
 over sockets" failed to apply to 5.4-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, jannh@google.com,
 stable@vger.kernel.org
References: <2023120913-cornea-query-b9bf@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023120913-cornea-query-b9bf@gregkh>

This is a multi-part message in MIME format.
--------------NXf2AoFsHOvwo4GXrycGhGu4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/23 5:03 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x 705318a99a138c29a512a72c3e0043b3cd7f55f4
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120913-cornea-query-b9bf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Here's one for 5.4-stable.

-- 
Jens Axboe

--------------NXf2AoFsHOvwo4GXrycGhGu4
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-af_unix-disable-sending-io_uring-over-socke.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-af_unix-disable-sending-io_uring-over-socke.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyYWQyNTI4OGIwZjY3ZDRhNTEyMGZlOWZlNjI3OWVmNjYzNWJiOTg2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogV2VkLCA2IERlYyAyMDIzIDEzOjI2OjQ3ICswMDAwClN1YmplY3Q6
IFtQQVRDSF0gaW9fdXJpbmcvYWZfdW5peDogZGlzYWJsZSBzZW5kaW5nIGlvX3VyaW5nIG92
ZXIgc29ja2V0cwoKY29tbWl0IDcwNTMxOGE5OWExMzhjMjlhNTEyYTcyYzNlMDA0M2IzY2Q3
ZjU1ZjQgdXBzdHJlYW0uCgpGaWxlIHJlZmVyZW5jZSBjeWNsZXMgaGF2ZSBjYXVzZWQgbG90
cyBvZiBwcm9ibGVtcyBmb3IgaW9fdXJpbmcKaW4gdGhlIHBhc3QsIGFuZCBpdCBzdGlsbCBk
b2Vzbid0IHdvcmsgZXhhY3RseSByaWdodCBhbmQgcmFjZXMgd2l0aAp1bml4X3N0cmVhbV9y
ZWFkX2dlbmVyaWMoKS4gVGhlIHNhZmVzdCBmaXggd291bGQgYmUgdG8gY29tcGxldGVseQpk
aXNhbGxvdyBzZW5kaW5nIGlvX3VyaW5nIGZpbGVzIHZpYSBzb2NrZXRzIHZpYSBTQ01fUklH
SFQsIHNvIHRoZXJlCmFyZSBubyBwb3NzaWJsZSBjeWNsZXMgaW52bG92aW5nIHJlZ2lzdGVy
ZWQgZmlsZXMgYW5kIHRodXMgcmVuZGVyaW5nClNDTSBhY2NvdW50aW5nIG9uIHRoZSBpb191
cmluZyBzaWRlIHVubmVjZXNzYXJ5LgoKQ2M6ICA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4K
Rml4ZXM6IDAwOTFiZmM4MTc0MWIgKCJpb191cmluZy9hZl91bml4OiBkZWZlciByZWdpc3Rl
cmVkIGZpbGVzIGdjIHRvIGlvX3VyaW5nIHJlbGVhc2UiKQpSZXBvcnRlZC1hbmQtc3VnZ2Vz
dGVkLWJ5OiBKYW5uIEhvcm4gPGphbm5oQGdvb2dsZS5jb20+ClNpZ25lZC1vZmYtYnk6IFBh
dmVsIEJlZ3Vua292IDxhc21sLnNpbGVuY2VAZ21haWwuY29tPgpMaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yL2M3MTZjODgzMjE5MzkxNTY5MDljZmExYmQ4YjBmYWFmMWM4MDQx
MDMuMTcwMTg2ODc5NS5naXQuYXNtbC5zaWxlbmNlQGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogZnMvaW9fdXJpbmcuYyAgfCAx
MDEgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
bmV0L2NvcmUvc2NtLmMgfCAgIDYgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMTAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2lvX3VyaW5nLmMgYi9m
cy9pb191cmluZy5jCmluZGV4IGFkYzI2MzQwMDQ3MS4uOWRlODk2MTc2M2IwIDEwMDY0NAot
LS0gYS9mcy9pb191cmluZy5jCisrKyBiL2ZzL2lvX3VyaW5nLmMKQEAgLTMxMzcsMTAxICsz
MTM3LDYgQEAgc3RhdGljIHZvaWQgaW9fZmluaXNoX2FzeW5jKHN0cnVjdCBpb19yaW5nX2N0
eCAqY3R4KQogCX0KIH0KIAotI2lmIGRlZmluZWQoQ09ORklHX1VOSVgpCi1zdGF0aWMgdm9p
ZCBpb19kZXN0cnVjdF9za2Ioc3RydWN0IHNrX2J1ZmYgKnNrYikKLXsKLQlzdHJ1Y3QgaW9f
cmluZ19jdHggKmN0eCA9IHNrYi0+c2stPnNrX3VzZXJfZGF0YTsKLQlpbnQgaTsKLQotCWZv
ciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGN0eC0+c3FvX3dxKTsgaSsrKQotCQlpZiAoY3R4
LT5zcW9fd3FbaV0pCi0JCQlmbHVzaF93b3JrcXVldWUoY3R4LT5zcW9fd3FbaV0pOwotCi0J
dW5peF9kZXN0cnVjdF9zY20oc2tiKTsKLX0KLQotLyoKLSAqIEVuc3VyZSB0aGUgVU5JWCBn
YyBpcyBhd2FyZSBvZiBvdXIgZmlsZSBzZXQsIHNvIHdlIGFyZSBjZXJ0YWluIHRoYXQKLSAq
IHRoZSBpb191cmluZyBjYW4gYmUgc2FmZWx5IHVucmVnaXN0ZXJlZCBvbiBwcm9jZXNzIGV4
aXQsIGV2ZW4gaWYgd2UgaGF2ZQotICogbG9vcHMgaW4gdGhlIGZpbGUgcmVmZXJlbmNpbmcu
Ci0gKi8KLXN0YXRpYyBpbnQgX19pb19zcWVfZmlsZXNfc2NtKHN0cnVjdCBpb19yaW5nX2N0
eCAqY3R4LCBpbnQgbnIsIGludCBvZmZzZXQpCi17Ci0Jc3RydWN0IHNvY2sgKnNrID0gY3R4
LT5yaW5nX3NvY2stPnNrOwotCXN0cnVjdCBzY21fZnBfbGlzdCAqZnBsOwotCXN0cnVjdCBz
a19idWZmICpza2I7Ci0JaW50IGk7Ci0KLQlmcGwgPSBremFsbG9jKHNpemVvZigqZnBsKSwg
R0ZQX0tFUk5FTCk7Ci0JaWYgKCFmcGwpCi0JCXJldHVybiAtRU5PTUVNOwotCi0Jc2tiID0g
YWxsb2Nfc2tiKDAsIEdGUF9LRVJORUwpOwotCWlmICghc2tiKSB7Ci0JCWtmcmVlKGZwbCk7
Ci0JCXJldHVybiAtRU5PTUVNOwotCX0KLQotCXNrYi0+c2sgPSBzazsKLQlza2ItPnNjbV9p
b191cmluZyA9IDE7Ci0Jc2tiLT5kZXN0cnVjdG9yID0gaW9fZGVzdHJ1Y3Rfc2tiOwotCi0J
ZnBsLT51c2VyID0gZ2V0X3VpZChjdHgtPnVzZXIpOwotCWZvciAoaSA9IDA7IGkgPCBucjsg
aSsrKSB7Ci0JCWZwbC0+ZnBbaV0gPSBnZXRfZmlsZShjdHgtPnVzZXJfZmlsZXNbaSArIG9m
ZnNldF0pOwotCQl1bml4X2luZmxpZ2h0KGZwbC0+dXNlciwgZnBsLT5mcFtpXSk7Ci0JfQot
Ci0JZnBsLT5tYXggPSBmcGwtPmNvdW50ID0gbnI7Ci0JVU5JWENCKHNrYikuZnAgPSBmcGw7
Ci0JcmVmY291bnRfYWRkKHNrYi0+dHJ1ZXNpemUsICZzay0+c2tfd21lbV9hbGxvYyk7Ci0J
c2tiX3F1ZXVlX2hlYWQoJnNrLT5za19yZWNlaXZlX3F1ZXVlLCBza2IpOwotCi0JZm9yIChp
ID0gMDsgaSA8IG5yOyBpKyspCi0JCWZwdXQoZnBsLT5mcFtpXSk7Ci0KLQlyZXR1cm4gMDsK
LX0KLQotLyoKLSAqIElmIFVOSVggc29ja2V0cyBhcmUgZW5hYmxlZCwgZmQgcGFzc2luZyBj
YW4gY2F1c2UgYSByZWZlcmVuY2UgY3ljbGUgd2hpY2gKLSAqIGNhdXNlcyByZWd1bGFyIHJl
ZmVyZW5jZSBjb3VudGluZyB0byBicmVhayBkb3duLiBXZSByZWx5IG9uIHRoZSBVTklYCi0g
KiBnYXJiYWdlIGNvbGxlY3Rpb24gdG8gdGFrZSBjYXJlIG9mIHRoaXMgcHJvYmxlbSBmb3Ig
dXMuCi0gKi8KLXN0YXRpYyBpbnQgaW9fc3FlX2ZpbGVzX3NjbShzdHJ1Y3QgaW9fcmluZ19j
dHggKmN0eCkKLXsKLQl1bnNpZ25lZCBsZWZ0LCB0b3RhbDsKLQlpbnQgcmV0ID0gMDsKLQot
CXRvdGFsID0gMDsKLQlsZWZ0ID0gY3R4LT5ucl91c2VyX2ZpbGVzOwotCXdoaWxlIChsZWZ0
KSB7Ci0JCXVuc2lnbmVkIHRoaXNfZmlsZXMgPSBtaW5fdCh1bnNpZ25lZCwgbGVmdCwgU0NN
X01BWF9GRCk7Ci0KLQkJcmV0ID0gX19pb19zcWVfZmlsZXNfc2NtKGN0eCwgdGhpc19maWxl
cywgdG90YWwpOwotCQlpZiAocmV0KQotCQkJYnJlYWs7Ci0JCWxlZnQgLT0gdGhpc19maWxl
czsKLQkJdG90YWwgKz0gdGhpc19maWxlczsKLQl9Ci0KLQlpZiAoIXJldCkKLQkJcmV0dXJu
IDA7Ci0KLQl3aGlsZSAodG90YWwgPCBjdHgtPm5yX3VzZXJfZmlsZXMpIHsKLQkJZnB1dChj
dHgtPnVzZXJfZmlsZXNbdG90YWxdKTsKLQkJdG90YWwrKzsKLQl9Ci0KLQlyZXR1cm4gcmV0
OwotfQotI2Vsc2UKLXN0YXRpYyBpbnQgaW9fc3FlX2ZpbGVzX3NjbShzdHJ1Y3QgaW9fcmlu
Z19jdHggKmN0eCkKLXsKLQlyZXR1cm4gMDsKLX0KLSNlbmRpZgotCiBzdGF0aWMgaW50IGlv
X3NxZV9maWxlc19yZWdpc3RlcihzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgdm9pZCBfX3Vz
ZXIgKmFyZywKIAkJCQkgdW5zaWduZWQgbnJfYXJncykKIHsKQEAgLTMyODUsMTEgKzMxOTAs
NyBAQCBzdGF0aWMgaW50IGlvX3NxZV9maWxlc19yZWdpc3RlcihzdHJ1Y3QgaW9fcmluZ19j
dHggKmN0eCwgdm9pZCBfX3VzZXIgKmFyZywKIAkJcmV0dXJuIHJldDsKIAl9CiAKLQlyZXQg
PSBpb19zcWVfZmlsZXNfc2NtKGN0eCk7Ci0JaWYgKHJldCkKLQkJaW9fc3FlX2ZpbGVzX3Vu
cmVnaXN0ZXIoY3R4KTsKLQotCXJldHVybiByZXQ7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRp
YyBpbnQgaW9fc3Ffb2ZmbG9hZF9zdGFydChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwKZGlm
ZiAtLWdpdCBhL25ldC9jb3JlL3NjbS5jIGIvbmV0L2NvcmUvc2NtLmMKaW5kZXggMzFhMzgy
MzljOTJmLi41NTI1YzE0ZjMzZjEgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3NjbS5jCisrKyBi
L25ldC9jb3JlL3NjbS5jCkBAIC0yNiw2ICsyNiw3IEBACiAjaW5jbHVkZSA8bGludXgvbnNw
cm94eS5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KICNpbmNsdWRlIDxsaW51eC9lcnJx
dWV1ZS5oPgorI2luY2x1ZGUgPGxpbnV4L2lvX3VyaW5nLmg+CiAKICNpbmNsdWRlIDxsaW51
eC91YWNjZXNzLmg+CiAKQEAgLTEwMyw2ICsxMDQsMTEgQEAgc3RhdGljIGludCBzY21fZnBf
Y29weShzdHJ1Y3QgY21zZ2hkciAqY21zZywgc3RydWN0IHNjbV9mcF9saXN0ICoqZnBscCkK
IAogCQlpZiAoZmQgPCAwIHx8ICEoZmlsZSA9IGZnZXRfcmF3KGZkKSkpCiAJCQlyZXR1cm4g
LUVCQURGOworCQkvKiBkb24ndCBhbGxvdyBpb191cmluZyBmaWxlcyAqLworCQlpZiAoaW9f
dXJpbmdfZ2V0X3NvY2tldChmaWxlKSkgeworCQkJZnB1dChmaWxlKTsKKwkJCXJldHVybiAt
RUlOVkFMOworCQl9CiAJCSpmcHArKyA9IGZpbGU7CiAJCWZwbC0+Y291bnQrKzsKIAl9Cg==


--------------NXf2AoFsHOvwo4GXrycGhGu4--

