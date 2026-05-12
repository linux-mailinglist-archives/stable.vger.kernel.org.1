Return-Path: <stable+bounces-245616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPGYJPMwA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:53:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2701F521BBC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEAA303A245
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C3F39AD3B;
	Tue, 12 May 2026 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="e5Z8H8Wc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258A39A4AD
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593698; cv=none; b=co3j+BKkrcD9JlmRLB+p57euOnjtcgaO26x5dlWRCBgWWAuqhtug9ZsvDNXq9WFBUcZfPNQPyddeuJOctBOpKtRLQVCjZX0RKumYCNugLQKJJqqL0Uvg9OfcqX/9duBE4u23q+8z7OR4lQGiRF9hTsZTsY/c5dfvMEu5ML7ccpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593698; c=relaxed/simple;
	bh=ePVYCu5zXFlUjEAxvXRr03q2p8fe+ecA2llYJMy+VLs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=FRXwGLLsAajhnIwL8QCrAzi8EhOvBS7k0nnoagv87gVW3bLtg1pR1ACOYz+OakiRYjdAXZ1FYAQfWVY5E/hWEulqpbcgadSlPi25kcPTd1xJ5wtKYAQTw1+7Qj4PDulpaLpTo3VKXcKP49LbF/ys8okWDKXenit496JYvpD4lxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=e5Z8H8Wc; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dccda31d3eso1462679a34.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778593694; x=1779198494; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKK78/B8+Scdmqb6P+QoG8u8NUDvWpM6BZ0YGPpnPVs=;
        b=e5Z8H8WcP4xT0dR7LRlhqbO3IGHqfnlfplgKxFgKxqj7FjEK0/JIzuDg3pURANv1qW
         eOzmPKAKhykCTjrEtJQYV4bSUzyTG+/CEkgmTZ2dq6ZzBkdhggeUv1S3KNUTz9J4ycs9
         HbnMMIhIEyJcJCvdPJ+v5kmcOfCMVNTeMIiMdatONpeBaK8p5iwzQW3Tn19AwF1hR3cs
         KEffe7CNmc/bDfEv6l6305dKJPUI8G+YkfK1xE0B7I6ek9L6qryj4AQrcbqUSK91cGZ1
         A6cRoCz5Y5UahkVIxXkXm6KqiQUXoWNUfn+gJVJsxiky3h0Wr0KRY4dEkyFs/+MpyJrB
         SJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778593694; x=1779198494;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VKK78/B8+Scdmqb6P+QoG8u8NUDvWpM6BZ0YGPpnPVs=;
        b=CGlb0FqhxEQ6oySfwrQVSuI0SjZkMEt58Wjg/2iTP/AS0h+Hz6o1mzyXtEB4MS21r8
         grPKjpyFEW9utzsM0+9Q+/PlwK212QPdSS59dieVKCPt2lrcwDviDWPpPcW6Xb2mXH1o
         YRp0P2fGTt6OAQGoV9EE4K4k2dSrJtcZQg4Td7KDisGr8IrXKqovGbWD89uVwmFp7tgb
         0HyJs6cU7bJkQUnfFj0YVUddy6/39Z94rPf1O8ZASmiITUHuCIqD8nHSRCira2M3wfUe
         dpYiO8waS1fxL+r6W8kgI9NIErxaVQKH8eEieW5NvCxvzdx+fTvHeJV3cVqFGOk/1Yo6
         XJxw==
X-Gm-Message-State: AOJu0YxTvxIgiyxqhdZn5RAlqHO5BShpdMbMCg/CGPB+nKqmtqb4Ye4C
	EUmqa4gvsQNdflM/Xp8kf7N9GAi6VScyZkWiITzSQVXMoLj3ecCqzUsU9HoqqSm/1TUAlEEKknu
	m6fiO
X-Gm-Gg: Acq92OGPUmppgYlnl6AY7kjC/dkrrJ/K0W8xdUYfqdDnxzN5ljhogkyf153EeESyFz1
	JWVlm1IcUYn7iVaXwXSuIp+yu8AO8JKi+f+Z0WJ+izeEaaT3IjVloMWMQqbrqMhbc2MT8+Nr1SW
	DDxsBP0sY4X5bEhubZY9hqG9YaHzAlFDpaz0Ah98m3uIAM9XS3OkVIv7nUcMUnVuJTVB2eKjsnp
	mzu64/GDn5GpsnpO79DrowqSIm1tIrabIcRMp7rDUXuPqeX+09RxCtwLsMXowR6hh0PzIBWKxgy
	WvfknOKh05yVLPkrbbS/xTb6xXwqhon1adffNhx6ryieWdnPdxi0ENe9sTKSKz4204kO3YzxW4h
	Mw5nfbT+4c+lYQWuMiyPh9ZL/BgppuAGOmMuBt3jIRZKQYOtilHYFy3/Rm0FqgnjGnqEg1Ob5dK
	OT93QFb0mnDREMYQXF/tMRXFvYLIwhHqSiXtQLePnl4ptSSd+mRCfeUo9+idmX7y0b7Sga25Klg
	fK7SAARYaglEjoXDcM=
X-Received: by 2002:a05:6830:f93:b0:7d7:d2e4:6373 with SMTP id 46e09a7af769-7e382178524mr8479818a34.20.1778593693951;
        Tue, 12 May 2026 06:48:13 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d8feb1sm8631557a34.23.2026.05.12.06.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 06:48:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0jDdE4SMK4D45gtun2N9e0QN"
Message-ID: <58a8f15e-7a5e-4b8f-9f2d-6493b685e598@kernel.dk>
Date: Tue, 12 May 2026 07:48:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: support min length left for
 incremental" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org, code@mgjm.de, krisman@suse.de
Cc: stable@vger.kernel.org
References: <2026051232-kindred-spooky-37ac@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026051232-kindred-spooky-37ac@gregkh>
X-Rspamd-Queue-Id: 2701F521BBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-245616-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:email,suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:email,kernel.dk:mid,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------0jDdE4SMK4D45gtun2N9e0QN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 6:41 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
> git checkout FETCH_HEAD
> git cherry-pick -x 7deba791ad495ce1d7921683f4f7d1190fa210d1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051232-kindred-spooky-37ac@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Here's one for 6.18-stable.

-- 
Jens Axboe

--------------0jDdE4SMK4D45gtun2N9e0QN
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-kbuf-support-min-length-left-for-incrementa.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-kbuf-support-min-length-left-for-incrementa.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhZTE2NWZlZDcyZjk2ODZhZWIwNDc2NmExNTQ1OTgwNzExNGE1MDIzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gTWljaGFlbGlzIDxjb2RlQG1nam0uZGU+
CkRhdGU6IFRodSwgMjMgQXByIDIwMjYgMTU6NTQ6MTEgLTA2MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gaW9fdXJpbmcva2J1Zjogc3VwcG9ydCBtaW4gbGVuZ3RoIGxlZnQgZm9yIGluY3Jl
bWVudGFsCiBidWZmZXJzCgpDb21taXQgN2RlYmE3OTFhZDQ5NWNlMWQ3OTIxNjgzZjRmN2Qx
MTkwZmEyMTBkMSB1cHN0cmVhbS4KCkluY3JlbWVudGFsbHkgY29uc3VtZWQgYnVmZmVyIHJp
bmdzIGFyZSBnZW5lcmFsbHkgZnVsbHkgY29uc3VtZWQsIGJ1dAppdCdzIHF1aXRlIHBvc3Np
YmxlIHRoYXQgdGhlIGFwcGxpY2F0aW9uIGhhcyBhIG1pbmltdW0gc2l6ZSBpdCBuZWVkcyB0
bwptZWV0IHRvIGF2b2lkIHRydW5jYXRpb24uIEN1cnJlbnRseSB0aGF0IG1pbmltdW0gbGlt
aXQgaXMgMSBieXRlLCBidXQKdGhpcyBzaG91bGQgYmUgYSBzZXR0aW5nIHRoYXQgaXMgdGhl
IGhhbmRzIG9mIHRoZSBhcHBsaWNhdGlvbi4gRm9yCnJlY3Ztc2cgbXVsdGlzaG90LCBhIHBy
aW1lIHVzZSBjYXNlIGZvciBpbmNyZW1lbnRhbGx5IGNvbnN1bWVkIGJ1ZmZlcnMsCnRoZSBh
cHBsaWNhdGlvbiBtYXkgZ2V0IHNwdXJpb3VzIC1FRkFVTFQgcmV0dXJuZWQgYXQgdGhlIGVu
ZCBvZiBhbgppbmNyZW1lbnRhbGx5IGNvbnN1bWVkIGJ1ZmZlciwgYXMgbGVzcyBzcGFjZSBp
cyBhdmFpbGFibGUgdGhhbiB0aGUKaGVhZGVycyBuZWVkLgoKR3JhYiBhIHUzMiBmaWVsZCBp
biBzdHJ1Y3QgaW9fdXJpbmdfYnVmX3JlZywgd2hpY2ggdGhlIGFwcGxpY2F0aW9uIGNhbgp1
c2UgdG8gaW5mb3JtIHRoZSBrZXJuZWwgb2YgdGhlIG1pbmltdW0gc2l6ZSB0aGF0IHNob3Vs
ZCBiZSBhdmFpbGFibGUKaW4gYW4gaW5jcmVtZW50YWxseSBjb25zdW1lZCBidWZmZXIuIElm
IGxlc3MgdGhhbiB0aGF0IGlzIGF2YWlsYWJsZSwKdGhlIGN1cnJlbnQgYnVmZmVyIGlzIGZ1
bGx5IHByb2Nlc3NlZCBhbmQgdGhlIG5leHQgb25lIHdpbGwgYmUgcGlja2VkLgoKQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IGFlOThkYmY0M2Q3NSAoImlvX3VyaW5nL2ti
dWY6IGFkZCBzdXBwb3J0IGZvciBpbmNyZW1lbnRhbCBidWZmZXIgY29uc3VtcHRpb24iKQpM
aW5rOiBodHRwczovL2dpdGh1Yi5jb20vYXhib2UvbGlidXJpbmcvaXNzdWVzLzE0MzMKU2ln
bmVkLW9mZi1ieTogTWFydGluIE1pY2hhZWxpcyA8Y29kZUBtZ2ptLmRlPgpbYXhib2U6IHdy
aXRlIGNvbW1pdCBtZXNzYWdlLCBjaGFuZ2UgaW9fYnVmZmVyX2xpc3QgbWVtYmVyIG5hbWVd
ClJldmlld2VkLWJ5OiBHYWJyaWVsIEtyaXNtYW4gQmVydGF6aSA8a3Jpc21hbkBzdXNlLmRl
PgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW5j
bHVkZS91YXBpL2xpbnV4L2lvX3VyaW5nLmggfCAgMyArKy0KIGlvX3VyaW5nL2tidWYuYyAg
ICAgICAgICAgICAgIHwgMTIgKysrKysrKysrLS0tCiBpb191cmluZy9rYnVmLmggICAgICAg
ICAgICAgICB8ICA3ICsrKysrKysKIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvaW9f
dXJpbmcuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9pb191cmluZy5oCmluZGV4IGI3YzhkYWQy
NjY5MC4uZWY1YjczNGI1YTQxIDEwMDY0NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvaW9f
dXJpbmcuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvaW9fdXJpbmcuaApAQCAtODY0LDcg
Kzg2NCw4IEBAIHN0cnVjdCBpb191cmluZ19idWZfcmVnIHsKIAlfX3UzMglyaW5nX2VudHJp
ZXM7CiAJX191MTYJYmdpZDsKIAlfX3UxNglmbGFnczsKLQlfX3U2NAlyZXN2WzNdOworCV9f
dTMyCW1pbl9sZWZ0OworCV9fdTMyCXJlc3ZbNV07CiB9OwogCiAvKiBhcmd1bWVudCBmb3Ig
SU9SSU5HX1JFR0lTVEVSX1BCVUZfU1RBVFVTICovCmRpZmYgLS1naXQgYS9pb191cmluZy9r
YnVmLmMgYi9pb191cmluZy9rYnVmLmMKaW5kZXggOWU4MTY2ZTI0ZGM4Li4zMmQzYjhkMjZi
ZjAgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2tidWYuYworKysgYi9pb191cmluZy9rYnVmLmMK
QEAgLTQ3LDkgKzQ3LDkgQEAgc3RhdGljIGJvb2wgaW9fa2J1Zl9pbmNfY29tbWl0KHN0cnVj
dCBpb19idWZmZXJfbGlzdCAqYmwsIGludCBsZW4pCiAJCXRoaXNfbGVuID0gbWluX3QodTMy
LCBsZW4sIGJ1Zl9sZW4pOwogCQlidWZfbGVuIC09IHRoaXNfbGVuOwogCQkvKiBTdG9wIGxv
b3BpbmcgZm9yIGludmFsaWQgYnVmZmVyIGxlbmd0aCBvZiAwICovCi0JCWlmIChidWZfbGVu
IHx8ICF0aGlzX2xlbikgewotCQkJYnVmLT5hZGRyID0gUkVBRF9PTkNFKGJ1Zi0+YWRkcikg
KyB0aGlzX2xlbjsKLQkJCWJ1Zi0+bGVuID0gYnVmX2xlbjsKKwkJaWYgKGJ1Zl9sZW4gPiBi
bC0+bWluX2xlZnRfc3ViX29uZSB8fCAhdGhpc19sZW4pIHsKKwkJCVdSSVRFX09OQ0UoYnVm
LT5hZGRyLCBSRUFEX09OQ0UoYnVmLT5hZGRyKSArIHRoaXNfbGVuKTsKKwkJCVdSSVRFX09O
Q0UoYnVmLT5sZW4sIGJ1Zl9sZW4pOwogCQkJcmV0dXJuIGZhbHNlOwogCQl9CiAJCWJ1Zi0+
bGVuID0gMDsKQEAgLTYzNyw2ICs2MzcsMTAgQEAgaW50IGlvX3JlZ2lzdGVyX3BidWZfcmlu
ZyhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgdm9pZCBfX3VzZXIgKmFyZykKIAlpZiAocmVn
LnJpbmdfZW50cmllcyA+PSA2NTUzNikKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwkvKiBtaW5p
bXVtIGxlZnQgYnl0ZSBjb3VudCBpcyBhIHByb3BlcnR5IG9mIGluY3JlbWVudGFsIGJ1ZmZl
cnMgKi8KKwlpZiAoIShyZWcuZmxhZ3MgJiBJT1VfUEJVRl9SSU5HX0lOQykgJiYgcmVnLm1p
bl9sZWZ0KQorCQlyZXR1cm4gLUVJTlZBTDsKKwogCWJsID0gaW9fYnVmZmVyX2dldF9saXN0
KGN0eCwgcmVnLmJnaWQpOwogCWlmIChibCkgewogCQkvKiBpZiBtYXBwZWQgYnVmZmVyIHJp
bmcgT1IgY2xhc3NpYyBleGlzdHMsIGRvbid0IGFsbG93ICovCkBAIC02ODQsNiArNjg4LDgg
QEAgaW50IGlvX3JlZ2lzdGVyX3BidWZfcmluZyhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwg
dm9pZCBfX3VzZXIgKmFyZykKIAlibC0+bWFzayA9IHJlZy5yaW5nX2VudHJpZXMgLSAxOwog
CWJsLT5mbGFncyB8PSBJT0JMX0JVRl9SSU5HOwogCWJsLT5idWZfcmluZyA9IGJyOworCWlm
IChyZWcubWluX2xlZnQpCisJCWJsLT5taW5fbGVmdF9zdWJfb25lID0gcmVnLm1pbl9sZWZ0
IC0gMTsKIAlpZiAocmVnLmZsYWdzICYgSU9VX1BCVUZfUklOR19JTkMpCiAJCWJsLT5mbGFn
cyB8PSBJT0JMX0lOQzsKIAlyZXQgPSBpb19idWZmZXJfYWRkX2xpc3QoY3R4LCBibCwgcmVn
LmJnaWQpOwpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcva2J1Zi5oIGIvaW9fdXJpbmcva2J1Zi5o
CmluZGV4IGFkYTM4MmZmMzhkNy4uZDFkMDBlMDQwZGZlIDEwMDY0NAotLS0gYS9pb191cmlu
Zy9rYnVmLmgKKysrIGIvaW9fdXJpbmcva2J1Zi5oCkBAIC0zNCw2ICszNCwxMyBAQCBzdHJ1
Y3QgaW9fYnVmZmVyX2xpc3QgewogCiAJX191MTYgZmxhZ3M7CiAKKwkvKgorCSAqIG1pbmlt
dW0gcmVxdWlyZWQgYW1vdW50IHRvIGJlIGxlZnQgdG8gcmV1c2UgYW4gaW5jcmVtZW50YWxs
eQorCSAqIGNvbnN1bWVkIGJ1ZmZlci4gSWYgbGVzcyB0aGFuIHRoaXMgaXMgbGVmdCBhdCBj
b25zdW1wdGlvbiB0aW1lLAorCSAqIGJ1ZmZlciBpcyBkb25lIGFuZCBoZWFkIGlzIGluY3Jl
bWVudGVkIHRvIHRoZSBuZXh0IGJ1ZmZlci4KKwkgKi8KKwlfX3UzMiBtaW5fbGVmdF9zdWJf
b25lOworCiAJc3RydWN0IGlvX21hcHBlZF9yZWdpb24gcmVnaW9uOwogfTsKIAotLSAKMi41
My4wCgo=

--------------0jDdE4SMK4D45gtun2N9e0QN--

