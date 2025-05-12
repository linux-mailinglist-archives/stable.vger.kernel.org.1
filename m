Return-Path: <stable+bounces-143264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF43AB3819
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66E5189B3D4
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4230C294A16;
	Mon, 12 May 2025 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q4AK9RuF"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A9294A0C
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055273; cv=none; b=NUEiiA18zuwviIAIsyXfpfzO1bnLUoFcIKwhHPsatZYwlIayAK7gBb1/L3JMOpwdph024dx3IGioAOMh92XtmveH4rBpAaO6unyXhc3jclvWX04on8Byg/mOxpI8DrbsPJ4RylCAROdI4rHYyV5lXwj9WH7WWNaldNZzltxci4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055273; c=relaxed/simple;
	bh=Fs+M6uId+B4c1H7fhOlwKXlWbr4Vdtl0SaZ6FsX2D4w=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=OVP7c85MGW+AeCbC14wOjcne/nEFITrHxMDxvpyWSurT5750wwoKHNXyeMur59hyRxIfoEK2NGZQPhjlPPf/8gkrsyXQCZEb2JhwJd7+VgLlWl/KrPU7ZWpf14SEa9NZO+I2zBvAm2dcBznuQriGDLhMoyYYMvojEJLNExMujzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q4AK9RuF; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d817bc6eb0so22516385ab.1
        for <stable@vger.kernel.org>; Mon, 12 May 2025 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055269; x=1747660069; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpWI2ARTa3FlH1L6Mm9W5lNf50MD23VKRgs0P0juVio=;
        b=q4AK9RuFnHaMr75jVccFNb/mwjwIMyIUx3/4WxnaUYbKLQUs/Dw0u/6TMY+psJRFVZ
         SvJ1TiMdq3ANJqfbv9rZRSQ7W4p9lV1kFB7VIIeb28e3KArpH9H6dr3LpcTJdYyOo8pJ
         Lto7q/172FFIpHM5+G83E4+xfAH2qpgEP0znI+Ls3gnG8gggi4zOQFUvwoAxjsGCaKqK
         N+fPbNZD5iGYJH4+2Ox4dm4Rso+6cxw5A3anYqloOPpW9fSuT1UUCI0rjdj9zTN3HQxC
         aX5VAc/gCO3wIdSjcBaq4Dvk1DWatjSpvmtG37+1b5rsKznxrtwoBIa2vzZcqbqK3NjT
         stgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055269; x=1747660069;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BpWI2ARTa3FlH1L6Mm9W5lNf50MD23VKRgs0P0juVio=;
        b=wNXw5cVnCiW94MA8stAwCyoF+0P2dkwWYdobB5z88qlo34+8OgKfnOH70HNlu/7ih9
         S5I/vCGvEEReFzDQKsirX2/HUf6C2LW/3xx/lc9Xz/WC0gnNGTWOPKpFHhZSYWh6F/xs
         5j//94Hdegt+YLCht9YxWdWZgGFPDSRxyDOINq8TkfSBka6eXyQDqfbX5SR3UghcFcq8
         MZ1ucOFXX4Lwy8NP85CZltQJk2IowsPAh2osikzUDVek6sC7HpDE6RXeDGiam5IbtdGM
         XQE9FSowtr3efQj4pR/blE2ybxrGSio0fa9lp8B9n8PutV1VSYtpSoFzwiJc88QGovLf
         mYag==
X-Gm-Message-State: AOJu0YwCHWirUVwQcQbMWVPCfrXQXbsovyqQbUd4EPHZjjYwkfBnVEbB
	sJqWSihfzyY9qZXsIh4mki/5RN41XLDxHD/OKYfAr3vtwCFzbgUc3F1RwYCMUWg=
X-Gm-Gg: ASbGncuO+Y6r9Ecfjc0awBE2eTXZgiPPF1uFGrGF38Jw/PNw2Hqy39mVLt8niWJBdIn
	ua2Mkj9JoKG3MZsU7D+oQ4E7cn2JsAgqqk0ua7LDppS0t1ZNyQRhh1PcmlYituiosRCQEwhdFtd
	2UpPIL/MXo2G9hy3YErB6heS6mx8WM9wueQh0BP4ZGaY+O973K9CLQo/7Le8akJUF4W3EdOQfFp
	aILmn9io8aCJToG/whru2Mr2BG0ZHtsduwhim9ihALmD/+ZXZ8JmiQ1o3+PeM9hgwXASer3YUQz
	2GvA7yYpMhC+T+ZOgKxEYwzZRae49dYfsRcqJfJatQCn5lr+p0LAYw7OEw==
X-Google-Smtp-Source: AGHT+IE+OXSiRhMsS5FNxrrWDIvAuZuPSYpH6juCnFVTGm3/PjEMgiCQDWCOcpAgPj5t0W5P892aJw==
X-Received: by 2002:a05:6e02:3712:b0:3da:7176:81c0 with SMTP id e9e14a558f8ab-3da7e214338mr168782835ab.22.1747055269479;
        Mon, 12 May 2025 06:07:49 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e1049casm23080055ab.26.2025.05.12.06.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:07:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------9sgwWLqkfKI8TfFe2LOr88kg"
Message-ID: <b4c1ae6c-edf4-4fc7-ab0e-18109a157473@kernel.dk>
Date: Mon, 12 May 2025 07:07:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: always arm linked timeouts prior
 to issue" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, chase@path.net
Cc: stable@vger.kernel.org
References: <2025051226-snorkel-exclusive-71e3@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025051226-snorkel-exclusive-71e3@gregkh>

This is a multi-part message in MIME format.
--------------9sgwWLqkfKI8TfFe2LOr88kg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 4:01 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's a tested 6.1-stable backport.

-- 
Jens Axboe

--------------9sgwWLqkfKI8TfFe2LOr88kg
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-always-arm-linked-timeouts-prior-to-issue.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-always-arm-linked-timeouts-prior-to-issue.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSA4NTFhZjE1ODgwNTQ3NzYxMGJlYzZiMDliYzAzYTE2MmIxYmQ3MTkzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgNSBNYXkgMjAyNSAwODozNDozOSAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBpb191cmluZzogYWx3YXlzIGFybSBsaW5rZWQgdGltZW91dHMgcHJpb3IgdG8gaXNzdWUK
CkNvbW1pdCBiNTNlNTIzMjYxYmYwNThlYTRhNTE4YjQ4MjIyMmU3YTI3N2IxODZiIHVwc3Ry
ZWFtLgoKVGhlcmUgYXJlIGEgZmV3IHNwb3RzIHdoZXJlIGxpbmtlZCB0aW1lb3V0cyBhcmUg
YXJtZWQsIGFuZCBub3QgYWxsIG9mCnRoZW0gYWRoZXJlIHRvIHRoZSBwcmUtYXJtLCBhdHRl
bXB0IGlzc3VlLCBwb3N0LWFybSBwYXR0ZXJuLiBUaGlzIGNhbgpiZSBwcm9ibGVtYXRpYyBp
ZiB0aGUgbGlua2VkIHJlcXVlc3QgcmV0dXJucyB0aGF0IGl0IHdpbGwgdHJpZ2dlciBhCmNh
bGxiYWNrIGxhdGVyLCBhbmQgZG9lcyBzbyBiZWZvcmUgdGhlIGxpbmtlZCB0aW1lb3V0IGlz
IGZ1bGx5IGFybWVkLgoKQ29uc29saWRhdGUgYWxsIHRoZSBsaW5rZWQgdGltZW91dCBoYW5k
bGluZyBpbnRvIF9faW9faXNzdWVfc3FlKCksCnJhdGhlciB0aGFuIGhhdmUgaXQgc3ByZWFk
IHRocm91Z2hvdXQgdGhlIHZhcmlvdXMgaXNzdWUgZW50cnkgcG9pbnRzLgoKQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKTGluazogaHR0cHM6Ly9naXRodWIuY29tL2F4Ym9lL2xpYnVy
aW5nL2lzc3Vlcy8xMzkwClJlcG9ydGVkLWJ5OiBDaGFzZSBIaWx0eiA8Y2hhc2VAcGF0aC5u
ZXQ+ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBp
b191cmluZy9pb191cmluZy5jIHwgNTMgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMzcg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3Vy
aW5nL2lvX3VyaW5nLmMKaW5kZXggY2VhYzE1YTZiZjNiLi40ODg3OTNiMTE5ZDAgMTAwNjQ0
Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpA
QCAtMzcyLDI0ICszNzIsNiBAQCBzdGF0aWMgc3RydWN0IGlvX2tpb2NiICpfX2lvX3ByZXBf
bGlua2VkX3RpbWVvdXQoc3RydWN0IGlvX2tpb2NiICpyZXEpCiAJcmV0dXJuIHJlcS0+bGlu
azsKIH0KIAotc3RhdGljIGlubGluZSBzdHJ1Y3QgaW9fa2lvY2IgKmlvX3ByZXBfbGlua2Vk
X3RpbWVvdXQoc3RydWN0IGlvX2tpb2NiICpyZXEpCi17Ci0JaWYgKGxpa2VseSghKHJlcS0+
ZmxhZ3MgJiBSRVFfRl9BUk1fTFRJTUVPVVQpKSkKLQkJcmV0dXJuIE5VTEw7Ci0JcmV0dXJu
IF9faW9fcHJlcF9saW5rZWRfdGltZW91dChyZXEpOwotfQotCi1zdGF0aWMgbm9pbmxpbmUg
dm9pZCBfX2lvX2FybV9sdGltZW91dChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKLXsKLQlpb19x
dWV1ZV9saW5rZWRfdGltZW91dChfX2lvX3ByZXBfbGlua2VkX3RpbWVvdXQocmVxKSk7Ci19
Ci0KLXN0YXRpYyBpbmxpbmUgdm9pZCBpb19hcm1fbHRpbWVvdXQoc3RydWN0IGlvX2tpb2Ni
ICpyZXEpCi17Ci0JaWYgKHVubGlrZWx5KHJlcS0+ZmxhZ3MgJiBSRVFfRl9BUk1fTFRJTUVP
VVQpKQotCQlfX2lvX2FybV9sdGltZW91dChyZXEpOwotfQotCiBzdGF0aWMgdm9pZCBpb19w
cmVwX2FzeW5jX3dvcmsoc3RydWN0IGlvX2tpb2NiICpyZXEpCiB7CiAJY29uc3Qgc3RydWN0
IGlvX29wX2RlZiAqZGVmID0gJmlvX29wX2RlZnNbcmVxLT5vcGNvZGVdOwpAQCAtNDM3LDcg
KzQxOSw2IEBAIHN0YXRpYyB2b2lkIGlvX3ByZXBfYXN5bmNfbGluayhzdHJ1Y3QgaW9fa2lv
Y2IgKnJlcSkKIAogc3RhdGljIHZvaWQgaW9fcXVldWVfaW93cShzdHJ1Y3QgaW9fa2lvY2Ig
KnJlcSkKIHsKLQlzdHJ1Y3QgaW9fa2lvY2IgKmxpbmsgPSBpb19wcmVwX2xpbmtlZF90aW1l
b3V0KHJlcSk7CiAJc3RydWN0IGlvX3VyaW5nX3Rhc2sgKnRjdHggPSByZXEtPnRhc2stPmlv
X3VyaW5nOwogCiAJQlVHX09OKCF0Y3R4KTsKQEAgLTQ2Miw4ICs0NDMsNiBAQCBzdGF0aWMg
dm9pZCBpb19xdWV1ZV9pb3dxKHN0cnVjdCBpb19raW9jYiAqcmVxKQogCiAJdHJhY2VfaW9f
dXJpbmdfcXVldWVfYXN5bmNfd29yayhyZXEsIGlvX3dxX2lzX2hhc2hlZCgmcmVxLT53b3Jr
KSk7CiAJaW9fd3FfZW5xdWV1ZSh0Y3R4LT5pb193cSwgJnJlcS0+d29yayk7Ci0JaWYgKGxp
bmspCi0JCWlvX3F1ZXVlX2xpbmtlZF90aW1lb3V0KGxpbmspOwogfQogCiBzdGF0aWMgX19j
b2xkIHZvaWQgaW9fcXVldWVfZGVmZXJyZWQoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCkBA
IC0xNzQxLDE3ICsxNzIwLDI0IEBAIHN0YXRpYyBib29sIGlvX2Fzc2lnbl9maWxlKHN0cnVj
dCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAJcmV0dXJuICEh
cmVxLT5maWxlOwogfQogCisjZGVmaW5lIFJFUV9JU1NVRV9TTE9XX0ZMQUdTCShSRVFfRl9D
UkVEUyB8IFJFUV9GX0FSTV9MVElNRU9VVCkKKwogc3RhdGljIGludCBpb19pc3N1ZV9zcWUo
c3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIHsKIAlj
b25zdCBzdHJ1Y3QgaW9fb3BfZGVmICpkZWYgPSAmaW9fb3BfZGVmc1tyZXEtPm9wY29kZV07
CiAJY29uc3Qgc3RydWN0IGNyZWQgKmNyZWRzID0gTlVMTDsKKwlzdHJ1Y3QgaW9fa2lvY2Ig
KmxpbmsgPSBOVUxMOwogCWludCByZXQ7CiAKIAlpZiAodW5saWtlbHkoIWlvX2Fzc2lnbl9m
aWxlKHJlcSwgaXNzdWVfZmxhZ3MpKSkKIAkJcmV0dXJuIC1FQkFERjsKIAotCWlmICh1bmxp
a2VseSgocmVxLT5mbGFncyAmIFJFUV9GX0NSRURTKSAmJiByZXEtPmNyZWRzICE9IGN1cnJl
bnRfY3JlZCgpKSkKLQkJY3JlZHMgPSBvdmVycmlkZV9jcmVkcyhyZXEtPmNyZWRzKTsKKwlp
ZiAodW5saWtlbHkocmVxLT5mbGFncyAmIFJFUV9JU1NVRV9TTE9XX0ZMQUdTKSkgeworCQlp
ZiAoKHJlcS0+ZmxhZ3MgJiBSRVFfRl9DUkVEUykgJiYgcmVxLT5jcmVkcyAhPSBjdXJyZW50
X2NyZWQoKSkKKwkJCWNyZWRzID0gb3ZlcnJpZGVfY3JlZHMocmVxLT5jcmVkcyk7CisJCWlm
IChyZXEtPmZsYWdzICYgUkVRX0ZfQVJNX0xUSU1FT1VUKQorCQkJbGluayA9IF9faW9fcHJl
cF9saW5rZWRfdGltZW91dChyZXEpOworCX0KIAogCWlmICghZGVmLT5hdWRpdF9za2lwKQog
CQlhdWRpdF91cmluZ19lbnRyeShyZXEtPm9wY29kZSk7CkBAIC0xNzYxLDggKzE3NDcsMTIg
QEAgc3RhdGljIGludCBpb19pc3N1ZV9zcWUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2ln
bmVkIGludCBpc3N1ZV9mbGFncykKIAlpZiAoIWRlZi0+YXVkaXRfc2tpcCkKIAkJYXVkaXRf
dXJpbmdfZXhpdCghcmV0LCByZXQpOwogCi0JaWYgKGNyZWRzKQotCQlyZXZlcnRfY3JlZHMo
Y3JlZHMpOworCWlmICh1bmxpa2VseShjcmVkcyB8fCBsaW5rKSkgeworCQlpZiAoY3JlZHMp
CisJCQlyZXZlcnRfY3JlZHMoY3JlZHMpOworCQlpZiAobGluaykKKwkJCWlvX3F1ZXVlX2xp
bmtlZF90aW1lb3V0KGxpbmspOworCX0KIAogCWlmIChyZXQgPT0gSU9VX09LKSB7CiAJCWlm
IChpc3N1ZV9mbGFncyAmIElPX1VSSU5HX0ZfQ09NUExFVEVfREVGRVIpCkBAIC0xODA5LDgg
KzE3OTksNiBAQCB2b2lkIGlvX3dxX3N1Ym1pdF93b3JrKHN0cnVjdCBpb193cV93b3JrICp3
b3JrKQogCWVsc2UKIAkJcmVxX3JlZl9nZXQocmVxKTsKIAotCWlvX2FybV9sdGltZW91dChy
ZXEpOwotCiAJLyogZWl0aGVyIGNhbmNlbGxlZCBvciBpby13cSBpcyBkeWluZywgc28gZG9u
J3QgdG91Y2ggdGN0eC0+aW93cSAqLwogCWlmICh3b3JrLT5mbGFncyAmIElPX1dRX1dPUktf
Q0FOQ0VMKSB7CiBmYWlsOgpAQCAtMTkwOCwxNSArMTg5NiwxMSBAQCBzdHJ1Y3QgZmlsZSAq
aW9fZmlsZV9nZXRfbm9ybWFsKHN0cnVjdCBpb19raW9jYiAqcmVxLCBpbnQgZmQpCiBzdGF0
aWMgdm9pZCBpb19xdWV1ZV9hc3luYyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50IHJldCkK
IAlfX211c3RfaG9sZCgmcmVxLT5jdHgtPnVyaW5nX2xvY2spCiB7Ci0Jc3RydWN0IGlvX2tp
b2NiICpsaW5rZWRfdGltZW91dDsKLQogCWlmIChyZXQgIT0gLUVBR0FJTiB8fCAocmVxLT5m
bGFncyAmIFJFUV9GX05PV0FJVCkpIHsKIAkJaW9fcmVxX2NvbXBsZXRlX2ZhaWxlZChyZXEs
IHJldCk7CiAJCXJldHVybjsKIAl9CiAKLQlsaW5rZWRfdGltZW91dCA9IGlvX3ByZXBfbGlu
a2VkX3RpbWVvdXQocmVxKTsKLQogCXN3aXRjaCAoaW9fYXJtX3BvbGxfaGFuZGxlcihyZXEs
IDApKSB7CiAJY2FzZSBJT19BUE9MTF9SRUFEWToKIAkJaW9fa2J1Zl9yZWN5Y2xlKHJlcSwg
MCk7CkBAIC0xOTI5LDkgKzE5MTMsNiBAQCBzdGF0aWMgdm9pZCBpb19xdWV1ZV9hc3luYyhz
dHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50IHJldCkKIAljYXNlIElPX0FQT0xMX09LOgogCQli
cmVhazsKIAl9Ci0KLQlpZiAobGlua2VkX3RpbWVvdXQpCi0JCWlvX3F1ZXVlX2xpbmtlZF90
aW1lb3V0KGxpbmtlZF90aW1lb3V0KTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIGlvX3F1
ZXVlX3NxZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKQEAgLTE5NDUsOSArMTkyNiw3IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBpb19xdWV1ZV9zcWUoc3RydWN0IGlvX2tpb2NiICpyZXEpCiAJ
ICogV2UgYXN5bmMgcHVudCBpdCBpZiB0aGUgZmlsZSB3YXNuJ3QgbWFya2VkIE5PV0FJVCwg
b3IgaWYgdGhlIGZpbGUKIAkgKiBkb2Vzbid0IHN1cHBvcnQgbm9uLWJsb2NraW5nIHJlYWQv
d3JpdGUgYXR0ZW1wdHMKIAkgKi8KLQlpZiAobGlrZWx5KCFyZXQpKQotCQlpb19hcm1fbHRp
bWVvdXQocmVxKTsKLQllbHNlCisJaWYgKHVubGlrZWx5KHJldCkpCiAJCWlvX3F1ZXVlX2Fz
eW5jKHJlcSwgcmV0KTsKIH0KIAotLSAKMi40OS4wCgo=

--------------9sgwWLqkfKI8TfFe2LOr88kg--

