Return-Path: <stable+bounces-180797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11091B8DB3D
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139077A702D
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1AB21FF39;
	Sun, 21 Sep 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NhovsXoa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE212190472
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758458729; cv=none; b=Rz//YNbtf7qJo9XqXHwe2zJpIg4bKEsJWQElHbEuXQfodvmaa8DXqDhQ1k7p/wO3yGTButK8HNhQQhvUgIx1Cu9k17EM5JEDLXDh8fY9G7EN4JHZ3ZjEsIF+eYA6dF9JB3wkMcw2mZ9ai3wxjW/F59OI9rtB5NdtINgtu/rXgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758458729; c=relaxed/simple;
	bh=h2qDGgH6kttpYUaklMd9hS6c10/huAreMl5F/Z20GPU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=VMRvNpA53KKuCkharO8+PqiSNoibGh5Mq+hMG2dHAgRhTzpI4ePOxv4Kl7Pnf4PBn9BbNgSzdjJUoD+VyTzENhGDrb9YznSGcxxV2Mr5nb9aeY0fgqSqntPhWO1nRoQTPCkLZ+WTWHecsCZkPVlBjIqLBDjPf3LOt6+xD8FLJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NhovsXoa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-271067d66fbso10805875ad.3
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758458726; x=1759063526; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGQfzGBitWIZR1eRedgaU1UabtEq7Ufs/twYSYZmWQA=;
        b=NhovsXoa5WXgOGToKqrQx8jsNyaqrUO69QB0H4MeIJcQjUiJAxCjvV/bTDhHhCQd4E
         TstuTG0z7yk+bImw3346+rBn0d/bKIUORucgaPqpMCUuqtSUDIIINoWHv1uXcMVUBBrd
         sxxLSiEKnykr9utnZBE7MIquhOTGHwfKIidqBEwERcj06+gEYQIBpiKOXDqIayIHINcu
         AOj185GCu9LgPtcuKdcS1XTvYYDb0wCeJ6Xl4j67vZ0mem27rtykKPBXDgDFG/bmAZre
         bnzgc6BjjhbBtC6eyQMiNlr909e259cTzwm4YqHdRMGnl1RDaFWmAJV6Ij5EzF1gTD0U
         i8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758458726; x=1759063526;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGQfzGBitWIZR1eRedgaU1UabtEq7Ufs/twYSYZmWQA=;
        b=OQkBiThSMDpPMQhEuhITRkZGnKCo/yZPo8CR40bpQA37QZN7GJDBBETIgB32BOEQT9
         07JYItKrtDVMo3rPeYLYr+Y3tFr34cLHhrdR0HUDjA3JZkd1PcmNTmvmcZ4G6x5kvZJY
         5yVvNi0/60gihfPP6+0Ks1Xcy3dkQ5xxBTlUl/pLXPEB9Hi7B5dq0RI6Q7LpiTUKFS+W
         DOUAiIYwfRpQLpYjzugBCluHWL8busttRSY19OuskS8Mo24hT1QX7hK2jkGEVN/+Sq+Z
         rcacqJ4NSByijo50qDKpOnLkpe2dMVYjPq+wb2en5PHQOaFqXneTyHYaChwGqgLnOzlw
         o7iw==
X-Gm-Message-State: AOJu0YylEhoDZ1j9ApCJOAwymhPEt843819+DnXn9ybIK6TV4pJtAyE0
	yPZL/xfHykV+LsNRbfis9CH/jc4L2O4s4Ej6Dcdwh5GdqItEWk56vLdzpgHGtqhIoqQ=
X-Gm-Gg: ASbGncvK0sZI0BtqAzyhdLT9MxcPS6gssZKefQ6tSjZ7pLCWro5xP9DzBknTR4qhoQX
	DD2luSlaejOUGcNuwkZ2cTthORbIGdKoonmaxilMNEZ9AYgwU5pKuFAbK+z4uwUZmpZk7/wmZ6M
	zQBRoq4eyLE44Ou1znpaelYAWX8vR8TOs+N5AQotndOcozTZtQIZsbGqmk+1jAbCUCe97SgtCnJ
	H1ZcLHboeH22kywJA9Xjt9cuuco/w2PGoDQdueWcz+pUMqiBpuocOgVm/xeNpcO1IWasbt7tavW
	qfnqsDc7Lh+2LPn/t0eWuxqFDElBhzMUgsWqFjTxh80iDpg9w1mKLh5ZYfRqDOIvcCqS+cFGm9f
	r0sQ2pvID4SpnkjxMzS6w
X-Google-Smtp-Source: AGHT+IEP3hYdktllbfPkrVgoKAO0d2js4+AkBg4xLwJB30oU/gE7JvQoa5V3xQJVN9pR3ckFa2TE5Q==
X-Received: by 2002:a17:902:c402:b0:267:8049:7c7f with SMTP id d9443c01a7336-269ba3e9219mr123432465ad.7.1758458725938;
        Sun, 21 Sep 2025 05:45:25 -0700 (PDT)
Received: from [172.17.2.81] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053e77sm105107585ad.7.2025.09.21.05.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 05:45:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------dZNGSxlueQeoYdIrlEc9n6iQ"
Message-ID: <05a536f3-6e28-4cea-b07c-780085973658@kernel.dk>
Date: Sun, 21 Sep 2025 06:45:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: include dying ring in task_work
 "should cancel"" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, thaler@thaler.hu
Cc: stable@vger.kernel.org
References: <2025092127-emit-dean-5272@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025092127-emit-dean-5272@gregkh>

This is a multi-part message in MIME format.
--------------dZNGSxlueQeoYdIrlEc9n6iQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 6:32 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092127-emit-dean-5272@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Ditto on the 6.6-stable side.

-- 
Jens Axboe

--------------dZNGSxlueQeoYdIrlEc9n6iQ
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-include-dying-ring-in-task_work-should-canc.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-include-dying-ring-in-task_work-should-canc.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwNGEwNjcwNWViNDA0ZGZjOTg2MTcxOTkzYzgyZDI4YTQ0YzgxNDAyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTggU2VwIDIwMjUgMTA6MjE6MTQgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gaW9fdXJpbmc6IGluY2x1ZGUgZHlpbmcgcmluZyBpbiB0YXNrX3dvcmsgInNob3VsZCBj
YW5jZWwiCiBzdGF0ZQoKQ29tbWl0IDM1MzliMTQ2N2U5NDMzNmQ1ODU0ZWJmOTc2ZDk2Mjdi
ZmI2NWQ2YzMgdXBzdHJlYW0uCgpXaGVuIHJ1bm5pbmcgdGFza193b3JrIGZvciBhbiBleGl0
aW5nIHRhc2ssIHJhdGhlciB0aGFuIHBlcmZvcm0gdGhlCmlzc3VlIHJldHJ5IGF0dGVtcHQs
IHRoZSB0YXNrX3dvcmsgaXMgY2FuY2VsZWQuIEhvd2V2ZXIsIHRoaXMgaXNuJ3QKZG9uZSBm
b3IgYSByaW5nIHRoYXQgaGFzIGJlZW4gY2xvc2VkLiBUaGlzIGNhbiBsZWFkIHRvIHJlcXVl
c3RzIGJlaW5nCnN1Y2Nlc3NmdWxseSBjb21wbGV0ZWQgcG9zdCB0aGUgcmluZyBiZWluZyBj
bG9zZWQsIHdoaWNoIGlzIHNvbWV3aGF0CmNvbmZ1c2luZyBhbmQgc3VycHJpc2luZyB0byBh
biBhcHBsaWNhdGlvbi4KClJhdGhlciB0aGFuIGp1c3QgY2hlY2sgdGhlIHRhc2sgZXhpdCBz
dGF0ZSwgYWxzbyBpbmNsdWRlIHRoZSByaW5nCnJlZiBzdGF0ZSBpbiBkZWNpZGluZyB3aGV0
aGVyIG9yIG5vdCB0byB0ZXJtaW5hdGUgYSBnaXZlbiByZXF1ZXN0IHdoZW4KcnVuIGZyb20g
dGFza193b3JrLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjErCkxpbms6IGh0
dHBzOi8vZ2l0aHViLmNvbS9heGJvZS9saWJ1cmluZy9kaXNjdXNzaW9ucy8xNDU5ClJlcG9y
dGVkLWJ5OiBCZW5lZGVrIFRoYWxlciA8dGhhbGVyQHRoYWxlci5odT4KU2lnbmVkLW9mZi1i
eTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL2lvX3VyaW5n
LmMgfCA2ICsrKystLQogaW9fdXJpbmcvaW9fdXJpbmcuaCB8IDQgKystLQogaW9fdXJpbmcv
cG9sbC5jICAgICB8IDIgKy0KIGlvX3VyaW5nL3RpbWVvdXQuYyAgfCAyICstCiA0IGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9pb191cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCBkMTg5
ODU0NzY2NTQuLjA3YTU4MjRhZDk4ZCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcu
YworKysgYi9pb191cmluZy9pb191cmluZy5jCkBAIC0xNDU5LDggKzE0NTksMTAgQEAgc3Rh
dGljIHZvaWQgaW9fcmVxX3Rhc2tfY2FuY2VsKHN0cnVjdCBpb19raW9jYiAqcmVxLCBzdHJ1
Y3QgaW9fdHdfc3RhdGUgKnRzKQogCiB2b2lkIGlvX3JlcV90YXNrX3N1Ym1pdChzdHJ1Y3Qg
aW9fa2lvY2IgKnJlcSwgc3RydWN0IGlvX3R3X3N0YXRlICp0cykKIHsKLQlpb190d19sb2Nr
KHJlcS0+Y3R4LCB0cyk7Ci0JaWYgKHVubGlrZWx5KGlvX3Nob3VsZF90ZXJtaW5hdGVfdHco
KSkpCisJc3RydWN0IGlvX3JpbmdfY3R4ICpjdHggPSByZXEtPmN0eDsKKworCWlvX3R3X2xv
Y2soY3R4LCB0cyk7CisJaWYgKHVubGlrZWx5KGlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoY3R4
KSkpCiAJCWlvX3JlcV9kZWZlcl9mYWlsZWQocmVxLCAtRUZBVUxUKTsKIAllbHNlIGlmIChy
ZXEtPmZsYWdzICYgUkVRX0ZfRk9SQ0VfQVNZTkMpCiAJCWlvX3F1ZXVlX2lvd3EocmVxKTsK
ZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmggYi9pb191cmluZy9pb191cmluZy5o
CmluZGV4IDYxMjMxNTlkYTQ0OC4uMGY2YjQ3ZjU1YzI0IDEwMDY0NAotLS0gYS9pb191cmlu
Zy9pb191cmluZy5oCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmgKQEAgLTQwMiw5ICs0MDIs
OSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaW9fYWxsb3dlZF9ydW5fdHcoc3RydWN0IGlvX3Jp
bmdfY3R4ICpjdHgpCiAgKiAyKSBQRl9LVEhSRUFEIGlzIHNldCwgaW4gd2hpY2ggY2FzZSB0
aGUgaW52b2tlciBvZiB0aGUgdGFza193b3JrIGlzCiAgKiAgICBvdXIgZmFsbGJhY2sgdGFz
a193b3JrLgogICovCi1zdGF0aWMgaW5saW5lIGJvb2wgaW9fc2hvdWxkX3Rlcm1pbmF0ZV90
dyh2b2lkKQorc3RhdGljIGlubGluZSBib29sIGlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoc3Ry
dWN0IGlvX3JpbmdfY3R4ICpjdHgpCiB7Ci0JcmV0dXJuIGN1cnJlbnQtPmZsYWdzICYgKFBG
X0tUSFJFQUQgfCBQRl9FWElUSU5HKTsKKwlyZXR1cm4gKGN1cnJlbnQtPmZsYWdzICYgKFBG
X0tUSFJFQUQgfCBQRl9FWElUSU5HKSkgfHwgcGVyY3B1X3JlZl9pc19keWluZygmY3R4LT5y
ZWZzKTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIGlvX3JlcV9xdWV1ZV90d19jb21wbGV0
ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgczMyIHJlcykKZGlmZiAtLWdpdCBhL2lvX3VyaW5n
L3BvbGwuYyBiL2lvX3VyaW5nL3BvbGwuYwppbmRleCAxODg0NzI2ZGFjNDkuLmI2YzhhY2Q4
NjI1ZSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvcG9sbC5jCisrKyBiL2lvX3VyaW5nL3BvbGwu
YwpAQCAtMjU4LDcgKzI1OCw3IEBAIHN0YXRpYyBpbnQgaW9fcG9sbF9jaGVja19ldmVudHMo
c3RydWN0IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBpb190d19zdGF0ZSAqdHMpCiB7CiAJaW50
IHY7CiAKLQlpZiAodW5saWtlbHkoaW9fc2hvdWxkX3Rlcm1pbmF0ZV90dygpKSkKKwlpZiAo
dW5saWtlbHkoaW9fc2hvdWxkX3Rlcm1pbmF0ZV90dyhyZXEtPmN0eCkpKQogCQlyZXR1cm4g
LUVDQU5DRUxFRDsKIAogCWRvIHsKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3RpbWVvdXQuYyBi
L2lvX3VyaW5nL3RpbWVvdXQuYwppbmRleCAwMThjMGNlYWY3MTcuLmJlMmEwZjZjMjA5YiAx
MDA2NDQKLS0tIGEvaW9fdXJpbmcvdGltZW91dC5jCisrKyBiL2lvX3VyaW5nL3RpbWVvdXQu
YwpAQCAtMzA3LDcgKzMwNyw3IEBAIHN0YXRpYyB2b2lkIGlvX3JlcV90YXNrX2xpbmtfdGlt
ZW91dChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc3RydWN0IGlvX3R3X3N0YXRlICp0CiAJaW50
IHJldCA9IC1FTk9FTlQ7CiAKIAlpZiAocHJldikgewotCQlpZiAoIWlvX3Nob3VsZF90ZXJt
aW5hdGVfdHcoKSkgeworCQlpZiAoIWlvX3Nob3VsZF90ZXJtaW5hdGVfdHcocmVxLT5jdHgp
KSB7CiAJCQlzdHJ1Y3QgaW9fY2FuY2VsX2RhdGEgY2QgPSB7CiAJCQkJLmN0eAkJPSByZXEt
PmN0eCwKIAkJCQkuZGF0YQkJPSBwcmV2LT5jcWUudXNlcl9kYXRhLAotLSAKMi41MS4wCgo=

--------------dZNGSxlueQeoYdIrlEc9n6iQ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-backport-io_should_terminate_tw.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-backport-io_should_terminate_tw.patch"
Content-Transfer-Encoding: base64

RnJvbSBhNGY0MzkwY2QzY2UwYTMzOTc1NDY1NWY4MjEwY2ZlMzM0NjVlM2M4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTggU2VwIDIwMjUgMTE6Mjc6MDYgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gaW9fdXJpbmc6IGJhY2twb3J0IGlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoKQoKUGFydHMg
b2YgY29tbWl0IGI2ZjU4YTNmNGFhOGRiYTQyNDM1NmM3YTY5Mzg4YTgxZjQ0NTkzMDAgdXBz
dHJlYW0uCgpCYWNrcG9ydCBpb19zaG91bGRfdGVybWluYXRlX3R3KCkgaGVscGVyIHRvIGp1
ZGdlIHdoZXRoZXIgdGFza193b3JrCnNob3VsZCBiZSBydW4gb3IgdGVybWluYXRlZC4KClNp
Z25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmlu
Zy9pb191cmluZy5jIHwgIDMgKy0tCiBpb191cmluZy9pb191cmluZy5oIHwgMTMgKysrKysr
KysrKysrKwogaW9fdXJpbmcvcG9sbC5jICAgICB8ICAzICstLQogaW9fdXJpbmcvdGltZW91
dC5jICB8ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5n
L2lvX3VyaW5nLmMKaW5kZXggODk3ZjA3MDE0YzAxLi5kMTg5ODU0NzY2NTQgMTAwNjQ0Ci0t
LSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpAQCAt
MTQ2MCw4ICsxNDYwLDcgQEAgc3RhdGljIHZvaWQgaW9fcmVxX3Rhc2tfY2FuY2VsKHN0cnVj
dCBpb19raW9jYiAqcmVxLCBzdHJ1Y3QgaW9fdHdfc3RhdGUgKnRzKQogdm9pZCBpb19yZXFf
dGFza19zdWJtaXQoc3RydWN0IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBpb190d19zdGF0ZSAq
dHMpCiB7CiAJaW9fdHdfbG9jayhyZXEtPmN0eCwgdHMpOwotCS8qIHJlcS0+dGFzayA9PSBj
dXJyZW50IGhlcmUsIGNoZWNraW5nIFBGX0VYSVRJTkcgaXMgc2FmZSAqLwotCWlmICh1bmxp
a2VseShyZXEtPnRhc2stPmZsYWdzICYgUEZfRVhJVElORykpCisJaWYgKHVubGlrZWx5KGlv
X3Nob3VsZF90ZXJtaW5hdGVfdHcoKSkpCiAJCWlvX3JlcV9kZWZlcl9mYWlsZWQocmVxLCAt
RUZBVUxUKTsKIAllbHNlIGlmIChyZXEtPmZsYWdzICYgUkVRX0ZfRk9SQ0VfQVNZTkMpCiAJ
CWlvX3F1ZXVlX2lvd3EocmVxKTsKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmgg
Yi9pb191cmluZy9pb191cmluZy5oCmluZGV4IDU5ZjVmNzEwMzdmZi4uNjEyMzE1OWRhNDQ4
IDEwMDY0NAotLS0gYS9pb191cmluZy9pb191cmluZy5oCisrKyBiL2lvX3VyaW5nL2lvX3Vy
aW5nLmgKQEAgLTM5NCw2ICszOTQsMTkgQEAgc3RhdGljIGlubGluZSBib29sIGlvX2FsbG93
ZWRfcnVuX3R3KHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4KQogCQkgICAgICBjdHgtPnN1Ym1p
dHRlcl90YXNrID09IGN1cnJlbnQpOwogfQogCisvKgorICogVGVybWluYXRlIHRoZSByZXF1
ZXN0IGlmIGVpdGhlciBvZiB0aGVzZSBjb25kaXRpb25zIGFyZSB0cnVlOgorICoKKyAqIDEp
IEl0J3MgYmVpbmcgZXhlY3V0ZWQgYnkgdGhlIG9yaWdpbmFsIHRhc2ssIGJ1dCB0aGF0IHRh
c2sgaXMgbWFya2VkCisgKiAgICB3aXRoIFBGX0VYSVRJTkcgYXMgaXQncyBleGl0aW5nLgor
ICogMikgUEZfS1RIUkVBRCBpcyBzZXQsIGluIHdoaWNoIGNhc2UgdGhlIGludm9rZXIgb2Yg
dGhlIHRhc2tfd29yayBpcworICogICAgb3VyIGZhbGxiYWNrIHRhc2tfd29yay4KKyAqLwor
c3RhdGljIGlubGluZSBib29sIGlvX3Nob3VsZF90ZXJtaW5hdGVfdHcodm9pZCkKK3sKKwly
ZXR1cm4gY3VycmVudC0+ZmxhZ3MgJiAoUEZfS1RIUkVBRCB8IFBGX0VYSVRJTkcpOworfQor
CiBzdGF0aWMgaW5saW5lIHZvaWQgaW9fcmVxX3F1ZXVlX3R3X2NvbXBsZXRlKHN0cnVjdCBp
b19raW9jYiAqcmVxLCBzMzIgcmVzKQogewogCWlvX3JlcV9zZXRfcmVzKHJlcSwgcmVzLCAw
KTsKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3BvbGwuYyBiL2lvX3VyaW5nL3BvbGwuYwppbmRl
eCA2NTkzNWVjOGRlODkuLjE4ODQ3MjZkYWM0OSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvcG9s
bC5jCisrKyBiL2lvX3VyaW5nL3BvbGwuYwpAQCAtMjU4LDggKzI1OCw3IEBAIHN0YXRpYyBp
bnQgaW9fcG9sbF9jaGVja19ldmVudHMoc3RydWN0IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBp
b190d19zdGF0ZSAqdHMpCiB7CiAJaW50IHY7CiAKLQkvKiByZXEtPnRhc2sgPT0gY3VycmVu
dCBoZXJlLCBjaGVja2luZyBQRl9FWElUSU5HIGlzIHNhZmUgKi8KLQlpZiAodW5saWtlbHko
cmVxLT50YXNrLT5mbGFncyAmIFBGX0VYSVRJTkcpKQorCWlmICh1bmxpa2VseShpb19zaG91
bGRfdGVybWluYXRlX3R3KCkpKQogCQlyZXR1cm4gLUVDQU5DRUxFRDsKIAogCWRvIHsKZGlm
ZiAtLWdpdCBhL2lvX3VyaW5nL3RpbWVvdXQuYyBiL2lvX3VyaW5nL3RpbWVvdXQuYwppbmRl
eCAyNzdlMjJkNTVjNjEuLjAxOGMwY2VhZjcxNyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvdGlt
ZW91dC5jCisrKyBiL2lvX3VyaW5nL3RpbWVvdXQuYwpAQCAtMzA3LDcgKzMwNyw3IEBAIHN0
YXRpYyB2b2lkIGlvX3JlcV90YXNrX2xpbmtfdGltZW91dChzdHJ1Y3QgaW9fa2lvY2IgKnJl
cSwgc3RydWN0IGlvX3R3X3N0YXRlICp0CiAJaW50IHJldCA9IC1FTk9FTlQ7CiAKIAlpZiAo
cHJldikgewotCQlpZiAoIShyZXEtPnRhc2stPmZsYWdzICYgUEZfRVhJVElORykpIHsKKwkJ
aWYgKCFpb19zaG91bGRfdGVybWluYXRlX3R3KCkpIHsKIAkJCXN0cnVjdCBpb19jYW5jZWxf
ZGF0YSBjZCA9IHsKIAkJCQkuY3R4CQk9IHJlcS0+Y3R4LAogCQkJCS5kYXRhCQk9IHByZXYt
PmNxZS51c2VyX2RhdGEsCi0tIAoyLjUxLjAKCg==

--------------dZNGSxlueQeoYdIrlEc9n6iQ--

