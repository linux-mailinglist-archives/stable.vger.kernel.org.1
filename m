Return-Path: <stable+bounces-158849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C49AECEBC
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 18:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6091E18937A1
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB921FF5F;
	Sun, 29 Jun 2025 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Xq7lvnqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2913957E
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751215323; cv=none; b=FbZEoekZR8MtOQ45nGNUD8wQ9Rxo5xFbVTwlkNx8UB8FDDUuKAPTrEH/whlSOYikMd96qhYm0ko4RDoJ2F+qhsys2HYvVyjnoFz7Bocd0/+Hpe5Pdiq4rKC5ojx5TnZoG7aGK5lzKeVKWDN88MlrP6J/UQ+6bWIhRK7R41OKNCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751215323; c=relaxed/simple;
	bh=wsvEJCFPhDdFmI7rIQVrWQaCSwlNqEP0KEK9AMc+2HI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Nb9aOoFfXWPf0l6E1dBEG0Kn2TiPinTjQl99JAbZi4do2IT6OyJpflTnLbOkogooD3TaFGOEddyzJ+hz9vGr09Zz9FEe7gHXPQpwA2r7HVhmUjQ0bv1zDBCe/powFFaP4erj8Z2yCv9f9rXqmLnQJocskGfiym1/2MY+H9KyWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Xq7lvnqA; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3df2f97258eso14169585ab.0
        for <stable@vger.kernel.org>; Sun, 29 Jun 2025 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751215319; x=1751820119; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shziQEz0DPL7zWyrcNtuRKc0yA0JpODOKezG0qfHZ+k=;
        b=Xq7lvnqAsZ4MRuipmPu1LzgOxS23L0KfHDkfZnlbxaopS49A7EdphVEMgrT7uFWYPx
         povI2aX7icATyuaf3zyj89wjBZqVCNEGOC9Gmd0TjIMvOrUhIt5qKmSqTM1z01TXEtUl
         0EgcK3w7CGo/lsxfzKnk+GxCyWMdpgWc2cUGsDYM8YuKBUDWJfoVsnVoXcWFhPK0/JmY
         fbwXe8ZLFDX9nkiW8hEcSJSoYzxExy/iizyvMzFm0IMJ0iR+jXxTprtyQKStlsNjPI43
         AGGL/T1XQyY39Sekxwdj/qfjQBREV040sqDSZbaZrLpx+2dCbnWo8wZKz2/lDKH0TxBD
         xgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751215319; x=1751820119;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=shziQEz0DPL7zWyrcNtuRKc0yA0JpODOKezG0qfHZ+k=;
        b=ez6hx8KAKZEw9eekfS+WuT9kF6CdysoUOQPxYk7C75aTNQMqSD+I8UrvuwmGQrqO51
         Ib1evUglCU4pJiy0hLZA0dLZRx5NDsMZkFyK+jgdNOu3nqzHrAK0DQ++3GjtegihVl4c
         N05L1/WomfwiC7bshknz3AgM6meEkXOVug2/EEJPg1iwDuDEKmWjs8a76tu8o1GjfpVd
         iJjAr3/exKOG+/Rh5JddLRL1mcwVAK4B3P6SkJUG5cwYcmProzKf+H5WtyYBTFju1tbg
         qMCcJGQTK5zw48A7HxXxySNPydVuN31TRd1wcrSODJFxA2lWSpqP7THA+6Yjhsf8DEOK
         iM8w==
X-Gm-Message-State: AOJu0YyN82sKqngOPWCGfD1K8v1gxB5sZR3f8yj4fmMvxX2BJKsn8DP8
	GwdThfbRh8PYwGRqL3KoPb2YWqo8Pg8BMFa6mTggSiLdSc85CwweBRsc5+202LRg9VY=
X-Gm-Gg: ASbGncuxfHBaUGg8I7Iy69qaShVjo+4iWJXL/CORb8H/Y0lCXG39k8D6TXPGRxlCg3s
	bhJW1kc4d+Ih08VVbjDdFjOcyzRqatADC9x/D7ryqRIK8mx5qAm+dZfPCfDWOEJIyM9mLhXCs31
	paZIGNes6OUBuolUyselOp9gDeNpEsWwLuF9hVwDqqIb1ku7m87UMzjJd9TP6yfTW1GSgoSY9th
	/Zy7GUlZFXbLKJ9YdkdLRiyWWvRuUJ5pss7RdDleFDmkytIp9ITGDuc9J0uz9Dsp7Asl37+AiLI
	vIlKJY3HCR0yjjbElOIMA74rP9jJVJLR49TU38dqSAk4jfQdH2QaMP1NrL4=
X-Google-Smtp-Source: AGHT+IHxxWF2uVXk1dTmXj6XQUMr3SqEgc6Nl9t4PNI+kffPDfBILSgQnka3V7HusPLUhULir/FHFw==
X-Received: by 2002:a05:6e02:188b:b0:3dc:8b2c:4bc7 with SMTP id e9e14a558f8ab-3df4ab5696cmr129987055ab.1.1751215318865;
        Sun, 29 Jun 2025 09:41:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df49feb22csm19200635ab.21.2025.06.29.09.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 09:41:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ptRGmHGZUlZwsjzqI9qxiwoZ"
Message-ID: <14c7b39a-d489-4265-8165-892ffcb81af9@kernel.dk>
Date: Sun, 29 Jun 2025 10:41:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rsrc: fix folio unpinning" failed
 to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, david@redhat.com
Cc: stable@vger.kernel.org
References: <2025062950-football-lifting-1443@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025062950-football-lifting-1443@gregkh>

This is a multi-part message in MIME format.
--------------ptRGmHGZUlZwsjzqI9qxiwoZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/25 6:41 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5afb4bf9fc62d828647647ec31745083637132e4
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062950-football-lifting-1443@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Set for 6.12-stable, thanks.

-- 
Jens Axboe

--------------ptRGmHGZUlZwsjzqI9qxiwoZ
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-io_uring-rsrc-don-t-rely-on-user-vaddr-alignment.patch"
Content-Disposition: attachment;
 filename*0="0003-io_uring-rsrc-don-t-rely-on-user-vaddr-alignment.patch"
Content-Transfer-Encoding: base64

RnJvbSBhMmIxZTk1NTM4MzlmMGQwNTI0ZjlhNjgyMzljYTIxNWU4NzU4NmJkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogVHVlLCAyNCBKdW4gMjAyNSAxNDo0MDozNCArMDEwMApTdWJqZWN0
OiBbUEFUQ0ggMy8zXSBpb191cmluZy9yc3JjOiBkb24ndCByZWx5IG9uIHVzZXIgdmFkZHIg
YWxpZ25tZW50CgpDb21taXQgM2EzYzZkNjE1NzdkYmIyM2MwOWRmM2UyMWY2ZjllZGExZWNk
NjM0YiB1cHN0cmVhbS4KClRoZXJlIGlzIG5vIGd1YXJhbnRlZWQgYWxpZ25tZW50IGZvciB1
c2VyIHBvaW50ZXJzLCBob3dldmVyIHRoZQpjYWxjdWxhdGlvbiBvZiBhbiBvZmZzZXQgb2Yg
dGhlIGZpcnN0IHBhZ2UgaW50byBhIGZvbGlvIGFmdGVyIGNvYWxlc2NpbmcKdXNlcyBzb21l
IHdlaXJkIGJpdCBtYXNrIGxvZ2ljLCBnZXQgcmlkIG9mIGl0LgoKQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKUmVwb3J0ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRo
YXQuY29tPgpGaXhlczogYThlZGJiNDI0YjEzOSAoImlvX3VyaW5nL3JzcmM6IGVuYWJsZSBt
dWx0aS1odWdlcGFnZSBidWZmZXIgY29hbGVzY2luZyIpClNpZ25lZC1vZmYtYnk6IFBhdmVs
IEJlZ3Vua292IDxhc21sLnNpbGVuY2VAZ21haWwuY29tPgpMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9pby11cmluZy9lMzg3YjRjNzhiMzNmMjMxMTA1YTYwMWQ4NGVlZmQ4MzAx
ZjU3OTU0LjE3NTA3NzE3MTguZ2l0LmFzbWwuc2lsZW5jZUBnbWFpbC5jb20vClNpZ25lZC1v
ZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9yc3Jj
LmMgfCA1ICsrKystCiBpb191cmluZy9yc3JjLmggfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcv
cnNyYy5jIGIvaW9fdXJpbmcvcnNyYy5jCmluZGV4IDEzODBmZThiZjdjOC4uMTY4N2UzNWUy
MWM5IDEwMDY0NAotLS0gYS9pb191cmluZy9yc3JjLmMKKysrIGIvaW9fdXJpbmcvcnNyYy5j
CkBAIC05MTgsNiArOTE4LDcgQEAgc3RhdGljIGJvb2wgaW9fdHJ5X2NvYWxlc2NlX2J1ZmZl
cihzdHJ1Y3QgcGFnZSAqKipwYWdlcywgaW50ICpucl9wYWdlcywKIAkJcmV0dXJuIGZhbHNl
OwogCiAJZGF0YS0+Zm9saW9fc2hpZnQgPSBmb2xpb19zaGlmdChmb2xpbyk7CisJZGF0YS0+
Zmlyc3RfZm9saW9fcGFnZV9pZHggPSBmb2xpb19wYWdlX2lkeChmb2xpbywgcGFnZV9hcnJh
eVswXSk7CiAJLyoKIAkgKiBDaGVjayBpZiBwYWdlcyBhcmUgY29udGlndW91cyBpbnNpZGUg
YSBmb2xpbywgYW5kIGFsbCBmb2xpb3MgaGF2ZQogCSAqIHRoZSBzYW1lIHBhZ2UgY291bnQg
ZXhjZXB0IGZvciB0aGUgaGVhZCBhbmQgdGFpbC4KQEAgLTk5OCw3ICs5OTksOSBAQCBzdGF0
aWMgaW50IGlvX3NxZV9idWZmZXJfcmVnaXN0ZXIoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgs
IHN0cnVjdCBpb3ZlYyAqaW92LAogCWlmIChjb2FsZXNjZWQpCiAJCWltdS0+Zm9saW9fc2hp
ZnQgPSBkYXRhLmZvbGlvX3NoaWZ0OwogCXJlZmNvdW50X3NldCgmaW11LT5yZWZzLCAxKTsK
LQlvZmYgPSAodW5zaWduZWQgbG9uZykgaW92LT5pb3ZfYmFzZSAmICgoMVVMIDw8IGltdS0+
Zm9saW9fc2hpZnQpIC0gMSk7CisJb2ZmID0gKHVuc2lnbmVkIGxvbmcpaW92LT5pb3ZfYmFz
ZSAmIH5QQUdFX01BU0s7CisJaWYgKGNvYWxlc2NlZCkKKwkJb2ZmICs9IGRhdGEuZmlyc3Rf
Zm9saW9fcGFnZV9pZHggPDwgUEFHRV9TSElGVDsKIAkqcGltdSA9IGltdTsKIAlyZXQgPSAw
OwogCmRpZmYgLS1naXQgYS9pb191cmluZy9yc3JjLmggYi9pb191cmluZy9yc3JjLmgKaW5k
ZXggOGVkNTg4MDM2MjEwLi40NTljZjRjNmU4NTYgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL3Jz
cmMuaAorKysgYi9pb191cmluZy9yc3JjLmgKQEAgLTU2LDYgKzU2LDcgQEAgc3RydWN0IGlv
X2ltdV9mb2xpb19kYXRhIHsKIAkvKiBGb3Igbm9uLWhlYWQvdGFpbCBmb2xpb3MsIGhhcyB0
byBiZSBmdWxseSBpbmNsdWRlZCAqLwogCXVuc2lnbmVkIGludAlucl9wYWdlc19taWQ7CiAJ
dW5zaWduZWQgaW50CWZvbGlvX3NoaWZ0OworCXVuc2lnbmVkIGxvbmcJZmlyc3RfZm9saW9f
cGFnZV9pZHg7CiB9OwogCiB2b2lkIGlvX3JzcmNfbm9kZV9yZWZfemVybyhzdHJ1Y3QgaW9f
cnNyY19ub2RlICpub2RlKTsKLS0gCjIuNTAuMAoK
--------------ptRGmHGZUlZwsjzqI9qxiwoZ
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-rsrc-fix-folio-unpinning.patch"
Content-Disposition: attachment;
 filename="0002-io_uring-rsrc-fix-folio-unpinning.patch"
Content-Transfer-Encoding: base64

RnJvbSBlMzNiOGIxZGYxMTMzZDAzYzdiMzU4MWU2NjY0MzA0NDZlMDE3MDE2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogVHVlLCAyNCBKdW4gMjAyNSAxNDo0MDozMyArMDEwMApTdWJqZWN0
OiBbUEFUQ0ggMi8zXSBpb191cmluZy9yc3JjOiBmaXggZm9saW8gdW5waW5uaW5nCgpDb21t
aXQgNWFmYjRiZjlmYzYyZDgyODY0NzY0N2VjMzE3NDUwODM2MzcxMzJlNCB1cHN0cmVhbS4K
CnN5emJvdCBjb21wbGFpbnMgYWJvdXQgYW4gdW5tYXBwaW5nIGZhaWx1cmU6CgpbICAxMDgu
MDcwMzgxXVsgICBUMTRdIGtlcm5lbCBCVUcgYXQgbW0vZ3VwLmM6NzEhClsgIDEwOC4wNzA1
MDJdWyAgIFQxNF0gSW50ZXJuYWwgZXJyb3I6IE9vcHMgLSBCVUc6IDAwMDAwMDAwZjIwMDA4
MDAgWyMxXSAgU01QClsgIDEwOC4xMjM2NzJdWyAgIFQxNF0gSGFyZHdhcmUgbmFtZTogUUVN
VSBLVk0gVmlydHVhbCBNYWNoaW5lLCBCSU9TIGVkazItMjAyNTAyMjEtOC5mYzQyIDAyLzIx
LzIwMjUKWyAgMTA4LjEyNzQ1OF1bICAgVDE0XSBXb3JrcXVldWU6IGlvdV9leGl0IGlvX3Jp
bmdfZXhpdF93b3JrClsgIDEwOC4xNzQyMDVdWyAgIFQxNF0gQ2FsbCB0cmFjZToKWyAgMTA4
LjE3NTY0OV1bICAgVDE0XSAgc2FuaXR5X2NoZWNrX3Bpbm5lZF9wYWdlcysweDdjYy8weDdk
MCAoUCkKWyAgMTA4LjE3ODEzOF1bICAgVDE0XSAgdW5waW5fdXNlcl9wYWdlKzB4ODAvMHgx
MGMKWyAgMTA4LjE4MDE4OV1bICAgVDE0XSAgaW9fcmVsZWFzZV91YnVmKzB4ODQvMHhmOApb
ICAxMDguMTgyMTk2XVsgICBUMTRdICBpb19mcmVlX3JzcmNfbm9kZSsweDI1MC8weDU3Ywpb
ICAxMDguMTg0MzQ1XVsgICBUMTRdICBpb19yc3JjX2RhdGFfZnJlZSsweDE0OC8weDI5OApb
ICAxMDguMTg2NDkzXVsgICBUMTRdICBpb19zcWVfYnVmZmVyc191bnJlZ2lzdGVyKzB4ODQv
MHhhMApbICAxMDguMTg4OTkxXVsgICBUMTRdICBpb19yaW5nX2N0eF9mcmVlKzB4NDgvMHg0
ODAKWyAgMTA4LjE5MTA1N11bICAgVDE0XSAgaW9fcmluZ19leGl0X3dvcmsrMHg3NjQvMHg3
ZDgKWyAgMTA4LjE5MzIwN11bICAgVDE0XSAgcHJvY2Vzc19vbmVfd29yaysweDdlOC8weDE1
NWMKWyAgMTA4LjE5NTQzMV1bICAgVDE0XSAgd29ya2VyX3RocmVhZCsweDk1OC8weGVkOApb
ICAxMDguMTk3NTYxXVsgICBUMTRdICBrdGhyZWFkKzB4NWZjLzB4NzVjClsgIDEwOC4xOTkz
NjJdWyAgIFQxNF0gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwCgpXZSBjYW4gcGluIGEgdGFp
bCBwYWdlIG9mIGEgZm9saW8sIGJ1dCB0aGVuIGlvX3VyaW5nIHdpbGwgdHJ5IHRvIHVucGlu
CnRoZSBoZWFkIHBhZ2Ugb2YgdGhlIGZvbGlvLiBXaGlsZSBpdCBzaG91bGQgYmUgZmluZSBp
biB0ZXJtcyBvZiBrZWVwaW5nCnRoZSBwYWdlIGFjdHVhbGx5IGFsaXZlLCBtbSBmb2xrcyBz
YXkgaXQncyB3cm9uZyBhbmQgdHJpZ2dlcnMgYSBkZWJ1Zwp3YXJuaW5nLiBVc2UgdW5waW5f
dXNlcl9mb2xpbygpIGluc3RlYWQgb2YgdW5waW5fdXNlcl9wYWdlKi4KCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnCkRlYnVnZ2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4KUmVwb3J0ZWQtYnk6IHN5emJvdCsxZDMzNTg5Mzc3MjQ2NzE5OWFiNkBz
eXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9sa21sLmtlcm5lbC5v
cmcvci82ODNmMTU1MS4wNTBhMDIyMC41NWNlYi4wMDE3LkdBRUBnb29nbGUuY29tCkZpeGVz
OiBhOGVkYmI0MjRiMTM5ICgiaW9fdXJpbmcvcnNyYzogZW5hYmxlIG11bHRpLWh1Z2VwYWdl
IGJ1ZmZlciBjb2FsZXNjaW5nIikKU2lnbmVkLW9mZi1ieTogUGF2ZWwgQmVndW5rb3YgPGFz
bWwuc2lsZW5jZUBnbWFpbC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2lv
LXVyaW5nL2EyOGIwZjg3MzM5YWMyYWNmMTRhNjQ1ZGFkMWU5NWJiY2JmMThhY2QuMTc1MDc3
MTcxOC5naXQuYXNtbC5zaWxlbmNlQGdtYWlsLmNvbS8KW2F4Ym9lOiBhZGFwdCB0byBjdXJy
ZW50IHRyZWUsIG1hc3NhZ2UgY29tbWl0IG1lc3NhZ2VdClNpZ25lZC1vZmYtYnk6IEplbnMg
QXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9yc3JjLmMgfCAxMyArKysr
KysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3JzcmMuYyBiL2lvX3VyaW5nL3JzcmMuYwpp
bmRleCA5OTgzYjk0MGViNTcuLjEzODBmZThiZjdjOCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcv
cnNyYy5jCisrKyBiL2lvX3VyaW5nL3JzcmMuYwpAQCAtMTE5LDggKzExOSwxMSBAQCBzdGF0
aWMgdm9pZCBpb19idWZmZXJfdW5tYXAoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIHN0cnVj
dCBpb19tYXBwZWRfdWJ1ZiAqKnNsbwogCWlmIChpbXUgIT0gJmR1bW15X3VidWYpIHsKIAkJ
aWYgKCFyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJmltdS0+cmVmcykpCiAJCQlyZXR1cm47Ci0J
CWZvciAoaSA9IDA7IGkgPCBpbXUtPm5yX2J2ZWNzOyBpKyspCi0JCQl1bnBpbl91c2VyX3Bh
Z2UoaW11LT5idmVjW2ldLmJ2X3BhZ2UpOworCQlmb3IgKGkgPSAwOyBpIDwgaW11LT5ucl9i
dmVjczsgaSsrKSB7CisJCQlzdHJ1Y3QgZm9saW8gKmZvbGlvID0gcGFnZV9mb2xpbyhpbXUt
PmJ2ZWNbaV0uYnZfcGFnZSk7CisKKwkJCXVucGluX3VzZXJfZm9saW8oZm9saW8sIDEpOwor
CQl9CiAJCWlmIChpbXUtPmFjY3RfcGFnZXMpCiAJCQlpb191bmFjY291bnRfbWVtKGN0eCwg
aW11LT5hY2N0X3BhZ2VzKTsKIAkJa3ZmcmVlKGltdSk7CkBAIC0xMDEwLDggKzEwMTMsMTAg
QEAgc3RhdGljIGludCBpb19zcWVfYnVmZmVyX3JlZ2lzdGVyKHN0cnVjdCBpb19yaW5nX2N0
eCAqY3R4LCBzdHJ1Y3QgaW92ZWMgKmlvdiwKIGRvbmU6CiAJaWYgKHJldCkgewogCQlrdmZy
ZWUoaW11KTsKLQkJaWYgKHBhZ2VzKQotCQkJdW5waW5fdXNlcl9wYWdlcyhwYWdlcywgbnJf
cGFnZXMpOworCQlpZiAocGFnZXMpIHsKKwkJCWZvciAoaSA9IDA7IGkgPCBucl9wYWdlczsg
aSsrKQorCQkJCXVucGluX3VzZXJfZm9saW8ocGFnZV9mb2xpbyhwYWdlc1tpXSksIDEpOwor
CQl9CiAJfQogCWt2ZnJlZShwYWdlcyk7CiAJcmV0dXJuIHJldDsKLS0gCjIuNTAuMAoK
--------------ptRGmHGZUlZwsjzqI9qxiwoZ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-fix-potential-page-leak-in-io_sqe_buffer_re.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-fix-potential-page-leak-in-io_sqe_buffer_re.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiYjcxNDQwNjM5ZGUwNzU3YTgwMWNhODE4ZDUwNDZjNWNlMDhjZWQ1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQZW5nbGVpIEppYW5nIDxzdXBlcm1hbi54cHRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDE3IEp1biAyMDI1IDA5OjU2OjQ0IC0wNzAwClN1YmplY3Q6
IFtQQVRDSCAxLzNdIGlvX3VyaW5nOiBmaXggcG90ZW50aWFsIHBhZ2UgbGVhayBpbgogaW9f
c3FlX2J1ZmZlcl9yZWdpc3RlcigpCgpDb21taXQgZTFjNzU4MzFmNjgyZWVmMGY2OGIzNTcy
MzQzNzE0NmVkODYwNzBiMSB1cHN0cmVhbS4KCklmIGFsbG9jYXRpb24gb2YgdGhlICdpbXUn
IGZhaWxzLCB0aGVuIHRoZSBleGlzdGluZyBwYWdlcyBhcmVuJ3QKdW5waW5uZWQgaW4gdGhl
IGVycm9yIHBhdGguIFRoaXMgaXMgbW9zdGx5IGEgdGhlb3JldGljYWwgaXNzdWUsCnJlcXVp
cmluZyBmYXVsdCBpbmplY3Rpb24gdG8gaGl0LgoKTW92ZSB1bnBpbl91c2VyX3BhZ2VzKCkg
dG8gdW5pZmllZCBlcnJvciBoYW5kbGluZyB0byBmaXggdGhlIHBhZ2UgbGVhawppc3N1ZS4K
CkZpeGVzOiBkOGMyMjM3ZDBhYTkgKCJpb191cmluZzogYWRkIGlvX3Bpbl9wYWdlcygpIGhl
bHBlciIpClNpZ25lZC1vZmYtYnk6IFBlbmdsZWkgSmlhbmcgPHN1cGVybWFuLnhwdEBnbWFp
bC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA2MTcxNjU2NDQu
NzkxNjUtMS1zdXBlcm1hbi54cHRAZ21haWwuY29tClNpZ25lZC1vZmYtYnk6IEplbnMgQXhi
b2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9yc3JjLmMgfCA5ICsrKysrLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pb191cmluZy9yc3JjLmMgYi9pb191cmluZy9yc3JjLmMKaW5kZXggYTY3
YmFlMzUwNDE2Li45OTgzYjk0MGViNTcgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL3JzcmMuYwor
KysgYi9pb191cmluZy9yc3JjLmMKQEAgLTk4MywxMCArOTgzLDggQEAgc3RhdGljIGludCBp
b19zcWVfYnVmZmVyX3JlZ2lzdGVyKHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4LCBzdHJ1Y3Qg
aW92ZWMgKmlvdiwKIAkJZ290byBkb25lOwogCiAJcmV0ID0gaW9fYnVmZmVyX2FjY291bnRf
cGluKGN0eCwgcGFnZXMsIG5yX3BhZ2VzLCBpbXUsIGxhc3RfaHBhZ2UpOwotCWlmIChyZXQp
IHsKLQkJdW5waW5fdXNlcl9wYWdlcyhwYWdlcywgbnJfcGFnZXMpOworCWlmIChyZXQpCiAJ
CWdvdG8gZG9uZTsKLQl9CiAKIAlzaXplID0gaW92LT5pb3ZfbGVuOwogCS8qIHN0b3JlIG9y
aWdpbmFsIGFkZHJlc3MgZm9yIGxhdGVyIHZlcmlmaWNhdGlvbiAqLwpAQCAtMTAxMCw4ICsx
MDA4LDExIEBAIHN0YXRpYyBpbnQgaW9fc3FlX2J1ZmZlcl9yZWdpc3RlcihzdHJ1Y3QgaW9f
cmluZ19jdHggKmN0eCwgc3RydWN0IGlvdmVjICppb3YsCiAJCXNpemUgLT0gdmVjX2xlbjsK
IAl9CiBkb25lOgotCWlmIChyZXQpCisJaWYgKHJldCkgewogCQlrdmZyZWUoaW11KTsKKwkJ
aWYgKHBhZ2VzKQorCQkJdW5waW5fdXNlcl9wYWdlcyhwYWdlcywgbnJfcGFnZXMpOworCX0K
IAlrdmZyZWUocGFnZXMpOwogCXJldHVybiByZXQ7CiB9Ci0tIAoyLjUwLjAKCg==

--------------ptRGmHGZUlZwsjzqI9qxiwoZ--

