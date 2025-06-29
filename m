Return-Path: <stable+bounces-158851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6FAECFBE
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 20:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6DA3B4210
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B305A225403;
	Sun, 29 Jun 2025 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nq3sMk4A"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF71288A8
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751223473; cv=none; b=Z6lSp4HsdauRPTnuqJn1Glg7wuqIQVtrAoTsInWB288GdtGamRqJTuasV9XzTItNs/QzHcHOf6vKD1gvONxh0dnfn2kojfYsS+BSP7NqkwV42cjhscTRciAzAsInGg1BkLz16GF/602rNLKe25rIFi0QsyI58d0My0RJ6FUlmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751223473; c=relaxed/simple;
	bh=qaWaNxXkwzMTaJROiqTvwOHMeTlhKkO6OmMScJdE/a4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=G9NZR9OEn8hy+WUTixCZ87QxYofxu48ic/QuGsPgrB2MT2i/X7Lcf8Yt1/JA2mJWmXITsKqrV0Pv1JOEKCth/pLeyiTQOGtOKeoLs6xCKM1BVpoZpyCF4r9yGA6O065N8MCyG/S++BvemCUze3UXv9co5IJLkWgb+5yTGbDH+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nq3sMk4A; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2fb6378cso12105495ab.0
        for <stable@vger.kernel.org>; Sun, 29 Jun 2025 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751223469; x=1751828269; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0arlbtdBm7gzdfIeFPrMknrBOIDBkKR/RBl5b3y7WM=;
        b=nq3sMk4AGhq3XXwvrTVibXAkpWLahOHX3WruuJjoOo4HXwXjz5pacdPawKOvGdYgyx
         h3/ZetquPbt1+ftx3pkKCj0VVXP9yJmKie5/H38r29hq64MUC+mkYVH097NjBoaWrcTT
         V1sIm/04XPDWnIEubz1pJCLVPRzJKz7N/5SVEAJEdn0nSvLjFBaMfNM5Zr4s13Fnysx4
         tII9+PlxsRmWUArdoGeIiuPsSy5C/7iAQXtYqTmVF7ua5HV+24/6E9KivrvF0FbB19/H
         lZoUlpZ58VN7HbOVRC35ncYP3ipWWEOMRw5G33Z54BD8QMui+vWcuTPDSwIpuw37jDIz
         o5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751223469; x=1751828269;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r0arlbtdBm7gzdfIeFPrMknrBOIDBkKR/RBl5b3y7WM=;
        b=C0hYTjelOiXqEy964O4TVcMl5F5k08gP8eGVDJJqSdWndYzx228/rP+mKfDTYWhqfL
         doe//oAioRSpyVuHIhkFSSGgQgL15e2T0vr6vGzP/54rI+jAIZ5GCzKmuF3VUP4XuPxN
         e0EfhJR9eFW98bEUX3SLPfkTVja6GDuVqtnbQb8UWY7gcyi3yU0+majJ+mx+N9G3jvjL
         gz19YGb8PRYjXD2P8jBgbrOb/TMbOcAv1i/DRnDa9P0JPS360zWAyeoGJBXNJUntxcuT
         ZIkJxpyzqg+br+etz17AGz+UcWaq+mIMeWAft31I9CMbs/DcedNRsPprBPCyNLsBF1nR
         c1bA==
X-Gm-Message-State: AOJu0YzQztJ/itEIKzMB0caNoNDHGlszguZt407/JkOzKKhSFhHSBabB
	22bkIpMP+GjF7JEDtU4JkUJnPhwon+b49WPIpSr93ISqDxJiY0ajw+pXXYbFK9Hmtc0=
X-Gm-Gg: ASbGncuJ8qL1poEGyibHQ1lHQKL7fHv1s/eB6d6qpDDpSNdFJVQBC8fRQwFyDOYi0SH
	C4kMUYGJW/f8B67+ivKdPeL3Idw7N9KaDpaV4A4bloGJ8QDCgLmuCZW1qF4LYy2HV1jn9ewHnGn
	E0BPNQoMyjewL+l0g+sbBuRLcUCSH0cDZ+JGcSHnSOSbwK/tUKo1fx6VnWsljMUaPqp3gTJjt7v
	AGwTSAMCX2p5dcHoQYXcLF1iolnQVvMO2x7Qvp8SGj69QzHx0Wel8KJLSFWVGslDG5NjlKaHF0z
	aHDHWXz5sga4R6x9sW9L9HtAKhRdgu7DGZG8goIYUBvqQpX13PIgnyugo+bamKclbu4JJg==
X-Google-Smtp-Source: AGHT+IFj5Nv46qJnMzeEinfBco2fUzijo86EDzHdbyztmBNaiCDo9dFcBpH1uTUZic5DPEnBFSL1xA==
X-Received: by 2002:a05:6e02:1445:b0:3dd:6696:2da7 with SMTP id e9e14a558f8ab-3df4b3b6747mr104597575ab.1.1751223468847;
        Sun, 29 Jun 2025 11:57:48 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df49fe8691sm19376765ab.19.2025.06.29.11.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jun 2025 11:57:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------KdOXCiYXxKOqphvXaWJqlgWJ"
Message-ID: <17b73627-c73f-4242-ba38-eb247442c02e@kernel.dk>
Date: Sun, 29 Jun 2025 12:57:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: flag partial buffer
 mappings" failed to apply to 6.15-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2025062920-conch-hypnotist-d63d@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025062920-conch-hypnotist-d63d@gregkh>

This is a multi-part message in MIME format.
--------------KdOXCiYXxKOqphvXaWJqlgWJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/25 6:42 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 178b8ff66ff827c41b4fa105e9aabb99a0b5c537
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062920-conch-hypnotist-d63d@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Easiest with a backport of another fix done on top, even if it isn't
necessary for 6.15-stable.

-- 
Jens Axboe
--------------KdOXCiYXxKOqphvXaWJqlgWJ
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-kbuf-flag-partial-buffer-mappings.patch"
Content-Disposition: attachment;
 filename="0002-io_uring-kbuf-flag-partial-buffer-mappings.patch"
Content-Transfer-Encoding: base64

RnJvbSBkMDA3N2EwMzQxMTMyZTk3OWI1NDJjYzU1NzE5MzhlODkwNzFjOTUzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMjYgSnVuIDIwMjUgMTI6MTc6NDggLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gaW9fdXJpbmcva2J1ZjogZmxhZyBwYXJ0aWFsIGJ1ZmZlciBtYXBwaW5ncwoKQ29tbWl0
IDE3OGI4ZmY2NmZmODI3YzQxYjRmYTEwNWU5YWFiYjk5YTBiNWM1MzcgdXBzdHJlYW0uCgpB
IHByZXZpb3VzIGNvbW1pdCBhYm9ydGVkIG1hcHBpbmcgbW9yZSBmb3IgYSBub24taW5jcmVt
ZW50YWwgcmluZyBmb3IKYnVuZGxlIHBlZWtpbmcsIGJ1dCBkZXBlbmRpbmcgb24gd2hlcmUg
aW4gdGhlIHByb2Nlc3MgdGhpcyBwZWVraW5nCmhhcHBlbmVkLCBpdCB3b3VsZCBub3QgbmVj
ZXNzYXJpbHkgcHJldmVudCBhIHJldHJ5IGJ5IHRoZSB1c2VyLiBUaGF0IGNhbgpjcmVhdGUg
Z2FwcyBpbiB0aGUgcmVjZWl2ZWQvcmVhZCBkYXRhLgoKQWRkIHN0cnVjdCBidWZfc2VsX2Fy
Zy0+cGFydGlhbF9tYXAsIHdoaWNoIGNhbiBwYXNzIHRoaXMgaW5mb3JtYXRpb24KYmFjay4g
VGhlIG5ldHdvcmtpbmcgc2lkZSBjYW4gdGhlbiBtYXAgdGhhdCB0byBpbnRlcm5hbCBzdGF0
ZSBhbmQgdXNlIGl0CnRvIGdhdGUgcmV0cnkgYXMgd2VsbC4KClNpbmNlIHRoaXMgbmVjZXNz
aXRhdGVzIGEgbmV3IGZsYWcsIGNoYW5nZSBpb19zcl9tc2ctPnJldHJ5IHRvIGEKcmV0cnlf
ZmxhZ3MgbWVtYmVyLCBhbmQgc3RvcmUgYm90aCB0aGUgcmV0cnkgYW5kIHBhcnRpYWwgbWFw
IGNvbmRpdGlvbgppbiB0aGVyZS4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVz
OiAyNmVjMTVlNGIwYzEgKCJpb191cmluZy9rYnVmOiBkb24ndCB0cnVuY2F0ZSBlbmQgYnVm
ZmVyIGZvciBtdWx0aXBsZSBidWZmZXIgcGVla3MiKQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4
Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcva2J1Zi5jIHwgIDEgKwogaW9f
dXJpbmcva2J1Zi5oIHwgIDEgKwogaW9fdXJpbmcvbmV0LmMgIHwgMjMgKysrKysrKysrKysr
KysrLS0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9rYnVmLmMgYi9pb191cmluZy9rYnVm
LmMKaW5kZXggYTg0NjdmNmFiYTU0Li42YzY3NmFlZGM5YTIgMTAwNjQ0Ci0tLSBhL2lvX3Vy
aW5nL2tidWYuYworKysgYi9pb191cmluZy9rYnVmLmMKQEAgLTI3MSw2ICsyNzEsNyBAQCBz
dGF0aWMgaW50IGlvX3JpbmdfYnVmZmVyc19wZWVrKHN0cnVjdCBpb19raW9jYiAqcmVxLCBz
dHJ1Y3QgYnVmX3NlbF9hcmcgKmFyZywKIAkJaWYgKGxlbiA+IGFyZy0+bWF4X2xlbikgewog
CQkJbGVuID0gYXJnLT5tYXhfbGVuOwogCQkJaWYgKCEoYmwtPmZsYWdzICYgSU9CTF9JTkMp
KSB7CisJCQkJYXJnLT5wYXJ0aWFsX21hcCA9IDE7CiAJCQkJaWYgKGlvdiAhPSBhcmctPmlv
dnMpCiAJCQkJCWJyZWFrOwogCQkJCWJ1Zi0+bGVuID0gbGVuOwpkaWZmIC0tZ2l0IGEvaW9f
dXJpbmcva2J1Zi5oIGIvaW9fdXJpbmcva2J1Zi5oCmluZGV4IDJlYzBiOTgzY2UyNC4uNmVi
MTZiYTZlZDM5IDEwMDY0NAotLS0gYS9pb191cmluZy9rYnVmLmgKKysrIGIvaW9fdXJpbmcv
a2J1Zi5oCkBAIC01NSw2ICs1NSw3IEBAIHN0cnVjdCBidWZfc2VsX2FyZyB7CiAJc2l6ZV90
IG1heF9sZW47CiAJdW5zaWduZWQgc2hvcnQgbnJfaW92czsKIAl1bnNpZ25lZCBzaG9ydCBt
b2RlOworCXVuc2lnbmVkIHNob3J0IHBhcnRpYWxfbWFwOwogfTsKIAogdm9pZCBfX3VzZXIg
KmlvX2J1ZmZlcl9zZWxlY3Qoc3RydWN0IGlvX2tpb2NiICpyZXEsIHNpemVfdCAqbGVuLApk
aWZmIC0tZ2l0IGEvaW9fdXJpbmcvbmV0LmMgYi9pb191cmluZy9uZXQuYwppbmRleCBhZGZk
Y2VhMDFlMzkuLjdiZjVlNjJkNWEyOSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvbmV0LmMKKysr
IGIvaW9fdXJpbmcvbmV0LmMKQEAgLTc2LDEyICs3NiwxNyBAQCBzdHJ1Y3QgaW9fc3JfbXNn
IHsKIAl1MTYJCQkJZmxhZ3M7CiAJLyogaW5pdGlhbGlzZWQgYW5kIHVzZWQgb25seSBieSAh
bXNnIHNlbmQgdmFyaWFudHMgKi8KIAl1MTYJCQkJYnVmX2dyb3VwOwotCWJvb2wJCQkJcmV0
cnk7CisJdW5zaWduZWQgc2hvcnQJCQlyZXRyeV9mbGFnczsKIAl2b2lkIF9fdXNlcgkJCSpt
c2dfY29udHJvbDsKIAkvKiB1c2VkIG9ubHkgZm9yIHNlbmQgemVyb2NvcHkgKi8KIAlzdHJ1
Y3QgaW9fa2lvY2IgCQkqbm90aWY7CiB9OwogCitlbnVtIHNyX3JldHJ5X2ZsYWdzIHsKKwlJ
T19TUl9NU0dfUkVUUlkJCT0gMSwKKwlJT19TUl9NU0dfUEFSVElBTF9NQVAJPSAyLAorfTsK
KwogLyoKICAqIE51bWJlciBvZiB0aW1lcyB3ZSdsbCB0cnkgYW5kIGRvIHJlY2VpdmVzIGlm
IHRoZXJlJ3MgbW9yZSBkYXRhLiBJZiB3ZQogICogZXhjZWVkIHRoaXMgbGltaXQsIHRoZW4g
YWRkIHVzIHRvIHRoZSBiYWNrIG9mIHRoZSBxdWV1ZSBhbmQgcmV0cnkgZnJvbQpAQCAtMTg4
LDcgKzE5Myw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBpb19tc2hvdF9wcmVwX3JldHJ5KHN0
cnVjdCBpb19raW9jYiAqcmVxLAogCiAJcmVxLT5mbGFncyAmPSB+UkVRX0ZfQkxfRU1QVFk7
CiAJc3ItPmRvbmVfaW8gPSAwOwotCXNyLT5yZXRyeSA9IGZhbHNlOworCXNyLT5yZXRyeV9m
bGFncyA9IDA7CiAJc3ItPmxlbiA9IDA7IC8qIGdldCBmcm9tIHRoZSBwcm92aWRlZCBidWZm
ZXIgKi8KIAlyZXEtPmJ1Zl9pbmRleCA9IHNyLT5idWZfZ3JvdXA7CiB9CkBAIC00MDEsNyAr
NDA2LDcgQEAgaW50IGlvX3NlbmRtc2dfcHJlcChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgY29u
c3Qgc3RydWN0IGlvX3VyaW5nX3NxZSAqc3FlKQogCXN0cnVjdCBpb19zcl9tc2cgKnNyID0g
aW9fa2lvY2JfdG9fY21kKHJlcSwgc3RydWN0IGlvX3NyX21zZyk7CiAKIAlzci0+ZG9uZV9p
byA9IDA7Ci0Jc3ItPnJldHJ5ID0gZmFsc2U7CisJc3ItPnJldHJ5X2ZsYWdzID0gMDsKIAlz
ci0+bGVuID0gUkVBRF9PTkNFKHNxZS0+bGVuKTsKIAlzci0+ZmxhZ3MgPSBSRUFEX09OQ0Uo
c3FlLT5pb3ByaW8pOwogCWlmIChzci0+ZmxhZ3MgJiB+U0VORE1TR19GTEFHUykKQEAgLTc1
OSw3ICs3NjQsNyBAQCBpbnQgaW9fcmVjdm1zZ19wcmVwKHN0cnVjdCBpb19raW9jYiAqcmVx
LCBjb25zdCBzdHJ1Y3QgaW9fdXJpbmdfc3FlICpzcWUpCiAJc3RydWN0IGlvX3NyX21zZyAq
c3IgPSBpb19raW9jYl90b19jbWQocmVxLCBzdHJ1Y3QgaW9fc3JfbXNnKTsKIAogCXNyLT5k
b25lX2lvID0gMDsKLQlzci0+cmV0cnkgPSBmYWxzZTsKKwlzci0+cmV0cnlfZmxhZ3MgPSAw
OwogCiAJaWYgKHVubGlrZWx5KHNxZS0+ZmlsZV9pbmRleCB8fCBzcWUtPmFkZHIyKSkKIAkJ
cmV0dXJuIC1FSU5WQUw7CkBAIC04MzEsNyArODM2LDcgQEAgc3RhdGljIGlubGluZSBib29s
IGlvX3JlY3ZfZmluaXNoKHN0cnVjdCBpb19raW9jYiAqcmVxLCBpbnQgKnJldCwKIAogCQlj
ZmxhZ3MgfD0gaW9fcHV0X2tidWZzKHJlcSwgdGhpc19yZXQsIGlvX2J1bmRsZV9uYnVmcyhr
bXNnLCB0aGlzX3JldCksCiAJCQkJICAgICAgaXNzdWVfZmxhZ3MpOwotCQlpZiAoc3ItPnJl
dHJ5KQorCQlpZiAoc3ItPnJldHJ5X2ZsYWdzICYgSU9fU1JfTVNHX1JFVFJZKQogCQkJY2Zs
YWdzID0gcmVxLT5jcWUuZmxhZ3MgfCAoY2ZsYWdzICYgQ1FFX0ZfTUFTSyk7CiAJCS8qIGJ1
bmRsZSB3aXRoIG5vIG1vcmUgaW1tZWRpYXRlIGJ1ZmZlcnMsIHdlJ3JlIGRvbmUgKi8KIAkJ
aWYgKHJlcS0+ZmxhZ3MgJiBSRVFfRl9CTF9FTVBUWSkKQEAgLTg0MCwxMiArODQ1LDEyIEBA
IHN0YXRpYyBpbmxpbmUgYm9vbCBpb19yZWN2X2ZpbmlzaChzdHJ1Y3QgaW9fa2lvY2IgKnJl
cSwgaW50ICpyZXQsCiAJCSAqIElmIG1vcmUgaXMgYXZhaWxhYmxlIEFORCBpdCB3YXMgYSBm
dWxsIHRyYW5zZmVyLCByZXRyeSBhbmQKIAkJICogYXBwZW5kIHRvIHRoaXMgb25lCiAJCSAq
LwotCQlpZiAoIXNyLT5yZXRyeSAmJiBrbXNnLT5tc2cubXNnX2lucSA+IDEgJiYgdGhpc19y
ZXQgPiAwICYmCisJCWlmICghc3ItPnJldHJ5X2ZsYWdzICYmIGttc2ctPm1zZy5tc2dfaW5x
ID4gMSAmJiB0aGlzX3JldCA+IDAgJiYKIAkJICAgICFpb3ZfaXRlcl9jb3VudCgma21zZy0+
bXNnLm1zZ19pdGVyKSkgewogCQkJcmVxLT5jcWUuZmxhZ3MgPSBjZmxhZ3MgJiB+Q1FFX0Zf
TUFTSzsKIAkJCXNyLT5sZW4gPSBrbXNnLT5tc2cubXNnX2lucTsKIAkJCXNyLT5kb25lX2lv
ICs9IHRoaXNfcmV0OwotCQkJc3ItPnJldHJ5ID0gdHJ1ZTsKKwkJCXNyLT5yZXRyeV9mbGFn
cyB8PSBJT19TUl9NU0dfUkVUUlk7CiAJCQlyZXR1cm4gZmFsc2U7CiAJCX0KIAl9IGVsc2Ug
ewpAQCAtMTA4OSw2ICsxMDk0LDggQEAgc3RhdGljIGludCBpb19yZWN2X2J1Zl9zZWxlY3Qo
c3RydWN0IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBpb19hc3luY19tc2doZHIgKmttc2cKIAkJ
CWttc2ctPnZlYy5pb3ZlYyA9IGFyZy5pb3ZzOwogCQkJcmVxLT5mbGFncyB8PSBSRVFfRl9O
RUVEX0NMRUFOVVA7CiAJCX0KKwkJaWYgKGFyZy5wYXJ0aWFsX21hcCkKKwkJCXNyLT5yZXRy
eV9mbGFncyB8PSBJT19TUl9NU0dfUEFSVElBTF9NQVA7CiAKIAkJLyogc3BlY2lhbCBjYXNl
IDEgdmVjLCBjYW4gYmUgYSBmYXN0IHBhdGggKi8KIAkJaWYgKHJldCA9PSAxKSB7CkBAIC0x
Mjg1LDcgKzEyOTIsNyBAQCBpbnQgaW9fc2VuZF96Y19wcmVwKHN0cnVjdCBpb19raW9jYiAq
cmVxLCBjb25zdCBzdHJ1Y3QgaW9fdXJpbmdfc3FlICpzcWUpCiAJaW50IHJldDsKIAogCXpj
LT5kb25lX2lvID0gMDsKLQl6Yy0+cmV0cnkgPSBmYWxzZTsKKwl6Yy0+cmV0cnlfZmxhZ3Mg
PSAwOwogCiAJaWYgKHVubGlrZWx5KFJFQURfT05DRShzcWUtPl9fcGFkMlswXSkgfHwgUkVB
RF9PTkNFKHNxZS0+YWRkcjMpKSkKIAkJcmV0dXJuIC1FSU5WQUw7Ci0tIAoyLjUwLjAKCg==

--------------KdOXCiYXxKOqphvXaWJqlgWJ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-net-mark-iov-as-dynamically-allocated-even-.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-net-mark-iov-as-dynamically-allocated-even-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjZWI2MzI2NmFhNjc5ODZiY2VlYzIyMzEwOWRjMzk4NGUzYmVmNzA2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFdlZCwgMjUgSnVuIDIwMjUgMTA6MTc6MDYgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gaW9fdXJpbmcvbmV0OiBtYXJrIGlvdiBhcyBkeW5hbWljYWxseSBhbGxvY2F0ZWQgZXZl
biBmb3IKIHNpbmdsZSBzZWdtZW50cwoKQ29tbWl0IDlhNzA5YjdlOThlNmZhNTE2MDBiNWYy
ZDI0YzUwNjhlZmE2ZDM5ZGUgdXBzdHJlYW0uCgpBIGJpZ2dlciBhcnJheSBvZiB2ZWNzIGNv
dWxkJ3ZlIGJlZW4gYWxsb2NhdGVkLCBidXQKaW9fcmluZ19idWZmZXJzX3BlZWsoKSBzdGls
bCBkZWNpZGVkIHRvIGNhcCB0aGUgbWFwcGVkIHJhbmdlIGRlcGVuZGluZwpvbiBob3cgbXVj
aCBkYXRhIHdhcyBhdmFpbGFibGUuIEhlbmNlIGRvbid0IHJlbHkgb24gdGhlIHNlZ21lbnQg
Y291bnQKdG8ga25vdyBpZiB0aGUgcmVxdWVzdCBzaG91bGQgYmUgbWFya2VkIGFzIG5lZWRp
bmcgY2xlYW51cCwgYWx3YXlzCmNoZWNrIHVwZnJvbnQgaWYgdGhlIGlvdiBhcnJheSBpcyBk
aWZmZXJlbnQgdGhhbiB0aGUgZmFzdF9pb3YgYXJyYXkuCgpGaXhlczogMjZlYzE1ZTRiMGMx
ICgiaW9fdXJpbmcva2J1ZjogZG9uJ3QgdHJ1bmNhdGUgZW5kIGJ1ZmZlciBmb3IgbXVsdGlw
bGUgYnVmZmVyIHBlZWtzIikKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPgotLS0KIGlvX3VyaW5nL25ldC5jIHwgMTEgKysrKysrLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
aW9fdXJpbmcvbmV0LmMgYi9pb191cmluZy9uZXQuYwppbmRleCAzZmVjZWIyYjViOTcuLmFk
ZmRjZWEwMWUzOSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvbmV0LmMKKysrIGIvaW9fdXJpbmcv
bmV0LmMKQEAgLTEwODQsNiArMTA4NCwxMiBAQCBzdGF0aWMgaW50IGlvX3JlY3ZfYnVmX3Nl
bGVjdChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc3RydWN0IGlvX2FzeW5jX21zZ2hkciAqa21z
ZwogCQlpZiAodW5saWtlbHkocmV0IDwgMCkpCiAJCQlyZXR1cm4gcmV0OwogCisJCWlmIChh
cmcuaW92cyAhPSAma21zZy0+ZmFzdF9pb3YgJiYgYXJnLmlvdnMgIT0ga21zZy0+dmVjLmlv
dmVjKSB7CisJCQlrbXNnLT52ZWMubnIgPSByZXQ7CisJCQlrbXNnLT52ZWMuaW92ZWMgPSBh
cmcuaW92czsKKwkJCXJlcS0+ZmxhZ3MgfD0gUkVRX0ZfTkVFRF9DTEVBTlVQOworCQl9CisK
IAkJLyogc3BlY2lhbCBjYXNlIDEgdmVjLCBjYW4gYmUgYSBmYXN0IHBhdGggKi8KIAkJaWYg
KHJldCA9PSAxKSB7CiAJCQlzci0+YnVmID0gYXJnLmlvdnNbMF0uaW92X2Jhc2U7CkBAIC0x
MDkyLDExICsxMDk4LDYgQEAgc3RhdGljIGludCBpb19yZWN2X2J1Zl9zZWxlY3Qoc3RydWN0
IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBpb19hc3luY19tc2doZHIgKmttc2cKIAkJfQogCQlp
b3ZfaXRlcl9pbml0KCZrbXNnLT5tc2cubXNnX2l0ZXIsIElURVJfREVTVCwgYXJnLmlvdnMs
IHJldCwKIAkJCQlhcmcub3V0X2xlbik7Ci0JCWlmIChhcmcuaW92cyAhPSAma21zZy0+ZmFz
dF9pb3YgJiYgYXJnLmlvdnMgIT0ga21zZy0+dmVjLmlvdmVjKSB7Ci0JCQlrbXNnLT52ZWMu
bnIgPSByZXQ7Ci0JCQlrbXNnLT52ZWMuaW92ZWMgPSBhcmcuaW92czsKLQkJCXJlcS0+Zmxh
Z3MgfD0gUkVRX0ZfTkVFRF9DTEVBTlVQOwotCQl9CiAJfSBlbHNlIHsKIAkJdm9pZCBfX3Vz
ZXIgKmJ1ZjsKIAotLSAKMi41MC4wCgo=

--------------KdOXCiYXxKOqphvXaWJqlgWJ--

