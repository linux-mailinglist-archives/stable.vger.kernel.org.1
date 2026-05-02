Return-Path: <stable+bounces-242578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MABSAH9m9WmBKwIAu9opvQ
	(envelope-from <stable+bounces-242578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:50:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E974B0B75
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 04:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FC653019F2F
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 02:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8472C11D6;
	Sat,  2 May 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="f+66MlW4"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09AB40DFB7
	for <stable@vger.kernel.org>; Sat,  2 May 2026 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777690225; cv=none; b=l3KNZslxqQsYIQQANz/bsFSlkx6EtBg6wYP8HBpxrcxRCIzeP7Ipk9FYFfeoOqcmWInhKVmAgsa5zvxyvEP2D2gnOv+1fRfEa9yLw/mmsI8+Fx+5PBgM4hS4vGD9eUHMBYKzVgHSACSXXqJ8c56lqncDYI7iz2PdUmI0yQnoaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777690225; c=relaxed/simple;
	bh=1YQ86PX3bPHQ51IFvItQivdsH0SE7Ty0e0nRywR/zm0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=qBvCoasGxBNZxempfscu4HjC1M4kV/hhrlr40fNVoRAr/ZePpCoz8U+QVq0iolG0tR0AvCnDVPapd6B4NHc+z3X0ql0G4kiVjtFjNidto94XISyRuEdOz9dyEgyFsf+Q/7mlj0WppUWYrmskORcuihotuyXTdfW7ul+dZuOn8/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=f+66MlW4; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47bdee5bfc4so1811278b6e.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 19:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777690223; x=1778295023; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Yjf9w7h0h5rcWNgfjnZwRZBCmB56Tv3LZF5qrz18c=;
        b=f+66MlW4K1CIZtRNO4kzexcBt4aDh7fi++wvkpXwyxLD6bJManVOV53qqH71SnkQuO
         NUncAYra8QLrSA+EKNRY+sJ+2Kjpfry6fZ+OW5kToKgOhKyYLX5LzgAs13GGXCWGeHdG
         U9OmK/TcWNr4IJjIfeZcTgCJm4JVpft4HUsBgB/46/bI7LCl/i4+q8NMMBoj8S4/vYea
         /FcJ8ENAVg9dlMvID+AFMEiLKHmo7ybpGjBgA+R5AXDCQpYVJ5yRRGgFZlhmIaAO5yXc
         T1jC2TXg02eGsRsWPOGCfwxWnvUMZDsEeZDGZkFI7EOeZOFGspJ1XLe7DigbFcTWDo4p
         QDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777690223; x=1778295023;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5Yjf9w7h0h5rcWNgfjnZwRZBCmB56Tv3LZF5qrz18c=;
        b=f2PGqT/lo4drIyjjDRwjFz1/Qo7jV747Ifp3J4l6ZGsBx1A6mRtYK0uWgFRwo8jgy+
         euQIw7drJFQuBLRpm4wbOoirB+aQ/uvly6gg0rUXi/Y9YX+IINg89p9G2LfqC7ly56G/
         mcL0RVlZ5QflUZTRTjaA7SzslQV8FKlt7u4g1+x3coG/wiYNrVNBOOxUHOIUvT0xjdzY
         yjvXAhbrM/3sHvvewUVrEVRbWgJKYlZM9bxpcB/KszR1/rKmZukndJ8D4RHhawqTBBBu
         axlufuRGvJ91yHI7QqD6V2b5qu0KqT4gqvYSdOiWkAySwBoi4DxOOgUQjq3RpeCtLlNT
         Kitg==
X-Gm-Message-State: AOJu0YyvcIpGZs8rjLyRxjdAoVQK01hiTYM6QKgpXkMxF76KGngQGaI/
	6JYvhmD0+1Vnh2sUUNjs2M0ZFp531E96CTs4kkcWep90BbXn8HiCXpxr8KhUp21XVOI=
X-Gm-Gg: AeBDiesY2iX+jtMOf8c36Qc7EyXk/pNIxR5/8fjCvc9DCJgN59x3SHO34FU/Y08Cr9M
	Eyt6KzWxUWCj2i58BVvzmN6JV771cM4PGDZcFtU4x5ObL6J4LVyhVpaDdfn/KarjwgRiGmz+SEZ
	7XrsQN8kwDG3IzzDiP5zutwTcNNuw8wRMfzSp6YauR3K6RFpA1zbSJe5tv1xm5OIsSgRXjHlmit
	DEcLrA3oxTQWmeePr8Feqv+3ZpaOOJTKZCwDX+ggFfD04vO5cbu7XkVGzqRw4ElAEXYrM6lkyhz
	vtsqrTMT3fg5ZI4Q/CAfaVq5zbwZUaabFHJHwMPlGPBNDBE5qhujuXk+DfbX32Lkbkk7wy0tYeR
	DHEGj1YOf/JH0uOwIF58YsCurHw7DHF4yOWdTKe2biVOS6dZ2XFkB/gFzbHyYO+HE4wMv5i32d2
	gnuvEG+W3ZnEj/a8AuYu5B74my18dsnJhkQUS1/GenddRbqE0LXpqXPNe+FtX6VWZ6rc1LUFELr
	wTvyfrGV3rjhawRAwl/rZQqgDz5u0E=
X-Received: by 2002:a05:6808:178c:b0:468:698:a626 with SMTP id 5614622812f47-47c620e6512mr3616577b6e.22.1777690222654;
        Fri, 01 May 2026 19:50:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded1915908sm2604787a34.14.2026.05.01.19.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 19:50:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------IsMMyAOZLvaGyb29EpceTQC9"
Message-ID: <c5c51528-5bbd-48d7-860f-e45f5bc42649@kernel.dk>
Date: Fri, 1 May 2026 20:50:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: fix signed comparison in"
 failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, ylong030@ucr.edu, asml.silence@gmail.com,
 bird@lzu.edu.cn, n05ec@lzu.edu.cn, tomapufckgml@gmail.com,
 yifanwucs@gmail.com, yuantan098@gmail.com, zcliangcn@gmail.com
Cc: stable@vger.kernel.org
References: <2026050147-vitality-crayfish-d8e1@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026050147-vitality-crayfish-d8e1@gregkh>
X-Rspamd-Queue-Id: 52E974B0B75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-242578-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[linuxfoundation.org,ucr.edu,gmail.com,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is a multi-part message in MIME format.
--------------IsMMyAOZLvaGyb29EpceTQC9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 5:08 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 326941b22806cbf2df1fbfe902b7908b368cce42
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050147-vitality-crayfish-d8e1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's a version of that for 5.15 AND 5.10-stable, please apply for both.

-- 
Jens Axboe

--------------IsMMyAOZLvaGyb29EpceTQC9
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-fix-signed-comparison-in-io_poll_get_o.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-fix-signed-comparison-in-io_poll_get_o.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0ZjFkZGNlNDA0MmVhNGIzZDhhM2QxNGQxYjQ3NDVkNDA4YjY4MDkwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBMb25neHVhbiBZdSA8eWxvbmcwMzBAdWNyLmVkdT4K
RGF0ZTogU3VuLCAxMiBBcHIgMjAyNiAxNjozODoyMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IGlvX3VyaW5nL3BvbGw6IGZpeCBzaWduZWQgY29tcGFyaXNvbiBpbgogaW9fcG9sbF9nZXRf
b3duZXJzaGlwKCkKCkNvbW1pdCAzMjY5NDFiMjI4MDZjYmYyZGYxZmJmZTkwMmI3OTA4YjM2
OGNjZTQyIHVzcHRyZWFtLgoKaW9fcG9sbF9nZXRfb3duZXJzaGlwKCkgdXNlcyBhIHNpZ25l
ZCBjb21wYXJpc29uIHRvIGNoZWNrIHdoZXRoZXIKcG9sbF9yZWZzIGhhcyByZWFjaGVkIHRo
ZSB0aHJlc2hvbGQgZm9yIHRoZSBzbG93cGF0aDoKCiAgICBpZiAodW5saWtlbHkoYXRvbWlj
X3JlYWQoJnJlcS0+cG9sbF9yZWZzKSA+PSBJT19QT0xMX1JFRl9CSUFTKSkKCmF0b21pY19y
ZWFkKCkgcmV0dXJucyBpbnQgKHNpZ25lZCkuIFdoZW4gSU9fUE9MTF9DQU5DRUxfRkxBRwoo
QklUKDMxKSkgaXMgc2V0IGluIHBvbGxfcmVmcywgdGhlIHZhbHVlIGJlY29tZXMgbmVnYXRp
dmUgaW4Kc2lnbmVkIGFyaXRobWV0aWMsIHNvIHRoZSA+PSAxMjggY29tcGFyaXNvbiBhbHdh
eXMgZXZhbHVhdGVzIHRvCmZhbHNlIGFuZCB0aGUgc2xvd3BhdGggaXMgbmV2ZXIgdGFrZW4u
CgpGaXggdGhpcyBieSBjYXN0aW5nIHRoZSBhdG9taWNfcmVhZCgpIHJlc3VsdCB0byB1bnNp
Z25lZCBpbnQKYmVmb3JlIHRoZSBjb21wYXJpc29uLCBzbyB0aGF0IHRoZSBjYW5jZWwgZmxh
ZyBpcyB0cmVhdGVkIGFzIGEKbGFyZ2UgcG9zaXRpdmUgdmFsdWUgYW5kIGNvcnJlY3RseSB0
cmlnZ2VycyB0aGUgc2xvd3BhdGguCgpGaXhlczogYTI2YTM1ZTkwMTlmICgiaW9fdXJpbmc6
IG1ha2UgcG9sbCByZWZzIG1vcmUgcm9idXN0IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKUmVwb3J0ZWQtYnk6IFlpZmFuIFd1IDx5aWZhbnd1Y3NAZ21haWwuY29tPgpSZXBvcnRl
ZC1ieTogSnVlZmVpIFB1IDx0b21hcHVmY2tnbWxAZ21haWwuY29tPgpDby1kZXZlbG9wZWQt
Ynk6IFl1YW4gVGFuIDx5dWFudGFuMDk4QGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogWXVh
biBUYW4gPHl1YW50YW4wOThAZ21haWwuY29tPgpTdWdnZXN0ZWQtYnk6IFhpbiBMaXUgPGJp
cmRAbHp1LmVkdS5jbj4KVGVzdGVkLWJ5OiBaaGVuZ2NodWFuIExpYW5nIDx6Y2xpYW5nY25A
Z21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBMb25neHVhbiBZdSA8eWxvbmcwMzBAdWNyLmVk
dT4KU2lnbmVkLW9mZi1ieTogUmVuIFdlaSA8bjA1ZWNAbHp1LmVkdS5jbj4KUmV2aWV3ZWQt
Ynk6IFBhdmVsIEJlZ3Vua292IDxhc21sLnNpbGVuY2VAZ21haWwuY29tPgpMaW5rOiBodHRw
czovL3BhdGNoLm1zZ2lkLmxpbmsvM2EzNTA4YjA4YmNkN2YxYmMzYmVmZjg0OGFlNmUxZDcz
ZDM1NTA0My4xNzc1OTY1NTk3LmdpdC55bG9uZzAzMEB1Y3IuZWR1ClNpZ25lZC1vZmYtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9pb191cmluZy5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5n
LmMKaW5kZXggY2I1NGViZGEwYThhLi5iYzBmMWE0OTgwZWUgMTAwNjQ0Ci0tLSBhL2lvX3Vy
aW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpAQCAtNTUyNSw3ICs1
NTI1LDcgQEAgc3RhdGljIGJvb2wgaW9fcG9sbF9nZXRfb3duZXJzaGlwX3Nsb3dwYXRoKHN0
cnVjdCBpb19raW9jYiAqcmVxKQogICovCiBzdGF0aWMgaW5saW5lIGJvb2wgaW9fcG9sbF9n
ZXRfb3duZXJzaGlwKHN0cnVjdCBpb19raW9jYiAqcmVxKQogewotCWlmICh1bmxpa2VseShh
dG9taWNfcmVhZCgmcmVxLT5wb2xsX3JlZnMpID49IElPX1BPTExfUkVGX0JJQVMpKQorCWlm
ICh1bmxpa2VseSgodW5zaWduZWQgaW50KWF0b21pY19yZWFkKCZyZXEtPnBvbGxfcmVmcykg
Pj0gSU9fUE9MTF9SRUZfQklBUykpCiAJCXJldHVybiBpb19wb2xsX2dldF9vd25lcnNoaXBf
c2xvd3BhdGgocmVxKTsKIAlyZXR1cm4gIShhdG9taWNfZmV0Y2hfaW5jKCZyZXEtPnBvbGxf
cmVmcykgJiBJT19QT0xMX1JFRl9NQVNLKTsKIH0KLS0gCjIuNTMuMAoK

--------------IsMMyAOZLvaGyb29EpceTQC9--

