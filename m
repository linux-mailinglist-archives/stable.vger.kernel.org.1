Return-Path: <stable+bounces-223097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCrQFkZnqGl3uQAAu9opvQ
	(envelope-from <stable+bounces-223097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:09:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FBB204E66
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFE1E30D33A5
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D34374E59;
	Wed,  4 Mar 2026 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBofuwds"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA29361663
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643340; cv=none; b=I5hrSSEpSa4AAzJMM+btf/sK9yhhpqzZyraWmQw4VIDOesq1LxjSCzx6yrbFqRnwXclxtKMdqsZAloRfNnYCwliMzBgOHdhjsehr6TlbPCirCKKkp7nbShM0TAU4X816pPg+jNDZcCZvHzpxDD4nn/tp9Znif+MYi+NEvmoXwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643340; c=relaxed/simple;
	bh=ZzfXF5B7ncFYSAq5Ab9OtcS0E8vMyzwj2/FvX/Npv38=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Message-ID:Date:
	 In-Reply-To:References; b=pr7CMQknur+5OoRaY2wcZvBE9eznGXSkGs95J7u1Vp0mSKwxNb1w0fl4sAu4z+cw9VZKiiK/L/lIvqLzhk9sHkpgrEx39S6g2CgOhchkyI/rmkq872DJTyxI9Hy2q5RKCFJ6rxUya8MHAF8MNARjJb028NZkpETHm18TALviBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBofuwds; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso847400f8f.3
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 08:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643338; x=1773248138; darn=vger.kernel.org;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzfXF5B7ncFYSAq5Ab9OtcS0E8vMyzwj2/FvX/Npv38=;
        b=eBofuwds5a+u5u6yYAG+NWn+axc9+QLgDXPstflOZUPNeTHR1YMlbnSa5j15rKvRDR
         OZAAdTQiBJcx6tCHAqaBa3UYBwl5YZkvWLsuOp7yHqfhD/fbpIf7G+e5yuVSrpJWrLmu
         bRqjRHpXzQ0+fvY3vpUAyay3g0De2eQew7eR+cIA0uure5Ng6apuEV0UVh8lc3fPRe6T
         4miqMNwOXd4as05JT6eO0u4vxHU6RDB8LK7kYT6LFTVoVh1+cZC+As/f6pk5hO7LWWwe
         RS2pe5aUMHBWQDC7ITwhewbZKQRJVfMT3VaXTcNcOGYF/YWkyFBgWsvkS3DeqhJP1T9x
         ueCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643338; x=1773248138;
        h=references:in-reply-to:date:message-id:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzfXF5B7ncFYSAq5Ab9OtcS0E8vMyzwj2/FvX/Npv38=;
        b=JKE4kwG0H9lxjmi373tyDrmseALThOsbtn7n0asNYGl0dKJSCSpCv2LAovfYOTvcqq
         gTJw7+gXuwf18HxurN3+rScB5Oe+Tfg648PpMwCb3G55TP6e858UfFt+j4JWybbf0j7b
         sxdbtI1PM9d8BtADoWD9m2b9GXJiB8KU+fiRA5VL56czOGMyzNP9AKZNu+iwel7vxoxJ
         VZ/jjEdGTsMDUo04L2YZ6/M1w7PnfRdchOqPdC08pY6LzII5+RiHkiP0j5R3NUd+Cmtr
         Qk4t4xzEk7sC3+aAIgCz2Qbj5QYK1j3pYS7HY4SlbqbX6TqNIsda5rRVEThd10QWaKyi
         SLIA==
X-Gm-Message-State: AOJu0YxJKKW6pgn3//Z6ulC9GixrJVLr4jWgCnlHb6aKU9D7yxGupM16
	jDHsu5DQr+VQETm5CYBV3dtnrxHzH3RcWRBBOM4ggOhoZnyliHlXlj9n0oX/qiMU7j4=
X-Gm-Gg: ATEYQzzMzdpTFRe1MgbuxEL9ByPE0pNmyfHrXcWewFFOSNiM3h7f/4a28xXUPxVhMiD
	UU4JbUH43UwdRIk7XRFyjPA77t1CYsjKX8Mxo5dHhFi7U0oLsPIB3pq2TlQ92Ywtfsb4NOvuTao
	0GD9VHhXuGPGjUV8wwr/I8H+GHgBwDIwfboIY13gOfYUpxPn+ClNWqHsPQcpovyR+cnQkPX5n6F
	POQ4amcsh/L8mzNEUQ4UVqHD4FYDjKFt+suJWrT9t0EDmo03YuuBxMRZOaPVqZRndEAKWliA0nU
	4ug9QklIMynu3ceGIP0/tYDkRm7cc9ue46P0GM5+dvk/V5bC18hF44zWtLhg1MckbKUN03zHuUB
	qCbAnh6uURe0w5Eqnfden+u6txQi/8S/4NWfe5OYHx/zv9MHswtC3HH8gZ5EjbPvPkomgFYneYy
	UKFMbsUoaKHV+9+xGeFtD+7uRKAHK0yy4F6EeNfoDrbVzjLRz8RQb/t13JsgURL+2SBdZ0nDPx
X-Received: by 2002:a05:600c:81c8:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-485198808f9mr47763175e9.18.1772643337414;
        Wed, 04 Mar 2026 08:55:37 -0800 (PST)
Received: from [192.168.87.1] ([2001:8f8:1623:5b27:105a:4143:17c9:9894])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad25a17sm16288255e9.29.2026.03.04.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:55:37 -0800 (PST)
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
Subject: [PATCH v3 6.6.y 8/8] netfilter: nft_set_pipapo: remove dirty flag
Message-ID: <1772643278.pipapo-v3.8@gmail.com>
Date: Wed, 04 Mar 2026 20:55:32 +0400
In-Reply-To: <1772643278.pipapo-v3.0@gmail.com>
References: <69a84adc.050a0220.1cea47.3011@mx.google.com> <2026030421-grunt-raft-15f0@gregkh> <1772643278.pipapo-v3.0@gmail.com>
X-Rspamd-Queue-Id: D0FBB204E66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223097-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

QWRhcHRhdGlvbiBvZiBjb21taXQgNTMyYWVjN2U4NzhiICgibmV0ZmlsdGVyOiBuZnRfc2V0X3Bp
cGFwbzogcmVtb3ZlCmRpcnR5IGZsYWciKSB0byA2LjYuMTIyLgoKQWZ0ZXIgdGhlIHByZXZpb3Vz
IGNoYW5nZSwgd2hlbiBhIGNsb25lIGV4aXN0cywgdGhlIGRpcnR5IGZsYWcKaXMgYWx3YXlzIHRy
dWUsIHdoZW4gY2xvbmUgaXMgTlVMTCwgZGlydHkgaXMgYWx3YXlzIGZhbHNlLgpSZW1vdmUgaXQu
CgpTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFdlc3RwaGFsIDxmd0BzdHJsZW4uZGU+ClJldmlld2Vk
LWJ5OiBTdGVmYW5vIEJyaXZpbyA8c2JyaXZpb0ByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBQ
YWJsbyBOZWlyYSBBeXVzbyA8cGFibG9AbmV0ZmlsdGVyLm9yZz4KU2lnbmVkLW9mZi1ieTogTmF0
YXJhamFuIEtWIDxuYXRhcmFqYW5rdjkxQGdtYWlsLmNvbT4KLS0tCiBuZXQvbmV0ZmlsdGVyL25m
dF9zZXRfcGlwYXBvLmMgfCAyICsrCiBuZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvLmggfCAy
IC0tCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvLmMgYi9uZXQvbmV0ZmlsdGVy
L25mdF9zZXRfcGlwYXBvLmMKaW5kZXggNTdiNDVlM2IxMWNhLi5mMDEwNTAwODdjNjkgMTAwNjQ0
Ci0tLSBhL25ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uYworKysgYi9uZXQvbmV0ZmlsdGVy
L25mdF9zZXRfcGlwYXBvLmMKQEAgLTExOTEsNiArMTE5MSw4IEBAIHN0YXRpYyBib29sIG5mdF9w
aXBhcG9fdHJhbnNhY3Rpb25fbXV0ZXhfaGVsZChjb25zdCBzdHJ1Y3QgbmZ0X3NldCAqc2V0KQog
I2VuZGlmCiB9CiAKK3N0YXRpYyBzdHJ1Y3QgbmZ0X3BpcGFwb19tYXRjaCAqcGlwYXBvX21heWJl
X2Nsb25lKGNvbnN0IHN0cnVjdCBuZnRfc2V0ICpzZXQpOworCiAvKioKICAqIG5mdF9waXBhcG9f
aW5zZXJ0KCkgLSBWYWxpZGF0ZSBhbmQgaW5zZXJ0IHJhbmdlZCBlbGVtZW50cwogICogQG5ldDoJ
TmV0d29yayBuYW1lc3BhY2UKZGlmZiAtLWdpdCBhL25ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBh
cG8uaCBiL25ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uaAppbmRleCBhYWQ5MTMwY2M3NjMu
Ljg0NDJhYWVjYmU3ZCAxMDA2NDQKLS0tIGEvbmV0L25ldGZpbHRlci9uZnRfc2V0X3BpcGFwby5o
CisrKyBiL25ldC9uZXRmaWx0ZXIvbmZ0X3NldF9waXBhcG8uaApAQCAtMTYzLDE0ICsxNjMsMTIg
QEAgc3RydWN0IG5mdF9waXBhcG9fbWF0Y2ggewogICogQG1hdGNoOglDdXJyZW50bHkgaW4tdXNl
IG1hdGNoaW5nIGRhdGEKICAqIEBjbG9uZToJQ29weSB3aGVyZSBwZW5kaW5nIGluc2VydGlvbnMg
YW5kIGRlbGV0aW9ucyBhcmUga2VwdAogICogQHdpZHRoOglUb3RhbCBieXRlcyB0byBiZSBtYXRj
aGVkIGZvciBvbmUgcGFja2V0LCBpbmNsdWRpbmcgcGFkZGluZwotICogQGRpcnR5OglXb3JraW5n
IGNvcHkgaGFzIHBlbmRpbmcgaW5zZXJ0aW9ucyBvciBkZWxldGlvbnMKICAqIEBsYXN0X2djOglU
aW1lc3RhbXAgb2YgbGFzdCBnYXJiYWdlIGNvbGxlY3Rpb24gcnVuLCBqaWZmaWVzCiAgKi8KIHN0
cnVjdCBuZnRfcGlwYXBvIHsKIAlzdHJ1Y3QgbmZ0X3BpcGFwb19tYXRjaCBfX3JjdSAqbWF0Y2g7
CiAJc3RydWN0IG5mdF9waXBhcG9fbWF0Y2ggKmNsb25lOwogCWludCB3aWR0aDsKLQlib29sIGRp
cnR5OwogCXVuc2lnbmVkIGxvbmcgbGFzdF9nYzsKIH07CiAKLS0gCjIuMzQuMQoK

