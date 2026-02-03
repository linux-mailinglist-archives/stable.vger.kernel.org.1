Return-Path: <stable+bounces-213135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCGEO3FBgWl6FAMAu9opvQ
	(envelope-from <stable+bounces-213135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:29:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68284D2F9F
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9041130177B8
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877B14B96E;
	Tue,  3 Feb 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4h5okCy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F813635E
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077875; cv=none; b=QqKbayz649ldipgIjaFno5gXWu45W1T406lFIUDWg1ZJ6gy5R4Xqjwp5rc9l942qLFSb9dB7s3mp6mk4z7kDVm86P/Rkqz4WZjK6LXcBnF/MN2CQFW6WelJjUSBvry7gFQbDcbJ1QBBfDcIf5pnTeV+G/5KahVQNfs4y00WZa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077875; c=relaxed/simple;
	bh=ZJVy6cPRC9mVjPwe70OyZwHOLgx0hBKchie2Ey+56o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpSaUJ0LK0MHZeDAjAgn4TOY6xTuxTXQTiMH1v9RRibvILD5OKp7mVE0WCF865qDr9atUdVE9b8L1JIzvFhJ5uvSzwBc37l9pXmgBCcAwOBAEmfsMXCins4zWvFtNjImP2Ma30BuKw6s2D5U8gljCQG9J/+N8yjOqZGVPHSLbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4h5okCy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c09bb78cso2096655ad.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 16:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770077873; x=1770682673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZ1ws/HZ3fMtoPm4mMzkQZSOpt+7LENYkmppWHzFdqA=;
        b=X4h5okCysoBz/QiSq5/mM9++K1C1JQlcJxa107X0FYoJkks62N4Vo91K0uWw4MnW3Y
         8e363Uw0SZ5YUckuF/CxOl97e9bS/2c1nm/qXPbEgW/NTN3genVWNb9eDDDXPvu1aLel
         5W9fwyTBlskb0vjfws3Ccjg3eCQUuwmgHlaAOi4n5+soluSYXIzBfXVrWA4Dtl+sCcZU
         6OxN/plGs059h4hIfKWlyXlRT6H/fgkz9qf25aACVQscHoTlAUBnp6tsP00Tm6vzgHqK
         /5+chZvsJkeDiYPwU0K5QMHeXbWpQUtEVft7JOyUsXG3DXvEljLqB+9tBhNIUM77hMpX
         M2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770077873; x=1770682673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SZ1ws/HZ3fMtoPm4mMzkQZSOpt+7LENYkmppWHzFdqA=;
        b=NZyV46nqfOJVbx02N+BAeNlXl8mxlG1zLrSbrkh0bHmFVMAP8k5XhNA/kiXDzBzDXa
         pHHOcrNUnm4PoRL+wWbBptO0zxCmNdzDa4VYa2dqNgySqIby+gT1ORga7cqzMirQPhDw
         HVvHZQJizoqjRMhbECsS5Z8rckkuOtN4UKW0Qq1bKW8KF7f+mekbwzwMpeiR2A9euukg
         F9/lq1CI2X/Rq07qOrCWgJV5PJeXHVV/ITogDz2FUHBSSEheHKkdv/+g66aDZtxlp0zn
         P1IuIYEaEbxH80SRGotp7x6SzrXpiIVcXnP+EX2o0htxZfOXFp4lL8geOgX7iI157lik
         yFMA==
X-Forwarded-Encrypted: i=1; AJvYcCWXWumkJp69+imTRyqVu2ABvggf986kNaubOG206HmZqzwvxZbJuOibaF1+JDeGARo4CkOGypI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoP7VPyYcEEEQwWyIio0bBcpQPBoJD6o1AGSmj8ZmoXtaFkuPn
	BZi58qGGUnaUmpl8KAjgO/iM8i3h8YtnX6zsS9pUNpijOWLNA+4Jdc6y
X-Gm-Gg: AZuq6aKbhuEYsQfiQO/Q+l481xjY/dIt5KTx88xEsfcuDnymJdO/cI68UqYiifO6AHh
	FY95HsZ8Zva9FHVihebFIRYoo8P1RYm0EHo64P4FIdamn6bijzlS7pqSkrKYf6cl9SHtPgH+goZ
	UgFftXpvnwA5z33Ta7emeovYWxI0b0X2R0iBfv3InJGTe7MWAgjutwtVJ3PXHeiJn0N5RfONUgb
	b4kK3399AMgo/qzm1LkJavoKlTXHM4E+FkvhUTekv9xYhUip8FrX+YctXfB7wynZwdSSzOMTsrw
	lpSqHBNEs5otvqC0AOx7SfiidnvA5RChw+xxi3BJwc4UAxnPWhIK8LKa0KRaHNSb/GusUShWn/N
	doITpYk9cMu/P28yNsg04DxU1suz8UnoAQdc9ftkovrX9QUs6sj/xqu95bQwAgRJqCPUiL7ueQC
	bZvNk=
X-Received: by 2002:a17:903:2ecd:b0:2a7:b412:6cc8 with SMTP id d9443c01a7336-2a92458de40mr8592055ad.1.1770077873450;
        Mon, 02 Feb 2026 16:17:53 -0800 (PST)
Received: from misys ([58.120.241.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4110sm149973765ad.84.2026.02.02.16.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:17:53 -0800 (PST)
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
	nathan@kernel.org,
	nsc@kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	HeeSu Kim <mlksvender@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] rust: Makefile: bound rustdoc workaround to affected versions
Date: Tue,  3 Feb 2026 18:17:31 +0900
Message-ID: <20260203091731.2731080-1-mlksvender@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CANiq72n39eU9WE=Yh0_yJzmqMxo=QAaU2pN0UqP9jZ7bT7rhgA@mail.gmail.com>
References: <CANiq72n39eU9WE=Yh0_yJzmqMxo=QAaU2pN0UqP9jZ7bT7rhgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	DATE_IN_FUTURE(4.00)[8];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-213135-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,posteo.net,garyguo.net,vger.kernel.org,umich.edu,gmail.com];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlksvender@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68284D2F9F
X-Rspamd-Action: no action

The `-Cunsafe-allow-abi-mismatch=fixed-x18` workaround was added to
handle a rustdoc bug where target modifiers were not properly saved [1].

This bug was fixed in Rust 1.90.0 [2]. Restrict the workaround to only
apply for Rust 1.88.x and 1.89.x versions that are affected by the
bug, preserving ABI compatibility checks on newer compiler versions.

Link: https://github.com/rust-lang/rust/issues/144521 [1]
Link: https://github.com/rust-lang/rust/pull/144523 [2]
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DG4JM9PU51M0.1YRGM9HVTY24U@garyguo.net/
Cc: stable@vger.kernel.org # Useful in 6.18.y and later.
Signed-off-by: HeeSu Kim <mlksvender@gmail.com>
---
Changes in v3:
- Remove Fixes: tag (this is a feature, not a fix)
- Use full URLs with Link: tags instead of GitHub-style references
- Add Link: to lore.kernel.org for Suggested-by attribution
- Add Cc: stable for potential backporting to 6.18.y

Changes in v2:
- Change approach: bound to affected Rust versions instead of ARM64-only
  (the flag is simply ignored on non-ARM64 architectures)

 rust/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 5c0155b83454..55e2dc865207 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -136,7 +136,8 @@ pin_init-flags := \

 # `rustdoc` did not save the target modifiers, thus workaround for
 # the time being (https://github.com/rust-lang/rust/issues/144521).
-rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),-Cunsafe-allow-abi-mismatch=fixed-x18)
+# The bug was fixed in Rust 1.90.0, so only apply for 1.88.x and 1.89.x.
+rustdoc_modifiers_workaround := $(if $(call rustc-min-version,108800),$(if $(call test-lt,$(CONFIG_RUSTC_VERSION),109000),-Cunsafe-allow-abi-mismatch=fixed-x18))

 # Similarly, for doctests (https://github.com/rust-lang/rust/issues/146465).
 doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rustc-min-version,109100),$(comma)sanitizer)
--
2.52.0


