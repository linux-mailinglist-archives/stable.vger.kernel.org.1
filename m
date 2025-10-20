Return-Path: <stable+bounces-188038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A88BF0CC0
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC9D3B1C01
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1C254876;
	Mon, 20 Oct 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LWgd8WHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AE25F784
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959241; cv=none; b=SArEhbhTdpRHf1t+NeDsBWnmUyYYuANDyNNvGW3Caw+tVAktdP+Uu/G3ke4fg7t+ox3Vz1LnE4vOl+XRhhAYQaPg0l4gSZYo/iCrdUCgef7K3Q24qHM5pBySkvDnkb5cWAJaNpxAGlJ3NfEDK8HZLafo8gShpDp5Sh9IPAFUat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959241; c=relaxed/simple;
	bh=g/f5fMy8JyOg0RhizGsl+Ve9xG1KaBjZKdRWOBxf8cc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=X1y8VZTo4rG9qrKWKKX4NmE4oQK7cCQIcK0bv96LJC4gH9zQD8XI89+NRCPWy/1yvvwa/BTE05zKM7wd1CSWroghYWsSsuww5GvCSXXWB4gLaVirnAAhGwdI1mSgNjYOBd8/kqp2t50bE+WSDIOFAM0QqAxyZv5VKTFCEZuvvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LWgd8WHI; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso409444439f.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760959236; x=1761564036; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=str1EkCrnpdq0hhhL19u70Ykh19+04/xuPSXvej+dIQ=;
        b=LWgd8WHIXQ/925sRt8+RJjJcAfd+lf4uIZ/H6yzpo3K3oF048YpeM60KO/ZoJcfnfE
         zP6dVPJnFwCdNsw5ihtkKFY1r5DUnTF2TSVYu//fkvOhcUDoPnQL7+6lvhPd8ZZGS2cd
         PJHeYlkeshVEd8EaRkc2qFSGnKcN2p7mQxUoxltzcckmpgdSsex6L+6iUtpDujGcxwzl
         qPmbpJXvxR/Xe2BlybonzDDS+cgYE3sXEPeCTBCjQ4jAJtfOGekzvyyzvpqP065/RJi8
         rJQoA2uANoMoLgsPHyXoEicFQuhfeRlYE2hE51VDsg0dAR1UZPvYbQuJJWMoeuR3pogv
         ubQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959236; x=1761564036;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=str1EkCrnpdq0hhhL19u70Ykh19+04/xuPSXvej+dIQ=;
        b=JrdxNFNuJEOXekEes1PKUla0vSw/Ao/EBvfHgnSmeJE2bguixP0Ke5t29/+QUOnIa8
         bs7+BcSC+FCNEz2JJZ30rzAMz2fDxVAfN+mimSeC+nYW+Z6w2DQo0gAJt87KixVfAR3F
         no5nn/BivNwYO1HByUHB80fhXfUgGxhowZgjivw16bs+AzoBqzjJ0Lpy8xIDA8yUqH0E
         8cBvTav/xOZy+VJgBYp7OxfBSB0VMOwrTsu9o0LHPayuSSpL/R0TxJpRHRJRPLruJ6Fe
         N4MxNvmSrevggDfKcXhhQ9iuQJ6Xyp8rFnvVQWkjjGvhJoLSeuYTlQkaxvCVHBdZF95x
         8N4A==
X-Gm-Message-State: AOJu0YxSMnKIQ1lXIwQrdmHaorbHFE6l3M+rQmsUbKzAUYTna3++/UIs
	hCbBM9lPrWAjPxIF8r4M+r58D5VUWBqIVfhJKIN8FMbu+8wo6joyrtQihfhq7vwheSc=
X-Gm-Gg: ASbGncvUsPlmj4D8mLPu2vhJMX4bnIJKyS0dPpmQvbp2PKBCh6AtP5BfK0e04s73MI8
	Xmy6D2evijZvBRSCl1mt6xV94rW+CnPH62dbJxbpwRFxTwDfGacEntH8D1LxplcRe+WrNz77si3
	Ni+La2nctASXMmGn032eDKMNsBSt2Cj+/TCtpMWjFh6Q2v45+6NCRk0qtCEKATldcrGtnndpeGI
	zid6Hcg/0MB6fzSZef+Yv/lFX8Kb6dAZZ1KFmh5AxLbyw0JQUGSYM5u0ssin7x7VAJvDoMgqDhi
	G7hNufiMujJ8OZFl03asczKDDt8KNPjl0PCnV3A+d7SZiNgpVz3bgZdn0ONfy56Zo4oetKl0ng6
	qOfwM0TH0iCiA6x893ZZn/Imk0V2faItNSHp86R4JfdYzAW0rs+0xaQaKyqWfo2wnpua3qTxn7P
	sQ6MwoPd12XYjC+oHnZz4=
X-Google-Smtp-Source: AGHT+IEKiPZpYoO/mUacuu0wMGWElJWw8mA9vziZskUf/vSi9bXKyezpHo0C0fOEak/H+X6xwV+H6w==
X-Received: by 2002:a05:6602:360a:b0:940:d9b2:f959 with SMTP id ca18e2360f4ac-940d9b3138dmr468116639f.14.1760959236351;
        Mon, 20 Oct 2025 04:20:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a962f04fsm2821970173.21.2025.10.20.04.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 04:20:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------yR1lIHAvF20wPE1EasVvbAWy"
Message-ID: <6d07f9bb-5c73-4e17-8292-927257867c83@kernel.dk>
Date: Mon, 20 Oct 2025 05:20:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] Revert "io_uring/rw: drop -EOPNOTSUPP
 check in" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, carnil@debian.org, kevin@xf.ee
Cc: stable@vger.kernel.org
References: <2025102039-bonelike-vocation-0372@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025102039-bonelike-vocation-0372@gregkh>

This is a multi-part message in MIME format.
--------------yR1lIHAvF20wPE1EasVvbAWy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 2:00 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Easy fixup, here's one for 6.12-stable.

-- 
Jens Axboe

--------------yR1lIHAvF20wPE1EasVvbAWy
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Revert-io_uring-rw-drop-EOPNOTSUPP-check-in-__io_com.patch"
Content-Disposition: attachment;
 filename*0="0001-Revert-io_uring-rw-drop-EOPNOTSUPP-check-in-__io_com.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlYWZmYTJmNmFmZmJhMWM0YjkxZDNhNzViNmU2ZDllMzFhZGM1YTI2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMTMgT2N0IDIwMjUgMTI6MDU6MzEgLTA2MDAKU3ViamVjdDogW1BBVENIXSBS
ZXZlcnQgImlvX3VyaW5nL3J3OiBkcm9wIC1FT1BOT1RTVVBQIGNoZWNrIGluCiBfX2lvX2Nv
bXBsZXRlX3J3X2NvbW1vbigpIgoKQ29tbWl0IDkyNzA2OWM0YWMyY2QxYTM3ZWZhNDY4NTk2
ZmI1YjhmODZkYjlkZjAgdXBzdHJlYW0uCgpUaGlzIHJldmVydHMgY29tbWl0IDkwYmZiMjhk
NWZhODEyN2ExMTNhMTQwYzk3OTFlYTBiNDBhYjE1NmEuCgpLZXZpbiByZXBvcnRzIHRoYXQg
dGhpcyBjb21taXQgY2F1c2VzIGFuIGlzc3VlIGZvciBoaW0gd2l0aCBMVk0Kc25hcHNob3Rz
LCBtb3N0IGxpa2VseSBiZWNhdXNlIG9mIHR1cm5pbmcgb2ZmIE5PV0FJVCBzdXBwb3J0IHdo
aWxlIGEKc25hcHNob3QgaXMgYmVpbmcgY3JlYXRlZC4gVGhpcyBtYWtlcyAtRU9QTk9UU1VQ
UCBidWJibGUgYmFjayB0aHJvdWdoCnRoZSBjb21wbGV0aW9uIGhhbmRsZXIsIHdoZXJlIGlv
X3VyaW5nIHJlYWQvd3JpdGUgaGFuZGxpbmcgc2hvdWxkIGp1c3QKcmV0cnkgaXQuCgpSZWlu
c3RhdGUgdGhlIHByZXZpb3VzIGNoZWNrIHJlbW92ZWQgYnkgdGhlIHJlZmVyZW5jZWQgY29t
bWl0LgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDkwYmZiMjhkNWZhOCAo
ImlvX3VyaW5nL3J3OiBkcm9wIC1FT1BOT1RTVVBQIGNoZWNrIGluIF9faW9fY29tcGxldGVf
cndfY29tbW9uKCkiKQpSZXBvcnRlZC1ieTogU2FsdmF0b3JlIEJvbmFjY29yc28gPGNhcm5p
bEBkZWJpYW4ub3JnPgpSZXBvcnRlZC1ieTogS2V2aW4gTHVtaWsgPGtldmluQHhmLmVlPgpM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9pby11cmluZy9jY2ViNzIzYy0wNTFiLTRk
ZTItOWE0Yy00YWE4MmUxNjE5ZWVAa2VybmVsLmRrLwpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4
Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvcncuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2lvX3VyaW5nL3J3LmMgYi9pb191cmluZy9ydy5jCmluZGV4IDNhZDEwNGNmMWU3ZC4uOTk2
Y2Q0YmVjNDgyIDEwMDY0NAotLS0gYS9pb191cmluZy9ydy5jCisrKyBiL2lvX3VyaW5nL3J3
LmMKQEAgLTQ3Nyw3ICs0NzcsNyBAQCBzdGF0aWMgdm9pZCBpb19yZXFfaW9fZW5kKHN0cnVj
dCBpb19raW9jYiAqcmVxKQogc3RhdGljIGJvb2wgX19pb19jb21wbGV0ZV9yd19jb21tb24o
c3RydWN0IGlvX2tpb2NiICpyZXEsIGxvbmcgcmVzKQogewogCWlmICh1bmxpa2VseShyZXMg
IT0gcmVxLT5jcWUucmVzKSkgewotCQlpZiAocmVzID09IC1FQUdBSU4gJiYgaW9fcndfc2hv
dWxkX3JlaXNzdWUocmVxKSkgeworCQlpZiAoKHJlcyA9PSAtRU9QTk9UU1VQUCB8fCByZXMg
PT0gLUVBR0FJTikgJiYgaW9fcndfc2hvdWxkX3JlaXNzdWUocmVxKSkgewogCQkJLyoKIAkJ
CSAqIFJlaXNzdWUgd2lsbCBzdGFydCBhY2NvdW50aW5nIGFnYWluLCBmaW5pc2ggdGhlCiAJ
CQkgKiBjdXJyZW50IGN5Y2xlLgotLSAKMi41MS4wCgo=

--------------yR1lIHAvF20wPE1EasVvbAWy--

