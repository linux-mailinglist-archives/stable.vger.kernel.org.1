Return-Path: <stable+bounces-215792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFjEIuJsjGlmngAAu9opvQ
	(envelope-from <stable+bounces-215792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:49:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E736123F46
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3297F3004D3C
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A9E30E84A;
	Wed, 11 Feb 2026 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WnKyTasJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0268460
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810587; cv=none; b=ua2wVSOPhYRFoVmTVpniKdWxRLGyLz0bKTmez4yiDXR7lXLthnVnL4GMe8wMR8YfXiURcz5BKjMZJVPU3FXYYSE9KiTIz4hQ5T60khMvHhYwQlCJ28iBOb9b6w8kBsxx1uk/uLX5N6bSIb/iaf7o/cdH39z5AhDHiyxWI8WUZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810587; c=relaxed/simple;
	bh=/10qhdazdrxunhBQBKC6OuoDepHUwEuYrIDRB1EzC9U=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=gZ3hMcnsPilbrcaN6XZEacmfbZIHLi1i67SPvppBd5SXja+Yd5SpRTX8YAcw01kvVvubFfhN9Qe7uB0drRegDBqsRfH4e+3KGeFLPlqvm7sVFp+ZBBPTDja7K7fvnC02+t+NMA5SRygNwkP/epeNPEeqilu9Pi5MQlYRvoLQEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WnKyTasJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d122733808so2148147a34.2
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 03:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770810583; x=1771415383; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Ka02HwhOXaE3+0IrENbGY3JcHxoE7z5q6/sxyHR2E=;
        b=WnKyTasJlE89ns5oqReVJ91HJwZloP+ujo+eEHqOGcVyPKH/EXYVZcs430rtehM+yQ
         H6UinezCeWuKH3D1FdvHFB8QZjuRGOCjacfum1iuY+NIm4c+f6vOEzy9XyTASY0PZaG4
         qHyE0jk7192o5l5X8O086oJkKA6SeEXbNSzLOWZDFCdw0D8KW/+J+FqCIyPq0uaU9O8n
         WqAZeKkS+VYg06sHNNrp5YCFLIZx90TA7+ke6/rlWZexMLRW3u/uDS2/hteIJH+WxQ8P
         +LZ6vbPzW3/4SywMrN/sQwaM8yl+sOfuK3bD1gS691T7J+SJGX8IJ30LrUfCPl6bEoK4
         dFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770810583; x=1771415383;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Ka02HwhOXaE3+0IrENbGY3JcHxoE7z5q6/sxyHR2E=;
        b=IIAu/KjHovyFpzN/FSvL4DV4Bxpqzt8AdBqUB5LQpQQAq8u+KcWm/s9lTWGqxXfIwS
         98x4HeCA21QHGoL5TY4u5vl/mH3FRDm/WRrEgufOtwvu4zZARvnwJ4ZOGvrktJaimeGD
         whLSxsXUgGzZQCz5n3COb29DUV02s8yUacQ6x+/PXfObr4rCpkjvUVmoFgc762YJTg/5
         mgZJiILTUrXbxpBDAn7llpoZoVFE5GpCsHO3yUKRnOPh45FsqS7f6nJcSVPa40dqWeN+
         ReMLhvKBa6wBTn1nTMIR2KqGHGUZtcjCF4yvdICFX9QwktdA9iliIkNj7lVwZvHZpSc2
         tAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7nGDasGH+6LJahV5eeO3URMWFvYCQCTDt8nwd/CxIUvgHiFelMo8f7dVoUO7zg9pVSkezpyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUTkyH7rIEdEFS7j/+oXlZ9nK3ANaLNFYvRQKFUI5uuJESR8B0
	VzPkV/0BboPapkV/6VsSaNoPjDzdbQjlSZLlvkLBKEyj8/wVTCEQ6FVhiTeRf+lsG2+4AwNzyBI
	Xje7kkHU=
X-Gm-Gg: AZuq6aKLbsBFdySifhh58bYKY4UEv5BrMBKJUkyST4qItlQlt5po3qDSyZXI3J4t/Dh
	RlPRntWeSjoPWwSyJjZ80HOS5TrUHTePJRaXbnqwEJs8i8rcvMNcDSjbACC0ZMFbXYJGPFki+Xn
	YQ96tHgwOfES/ygQRsyHeVihcwiYuGrSEvrZfzSr9pe2/JWuMQVEeZfYVLo/0k2LlawcDDSs0hl
	ur/c5SzDGBPxgv5vh7KxPyTdtigIjIMqOA2h21twVZjlLrX/mSU/9eHBIgGT7qZQclP4P+uzi7b
	l/VceuQwKAkhyGT4cQ0ACMXKpWld79v9sxyIksCV0//utsByZyA22L7zkgrNqd2Af8dSlcIlIfS
	oPxBYnapEs7NsOFowrVWe4RovtKxEjqx/bp9FOK9qKvsZnIxH2djlQnuroNQ9GWREDKwRRtFNw4
	jOQL9JcPOTxLiDuTRnqrxyvbY/GXrD87HuiOH+xBC7E21IwOfgfka9yyJl7SkW8wqfB5FzehhWp
	LXk2sc1Sw==
X-Received: by 2002:a05:6830:608b:b0:7d1:9195:a83e with SMTP id 46e09a7af769-7d4a5669db4mr1226415a34.12.1770810583566;
        Wed, 11 Feb 2026 03:49:43 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7548218sm1177522a34.9.2026.02.11.03.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 03:49:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------bsZPDqejl5l0npTTIoJKcNzl"
Message-ID: <7923dc60-dbf5-44aa-9aab-1c474cea0039@kernel.dk>
Date: Wed, 11 Feb 2026 04:49:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: 6.18-stable inclusion request
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-215792-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:mid,kernel.dk:email]
X-Rspamd-Queue-Id: 9E736123F46
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------bsZPDqejl5l0npTTIoJKcNzl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg/stable,

Can you add these two patches to the 6.18-stable queue? You can also
just cherry pick these in order:

38aa434ab9335ce2d178b7538cdf01d60b2014c3
91214661489467f8452d34edbf257488d85176e4

It's in the nice-to-have category just to be consistent with the
older/current stable release.

Thanks!

-- 
Jens Axboe


--------------bsZPDqejl5l0npTTIoJKcNzl
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-io-wq-add-exit-on-idle-state.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-io-wq-add-exit-on-idle-state.patch"
Content-Transfer-Encoding: base64

RnJvbSBlZmE5ZjE2NGU5MzQ1ZTYxM2I1MGMyMDNlYjc2MzkyMmEzZDEzMGQwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBMaSBDaGVuIDxtZUBsaW51eC5iZWF1dHk+CkRhdGU6
IE1vbiwgMiBGZWIgMjAyNiAyMjozNzo1MyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBp
b191cmluZy9pby13cTogYWRkIGV4aXQtb24taWRsZSBzdGF0ZQoKQ29tbWl0IDM4YWE0MzRh
YjkzMzVjZTJkMTc4Yjc1MzhjZGYwMWQ2MGIyMDE0YzMgdXBzdHJlYW0uCgppby13cSB1c2Vz
IGFuIGlkbGUgdGltZW91dCB0byBzaHJpbmsgdGhlIHBvb2wsIGJ1dCBrZWVwcyB0aGUgbGFz
dCB3b3JrZXIKYXJvdW5kIGluZGVmaW5pdGVseSB0byBhdm9pZCBjaHVybi4KCkZvciB0YXNr
cyB0aGF0IHVzZWQgaW9fdXJpbmcgZm9yIGZpbGUgSS9PIGFuZCB0aGVuIHN0b3AgdXNpbmcg
aW9fdXJpbmcsCnRoaXMgY2FuIGxlYXZlIGFuIGlvdS13cmstKiB0aHJlYWQgYmVoaW5kIGV2
ZW4gYWZ0ZXIgYWxsIGlvX3VyaW5nCmluc3RhbmNlcyBhcmUgZ29uZS4gVGhpcyBpcyB1bm5l
Y2Vzc2FyeSBvdmVyaGVhZCBhbmQgYWxzbyBnZXRzIGluIHRoZQp3YXkgb2YgcHJvY2VzcyBj
aGVja3BvaW50L3Jlc3RvcmUuCgpBZGQgYW4gZXhpdC1vbi1pZGxlIHN0YXRlIHRoYXQgbWFr
ZXMgYWxsIGlvLXdxIHdvcmtlcnMgZXhpdCBhcyBzb29uIGFzCnRoZXkgYmVjb21lIGlkbGUs
IGFuZCBwcm92aWRlIGlvX3dxX3NldF9leGl0X29uX2lkbGUoKSB0byB0b2dnbGUgaXQuCgpT
aWduZWQtb2ZmLWJ5OiBMaSBDaGVuIDxtZUBsaW51eC5iZWF1dHk+ClNpZ25lZC1vZmYtYnk6
IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9pby13cS5jIHwg
MjcgKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiBpb191cmluZy9pby13cS5oIHwgIDEg
KwogMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvLXdxLmMgYi9pb191cmluZy9pby13cS5jCmluZGV4
IDU2YjZhODI1Nzk1OS4uNDlhOWM5MTRiNGU5IDEwMDY0NAotLS0gYS9pb191cmluZy9pby13
cS5jCisrKyBiL2lvX3VyaW5nL2lvLXdxLmMKQEAgLTM0LDYgKzM0LDcgQEAgZW51bSB7CiAK
IGVudW0gewogCUlPX1dRX0JJVF9FWElUCQk9IDAsCS8qIHdxIGV4aXRpbmcgKi8KKwlJT19X
UV9CSVRfRVhJVF9PTl9JRExFCT0gMSwJLyogYWxsb3cgYWxsIHdvcmtlcnMgdG8gZXhpdCBv
biBpZGxlICovCiB9OwogCiBlbnVtIHsKQEAgLTcwNiw5ICs3MDcsMTMgQEAgc3RhdGljIGlu
dCBpb193cV93b3JrZXIodm9pZCAqZGF0YSkKIAkJcmF3X3NwaW5fbG9jaygmYWNjdC0+d29y
a2Vyc19sb2NrKTsKIAkJLyoKIAkJICogTGFzdCBzbGVlcCB0aW1lZCBvdXQuIEV4aXQgaWYg
d2UncmUgbm90IHRoZSBsYXN0IHdvcmtlciwKLQkJICogb3IgaWYgc29tZW9uZSBtb2RpZmll
ZCBvdXIgYWZmaW5pdHkuCisJCSAqIG9yIGlmIHNvbWVvbmUgbW9kaWZpZWQgb3VyIGFmZmlu
aXR5LiBJZiB3cSBpcyBtYXJrZWQKKwkJICogaWRsZS1leGl0LCBkcm9wIHRoZSB3b3JrZXIg
YXMgd2VsbC4gVGhpcyBpcyB1c2VkIHRvIGF2b2lkCisJCSAqIGtlZXBpbmcgaW8td3Egd29y
a2VycyBhcm91bmQgZm9yIHRhc2tzIHRoYXQgbm8gbG9uZ2VyIGhhdmUKKwkJICogYW55IGFj
dGl2ZSBpb191cmluZyBpbnN0YW5jZXMuCiAJCSAqLwotCQlpZiAobGFzdF90aW1lb3V0ICYm
IChleGl0X21hc2sgfHwgYWNjdC0+bnJfd29ya2VycyA+IDEpKSB7CisJCWlmICgobGFzdF90
aW1lb3V0ICYmIChleGl0X21hc2sgfHwgYWNjdC0+bnJfd29ya2VycyA+IDEpKSB8fAorCQkg
ICAgdGVzdF9iaXQoSU9fV1FfQklUX0VYSVRfT05fSURMRSwgJndxLT5zdGF0ZSkpIHsKIAkJ
CWFjY3QtPm5yX3dvcmtlcnMtLTsKIAkJCXJhd19zcGluX3VubG9jaygmYWNjdC0+d29ya2Vy
c19sb2NrKTsKIAkJCV9fc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19SVU5OSU5HKTsKQEAgLTk2
NSw2ICs5NzAsMjQgQEAgc3RhdGljIGJvb2wgaW9fd3Ffd29ya2VyX3dha2Uoc3RydWN0IGlv
X3dvcmtlciAqd29ya2VyLCB2b2lkICpkYXRhKQogCXJldHVybiBmYWxzZTsKIH0KIAordm9p
ZCBpb193cV9zZXRfZXhpdF9vbl9pZGxlKHN0cnVjdCBpb193cSAqd3EsIGJvb2wgZW5hYmxl
KQoreworCWlmICghd3EtPnRhc2spCisJCXJldHVybjsKKworCWlmICghZW5hYmxlKSB7CisJ
CWNsZWFyX2JpdChJT19XUV9CSVRfRVhJVF9PTl9JRExFLCAmd3EtPnN0YXRlKTsKKwkJcmV0
dXJuOworCX0KKworCWlmICh0ZXN0X2FuZF9zZXRfYml0KElPX1dRX0JJVF9FWElUX09OX0lE
TEUsICZ3cS0+c3RhdGUpKQorCQlyZXR1cm47CisKKwlyY3VfcmVhZF9sb2NrKCk7CisJaW9f
d3FfZm9yX2VhY2hfd29ya2VyKHdxLCBpb193cV93b3JrZXJfd2FrZSwgTlVMTCk7CisJcmN1
X3JlYWRfdW5sb2NrKCk7Cit9CisKIHN0YXRpYyB2b2lkIGlvX3J1bl9jYW5jZWwoc3RydWN0
IGlvX3dxX3dvcmsgKndvcmssIHN0cnVjdCBpb193cSAqd3EpCiB7CiAJZG8gewpkaWZmIC0t
Z2l0IGEvaW9fdXJpbmcvaW8td3EuaCBiL2lvX3VyaW5nL2lvLXdxLmgKaW5kZXggNzc0YWJh
YjU0NzMyLi45NGIxNDc0MmI3MDMgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvLXdxLmgKKysr
IGIvaW9fdXJpbmcvaW8td3EuaApAQCAtNDEsNiArNDEsNyBAQCBzdHJ1Y3QgaW9fd3FfZGF0
YSB7CiBzdHJ1Y3QgaW9fd3EgKmlvX3dxX2NyZWF0ZSh1bnNpZ25lZCBib3VuZGVkLCBzdHJ1
Y3QgaW9fd3FfZGF0YSAqZGF0YSk7CiB2b2lkIGlvX3dxX2V4aXRfc3RhcnQoc3RydWN0IGlv
X3dxICp3cSk7CiB2b2lkIGlvX3dxX3B1dF9hbmRfZXhpdChzdHJ1Y3QgaW9fd3EgKndxKTsK
K3ZvaWQgaW9fd3Ffc2V0X2V4aXRfb25faWRsZShzdHJ1Y3QgaW9fd3EgKndxLCBib29sIGVu
YWJsZSk7CiAKIHZvaWQgaW9fd3FfZW5xdWV1ZShzdHJ1Y3QgaW9fd3EgKndxLCBzdHJ1Y3Qg
aW9fd3Ffd29yayAqd29yayk7CiB2b2lkIGlvX3dxX2hhc2hfd29yayhzdHJ1Y3QgaW9fd3Ff
d29yayAqd29yaywgdm9pZCAqdmFsKTsKLS0gCjIuNTEuMAoK
--------------bsZPDqejl5l0npTTIoJKcNzl
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-allow-io-wq-workers-to-exit-when-unused.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-allow-io-wq-workers-to-exit-when-unused.patch"
Content-Transfer-Encoding: base64

RnJvbSA2ODA5YWQ4NzJkZjlmNzQ2ZjczN2FiNzYyZWU3MmYxZDlhNjkyYzFkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBMaSBDaGVuIDxtZUBsaW51eC5iZWF1dHk+CkRhdGU6
IE1vbiwgMiBGZWIgMjAyNiAyMjozNzo1NCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBp
b191cmluZzogYWxsb3cgaW8td3Egd29ya2VycyB0byBleGl0IHdoZW4gdW51c2VkCgpDb21t
aXQgOTEyMTQ2NjE0ODk0NjdmODQ1MmQzNGVkYmYyNTc0ODhkODUxNzZlNCB1cHN0cmVhbS4K
CmlvX3VyaW5nIGtlZXBzIGEgcGVyLXRhc2sgaW8td3EgYXJvdW5kLCBldmVuIHdoZW4gdGhl
IHRhc2sgbm8gbG9uZ2VyIGhhcwphbnkgaW9fdXJpbmcgaW5zdGFuY2VzLgoKSWYgdGhlIHRh
c2sgcHJldmlvdXNseSB1c2VkIGlvX3VyaW5nIGZvciBmaWxlIEkvTywgdGhpcyBjYW4gbGVh
dmUgYW4KdW5yZWxhdGVkIGlvdS13cmstKiB3b3JrZXIgdGhyZWFkIGJlaGluZCBhZnRlciB0
aGUgbGFzdCBpb191cmluZwppbnN0YW5jZSBpcyBnb25lLgoKV2hlbiB0aGUgbGFzdCBpb191
cmluZyBjdHggaXMgcmVtb3ZlZCBmcm9tIHRoZSB0YXNrIGNvbnRleHQsIG1hcmsgdGhlCmlv
LXdxIGV4aXQtb24taWRsZSBzbyB3b3JrZXJzIGNhbiBnbyBhd2F5LiBDbGVhciB0aGUgZmxh
ZyBvbiBzdWJzZXF1ZW50CmlvX3VyaW5nIHVzYWdlLgoKU2lnbmVkLW9mZi1ieTogTGkgQ2hl
biA8bWVAbGludXguYmVhdXR5PgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBr
ZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvdGN0eC5jIHwgMTEgKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvdGN0
eC5jIGIvaW9fdXJpbmcvdGN0eC5jCmluZGV4IDViNjY3NTU1NzljMC4uMDNjMjc4YWE1ODEy
IDEwMDY0NAotLS0gYS9pb191cmluZy90Y3R4LmMKKysrIGIvaW9fdXJpbmcvdGN0eC5jCkBA
IC0xMjIsNiArMTIyLDE0IEBAIGludCBfX2lvX3VyaW5nX2FkZF90Y3R4X25vZGUoc3RydWN0
IGlvX3JpbmdfY3R4ICpjdHgpCiAJCQkJcmV0dXJuIHJldDsKIAkJfQogCX0KKworCS8qCisJ
ICogUmUtYWN0aXZhdGUgaW8td3Ega2VlcGFsaXZlIG9uIGFueSBuZXcgaW9fdXJpbmcgdXNh
Z2UuIFRoZSB3cSBtYXkgaGF2ZQorCSAqIGJlZW4gbWFya2VkIGZvciBpZGxlLWV4aXQgd2hl
biB0aGUgdGFzayB0ZW1wb3JhcmlseSBoYWQgbm8gYWN0aXZlCisJICogaW9fdXJpbmcgaW5z
dGFuY2VzLgorCSAqLworCWlmICh0Y3R4LT5pb193cSkKKwkJaW9fd3Ffc2V0X2V4aXRfb25f
aWRsZSh0Y3R4LT5pb193cSwgZmFsc2UpOwogCWlmICgheGFfbG9hZCgmdGN0eC0+eGEsICh1
bnNpZ25lZCBsb25nKWN0eCkpIHsKIAkJbm9kZSA9IGttYWxsb2Moc2l6ZW9mKCpub2RlKSwg
R0ZQX0tFUk5FTCk7CiAJCWlmICghbm9kZSkKQEAgLTE4Myw2ICsxOTEsOSBAQCBfX2NvbGQg
dm9pZCBpb191cmluZ19kZWxfdGN0eF9ub2RlKHVuc2lnbmVkIGxvbmcgaW5kZXgpCiAJaWYg
KHRjdHgtPmxhc3QgPT0gbm9kZS0+Y3R4KQogCQl0Y3R4LT5sYXN0ID0gTlVMTDsKIAlrZnJl
ZShub2RlKTsKKworCWlmICh4YV9lbXB0eSgmdGN0eC0+eGEpICYmIHRjdHgtPmlvX3dxKQor
CQlpb193cV9zZXRfZXhpdF9vbl9pZGxlKHRjdHgtPmlvX3dxLCB0cnVlKTsKIH0KIAogX19j
b2xkIHZvaWQgaW9fdXJpbmdfY2xlYW5fdGN0eChzdHJ1Y3QgaW9fdXJpbmdfdGFzayAqdGN0
eCkKLS0gCjIuNTEuMAoK

--------------bsZPDqejl5l0npTTIoJKcNzl--

