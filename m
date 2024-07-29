Return-Path: <stable+bounces-62595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1A93FC92
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 19:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EAE283841
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0583A17;
	Mon, 29 Jul 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="by4EvxFh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914C78C76
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275159; cv=none; b=SF7a3HSJEG3WhuUaYb++AyKOlQ+j7J0EEvrGEUmThMBhA2uU1JFgof+19W3zuUH6GWx+A/1CkYhWPUEqDWqvQ2rJ0mAJAl9H+czIa+jpPUF8NJjExogKXhNdZx0AZ6HT4rHjfokm+rHlQukjX7oozSxb3g4JVQQrp/MRMc/twpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275159; c=relaxed/simple;
	bh=uCdgoIiavXN3puMXJE2UzYdCsJJPEwUFOwCTOxLwMiI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=aIU8A1HGL4x8r0E5BPE94RPReflQ8jWDc1K4yRBPQgz5RRIY4OneL1i/jRDI8Z6tkT4jlQqsOFGEATBTnyOZZ3o8F/ZUAGZB/bWedUx8KB3fqWvRHrMd7FBernq/Sov/t0n10yk7PyEvdU+m1hwynkxr6JLkAmwfkmMmexdam+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=by4EvxFh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc53171e56so1581825ad.3
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722275154; x=1722879954; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h2UzJDdTN5EnnSIS53uqREIsImTeXMJr90b+PzT8ds=;
        b=by4EvxFhE39l+XEnEfdCfvFwMg3+R11FSbDKRzj0bokNnAYSDtY2ao/n238E0Zeotm
         I79KpBQ0bNCc7B6UzR8jOKJK82X4zYyR3DcjFU9+OPQpyvGpS0yfRSp7cCySEwNdF+61
         sh6lM7DAYpclJxoi1szg7dfGCyGEgNjrpyBDIkiAXPYgCm23kaSEP2IZ1tlWZtM0SU/8
         lh8FShruZAq/3QE4gPnnnXOrIsh9l2eY2D5Er2kF/JVaaeQMD8gJ17Nye/89scmRdHX0
         VzttZ9BJSDD/P7yssUtzHgfe1ArdXvClV42fYJdS+k0vPBUKZIhP9Br+oU6d70jXdfsK
         Iraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722275154; x=1722879954;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7h2UzJDdTN5EnnSIS53uqREIsImTeXMJr90b+PzT8ds=;
        b=h0IQ6vI+Je/Wb/RBemZA4ZpdZfrbfUvQUwVkcbqlE9/Xr8LYsZfmhRyvMc6WG/K+Mq
         +i0JiBFnAkD3PXgydbrT72oSeph5ux6pgUZgDOvwZduvot4w5+wumL14Z1W7IunylA5u
         D13146LEJJFAxfNLDJtB0fsOeaIr7fUAk7SiLnu2zCqkjkjfLyRZlue8UfpJJeefc0sq
         b62keb3DIKqhw6RucszOT+g4tN7NQbuAn1Yx7U5qenlFmCj30xfCsBXdan3EuVEfNMCh
         62e2gHXVUlSuKwzHdQIB649ZQbZ9xfICpcJu9Cku3CNJ/+q6134zeyGQPmzyX6wPq/V6
         KkDw==
X-Gm-Message-State: AOJu0Yx+HMVQL7yfuYBxYZDF+yazrIOhmEVKZZZQleto7g9B9jHTVc8/
	QmYgsBJ2dclabZuCi69WebO4hUgarNoL2CTXCDZ+2mYLBByMqd/luapEj++WSgiuf28WzhpxL23
	t
X-Google-Smtp-Source: AGHT+IH1ERE8fbkXmWAsiMOXhA5DOJj7EBvZZ93WCR+gJmq+4kjavd86f7pTtyjHKYpFrhlVmU36Ww==
X-Received: by 2002:a17:903:24d:b0:1fc:5cc8:bb1b with SMTP id d9443c01a7336-1fed6ca4e55mr105134775ad.7.1722275154496;
        Mon, 29 Jul 2024 10:45:54 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee6a1esm86177275ad.164.2024.07.29.10.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 10:45:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0rU5Mazv2GPmM48d69i3HmwB"
Message-ID: <2f9bc94b-2c6b-46b9-b772-8ec00a637de9@kernel.dk>
Date: Mon, 29 Jul 2024 11:45:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/io-wq: limit retrying worker
 initialisation" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, ju.orth@gmail.com
Cc: stable@vger.kernel.org
References: <2024072923-bodacious-claw-442b@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024072923-bodacious-claw-442b@gregkh>

This is a multi-part message in MIME format.
--------------0rU5Mazv2GPmM48d69i3HmwB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/24 1:55 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0453aad676ff99787124b9b3af4a5f59fbe808e2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072923-bodacious-claw-442b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's a 6.1 variant.

-- 
Jens Axboe


--------------0rU5Mazv2GPmM48d69i3HmwB
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-io-wq-limit-retrying-worker-initialisation.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-io-wq-limit-retrying-worker-initialisation.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSAwNDUzYWFkNjc2ZmY5OTc4NzEyNGI5YjNhZjRhNWY1OWZiZTgwOGUyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogV2VkLCAxMCBKdWwgMjAyNCAxODo1ODoxNyArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIGlvX3VyaW5nL2lvLXdxOiBsaW1pdCByZXRyeWluZyB3b3JrZXIgaW5pdGlh
bGlzYXRpb24KCmNvbW1pdCAwNDUzYWFkNjc2ZmY5OTc4NzEyNGI5YjNhZjRhNWY1OWZiZTgw
OGUyIHVwc3RyZWFtLgoKSWYgaW8td3Egd29ya2VyIGNyZWF0aW9uIGZhaWxzLCB3ZSByZXRy
eSBpdCBieSBxdWV1ZWluZyB1cCBhIHRhc2tfd29yay4KdGFzS193b3JrIGlzIG5lZWRlZCBi
ZWNhdXNlIGl0IHNob3VsZCBiZSBkb25lIGZyb20gdGhlIHVzZXIgcHJvY2Vzcwpjb250ZXh0
LiBUaGUgcHJvYmxlbSBpcyB0aGF0IHJldHJpZXMgYXJlIG5vdCBsaW1pdGVkLCBhbmQgaWYg
cXVldWVpbmcgYQp0YXNrX3dvcmsgaXMgdGhlIHJlYXNvbiBmb3IgdGhlIGZhaWx1cmUsIHdl
IG1pZ2h0IGdldCBpbnRvIGFuIGluZmluaXRlCmxvb3AuCgpJdCBkb2Vzbid0IHNlZW0gdG8g
aGFwcGVuIG5vdyBidXQgaXQgd291bGQgd2l0aCB0aGUgZm9sbG93aW5nIHBhdGNoCmV4ZWN1
dGluZyB0YXNrX3dvcmsgaW4gdGhlIGZyZWV6ZXIncyBsb29wLiBGb3Igbm93LCBhcmJpdHJh
cmlseSBsaW1pdCB0aGUKbnVtYmVyIG9mIGF0dGVtcHRzIHRvIGNyZWF0ZSBhIHdvcmtlci4K
CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAzMTQ2Y2JhOTlhYTI4ICgiaW8t
d3E6IG1ha2Ugd29ya2VyIGNyZWF0aW9uIHJlc2lsaWVudCBhZ2FpbnN0IHNpZ25hbHMiKQpS
ZXBvcnRlZC1ieTogSnVsaWFuIE9ydGggPGp1Lm9ydGhAZ21haWwuY29tPgpTaWduZWQtb2Zm
LWJ5OiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdtYWlsLmNvbT4KTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci84MjgwNDM2OTI1ZGI4ODQ0OGM3Yzg1YzY2NTZlZGVl
MWE0MzAyOWVhLjE3MjA2MzQxNDYuZ2l0LmFzbWwuc2lsZW5jZUBnbWFpbC5jb20KU2lnbmVk
LW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL2lv
LXdxLmMgfCAxMCArKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvLXdxLmMgYi9pb191
cmluZy9pby13cS5jCmluZGV4IDk4YWM5ZGJjZWMyZi4uMDQ1MDMxMThjZGMxIDEwMDY0NAot
LS0gYS9pb191cmluZy9pby13cS5jCisrKyBiL2lvX3VyaW5nL2lvLXdxLmMKQEAgLTIyLDYg
KzIyLDcgQEAKICNpbmNsdWRlICJpb191cmluZy5oIgogCiAjZGVmaW5lIFdPUktFUl9JRExF
X1RJTUVPVVQJKDUgKiBIWikKKyNkZWZpbmUgV09SS0VSX0lOSVRfTElNSVQJMwogCiBlbnVt
IHsKIAlJT19XT1JLRVJfRl9VUAkJPSAxLAkvKiB1cCBhbmQgYWN0aXZlICovCkBAIC01OCw2
ICs1OSw3IEBAIHN0cnVjdCBpb193b3JrZXIgewogCXVuc2lnbmVkIGxvbmcgY3JlYXRlX3N0
YXRlOwogCXN0cnVjdCBjYWxsYmFja19oZWFkIGNyZWF0ZV93b3JrOwogCWludCBjcmVhdGVf
aW5kZXg7CisJaW50IGluaXRfcmV0cmllczsKIAogCXVuaW9uIHsKIAkJc3RydWN0IHJjdV9o
ZWFkIHJjdTsKQEAgLTcyOSw3ICs3MzEsNyBAQCBzdGF0aWMgYm9vbCBpb193cV93b3JrX21h
dGNoX2FsbChzdHJ1Y3QgaW9fd3Ffd29yayAqd29yaywgdm9pZCAqZGF0YSkKIAlyZXR1cm4g
dHJ1ZTsKIH0KIAotc3RhdGljIGlubGluZSBib29sIGlvX3Nob3VsZF9yZXRyeV90aHJlYWQo
bG9uZyBlcnIpCitzdGF0aWMgaW5saW5lIGJvb2wgaW9fc2hvdWxkX3JldHJ5X3RocmVhZChz
dHJ1Y3QgaW9fd29ya2VyICp3b3JrZXIsIGxvbmcgZXJyKQogewogCS8qCiAJICogUHJldmVu
dCBwZXJwZXR1YWwgdGFza193b3JrIHJldHJ5LCBpZiB0aGUgdGFzayAob3IgaXRzIGdyb3Vw
KSBpcwpAQCAtNzM3LDYgKzczOSw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpb19zaG91bGRf
cmV0cnlfdGhyZWFkKGxvbmcgZXJyKQogCSAqLwogCWlmIChmYXRhbF9zaWduYWxfcGVuZGlu
ZyhjdXJyZW50KSkKIAkJcmV0dXJuIGZhbHNlOworCWlmICh3b3JrZXItPmluaXRfcmV0cmll
cysrID49IFdPUktFUl9JTklUX0xJTUlUKQorCQlyZXR1cm4gZmFsc2U7CiAKIAlzd2l0Y2gg
KGVycikgewogCWNhc2UgLUVBR0FJTjoKQEAgLTc2Myw3ICs3NjcsNyBAQCBzdGF0aWMgdm9p
ZCBjcmVhdGVfd29ya2VyX2NvbnQoc3RydWN0IGNhbGxiYWNrX2hlYWQgKmNiKQogCQlpb19p
bml0X25ld193b3JrZXIod3FlLCB3b3JrZXIsIHRzayk7CiAJCWlvX3dvcmtlcl9yZWxlYXNl
KHdvcmtlcik7CiAJCXJldHVybjsKLQl9IGVsc2UgaWYgKCFpb19zaG91bGRfcmV0cnlfdGhy
ZWFkKFBUUl9FUlIodHNrKSkpIHsKKwl9IGVsc2UgaWYgKCFpb19zaG91bGRfcmV0cnlfdGhy
ZWFkKHdvcmtlciwgUFRSX0VSUih0c2spKSkgewogCQlzdHJ1Y3QgaW9fd3FlX2FjY3QgKmFj
Y3QgPSBpb193cWVfZ2V0X2FjY3Qod29ya2VyKTsKIAogCQlhdG9taWNfZGVjKCZhY2N0LT5u
cl9ydW5uaW5nKTsKQEAgLTgzMCw3ICs4MzQsNyBAQCBzdGF0aWMgYm9vbCBjcmVhdGVfaW9f
d29ya2VyKHN0cnVjdCBpb193cSAqd3EsIHN0cnVjdCBpb193cWUgKndxZSwgaW50IGluZGV4
KQogCXRzayA9IGNyZWF0ZV9pb190aHJlYWQoaW9fd3FlX3dvcmtlciwgd29ya2VyLCB3cWUt
Pm5vZGUpOwogCWlmICghSVNfRVJSKHRzaykpIHsKIAkJaW9faW5pdF9uZXdfd29ya2VyKHdx
ZSwgd29ya2VyLCB0c2spOwotCX0gZWxzZSBpZiAoIWlvX3Nob3VsZF9yZXRyeV90aHJlYWQo
UFRSX0VSUih0c2spKSkgeworCX0gZWxzZSBpZiAoIWlvX3Nob3VsZF9yZXRyeV90aHJlYWQo
d29ya2VyLCBQVFJfRVJSKHRzaykpKSB7CiAJCWtmcmVlKHdvcmtlcik7CiAJCWdvdG8gZmFp
bDsKIAl9IGVsc2Ugewo=

--------------0rU5Mazv2GPmM48d69i3HmwB--

