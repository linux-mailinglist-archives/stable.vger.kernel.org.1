Return-Path: <stable+bounces-249989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLzoIrHLDWqq3QUAu9opvQ
	(envelope-from <stable+bounces-249989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:56:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419A5904A0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1C78304A652
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23E3033E9;
	Wed, 20 May 2026 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Cfpj3U6l"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187A1A6801
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288404; cv=none; b=i5qUpZL0G8q3LGQS7UFDU16wozHKXxdCNrpxG2XrBFvhkfjOmpu6Yg09HqOhnWeTO+UxLGC0E00+ZZTos0EnI6WI10mNjOC/T2m9wdhNfHT6ogzTcTenrNxZbLHcido83//RHLd/tZPwwnYQKxAkM8uJe5NvQS3o2V0BXUAHxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288404; c=relaxed/simple;
	bh=nbDzCy6cB88mtxEFVuiBvUGo3FU7AlMLXEA0BtffLgY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=hEkrUhPBBG5Qlr5s5bB7AeTJFFyIO6/FiIPj9dQpX49gc0Eis+ONHgjEglAM+St6IjNXeZ14GwAcoKMM5f+DRcbYddI0Yi54ftTTRltxZ6cteJNBlb4AA5J2urGjAH3q6nbuSQllvFCZwcze2LzErNCEpuQGd7SdVtSiiSrwayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Cfpj3U6l; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dcdaf06498so3308038a34.2
        for <stable@vger.kernel.org>; Wed, 20 May 2026 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779288402; x=1779893202; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG4A165MAodnO+O7zW8+RfAuu97glT+mvhHKPhxnuNA=;
        b=Cfpj3U6lG931/hQaS5GQvzn4WRtc/gRd4MB92p9ky7tw3z45e2OXqvYf+yGCf+YeC9
         zHZMbzz2VlCWdx4IBK55OpiNPf1fsWuZLidvwnzsnSteYAs8lkSyJsF36hvtdbO+ukxX
         ySNQZvQgChrKBUwXpd9k8YWlsrVlbm4yyJoZJFYFSiB3vf6k1wD0YZXQKLLar6TTasoo
         Qiijof1igoFYb4H/yh3EMhXrf9f10RdPTmXM0LTUGwWB7qu9qcDT00c/St0YwBej9W3l
         8C/WBC7QNXkHDhL2VKJ2iwKhdPJx/C+3eBR8k78xM0SAoIGVl1uSEFfWSXbF6NtLftCS
         Gliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288402; x=1779893202;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PG4A165MAodnO+O7zW8+RfAuu97glT+mvhHKPhxnuNA=;
        b=s8yq5yu/LXs2lLAzXdm05F4io2BgElWtEKss/jhNKOKk0aHts/5N1StscBkUKakQ2i
         I3Ghc7C6diETMR6NmIk8i89yRLDo3WCez+QS/wpZqi0ifi95ECtQeaIdiV+8w+NNOjIk
         tc9SgudTQ/PtZB2z6h9UHS3UO8WuMnVxE5xHIpbsLrhzwL5VWJ5oOs7SuQcJMgLMuN6M
         7idzpjTGZfq4yIu1BH8KKTiKcw8/PEVDo7TLm2Q7s03MCuD1rGh72MUZ992LwO8LV9WN
         8vPwv6SGc7CTGx+UEOIR3eY+eK0hw2e6x3E/oeEoDroviXTN2aR+sOeI2K6kF5SbzVOM
         AYag==
X-Gm-Message-State: AOJu0YzmHdrZ6Fss5noB5JPEZnEJScadq/nPTrG+VtHppmGIkH8ELTei
	XBlK2nYLIZqXO+Bl7GSiCe0Vy2d2K8vXEtjMDqNgox0K+CMoiEBqAAxX/6GvNKzuFjfDvijy87S
	y/cLH
X-Gm-Gg: Acq92OGaccd02DixZFmG07K+9mJ43m3UpRDHckD7Jxxf/uJspPuIBPmfvnUdcwCNjv3
	3iN3njCTgGXfJZ1+SJF2okrfvWjIXk9qkVQgx2Gz9MnubLsnm4VLa3iJKdsqXlMe4A3OgjWa7EB
	QSaqwqhp8Idcr4cj3n+3kS0Q5H7KnXgaWZRbyQPR6MM+PDAvdER0aVybZdpqcXTot9ajyqVLrtp
	38e6v1IpeTMVOB2DH7uI7rfHxtaAf46ZC6RonFiyQbeCODt9LW8f9vTRznAvLb68huNAJ/F4CJa
	9Xs4Y8HLDYalJep/2QpZbxg6M8NJgpr4FCqOGEF70DnOMmohiErlrGy0OY6WzcCdxJ4JvURriEb
	cQLAuzGuB/k4asupCEFikq4wISCw1yRVMkH3uS5Z4GeLMsD7q8iGrXh4OXV5MvSFLiBE6T2wZeK
	u1/y/aX/LoFFpusRjxiAxKPrMdIltabuDHh/2t+7CZIDAISCWbQ+vCGuj9yryODSH5coBzj/CL7
	O4eMQ6zNQHa6Lqm1kfb
X-Received: by 2002:a05:6830:6312:b0:7dc:e6e8:62b with SMTP id 46e09a7af769-7e4f2b416bemr16638809a34.13.1779288401613;
        Wed, 20 May 2026 07:46:41 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b8203a3sm12162778a34.11.2026.05.20.07.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 07:46:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------z849OsaD8RXwnL6tUGFZaWdm"
Message-ID: <7a2c2f2c-eb64-496b-a058-323ebf27df3b@kernel.dk>
Date: Wed, 20 May 2026 08:46:40 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io-wq: check that the predecessor is
 hashed in" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, nicholas@carlini.com
Cc: stable@vger.kernel.org
References: <2026052036-abiding-paper-2842@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026052036-abiding-paper-2842@gregkh>
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-249989-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,gregkh:email,linuxfoundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,carlini.com:email,kernel.dk:mid]
X-Rspamd-Queue-Id: 0419A5904A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------z849OsaD8RXwnL6tUGFZaWdm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/26 8:41 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x d6a2d7b04b5a093021a7a0e2e69e9d5237dfa8cc
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052036-abiding-paper-2842@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's one for 6.1-stable.

-- 
Jens Axboe

--------------z849OsaD8RXwnL6tUGFZaWdm
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io-wq-check-that-the-predecessor-is-hashed-in-io_wq_.patch"
Content-Disposition: attachment;
 filename*0="0001-io-wq-check-that-the-predecessor-is-hashed-in-io_wq_.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3MGQ0NjA2YzkxNWYzYTc1Mjc3YWRkYTI1NWNjN2EyYzdiMGFiMjA1IE1vbiBTZXAg
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
NThlNjE5Nzc2ZjAuLmY3NTI5OTk4MDdlZCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW8td3Eu
YworKysgYi9pb191cmluZy9pby13cS5jCkBAIC0xMDM0LDcgKzEwMzQsOCBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgaW9fd3FlX3JlbW92ZV9wZW5kaW5nKHN0cnVjdCBpb193cWUgKndxZSwK
IAlpZiAoaW9fd3FfaXNfaGFzaGVkKHdvcmspICYmIHdvcmsgPT0gd3FlLT5oYXNoX3RhaWxb
aGFzaF0pIHsKIAkJaWYgKHByZXYpCiAJCQlwcmV2X3dvcmsgPSBjb250YWluZXJfb2YocHJl
diwgc3RydWN0IGlvX3dxX3dvcmssIGxpc3QpOwotCQlpZiAocHJldl93b3JrICYmIGlvX2dl
dF93b3JrX2hhc2gocHJldl93b3JrKSA9PSBoYXNoKQorCQlpZiAocHJldl93b3JrICYmIGlv
X3dxX2lzX2hhc2hlZChwcmV2X3dvcmspICYmCisJCSAgICBpb19nZXRfd29ya19oYXNoKHBy
ZXZfd29yaykgPT0gaGFzaCkKIAkJCXdxZS0+aGFzaF90YWlsW2hhc2hdID0gcHJldl93b3Jr
OwogCQllbHNlCiAJCQl3cWUtPmhhc2hfdGFpbFtoYXNoXSA9IE5VTEw7Ci0tIAoyLjUzLjAK
Cg==

--------------z849OsaD8RXwnL6tUGFZaWdm--

