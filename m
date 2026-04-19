Return-Path: <stable+bounces-238639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPohNGvh5Gn7bQEAu9opvQ
	(envelope-from <stable+bounces-238639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 16:06:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7160742448F
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AD233015880
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0E22173D;
	Sun, 19 Apr 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6igzAJp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FD37C10F
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776607564; cv=none; b=fD2bBe5d3S9+gXmQgmGNl6cj0hMMzJU8JVaH3uwsMRlJIqg5FszMX0Us3Vh7DTBazP4UuTrCb+Z8LBmC799nfOqqcZHhS28ouA4x7Gj/TWqLZ0tz83Xflf4jptJXO7Tr/8NlAZdB8bD5s5y29/REhiIktkfinYEpw8sy7agAkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776607564; c=relaxed/simple;
	bh=3WWp9rUozTrqD9jYJJIxf3iZIrIrmP3btVTinVMXXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qM9MyR/PPcCILSr+mbOrFLhBDlfkt0N5SrcGVtgLxgeZFG8DJSnEQLN7yzsdepqWK2+/2Ng5vvpd0nktwLu/m+mdxMhz1+a5+VL9nJgDhhksscZR3xWjIvmu1DFvxvzJkp9ePGjG3+zEKMNXhhigYh4/gHYl841dkIYlIiOuOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6igzAJp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f943870baso628540b3a.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776607563; x=1777212363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au3wY7wHMTJZKx13iEN8EAIoe19OdnlK/RWrodbzRlg=;
        b=e6igzAJp8bKEpr2lr3+2LP6ZSnvTPdMrBjnszXlyd4gXd9jWisN+TDU762mpX1l3Fd
         94jLIvepvcKfd+/LfTqD2+M+UKmtYMCtiuWBRUUWWgty681OV5FvszUHmrWZchBdrB0e
         OR873LrxxNo5Znmukn/8VjJLjqD9rQyx0lr3syFa/TWWDPAcJFlxO12oenX3qZOGSxD3
         fMwfdYoH2t9REkP4y03gJGF5W6+Ekv6cWrXCxeGul3TIuo9cATFc0srD2WcO+w/ic61o
         gsGjlgg/JYpUMAkqGsLeQVngkiR5QFBsXXAa3haGKr1nNdqytKabNp1ib5Sd3JfKGhVR
         whPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776607563; x=1777212363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=au3wY7wHMTJZKx13iEN8EAIoe19OdnlK/RWrodbzRlg=;
        b=Q7MggymEPOphRHOFuzNLCSD5/d9n8VSEKC/4Y7DUjr5MNb8njPo4slzuw3QFqS6Mc2
         6UPTP+IY5FAY7ViZ0omldxhbgT9Hcb72bNk34O5wttEIbANHi+thDmR9nPkZo9DvTXAd
         RWfR5FLnERnoVEc0vkcZxIarJQgX2yvbbGKIyxfsuqNyxiR8553PToDWLkKGgtOMTkwQ
         46VKG1xt5raB8l3r3Ygxzw6ActHsnefxTDpAcVtxw9HWFK+bS5Vb3pVlAtznVbyJPvjH
         y1pNJUHyK/RRZUvbX/+nAlALfcGHTMwW1ktN59Vd/+Fy0d5dwDVqyL3I4cykLIGwZiPO
         2PkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3KmlhuwqKVjmzjRfGD7sju2sDSlIZJZaMsKAAusA/dIstsKUlgmSPCI3jcEtqfOOFL6N+0TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xiYX2Ukp/7amfEHLWJHW/rfuGuinsTI5HcIKrphGl5eEsa+o
	4fiGsBVob+WqXS/INVNU5kcLWkKXGb/tdXqsMlcqJKSMKZ5XtBhgdPOP
X-Gm-Gg: AeBDiesnPsN2SUzXRiSLSUyXa6ng2myn2EPbR4PF7VLwAdFBZAkP87jFRF1rjymOCJS
	Ne0pNQyGHaqGJa5sYPNHKkxv6LX98I/SPBgptDSgmtmCYslTfuLwh9KCP1U7c/QNCYBgsi12cYJ
	SPwoX4bQg8XzgardVibra60TMwL/YjjLfrpW1KOlgJ7wu0p/beQk+uY6imIAjx+XnCY9UkdEE0b
	3UbGYncQU0kM8uzjBtx8SOZZ+KxeUWkBvyFzUlnaY+GTxY1Bv1+RY89subBZNK0rcQeGFh+UJ9p
	9HVqOTylKiGGAcZL6uYUKXNuD+Y327DloYs+CHwLZlcYcLkOWLqMxUFpfSn1rMKx2MrF12bKOtg
	yPNxHg9Tfw4cil0MdmfzpZ3bVR0MefhQr9YksC4VnUetjUTyUBFPpi4QWyfsArFRLIwFtSzl8OJ
	4wEsYijImduaLeDi0p8t0X+uzm5A==
X-Received: by 2002:a05:6a00:6de7:b0:824:a22c:c6d7 with SMTP id d2e1a72fcca58-82f8c8893abmr9989689b3a.18.1776607562984;
        Sun, 19 Apr 2026 07:06:02 -0700 (PDT)
Received: from misys ([58.120.241.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe6642sm9667974b3a.45.2026.04.19.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 07:06:02 -0700 (PDT)
From: HeeSu Kim <mlksvender@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@google.com,
	charmitro@posteo.net,
	dakr@kernel.org,
	gary@garyguo.net,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	mlksvender@gmail.com,
	nathan@kernel.org,
	nsc@kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH v6 1/2] kbuild: add rustc-lt-version macro
Date: Sun, 19 Apr 2026 23:05:53 +0900
Message-ID: <498f49f1c0b34535309f9dedf87ac4de8e7c132b.1776607331.git.mlksvender@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776607331.git.mlksvender@gmail.com>
References: <cover.1776607331.git.mlksvender@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,posteo.net,garyguo.net,vger.kernel.org,gmail.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238639-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mlksvender@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7160742448F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add `rustc-lt-version` macro to `scripts/Makefile.compiler` for version
upper bound checks, mirroring the existing `rustc-min-version`.

Use a non-inclusive (less-than) comparison so that callers can express
clean version boundaries such as `109000` (Rust 1.90.0) rather than
`108999`, which is also easier to remove once the toolchain minimum
version is bumped past the bound.

This will be used to bound workarounds to specific compiler version
ranges.

Originally posted as `rustc-max-version` in v5 [1]; renamed to
`rustc-lt-version` on this respin per Miguel's direction to simplify
the delta and avoid the `99` form [2].

[1] https://lore.kernel.org/rust-for-linux/20260205131522.2942928-1-mlksvender@gmail.com/
[2] https://lore.kernel.org/rust-for-linux/CANiq72n-z0v_deUVPWeg1h0c6KQ+r6xfNDf72o29_0yy6KbqGA@mail.gmail.com/

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/CANiq72n39eU9WE=Yh0_yJzmqMxo=QAaU2pN0UqP9jZ7bT7rhgA@mail.gmail.com/
Acked-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: HeeSu Kim <mlksvender@gmail.com>
---
 scripts/Makefile.compiler | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index ef91910de265..fd039e228800 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -71,6 +71,10 @@ clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 # Usage: rustc-$(call rustc-min-version, 108500) += -Cfoo
 rustc-min-version = $(call test-ge, $(CONFIG_RUSTC_VERSION), $1)
 
+# rustc-lt-version
+# Usage: rustc-$(call rustc-lt-version, 109000) += -Cfoo
+rustc-lt-version = $(if $(call rustc-min-version,$1),,y)
+
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
 ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
-- 
2.52.0


