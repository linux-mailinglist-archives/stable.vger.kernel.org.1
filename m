Return-Path: <stable+bounces-62597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED9C93FCFF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 20:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046912807BC
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439DE15FA66;
	Mon, 29 Jul 2024 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gMtbzLzj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9878181B82
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276127; cv=none; b=TJcVNnKD7xEZi7vZa8ZivNE7TKPCvvB6hcBLiPzgqOrzpOcdkYcJJB2pgOVb/0geO00IbN5tXb8+f56oWAC4js+XAwJNLLwMVbxTRoIt3HI9241reRDpX3zBHgxE9B7Y4tjEqKfUuXusU336WepkgogouLSoT4+v1KFZLbe5LM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276127; c=relaxed/simple;
	bh=5srXJaWXMXl6XXocxvySb+lBAcGlPFX1mu0UfMhRD2I=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=nhi6zU8NucJL0Giky9id7xxFompfa1yQDCMgEWbYoyapJGIpZxoc66CyZMBfiGSvrjm618D1vn9DOHcdduLfSOlDSjRp1FBbWI+cHi+H6HC5FSVL1goooxxiB5zo7CUlLcytj5MNtnjNKbDM8rKl7J+OpYQsY106o1a1OaKcf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gMtbzLzj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d39a836ccso123890b3a.0
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722276123; x=1722880923; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAAMCMxwxMpwu2ZUXTtH+QT/amqNWxVv5+OwVO1qZR0=;
        b=gMtbzLzjX0VwnBWvDPSvkAPsl/Ypbn6pRgd/ZD5o5pKKGXyY/J+wI8W9x+R2UCWv/M
         k19i9hpi7vvJry9PJJZzlAEPHsuTQdrqj1NGVE3Sh2V66UYSsxAo95pEJ0gwx3B7r5Da
         DvT0iOWtSVVLtF0a1DY05H35+SvxdSyDZonHZVrWH753A5JAYa9ZLT9l7IoZQeRFYpRt
         Cn98b+dI/NgBiiCp1zCK/eW0Q45/P8HtD+lrQaiZp5OjvC/tX17QgU6XYNZaWeCGMfdJ
         L7Sb0z5rMjhQzj/i0M+TJxjP48i6dow9ysyiSnvt9fdvG1Xk+qWXd1vfkRb+sPeg88xo
         ltNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722276123; x=1722880923;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tAAMCMxwxMpwu2ZUXTtH+QT/amqNWxVv5+OwVO1qZR0=;
        b=KCKYOrzcMbpAaRZUagqBIcV6pwV6x4hLcZBXqJLkGbPuB2h2gfgzFrbeFOSJyeIa7o
         yBKC1IW1MZmYU8zxoP0d76LnQ8GGkAgFhxXtkUv0Ax5Lv5S0R1QtzxkyAHl6aXkdEWt0
         A/FTTrEUgsYdQ7aIa4migSQ1Pp/E3RM9MHsvDJm+94G7w8HwZ0MaoxhfEcGs/3mWPf76
         GydtCqIdQkmFND/SwgsgVM3S4hnnoq3E0ja7ocBQ7PC+TMgJRTNk9QlmESZRwUGcPK/J
         KflLJwd5mYt9p4Ec97A7ayICsiQYVKCbtPjjwzuWqMWyovaonQqIB0MbtQVYFtDYTVz6
         i56w==
X-Gm-Message-State: AOJu0YzBz3ehRsQmhcgILbq3cd7JI9AN+kso5/C+q4/MYuE5T7y88RFg
	tXX3Lw+SCWVc1EEex6p9ph2TUe1UBhv1JAdNBpe4U6k/xJBhoUi4hltDdxjd2VM=
X-Google-Smtp-Source: AGHT+IExmOMEC8ahQ2ReyiLzd6DLJNHe/KuHD7lCv5rI3yVbodpRV27n0ai1owegkMBAIAWa15mhLg==
X-Received: by 2002:a05:6a21:3985:b0:1c2:8a9b:b18 with SMTP id adf61e73a8af0-1c4773db241mr10279105637.5.1722276122997;
        Mon, 29 Jul 2024 11:02:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f884c166sm7519808a12.49.2024.07.29.11.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 11:02:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------nZUqvkTM0r5EYuqT5ZKEmUv0"
Message-ID: <30041ada-0d2d-41ff-939d-038eb900c649@kernel.dk>
Date: Mon, 29 Jul 2024 12:02:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] kernel: rerun task_work while freezing in
 get_signal()" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, ju.orth@gmail.com,
 oleg@redhat.com, tj@kernel.org
Cc: stable@vger.kernel.org
References: <2024072940-parish-shirt-3e49@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024072940-parish-shirt-3e49@gregkh>

This is a multi-part message in MIME format.
--------------nZUqvkTM0r5EYuqT5ZKEmUv0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/24 1:49 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 943ad0b62e3c21f324c4884caa6cb4a871bca05c
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072940-parish-shirt-3e49@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's the 5.10-stable and 5.15-stable variant of this. For some
reason this wasn't queued for 5.10 (probably because of the long
ago 5.15-stable backport of io_uring to 5.10), but it should go
there too.

-- 
Jens Axboe


--------------nZUqvkTM0r5EYuqT5ZKEmUv0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-kernel-rerun-task_work-while-freezing-in-get_signal.patch"
Content-Disposition: attachment;
 filename*0="0001-kernel-rerun-task_work-while-freezing-in-get_signal.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSBmNDE2ZTRhMTg1ZGMzZDAwN2VhNDc4ZGIzZmY3NWY0N2NkNjg5ZWI2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogV2VkLCAxMCBKdWwgMjAyNCAxODo1ODoxOCArMDEwMApTdWJqZWN0
OiBbUEFUQ0ggMS8yXSBrZXJuZWw6IHJlcnVuIHRhc2tfd29yayB3aGlsZSBmcmVlemluZyBp
biBnZXRfc2lnbmFsKCkKCmNvbW1pdCA5NDNhZDBiNjJlM2MyMWYzMjRjNDg4NGNhYTZjYjRh
ODcxYmNhMDVjIHVwc3RyZWFtLgoKaW9fdXJpbmcgY2FuIGFzeW5jaHJvbm91c2x5IGFkZCBh
IHRhc2tfd29yayB3aGlsZSB0aGUgdGFzayBpcyBnZXR0aW5nCmZyZWV6ZWQuIFRJRl9OT1RJ
RllfU0lHTkFMIHdpbGwgcHJldmVudCB0aGUgdGFzayBmcm9tIHNsZWVwaW5nIGluCmRvX2Zy
ZWV6ZXJfdHJhcCgpLCBhbmQgc2luY2UgdGhlIGdldF9zaWduYWwoKSdzIHJlbG9jayBsb29w
IGRvZXNuJ3QKcmV0cnkgdGFza193b3JrLCB0aGUgdGFzayB3aWxsIHNwaW4gdGhlcmUgbm90
IGJlaW5nIGFibGUgdG8gc2xlZXAKdW50aWwgdGhlIGZyZWV6aW5nIGlzIGNhbmNlbGxlZCAv
IHRoZSB0YXNrIGlzIGtpbGxlZCAvIGV0Yy4KClJ1biB0YXNrX3dvcmtzIGluIHRoZSBmcmVl
emVyIHBhdGguIEtlZXAgdGhlIHBhdGNoIHNtYWxsIGFuZCBzaW1wbGUKc28gaXQgY2FuIGJl
IGVhc2lseSBiYWNrIHBvcnRlZCwgYnV0IHdlIG1pZ2h0IG5lZWQgdG8gZG8gc29tZSBjbGVh
bmluZwphZnRlciBhbmQgbG9vayBpZiB0aGVyZSBhcmUgb3RoZXIgcGxhY2VzIHdpdGggc2lt
aWxhciBwcm9ibGVtcy4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkxpbms6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9zeXN0ZW1kL3N5c3RlbWQvaXNzdWVzLzMzNjI2CkZpeGVzOiAxMmRi
OGI2OTAwMTBjICgiZW50cnk6IEFkZCBzdXBwb3J0IGZvciBUSUZfTk9USUZZX1NJR05BTCIp
ClJlcG9ydGVkLWJ5OiBKdWxpYW4gT3J0aCA8anUub3J0aEBnbWFpbC5jb20+CkFja2VkLWJ5
OiBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhhdC5jb20+CkFja2VkLWJ5OiBUZWp1biBIZW8g
PHRqQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IFBhdmVsIEJlZ3Vua292IDxhc21sLnNp
bGVuY2VAZ21haWwuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzg5ZWQz
YTUyOTMzMzcwZGVhYWY2MWEwYTYyMGE2YWM5MWYxZTc1NGQuMTcyMDYzNDE0Ni5naXQuYXNt
bC5zaWxlbmNlQGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+Ci0tLQogaW5jbHVkZS9saW51eC9zY2hlZC9zaWduYWwuaCB8IDYgKysrKysr
CiBrZXJuZWwvc2lnbmFsLmMgICAgICAgICAgICAgIHwgOCArKysrKysrKwogMiBmaWxlcyBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9z
Y2hlZC9zaWduYWwuaCBiL2luY2x1ZGUvbGludXgvc2NoZWQvc2lnbmFsLmgKaW5kZXggOTc0
M2Y3ZDE3M2EwLi4xM2M5NTc4MmMwNjMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2No
ZWQvc2lnbmFsLmgKKysrIGIvaW5jbHVkZS9saW51eC9zY2hlZC9zaWduYWwuaApAQCAtMzQ3
LDYgKzM0NywxMiBAQCBleHRlcm4gdm9pZCBzaWdxdWV1ZV9mcmVlKHN0cnVjdCBzaWdxdWV1
ZSAqKTsKIGV4dGVybiBpbnQgc2VuZF9zaWdxdWV1ZShzdHJ1Y3Qgc2lncXVldWUgKiwgc3Ry
dWN0IHBpZCAqLCBlbnVtIHBpZF90eXBlKTsKIGV4dGVybiBpbnQgZG9fc2lnYWN0aW9uKGlu
dCwgc3RydWN0IGtfc2lnYWN0aW9uICosIHN0cnVjdCBrX3NpZ2FjdGlvbiAqKTsKIAorc3Rh
dGljIGlubGluZSB2b2lkIGNsZWFyX25vdGlmeV9zaWduYWwodm9pZCkKK3sKKwljbGVhcl90
aHJlYWRfZmxhZyhUSUZfTk9USUZZX1NJR05BTCk7CisJc21wX21iX19hZnRlcl9hdG9taWMo
KTsKK30KKwogc3RhdGljIGlubGluZSBpbnQgcmVzdGFydF9zeXNjYWxsKHZvaWQpCiB7CiAJ
c2V0X3Rza190aHJlYWRfZmxhZyhjdXJyZW50LCBUSUZfU0lHUEVORElORyk7CmRpZmYgLS1n
aXQgYS9rZXJuZWwvc2lnbmFsLmMgYi9rZXJuZWwvc2lnbmFsLmMKaW5kZXggYzdkYmIxOTIx
OWI5Li4wOGJjY2RiYjFiNDYgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9zaWduYWwuYworKysgYi9r
ZXJuZWwvc2lnbmFsLmMKQEAgLTI1NzksNiArMjU3OSwxNCBAQCBzdGF0aWMgdm9pZCBkb19m
cmVlemVyX3RyYXAodm9pZCkKIAlzcGluX3VubG9ja19pcnEoJmN1cnJlbnQtPnNpZ2hhbmQt
PnNpZ2xvY2spOwogCWNncm91cF9lbnRlcl9mcm96ZW4oKTsKIAlmcmVlemFibGVfc2NoZWR1
bGUoKTsKKworCS8qCisJICogV2UgY291bGQndmUgYmVlbiB3b2tlbiBieSB0YXNrX3dvcmss
IHJ1biBpdCB0byBjbGVhcgorCSAqIFRJRl9OT1RJRllfU0lHTkFMLiBUaGUgY2FsbGVyIHdp
bGwgcmV0cnkgaWYgbmVjZXNzYXJ5LgorCSAqLworCWNsZWFyX25vdGlmeV9zaWduYWwoKTsK
KwlpZiAodW5saWtlbHkoUkVBRF9PTkNFKGN1cnJlbnQtPnRhc2tfd29ya3MpKSkKKwkJdGFz
a193b3JrX3J1bigpOwogfQogCiBzdGF0aWMgaW50IHB0cmFjZV9zaWduYWwoaW50IHNpZ25y
LCBrZXJuZWxfc2lnaW5mb190ICppbmZvKQotLSAKMi40My4wCgo=

--------------nZUqvkTM0r5EYuqT5ZKEmUv0--

