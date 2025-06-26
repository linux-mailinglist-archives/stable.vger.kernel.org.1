Return-Path: <stable+bounces-158684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D454AE9C71
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3743B232D
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E4327510E;
	Thu, 26 Jun 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZL1Ezwc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BCA1DE2DC;
	Thu, 26 Jun 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936850; cv=none; b=SJm4Ho6A5KnmSLNztvXleIBqzaWCQuQn0YUxUXwrA+akeq6SXCX+El1tKHcAbGXaGWOS75D1uwLbb/Bl6+gSVL4E1vsVtvU/sjUFoPSp9G90rDnIKWTv6GAgYscXKzEmRXBeZgbgSjU/o03fk/gs5t8HtYUaJx8gArpt9iitXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936850; c=relaxed/simple;
	bh=VU9tv04ZofpUdDCl5rmOTYOvZ0c9i0Uu2PSRiRaHGbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNLcuSY0hVGf4VdgBGiviNdFzjbWkksKqtqIc0M3HTUXCfrxUj7yw5tBCgTduTBeg2t0EorKaPaFJLFmguKf46gyDDKWObTWCaTlod3mk+RBDRrRk0g7H6Er9EsFULvgObneFh4BQXOZ062+tSRa6TMoePsD0JrFJnITQyrokwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZL1Ezwc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0e0271d82so38504766b.3;
        Thu, 26 Jun 2025 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750936847; x=1751541647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YWGvZw6MV7GFdDBKi+dQLKYsveFoasqLGDzAcy79qPA=;
        b=JZL1EzwcWcLJy/zAqnFkBVi+uQja5S7xbqPogZXR6Go/wVvo7iZreK6d3pfChC2IKg
         kN299AkvIwcIAKxc10NrCcd8p9wSOJzAjyfh6XbtEDaaZQ2In/dvYB5qwX7lPvOXATy2
         RHqg2Dk4aSsMy0RtzUh1m4HU/wAVSga4/21r9qwZzNQfYMqM4ZXtuGu2bD/xj527HrWO
         4rXd/RX5SmZ+HofyDrn0EdQuyI7L9LA6uCXdcWLZcRrgV15+UXVr/RRUXzDovJEwgJ+r
         aYNov1tld2rhSDMedfHV13vXXQ2z2Oon+lSMPXTI/sd62Pqj8yNiolv1WOdq+em8vhx8
         2TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750936847; x=1751541647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWGvZw6MV7GFdDBKi+dQLKYsveFoasqLGDzAcy79qPA=;
        b=sQFLWewljGkYQ/+p5RgNNTk5+BxgclvsjsEwybwz+15ezsm1g+5co27I+RW/J54unD
         xpStEjLELz8jlNi88YPkBCEsBZ2exs+lPflfGfITNow6GdmrL5yyztmCgYkzpGABzSk8
         Lv3gWPNAksrJw2lRHKBIvIMLj5oN9/vejciiKlus9EEsGVLEHyioAMYl9mDUtpkN9knh
         A7tjsTT30d/fgDHHRlmi8bN2tptM4QlX6KOsM93AG+itauRPeP47nS7WVi2iDgt9feRR
         qZouLhKzy+mHDoD8g+2jAqKzEHE16EfUBHkE+vYV2WnxIUwP9Cb6aPZ0K9iKcx4ZdFMJ
         doiw==
X-Forwarded-Encrypted: i=1; AJvYcCW3VH6l2c62P86mOQqaaqXEWP0Gz2kP09dq5lNa0iS1xueVh+Sp72fvcRafQQwUDJji5mplVKf6lbQ4eOk=@vger.kernel.org, AJvYcCXhcRpOPXektMVfog2uoONtoZD5EA+CKBbe4ABB7MxBN5S34JLKQdeRlGH+hDHBmqAdcmlWoZHG@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQ0olS8f+an7rrqcIT52PXLqcbxskKtAhNbM5v1MPokcxZOeY
	6Qql3YlrKtl8/6XHGQ6MLGlq5RV+sBW+RSzDYBcuEcC/YyE0lFCinc8oGZQzCp5eR3teykAuPQ8
	Wk3/9hqHNxgF4Ey6Ng1cSPh8xYeVzKFg=
X-Gm-Gg: ASbGncujHOrU0CriHotj6bstnqkX6hUmi0PAlb3zq5qEb3gco1LKI9Dj4JX8Or/4S7p
	OnSvlYfp0ar51EuLAVEI9qfB864/sOrYVmdkZUOv6NjbQSjJlK6EJY809qFMadzuDy3KBPyCs5r
	6R4mM4cx2yEKUoSquDcAB0v/UXV+qa2At2xYG8U5tGDzY=
X-Google-Smtp-Source: AGHT+IFGmfCKJbvnbGzZtBmpy8UpMv0Gaae1MPevBZvEmkYAT/3EHECmHFwUpqq1SojkVMOTp1DkNUFg1K1CE3Q+O6k=
X-Received: by 2002:a17:907:ba06:b0:ade:433c:6412 with SMTP id
 a640c23a62f3a-ae0be7fda14mr724079666b.3.1750936846702; Thu, 26 Jun 2025
 04:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com>
 <CAOQ4uxi9KjOx0JSakPYbsNaZj63nLiLzQE-_Hdq1H_MGrC8=6A@mail.gmail.com>
In-Reply-To: <CAOQ4uxi9KjOx0JSakPYbsNaZj63nLiLzQE-_Hdq1H_MGrC8=6A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Jun 2025 13:20:34 +0200
X-Gm-Features: Ac12FXxYyrb54qNUP16cQgT4q4pUUBMxVyyoX1vueeowLOsUWx2U9K5eznE3q9U
Message-ID: <CAOQ4uxhkZ989daUzNos3=7ucsOWx9bRd36gLppA7ttgbquWkeg@mail.gmail.com>
Subject: Re: stable-rc: 5.4 and 5.10: fanotify01.c:339: TFAIL:
 fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100, ".") expected EXDEV:
 ENODEV (19)
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Petr Vorel <pvorel@suse.cz>
Cc: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
	linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, chrubis <chrubis@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000c5d5e5063877c0ab"

--000000000000c5d5e5063877c0ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:57=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Jun 26, 2025 at 9:03=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > Regression in the LTP syscalls/fanotify01 test on the Linux stable-rc 5=
.4
> > and 5.10 kernel after upgrading to LTP version 20250530.
> >
> >  - The test passed with LTP version 20250130
> >  - The test fails with LTP version 20250530
> >
> > Regressions found on stable-rc 5.4 and 5.10 LTP syscalls fanotify01.c
> > fanotify_mark expected EXDEV: ENODEV (19)
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducibility? Yes
> >
> > Test regression: stable-rc 5.4 and 5.10
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > fanotify01.c:339: TFAIL: fanotify_mark(fd_notify, 0x00000001,
> > 0x00000008, -100, ".") expected EXDEV: ENODEV (19)
> >
> > The test expected fanotify_mark() to fail with EXDEV, but received
> > ENODEV instead. This indicates a potential mismatch between updated
> > LTP test expectations and the behavior of the 5.4 kernel=E2=80=99s fano=
tify
> > implementation.
> >
>
> Yap, that's true.
>
> The change to fanotify01:
> * db197b7b5 - fanotify01: fix test failure when running with nfs TMPDIR
>
> Depends on this kernel change from v6.8:
> * 30ad1938326b - fanotify: allow "weak" fsid when watching a single files=
ystem
>
> Which fs type is your LTP TMPDIR?
>
> Can you please test this fix:
>
> --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> @@ -374,7 +374,21 @@ static void setup(void)
>         }
>
>         if (fanotify_flags_supported_on_fs(FAN_REPORT_FID,
> FAN_MARK_MOUNT, FAN_OPEN, ".")) {
> -               inode_mark_fid_xdev =3D (errno =3D=3D ENODEV) ? EXDEV : e=
rrno;
> +               inode_mark_fid_xdev =3D errno;
> +               if (inode_mark_fid_xdev =3D=3D ENODEV) {
> +                       /*
> +                        * The fs on TMPDIR has zero fsid.
> +                        * On kernels <  v6.8 an inode mark fails with EN=
ODEV.
> +                        * On kernels >=3D v6.8 an inode mark is allowed =
but multi
> +                        * fs inode marks will fail with EXDEV.
> +                        * See kernel commit 30ad1938326b
> +                        * ("fanotify: allow "weak" fsid when watching
> a single filesystem").
> +                        */
> +                       if
> (fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_INODE,
> FAN_OPEN, "."))
> +                               inode_mark_fid_xdev =3D errno;
> +                       else
> +                               inode_mark_fid_xdev =3D EXDEV;
> +               }
>                 tst_res(TINFO | TERRNO, "TMPDIR does not support
> reporting events with fid from multi fs");
>         }
>  }
>
>

Please test the attached patch instead.
It is simpler and more correct in some configurations.

Thanks,
Amir.

--000000000000c5d5e5063877c0ab
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fanotify01-Fix-regression-on-kernels-v6.8.patch"
Content-Disposition: attachment; 
	filename="0001-fanotify01-Fix-regression-on-kernels-v6.8.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mcdakydf0>
X-Attachment-Id: f_mcdakydf0

RnJvbSAyYjcxN2IyODRiZjhhODAzZjIyM2NhNGI2MjcxMGI5MTBiNjIyNTg0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDI2IEp1biAyMDI1IDExOjU4OjAxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZmFu
b3RpZnkwMTogRml4IHJlZ3Jlc3Npb24gb24ga2VybmVscyA8IHY2LjgKClRoZXJlIHdhcyBhIHRl
c3QgcmVncmVzc2lvbiBpbiBjYXNlIHRoZSBUTVBESVIgaGFzIGEgemVybyBmc2lkLgoKS2VybmVs
cyA8IHY2LjggZG8gbm90IGFsbG93IHNldHRpbmcgaW5vZGVzIG1hcmtzIG9uIHN1Y2ggZnMsIHdo
aWxlCmtlcm5lbHMgPj0gdjYuOCBkbyBhbGxvdyB0byBzZXQgaW5vZGUgbWFya3MgYnV0IG9uIG9u
IGEgc2luZ2xlIGZzLgoKQWRqdXN0IHRoZSB0ZXN0IGV4cGVjdGF0aW9uIGluIHRob3NlIHR3byBk
aWZmZXJlbnQgY2FzZXMuCgpSZXBvcnRlZC1ieTogTmFyZXNoIEthbWJvanUgPG5hcmVzaC5rYW1i
b2p1QGxpbmFyby5vcmc+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC9DQStHOWZZ
dEpPNERiaWFiSndwU2FtVFBIalB6eXJEM082WkN3bTIrQ0RFVUE3ZitaWXdAbWFpbC5nbWFpbC5j
b20vCkZpeGVzOiBkYjE5N2I3YjUgKCJmYW5vdGlmeTAxOiBmaXggdGVzdCBmYWlsdXJlIHdoZW4g
cnVubmluZyB3aXRoIG5mcyBUTVBESVIiKQpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8
YW1pcjczaWxAZ21haWwuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3Rp
ZnkvZmFub3RpZnkwMS5jIHwgMTYgKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDEuYwppbmRleCBmNTE0ZGMxZGYuLmRmNTBkODRhMSAx
MDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAx
LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMK
QEAgLTc1LDYgKzc1LDcgQEAgc3RhdGljIGNoYXIgZm5hbWVbQlVGX1NJWkVdOwogc3RhdGljIGNo
YXIgYnVmW0JVRl9TSVpFXTsKIHN0YXRpYyBpbnQgZmRfbm90aWZ5Owogc3RhdGljIGludCBmYW5f
cmVwb3J0X2ZpZF91bnN1cHBvcnRlZDsKK3N0YXRpYyBpbnQgdG1wZnNfcmVwb3J0X2ZpZF91bnN1
cHBvcnRlZDsKIHN0YXRpYyBpbnQgbW91bnRfbWFya19maWRfdW5zdXBwb3J0ZWQ7CiBzdGF0aWMg
aW50IGlub2RlX21hcmtfZmlkX3hkZXY7CiBzdGF0aWMgaW50IGZpbGVzeXN0ZW1fbWFya191bnN1
cHBvcnRlZDsKQEAgLTMzNSw5ICszMzYsMTEgQEAgcGFzczoKIAkgKiBXaGVuIHRlc3RlZCBmcyBo
YXMgemVybyBmc2lkIChlLmcuIGZ1c2UpIGFuZCBldmVudHMgYXJlIHJlcG9ydGVkCiAJICogd2l0
aCBmc2lkK2ZpZCwgd2F0Y2hpbmcgZGlmZmVyZW50IGZpbGVzeXN0ZW1zIGlzIG5vdCBzdXBwb3J0
ZWQuCiAJICovCi0JcmV0ID0gcmVwb3J0X2ZpZCA/IGlub2RlX21hcmtfZmlkX3hkZXYgOiAwOwot
CVRTVF9FWFBfRkRfT1JfRkFJTChmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgRkFOX01BUktfQURE
LCBGQU5fQ0xPU0VfV1JJVEUsCi0JCQkJCSBBVF9GRENXRCwgIi4iKSwgcmV0KTsKKwlpZiAoIXRt
cGZzX3JlcG9ydF9maWRfdW5zdXBwb3J0ZWQpIHsKKwkJcmV0ID0gcmVwb3J0X2ZpZCA/IGlub2Rl
X21hcmtfZmlkX3hkZXYgOiAwOworCQlUU1RfRVhQX0ZEX09SX0ZBSUwoZmFub3RpZnlfbWFyayhm
ZF9ub3RpZnksIEZBTl9NQVJLX0FERCwgRkFOX0NMT1NFX1dSSVRFLAorCQkJCQkJIEFUX0ZEQ1dE
LCAiLiIpLCByZXQpOworCX0KIAogCS8qIFJlbW92ZSBtYXJrIHRvIGNsZWFyIEZBTl9NQVJLX0lH
Tk9SRURfU1VSVl9NT0RJRlkgKi8KIAlTQUZFX0ZBTk9USUZZX01BUksoZmRfbm90aWZ5LCBGQU5f
TUFSS19SRU1PVkUgfCBtYXJrLT5mbGFnLApAQCAtMzczLDggKzM3NiwxMSBAQCBzdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQogCQlpbm9kZV9tYXJrX2ZpZF94ZGV2ID0gRVhERVY7CiAJfQogCi0JaWYg
KGZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRlZF9vbl9mcyhGQU5fUkVQT1JUX0ZJRCwgRkFOX01BUktf
TU9VTlQsIEZBTl9PUEVOLCAiLiIpKSB7Ci0JCWlub2RlX21hcmtfZmlkX3hkZXYgPSAoZXJybm8g
PT0gRU5PREVWKSA/IEVYREVWIDogZXJybm87CisJdG1wZnNfcmVwb3J0X2ZpZF91bnN1cHBvcnRl
ZCA9IGZhbm90aWZ5X2luaXRfZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKEZBTl9SRVBPUlRfRklELCAi
LiIpOworCWlmICghdG1wZnNfcmVwb3J0X2ZpZF91bnN1cHBvcnRlZCAmJgorCSAgICBmYW5vdGlm
eV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoRkFOX1JFUE9SVF9GSUQsIEZBTl9NQVJLX01PVU5ULCBG
QU5fT1BFTiwgIi4iKSAmJgorCSAgICAoZXJybm8gPT0gRU5PREVWIHx8IGVycm5vID09IEVYREVW
KSkgeworCQlpbm9kZV9tYXJrX2ZpZF94ZGV2ID0gRVhERVY7CiAJCXRzdF9yZXMoVElORk8gfCBU
RVJSTk8sICJUTVBESVIgZG9lcyBub3Qgc3VwcG9ydCByZXBvcnRpbmcgZXZlbnRzIHdpdGggZmlk
IGZyb20gbXVsdGkgZnMiKTsKIAl9CiB9Ci0tIAoyLjQzLjAKCg==
--000000000000c5d5e5063877c0ab--

