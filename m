Return-Path: <stable+bounces-223095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AwUAD5nqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:09:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55D204E58
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6539C30E253A
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CD9372677;
	Wed,  4 Mar 2026 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HesX66V6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1F376BC4
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643327; cv=none; b=jj8wDYyJWCzoJ74yog5cLdot9De5vMZVGk5Z7qzKz51J4ZCBQ2nMgQSO8jCeeX1G4f+hrbU3R8DGVgEJlfLgm+7Yjm5wylxzy7QtrDirItUarqlvjea+wriqVeYhaqkpu9XA0R8Q5p6D7CNjPCH23S28B7tNemJ3tDy4NeWWA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643327; c=relaxed/simple;
	bh=JnP3OQwNbiKBS2Iy0zKDJ4D1uDkaqwZIC5pDpYOb4z4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=LPAq01bdJU6Ye+7pTcG/w6wCTB1CguFE6mTirdbisf5rYveCr0LHQbnH7lYoQPgoxqFUStWEM4EgfyyeGLzbjMeS4jfR8ZhVJR1P0blVLP+KtFFANxPnY6tSkbXutL4ijMyFY07FfljnBdjQJgwOEPp9gnBeaW1A+kxgPxJ9ruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HesX66V6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9b1900bso2517512f8f.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643324; x=1773248124; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnP3OQwNbiKBS2Iy0zKDJ4D1uDkaqwZIC5pDpYOb4z4=;
        b=HesX66V6zBVwGBb44MtW8r62OI7xEfyOgmpFXLfCGUfjGtlXmll2MkXboS5BShdeMk
         gbbyxf8768iDim8jin+nKhT17UlbN/c0OkDLMpl4Ek8UjLCsuDtlANnhMTDiRvyGrp35
         Zq14Lar6+ai1679zUINLHOsMmcOh0bnKbl5pCZ5GOIJb5ySOBsA7O2nQBRiFFlZt4h/x
         XKErx8cCSt2Gs+6BhlhhHf1x6zbc1tjC5QEx8O0gU0+iDk0LWg0ODBkEmzRdAox2xSX9
         tUZFgz985vK6TQHBhwE202FXqUhHZvqxsCIpI2jrJXSYqgCO59dfLI5ZWaUY89QuDh9W
         jOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643324; x=1773248124;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnP3OQwNbiKBS2Iy0zKDJ4D1uDkaqwZIC5pDpYOb4z4=;
        b=pc4fxNSi3q+otF7GY6Jaqcv6SL11FOETyitLUqJuT+MCJd0OPsdpsm1l66bGzq1Ie3
         3Y43IDIj4f+9Jlmp/irzDb6KxRLXHhaM1s8LdyOJcNGJuXSxshGObg6+Z+D3VAgq7Tmc
         f/KjlclBmqnIt0dzc/xYZs77QOXF8zi4q84OHKnHt1glnUGFSX4PQARspIR8gNzDXLE0
         46QUWpkYueFsT97Rgnfb9DgcS/Clk1Aat+AjV3WeoH9YKcGNzYF2LepWesCZ3D/rJCCI
         HtkU4i9tMYjg12l9G959iOg1xFkO5b2nRY9ahx4b1I1m1gqbthLjrspHPO31gRlfig2m
         58FQ==
X-Gm-Message-State: AOJu0Yyw5qE8jIxtfnIgIC2Xl3XVEiRg+UWjn6FQPeFrgBOk9UJbBmji
	WOy0dYsLZnhOmqoi5/n2pd7RMBn4pIrB32uVl2vh9jFYqDGqh1rPz2k+cQk6MF10fRY=
X-Gm-Gg: ATEYQzwE+R+lcuXIkckeKiYoTJiK+g3ifUjp7SGQ59d6/R+mvM848QsmrD3M3RUh+Mg
	zlNxY5N3qkhIC7F4uofllsSmS6ujeYQ5yhe8XG5cr2HNjCJRt+2vCGIgQQxO/UV6q9uRKlpkMEj
	xUqyPF1hWD3X8+Gi7jiIsgDZaGil1e2hBWLRqi/HeBbjwRSHZh5dwU0cLQaKFf4plYkgbQ1xbn6
	6KexSXPUCogR0Sb7oAbLXxqgfWKudN86psUT0OHw+eTPpAjNtKxpckUjPP2WkGBxUadSaTYncWC
	Mer7bMSSHx/Y8hsZNsyC/vHJvkjjXE58Cf15Ry3EmUCnEHfKOi+8CffapRkTv47YKdErc6BTZJ+
	0D2k/6AvfdROz3sDIv+JnEb/VEk5hJ90+kyDa0qobAbTGGo7y30V5CzBJUPluxmrn/WAyXoCr5O
	/2xoWvgiaqdLwmntSTT5FXFH7/xmZ89rLx9RzGJh8MizY/hQ5YvB0uO/S+ipOK1JcWvEJc+QM5C
	oXYu1AfRqI=
X-Received: by 2002:a05:6000:609:b0:439:af25:e4ea with SMTP id ffacd0b85a97d-439c7fb73b9mr5110253f8f.25.1772643324338;
        Wed, 04 Mar 2026 08:55:24 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b4175fd2sm28647664f8f.14.2026.03.04.08.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:55:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Natarajan KV <natarajankv91@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de
Subject: [PATCH v3 6.6.y 6/8] netfilter: nft_set_pipapo: prepare pipapo_get
 helper for on-demand clone
Message-ID: <1772643278.pipapo-v3.6@gmail.com>
Date: Wed, 04 Mar 2026 20:55:20 +0400
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh> <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: 6C55D204E58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223095-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natarajankv91@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:email,strlen.de:email]
X-Rspamd-Action: no action

QWRhcHRhdGlvbiBvZiBjb21taXQgYTIzODEwNjcwM2FiICgibmV0ZmlsdGVyOiBuZnRfc2V0X3Bp
cGFwbzogcHJlcGFyZQpwaXBhcG9fZ2V0IGhlbHBlciBmb3Igb24tZGVtYW5kIGNsb25lIikgdG8g
Ni42LjEyMi4KClBhc3MgdGhlIG1hdGNoIGRhdGEgdG8gcGlwYXBvX2dldCgpIGluc3RlYWQgb2Yg
aGF2aW5nIGl0IGFjY2Vzcwpwcml2LT5jbG9uZSB1bmNvbmRpdGlvbmFsbHkuCgpuZnRfcGlwYXBv
X2dldCgpIHBhc3NlcyByY3VfZGVyZWZlcmVuY2UocHJpdi0+bWF0Y2gpIHRvIGdldApjb21taXR0
ZWQgZGF0YSwgbmZ0X3BpcGFwb19kZWFjdGl2YXRlKCkgcGFzc2VzIHByaXYtPmNsb25lLgpuZnRf
cGlwYXBvX2luc2VydCgpIHBhc3NlcyBtICh3aGljaCBpcyBwcml2LT5jbG9uZSkuCgpJbiA2LjYu
MTIyIHBpcGFwb19nZXQoKSBoYXMgbm8gR0ZQIHBhcmFtZXRlciAoYWx3YXlzIEdGUF9BVE9NSUMp
LAphbmQgcGlwYXBvX2RlYWN0aXZhdGUoKSBoZWxwZXIgaXMga2VwdCBmb3IgbmZ0X3BpcGFwb19m
bHVzaCgpLgoKU2lnbmVkLW9mZi1ieTogRmxvcmlhbiBXZXN0cGhhbCA8ZndAc3RybGVuLmRlPgpS
ZXZpZXdlZC1ieTogU3RlZmFubyBCcml2aW8gPHNicml2aW9AcmVkaGF0LmNvbT4KU2lnbmVkLW9m
Zi1ieTogUGFibG8gTmVpcmEgQXl1c28gPHBhYmxvQG5ldGZpbHRlci5vcmc+ClNpZ25lZC1vZmYt
Ynk6IE5hdGFyYWphbiBLViA8bmF0YXJhamFua3Y5MUBnbWFpbC5jb20+Ci0tLQogbmV0L25ldGZp
bHRlci9uZnRfc2V0X3BpcGFwby5jIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5jIGIvbmV0L25ldGZpbHRlci9uZnRfc2V0
X3BpcGFwby5jCmluZGV4IGNiNjA1M2Y5NmU4Ny4uMTc2ZjFhODk1NmE5IDEwMDY0NAotLS0gYS9u
ZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvLmMKKysrIGIvbmV0L25ldGZpbHRlci9uZnRfc2V0
X3BpcGFwby5jCkBAIC01MDAsOCArNTAwLDcgQEAgYm9vbCBuZnRfcGlwYXBvX2xvb2t1cChjb25z
dCBzdHJ1Y3QgbmV0ICpuZXQsIGNvbnN0IHN0cnVjdCBuZnRfc2V0ICpzZXQsCiAKIC8qKgogICog
cGlwYXBvX2dldCgpIC0gR2V0IG1hdGNoaW5nIGVsZW1lbnQgcmVmZXJlbmNlIGdpdmVuIGtleSBk
YXRhCi0gKiBAbmV0OglOZXR3b3JrIG5hbWVzcGFjZQotICogQHNldDoJbmZ0YWJsZXMgQVBJIHNl
dCByZXByZXNlbnRhdGlvbgorICogQG06CQlNYXRjaGluZyBkYXRhCiAgKiBAZGF0YToJS2V5IGRh
dGEgdG8gYmUgbWF0Y2hlZCBhZ2FpbnN0IGV4aXN0aW5nIGVsZW1lbnRzCiAgKiBAZ2VubWFzazoJ
SWYgc2V0LCBjaGVjayB0aGF0IGVsZW1lbnQgaXMgYWN0aXZlIGluIGdpdmVuIGdlbm1hc2sKICAq
IEB0c3RhbXA6CXRpbWVzdGFtcCB0byBjaGVjayBmb3IgZXhwaXJlZCBlbGVtZW50cwpAQCAtNTEy
LDIwICs1MTEsMTUgQEAgYm9vbCBuZnRfcGlwYXBvX2xvb2t1cChjb25zdCBzdHJ1Y3QgbmV0ICpu
ZXQsIGNvbnN0IHN0cnVjdCBuZnRfc2V0ICpzZXQsCiAgKgogICogUmV0dXJuOiBwb2ludGVyIHRv
ICZzdHJ1Y3QgbmZ0X3BpcGFwb19lbGVtIG9uIG1hdGNoLCBlcnJvciBwb2ludGVyIG90aGVyd2lz
ZS4KICAqLwotc3RhdGljIHN0cnVjdCBuZnRfcGlwYXBvX2VsZW0gKnBpcGFwb19nZXQoY29uc3Qg
c3RydWN0IG5ldCAqbmV0LAotCQkJCQkgIGNvbnN0IHN0cnVjdCBuZnRfc2V0ICpzZXQsCitzdGF0
aWMgc3RydWN0IG5mdF9waXBhcG9fZWxlbSAqcGlwYXBvX2dldChjb25zdCBzdHJ1Y3QgbmZ0X3Bp
cGFwb19tYXRjaCAqbSwKIAkJCQkJICBjb25zdCB1OCAqZGF0YSwgdTggZ2VubWFzaywKIAkJCQkJ
ICB1NjQgdHN0YW1wKQogewogCXN0cnVjdCBuZnRfcGlwYXBvX2VsZW0gKnJldCA9IEVSUl9QVFIo
LUVOT0VOVCk7Ci0Jc3RydWN0IG5mdF9waXBhcG8gKnByaXYgPSBuZnRfc2V0X3ByaXYoc2V0KTsK
IAl1bnNpZ25lZCBsb25nICpyZXNfbWFwLCAqZmlsbF9tYXAgPSBOVUxMOwotCWNvbnN0IHN0cnVj
dCBuZnRfcGlwYXBvX21hdGNoICptOwogCWNvbnN0IHN0cnVjdCBuZnRfcGlwYXBvX2ZpZWxkICpm
OwogCWludCBpOwogCi0JbSA9IHByaXYtPmNsb25lOwotCiAJcmVzX21hcCA9IGttYWxsb2NfYXJy
YXkobS0+YnNpemVfbWF4LCBzaXplb2YoKnJlc19tYXApLCBHRlBfQVRPTUlDKTsKIAlpZiAoIXJl
c19tYXApIHsKIAkJcmV0ID0gRVJSX1BUUigtRU5PTUVNKTsKQEAgLTYwNiw3ICs2MDAsMTIgQEAg
c3RhdGljIHN0cnVjdCBuZnRfcGlwYXBvX2VsZW0gKnBpcGFwb19nZXQoY29uc3Qgc3RydWN0IG5l
dCAqbmV0LAogc3RhdGljIHZvaWQgKm5mdF9waXBhcG9fZ2V0KGNvbnN0IHN0cnVjdCBuZXQgKm5l
dCwgY29uc3Qgc3RydWN0IG5mdF9zZXQgKnNldCwKIAkJCSAgICBjb25zdCBzdHJ1Y3QgbmZ0X3Nl
dF9lbGVtICplbGVtLCB1bnNpZ25lZCBpbnQgZmxhZ3MpCiB7Ci0JcmV0dXJuIHBpcGFwb19nZXQo
bmV0LCBzZXQsIChjb25zdCB1OCAqKWVsZW0tPmtleS52YWwuZGF0YSwKKwlzdHJ1Y3QgbmZ0X3Bp
cGFwbyAqcHJpdiA9IG5mdF9zZXRfcHJpdihzZXQpOworCWNvbnN0IHN0cnVjdCBuZnRfcGlwYXBv
X21hdGNoICptOworCisJbSA9IHJjdV9kZXJlZmVyZW5jZV9jaGVjayhwcml2LT5tYXRjaCwKKwkJ
CQkgIGxvY2tkZXBfaXNfaGVsZCgmbmZ0X3Blcm5ldChyZWFkX3BuZXQoJnNldC0+bmV0KSktPmNv
bW1pdF9tdXRleCkpOworCXJldHVybiBwaXBhcG9fZ2V0KG0sIChjb25zdCB1OCAqKWVsZW0tPmtl
eS52YWwuZGF0YSwKIAkJCSBuZnRfZ2VubWFza19jdXIobmV0KSwgZ2V0X2ppZmZpZXNfNjQoKSk7
CiB9CiAKQEAgLTEyMjIsNyArMTIyMSw3IEBAIHN0YXRpYyBpbnQgbmZ0X3BpcGFwb19pbnNlcnQo
Y29uc3Qgc3RydWN0IG5ldCAqbmV0LCBjb25zdCBzdHJ1Y3QgbmZ0X3NldCAqc2V0LAogCWVsc2UK
IAkJZW5kID0gc3RhcnQ7CiAKLQlkdXAgPSBwaXBhcG9fZ2V0KG5ldCwgc2V0LCBzdGFydCwgZ2Vu
bWFzaywgdHN0YW1wKTsKKwlkdXAgPSBwaXBhcG9fZ2V0KG0sIHN0YXJ0LCBnZW5tYXNrLCB0c3Rh
bXApOwogCWlmICghSVNfRVJSKGR1cCkpIHsKIAkJLyogQ2hlY2sgaWYgd2UgYWxyZWFkeSBoYXZl
IHRoZSBzYW1lIGV4YWN0IGVudHJ5ICovCiAJCWNvbnN0IHN0cnVjdCBuZnRfZGF0YSAqZHVwX2tl
eSwgKmR1cF9lbmQ7CkBAIC0xMjQ0LDcgKzEyNDMsNyBAQCBzdGF0aWMgaW50IG5mdF9waXBhcG9f
aW5zZXJ0KGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwgY29uc3Qgc3RydWN0IG5mdF9zZXQgKnNldCwK
IAogCWlmIChQVFJfRVJSKGR1cCkgPT0gLUVOT0VOVCkgewogCQkvKiBMb29rIGZvciBwYXJ0aWFs
bHkgb3ZlcmxhcHBpbmcgZW50cmllcyAqLwotCQlkdXAgPSBwaXBhcG9fZ2V0KG5ldCwgc2V0LCBl
bmQsIG5mdF9nZW5tYXNrX25leHQobmV0KSwgdHN0YW1wKTsKKwkJZHVwID0gcGlwYXBvX2dldCht
LCBlbmQsIG5mdF9nZW5tYXNrX25leHQobmV0KSwgdHN0YW1wKTsKIAl9CiAKIAlpZiAoUFRSX0VS
UihkdXApICE9IC1FTk9FTlQpIHsKQEAgLTE3ODgsOSArMTc4NywxMCBAQCBzdGF0aWMgdm9pZCBu
ZnRfcGlwYXBvX2FjdGl2YXRlKGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwKIHN0YXRpYyB2b2lkICpw
aXBhcG9fZGVhY3RpdmF0ZShjb25zdCBzdHJ1Y3QgbmV0ICpuZXQsIGNvbnN0IHN0cnVjdCBuZnRf
c2V0ICpzZXQsCiAJCQkgICAgICAgY29uc3QgdTggKmRhdGEsIGNvbnN0IHN0cnVjdCBuZnRfc2V0
X2V4dCAqZXh0KQogeworCXN0cnVjdCBuZnRfcGlwYXBvICpwcml2ID0gbmZ0X3NldF9wcml2KHNl
dCk7CiAJc3RydWN0IG5mdF9waXBhcG9fZWxlbSAqZTsKIAotCWUgPSBwaXBhcG9fZ2V0KG5ldCwg
c2V0LCBkYXRhLCBuZnRfZ2VubWFza19uZXh0KG5ldCksIG5mdF9uZXRfdHN0YW1wKG5ldCkpOwor
CWUgPSBwaXBhcG9fZ2V0KHByaXYtPmNsb25lLCBkYXRhLCBuZnRfZ2VubWFza19uZXh0KG5ldCks
IG5mdF9uZXRfdHN0YW1wKG5ldCkpOwogCWlmIChJU19FUlIoZSkpCiAJCXJldHVybiBOVUxMOwog
Ci0tIAoyLjM0LjEKCg==

