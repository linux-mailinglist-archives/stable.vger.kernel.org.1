Return-Path: <stable+bounces-238642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKhZGL7h5Gn7bQEAu9opvQ
	(envelope-from <stable+bounces-238642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 16:07:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E12A4244D8
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A6FE3026CA7
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 14:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306DB37E2FC;
	Sun, 19 Apr 2026 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+xnDSv+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647C37E2FE
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776607583; cv=none; b=Lbpa9v1owqEPl6N36dvWg6iNTlv4RdJyWZzp0QiBwribPNQB/h7PFU0jdbDRx/vNDF1X4KJVvJPO7aQerKwa8Ys8VPuxxqQJwHHY+YINT2l9uZEQcLvGpLrZqq94fX0VDx68ui/+0jCTx/qIrTjZyKQDQkWNqH0wFnxJfQpJXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776607583; c=relaxed/simple;
	bh=3WWp9rUozTrqD9jYJJIxf3iZIrIrmP3btVTinVMXXjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIygIH9mrhMnyjQk1f3AjxaCeQs+f7isULDY0Ogup9A6tJc4X55v014ecGtaXHYhXm+osqnancQ07TuvfBaozGGLkXJkHFJs4DlDOOjtd9U92W/VYUd3p6dBNb42ubSuexWH3YjNQds4JNLlTXP5x7sQF5TzPpwyewCESJU1OIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+xnDSv+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-356337f058aso1351264a91.2
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776607581; x=1777212381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au3wY7wHMTJZKx13iEN8EAIoe19OdnlK/RWrodbzRlg=;
        b=J+xnDSv+u78mVhjouID8LyShxnk7yOdGHPy/vsXV0tS4t6S2DgPFdA2qYYi9tT/kUd
         7V56H12W4WTpoKwO6QVSOvWfWhIcRjnaIRg8KSiXEJL3PYNICnrm7UwO37K9vY9aDhb0
         kQXZqSXfqHck0CheFLhnTUaXCc0vy1kuBXNDHtjic+9UdeAlFL3/6fE5u2JwSJV4OEIZ
         5e9NVY6sIQ90KKpZPmBUj/shW5iaiYSX0ixYxskYV8MkZnSmJlle6b7Nu7uY0uPJG7wl
         WPEudXqWW2912nkL14wbt4xpfE3cVNHoNCrpI/EkAhMIwLv67wKbd7/BjvjbHQS3jUVs
         EwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776607581; x=1777212381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=au3wY7wHMTJZKx13iEN8EAIoe19OdnlK/RWrodbzRlg=;
        b=nl4N/p+2JJIQqqVW3TEnjhy+G+yHPicWcSFksvOYiqVHup+Jcc4MqEOkLQBsE9CLJJ
         EZEDIAxRSeTNfA5jpIIthgFY/W0w6l6Kb/P2vlqjtNvycS0ihcXQbc5YaXifBRAO7Lk7
         p94rVk6JJg/dZPdl5OpYvNwcwB6m+iFSbTQM2XiX229QaGUBaLlGYQXk5UZFd8Tq5YRF
         PveL7V3HgSeLTohd4nGbslgKdYCUU0myLfIUMWjQ/cMhzjiInN4Oe0fe0kt1SrS8NHTX
         irdCJIMCvRza4BlHbeCYzonXOOmR7mVRykevBcj+4dtmqThERzXYEUoD+30Ad6vO0Zza
         AhXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GmtfDwiydi/Oe0i56E1d1+iAlwrW0ITIxM5GzWL2/QEF+n6ddGw1Aqgxz0IB3yIQHAX9bj/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp22P+DFpvVIZgmOxBFGy6IgCHTMgBnbhK/krfp2eNPDKEZkW9
	Tf0xlluvwFqbVIFipFxeGrQhqBxVW49DJ/XqxX5XddytrIAjXHLTGNhw
X-Gm-Gg: AeBDiev3NhLoxw2Tm1H8TMFjuIhfwmkl4A+g3XYNkRpak9xDWBKu/AFIw8MPjLVZ81e
	65CGcx01YjDggPmEmpIapwKduw7t8dJd+IBu/qdwa40OOiU6NQwAWsw6iwfSI9i0WQAQE8m6K4V
	+f5RvLLUGswLvyNLKZIJvWnEb9vkF2D+qZijwGYlC/EsfK5Lp3x9COnJSMHn1ev/sUv09CTX2IZ
	Unw34D1C2OESSc81UIFhiHeWlh+xl0nEM+87YAbj7e5J0qa+ALcOSpE/Z3CxDWyW7+4uhenTdhh
	wGBJRygT1gpd3Zj5davk7Sccy8Sd96zHr5ykUIPziMzi7ru6CPxcb0oc2UUnw19yRf4X5PbsBbA
	GNYDtdNCzNUX4gWzWRjy674t6jBkXoVxINnTbiN1+EEH7DpXEa/RzqghTF0uDTidCa2/+L/afgS
	l740B2HOuxgyMfZxzINilIQljwNdjF1g/WYTuv
X-Received: by 2002:a17:90a:d09:b0:361:45df:102 with SMTP id 98e67ed59e1d1-36145df0c75mr5534160a91.17.1776607581141;
        Sun, 19 Apr 2026 07:06:21 -0700 (PDT)
Received: from misys ([58.120.241.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141898ebasm7718121a91.7.2026.04.19.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 07:06:20 -0700 (PDT)
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
Date: Sun, 19 Apr 2026 23:06:12 +0900
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
	TAGGED_FROM(0.00)[bounces-238642-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 8E12A4244D8
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


