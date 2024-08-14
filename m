Return-Path: <stable+bounces-67694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9909521B8
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620ECB21CF0
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 18:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B991B373D;
	Wed, 14 Aug 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="US+VR5zH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887A79D2
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658438; cv=none; b=IE2E2h7TzkLr+O5k6lUzYUdYIU+UHQEgJpNGHFjcDjbud5DVZ42QCPEHszOyPAXMSVBByVG+NODrXbVSc5K0wESHRZQYeZVjjg/dHwV0OmBQ6u95sPaWwzOoFoF+ISXI+3SjvOpo+lmfuDWRTjc8L4FzGSGK2DpFxOdcrLVbihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658438; c=relaxed/simple;
	bh=K0Xo0nQ4ui1WE4rFBwVz/y7fVZKWJ0h9ddzy1GJ2dYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bai1G3og9hWwEM/RoqlP5F17D4Z8559+WpnmUNQsNP03Dq7ExC0dinUj1cBpX5Aq9h+7NQsLEYAh/DRj2XsUaIVyi7Qj35D8fdjLFFmbXtSvlk/pCwIsZBn2EfkBZuHYCyu835ZP6HI8ZqGQiqXY5T2bSB9A/PWPel7Xb7lsuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=US+VR5zH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ad02501c3so20728966b.2
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723658434; x=1724263234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PkN5CQFXzKu7Obf6R9rRCX4jXljNnN1QnRqODfRNM+o=;
        b=US+VR5zHhPmdpvlrmIl7hdYWMn2S7P2CTZPMk/bi2FZGFRzz2hDnfliHD1p50o6/UA
         fmuSyoU6X8CljdGHXtekd362DYvtBhK/AvJOwnxBFGBOs+72SXJT4IxK2vIIIjRxcNvZ
         Aaem0JT147eJ7W39uhcR6XiPnAO2eDmSQ90T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658434; x=1724263234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkN5CQFXzKu7Obf6R9rRCX4jXljNnN1QnRqODfRNM+o=;
        b=FjqSUqO0vVXSiRr41QzvS12B9sEBrRrgmEGEHa/tuD5KaS/uUR8vnI2rphoQM7Qv2l
         bKBfpOipx8X0CgmhIFnJva3IOvL9nGhKzAnjLHHUhx07holOVnz2FmCc+rPELA1lI1o0
         U/8RGuSjVNXknO8+uemaMwkpwj0krg9q4OIRxY/kff6UuFPy1HaqrIrehSp8Ieu6II0F
         +aijX57rSpHrdDOZOL1iHQFFF4XSnyP4tr7e6RsKuRXbmv0+eVNpfEOCbHAx5eG78krh
         W4VdQBOSHGEO/qxpy197pzzIvqL3MeeBJNuwpmgLjCWKCpF4jmhu6SkAMeJPAmZg8n7P
         ECEA==
X-Forwarded-Encrypted: i=1; AJvYcCU4YrePG240nnEwJ6mXWD/9CNQ5rU2ZH7xD7v9URm1yy9j8RG3Osz94Nl6SJRxcPVm9fAFs+ADL1AP3QmDp4Y1UWoFF6fkc
X-Gm-Message-State: AOJu0YxiJSx8PanrvnCcDpUSFPgwDAL7TwuLOzX1/pzoF0vbVMOQi+Vu
	bwXdu6Gq+cN2H3WgiE5D952794dPO7vtFTZpOYmJV/h80YV0VCQZmtPmDAenwOg7QRGPDVMtmti
	OJA8=
X-Google-Smtp-Source: AGHT+IE6BuihRidWaZCeZ+DUD6m24yPOFskEXQyBVzjj7sQfeTI8eE4Q6D2+7uUNn9qS8E9M3QA/7g==
X-Received: by 2002:a17:907:e2da:b0:a7a:9144:e251 with SMTP id a640c23a62f3a-a8366c1fbb9mr272306866b.11.1723658433949;
        Wed, 14 Aug 2024 11:00:33 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f4b828sm203361866b.10.2024.08.14.11.00.31
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 11:00:33 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so227168a12.2
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 11:00:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpwQgcrrRA4zMglxYmWKJt40kBkOrxOcifIgIIOSeK4VajhbCIDDU05TYtM1gHQUyMvUvDj2slQ9noSkaubk1+ufRxSPKA
X-Received: by 2002:a05:6402:3550:b0:584:8feb:c3a1 with SMTP id
 4fb4d7f45d1cf-5bea1c6f94amr2531872a12.1.1723658431137; Wed, 14 Aug 2024
 11:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024081450-exploring-lego-5070@gregkh>
In-Reply-To: <2024081450-exploring-lego-5070@gregkh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Aug 2024 11:00:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQiPDmf+mofasoQVW1zU7AKh5_J3xK7rCJtzWzXiC6NQ@mail.gmail.com>
Message-ID: <CAHk-=wgQiPDmf+mofasoQVW1zU7AKh5_J3xK7rCJtzWzXiC6NQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] exec: Fix ToCToU between perm check and
 set-uid/gid usage" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: kees@kernel.org, brauner@kernel.org, ebiederm@xmission.com, 
	mvanotti@google.com, viro@zeniv.linux.org.uk, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008102b3061fa880d4"

--0000000000008102b3061fa880d4
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 10:39, <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.1-stable tree.

I think this is the right backport for 6.1.

Entirely untested, though.

               Linus

--0000000000008102b3061fa880d4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-exec-Fix-ToCToU-between-perm-check-and-set-uid-gid-u.patch"
Content-Disposition: attachment; 
	filename="0001-exec-Fix-ToCToU-between-perm-check-and-set-uid-gid-u.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lzu5pp690>
X-Attachment-Id: f_lzu5pp690

RnJvbSA0MTUzN2QwM2FmM2NiMDYxNjY4ODhhNDkwOGE3YjllNjdlZDM3ZGY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9yZz4KRGF0ZTogVGh1
LCA4IEF1ZyAyMDI0IDExOjM5OjA4IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gZXhlYzogRml4IFRv
Q1RvVSBiZXR3ZWVuIHBlcm0gY2hlY2sgYW5kIHNldC11aWQvZ2lkIHVzYWdlCgpXaGVuIG9wZW5p
bmcgYSBmaWxlIGZvciBleGVjIHZpYSBkb19maWxwX29wZW4oKSwgcGVybWlzc2lvbiBjaGVja2lu
ZyBpcwpkb25lIGFnYWluc3QgdGhlIGZpbGUncyBtZXRhZGF0YSBhdCB0aGF0IG1vbWVudCwgYW5k
IG9uIHN1Y2Nlc3MsIGEgZmlsZQpwb2ludGVyIGlzIHBhc3NlZCBiYWNrLiBNdWNoIGxhdGVyIGlu
IHRoZSBleGVjdmUoKSBjb2RlIHBhdGgsIHRoZSBmaWxlCm1ldGFkYXRhIChzcGVjaWZpY2FsbHkg
bW9kZSwgdWlkLCBhbmQgZ2lkKSBpcyB1c2VkIHRvIGRldGVybWluZSBpZi9ob3cKdG8gc2V0IHRo
ZSB1aWQgYW5kIGdpZC4gSG93ZXZlciwgdGhvc2UgdmFsdWVzIG1heSBoYXZlIGNoYW5nZWQgc2lu
Y2UgdGhlCnBlcm1pc3Npb25zIGNoZWNrLCBtZWFuaW5nIHRoZSBleGVjdXRpb24gbWF5IGdhaW4g
dW5pbnRlbmRlZCBwcml2aWxlZ2VzLgoKRm9yIGV4YW1wbGUsIGlmIGEgZmlsZSBjb3VsZCBjaGFu
Z2UgcGVybWlzc2lvbnMgZnJvbSBleGVjdXRhYmxlIGFuZCBub3QKc2V0LWlkOgoKLS0tLS0tLS0t
eCAxIHJvb3Qgcm9vdCAxNjA0OCBBdWcgIDcgMTM6MTYgdGFyZ2V0Cgp0byBzZXQtaWQgYW5kIG5v
bi1leGVjdXRhYmxlOgoKLS0tUy0tLS0tLSAxIHJvb3Qgcm9vdCAxNjA0OCBBdWcgIDcgMTM6MTYg
dGFyZ2V0CgppdCBpcyBwb3NzaWJsZSB0byBnYWluIHJvb3QgcHJpdmlsZWdlcyB3aGVuIGV4ZWN1
dGlvbiBzaG91bGQgaGF2ZSBiZWVuCmRpc2FsbG93ZWQuCgpXaGlsZSB0aGlzIHJhY2UgY29uZGl0
aW9uIGlzIHJhcmUgaW4gcmVhbC13b3JsZCBzY2VuYXJpb3MsIGl0IGhhcyBiZWVuCm9ic2VydmVk
IChhbmQgcHJvdmVuIGV4cGxvaXRhYmxlKSB3aGVuIHBhY2thZ2UgbWFuYWdlcnMgYXJlIHVwZGF0
aW5nCnRoZSBzZXR1aWQgYml0cyBvZiBpbnN0YWxsZWQgcHJvZ3JhbXMuIFN1Y2ggZmlsZXMgc3Rh
cnQgd2l0aCBiZWluZwp3b3JsZC1leGVjdXRhYmxlIGJ1dCB0aGVuIGFyZSBhZGp1c3RlZCB0byBi
ZSBncm91cC1leGVjIHdpdGggYSBzZXQtdWlkCmJpdC4gRm9yIGV4YW1wbGUsICJjaG1vZCBvLXgs
dStzIHRhcmdldCIgbWFrZXMgInRhcmdldCIgZXhlY3V0YWJsZSBvbmx5CmJ5IHVpZCAicm9vdCIg
YW5kIGdpZCAiY2Ryb20iLCB3aGlsZSBhbHNvIGJlY29taW5nIHNldHVpZC1yb290OgoKLXJ3eHIt
eHIteCAxIHJvb3QgY2Ryb20gMTYwNDggQXVnICA3IDEzOjE2IHRhcmdldAoKYmVjb21lczoKCi1y
d3NyLXhyLS0gMSByb290IGNkcm9tIDE2MDQ4IEF1ZyAgNyAxMzoxNiB0YXJnZXQKCkJ1dCByYWNp
bmcgdGhlIGNobW9kIG1lYW5zIHVzZXJzIHdpdGhvdXQgZ3JvdXAgImNkcm9tIiBtZW1iZXJzaGlw
IGNhbgpnZXQgdGhlIHBlcm1pc3Npb24gdG8gZXhlY3V0ZSAidGFyZ2V0IiBqdXN0IGJlZm9yZSB0
aGUgY2htb2QsIGFuZCB3aGVuCnRoZSBjaG1vZCBmaW5pc2hlcywgdGhlIGV4ZWMgcmVhY2hlcyBi
cnBtX2ZpbGxfdWlkKCksIGFuZCBwZXJmb3JtcyB0aGUKc2V0dWlkIHRvIHJvb3QsIHZpb2xhdGlu
ZyB0aGUgZXhwcmVzc2VkIGF1dGhvcml6YXRpb24gb2YgIm9ubHkgY2Ryb20KZ3JvdXAgbWVtYmVy
cyBjYW4gc2V0dWlkIHRvIHJvb3QiLgoKUmUtY2hlY2sgdGhhdCB3ZSBzdGlsbCBoYXZlIGV4ZWN1
dGUgcGVybWlzc2lvbnMgaW4gY2FzZSB0aGUgbWV0YWRhdGEKaGFzIGNoYW5nZWQuIEl0IHdvdWxk
IGJlIGJldHRlciB0byBrZWVwIGEgY29weSBmcm9tIHRoZSBwZXJtLWNoZWNrIHRpbWUsCmJ1dCB1
bnRpbCB3ZSBjYW4gZG8gdGhhdCByZWZhY3RvcmluZywgdGhlIGxlYXN0LWJhZCBvcHRpb24gaXMg
dG8gZG8gYQpmdWxsIGlub2RlX3Blcm1pc3Npb24oKSBjYWxsICh1bmRlciBpbm9kZSBsb2NrKS4g
SXQgaXMgdW5kZXJzdG9vZCB0aGF0CnRoaXMgaXMgc2FmZSBhZ2FpbnN0IGRlYWQtbG9ja3MsIGJ1
dCBoYXJkbHkgb3B0aW1hbC4KClJlcG9ydGVkLWJ5OiBNYXJjbyBWYW5vdHRpIDxtdmFub3R0aUBn
b29nbGUuY29tPgpUZXN0ZWQtYnk6IE1hcmNvIFZhbm90dGkgPG12YW5vdHRpQGdvb2dsZS5jb20+
ClN1Z2dlc3RlZC1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24u
b3JnPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpDYzogRXJpYyBCaWVkZXJtYW4gPGViaWVk
ZXJtQHhtaXNzaW9uLmNvbT4KQ2M6IEFsZXhhbmRlciBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9y
Zy51az4KQ2M6IENocmlzdGlhbiBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+ClNpZ25lZC1v
ZmYtYnk6IEtlZXMgQ29vayA8a2Vlc0BrZXJuZWwub3JnPgooY2hlcnJ5IHBpY2tlZCBmcm9tIGNv
bW1pdCBmNTA3MzNiNDVkODY1ZjkxZGI5MDkxOWY4MzExZTIxMjdjZTVhMGNiKQotLS0KIGZzL2V4
ZWMuYyB8IDggKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9leGVjLmMgYi9mcy9leGVjLmMKaW5kZXggYjAxNDM0
ZDZhNTEyLi40ODFiNmU3ZGY2YWUgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZWMuYworKysgYi9mcy9leGVj
LmMKQEAgLTE2MDMsNiArMTYwMyw3IEBAIHN0YXRpYyB2b2lkIGJwcm1fZmlsbF91aWQoc3RydWN0
IGxpbnV4X2JpbnBybSAqYnBybSwgc3RydWN0IGZpbGUgKmZpbGUpCiAJdW5zaWduZWQgaW50IG1v
ZGU7CiAJa3VpZF90IHVpZDsKIAlrZ2lkX3QgZ2lkOworCWludCBlcnI7CiAKIAlpZiAoIW1udF9t
YXlfc3VpZChmaWxlLT5mX3BhdGgubW50KSkKIAkJcmV0dXJuOwpAQCAtMTYxOSwxMiArMTYyMCwx
NyBAQCBzdGF0aWMgdm9pZCBicHJtX2ZpbGxfdWlkKHN0cnVjdCBsaW51eF9iaW5wcm0gKmJwcm0s
IHN0cnVjdCBmaWxlICpmaWxlKQogCS8qIEJlIGNhcmVmdWwgaWYgc3VpZC9zZ2lkIGlzIHNldCAq
LwogCWlub2RlX2xvY2soaW5vZGUpOwogCi0JLyogcmVsb2FkIGF0b21pY2FsbHkgbW9kZS91aWQv
Z2lkIG5vdyB0aGF0IGxvY2sgaGVsZCAqLworCS8qIEF0b21pY2FsbHkgcmVsb2FkIGFuZCBjaGVj
ayBtb2RlL3VpZC9naWQgbm93IHRoYXQgbG9jayBoZWxkLiAqLwogCW1vZGUgPSBpbm9kZS0+aV9t
b2RlOwogCXVpZCA9IGlfdWlkX2ludG9fbW50KG1udF91c2VybnMsIGlub2RlKTsKIAlnaWQgPSBp
X2dpZF9pbnRvX21udChtbnRfdXNlcm5zLCBpbm9kZSk7CisJZXJyID0gaW5vZGVfcGVybWlzc2lv
bihtbnRfdXNlcm5zLCBpbm9kZSwgTUFZX0VYRUMpOwogCWlub2RlX3VubG9jayhpbm9kZSk7CiAK
KwkvKiBEaWQgdGhlIGV4ZWMgYml0IHZhbmlzaCBvdXQgZnJvbSB1bmRlciB1cz8gR2l2ZSB1cC4g
Ki8KKwlpZiAoZXJyKQorCQlyZXR1cm47CisKIAkvKiBXZSBpZ25vcmUgc3VpZC9zZ2lkIGlmIHRo
ZXJlIGFyZSBubyBtYXBwaW5ncyBmb3IgdGhlbSBpbiB0aGUgbnMgKi8KIAlpZiAoIWt1aWRfaGFz
X21hcHBpbmcoYnBybS0+Y3JlZC0+dXNlcl9ucywgdWlkKSB8fAogCQkgIWtnaWRfaGFzX21hcHBp
bmcoYnBybS0+Y3JlZC0+dXNlcl9ucywgZ2lkKSkKLS0gCjIuNDYuMC5yYzEuNS5nMWViYTQyYTAy
MQoK
--0000000000008102b3061fa880d4--

