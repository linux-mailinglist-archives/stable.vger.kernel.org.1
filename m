Return-Path: <stable+bounces-39210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C48C8A1DFA
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 20:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A3DB3428B
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBCA3D3BC;
	Thu, 11 Apr 2024 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lw/RD4xl"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C63D548
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 16:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852939; cv=none; b=UKx4nLMvogtI2mT3a8VeZRjXD1F5VQ0cjZBrqrMdJzO+InALuQru/15Chf9wx9tgTgEMXKdmwugBiE5iZNUTBNAnZXpQHt5X5lxEQfkzBz6x2aAPc7SqHwlQptotLt93pGsOYbNrm4WL2qC2k09/+VThmi3qU11OhxlcKnKGbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852939; c=relaxed/simple;
	bh=y2jcGGIiMkEKCJkOhdPc9G1qO6EfT2401gupWqGLqWs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=YMGwwE9jDrxuYm7gO9ENP8My6zRPyJ8FjchKkvCGiJjbaHizeIs2fdnKQa4uCZ81Ea8LaQEuqLerBVDmjZ6AZXC/uC75mEqVRez/ZjoAfweSx4qpp+m0B+ZBcwCbtPJst468S9viOUqBQ74F3BskeKagtcctu/ZV7QcwrGgbAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lw/RD4xl; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9990039f.0
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712852936; x=1713457736; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBGkwzcCwC0Qy8Ql46phtc4hR/OfBLk2PszTzEzw/kQ=;
        b=lw/RD4xlhIhWHVdAT5BY8Rd9w7Rg2A2mloHJvqyniPnt1v7l0ZnRLvZ/GL1zuRdEJ2
         wTMj0Jv+JUofGjv5Lkxxw1AXw9fYEjfYIOYsy2T1gHEIyCKfveBaBT5ozkiHP816N/S4
         8R6k7OqyziVGR07PheU9QulSP4fHzjjePQJCvzCA0/+rDJ+5URbov4pijIG4Ox0KJKah
         xa42CIqHWBrp0AFMkW3G2zpQFYN9FVtwJ+ehFFfH+t34lJHB5P7YoE0mehqaXZ5blSlV
         ETcN/7B3SKRQDrvx+2iwius8L+VJnU41i5HofZ5iywo1sGLDhB1AWRMWbDv7YZxXbQgx
         QOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852936; x=1713457736;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oBGkwzcCwC0Qy8Ql46phtc4hR/OfBLk2PszTzEzw/kQ=;
        b=GkZ4s6Mmug8GRSKH5GW/E47Id+SAxW5AxS2N7YM+02pMmX5RwIE9jlyPtgsH/LNs01
         dRqh++MF+YYc5JgUi/IxtSK7wwEZqhqc5+ybqUwM0yIBZnz13gHGhFlziZ7pc8fwFKCT
         xo0JR6TUPNp5Xh8TYqoB1vNDLhQAZFMhuu68g/hyC9iZwL7wUhPvnHF8mCNcjaRnBplT
         dtDC5qoJ3UCbgTygzI24Rk5PcTaySyi1Icj5EJoYGCuVt6N1PdEdu9VS2X94O97Z2IhZ
         1XRaWmtMPtEtkk5wke3PfuzckDGN4I7/Eg/ALlOZ47YsMe+AstrkzZ7kuxSgkY71jsgt
         1RrQ==
X-Gm-Message-State: AOJu0Yx0aL8opC2XGAzVhHZ1Mpu3+zeh6dgQ/Xdkmy3MImNFc5UHcYtc
	oPBMYzjMM3C/fJBoxdFrBBVNJNHkAFtUwHif7n7ZElTPx7VwS9DFwX+0p4sClqjDg7Aqz5P6bQU
	V
X-Google-Smtp-Source: AGHT+IH4OVPH3BXJOd9VAeoIOdcM/b5VeWX1WO+NoD6IFqFHdh3pg3TDocpHWjFjWOQlXpWQk2k12g==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr347050ioj.2.1712852936242;
        Thu, 11 Apr 2024 09:28:56 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bc5-20020a0566383cc500b004829ebe7aa7sm113179jab.60.2024.04.11.09.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 09:28:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------E0mhNOsBli2GYhbgdMwlqaFr"
Message-ID: <4d095453-00d6-471a-aafd-7586d94a76a7@kernel.dk>
Date: Thu, 11 Apr 2024 10:28:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: disable io-wq execution of
 multishot NOWAIT" failed to apply to 6.8-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2024040826-handbrake-five-e04e@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024040826-handbrake-five-e04e@gregkh>

This is a multi-part message in MIME format.
--------------E0mhNOsBli2GYhbgdMwlqaFr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/24 3:11 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
> git checkout FETCH_HEAD
> git cherry-pick -x bee1d5becdf5bf23d4ca0cd9c6b60bdf3c61d72b
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040826-handbrake-five-e04e@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Here's the dependency and the patch itself backported, please add for
6.8. Thanks!

-- 
Jens Axboe


--------------E0mhNOsBli2GYhbgdMwlqaFr
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-disable-io-wq-execution-of-multishot-NOWAIT.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-disable-io-wq-execution-of-multishot-NOWAIT.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA1OTg0YmI5ZTJiNzI0NTVlOGU1YTE5MjVlZGRlMzA3OWM5Zjk0OWJlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMSBBcHIgMjAyNCAxMTozMDowNiAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBpb191cmluZzogZGlzYWJsZSBpby13cSBleGVjdXRpb24gb2YgbXVsdGlzaG90IE5PV0FJ
VAogcmVxdWVzdHMKCkNvbW1pdCBiZWUxZDViZWNkZjViZjIzZDRjYTBjZDljNmI2MGJkZjNj
NjFkNzJiIHVwc3RyZWFtLgoKRG8gdGhlIHNhbWUgY2hlY2sgZm9yIGRpcmVjdCBpby13cSBl
eGVjdXRpb24gZm9yIG11bHRpc2hvdCByZXF1ZXN0cyB0aGF0CmNvbW1pdCAyYTk3NWQ0MjZj
ODIgZGlkIGZvciB0aGUgaW5saW5lIGV4ZWN1dGlvbiwgYW5kIGRpc2FibGUgbXVsdGlzaG90
Cm1vZGUgKGFuZCByZXZlcnQgdG8gc2luZ2xlIHNob3QpIGlmIHRoZSBmaWxlIHR5cGUgZG9l
c24ndCBzdXBwb3J0IE5PV0FJVCwKYW5kIGlzbid0IG9wZW5lZCBpbiBPX05PTkJMT0NLIG1v
ZGUuIEZvciBtdWx0aXNob3QgdG8gd29yayBwcm9wZXJseSwgaXQncwphIHJlcXVpcmVtZW50
IHRoYXQgbm9uYmxvY2tpbmcgcmVhZCBhdHRlbXB0cyBjYW4gYmUgZG9uZS4KCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtl
cm5lbC5kaz4KLS0tCiBpb191cmluZy9pb191cmluZy5jIHwgMTMgKysrKysrKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRl
eCA2ZmRjYjVlMDc4MDcuLjFhOWY5NmVkMjU5ZSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9f
dXJpbmcuYworKysgYi9pb191cmluZy9pb191cmluZy5jCkBAIC0xOTY0LDEwICsxOTY0LDE1
IEBAIHZvaWQgaW9fd3Ffc3VibWl0X3dvcmsoc3RydWN0IGlvX3dxX3dvcmsgKndvcmspCiAJ
CWVyciA9IC1FQkFERkQ7CiAJCWlmICghZmlsZV9jYW5fcG9sbChyZXEtPmZpbGUpKQogCQkJ
Z290byBmYWlsOwotCQllcnIgPSAtRUNBTkNFTEVEOwotCQlpZiAoaW9fYXJtX3BvbGxfaGFu
ZGxlcihyZXEsIGlzc3VlX2ZsYWdzKSAhPSBJT19BUE9MTF9PSykKLQkJCWdvdG8gZmFpbDsK
LQkJcmV0dXJuOworCQlpZiAocmVxLT5maWxlLT5mX2ZsYWdzICYgT19OT05CTE9DSyB8fAor
CQkgICAgcmVxLT5maWxlLT5mX21vZGUgJiBGTU9ERV9OT1dBSVQpIHsKKwkJCWVyciA9IC1F
Q0FOQ0VMRUQ7CisJCQlpZiAoaW9fYXJtX3BvbGxfaGFuZGxlcihyZXEsIGlzc3VlX2ZsYWdz
KSAhPSBJT19BUE9MTF9PSykKKwkJCQlnb3RvIGZhaWw7CisJCQlyZXR1cm47CisJCX0gZWxz
ZSB7CisJCQlyZXEtPmZsYWdzICY9IH5SRVFfRl9BUE9MTF9NVUxUSVNIT1Q7CisJCX0KIAl9
CiAKIAlpZiAocmVxLT5mbGFncyAmIFJFUV9GX0ZPUkNFX0FTWU5DKSB7Ci0tIAoyLjQzLjAK
Cg==
--------------E0mhNOsBli2GYhbgdMwlqaFr
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-refactor-DEFER_TASKRUN-multishot-checks.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-refactor-DEFER_TASKRUN-multishot-checks.patch"
Content-Transfer-Encoding: base64

RnJvbSA2ZmE4ZGEyNWJlNWFkMjg1ZmFlNTE1ODRjZTFkNDYxZmVjNDJiZDk0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogRnJpLCA4IE1hciAyMDI0IDEzOjU1OjU3ICswMDAwClN1YmplY3Q6
IFtQQVRDSCAxLzJdIGlvX3VyaW5nOiByZWZhY3RvciBERUZFUl9UQVNLUlVOIG11bHRpc2hv
dCBjaGVja3MKCkNvbW1pdCBlMGU0YWI1MmQxNzA5NmQ5NmMyMWE2ODA1Y2NkNDI0YjI4M2Mz
YzZkIHVwc3RyZWFtLgoKV2UgZGlzYWxsb3cgREVGRVJfVEFTS1JVTiBtdWx0aXNob3RzIGZy
b20gcnVubmluZyBieSBpby13cSwgd2hpY2ggaXMKY2hlY2tlZCBieSBpbmRpdmlkdWFsIG9w
Y29kZXMgaW4gdGhlIGlzc3VlIHBhdGguIFdlIGNhbiBjb25zb2xpZGF0ZSBhbGwKaXQgaW4g
aW9fd3Ffc3VibWl0X3dvcmsoKSBhdCB0aGUgc2FtZSB0aW1lIG1vdmluZyB0aGUgY2hlY2tz
IG91dCBvZiB0aGUKaG90IHBhdGguCgpTdWdnZXN0ZWQtYnk6IEplbnMgQXhib2UgPGF4Ym9l
QGtlcm5lbC5kaz4KU2lnbmVkLW9mZi1ieTogUGF2ZWwgQmVndW5rb3YgPGFzbWwuc2lsZW5j
ZUBnbWFpbC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvZTQ5MmYwZjEx
NTg4YmI1YWExMWQ3ZDI0ZTZmNTNiN2M3NjI4YWZkYi4xNzA5OTA1NzI3LmdpdC5hc21sLnNp
bGVuY2VAZ21haWwuY29tClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5l
bC5kaz4KLS0tCiBpb191cmluZy9pb191cmluZy5jIHwgMjAgKysrKysrKysrKysrKysrKysr
KysKIGlvX3VyaW5nL25ldC5jICAgICAgfCAyMSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGlv
X3VyaW5nL3J3LmMgICAgICAgfCAgMiAtLQogMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRp
b25zKCspLCAyMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmlu
Zy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCA1NzJlZmZkMGFmNTMuLjZmZGNiNWUw
NzgwNyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9p
b191cmluZy5jCkBAIC05NDksNiArOTQ5LDggQEAgYm9vbCBpb19maWxsX2NxZV9yZXFfYXV4
KHN0cnVjdCBpb19raW9jYiAqcmVxLCBib29sIGRlZmVyLCBzMzIgcmVzLCB1MzIgY2ZsYWdz
KQogCXU2NCB1c2VyX2RhdGEgPSByZXEtPmNxZS51c2VyX2RhdGE7CiAJc3RydWN0IGlvX3Vy
aW5nX2NxZSAqY3FlOwogCisJbG9ja2RlcF9hc3NlcnQoIWlvX3dxX2N1cnJlbnRfaXNfd29y
a2VyKCkpOworCiAJaWYgKCFkZWZlcikKIAkJcmV0dXJuIF9faW9fcG9zdF9hdXhfY3FlKGN0
eCwgdXNlcl9kYXRhLCByZXMsIGNmbGFncywgZmFsc2UpOwogCkBAIC0xOTUwLDYgKzE5NTIs
MjQgQEAgdm9pZCBpb193cV9zdWJtaXRfd29yayhzdHJ1Y3QgaW9fd3Ffd29yayAqd29yaykK
IAkJZ290byBmYWlsOwogCX0KIAorCS8qCisJICogSWYgREVGRVJfVEFTS1JVTiBpcyBzZXQs
IGl0J3Mgb25seSBhbGxvd2VkIHRvIHBvc3QgQ1FFcyBmcm9tIHRoZQorCSAqIHN1Ym1pdHRl
ciB0YXNrIGNvbnRleHQuIEZpbmFsIHJlcXVlc3QgY29tcGxldGlvbnMgYXJlIGhhbmRlZCB0
byB0aGUKKwkgKiByaWdodCBjb250ZXh0LCBob3dldmVyIHRoaXMgaXMgbm90IHRoZSBjYXNl
IG9mIGF1eGlsaWFyeSBDUUVzLAorCSAqIHdoaWNoIGlzIHRoZSBtYWluIG1lYW4gb2Ygb3Bl
cmF0aW9uIGZvciBtdWx0aXNob3QgcmVxdWVzdHMuCisJICogRG9uJ3QgYWxsb3cgYW55IG11
bHRpc2hvdCBleGVjdXRpb24gZnJvbSBpby13cS4gSXQncyBtb3JlIHJlc3RyaWN0aXZlCisJ
ICogdGhhbiBuZWNlc3NhcnkgYW5kIGFsc28gY2xlYW5lci4KKwkgKi8KKwlpZiAocmVxLT5m
bGFncyAmIFJFUV9GX0FQT0xMX01VTFRJU0hPVCkgeworCQllcnIgPSAtRUJBREZEOworCQlp
ZiAoIWZpbGVfY2FuX3BvbGwocmVxLT5maWxlKSkKKwkJCWdvdG8gZmFpbDsKKwkJZXJyID0g
LUVDQU5DRUxFRDsKKwkJaWYgKGlvX2FybV9wb2xsX2hhbmRsZXIocmVxLCBpc3N1ZV9mbGFn
cykgIT0gSU9fQVBPTExfT0spCisJCQlnb3RvIGZhaWw7CisJCXJldHVybjsKKwl9CisKIAlp
ZiAocmVxLT5mbGFncyAmIFJFUV9GX0ZPUkNFX0FTWU5DKSB7CiAJCWJvb2wgb3Bjb2RlX3Bv
bGwgPSBkZWYtPnBvbGxpbiB8fCBkZWYtPnBvbGxvdXQ7CiAKZGlmZiAtLWdpdCBhL2lvX3Vy
aW5nL25ldC5jIGIvaW9fdXJpbmcvbmV0LmMKaW5kZXggNWE0MDAxMTM5ZTI4Li42NTk0N2I5
YWZjNzEgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL25ldC5jCisrKyBiL2lvX3VyaW5nL25ldC5j
CkBAIC03OCwxOSArNzgsNiBAQCBzdHJ1Y3QgaW9fc3JfbXNnIHsKICAqLwogI2RlZmluZSBN
VUxUSVNIT1RfTUFYX1JFVFJZCTMyCiAKLXN0YXRpYyBpbmxpbmUgYm9vbCBpb19jaGVja19t
dWx0aXNob3Qoc3RydWN0IGlvX2tpb2NiICpyZXEsCi0JCQkJICAgICAgdW5zaWduZWQgaW50
IGlzc3VlX2ZsYWdzKQotewotCS8qCi0JICogV2hlbiAtPmxvY2tlZF9jcSBpcyBzZXQgd2Ug
b25seSBhbGxvdyB0byBwb3N0IENRRXMgZnJvbSB0aGUgb3JpZ2luYWwKLQkgKiB0YXNrIGNv
bnRleHQuIFVzdWFsIHJlcXVlc3QgY29tcGxldGlvbnMgd2lsbCBiZSBoYW5kbGVkIGluIG90
aGVyCi0JICogZ2VuZXJpYyBwYXRocyBidXQgbXVsdGlwb2xsIG1heSBkZWNpZGUgdG8gcG9z
dCBleHRyYSBjcWVzLgotCSAqLwotCXJldHVybiAhKGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdf
Rl9JT1dRKSB8fAotCQkhKHJlcS0+ZmxhZ3MgJiBSRVFfRl9BUE9MTF9NVUxUSVNIT1QpIHx8
Ci0JCSFyZXEtPmN0eC0+dGFza19jb21wbGV0ZTsKLX0KLQogaW50IGlvX3NodXRkb3duX3By
ZXAoc3RydWN0IGlvX2tpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBpb191cmluZ19zcWUgKnNx
ZSkKIHsKIAlzdHJ1Y3QgaW9fc2h1dGRvd24gKnNodXRkb3duID0gaW9fa2lvY2JfdG9fY21k
KHJlcSwgc3RydWN0IGlvX3NodXRkb3duKTsKQEAgLTgzNyw5ICs4MjQsNiBAQCBpbnQgaW9f
cmVjdm1zZyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdz
KQogCSAgICAoc3ItPmZsYWdzICYgSU9SSU5HX1JFQ1ZTRU5EX1BPTExfRklSU1QpKQogCQly
ZXR1cm4gaW9fc2V0dXBfYXN5bmNfbXNnKHJlcSwga21zZywgaXNzdWVfZmxhZ3MpOwogCi0J
aWYgKCFpb19jaGVja19tdWx0aXNob3QocmVxLCBpc3N1ZV9mbGFncykpCi0JCXJldHVybiBp
b19zZXR1cF9hc3luY19tc2cocmVxLCBrbXNnLCBpc3N1ZV9mbGFncyk7Ci0KIHJldHJ5X211
bHRpc2hvdDoKIAlpZiAoaW9fZG9fYnVmZmVyX3NlbGVjdChyZXEpKSB7CiAJCXZvaWQgX191
c2VyICpidWY7CkBAIC05MzUsOSArOTE5LDYgQEAgaW50IGlvX3JlY3Yoc3RydWN0IGlvX2tp
b2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAkgICAgKHNyLT5mbGFncyAm
IElPUklOR19SRUNWU0VORF9QT0xMX0ZJUlNUKSkKIAkJcmV0dXJuIC1FQUdBSU47CiAKLQlp
ZiAoIWlvX2NoZWNrX211bHRpc2hvdChyZXEsIGlzc3VlX2ZsYWdzKSkKLQkJcmV0dXJuIC1F
QUdBSU47Ci0KIAlzb2NrID0gc29ja19mcm9tX2ZpbGUocmVxLT5maWxlKTsKIAlpZiAodW5s
aWtlbHkoIXNvY2spKQogCQlyZXR1cm4gLUVOT1RTT0NLOwpAQCAtMTM4Niw4ICsxMzY3LDYg
QEAgaW50IGlvX2FjY2VwdChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlz
c3VlX2ZsYWdzKQogCXN0cnVjdCBmaWxlICpmaWxlOwogCWludCByZXQsIGZkOwogCi0JaWYg
KCFpb19jaGVja19tdWx0aXNob3QocmVxLCBpc3N1ZV9mbGFncykpCi0JCXJldHVybiAtRUFH
QUlOOwogcmV0cnk6CiAJaWYgKCFmaXhlZCkgewogCQlmZCA9IF9fZ2V0X3VudXNlZF9mZF9m
bGFncyhhY2NlcHQtPmZsYWdzLCBhY2NlcHQtPm5vZmlsZSk7CmRpZmYgLS1naXQgYS9pb191
cmluZy9ydy5jIGIvaW9fdXJpbmcvcncuYwppbmRleCBkZDZmZTNiMzI4ZjQuLmMzYzE1NDc5
MGU0NSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvcncuYworKysgYi9pb191cmluZy9ydy5jCkBA
IC05MzIsOCArOTMyLDYgQEAgaW50IGlvX3JlYWRfbXNob3Qoc3RydWN0IGlvX2tpb2NiICpy
ZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAkgKi8KIAlpZiAoIWZpbGVfY2FuX3Bv
bGwocmVxLT5maWxlKSkKIAkJcmV0dXJuIC1FQkFERkQ7Ci0JaWYgKGlzc3VlX2ZsYWdzICYg
SU9fVVJJTkdfRl9JT1dRKQotCQlyZXR1cm4gLUVBR0FJTjsKIAogCXJldCA9IF9faW9fcmVh
ZChyZXEsIGlzc3VlX2ZsYWdzKTsKIAotLSAKMi40My4wCgo=

--------------E0mhNOsBli2GYhbgdMwlqaFr--

