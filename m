Return-Path: <stable+bounces-211462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0wj5LJXvdGmv/AAAu9opvQ
	(envelope-from <stable+bounces-211462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 17:13:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2403E7E17C
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 17:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A3E5300F190
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343DF23958D;
	Sat, 24 Jan 2026 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLE7fCnm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84A1DFE12;
	Sat, 24 Jan 2026 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769271184; cv=none; b=fqEgfmjKMf3gBTfoQEWlb1fRe0gpPcmDsfVQxshA8svIUVoRz+MdLv9cBaEpqPXZaLV8BOAv1TlTKZglIt1OsEMIzLFYUqBN5nhKSuMpAk37xasTjyywvVnnb78TFA0w259BWo5+c97zriOpv5XX4a2WGnRIw0nHPueqSKnF7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769271184; c=relaxed/simple;
	bh=OB4Oj3IPiEmInLRb5mbu6fz1itrOKTvgfaliwNhPdq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvB45a66v+rRjI3JQHMyhZ01WO+AbOy3uzeMM+04o4E1hgR3Wae+Oa0ljfC2Ltviwr5JQM9i29KVhksbI7k9SNmzoH31UNJud5NjFmjFyTuqcbYxl8+nMaewsFT0VONWU6ZnyBHvt7hmaIKzg/454j+oEQvwf5BDgb9kYISIJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLE7fCnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81519C116D0;
	Sat, 24 Jan 2026 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769271183;
	bh=OB4Oj3IPiEmInLRb5mbu6fz1itrOKTvgfaliwNhPdq0=;
	h=From:To:Cc:Subject:Date:From;
	b=BLE7fCnmFAl9POpj9P8Lec/b9uvHSkVoP7AVBUUBGV731WApBVjpi1/oi5st3BwBy
	 5zoYW3id0gWlEpSv5iLrwusGOVSbbdzR++4tA8bGEVaiyMSbJ8bXlYbEIOTiXqBTXE
	 ktDTaQrnnJ9/7160E1eUUjKRmkCiTKpMD5+qAqKwCT5n5RTwxh11OE7FZ+JRjaxDSZ
	 uwKNSfc55dYja2s0OUPRq14M/Vzx2Wd3dMYnlDaSA7R/stKdWcitk8eYvKM+KczZE5
	 b+RLbI/zjhBiZpK8ibRQamrLhPwAKgu/t/AIjkvx86PGtsfxWjAyEmZce5Ga0p0k5g
	 Y02zy2/59csOA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/tyr: depend on `COMMON_CLK` to fix build error
Date: Sat, 24 Jan 2026 17:09:48 +0100
Message-ID: <20260124160948.67508-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,garyguo.net,protonmail.com,kernel.org,umich.edu,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-211462-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2403E7E17C
X-Rspamd-Action: no action

Tyr needs `CONFIG_COMMON_CLK` to build:

    error[E0432]: unresolved import `kernel::clk::Clk`
     --> drivers/gpu/drm/tyr/driver.rs:3:5
      |
    3 | use kernel::clk::Clk;
      |     ^^^^^^^^^^^^^^^^ no `Clk` in `clk`

    error[E0432]: unresolved import `kernel::clk::OptionalClk`
     --> drivers/gpu/drm/tyr/driver.rs:4:5
      |
    4 | use kernel::clk::OptionalClk;
      |     ^^^^^^^^^^^^^^^^^^^^^^^^ no `OptionalClk` in `clk`

Thus add the dependency to fix it.

Fixes: cf4fd52e3236 ("rust: drm: Introduce the Tyr driver for Arm Mali GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/gpu/drm/tyr/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
index 4b55308fd2eb..e933e6478027 100644
--- a/drivers/gpu/drm/tyr/Kconfig
+++ b/drivers/gpu/drm/tyr/Kconfig
@@ -6,6 +6,7 @@ config DRM_TYR
 	depends on RUST
 	depends on ARM || ARM64 || COMPILE_TEST
 	depends on !GENERIC_ATOMIC64  # for IOMMU_IO_PGTABLE_LPAE
+	depends on COMMON_CLK
 	default n
 	help
 	  Rust DRM driver for ARM Mali CSF-based GPUs.

base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
-- 
2.52.0


