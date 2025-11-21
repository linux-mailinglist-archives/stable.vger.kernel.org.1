Return-Path: <stable+bounces-195493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB8C78850
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9696B2D60D
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92B0343D80;
	Fri, 21 Nov 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAHHG0EF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228F25F988
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763721099; cv=none; b=dcWTFMwXZKCLxjSNnRb268DOot9WgB512Bj1cskObnLB4HQtU+/7gNXqd3La3Xvg59g218oCkfEJJIXGwuK2j+dikxIvN+1gCxM2mnuYXHwBbTTLiqjM/VQZSlL0kh3lGR+k3ggbdkmkAKxiKhP9flzwcQksxVxxRbG5lsXn5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763721099; c=relaxed/simple;
	bh=J1yXSUu2O318vkuKwVLBEuQ4WwfnwArpp9ed1Xg9sxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9jVUblXhcsCxooAGjNY07mFvH95yYZnhFFPYQFg+o4e/b7zw97aNJF+uN2Or76OlNizmzeaqvuU46UyDl4IWO8kwIZswPvaCX4DWMbi1Cp8P4smNJ7frFM1wJO1buhrXBd3ddb7hF1aHFX6SnYU7COVGMJw9oj3R05pI+y2onE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAHHG0EF; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a6c7ac38fso21047017b3.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 02:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763721094; x=1764325894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PeWOSiWwePy1hVoZd11svN6l5FS7nEG0Gxe3W4hSJlo=;
        b=gAHHG0EFRv+CVc2kUTncZaPK16BZb9E92pbasZNUhMd7FS92f50p/jd/z/Iib8MOSA
         bRK4Hd8S5Q4i3HvpcxL0yyQWRJhgygpMd5JNMOoBrj9S37dZXZZ8vKc7QsWmACpTQbeg
         HPwf/dCSZRaVExnq3rw1WjjGzYffbqsyD8KG5pWNiieQDNSn+d+T0oPbLnnSKEx79UQm
         Gr1FUVfSnBi/B8/RpokC0fYQHQUm7Vmssyol3sh0BcEMNFd4v+BG7HDGIxdn7A+KCjOs
         AhXrtEYCm62cm9oVLLt7C9zlwXaCjjJ2LGSbaXm553cj/nA6CejCFEzsWk9L8y6f7Bvz
         KqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763721094; x=1764325894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeWOSiWwePy1hVoZd11svN6l5FS7nEG0Gxe3W4hSJlo=;
        b=YTMKTX8+DTRxEIUrPo8UPo4/sct3d5xRP3wtGAebszI0EMGh+OmnPD4oepggh9Imgy
         SMR1UZyfRwzL6fod0PVNN7HRXDzlIdNaBQnmQcxrWIzpXitzVZelo2ddjyO6lJYBd8+c
         mxK3Z3FXVS/BYe3bglN0+xK0WI9uMDRgkhjT0BOSijXyy8vuKhL3Pu6us2gf5zcldKSk
         dj3xgCOakXvHtPmccqFzwzi8rrG2K9on/dL15jpnSQBls5w64FMOPL+Ili1KljaOWZ+I
         I98Rsppw5IOcxAX9Md1CQscFo2qAKrdhks9dTpeQZCUcKX8T3DlnAosDOCN01zhbkW58
         5iMg==
X-Forwarded-Encrypted: i=1; AJvYcCUFzMvxQqGRsH94JRLA++RREZu+Ybfud7Kasyac5lAkCAfiR/AvF9rQdVYYAa8dQ4IH+WBb9v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztqmeit8lBzeQIK3EnCQqgohS+DT7K/KiRCCOv0BrlCMihJK5a
	yg6KRuvRIFn85Os7wFrAwOE4TscKYShf4NidfRqz14vX1zC5gnTHec4j+dkQy2wpo/Lqu2S4GrW
	VQWmXK/Ektir3rUWAfSfmyuLK3refU+Y=
X-Gm-Gg: ASbGnctfDdkqu2HicGAym0P0krtLfexrUBPZJ58kl6JiVmsxr867CYJ+vgpbalYOcrm
	NBJAk5JgkcUjxbGo+JrEqzBdVAR9hV9JzTScBXIZzlNbkgDPar0Pv3Vjs5PanLGz69obtPxGECN
	py8gZct/viSnxcVfVDAdViDAaV80mFCXkT5RHRGwdM97MBQ5mP3E19sn92PqLgD59hW6pM7SAi8
	u3SagBClho6vxGF2OIoueWnxmVDcu65Y8mtxsZ8wT4JIkrylMnSnYVHfn2TitSv45CdAw==
X-Google-Smtp-Source: AGHT+IHANzUJtcNoaGkLxHJigDgfdukciF1L4ARVa7aMC3v7QZNTiG0CNEJcVi8LU8CfTdlErsibUBQA6FgWV212ytI=
X-Received: by 2002:a05:690c:670e:b0:786:5c6f:d242 with SMTP id
 00721157ae682-78a8b56dd39mr10573007b3.69.1763721093836; Fri, 21 Nov 2025
 02:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710165040.3525304-1-henrique.carvalho@suse.com>
 <2944136.1752224518@warthog.procyon.org.uk> <aHE0--yUyFJqK6lb@precision>
 <CAGypqWyyA6nUfH-bGhQxLYD74O7EcE_6_W15=AB8jvi6yZiV_Q@mail.gmail.com> <2025112112-icon-bunkmate-bfad@gregkh>
In-Reply-To: <2025112112-icon-bunkmate-bfad@gregkh>
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Fri, 21 Nov 2025 02:31:20 -0800
X-Gm-Features: AWmQ_bnVIzOSPNNRHErVzaj-1mBXb63__PYx0RxOm591ioHVYyroSEV6uGMkK2U
Message-ID: <CAGypqWy8=Oq6CC0YGFSr72L7kqrEDOytboSqJFJBxxV5tGQgFA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] smb: client: support kvec iterators in async read path
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Henrique Carvalho <henrique.carvalho@suse.com>, stable@vger.kernel.org, 
	Shyam Prasad N <sprasad@microsoft.com>, apais@microsoft.com, 
	Bharath S M <bharathsm@microsoft.com>, David Howells <dhowells@redhat.com>, smfrench@gmail.com, 
	linux-cifs@vger.kernel.org, Laura Kerner <laura.kerner@ichaus.de>
Content-Type: multipart/mixed; boundary="0000000000004899230644185127"

--0000000000004899230644185127
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:02=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Nov 06, 2025 at 06:02:39AM -0800, Bharath SM wrote:
> > On Fri, Jul 11, 2025 at 9:01=E2=80=AFAM Henrique Carvalho
> > <henrique.carvalho@suse.com> wrote:
> > >
> > > On Fri, Jul 11, 2025 at 10:01:58AM +0100, David Howells wrote:
> > > > Henrique Carvalho <henrique.carvalho@suse.com> wrote:
> > > >
> > > > > Add cifs_limit_kvec_subset() and select the appropriate limiter i=
n
> > > > > cifs_send_async_read() to handle kvec iterators in async read pat=
h,
> > > > > fixing the EIO bug when running executables in cifs shares mounte=
d
> > > > > with nolease.
> > > > >
> > > > > This patch -- or equivalent patch, does not exist upstream, as th=
e
> > > > > upstream code has suffered considerable API changes. The affected=
 path
> > > > > is currently handled by netfs lib and located under netfs/direct_=
read.c.
> > > >
> > > > Are you saying that you do see this upstream too?
> > > >
> > >
> > > No, the patch only targets the 6.6.y stable tree. Since version 6.8,
> > > this path has moved into the netfs layer, so the original bug no long=
er
> > > exists.
> > >
> > > The bug was fixed at least since the commit referred in the commit
> > > message -- 3ee1a1fc3981. In this commit, the call to cifs_user_readv(=
)
> > > is replaced by a call to netfs_unbuffered_read_iter(), inside the
> > > function cifs_strict_readv().
> > >
> > > netfs_unbuffered_read_iter() itself was introduced in commit
> > > 016dc8516aec8, along with other netfs api changes, present in kernel
> > > versions 6.8+.
> > >
> > > Backporting netfs directly would be non-trivial. Instead, I:
> > >
> > > - add cifs_limit_kvec_subset(), modeled on the existing
> > >   cifs_limit_bvec_subset()
> > > - choose between the kvec or bvec limiter function early in
> > >   cifs_write_from_iter().
> > >
> > > The Fixes tag references d08089f649a0c, which implements
> > > cifs_limit_bvec_subset() and uses it inside cifs_write_from_iter().
> > >
> > > > > Reproducer:
> > > > >
> > > > > $ mount.cifs //server/share /mnt -o nolease
> > > > > $ cat - > /mnt/test.sh <<EOL
> > > > > echo hallo
> > > > > EOL
> > > > > $ chmod +x /mnt/test.sh
> > > > > $ /mnt/test.sh
> > > > > bash: /mnt/test.sh: /bin/bash: Defekter Interpreter: Eingabe-/Aus=
gabefehler
> > > > > $ rm -f /mnt/test.sh
> > > >
> > > > Is this what you are expecting to see when it works or when it fail=
s?
> > > >
> > >
> > > This is the reproducer for the observed bug. In english it reads "Bad
> > > interpreter: Input/Output error".
> > >
> > > FYI: I tried to follow Option 3 of the stable-kernel rules for submis=
sion:
> > > <https://www.kernel.org/doc/html/v6.15/process/stable-kernel-rules.ht=
ml>
> > > Please let me know if you'd prefer a different approach or any furthe=
r
> > > changes.
> > Thanks Henrique.
> >
> > Hi Greg,
> >
> > We are observing the same issue with the 6.6 Kernel, Can you please
> > help include this patch in the 6.6 stable kernel.?
>
> Pleas provide a working backport and we will be glad to imclude it.
>
This fix is not needed now in the stable kernels as "[PATCH] cifs: Fix
uncached read into ITER_KVEC iterator" submitted
in email thread "Request to backport data corruption fix to stable"
fixes this issue.

--0000000000004899230644185127
Content-Type: application/octet-stream; 
	name="0001-cifs-Fix-uncached-read-into-ITER_KVEC-iterator.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-Fix-uncached-read-into-ITER_KVEC-iterator.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mi8pyz4x0>
X-Attachment-Id: f_mi8pyz4x0

RnJvbSA1YzAyNjMzNWVlZjEwODA1YTNiNWQzNjI0YzQ2NGYyMzkzZjg1OWUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBGcmksIDE0IE5vdiAyMDI1IDA2OjEzOjM1ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gY2lm
czogRml4IHVuY2FjaGVkIHJlYWQgaW50byBJVEVSX0tWRUMgaXRlcmF0b3IKCklmIGEgY2lmcyBz
aGFyZSBpcyBtb3VudGVkIGNhY2hlPW5vbmUsIGludGVybmFsIHJlYWRzIChzdWNoIGFzIGJ5IGV4
ZWMpCndpbGwgcGFzcyBhIEtWRUMgaXRlcmF0b3IgZG93biBmcm9tIF9fY2lmc19yZWFkdigpIHRv
CmNpZnNfc2VuZF9hc3luY19yZWFkKCkgd2hpY2ggd2lsbCB0aGVuIGNhbGwgY2lmc19saW1pdF9i
dmVjX3N1YnNldCgpIHVwb24KaXQgdG8gbGltaXQgdGhlIG51bWJlciBvZiBjb250aWd1b3VzIGVs
ZW1lbnRzIGZvciBSRE1BIHB1cnBvc2VzLiAgVGhpcwpkb2Vzbid0IHdvcmsgb24gbm9uLUJWRUMg
aXRlcmF0b3JzLCBob3dldmVyLgoKRml4IHRoaXMgYnkgZXh0cmFjdGluZyBhIEtWRUMgaXRlcmF0
b3IgaW50byBhIEJWRUMgaXRlcmF0b3IgaW4KX19jaWZzX3JlYWR2KCkgIChpdCB3b3VsZCBiZSBk
dXAnZCBhbnl3YXkgaXQgYXN5bmMpLgoKVGhpcyBjYXVzZWQgdGhlIGZvbGxvd2luZyB3YXJuaW5n
OgoKICBXQVJOSU5HOiBDUFU6IDAgUElEOiA2MjkwIGF0IGZzL3NtYi9jbGllbnQvZmlsZS5jOjM1
NDkgY2lmc19saW1pdF9idmVjX3N1YnNldCsweGUvMHhjMAogIC4uLgogIENhbGwgVHJhY2U6CiAg
IDxUQVNLPgogICBjaWZzX3NlbmRfYXN5bmNfcmVhZCsweDE0Ni8weDJlMAogICBfX2NpZnNfcmVh
ZHYrMHgyMDcvMHgyZDAKICAgX19rZXJuZWxfcmVhZCsweGY2LzB4MTYwCiAgIHNlYXJjaF9iaW5h
cnlfaGFuZGxlcisweDQ5LzB4MjEwCiAgIGV4ZWNfYmlucHJtKzB4NGEvMHgxNDAKICAgYnBybV9l
eGVjdmUucGFydC4wKzB4ZTQvMHgxNzAKICAgZG9fZXhlY3ZlYXRfY29tbW9uLmlzcmEuMCsweDE5
Ni8weDFjMAogICBkb19leGVjdmUrMHgxZi8weDMwCgpGaXhlczogZDA4MDg5ZjY0OWEwICgiY2lm
czogQ2hhbmdlIHRoZSBJL08gcGF0aHMgdG8gdXNlIGFuIGl0ZXJhdG9yIHJhdGhlciB0aGFuIGEg
cGFnZSBsaXN0IikKQWNrZWQtYnk6IEJoYXJhdGggU00gPGJoYXJhdGhzbUBtaWNyb3NvZnQuY29t
PgpUZXN0ZWQtYnk6IEJoYXJhdGggU00gPGJoYXJhdGhzbUBtaWNyb3NvZnQuY29tPgpTaWduZWQt
b2ZmLWJ5OiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpjYzogc3RhYmxlQGtl
cm5lbC5vcmcgIyB2Ni42fnY2LjkKLS0tCiBmcy9zbWIvY2xpZW50L2ZpbGUuYyB8IDk3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwg
OTQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xp
ZW50L2ZpbGUuYyBiL2ZzL3NtYi9jbGllbnQvZmlsZS5jCmluZGV4IDEwNTgwNjY5MTNkZC4uNGQz
ODAxMTQxM2EwIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L2ZpbGUuYworKysgYi9mcy9zbWIv
Y2xpZW50L2ZpbGUuYwpAQCAtMzcsNiArMzcsODEgQEAKICNpbmNsdWRlICJjaWZzX2lvY3RsLmgi
CiAjaW5jbHVkZSAiY2FjaGVkX2Rpci5oIgogCisvKgorICogQWxsb2NhdGUgYSBiaW9fdmVjIGFy
cmF5IGFuZCBleHRyYWN0IHVwIHRvIHNnX21heCBwYWdlcyBmcm9tIGEgS1ZFQy10eXBlCisgKiBp
dGVyYXRvciBhbmQgYWRkIHRoZW0gdG8gdGhlIGFycmF5LiAgVGhpcyBjYW4gZGVhbCB3aXRoIHZt
YWxsb2MnZCBidWZmZXJzIGFzCisgKiB3ZWxsIGFzIGttYWxsb2MnZCBvciBzdGF0aWMgYnVmZmVy
cy4gIFRoZSBwYWdlcyBhcmUgbm90IHBpbm5lZC4KKyAqLworc3RhdGljIHNzaXplX3QgZXh0cmFj
dF9rdmVjX3RvX2J2ZWMoc3RydWN0IGlvdl9pdGVyICppdGVyLCBzc2l6ZV90IG1heHNpemUsCisJ
CQkJCXVuc2lnbmVkIGludCBiY19tYXgsCisJCQkJCXN0cnVjdCBiaW9fdmVjICoqX2J2LCB1bnNp
Z25lZCBpbnQgKl9iYykKK3sKKwljb25zdCBzdHJ1Y3Qga3ZlYyAqa3YgPSBpdGVyLT5rdmVjOwor
CXN0cnVjdCBiaW9fdmVjICpidjsKKwl1bnNpZ25lZCBsb25nIHN0YXJ0ID0gaXRlci0+aW92X29m
ZnNldDsKKwl1bnNpZ25lZCBpbnQgaSwgYmMgPSAwOworCXNzaXplX3QgcmV0ID0gMDsKKworCWJj
X21heCA9IGlvdl9pdGVyX25wYWdlcyhpdGVyLCBiY19tYXgpOworCWlmIChiY19tYXggPT0gMCkg
eworCQkqX2J2ID0gTlVMTDsKKwkJKl9iYyA9IDA7CisJCXJldHVybiAwOworCX0KKworCWJ2ID0g
a3ZtYWxsb2MoYXJyYXlfc2l6ZShiY19tYXgsIHNpemVvZigqYnYpKSwgR0ZQX05PRlMpOworCWlm
ICghYnYpIHsKKwkJKl9idiA9IE5VTEw7CisJCSpfYmMgPSAwOworCQlyZXR1cm4gLUVOT01FTTsK
Kwl9CisJKl9idiA9IGJ2OworCisJZm9yIChpID0gMDsgaSA8IGl0ZXItPm5yX3NlZ3M7IGkrKykg
eworCQlzdHJ1Y3QgcGFnZSAqcGFnZTsKKwkJdW5zaWduZWQgbG9uZyBrYWRkcjsKKwkJc2l6ZV90
IG9mZiwgbGVuLCBzZWc7CisKKwkJbGVuID0ga3ZbaV0uaW92X2xlbjsKKwkJaWYgKHN0YXJ0ID49
IGxlbikgeworCQkJc3RhcnQgLT0gbGVuOworCQkJY29udGludWU7CisJCX0KKworCQlrYWRkciA9
ICh1bnNpZ25lZCBsb25nKWt2W2ldLmlvdl9iYXNlICsgc3RhcnQ7CisJCW9mZiA9IGthZGRyICYg
flBBR0VfTUFTSzsKKwkJbGVuID0gbWluX3Qoc2l6ZV90LCBtYXhzaXplLCBsZW4gLSBzdGFydCk7
CisJCWthZGRyICY9IFBBR0VfTUFTSzsKKworCQltYXhzaXplIC09IGxlbjsKKwkJcmV0ICs9IGxl
bjsKKwkJZG8geworCQkJc2VnID0gdW1pbihsZW4sIFBBR0VfU0laRSAtIG9mZik7CisJCQlpZiAo
aXNfdm1hbGxvY19vcl9tb2R1bGVfYWRkcigodm9pZCAqKWthZGRyKSkKKwkJCQlwYWdlID0gdm1h
bGxvY190b19wYWdlKCh2b2lkICopa2FkZHIpOworCQkJZWxzZQorCQkJCXBhZ2UgPSB2aXJ0X3Rv
X3BhZ2UoKHZvaWQgKilrYWRkcik7CisKKwkJCWJ2ZWNfc2V0X3BhZ2UoYnYsIHBhZ2UsIGxlbiwg
b2ZmKTsKKwkJCWJ2Kys7CisJCQliYysrOworCisJCQlsZW4gLT0gc2VnOworCQkJa2FkZHIgKz0g
UEFHRV9TSVpFOworCQkJb2ZmID0gMDsKKwkJfSB3aGlsZSAobGVuID4gMCAmJiBiYyA8IGJjX21h
eCk7CisKKwkJaWYgKG1heHNpemUgPD0gMCB8fCBiYyA+PSBiY19tYXgpCisJCQlicmVhazsKKwkJ
c3RhcnQgPSAwOworCX0KKworCWlmIChyZXQgPiAwKQorCQlpb3ZfaXRlcl9hZHZhbmNlKGl0ZXIs
IHJldCk7CisJKl9iYyA9IGJjOworCXJldHVybiByZXQ7Cit9CisKIC8qCiAgKiBSZW1vdmUgdGhl
IGRpcnR5IGZsYWdzIGZyb20gYSBzcGFuIG9mIHBhZ2VzLgogICovCkBAIC00MzE4LDExICs0Mzkz
LDI3IEBAIHN0YXRpYyBzc2l6ZV90IF9fY2lmc19yZWFkdigKIAkJY3R4LT5idiA9ICh2b2lkICop
Y3R4LT5pdGVyLmJ2ZWM7CiAJCWN0eC0+YnZfbmVlZF91bnBpbiA9IGlvdl9pdGVyX2V4dHJhY3Rf
d2lsbF9waW4odG8pOwogCQljdHgtPnNob3VsZF9kaXJ0eSA9IHRydWU7Ci0JfSBlbHNlIGlmICgo
aW92X2l0ZXJfaXNfYnZlYyh0bykgfHwgaW92X2l0ZXJfaXNfa3ZlYyh0bykpICYmCi0JCSAgICFp
c19zeW5jX2tpb2NiKGlvY2IpKSB7CisJfSBlbHNlIGlmIChpb3ZfaXRlcl9pc19rdmVjKHRvKSkg
eworCQkvKgorCQkgKiBFeHRyYWN0IGEgS1ZFQy10eXBlIGl0ZXJhdG9yIGludG8gYSBCVkVDLXR5
cGUgaXRlcmF0b3IuICBXZQorCQkgKiBhc3N1bWUgdGhhdCB0aGUgc3RvcmFnZSB3aWxsIGJlIHJl
dGFpbmVkIGJ5IHRoZSBjYWxsZXI7IGluCisJCSAqIGFueSBjYXNlLCB3ZSBtYXkgb3IgbWF5IG5v
dCBiZSBhYmxlIHRvIHBpbiB0aGUgcGFnZXMsIHNvIHdlCisJCSAqIGRvbid0IHRyeS4KKwkJICov
CisJCXVuc2lnbmVkIGludCBiYzsKKworCQlyYyA9IGV4dHJhY3Rfa3ZlY190b19idmVjKHRvLCBp
b3ZfaXRlcl9jb3VudCh0byksIElOVF9NQVgsCisJCQkJCSZjdHgtPmJ2LCAmYmMpOworCQlpZiAo
cmMgPCAwKSB7CisJCQlrcmVmX3B1dCgmY3R4LT5yZWZjb3VudCwgY2lmc19haW9fY3R4X3JlbGVh
c2UpOworCQkJcmV0dXJuIHJjOworCQl9CisKKwkJaW92X2l0ZXJfYnZlYygmY3R4LT5pdGVyLCBJ
VEVSX0RFU1QsIGN0eC0+YnYsIGJjLCByYyk7CisJfSBlbHNlIGlmIChpb3ZfaXRlcl9pc19idmVj
KHRvKSAmJiAhaXNfc3luY19raW9jYihpb2NiKSkgewogCQkvKgogCQkgKiBJZiB0aGUgb3AgaXMg
YXN5bmNocm9ub3VzLCB3ZSBuZWVkIHRvIGNvcHkgdGhlIGxpc3QgYXR0YWNoZWQKLQkJICogdG8g
YSBCVkVDL0tWRUMtdHlwZSBpdGVyYXRvciwgYnV0IHdlIGFzc3VtZSB0aGF0IHRoZSBzdG9yYWdl
CisJCSAqIHRvIGEgQlZFQy10eXBlIGl0ZXJhdG9yLCBidXQgd2UgYXNzdW1lIHRoYXQgdGhlIHN0
b3JhZ2UKIAkJICogd2lsbCBiZSByZXRhaW5lZCBieSB0aGUgY2FsbGVyOyBpbiBhbnkgY2FzZSwg
d2UgbWF5IG9yIG1heQogCQkgKiBub3QgYmUgYWJsZSB0byBwaW4gdGhlIHBhZ2VzLCBzbyB3ZSBk
b24ndCB0cnkuCiAJCSAqLwotLSAKMi40NS40Cgo=
--0000000000004899230644185127--

