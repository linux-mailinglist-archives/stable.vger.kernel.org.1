Return-Path: <stable+bounces-5169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BFD80B53F
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 17:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A34E1F2147C
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C311429B;
	Sat,  9 Dec 2023 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t1hav3Gq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774410D8
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 08:31:22 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28a1dc9834aso529095a91.1
        for <stable@vger.kernel.org>; Sat, 09 Dec 2023 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702139482; x=1702744282; darn=vger.kernel.org;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uS/hkwvL4L2yZqHlraVGUVrSbNCYLepPWGJ26MYOpwY=;
        b=t1hav3GqWXUKTRPUK1KrPhrs0KgBTTV9KEX4uM5OkFY9husJz2xm+xCYoAXkPVPlLb
         7hqUIIshG8/dRvkQ/xQjDCr+QRPn+J86sEzb3ANu4tMTPbQST/3XPGv95kxK08FXaFkA
         TWKApF3O7tSXRsk1PkxdiB/k7VCgm0viZm0YZw6rbGJ+Wqyanc17VPzvOgUxSej8FMv8
         JivgBu0XpBAWdaGUUQ4Lgm/Rzh/VmKaE7YBPe1f2BCVIrVCqJFnAGoT3EU50AZi0GB8K
         fxcdBxJUHQ+/E33OjnbBltDTWYvlyVrhay4OoKHeH4SUs/bWAAuLC44aQV6JhmWVWNiJ
         7iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702139482; x=1702744282;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uS/hkwvL4L2yZqHlraVGUVrSbNCYLepPWGJ26MYOpwY=;
        b=sROzXGxiiKGOLklnZHx4lIsxqYazTwq77LbxgdqyvFdb7YCUqZZB9rZ+CY76cy9A4Z
         RrGRwU2eAFxqoYumkAuGrijHSRzREWHbp1uuO71aupJMkoSAIFhrEZORKUJMHzry/VBV
         aEQJ1bDDk/W/Vqcm6+3dqlVmE0t3/OIyZvMrYf76JhXyUZLpRKP2Y3AEd+F3f2f3E1eW
         g4KEl9ZR+jMzZv2c60YyrH0UqJ5nu3Wpf54/AZvW9/SqoAqQD/k7nwcKq8YlFHlDncqx
         /uxVFR9FkG5pZQsSntgT3lhya8b5r1zFmKaMQUPNXHWHsIgvT2zrc0dSqYDHxtzH6tx1
         sGGg==
X-Gm-Message-State: AOJu0Yw5/cK0YpqoJ3ffVkYkk72wlxqiVCNKlOuSMXPZncuuQdSrbpof
	EYc+YswO5TLRYEI4hnath+Cz8Q==
X-Google-Smtp-Source: AGHT+IHDwhBR8r9+EhdOXkr34NavS4vmg9Pia/Fvypncwg48FzAAoojMKoGoDCEv26zRYrHBKliMPA==
X-Received: by 2002:a17:90b:3909:b0:286:f169:79f1 with SMTP id ob9-20020a17090b390900b00286f16979f1mr3259846pjb.2.1702139482244;
        Sat, 09 Dec 2023 08:31:22 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db0600b001cfce833b6fsm3553277plx.204.2023.12.09.08.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 08:31:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------F0rIUoQEGjgDPR2vXt00evu9"
Message-ID: <d5e10897-bb37-4592-9f57-cb2d85550965@kernel.dk>
Date: Sat, 9 Dec 2023 09:31:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/af_unix: disable sending io_uring
 over sockets" failed to apply to 5.15-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, jannh@google.com,
 stable@vger.kernel.org
References: <2023120911-ecosystem-diary-c2b7@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023120911-ecosystem-diary-c2b7@gregkh>

This is a multi-part message in MIME format.
--------------F0rIUoQEGjgDPR2vXt00evu9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/23 5:03 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 705318a99a138c29a512a72c3e0043b3cd7f55f4
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120911-ecosystem-diary-c2b7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's one for 5.10 and 5.15 stable.

-- 
Jens Axboe


--------------F0rIUoQEGjgDPR2vXt00evu9
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
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcu
YyB8IDU1IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
bmV0L2NvcmUvc2NtLmMgICAgICB8ICA2ICsrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNTUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9f
dXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggNWIyZGJkM2RjMmRlLi43MWRi
OTgzMGQwMjkgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJp
bmcvaW9fdXJpbmcuYwpAQCAtODYyNSw0OSArODYyNSw2IEBAIHN0YXRpYyBpbnQgaW9fc3Fl
X2ZpbGVzX3JlZ2lzdGVyKHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4LCB2b2lkIF9fdXNlciAq
YXJnLAogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyBpbnQgaW9fc3FlX2ZpbGVfcmVnaXN0
ZXIoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIHN0cnVjdCBmaWxlICpmaWxlLAotCQkJCWlu
dCBpbmRleCkKLXsKLSNpZiBkZWZpbmVkKENPTkZJR19VTklYKQotCXN0cnVjdCBzb2NrICpz
b2NrID0gY3R4LT5yaW5nX3NvY2stPnNrOwotCXN0cnVjdCBza19idWZmX2hlYWQgKmhlYWQg
PSAmc29jay0+c2tfcmVjZWl2ZV9xdWV1ZTsKLQlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOwotCi0J
LyoKLQkgKiBTZWUgaWYgd2UgY2FuIG1lcmdlIHRoaXMgZmlsZSBpbnRvIGFuIGV4aXN0aW5n
IHNrYiBTQ01fUklHSFRTCi0JICogZmlsZSBzZXQuIElmIHRoZXJlJ3Mgbm8gcm9vbSwgZmFs
bCBiYWNrIHRvIGFsbG9jYXRpbmcgYSBuZXcgc2tiCi0JICogYW5kIGZpbGxpbmcgaXQgaW4u
Ci0JICovCi0Jc3Bpbl9sb2NrX2lycSgmaGVhZC0+bG9jayk7Ci0Jc2tiID0gc2tiX3BlZWso
aGVhZCk7Ci0JaWYgKHNrYikgewotCQlzdHJ1Y3Qgc2NtX2ZwX2xpc3QgKmZwbCA9IFVOSVhD
Qihza2IpLmZwOwotCi0JCWlmIChmcGwtPmNvdW50IDwgU0NNX01BWF9GRCkgewotCQkJX19z
a2JfdW5saW5rKHNrYiwgaGVhZCk7Ci0JCQlzcGluX3VubG9ja19pcnEoJmhlYWQtPmxvY2sp
OwotCQkJZnBsLT5mcFtmcGwtPmNvdW50XSA9IGdldF9maWxlKGZpbGUpOwotCQkJdW5peF9p
bmZsaWdodChmcGwtPnVzZXIsIGZwbC0+ZnBbZnBsLT5jb3VudF0pOwotCQkJZnBsLT5jb3Vu
dCsrOwotCQkJc3Bpbl9sb2NrX2lycSgmaGVhZC0+bG9jayk7Ci0JCQlfX3NrYl9xdWV1ZV9o
ZWFkKGhlYWQsIHNrYik7Ci0JCX0gZWxzZSB7Ci0JCQlza2IgPSBOVUxMOwotCQl9Ci0JfQot
CXNwaW5fdW5sb2NrX2lycSgmaGVhZC0+bG9jayk7Ci0KLQlpZiAoc2tiKSB7Ci0JCWZwdXQo
ZmlsZSk7Ci0JCXJldHVybiAwOwotCX0KLQotCXJldHVybiBfX2lvX3NxZV9maWxlc19zY20o
Y3R4LCAxLCBpbmRleCk7Ci0jZWxzZQotCXJldHVybiAwOwotI2VuZGlmCi19Ci0KIHN0YXRp
YyBpbnQgaW9fcXVldWVfcnNyY19yZW1vdmFsKHN0cnVjdCBpb19yc3JjX2RhdGEgKmRhdGEs
IHVuc2lnbmVkIGlkeCwKIAkJCQkgc3RydWN0IGlvX3JzcmNfbm9kZSAqbm9kZSwgdm9pZCAq
cnNyYykKIHsKQEAgLTg3MjUsMTIgKzg2ODIsNiBAQCBzdGF0aWMgaW50IGlvX2luc3RhbGxf
Zml4ZWRfZmlsZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc3RydWN0IGZpbGUgKmZpbGUsCiAK
IAkqaW9fZ2V0X3RhZ19zbG90KGN0eC0+ZmlsZV9kYXRhLCBzbG90X2luZGV4KSA9IDA7CiAJ
aW9fZml4ZWRfZmlsZV9zZXQoZmlsZV9zbG90LCBmaWxlKTsKLQlyZXQgPSBpb19zcWVfZmls
ZV9yZWdpc3RlcihjdHgsIGZpbGUsIHNsb3RfaW5kZXgpOwotCWlmIChyZXQpIHsKLQkJZmls
ZV9zbG90LT5maWxlX3B0ciA9IDA7Ci0JCWdvdG8gZXJyOwotCX0KLQogCXJldCA9IDA7CiBl
cnI6CiAJaWYgKG5lZWRzX3N3aXRjaCkKQEAgLTg4NDQsMTIgKzg3OTUsNiBAQCBzdGF0aWMg
aW50IF9faW9fc3FlX2ZpbGVzX3VwZGF0ZShzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwKIAkJ
CX0KIAkJCSppb19nZXRfdGFnX3Nsb3QoZGF0YSwgaSkgPSB0YWc7CiAJCQlpb19maXhlZF9m
aWxlX3NldChmaWxlX3Nsb3QsIGZpbGUpOwotCQkJZXJyID0gaW9fc3FlX2ZpbGVfcmVnaXN0
ZXIoY3R4LCBmaWxlLCBpKTsKLQkJCWlmIChlcnIpIHsKLQkJCQlmaWxlX3Nsb3QtPmZpbGVf
cHRyID0gMDsKLQkJCQlmcHV0KGZpbGUpOwotCQkJCWJyZWFrOwotCQkJfQogCQl9CiAJfQog
CmRpZmYgLS1naXQgYS9uZXQvY29yZS9zY20uYyBiL25ldC9jb3JlL3NjbS5jCmluZGV4IGFj
YjdkNzc2ZmE2ZS4uZTc2MmE0YjhhMWQyIDEwMDY0NAotLS0gYS9uZXQvY29yZS9zY20uYwor
KysgYi9uZXQvY29yZS9zY20uYwpAQCAtMjYsNiArMjYsNyBAQAogI2luY2x1ZGUgPGxpbnV4
L25zcHJveHkuaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8bGludXgv
ZXJycXVldWUuaD4KKyNpbmNsdWRlIDxsaW51eC9pb191cmluZy5oPgogCiAjaW5jbHVkZSA8
bGludXgvdWFjY2Vzcy5oPgogCkBAIC0xMDMsNiArMTA0LDExIEBAIHN0YXRpYyBpbnQgc2Nt
X2ZwX2NvcHkoc3RydWN0IGNtc2doZHIgKmNtc2csIHN0cnVjdCBzY21fZnBfbGlzdCAqKmZw
bHApCiAKIAkJaWYgKGZkIDwgMCB8fCAhKGZpbGUgPSBmZ2V0X3JhdyhmZCkpKQogCQkJcmV0
dXJuIC1FQkFERjsKKwkJLyogZG9uJ3QgYWxsb3cgaW9fdXJpbmcgZmlsZXMgKi8KKwkJaWYg
KGlvX3VyaW5nX2dldF9zb2NrZXQoZmlsZSkpIHsKKwkJCWZwdXQoZmlsZSk7CisJCQlyZXR1
cm4gLUVJTlZBTDsKKwkJfQogCQkqZnBwKysgPSBmaWxlOwogCQlmcGwtPmNvdW50Kys7CiAJ
fQotLSAKMi40Mi4wCgo=

--------------F0rIUoQEGjgDPR2vXt00evu9--

