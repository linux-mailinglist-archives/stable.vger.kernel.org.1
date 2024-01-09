Return-Path: <stable+bounces-10378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC88285A2
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 12:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010651C23CA7
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C13717D;
	Tue,  9 Jan 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4f3NEw0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77889381C8
	for <stable@vger.kernel.org>; Tue,  9 Jan 2024 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704801495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kLEhsfysWVsbGAff9BcrJlFshb5bLgks+b9spt728OA=;
	b=Q4f3NEw0igmcD+cgNjciYQEY0HcwQel6DTwqc6vpL4bInI6Abm42U77WYnF7lkYTjtb70v
	f3Bfje77wUeE3wrbrXfilSyq+YAWX7QCo3wr5iipjmnp5VUZbB3OmUcO30qvhUyUcenJKI
	1v7T2rzNoxkDg9Dd52kSRIbj2Jee6P0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-MEk0Gm9rO4q2l6yhURK3fA-1; Tue, 09 Jan 2024 06:58:13 -0500
X-MC-Unique: MEk0Gm9rO4q2l6yhURK3fA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d87bcf8a15so4291631a34.0
        for <stable@vger.kernel.org>; Tue, 09 Jan 2024 03:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801493; x=1705406293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLEhsfysWVsbGAff9BcrJlFshb5bLgks+b9spt728OA=;
        b=UAtCRG70QLncU4cahI6hRRtUBVuFV/RXpGbJg2U8gPD3Xzoc17N8EeRBhKO13QbMTG
         CtrmsJxk9WsxzSpCUkQaLSC2jUzO1PMSNqZyxACL0YNhLWGDfrQP45bj3RfY4r+KzrVk
         LMhb9o52igoks5dc5EH7XZPXkyEmnVokfGweUi6HtI3WnfrprobkNbXGwWUcp7H9Af0b
         YhCAg7uHxqJtbFsBqCxkapw305HvXu9nsOEiLgcKJqG6tKpRt9MuG5Q88gHmPiadhde5
         ybrw0kz+Tae1qar0cXu/v0TXEV19Lnx/UdFpJOMuOi3hTbJzIJUJ8i8i6N528wnvko9e
         UPWw==
X-Gm-Message-State: AOJu0Ywjhb9qRaLtTbPfxZOJIji/l3ujdmVfyxJTDawnxHpbiF2yaYMJ
	xESkTs0SrfhYzofmHLGZdIzcEE5tbSGuK2BXe+1Dx6uacFIu9u4MQuS5NCpQfaL6OyCsm+OsnnZ
	i/4Q0p5MbN5B+GV4HCgVI8nXoK4NzrVaiE8IR5fN6
X-Received: by 2002:a05:6358:904c:b0:173:22a:635a with SMTP id f12-20020a056358904c00b00173022a635amr6635720rwf.30.1704801493139;
        Tue, 09 Jan 2024 03:58:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYYF1UAXyy35byvlzqClPDRriMCETENXfHEtYLAsA9koVTqTBmhiuA274QkV5nOqAzNLBaSn0y6U7I1Y6mUTo=
X-Received: by 2002:a05:6358:904c:b0:173:22a:635a with SMTP id
 f12-20020a056358904c00b00173022a635amr6635712rwf.30.1704801492840; Tue, 09
 Jan 2024 03:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023091601-spotted-untie-0ba4@gregkh>
In-Reply-To: <2023091601-spotted-untie-0ba4@gregkh>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 9 Jan 2024 12:58:01 +0100
Message-ID: <CAOssrKe9GKw7yOhWnHDjx1poiG=g_iU5qLLNWnB8fLatkGGaJQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] fuse: nlookup missing decrement in
 fuse_direntplus_link" failed to apply to 4.19-stable tree
To: gregkh@linuxfoundation.org
Cc: ruan.meisi@zte.com.cn, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000065a1bd060e82077a"

--00000000000065a1bd060e82077a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 2:19=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x b8bd342d50cbf606666488488f9fea374aceb2d5

Attaching the backport.  This applies cleanly to  v4.14 and v4.19.

Thanks,
Miklos

--00000000000065a1bd060e82077a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-nlookup-missing-decrement-in-fuse_direntplus_li-v4.14-v4.19.patch"
Content-Disposition: attachment; 
	filename="fuse-nlookup-missing-decrement-in-fuse_direntplus_li-v4.14-v4.19.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lr6anj1m0>
X-Attachment-Id: f_lr6anj1m0

RnJvbSAxZDcyMDcwOWZjMTk3MmU0YzZjN2U1NDhhMzdjYjM4OTk3MzM5ZmNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBydWFubWVpc2kgPHJ1YW4ubWVpc2lAenRlLmNvbS5jbj4KRGF0
ZTogVHVlLCAyNSBBcHIgMjAyMyAxOToxMzo1NCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGZ1c2U6
IG5sb29rdXAgbWlzc2luZyBkZWNyZW1lbnQgaW4gZnVzZV9kaXJlbnRwbHVzX2xpbmsKCkR1cmlu
ZyBvdXIgZGVidWdnaW5nIG9mIGdsdXN0ZXJmcywgd2UgZm91bmQgYW4gQXNzZXJ0aW9uIGZhaWxl
ZCBlcnJvcjoKaW5vZGVfbG9va3VwID49IG5sb29rdXAsIHdoaWNoIHdhcyBjYXVzZWQgYnkgdGhl
IG5sb29rdXAgdmFsdWUgaW4gdGhlCmtlcm5lbCBiZWluZyBncmVhdGVyIHRoYW4gdGhhdCBpbiB0
aGUgRlVTRSBmaWxlIHN5c3RlbS4KClRoZSBpc3N1ZSB3YXMgaW50cm9kdWNlZCBieSBmdXNlX2Rp
cmVudHBsdXNfbGluaywgd2hlcmUgaW4gdGhlIGZ1bmN0aW9uLApmdXNlX2lnZXQgaW5jcmVtZW50
cyBubG9va3VwLCBhbmQgaWYgZF9zcGxpY2VfYWxpYXMgcmV0dXJucyBmYWlsdXJlLApmdXNlX2Rp
cmVudHBsdXNfbGluayByZXR1cm5zIGZhaWx1cmUgd2l0aG91dCBkZWNyZW1lbnRpbmcgbmxvb2t1
cApodHRwczovL2dpdGh1Yi5jb20vZ2x1c3Rlci9nbHVzdGVyZnMvcHVsbC80MDgxCgpTaWduZWQt
b2ZmLWJ5OiBydWFubWVpc2kgPHJ1YW4ubWVpc2lAenRlLmNvbS5jbj4KRml4ZXM6IDBiMDViMTgz
ODFlZSAoImZ1c2U6IGltcGxlbWVudCBORlMtbGlrZSByZWFkZGlycGx1cyBzdXBwb3J0IikKQ2M6
IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPiAjIHYzLjkKU2lnbmVkLW9mZi1ieTogTWlrbG9zIFN6
ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+CihjaGVycnkgcGlja2VkIGZyb20gY29tbWl0IGI4
YmQzNDJkNTBjYmY2MDY2NjY0ODg0ODhmOWZlYTM3NGFjZWIyZDUpCi0tLQogZnMvZnVzZS9kaXIu
YyB8IDEwICsrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9mdXNlL2Rpci5jIGIvZnMvZnVzZS9kaXIuYwppbmRl
eCA4ZTUxMjU5MDQ3NjIuLmJkNjAyYjdlOGU0NiAxMDA2NDQKLS0tIGEvZnMvZnVzZS9kaXIuYwor
KysgYi9mcy9mdXNlL2Rpci5jCkBAIC0xMjk5LDggKzEyOTksMTYgQEAgc3RhdGljIGludCBmdXNl
X2RpcmVudHBsdXNfbGluayhzdHJ1Y3QgZmlsZSAqZmlsZSwKIAkJCWRwdXQoZGVudHJ5KTsKIAkJ
CWRlbnRyeSA9IGFsaWFzOwogCQl9Ci0JCWlmIChJU19FUlIoZGVudHJ5KSkKKwkJaWYgKElTX0VS
UihkZW50cnkpKSB7CisJCQlpZiAoIUlTX0VSUihpbm9kZSkpIHsKKwkJCQlzdHJ1Y3QgZnVzZV9p
bm9kZSAqZmkgPSBnZXRfZnVzZV9pbm9kZShpbm9kZSk7CisKKwkJCQlzcGluX2xvY2soJmZjLT5s
b2NrKTsKKwkJCQlmaS0+bmxvb2t1cC0tOworCQkJCXNwaW5fdW5sb2NrKCZmYy0+bG9jayk7CisJ
CQl9CiAJCQlyZXR1cm4gUFRSX0VSUihkZW50cnkpOworCQl9CiAJfQogCWlmIChmYy0+cmVhZGRp
cnBsdXNfYXV0bykKIAkJc2V0X2JpdChGVVNFX0lfSU5JVF9SRFBMVVMsICZnZXRfZnVzZV9pbm9k
ZShpbm9kZSktPnN0YXRlKTsKLS0gCjIuNDMuMAoK
--00000000000065a1bd060e82077a--


