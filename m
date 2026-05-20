Return-Path: <stable+bounces-249985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECwpO9fKDWqo3QUAu9opvQ
	(envelope-from <stable+bounces-249985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:53:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DEB59039A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6D5F302F9CD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B2E306B08;
	Wed, 20 May 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QQDFfrnd"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D0272E61
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288366; cv=none; b=ISKow+QKXxwvhwC/oAjE1k4OSLxb5cBQs9SEk2wug9lHWQg+WeeZD/w6IaIiA4X8T6wpZcvZwIykvm0Ot2aAr81kkrEzsVZ9HrMCzIlv2JdDin/t1j8Jz/b8jPwl+nrUzMWfaTnevOvj3AcyPb3AfoefCfx0NVkFt587/L3wmbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288366; c=relaxed/simple;
	bh=jY3OTcpEwOyfqBo4nkRxU0pTjvIhnoM5+DXGQEiteUA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=atQiFrpMge6FW794rJyXF85ANryoQxJ+o0IMIGu/uLgzUXkg0ZaDSMAuS+Eafo/IQSQ+f3kK3WzKew2Adgwb7c1mGkxu3ZV6cme3fesvM4voFfSqsma1aR2YJDMabXLkWoL+T/FPzkLGWxAs5Fy8m1G0xxoOGJ/TQuG8g0KetZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QQDFfrnd; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69b747a8984so1239359eaf.2
        for <stable@vger.kernel.org>; Wed, 20 May 2026 07:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779288363; x=1779893163; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wh+afktZHPLncMwi/X3WmfjAIG77K3LxEOfZ53bCeo=;
        b=QQDFfrndoHbgIb9a36hNNCFxkyhqgahGjA+rI+eV5KJ9cWoT17189idnfumWgRdG60
         WGVemj0134bwlNnudRNiqmRRPGQGsPTPSmIvTT/umPnSrFtZjQxlmGlsRxx/Lp5oMD22
         VhyGJEwDIzeyS6AGgRIga70eN5QChITgEkPp/FiLrqtWYWldZJL89zs7cZC/UP1IJ1Xr
         fArFuC8VhVm+HKErS9vqPAg4Yo8YiTvKogS2mXo8HRYxrw29bzn9VNDoQQtg8vGekDxq
         8+JX6TntLynQsNtAobMswCM+egGdEdL4qtd9B99nSX2vQtqRIzE7eHY8cddslgT0kNFv
         aEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288363; x=1779893163;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wh+afktZHPLncMwi/X3WmfjAIG77K3LxEOfZ53bCeo=;
        b=XzzrM9YxZ98IW2blgkyQicElik4Xz82XUOPAtTErKpV7x9BPPDkF47XGAao0xxU1nl
         xF6fUPhh6qD5oWGwG2sz4hvTe8oX7P9lQbAej7pPs1PPHBOfLPpqcURDmJC5Ppgr+Agi
         jXtwvBYphb0xNpJ7kyylRU/XwXVfGSF+zb/G+62FdJKcUruUNbz6eykqqypD0OZd3icE
         Eit6cSJciQh93RCWX0+QhyH4aQ3veQkW9PdRfTyPRjK/O2MtM08bTCjyelbR4GW4Ro2H
         W7CxR8+i1BVGAOmmlAFBMXqyZy8x5uVn4Fy0RlSzT4a4Fef/WkTs6bPfJGl/AR194FBf
         u58w==
X-Gm-Message-State: AOJu0Yy/WLplVfj4nErbspkT2GXP2xSe7hsQmu/aa6XsYVBSt4Ps1m3h
	MURQ0JYWDVNiuJjiqNhjfpkV7PEP7cs+1hBNTUnCdC5P4vh1lMMSVX6H+24TLoHVn1s=
X-Gm-Gg: Acq92OFUKLzjOceb8AydM5nDkY+kwnnTsGauuwkkhom69K05GTBuVALJTqLVMY0MC5g
	9nPKoeFrrVlJ3CYXBAne7xgkJx3rJUTsNsPuzVtCwNe7Ko1Bqpar/v4REKH/8ophXMjav1yrP+C
	U3MjYFN+gKO48/9V5iz2O6O2CeeReX5ELbNdhe1SR83+4GI3D24IUew4P/E9fnM3EXL3KJxhslE
	OJhLp9sZ4oGApHVbFCPtqavAlXORfEMp196B4SYNgYKSWQvrVD6Tgp6fbrauQIATmpvaqooBLHP
	gkhiNdSMVgYmS7fOt9X7Ljol1r7cYVhpJ+ea1qxkqnKGUp2BM8WI95Di+yz5wFH/tgixy47fD7d
	/SM6QlCIKaYAgTq0URkmWH3RwHWG/xosbWA3eRVrkScZrxo+mJNIwdo1YhvpKQ2FwTThhIqSQpv
	JusnkYaVgnv+G00hmxF7PDahmE8SfGkr2UAF0+Ry/3ZIbZC7lxqJnLVhS3rNIEVFRRzc/Yu1bd2
	XfJRx9/EmyWpIaP4J4B
X-Received: by 2002:a05:6820:81c7:b0:69b:5697:3878 with SMTP id 006d021491bc7-69c942ee217mr15966992eaf.18.1779288363041;
        Wed, 20 May 2026 07:46:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d0465461bsm8856094eaf.7.2026.05.20.07.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:46:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------5RVAdOxbgns14ztbK19x7WCi"
Message-ID: <efd4f787-c6df-4ab7-96ce-132cabf414f9@kernel.dk>
Date: Wed, 20 May 2026 08:46:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io-wq: check that the predecessor is
 hashed in" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, nicholas@carlini.com
Cc: stable@vger.kernel.org
References: <2026052036-arbitrate-wasp-6200@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026052036-arbitrate-wasp-6200@gregkh>
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_FROM(0.00)[bounces-249985-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[carlini.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kernel.dk:mid,linuxfoundation.org:email,gregkh:email,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 83DEB59039A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------5RVAdOxbgns14ztbK19x7WCi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/26 8:41 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x d6a2d7b04b5a093021a7a0e2e69e9d5237dfa8cc
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052036-arbitrate-wasp-6200@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's one for 5.15-stable AND 5.10-stable.

-- 
Jens Axboe

--------------5RVAdOxbgns14ztbK19x7WCi
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io-wq-check-that-the-predecessor-is-hashed-in-io_wq_.patch"
Content-Disposition: attachment;
 filename*0="0001-io-wq-check-that-the-predecessor-is-hashed-in-io_wq_.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmYjEzMzM1MWJlZDVjNWFlZmMyMDEyOWRjZjNiM2E2MmQ0NGUxNmVhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNob2xhcyBDYXJsaW5pIDxuaWNob2xhc0BjYXJs
aW5pLmNvbT4KRGF0ZTogTW9uLCAxMSBNYXkgMjAyNiAxODowMjoxNiArMDAwMApTdWJqZWN0
OiBbUEFUQ0hdIGlvLXdxOiBjaGVjayB0aGF0IHRoZSBwcmVkZWNlc3NvciBpcyBoYXNoZWQg
aW4KIGlvX3dxX3JlbW92ZV9wZW5kaW5nKCkKCmlvX3dxX3JlbW92ZV9wZW5kaW5nKCkgbmVl
ZHMgdG8gZml4IHVwIHdxLT5oYXNoX3RhaWxbXSBpZiB0aGUgY2FuY2VsbGVkCndvcmsgd2Fz
IHRoZSB0YWlsIG9mIGl0cyBoYXNoIGJ1Y2tldC4gV2hlbiBkb2luZyB0aGlzLCBpdCBjaGVj
a3Mgd2hldGhlcgp0aGUgcHJlY2VkaW5nIGVudHJ5IGluIGFjY3QtPndvcmtfbGlzdCBoYXMg
dGhlIHNhbWUgaGFzaCB2YWx1ZSwgYnV0Cm5ldmVyIGNoZWNrcyB0aGF0IHRoZSBwcmVkZWNl
c3NvciBpcyBoYXNoZWQgYXQgYWxsLiBpb19nZXRfd29ya19oYXNoKCkKaXMgc2ltcGx5IGF0
b21pY19yZWFkKCZ3b3JrLT5mbGFncykgPj4gSU9fV1FfSEFTSF9TSElGVCwgYW5kIHRoZSBo
YXNoCmJpdHMgYXJlIG5ldmVyIHNldCBmb3Igbm9uLWhhc2hlZCB3b3JrLCBzbyBpdCByZXR1
cm5zIDAuIFRodXMsIHdoZW4gYQpoYXNoZWQgYnVja2V0LTAgd29yayBpcyBjYW5jZWxsZWQg
d2hpbGUgYSBub24taGFzaGVkIHdvcmsgaXMgaXRzIGxpc3QKcHJlZGVjZXNzb3IsIHRoZSBj
aGVjayBzcHVyaW91c2x5IHBhc3NlcyBhbmQgYSBwb2ludGVyIHRvIHRoZSBub24taGFzaGVk
CmlvX2tpb2NiIGlzIHN0b3JlZCBpbiB3cS0+aGFzaF90YWlsWzBdLgoKQmVjYXVzZSBub24t
aGFzaGVkIHdvcmsgaXMgZGVxdWV1ZWQgdmlhIHRoZSBmYXN0IHBhdGggaW4KaW9fZ2V0X25l
eHRfd29yaygpLCB3aGljaCBuZXZlciB0b3VjaGVzIGhhc2hfdGFpbFtdLCB0aGUgc3RhbGUg
cG9pbnRlcgppcyBuZXZlciBjbGVhcmVkLiBUaGVyZWZvcmUsIGFmdGVyIHRoZSBub24taGFz
aGVkIGlvX2tpb2NiIGNvbXBsZXRlcyBhbmQKaXMgZnJlZWQgYmFjayB0byByZXFfY2FjaGVw
LCB3cS0+aGFzaF90YWlsWzBdIGlzIGEgZGFuZ2xpbmcgcG9pbnRlci4gVGhlCmlvX3dxIGlz
IHBlci10YXNrICh0Y3R4LT5pb193cSkgYW5kIHN1cnZpdmVzIHJpbmcgb3Blbi9jbG9zZSwg
c28gdGhlCmRhbmdsaW5nIHBvaW50ZXIgcGVyc2lzdHMgZm9yIHRoZSBsaWZldGltZSBvZiB0
aGUgdGFzazsgdGhlIG5leHQgaGFzaGVkCmJ1Y2tldC0wIGVucXVldWUgZGVyZWZlcmVuY2Vz
IGl0IGluIGlvX3dxX2luc2VydF93b3JrKCkgYW5kCndxX2xpc3RfYWRkX2FmdGVyKCkgd3Jp
dGVzIHRocm91Z2ggZnJlZWQgbWVtb3J5LgoKQWRkIHRoZSBtaXNzaW5nIGlvX3dxX2lzX2hh
c2hlZCgpIGNoZWNrIHNvIGEgbm9uLWhhc2hlZCBwcmVkZWNlc3NvcgpuZXZlciBpbmhlcml0
cyBhIGhhc2hfdGFpbFtdIHNsb3QuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDUu
NysKRml4ZXM6IDIwNDM2MWE3N2Y0MCAoImlvLXdxOiBmaXggaGFuZyBhZnRlciBjYW5jZWxs
aW5nIHBlbmRpbmcgaGFzaGVkIHdvcmsiKQpTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBDYXJs
aW5pIDxuaWNob2xhc0BjYXJsaW5pLmNvbT4KLS0tCiBpb191cmluZy9pby13cS5jIHwgMyAr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9pb191cmluZy9pby13cS5jIGIvaW9fdXJpbmcvaW8td3EuYwppbmRleCA5
MjY4OTBmNTA4NmUuLjVkOTVlNjA0YjdlNiAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW8td3Eu
YworKysgYi9pb191cmluZy9pby13cS5jCkBAIC0xMDE0LDcgKzEwMTQsOCBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgaW9fd3FlX3JlbW92ZV9wZW5kaW5nKHN0cnVjdCBpb193cWUgKndxZSwK
IAlpZiAoaW9fd3FfaXNfaGFzaGVkKHdvcmspICYmIHdvcmsgPT0gd3FlLT5oYXNoX3RhaWxb
aGFzaF0pIHsKIAkJaWYgKHByZXYpCiAJCQlwcmV2X3dvcmsgPSBjb250YWluZXJfb2YocHJl
diwgc3RydWN0IGlvX3dxX3dvcmssIGxpc3QpOwotCQlpZiAocHJldl93b3JrICYmIGlvX2dl
dF93b3JrX2hhc2gocHJldl93b3JrKSA9PSBoYXNoKQorCQlpZiAocHJldl93b3JrICYmIGlv
X3dxX2lzX2hhc2hlZChwcmV2X3dvcmspICYmCisJCSAgICBpb19nZXRfd29ya19oYXNoKHBy
ZXZfd29yaykgPT0gaGFzaCkKIAkJCXdxZS0+aGFzaF90YWlsW2hhc2hdID0gcHJldl93b3Jr
OwogCQllbHNlCiAJCQl3cWUtPmhhc2hfdGFpbFtoYXNoXSA9IE5VTEw7Ci0tIAoyLjUzLjAK
Cg==

--------------5RVAdOxbgns14ztbK19x7WCi--

