Return-Path: <stable+bounces-210356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F045AD3AB5A
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAFD0300FE03
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AC32693E;
	Mon, 19 Jan 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EdV5FQjj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915A376BFF
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831795; cv=none; b=YtdiulfhoYYErvX8Q9t1km+wgpXqyBhQh3VYY7XDXHKT1PW0m+uUEGezkt3HelLxJt/B+kTRCshefjKBJBNgV+iQumWmeXrSIldeeWkwbAN4ez5ocEzT+QREKYeW+bEY89X7mx7qN7Ecm3omrJR9rQdAMiUQa3S5q2UjkDBHymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831795; c=relaxed/simple;
	bh=6U8McwR52eIu6tT5JV1q0h4k03viouDmkp+RqWVDq4w=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=O7jBmYtUAEustL/I0sqKFzjO9IGl8FlUD2LxY8Z5gFf9DJors8151CDslJ3YzsNDXdD32wokpihyE2uGY65dlK6jVODFkh60fCJbIfMim+zvbpDfuMXc0meGOcaDEvYjvzpkIK8iiJxKWh31Tfoy9xUf0dQ/S4kmbCBVqYvkd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EdV5FQjj; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40423dbe98bso1640751fac.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768831790; x=1769436590; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn+kgCXo+gO3XBNdhRqVLYxyzQzS1oytNHk5Z1E3Ox8=;
        b=EdV5FQjjS23lLIj9wjEnwvJDdkK11IQXzx9sVGTlLf6VCOc5nQ8iPWGHBnJVU0Iejw
         D47uquxvs9xavBRGgNH8FLzAlOhATtdv04F5IxeCjirkCnfU5wVHks30ELeqaDMa3aIS
         VNgF9wB7GfH40ucoqI5td9JnYamfUWOyqVFMq9E0Q2/2cf1Lr4+T8NQ31LAX1eJkUH5R
         3KSoMkJM7Vc+Uipx7iJih4F0op7ElGXDrIPHQbggsuVkk1rAJkwCsrr/Z+tISuGP+oC/
         rklMkKiAU2/tbIMml3G+moIlcwMD0LP3JcFyVUnoQ8HGwZmPlAZQt6lNSFWv8qAedYKM
         IddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831790; x=1769436590;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nn+kgCXo+gO3XBNdhRqVLYxyzQzS1oytNHk5Z1E3Ox8=;
        b=lp5YDakkoPr5WEzaTEZccVUvlE0bopMzEt3Xznak1AjDY8t1KOdaB2Lz5pqEoSX9k8
         4XBkBgXUS2MTogy32B/bFonmbAZfqIo2dSHpocdmdLMLzhI5Xc0w6nYJPippklFbSusw
         JK0KaDj5Mt7B9hvmQnbhTQ4NIpz2WIyQsPcN5V6lSOxJbTkoBkrtSmwpTzvsLZ4b9fxF
         PjFdj72P2FtjeNQyxaQzRBVWp1zdGWuI9RlkNmQZFryP9WnQqVsxfhTcz03zfhOvyjG/
         Hxu9ndBCzfoKo+tXq9OGVCWzUi4yl0f6rzcoLzst1nNoBsvQ7+4kjU018gx12WfZL6xu
         tKYA==
X-Gm-Message-State: AOJu0Yz9uzbgrqkvSMIkT7VG8TaxkTkpYbrSh55AvidRKrzzrcWyMLQt
	Atc9PjAp3ArmO9iwAE5PQlS/UGyB17c3GvF8dqQ0Qe6DKOGkvAPn41vCnvVPrQaSUBXsm2vYOve
	MZfk3
X-Gm-Gg: AY/fxX4ofFQfb3WewPUNJqeEXNZ+hZU8trb++vJaIQLLe/y0xGT0HNvt2b3LOnYo5Wi
	WnEqvi9Xncv4RFkWrTnjsTjsnrxoWoOXnbTfeKX+yKURZ9EIt7F57LsWdu+SCmTr7ADzl9KoShJ
	WObHve8bdcmynhLnVflme7exUa7zQd7L4+z89t+apfXLU0dLt/JFi9MqUzuQiBuHlG0JCieumKC
	mr7AQ3f05G33gAgDnkNaVbhWpqERRrK3/29Lz01PXYwd1iBbdfOFIZLBwpTVXqIeVK/tKNkcu5/
	Un3BA0++/sif4zhrFVJJadsXwh81iHDLfVqc5BUBF4e8RXgltjnMw7SHrugx7pyk63oMF1Ec4HY
	h/TaWHumMHiaJGJTvacF7SlbuwTw18oofto93XGw0DL4bnVGsAM75kvwdbTYOjpNqGFkI0gQBeN
	mL7KMwjdABo4bSOEbcRJ7nUXPhmVk+O0ICe1mZAa5BlXVctDAXL40zbsNxi0w5/XeaPWKe3Q==
X-Received: by 2002:a05:6870:fb92:b0:3f1:644f:56b0 with SMTP id 586e51a60fabf-4044d09dfd6mr5277885fac.53.1768831789756;
        Mon, 19 Jan 2026 06:09:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bda221asm6776158fac.20.2026.01.19.06.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:09:48 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------0c3stn23lDdEhRSm0bpr4O18"
Message-ID: <70e03a78-fa04-48c6-8252-7d0724c2c860@kernel.dk>
Date: Mon, 19 Jan 2026 07:09:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: move local task_work in exit
 cancel loop" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, ming.lei@redhat.com
Cc: stable@vger.kernel.org
References: <2026011955-pulmonary-transpire-4456@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026011955-pulmonary-transpire-4456@gregkh>

This is a multi-part message in MIME format.
--------------0c3stn23lDdEhRSm0bpr4O18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 4:47 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x da579f05ef0faada3559e7faddf761c75cdf85e1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011955-pulmonary-transpire-4456@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Here's one for 6.12-stable.

-- 
Jens Axboe

--------------0c3stn23lDdEhRSm0bpr4O18
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-move-local-task_work-in-exit-cancel-loop.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-move-local-task_work-in-exit-cancel-loop.patch"
Content-Transfer-Encoding: base64

RnJvbSBkZGRlMWU4OTU1YzRkNzU3NGFmN2Y3OGZmYTY0Njk1NDgyZGUzZmM4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0LmNvbT4K
RGF0ZTogV2VkLCAxNCBKYW4gMjAyNiAxNjo1NDowNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hd
IGlvX3VyaW5nOiBtb3ZlIGxvY2FsIHRhc2tfd29yayBpbiBleGl0IGNhbmNlbCBsb29wCgpD
b21taXQgZGE1NzlmMDVlZjBmYWFkYTM1NTllN2ZhZGRmNzYxYzc1Y2RmODVlMSB1cHN0cmVh
bS4KCldpdGggSU9SSU5HX1NFVFVQX0RFRkVSX1RBU0tSVU4sIHRhc2sgd29yayBpcyBxdWV1
ZWQgdG8gY3R4LT53b3JrX2xsaXN0Cihsb2NhbCB3b3JrKSByYXRoZXIgdGhhbiB0aGUgZmFs
bGJhY2sgbGlzdC4gRHVyaW5nIGlvX3JpbmdfZXhpdF93b3JrKCksCmlvX21vdmVfdGFza193
b3JrX2Zyb21fbG9jYWwoKSB3YXMgY2FsbGVkIG9uY2UgYmVmb3JlIHRoZSBjYW5jZWwgbG9v
cCwKbW92aW5nIHdvcmsgZnJvbSB3b3JrX2xsaXN0IHRvIGZhbGxiYWNrX2xsaXN0LgoKSG93
ZXZlciwgdGFzayB3b3JrIGNhbiBiZSBhZGRlZCB0byB3b3JrX2xsaXN0IGR1cmluZyB0aGUg
Y2FuY2VsIGxvb3AKaXRzZWxmLiBUaGVyZSBhcmUgdHdvIGNhc2VzOgoKMSkgaW9fa2lsbF90
aW1lb3V0cygpIGlzIGNhbGxlZCBmcm9tIGlvX3VyaW5nX3RyeV9jYW5jZWxfcmVxdWVzdHMo
KSB0bwpjYW5jZWwgcGVuZGluZyB0aW1lb3V0cywgYW5kIGl0IGFkZHMgdGFzayB3b3JrIHZp
YSBpb19yZXFfcXVldWVfdHdfY29tcGxldGUoKQpmb3IgZWFjaCBjYW5jZWxsZWQgdGltZW91
dDoKCjIpIFVSSU5HX0NNRCByZXF1ZXN0cyBsaWtlIHVibGsgY2FuIGJlIGNvbXBsZXRlZCB2
aWEKaW9fdXJpbmdfY21kX2NvbXBsZXRlX2luX3Rhc2soKSBmcm9tIHVibGtfcXVldWVfcnEo
KSBkdXJpbmcgY2FuY2VsaW5nLApnaXZlbiB1YmxrIHJlcXVlc3QgcXVldWUgaXMgb25seSBx
dWllc2NlZCB3aGVuIGNhbmNlbGluZyB0aGUgMXN0IHVyaW5nX2NtZC4KClNpbmNlIGlvX2Fs
bG93ZWRfZGVmZXJfdHdfcnVuKCkgcmV0dXJucyBmYWxzZSBpbiBpb19yaW5nX2V4aXRfd29y
aygpCihrd29ya2VyICE9IHN1Ym1pdHRlcl90YXNrKSwgaW9fcnVuX2xvY2FsX3dvcmsoKSBp
cyBuZXZlciBpbnZva2VkLAphbmQgdGhlIHdvcmtfbGxpc3QgZW50cmllcyBhcmUgbmV2ZXIg
cHJvY2Vzc2VkLiBUaGlzIGNhdXNlcwppb191cmluZ190cnlfY2FuY2VsX3JlcXVlc3RzKCkg
dG8gbG9vcCBpbmRlZmluaXRlbHksIHJlc3VsdGluZyBpbgoxMDAlIENQVSB1c2FnZSBpbiBr
d29ya2VyIHRocmVhZHMuCgpGaXggdGhpcyBieSBtb3ZpbmcgaW9fbW92ZV90YXNrX3dvcmtf
ZnJvbV9sb2NhbCgpIGluc2lkZSB0aGUgY2FuY2VsCmxvb3AsIGVuc3VyaW5nIGFueSB3b3Jr
IG9uIHdvcmtfbGxpc3QgaXMgbW92ZWQgdG8gZmFsbGJhY2sgYmVmb3JlCmVhY2ggY2FuY2Vs
IGF0dGVtcHQuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogYzBlMGQ2YmEy
NWYxICgiaW9fdXJpbmc6IGFkZCBJT1JJTkdfU0VUVVBfREVGRVJfVEFTS1JVTiIpClNpZ25l
ZC1vZmYtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CihjaGVycnkgcGlja2VkIGZyb20gY29t
bWl0IGRhNTc5ZjA1ZWYwZmFhZGEzNTU5ZTdmYWRkZjc2MWM3NWNkZjg1ZTEpCi0tLQogaW9f
dXJpbmcvaW9fdXJpbmcuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJp
bmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggYWRmMmIwYTFiYjU5Li45OWIwYjFi
YTBmZTIgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcv
aW9fdXJpbmcuYwpAQCAtMjkwNCwxMSArMjkwNCwxMSBAQCBzdGF0aWMgX19jb2xkIHZvaWQg
aW9fcmluZ19leGl0X3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJbXV0ZXhf
dW5sb2NrKCZjdHgtPnVyaW5nX2xvY2spOwogCQl9CiAKLQkJaWYgKGN0eC0+ZmxhZ3MgJiBJ
T1JJTkdfU0VUVVBfREVGRVJfVEFTS1JVTikKLQkJCWlvX21vdmVfdGFza193b3JrX2Zyb21f
bG9jYWwoY3R4KTsKLQotCQl3aGlsZSAoaW9fdXJpbmdfdHJ5X2NhbmNlbF9yZXF1ZXN0cyhj
dHgsIE5VTEwsIHRydWUpKQorCQlkbyB7CisJCQlpZiAoY3R4LT5mbGFncyAmIElPUklOR19T
RVRVUF9ERUZFUl9UQVNLUlVOKQorCQkJCWlvX21vdmVfdGFza193b3JrX2Zyb21fbG9jYWwo
Y3R4KTsKIAkJCWNvbmRfcmVzY2hlZCgpOworCQl9IHdoaWxlIChpb191cmluZ190cnlfY2Fu
Y2VsX3JlcXVlc3RzKGN0eCwgTlVMTCwgdHJ1ZSkpOwogCiAJCWlmIChjdHgtPnNxX2RhdGEp
IHsKIAkJCXN0cnVjdCBpb19zcV9kYXRhICpzcWQgPSBjdHgtPnNxX2RhdGE7Ci0tIAoyLjUx
LjAKCg==

--------------0c3stn23lDdEhRSm0bpr4O18--

