Return-Path: <stable+bounces-237725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CutM5LU3WnfjwkAu9opvQ
	(envelope-from <stable+bounces-237725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:45:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFC3F5CA3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAAC43019509
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6EB303A07;
	Tue, 14 Apr 2026 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii3wWGIe"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE12609EE
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145489; cv=none; b=XMjYZSm2Ay050MGgbiBhgMCILyjdhnTbwfIYLxP8U4tesnKLC7J/g7L8EXMVT1SW6IOCrhBhFYAffOjM+ktQc0BroV3LrA8XOJmdMzbebQnynpSYh7pDqSmm5Sdlem9gycx9VNWXZxxNUUL0+t2sBRf5OGNaLtZGGhdCItB1hzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145489; c=relaxed/simple;
	bh=aDm5Kil0HXsnjHv6GNGtwXDhX9a19psMf0K9NXnVpWM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID; b=j6ynVRDw+mfQYXWWVO7IAbWuYwHWvAF4eMkLMmmirIu5WlUkecDVu7nICrrObqQg8Hj+8VRI5GdGuxRXZtQIn4KVlJ7U581ySUWUMVcHF2J0m06YwyIMJy23pRbzLSDqnXt9o/OJPXJFRLIZtXjBvnedUmpGwojus63zjkFkDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii3wWGIe; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so21629336d6.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776145486; x=1776750286; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aDm5Kil0HXsnjHv6GNGtwXDhX9a19psMf0K9NXnVpWM=;
        b=Ii3wWGIexNcvthzIuddEfYyY5O7lpSX6Z2hspZrD36w/S0qNDTUG0+tKCddj/NjOzc
         f+AYYcqpcvKm3y10oVn2qUzcFMOsKu/KCtROqLExJSpODA7q55+ZZVPa8HWyPAQF6leJ
         RybLD5ON3/h2Vrv9fBlwf/fU0EzTl2pFm02SK1fHq2cdNRXjWPxkKP0FD5Zb0A2Z7qLW
         sjRg1rpn4JixLxUhms5I9ut8cTguWagkrvBhC5nkTVqIF6ipD8OuQGk0k6FtisaG0ZWo
         xaGv74GVRhPnyjH6AT69YX+B5wi0Kqp7eMmzKiisH4EsoYb/3FAIQKjz/KQ523F/0adD
         A0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776145486; x=1776750286;
        h=message-id:date:subject:cc:to:from:content-transfer-encoding
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDm5Kil0HXsnjHv6GNGtwXDhX9a19psMf0K9NXnVpWM=;
        b=bWLqRA5hsm6mZcpiyh8iiUNF44FqjyhO6pA3XF1VklcyKelyJKaoKdAwf6TGKhb3a6
         zwIAP5V5yyjQv6u9cKHXoYMcfuiqao2DePtE5p4UstLLCUBMy42mEBhRe1DT57UPjtLk
         mhXOjODSs4YtYL5+p9jCy7+yZvqnQXJbrUpqwsV0g/baqXp19NQbWcdDkfWBojD9+OnU
         JcjC++2eE9amDga6GhCNPWHey96bVvX0LMdvQp2PFyqbw+mh9eiQcXVotV7YPten7MYD
         2cXUY5zpCcofiN44ghzuvvugYVhAr290DoDAFfgP+YV++Sa/Ylb1bbr+eRYNLDKalU/U
         QeIA==
X-Forwarded-Encrypted: i=1; AFNElJ9L0PkEXbVlDJwvUbBYpV7BRENVJvN73Lglq4wcaX4vRASXR4gtyvf8ySBw4dIiNbpdzmGcZxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYp5wFBcUYa3+v1zxe+IxrKP/o4yJIDeBDnn6KPReGwryIjFSt
	sb8pwfFTHZmfNftO660YYamiPAwNE0umHnncnRKf1icFiPxMS9T9DoawPPuaboIi08ndMQ==
X-Gm-Gg: AeBDieuA+E6nwj+VRr3iT6/pj5hwjAEop2fDx699tKkxMn+eIxg8buuQpxOGFV3b7OX
	PkeNJte0WbaN7roxahAz0T/NcWDjMzrU4hyRUFmTh35sBWEKOrN710tRupw7RwSj58SDrCCLYcz
	zJdwsDvKzJC3Dr6CxZI1Df6PsevzVfZaxJ36KInJREU9MgLoeglfxpOOGf1lTZzNxgRRrtLbhMR
	g0roHCkHNIkacSS3oJPQBJPrbbyhFMBWZhZf6jX4bfp46XHmDmDYAEy7sNlkIs7Ld4PsY4Y+CFI
	HPUZInB3iE093HxkH2+JTi6E1Y4kH8BfZB45upu4key2DJW4+net6NXYrsr4dvftO1pIitpOD4q
	kGC2tdRBnl04wv2AYn1csItOoQUdg30L87ZLvV9ntBY6IH4bpdIBD3XPqJnFuAJt13u4O8uOOM9
	kzBInsh0XHES7dqANewx6zbrSOWSe8fFUwHjhIKvv32wVrtDZ82TDNIq/dIHR/4gUwd45EjzNiA
	Lvpy/1ToQ==
X-Received: by 2002:ad4:574d:0:b0:89c:df61:7a06 with SMTP id 6a1803df08f44-8ac862f56c6mr262396686d6.48.1776145486489;
        Mon, 13 Apr 2026 22:44:46 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8acb925d457sm22924196d6.45.2026.04.13.22.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 22:44:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: mcanal@igalia.com, itoral@igalia.com, stable@vger.kernel.org
Subject: [PATCH v3] drm/v3d: Reject empty multisync extension to prevent infinite loop
Date: Tue, 14 Apr 2026 05:44:45 -0000
Message-ID: <177614548527.3603641.5360701002746181082@gmail.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237725-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33DFC3F5CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

djNkX2dldF9leHRlbnNpb25zKCkgd2Fsa3MgYSB1c2Vyc3BhY2UtcHJvdmlkZWQgc2luZ2x5LWxp
bmtlZCBsaXN0IG9mCmlvY3RsIGV4dGVuc2lvbnMgd2l0aG91dCBhbnkgYm91bmQgb24gdGhlIGNo
YWluIGxlbmd0aC4gQSBsb2NhbCB1c2VyCmNhbiBjcmFmdCBhIHNlbGYtcmVmZXJlbnRpYWwgZXh0
ZW5zaW9uIChleHQtPm5leHQgPT0gJmV4dCkgd2l0aCB6ZXJvCmluX3N5bmNfY291bnQgYW5kIG91
dF9zeW5jX2NvdW50LCB3aGljaCBieXBhc3NlcyB0aGUgZXhpc3RpbmcgZHVwbGljYXRlLQpleHRl
bnNpb24gZ3VhcmQ6CgogICAgaWYgKHNlLT5pbl9zeW5jX2NvdW50IHx8IHNlLT5vdXRfc3luY19j
b3VudCkKICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7CgpUaGUgZ3VhcmQgbmV2ZXIgZmlyZXMg
YmVjYXVzZSB2M2RfZ2V0X211bHRpc3luY19wb3N0X2RlcHMoKSByZXR1cm5zCmltbWVkaWF0ZWx5
IHdoZW4gY291bnQgaXMgemVybywgbGVhdmluZyBib3RoIGZpZWxkcyBhdCB6ZXJvIG9uIGV2ZXJ5
Cml0ZXJhdGlvbi4gVGhlIHJlc3VsdCBpcyBhbiBpbmZpbml0ZSBsb29wIGluIGtlcm5lbCBjb250
ZXh0LCBibG9ja2luZwp0aGUgY2FsbGluZyB0aHJlYWQgYW5kIHBlZ2dpbmcgYSBDUFUgY29yZSBp
bmRlZmluaXRlbHkuCgpGaXggdGhpcyBieSByZWplY3RpbmcgYSBtdWx0aXN5bmMgZXh0ZW5zaW9u
IHdoZXJlIGJvdGggaW5fc3luY19jb3VudAphbmQgb3V0X3N5bmNfY291bnQgYXJlIHplcm8gaW4g
djNkX2dldF9tdWx0aXN5bmNfc3VibWl0X2RlcHMoKS4gQW4KZW1wdHkgbXVsdGlzeW5jIGNhcnJp
ZXMgbm8gc3luY2hyb25pemF0aW9uIGluZm9ybWF0aW9uIGFuZCBzZXJ2ZXMgbm8KdXNlZnVsIHB1
cnBvc2UsIHNvIHJldHVybmluZyAtRUlOVkFMIGZvciBzdWNoIGFuIGV4dGVuc2lvbiBpcyB0aGUK
Y29ycmVjdCBkZWZlbnNlIGFnYWluc3QgdGhpcyBhdHRhY2sgdmVjdG9yLgoKRml4ZXM6IDkwMzJk
NWY2MzNlZCAoImRybS92M2Q6IERldGFjaCBqb2Igc3VibWlzc2lvbnMgSU9DVExzIHRvIGEgbmV3
IHNwZWNpZmljIGZpbGUiKQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5
OiBBc2h1dG9zaCBEZXNhaSA8YXNodXRvc2hkZXNhaTk5M0BnbWFpbC5jb20+Ci0tLQpWMiAtPiBW
MzogZHJvcCBkZXB0aCBjb3VudGVyOyBpbnN0ZWFkIHJlamVjdCBlbXB0eSBtdWx0aXN5bmMKICAg
ICAgICAgIChpbl9zeW5jX2NvdW50ID09IDAgJiYgb3V0X3N5bmNfY291bnQgPT0gMCkgaW4KICAg
ICAgICAgIHYzZF9nZXRfbXVsdGlzeW5jX3N1Ym1pdF9kZXBzKCkKVjEgLT4gVjI6IGNoYW5nZSBj
YXAgZnJvbSAxNiB0byBWM0RfTUFYX0VYVEVOU0lPTlMgKDcpLCBhZGQgI2RlZmluZQoKdjI6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2RyaS1kZXZlbC8yMDI2MDQxMzA1NTIzMC4zMzQ5MTE0LTEt
YXNodXRvc2hkZXNhaTk5M0BnbWFpbC5jb20vCnYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9k
cmktZGV2ZWwvMjAyNjA0MTAwMTM5MDcuMjQwNDE3NS0xLWFzaHV0b3NoZGVzYWk5OTNAZ21haWwu
Y29tLwoKIGRyaXZlcnMvZ3B1L2RybS92M2QvdjNkX3N1Ym1pdC5jIHwgNSArKysrKwogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92
M2QvdjNkX3N1Ym1pdC5jIGIvZHJpdmVycy9ncHUvZHJtL3YzZC92M2Rfc3VibWl0LmMKaW5kZXgg
MThmMmJmMWZlODlmLi5mYzc0MzUxZWZhZDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS92
M2QvdjNkX3N1Ym1pdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS92M2QvdjNkX3N1Ym1pdC5jCkBA
IC0zOTMsNiArMzkzLDExIEBAIHYzZF9nZXRfbXVsdGlzeW5jX3N1Ym1pdF9kZXBzKHN0cnVjdCBk
cm1fZmlsZSAqZmlsZV9wcml2LAogaWYgKG11bHRpc3luYy5wYWQpCiAgLUVJTlZBTDsKIAoraWYg
KCFtdWx0aXN5bmMuaW5fc3luY19jb3VudCAmJiAhbXVsdGlzeW5jLm91dF9zeW5jX2NvdW50KSB7
Citkcm1fZGJnKCZ2M2QtPmRybSwgIkVtcHR5IG11bHRpc3luYyBleHRlbnNpb24KIik7CityZXR1
cm4gLUVJTlZBTDsKK30KKwogcmV0ID0gdjNkX2dldF9tdWx0aXN5bmNfcG9zdF9kZXBzKGZpbGVf
cHJpdiwgc2UsIG11bHRpc3luYy5vdXRfc3luY19jb3VudCwKIG11bHRpc3luYy5vdXRfc3luY3Mp
OwogaWYgKHJldCkKLS0gCjIuMzQuMQ==

