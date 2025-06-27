Return-Path: <stable+bounces-158795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BD9AEBCD9
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 18:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0031C608AD
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEC32EA475;
	Fri, 27 Jun 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YB8xNf54"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF42EA166
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040605; cv=none; b=dQiVogWg6crKM3EUS3qC6lHkxB411c1QUHyU1W7RBUNxAjdtSS4kVc/zU2HaxQx73/Dq944uqgjOJ5970LVQc1CmQA+qn6MlqGWhcBC7SACt4IBfbwVWKE7klPvrofVWSDYDBBXA9Kb2MDjmj6pzvj/dY1fk/HIFxFtW4I7Yb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040605; c=relaxed/simple;
	bh=H8KgJGD4tGs78wnbxiHGjMrU9aNrHA+Hp2dv/6vUsAA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=qTw1EjVqrS+joaPksGuMxhyUk43x7q/N/KBqLUYIQHBl1qTZH8TK1Y5MEZZr/dIvMeNEHJvzO9gUUBqF/uX7ag48zfLaoZ0MkZv510aQ2rA1jpcS5AAc23+N4n6wpfHPaAFGGyqHGMFINEIeWRvpmR72ZnOxRd9W94Le6Kz1v4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YB8xNf54; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2856572b3a.0
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751040602; x=1751645402; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiZRBkvRgmJo80Flyd7sHs9wf0++3fw8LTQVAmZyapI=;
        b=YB8xNf54jbMLe8srFT0iBWNIvi7oeBcj93VNrthnvhi3lmJ98mp3RS+2Cy+jAnKIPZ
         r2foFZuGo0qs+oBv2i10r+32eG7RLWJQIkJXQpqMT8TqSIsqzb/6rYche4vMl1+Nlya0
         bm7BuoD5ROQd8dkOE9Py5C8ZLGzH7tXZ0N0CKhVAkh+8qvp4nN9ddElstyB9t0x5vSK8
         vtz6DYycpGBCyw55faqvYJjnEe93yBppKFZVjFdFkFIkk+Yys1f1fD5SE//nrXzhNI64
         zVuHUnRRtoSDTm9Bj4sdX90giygILDohUYef8tEn4ZaWWQ+BLzGyWjvu9jC3O7mCdFyJ
         dFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751040602; x=1751645402;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wiZRBkvRgmJo80Flyd7sHs9wf0++3fw8LTQVAmZyapI=;
        b=AFCveeT2rOdBzOGXgXmxEWLBpGwVUrh/lBv34LUtsKYpdvUwUlyH1HAogOYYsWpCWB
         2X9TAD6WL3pAu59ASCUGwXIgakCJ4feSS8AI2IQQwTIUDkklsSapZfDNIHozx961Pq3p
         /AXcaZtiRJIecaxvoqHC3guGT9YTugkdmuDjhRphEHFtBnB/fsIoBbAI1OVeqTQWl/TM
         x0kuxo0v/GqMuatBXBIQJ9Tc9++JSqtOReqK6/veBoMwhItR9slIp7HnRlyFwLLK8xYV
         XXOLdUvgA9PVwI05emaKqXQysUvewT1R8hxvQGFoMUM1+OOUOPORSEYzev8rsC/CjDDi
         bqjg==
X-Gm-Message-State: AOJu0Yy9sSjjToSQKaXbN1OI9ofZ2szDZld/VhD776zqKQcy6RpIswCu
	8VWduhaQVmnxr8I1MYAsr+sdPFzKzvxBait0Xbu8a/ysgJNBvfjtABfNYJaKpDOpiAw=
X-Gm-Gg: ASbGncvAXhP/fcM2bzmbcNKfzCucLcuUhyYWMvppP/kT+Q6ADnaRErShxN4wxWUMGe1
	QQzsg9b/9NTKeJNNC0UKGtNxjp36Y+d4uyVcQqeCPP7xJns1R4gFbftjUiRfmPnEH1lBQkyg9W1
	etyGf7RJ9Bn8TuGlNV8mue41xcDqvCzGybLXOdldcqundBhOZ7GYCfy3rtctIgKZHh3jrZZW4fs
	wDMKhbIJYyddcFlQt+i0LIErL8N8vJD/3CyNggAfZtZqecGZYXg75JFjr1n26/ypnEUyDiSo04M
	q5ZuDhuzff8lzgnzwWWdq1EyfMUFoYBRc04g5u54k/2Rvg2b8hAXBKNdUw==
X-Google-Smtp-Source: AGHT+IG/SxtPPgd4YwpR5ik5hyJj6OHuCKNMsgZRI4hfFCAZS098ESmB5oRTu2Lyt2tP1JQTloqQdA==
X-Received: by 2002:a17:903:2304:b0:233:d3e7:6fd6 with SMTP id d9443c01a7336-2390a51a55cmr134427055ad.19.1751040602520;
        Fri, 27 Jun 2025 09:10:02 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b900sm20137315ad.93.2025.06.27.09.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:10:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------rp5Ny8glHdszJE3oYer34tAA"
Message-ID: <a527c502-4cd6-477d-b77e-7e987486c52e@kernel.dk>
Date: Fri, 27 Jun 2025 10:09:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] nvme: always punt polled uring_cmd end_io
 work to task_work" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2025062012-veggie-grout-8f7e@gregkh>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <2025062012-veggie-grout-8f7e@gregkh>

This is a multi-part message in MIME format.
--------------rp5Ny8glHdszJE3oYer34tAA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 9:10 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 9ce6c9875f3e995be5fd720b65835291f8a609b1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062012-veggie-grout-8f7e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's a 6.1-stable variant.

-- 
Jens Axboe
--------------rp5Ny8glHdszJE3oYer34tAA
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-nvme-always-punt-polled-uring_cmd-end_io-work-to-tas.patch"
Content-Disposition: attachment;
 filename*0="0002-nvme-always-punt-polled-uring_cmd-end_io-work-to-tas.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2YzRhM2NlYzBlNDYzYzNiZWE5MWNmNjI1YmY0ZjBmZmEyMWZlOTM0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IEZyaSwgMTMgSnVuIDIwMjUgMTM6Mzc6NDEgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gbnZtZTogYWx3YXlzIHB1bnQgcG9sbGVkIHVyaW5nX2NtZCBlbmRfaW8gd29yayB0bwog
dGFza193b3JrCgpDb21taXQgOWNlNmM5ODc1ZjNlOTk1YmU1ZmQ3MjBiNjU4MzUyOTFmOGE2
MDliMSB1cHN0cmVhbS4KCkN1cnJlbnRseSBOVk1lIHVyaW5nX2NtZCBjb21wbGV0aW9ucyB3
aWxsIGNvbXBsZXRlIGxvY2FsbHksIGlmIHRoZXkgYXJlCnBvbGxlZC4gVGhpcyBpcyBkb25l
IGJlY2F1c2UgdGhvc2UgY29tcGxldGlvbnMgYXJlIGFsd2F5cyBpbnZva2VkIGZyb20KdGFz
ayBjb250ZXh0LiBBbmQgd2hpbGUgdGhhdCBpcyB0cnVlLCB0aGVyZSdzIG5vIGd1YXJhbnRl
ZSB0aGF0IGl0J3MKaW52b2tlZCB1bmRlciB0aGUgcmlnaHQgcmluZyBjb250ZXh0LCBvciBl
dmVuIHRhc2suIElmIHNvbWVvbmUgZG9lcwpOVk1lIHBhc3N0aHJvdWdoIHZpYSBtdWx0aXBs
ZSB0aHJlYWRzIGFuZCB3aXRoIGEgbGltaXRlZCBudW1iZXIgb2YKcG9sbCBxdWV1ZXMsIHRo
ZW4gcmluZ0EgbWF5IGZpbmQgY29tcGxldGlvbnMgZnJvbSByaW5nQi4gRm9yIHRoYXQgY2Fz
ZSwKY29tcGxldGluZyB0aGUgcmVxdWVzdCBtYXkgbm90IGJlIHNvdW5kLgoKQWx3YXlzIGp1
c3QgcHVudCB0aGUgcGFzc3Rocm91Z2ggY29tcGxldGlvbnMgdmlhIHRhc2tfd29yaywgd2hp
Y2ggd2lsbApyZWRpcmVjdCB0aGUgY29tcGxldGlvbiwgaWYgbmVlZGVkLgoKQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDU4NTA3OWI2ZTQyNSAoIm52bWU6IHdpcmUgdXAg
YXN5bmMgcG9sbGluZyBmb3IgaW8gcGFzc3Rocm91Z2ggY29tbWFuZHMiKQpTaWduZWQtb2Zm
LWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogZHJpdmVycy9udm1lL2hv
c3QvaW9jdGwuYyB8IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
aG9zdC9pb2N0bC5jIGIvZHJpdmVycy9udm1lL2hvc3QvaW9jdGwuYwppbmRleCBhY2Y3M2E5
MWU4N2UuLmJkYzcwMDI1ZmI1MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvaW9j
dGwuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9pb2N0bC5jCkBAIC00MzgsNyArNDM4LDYg
QEAgc3RhdGljIGVudW0gcnFfZW5kX2lvX3JldCBudm1lX3VyaW5nX2NtZF9lbmRfaW8oc3Ry
dWN0IHJlcXVlc3QgKnJlcSwKIHsKIAlzdHJ1Y3QgaW9fdXJpbmdfY21kICppb3VjbWQgPSBy
ZXEtPmVuZF9pb19kYXRhOwogCXN0cnVjdCBudm1lX3VyaW5nX2NtZF9wZHUgKnBkdSA9IG52
bWVfdXJpbmdfY21kX3BkdShpb3VjbWQpOwotCXZvaWQgKmNvb2tpZSA9IFJFQURfT05DRShp
b3VjbWQtPmNvb2tpZSk7CiAKIAlyZXEtPmJpbyA9IHBkdS0+YmlvOwogCWlmIChudm1lX3Jl
cShyZXEpLT5mbGFncyAmIE5WTUVfUkVRX0NBTkNFTExFRCkgewpAQCAtNDUxLDE0ICs0NTAs
MTQgQEAgc3RhdGljIGVudW0gcnFfZW5kX2lvX3JldCBudm1lX3VyaW5nX2NtZF9lbmRfaW8o
c3RydWN0IHJlcXVlc3QgKnJlcSwKIAlwZHUtPnUucmVzdWx0ID0gbGU2NF90b19jcHUobnZt
ZV9yZXEocmVxKS0+cmVzdWx0LnU2NCk7CiAKIAkvKgotCSAqIEZvciBpb3BvbGwsIGNvbXBs
ZXRlIGl0IGRpcmVjdGx5LgotCSAqIE90aGVyd2lzZSwgbW92ZSB0aGUgY29tcGxldGlvbiB0
byB0YXNrIHdvcmsuCisJICogSU9QT0xMIGNvdWxkIHBvdGVudGlhbGx5IGNvbXBsZXRlIHRo
aXMgcmVxdWVzdCBkaXJlY3RseSwgYnV0CisJICogaWYgbXVsdGlwbGUgcmluZ3MgYXJlIHBv
bGxpbmcgb24gdGhlIHNhbWUgcXVldWUsIHRoZW4gaXQncyBwb3NzaWJsZQorCSAqIGZvciBv
bmUgcmluZyB0byBmaW5kIGNvbXBsZXRpb25zIGZvciBhbm90aGVyIHJpbmcuIFB1bnRpbmcg
dGhlCisJICogY29tcGxldGlvbiB2aWEgdGFza193b3JrIHdpbGwgYWx3YXlzIGRpcmVjdCBp
dCB0byB0aGUgcmlnaHQKKwkgKiBsb2NhdGlvbiwgcmF0aGVyIHRoYW4gcG90ZW50aWFsbHkg
Y29tcGxldGUgcmVxdWVzdHMgZm9yIHJpbmdBCisJICogdW5kZXIgaW9wb2xsIGludm9jYXRp
b25zIGZyb20gcmluZ0IuCiAJICovCi0JaWYgKGNvb2tpZSAhPSBOVUxMICYmIGJsa19ycV9p
c19wb2xsKHJlcSkpCi0JCW52bWVfdXJpbmdfdGFza19jYihpb3VjbWQsIElPX1VSSU5HX0Zf
VU5MT0NLRUQpOwotCWVsc2UKLQkJaW9fdXJpbmdfY21kX2NvbXBsZXRlX2luX3Rhc2soaW91
Y21kLCBudm1lX3VyaW5nX3Rhc2tfY2IpOwotCisJaW9fdXJpbmdfY21kX2NvbXBsZXRlX2lu
X3Rhc2soaW91Y21kLCBudm1lX3VyaW5nX3Rhc2tfY2IpOwogCXJldHVybiBSUV9FTkRfSU9f
RlJFRTsKIH0KIAotLSAKMi41MC4wCgo=

--------------rp5Ny8glHdszJE3oYer34tAA--

