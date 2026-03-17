Return-Path: <stable+bounces-225996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Na3EgFTuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-225996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:11:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B60F2AA941
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BED43041DBB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9123C6A4E;
	Tue, 17 Mar 2026 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="weverUiA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08990390CB5
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752592; cv=none; b=cD2x4YnOZgOxkqYxMrJ5jrUCaRAq7sUcBNrF2U5Fh6OA1uDQUCW3pUDJPDSYiFX+EATB6nuhR//SnFIUDa4CJHO8WCch+H1OrAGfQPWVTqYh967oihSf9UIy97zOkRXnspd5w45DiM2ZTkHFFM/DAdkDQ5R+WjKNvoG7cLMCrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752592; c=relaxed/simple;
	bh=u0BgBwVmTO0HkP+qg2VbnO33yIzy4x34YiCYhS5xYWc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=eKh35LGtXyLG9dlycdtsIDtIzQKdS1+OuJdu74oFujTqZcMoi5hF4pwKxGP9aazZ5MWq5Z7wQyHIX4pqMcyodcB6rz0Tjyo18nJAqKs4mwxkbBtjb/pNq81CUfxSgnzDe9Bzi/48G6FhsFTidw6S3sz+d/1GIffBdfNlUkj/c0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=weverUiA; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-408778a8ec4so3446093fac.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773752590; x=1774357390; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvTidA9mOZV8Vf/fKE6vbNdjSBJoW2hEOgq7l+k5SNg=;
        b=weverUiAMfpTqFWu7ZFJBaO4Di6zCkbvDnk0uUCkceZl1YwkM6QexU8Gop/eiMeGY6
         FxKGBru0yifN+fIgCvAdYOEdQCIt9iy8OXSxgjMFRXQPNHDHKnAC/oJ8yAK1zvSU1w8J
         rWRg0QIIhx5OfHqF2YTulSheK3Qxx0kS02iUJqe1vrV/+hk1l0/WHwA2yMSwIcCzVqEN
         GH8272+673Dj3FZVBUrW8X7pCGrjgLGZ1M1Ipe+UReK0LYJSadZjQcGzInibOY23t6hr
         XoZG+ajWuo8BHxz3G45y5achOExfeuFBeG8UCILQ/d+XWB+bhoA+ORrbquiZGCrNhs6n
         UvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752590; x=1774357390;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvTidA9mOZV8Vf/fKE6vbNdjSBJoW2hEOgq7l+k5SNg=;
        b=Nfn8O4H/O94cVOofCl38amklg11yjGFQmTIz/4AQ9tK/YAjAyGujeKV2YEkwzl4bCl
         DxI6/hajQS8/9yVCv5WBvn1IEhu3llU5ApZJvs+MhfxsAvatxwu87HBYJhSDrFhDRpU8
         2qppgN9bD91FhULuznomLgo2TLDq0Ep+uo2cHK/mBHzLObxlTJbS+Uvkjk/NAxwYRryJ
         dbhoIOXanK9qOantJnz4bczHC87qWxdeTP29lVtSmmDh7uiaEVRebMCSQyMAvwTgRpwM
         +Cl92aHi0Gzw+Y/zflXxHS/Kiw61ESRZ5G4D98Ixm/wjBxGaZ7I54zaGTB8tRE/09bAD
         vYxA==
X-Gm-Message-State: AOJu0Yx3nLl+oiAARrUyUHJ4vAbzZD8UxfIXUbLoov1zrbQPLZ4BmXzh
	w2hm/GQlCY//spIUGC7xRl1gyQo07Ii4vDUVeaksuUgJi0RA3rtcHCG+QkXHmZ3ABaw=
X-Gm-Gg: ATEYQzw3M+np2sI9fHSrU6pjorcstXA9PcariWNLWgS4oqx1vAyeAXJPmfQizIosPUF
	zFgqdF+sb2p1gl5usuYfJVw69TIzF5aE0AzRsflCypYCEBJgqfvcs6fFBKP/Cfr3qIJvnz9cPV8
	Kn8SY03p9iVCxE+jrA/B5hB0QnzUp63fXvOoijBdlzYjNep3vLzoquFgSnZKsiWtjSik0Z0ZEvm
	VkIVYexq/E43zl6GIfXHW+dw+f7f5uc0Rh/WDZqTKoYvoQ2lNBTfrgNMBpZgORDegwFPXPnHaTA
	gX0/cBOChJrNU7st40kdmg4eOWHqiBvWMZI1DjW541jUyGsGUDkhMBWiSbdAjj8E8Rb3xAo1bkS
	7YOQ6ConRQz2OyMlfApIh4xTrPNQWbg1A2gZ6w5mPEk26z5Fzd45VM1dhsqqFgg7Q81YXLwAlnF
	KpzWgftr9IH3Z8jWxsLux7xxVARrCOvAWAAJGut6kuPthSgOJW/UIYYWK2TUc439lEBXyzf7fVc
	YKVoNUyoQ==
X-Received: by 2002:a05:6870:8318:b0:36e:8381:db00 with SMTP id 586e51a60fabf-417b902b7eemr10219350fac.9.1773752589727;
        Tue, 17 Mar 2026 06:03:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm19337678fac.12.2026.03.17.06.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 06:03:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------dlB35gz0zpTHxRjRY50NcXbg"
Message-ID: <07f88e01-d7d7-4e13-88de-76f460f60c50@kernel.dk>
Date: Tue, 17 Mar 2026 07:03:07 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: ensure ctx->rings is stable for
 task work flags" failed to apply to 6.18-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, naup96721@gmail.com
Cc: stable@vger.kernel.org
References: <2026031718-sulfur-overflow-96fd@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026031718-sulfur-overflow-96fd@gregkh>
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225996-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:email,kernel.dk:mid]
X-Rspamd-Queue-Id: 4B60F2AA941
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------dlB35gz0zpTHxRjRY50NcXbg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This one and the following one, for 6.18.

-- 
Jens Axboe

--------------dlB35gz0zpTHxRjRY50NcXbg
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-eventfd-use-ctx-rings_rcu-for-flags-checkin.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-eventfd-use-ctx-rings_rcu-for-flags-checkin.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmMzk4OTlkMmMwYjMxYTRmNWM5NzQyZWRjZTBmN2VmZjQ0MTQ4MzNiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgOSBNYXIgMjAyNiAxNDozNTo0OSAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBpb191cmluZy9ldmVudGZkOiB1c2UgY3R4LT5yaW5nc19yY3UgZm9yIGZsYWdzIGNoZWNr
aW5nCgpDb21taXQgMTc3YzY5NDMyMTYxZjZlNGJhYjA3Y2NhY2Y4YTE3NDhhNjg5OGE2YiB1
cHN0cmVhbS4KClNpbWlsYXJseSB0byB3aGF0IGNvbW1pdCBlNzhmN2I3MGU4MzcgZGlkIGZv
ciBsb2NhbCB0YXNrIHdvcmsgYWRkaXRpb25zLAp1c2UgLT5yaW5nc19yY3UgdW5kZXIgUkNV
IHJhdGhlciB0aGFuIGRlcmVmZXJlbmNlIC0+cmluZ3MgZGlyZWN0bHkuIFNlZQp0aGF0IGNv
bW1pdCBmb3IgbW9yZSBkZXRhaWxzLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4
ZXM6IDc5Y2ZlOWU1OWMyYSAoImlvX3VyaW5nL3JlZ2lzdGVyOiBhZGQgSU9SSU5HX1JFR0lT
VEVSX1JFU0laRV9SSU5HUyIpClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtl
cm5lbC5kaz4KLS0tCiBpb191cmluZy9ldmVudGZkLmMgfCAxMCArKysrKysrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2lvX3VyaW5nL2V2ZW50ZmQuYyBiL2lvX3VyaW5nL2V2ZW50ZmQuYwppbmRleCA3OGY4
YWI3ZGIxMDQuLmFiNzg5ZTFlYmU5MSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvZXZlbnRmZC5j
CisrKyBiL2lvX3VyaW5nL2V2ZW50ZmQuYwpAQCAtNzYsMTEgKzc2LDE1IEBAIHZvaWQgaW9f
ZXZlbnRmZF9zaWduYWwoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIGJvb2wgY3FlX2V2ZW50
KQogewogCWJvb2wgc2tpcCA9IGZhbHNlOwogCXN0cnVjdCBpb19ldl9mZCAqZXZfZmQ7Ci0K
LQlpZiAoUkVBRF9PTkNFKGN0eC0+cmluZ3MtPmNxX2ZsYWdzKSAmIElPUklOR19DUV9FVkVO
VEZEX0RJU0FCTEVEKQotCQlyZXR1cm47CisJc3RydWN0IGlvX3JpbmdzICpyaW5nczsKIAog
CWd1YXJkKHJjdSkoKTsKKworCXJpbmdzID0gcmN1X2RlcmVmZXJlbmNlKGN0eC0+cmluZ3Nf
cmN1KTsKKwlpZiAoIXJpbmdzKQorCQlyZXR1cm47CisJaWYgKFJFQURfT05DRShyaW5ncy0+
Y3FfZmxhZ3MpICYgSU9SSU5HX0NRX0VWRU5URkRfRElTQUJMRUQpCisJCXJldHVybjsKIAll
dl9mZCA9IHJjdV9kZXJlZmVyZW5jZShjdHgtPmlvX2V2X2ZkKTsKIAkvKgogCSAqIENoZWNr
IGFnYWluIGlmIGV2X2ZkIGV4aXN0cyBpbiBjYXNlIGFuIGlvX2V2ZW50ZmRfdW5yZWdpc3Rl
ciBjYWxsCi0tIAoyLjUzLjAKCg==
--------------dlB35gz0zpTHxRjRY50NcXbg
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-ensure-ctx-rings-is-stable-for-task-work-fl.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-ensure-ctx-rings-is-stable-for-task-work-fl.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmNzlhNmQwODg5MzE4ZGNlNzliMTY5MWIyZTdlOTRiOGQ3ODlmZTM2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgOSBNYXIgMjAyNiAxNDoyMTozNyAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBpb191cmluZzogZW5zdXJlIGN0eC0+cmluZ3MgaXMgc3RhYmxlIGZvciB0YXNrIHdvcmsg
ZmxhZ3MKIG1hbmlwdWxhdGlvbgoKQ29tbWl0IDk2MTg5MDgwMjY1ZTZiYjVkZGUzYTRhZmJh
Zjk0N2FmNDkzZTNmODIgdXBzdHJlYW0uCgpJZiBERUZFUl9UQVNLUlVOIHwgU0VUVVBfVEFT
S1JVTiBpcyB1c2VkIGFuZCB0YXNrIHdvcmsgaXMgYWRkZWQgd2hpbGUKdGhlIHJpbmcgaXMg
YmVpbmcgcmVzaXplZCwgaXQncyBwb3NzaWJsZSBmb3IgdGhlIE9SJ2luZyBvZgpJT1JJTkdf
U1FfVEFTS1JVTiB0byBoYXBwZW4gaW4gdGhlIHNtYWxsIHdpbmRvdyBvZiBzd2FwcGluZyBp
bnRvIHRoZQpuZXcgcmluZ3MgYW5kIHRoZSBvbGQgcmluZ3MgYmVpbmcgZnJlZWQuCgpQcmV2
ZW50IHRoaXMgYnkgYWRkaW5nIGEgMm5kIC0+cmluZ3MgcG9pbnRlciwgLT5yaW5nc19yY3Us
IHdoaWNoIGlzCnByb3RlY3RlZCBieSBSQ1UuIFRoZSB0YXNrIHdvcmsgZmxhZ3MgbWFuaXB1
bGF0aW9uIGlzIGluc2lkZSBSQ1UKYWxyZWFkeSwgYW5kIGlmIHRoZSByZXNpemUgcmluZyBm
cmVlaW5nIGlzIGRvbmUgcG9zdCBhbiBSQ1Ugc3luY2hyb25pemUsCnRoZW4gdGhlcmUncyBu
byBuZWVkIHRvIGFkZCBsb2NraW5nIHRvIHRoZSBmYXN0IHBhdGggb2YgdGFzayB3b3JrCmFk
ZGl0aW9ucy4KCk5vdGU6IHRoaXMgaXMgb25seSBkb25lIGZvciBERUZFUl9UQVNLUlVOLCBh
cyB0aGF0J3MgdGhlIG9ubHkgc2V0dXAgbW9kZQp0aGF0IHN1cHBvcnRzIHJpbmcgcmVzaXpp
bmcuIElmIHRoaXMgZXZlciBjaGFuZ2VzLCB0aGVuIHRoZXkgdG9vIG5lZWQgdG8KdXNlIHRo
ZSBpb19jdHhfbWFya190YXNrcnVuKCkgaGVscGVyLgoKTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvaW8tdXJpbmcvMjAyNjAzMDkwNjI3NTkuNDgyMjEwLTEtbmF1cDk2NzIxQGdt
YWlsLmNvbS8KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDc5Y2ZlOWU1OWMy
YSAoImlvX3VyaW5nL3JlZ2lzdGVyOiBhZGQgSU9SSU5HX1JFR0lTVEVSX1JFU0laRV9SSU5H
UyIpClJlcG9ydGVkLWJ5OiBIYW8tWXUgWWFuZyA8bmF1cDk2NzIxQGdtYWlsLmNvbT4KU3Vn
Z2VzdGVkLWJ5OiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdtYWlsLmNvbT4KU2ln
bmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGluY2x1ZGUv
bGludXgvaW9fdXJpbmdfdHlwZXMuaCB8ICAxICsKIGlvX3VyaW5nL2lvX3VyaW5nLmMgICAg
ICAgICAgICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKystLS0KIGlvX3VyaW5nL3JlZ2lz
dGVyLmMgICAgICAgICAgICB8IDExICsrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDM0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9pb191cmluZ190eXBlcy5oIGIvaW5jbHVkZS9saW51eC9pb191cmluZ190eXBlcy5o
CmluZGV4IGI0ZDhhY2EzZTc4Ni4uM2YzNTA2MDU2YjlhIDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L2lvX3VyaW5nX3R5cGVzLmgKKysrIGIvaW5jbHVkZS9saW51eC9pb191cmluZ190
eXBlcy5oCkBAIC0zNzIsNiArMzcyLDcgQEAgc3RydWN0IGlvX3JpbmdfY3R4IHsKIAkgKiBy
ZWd1bGFybHkgYm91bmNlIGIvdyBDUFVzLgogCSAqLwogCXN0cnVjdCB7CisJCXN0cnVjdCBp
b19yaW5ncwlfX3JjdQkqcmluZ3NfcmN1OwogCQlzdHJ1Y3QgbGxpc3RfaGVhZAl3b3JrX2xs
aXN0OwogCQlzdHJ1Y3QgbGxpc3RfaGVhZAlyZXRyeV9sbGlzdDsKIAkJdW5zaWduZWQgbG9u
ZwkJY2hlY2tfY3E7CmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIvaW9fdXJp
bmcvaW9fdXJpbmcuYwppbmRleCA2NWFmNDdiOTEzNWIuLmQxMGEzOGM5ZGJmYiAxMDA2NDQK
LS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191cmluZy5jCkBA
IC0xMjM4LDYgKzEyMzgsMjEgQEAgdm9pZCB0Y3R4X3Rhc2tfd29yayhzdHJ1Y3QgY2FsbGJh
Y2tfaGVhZCAqY2IpCiAJV0FSTl9PTl9PTkNFKHJldCk7CiB9CiAKKy8qCisgKiBTZXRzIElP
UklOR19TUV9UQVNLUlVOIGluIHRoZSBzcV9mbGFncyBzaGFyZWQgd2l0aCB1c2Vyc3BhY2Us
IHVzaW5nIHRoZQorICogUkNVIHByb3RlY3RlZCByaW5ncyBwb2ludGVyIHRvIGJlIHNhZmUg
YWdhaW5zdCBjb25jdXJyZW50IHJpbmcgcmVzaXppbmcuCisgKi8KK3N0YXRpYyB2b2lkIGlv
X2N0eF9tYXJrX3Rhc2tydW4oc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCit7CisJbG9ja2Rl
cF9hc3NlcnRfaW5fcmN1X3JlYWRfbG9jaygpOworCisJaWYgKGN0eC0+ZmxhZ3MgJiBJT1JJ
TkdfU0VUVVBfVEFTS1JVTl9GTEFHKSB7CisJCXN0cnVjdCBpb19yaW5ncyAqcmluZ3MgPSBy
Y3VfZGVyZWZlcmVuY2UoY3R4LT5yaW5nc19yY3UpOworCisJCWF0b21pY19vcihJT1JJTkdf
U1FfVEFTS1JVTiwgJnJpbmdzLT5zcV9mbGFncyk7CisJfQorfQorCiBzdGF0aWMgdm9pZCBp
b19yZXFfbG9jYWxfd29ya19hZGQoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGZs
YWdzKQogewogCXN0cnVjdCBpb19yaW5nX2N0eCAqY3R4ID0gcmVxLT5jdHg7CkBAIC0xMjky
LDggKzEzMDcsNyBAQCBzdGF0aWMgdm9pZCBpb19yZXFfbG9jYWxfd29ya19hZGQoc3RydWN0
IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGZsYWdzKQogCSAqLwogCiAJaWYgKCFoZWFkKSB7
Ci0JCWlmIChjdHgtPmZsYWdzICYgSU9SSU5HX1NFVFVQX1RBU0tSVU5fRkxBRykKLQkJCWF0
b21pY19vcihJT1JJTkdfU1FfVEFTS1JVTiwgJmN0eC0+cmluZ3MtPnNxX2ZsYWdzKTsKKwkJ
aW9fY3R4X21hcmtfdGFza3J1bihjdHgpOwogCQlpZiAoY3R4LT5oYXNfZXZmZCkKIAkJCWlv
X2V2ZW50ZmRfc2lnbmFsKGN0eCwgZmFsc2UpOwogCX0KQEAgLTEzMTcsNiArMTMzMSwxMCBA
QCBzdGF0aWMgdm9pZCBpb19yZXFfbm9ybWFsX3dvcmtfYWRkKHN0cnVjdCBpb19raW9jYiAq
cmVxKQogCWlmICghbGxpc3RfYWRkKCZyZXEtPmlvX3Rhc2tfd29yay5ub2RlLCAmdGN0eC0+
dGFza19saXN0KSkKIAkJcmV0dXJuOwogCisJLyoKKwkgKiBEb2Vzbid0IG5lZWQgdG8gdXNl
IC0+cmluZ3NfcmN1LCBhcyByZXNpemluZyBpc24ndCBzdXBwb3J0ZWQgZm9yCisJICogIURF
RkVSX1RBU0tSVU4uCisJICovCiAJaWYgKGN0eC0+ZmxhZ3MgJiBJT1JJTkdfU0VUVVBfVEFT
S1JVTl9GTEFHKQogCQlhdG9taWNfb3IoSU9SSU5HX1NRX1RBU0tSVU4sICZjdHgtPnJpbmdz
LT5zcV9mbGFncyk7CiAKQEAgLTI3NzQsNiArMjc5Miw3IEBAIHN0YXRpYyB2b2lkIGlvX3Jp
bmdzX2ZyZWUoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCiAJaW9fZnJlZV9yZWdpb24oY3R4
LCAmY3R4LT5zcV9yZWdpb24pOwogCWlvX2ZyZWVfcmVnaW9uKGN0eCwgJmN0eC0+cmluZ19y
ZWdpb24pOwogCWN0eC0+cmluZ3MgPSBOVUxMOworCVJDVV9JTklUX1BPSU5URVIoY3R4LT5y
aW5nc19yY3UsIE5VTEwpOwogCWN0eC0+c3Ffc3FlcyA9IE5VTEw7CiB9CiAKQEAgLTM2Mjcs
NyArMzY0Niw3IEBAIHN0YXRpYyBfX2NvbGQgaW50IGlvX2FsbG9jYXRlX3NjcV91cmluZ3Mo
c3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsCiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAlj
dHgtPnJpbmdzID0gcmluZ3MgPSBpb19yZWdpb25fZ2V0X3B0cigmY3R4LT5yaW5nX3JlZ2lv
bik7Ci0KKwlyY3VfYXNzaWduX3BvaW50ZXIoY3R4LT5yaW5nc19yY3UsIHJpbmdzKTsKIAlp
ZiAoIShjdHgtPmZsYWdzICYgSU9SSU5HX1NFVFVQX05PX1NRQVJSQVkpKQogCQljdHgtPnNx
X2FycmF5ID0gKHUzMiAqKSgoY2hhciAqKXJpbmdzICsgc3FfYXJyYXlfb2Zmc2V0KTsKIApk
aWZmIC0tZ2l0IGEvaW9fdXJpbmcvcmVnaXN0ZXIuYyBiL2lvX3VyaW5nL3JlZ2lzdGVyLmMK
aW5kZXggZGI1M2U2NjQzNDhkLi5mYWE0NGRkMzJjZDUgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5n
L3JlZ2lzdGVyLmMKKysrIGIvaW9fdXJpbmcvcmVnaXN0ZXIuYwpAQCAtNTU2LDcgKzU1Niwx
NSBAQCBzdGF0aWMgaW50IGlvX3JlZ2lzdGVyX3Jlc2l6ZV9yaW5ncyhzdHJ1Y3QgaW9fcmlu
Z19jdHggKmN0eCwgdm9pZCBfX3VzZXIgKmFyZykKIAljdHgtPnNxX2VudHJpZXMgPSBwLnNx
X2VudHJpZXM7CiAJY3R4LT5jcV9lbnRyaWVzID0gcC5jcV9lbnRyaWVzOwogCisJLyoKKwkg
KiBKdXN0IG1hcmsgYW55IGZsYWcgd2UgbWF5IGhhdmUgbWlzc2VkIGFuZCB0aGF0IHRoZSBh
cHBsaWNhdGlvbgorCSAqIHNob3VsZCBhY3Qgb24gdW5jb25kaXRpb25hbGx5LiBXb3JzdCBj
YXNlIGl0J2xsIGJlIGFuIGV4dHJhCisJICogc3lzY2FsbC4KKwkgKi8KKwlhdG9taWNfb3Io
SU9SSU5HX1NRX1RBU0tSVU4gfCBJT1JJTkdfU1FfTkVFRF9XQUtFVVAsICZuLnJpbmdzLT5z
cV9mbGFncyk7CiAJY3R4LT5yaW5ncyA9IG4ucmluZ3M7CisJcmN1X2Fzc2lnbl9wb2ludGVy
KGN0eC0+cmluZ3NfcmN1LCBuLnJpbmdzKTsKKwogCWN0eC0+c3Ffc3FlcyA9IG4uc3Ffc3Fl
czsKIAlzd2FwX29sZChjdHgsIG8sIG4sIHJpbmdfcmVnaW9uKTsKIAlzd2FwX29sZChjdHgs
IG8sIG4sIHNxX3JlZ2lvbik7CkBAIC01NjUsNiArNTczLDkgQEAgc3RhdGljIGludCBpb19y
ZWdpc3Rlcl9yZXNpemVfcmluZ3Moc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIHZvaWQgX191
c2VyICphcmcpCiBvdXQ6CiAJc3Bpbl91bmxvY2soJmN0eC0+Y29tcGxldGlvbl9sb2NrKTsK
IAltdXRleF91bmxvY2soJmN0eC0+bW1hcF9sb2NrKTsKKwkvKiBXYWl0IGZvciBjb25jdXJy
ZW50IGlvX2N0eF9tYXJrX3Rhc2tydW4oKSAqLworCWlmICh0b19mcmVlID09ICZvKQorCQlz
eW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCk7CiAJaW9fcmVnaXN0ZXJfZnJlZV9yaW5ncyhj
dHgsICZwLCB0b19mcmVlKTsKIAogCWlmIChjdHgtPnNxX2RhdGEpCi0tIAoyLjUzLjAKCg==


--------------dlB35gz0zpTHxRjRY50NcXbg--

