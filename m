Return-Path: <stable+bounces-227603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mnivN8iSvWnO/AIAu9opvQ
	(envelope-from <stable+bounces-227603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 19:32:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6192DF77A
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 19:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A96F73036E9E
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C163E7151;
	Fri, 20 Mar 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F8nSl8Kd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28F29346F
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031344; cv=none; b=t3MYJuiEfOxXHl2IGYMY3zZgOSGigSJNyvz6y3e6SficfkFXyRPm3RwsQ5H/gh1bp9Kc7xGmOzhRaKNpjPn8W93TiCu14nkzGPG8WjAcTtZUGE1VfOW/hvlOZ1gGLVAy+SA7vf9DsgBHqZHbbJNSlbdPQAc4GI1QJNpfL7ug4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031344; c=relaxed/simple;
	bh=yiEsoBEACzQ/jo0e+ZQ8AUPIqZcZ/eQkt2S+SbcW2Wc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ECcSu7gEJlBY/uWLeuSfc3ZEGusTxIjFXVaEq2Vm2AgRnO2+4dj1J6XTluotWZNbBKcaY/uiUuYuwDY5VszJ+sRbV1cljGdG+gDf0mVT2D1kyi2ry+Lcgh0t3UruDXUyNnm+cF8uvXZM+g2UmbZ3E0INcFmNe0SokMD8BrDF0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F8nSl8Kd; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d77b179b52so1701590a34.2
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774031341; x=1774636141; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdxAqbJMBkCfzRUM/vRrT9Nh3LwnWjxSazeXCeufvvo=;
        b=F8nSl8KdSD38LjlIKgNVLI0PNwLEB/GzS8Q/bYBUIyeBa/hc/cSGKkXelrp6+Vf6gM
         sAZT7mYKNxKpXHSXOkMUt5CSYQb+2FNdIAkEaX7cwuGC7oWlRU7iPrkANIrszmXs6XMy
         HUpvdBshENZHoYycU4nkMMYKcaV/wKPGRF/Ferd6djW01/W5s8NnlHAMAwS1kGdAWjjq
         rtmYQGFrsti1VRH5oyB9HqwLL9xWB62PnO2ZwovC2jnAnsSLW65o4sUlYyTf9X1LZ47Y
         5S0GbR/ejEhTZZ0Y+XaroX1S6pGrAXrO1wY9L+tO6HhJQSlQpFm0vwlK6abcoyVWaDLv
         5deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031341; x=1774636141;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdxAqbJMBkCfzRUM/vRrT9Nh3LwnWjxSazeXCeufvvo=;
        b=H3QzFJNXdD4n301j5r/QVRhPnIpoSlpGwasEq6t431N27JIBU6PCwSo/EwSQjaRKMs
         DZUmjfPhPqaVjlr8IcXJ2oIkpE9T+jeH2RPD5Pt+W3HQ20w/oTHnqt2cA8W1NhbaauSV
         HKHWanevDBOSpN2JtqpI6+bAiCS2RYIGls4t953Kn5AaXwIuNJDDcuaQKbUCRi4NISQZ
         1qw6yy5dNG1dmN21HnLrxT7iab3hhtOwA3OIq+GSiTno7sntoSYa7OWs65NjOFr7TC3i
         LWWgKgNBYuPEo2C2ogkwGnXEzADq+OXoEikZgt4MZEuASkrQOnuNsVOn1SSMs+O9qG3K
         Czng==
X-Gm-Message-State: AOJu0Yxw/4OS0b4R06Je5AKAXj503j3o1JU0FZmZOwGH35369cKcKq3A
	C7qenmpYUsAGn2HIKGyyHSo8sXYwcuahr530jRk7ruIoGpUTNM+TaVINMbecg+8EVmb+2c9Na3+
	Z5NGL24E=
X-Gm-Gg: ATEYQzxVGSFnRt2h/bQHz2twDp915+preTWB8hjAR6L8vYm5Mu38VQz2rC/6tAhmHOm
	0a6JqHtqKUXzUUczBzK8acGMRwb2sYj7Jm6VZoBOa4z76HE/QGsAG9zSKHfl/nX9JBP87PoKYxM
	C1wcW/btvncxy95V0cOXMSZz6+AWBvQfPI5OKdodc1+c59MAhL1TnRtAyGwA17MXNdzmtmEmDsP
	W0owoKyhiqk1TyQZe8C2DKDuFiHuueqfyEjwQ1+aI+pJ+w8jIs1fWX7Fk+ZnunIPVk8hvzSDp6y
	ITQ2sFUYd4vxo1VFExTos9/oJmdZEVThkZlqY/EILjpQDM64TpcDO3OswzP01GQyBgM9HSBbSyw
	Ee2Zec0guQJBLpLBqZVekTpmdNU+xWghLLo/bOr8pnGmTE1nzH5QvRbhk+V2U4qANlZE0i/W1lX
	L0tuK8i/fGXvDV83hjt1IidM5kTxIcYO5WBeGwqvBvWcPMzdpCq2uXOFaxcGB8LznP96lT1UN2n
	eomhErT
X-Received: by 2002:a05:6830:441f:b0:7d7:cd5a:cf9b with SMTP id 46e09a7af769-7d7eae79e63mr2733754a34.8.1774031340657;
        Fri, 20 Mar 2026 11:29:00 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadce2e4sm2706687a34.17.2026.03.20.11.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:28:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------SxuGKNyGpd1dp0GyWl5H87C9"
Message-ID: <c6099d0e-3f0b-4b25-9366-f258445a8e99@kernel.dk>
Date: Fri, 20 Mar 2026 12:28:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: propagate BUF_MORE through
 early buffer commit" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, code@mgjm.de
Cc: stable@vger.kernel.org
References: <2026032021-amused-playable-2e81@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026032021-amused-playable-2e81@gregkh>
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-227603-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,mgjm.de:email,kernel.dk:email,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5E6192DF77A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------SxuGKNyGpd1dp0GyWl5H87C9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 11:34 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's a tested version for 6.12-stable.

-- 
Jens Axboe

--------------SxuGKNyGpd1dp0GyWl5H87C9
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-kbuf-propagate-BUF_MORE-through-early-buffe.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-kbuf-propagate-BUF_MORE-through-early-buffe.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1M2JmOTc1ZjA5NGQzZDFmMmU0OTllODZiZDVhZjdhOWI0YjA4YTRkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTkgTWFyIDIwMjYgMTQ6Mjk6MjAgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9rYnVmOiBwcm9wYWdhdGUgQlVGX01PUkUgdGhyb3VnaCBlYXJseSBidWZmZXIg
Y29tbWl0CiBwYXRoCgpDb21taXQgNDE4ZWFiN2E2ZjNjMDAyZDhlNjRkNmU5NWVjMjcxMTgw
MTcwMTlhZiB1cHN0cmVhbS4KCldoZW4gaW9fc2hvdWxkX2NvbW1pdCgpIHJldHVybnMgdHJ1
ZSAoZWcgZm9yIG5vbi1wb2xsYWJsZSBmaWxlcyksIGJ1ZmZlcgpjb21taXQgaGFwcGVucyBh
dCBidWZmZXIgc2VsZWN0aW9uIHRpbWUgYW5kIHNlbC0+YnVmX2xpc3QgaXMgc2V0IHRvCk5V
TEwuIFdoZW4gX19pb19wdXRfa2J1ZnMoKSBnZW5lcmF0ZXMgQ1FFIGZsYWdzIGF0IGNvbXBs
ZXRpb24gdGltZSwgaXQKY2FsbHMgX19pb19wdXRfa2J1Zl9yaW5nKCkgd2hpY2ggZmluZHMg
YSBOVUxMIGJ1ZmZlcl9saXN0IGFuZCBoZW5jZQpjYW5ub3QgZGV0ZXJtaW5lIHdoZXRoZXIg
dGhlIGJ1ZmZlciB3YXMgY29uc3VtZWQgb3Igbm90LiBUaGlzIG1lYW5zIHRoYXQKSU9SSU5H
X0NRRV9GX0JVRl9NT1JFIGlzIG5ldmVyIHNldCBmb3Igbm9uLXBvbGxhYmxlIGlucHV0IHdp
dGgKaW5jcmVtZW50YWxseSBjb25zdW1lZCBidWZmZXJzLgoKTGlrZXdpc2UgZm9yIGlvX2J1
ZmZlcnNfc2VsZWN0KCksIHdoaWNoIGFsd2F5cyBjb21taXRzIHVwZnJvbnQgYW5kCmRpc2Nh
cmRzIHRoZSByZXR1cm4gdmFsdWUgb2YgaW9fa2J1Zl9jb21taXQoKS4KCkFkZCBSRVFfRl9C
VUZfTU9SRSB0byBzdG9yZSB0aGUgcmVzdWx0IG9mIGlvX2tidWZfY29tbWl0KCkgZHVyaW5n
IGVhcmx5CmNvbW1pdC4gVGhlbiBfX2lvX3B1dF9rYnVmX3JpbmcoKSBjYW4gY2hlY2sgdGhp
cyBmbGFnIGFuZCBzZXQKSU9SSU5HX0ZfQlVGX01PUkUgYWNjb3JkaW5neS4KClJlcG9ydGVk
LWJ5OiBNYXJ0aW4gTWljaGFlbGlzIDxjb2RlQG1nam0uZGU+CkNjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnCkZpeGVzOiBhZTk4ZGJmNDNkNzUgKCJpb191cmluZy9rYnVmOiBhZGQgc3Vw
cG9ydCBmb3IgaW5jcmVtZW50YWwgYnVmZmVyIGNvbnN1bXB0aW9uIikKTGluazogaHR0cHM6
Ly9naXRodWIuY29tL2F4Ym9lL2xpYnVyaW5nL2lzc3Vlcy8xNTUzClNpZ25lZC1vZmYtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpbmNsdWRlL2xpbnV4L2lvX3Vy
aW5nX3R5cGVzLmggfCAzICsrKwogaW9fdXJpbmcva2J1Zi5jICAgICAgICAgICAgICAgIHwg
NiArKysrLS0KIGlvX3VyaW5nL2tidWYuaCAgICAgICAgICAgICAgICB8IDQgKysrLQogMyBm
aWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvaW9fdXJpbmdfdHlwZXMuaCBiL2luY2x1ZGUvbGludXgv
aW9fdXJpbmdfdHlwZXMuaAppbmRleCBmMThmNTBkMzk1OTguLjljNjFlM2I5NjYyOCAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pb191cmluZ190eXBlcy5oCisrKyBiL2luY2x1ZGUv
bGludXgvaW9fdXJpbmdfdHlwZXMuaApAQCAtNDY3LDYgKzQ2Nyw3IEBAIGVudW0gewogCVJF
UV9GX0JMX0VNUFRZX0JJVCwKIAlSRVFfRl9CTF9OT19SRUNZQ0xFX0JJVCwKIAlSRVFfRl9C
VUZGRVJTX0NPTU1JVF9CSVQsCisJUkVRX0ZfQlVGX01PUkVfQklULAogCiAJLyogbm90IGEg
cmVhbCBiaXQsIGp1c3QgdG8gY2hlY2sgd2UncmUgbm90IG92ZXJmbG93aW5nIHRoZSBzcGFj
ZSAqLwogCV9fUkVRX0ZfTEFTVF9CSVQsCkBAIC01NDcsNiArNTQ4LDggQEAgZW51bSB7CiAJ
UkVRX0ZfQkxfTk9fUkVDWUNMRQk9IElPX1JFUV9GTEFHKFJFUV9GX0JMX05PX1JFQ1lDTEVf
QklUKSwKIAkvKiBidWZmZXIgcmluZyBoZWFkIG5lZWRzIGluY3JlbWVudGluZyBvbiBwdXQg
Ki8KIAlSRVFfRl9CVUZGRVJTX0NPTU1JVAk9IElPX1JFUV9GTEFHKFJFUV9GX0JVRkZFUlNf
Q09NTUlUX0JJVCksCisJLyogaW5jcmVtZW50YWwgYnVmZmVyIGNvbnN1bXB0aW9uLCBtb3Jl
IHNwYWNlIGF2YWlsYWJsZSAqLworCVJFUV9GX0JVRl9NT1JFCQk9IElPX1JFUV9GTEFHKFJF
UV9GX0JVRl9NT1JFX0JJVCksCiB9OwogCiB0eXBlZGVmIHZvaWQgKCppb19yZXFfdHdfZnVu
Y190KShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc3RydWN0IGlvX3R3X3N0YXRlICp0cyk7CmRp
ZmYgLS1naXQgYS9pb191cmluZy9rYnVmLmMgYi9pb191cmluZy9rYnVmLmMKaW5kZXggMjU1
OTdmMDYyOWYzLi41OTA5NzNjNDdjZDMgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2tidWYuYwor
KysgYi9pb191cmluZy9rYnVmLmMKQEAgLTE3NSw3ICsxNzUsOCBAQCBzdGF0aWMgdm9pZCBf
X3VzZXIgKmlvX3JpbmdfYnVmZmVyX3NlbGVjdChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc2l6
ZV90ICpsZW4sCiAJCSAqIHRoZSB0cmFuc2ZlciBjb21wbGV0ZXMgKG9yIGlmIHdlIGdldCAt
RUFHQUlOIGFuZCBtdXN0IHBvbGwgb2YKIAkJICogcmV0cnkpLgogCQkgKi8KLQkJaW9fa2J1
Zl9jb21taXQocmVxLCBibCwgKmxlbiwgMSk7CisJCWlmICghaW9fa2J1Zl9jb21taXQocmVx
LCBibCwgKmxlbiwgMSkpCisJCQlyZXEtPmZsYWdzIHw9IFJFUV9GX0JVRl9NT1JFOwogCQly
ZXEtPmJ1Zl9saXN0ID0gTlVMTDsKIAl9CiAJcmV0dXJuIHJldDsKQEAgLTMyMSw3ICszMjIs
OCBAQCBpbnQgaW9fYnVmZmVyc19zZWxlY3Qoc3RydWN0IGlvX2tpb2NiICpyZXEsIHN0cnVj
dCBidWZfc2VsX2FyZyAqYXJnLAogCQkgKi8KIAkJaWYgKHJldCA+IDApIHsKIAkJCXJlcS0+
ZmxhZ3MgfD0gUkVRX0ZfQlVGRkVSU19DT01NSVQgfCBSRVFfRl9CTF9OT19SRUNZQ0xFOwot
CQkJaW9fa2J1Zl9jb21taXQocmVxLCBibCwgYXJnLT5vdXRfbGVuLCByZXQpOworCQkJaWYg
KCFpb19rYnVmX2NvbW1pdChyZXEsIGJsLCBhcmctPm91dF9sZW4sIHJldCkpCisJCQkJcmVx
LT5mbGFncyB8PSBSRVFfRl9CVUZfTU9SRTsKIAkJfQogCX0gZWxzZSB7CiAJCXJldCA9IGlv
X3Byb3ZpZGVkX2J1ZmZlcnNfc2VsZWN0KHJlcSwgJmFyZy0+b3V0X2xlbiwgYmwsIGFyZy0+
aW92cyk7CmRpZmYgLS1naXQgYS9pb191cmluZy9rYnVmLmggYi9pb191cmluZy9rYnVmLmgK
aW5kZXggYTNhZDhhZWE0NWM4Li45MDM4MDBiMjBmZjMgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5n
L2tidWYuaAorKysgYi9pb191cmluZy9rYnVmLmgKQEAgLTE2NSw3ICsxNjUsOSBAQCBzdGF0
aWMgaW5saW5lIGJvb2wgX19pb19wdXRfa2J1Zl9yaW5nKHN0cnVjdCBpb19raW9jYiAqcmVx
LCBpbnQgbGVuLCBpbnQgbnIpCiAJCXJldCA9IGlvX2tidWZfY29tbWl0KHJlcSwgYmwsIGxl
biwgbnIpOwogCQlyZXEtPmJ1Zl9pbmRleCA9IGJsLT5iZ2lkOwogCX0KLQlyZXEtPmZsYWdz
ICY9IH5SRVFfRl9CVUZGRVJfUklORzsKKwlpZiAocmV0ICYmIChyZXEtPmZsYWdzICYgUkVR
X0ZfQlVGX01PUkUpKQorCQlyZXQgPSBmYWxzZTsKKwlyZXEtPmZsYWdzICY9IH4oUkVRX0Zf
QlVGRkVSX1JJTkcgfCBSRVFfRl9CVUZfTU9SRSk7CiAJcmV0dXJuIHJldDsKIH0KIAotLSAK
Mi41My4wCgo=

--------------SxuGKNyGpd1dp0GyWl5H87C9--

