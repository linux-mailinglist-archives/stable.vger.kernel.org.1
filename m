Return-Path: <stable+bounces-220764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x6SeKRFBo2lC+wQAu9opvQ
	(envelope-from <stable+bounces-220764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F551C6F3E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76009311928F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D307492508;
	Sat, 28 Feb 2026 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjrLBFE0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400444059A0;
	Sat, 28 Feb 2026 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300644; cv=none; b=N+WivQ09FcjhSRU40fCOeNComd6HiH0PeRJ7pR7Ub6Smo2fh3TaxFGIHTwg7y+ap5NKa2/c8LDr3mLPUclDAGCmdUZ96S/yh4JyMSAkfZtFYCoOO2oUT72LgNEU5cSnwbYBlTwf9Fz8E1fscqVwVAJAeT3Jgo4TnWNfVcoWA+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300644; c=relaxed/simple;
	bh=AedUg56Kv4+hZRWO362YEp7CZLERRZDvK76EqmWpuKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2YuHQwFrp2/CYvPhB1xFScgORHXMEFUEfcsM0pTsPmUfZGeugvGQLewZFNYR1fpAb1XdNm2SZU35zSz6jM5PnBUl4RkazRR8QThf7y9mOoT94vvqf3jtHSRDq0IDlGjvZD+vhkcfCYodW9Ifcio9mElCudBXzwmQwqPaE1VMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjrLBFE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E284C116D0;
	Sat, 28 Feb 2026 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300644;
	bh=AedUg56Kv4+hZRWO362YEp7CZLERRZDvK76EqmWpuKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjrLBFE057s/AlBze4ChGNQJ6qEJ2sSQUF/oKtnM41wKHBNDmKInf6AgpNcySMmjq
	 Tun2IkcfL+AOHEloPpea+9p0flLiXEcUHe2WWCs25KQgtml4x+qGZjJpcs6Y3SWMMi
	 YXa9reyHxCcerLxBJC8y+gOx1f//UixxIj642vgStBcXVqRksKeREHVQYo9Liba8rj
	 q4nxHplZ4MIec4O6wUaeDNVeKIKOzvZ/qAxDYVVpb83dAkiph8eluGOZ5auGrmtuIt
	 yl7RUHyOXjuCtHPj7qQUgzDhk0MU5k/Iqxbu+gyndEy7DwQFPtutYXGkU9TnE2USHo
	 UTBgPOVeaXC/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 685/844] rust/drm: Fix Registration::{new,new_foreign_owned}() docs
Date: Sat, 28 Feb 2026 12:29:58 -0500
Message-ID: <20260228173244.1509663-686-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220764-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21F551C6F3E
X-Rspamd-Action: no action

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit 638eeda8abaa3e6afe6bd5758ef8045a7f33b9a0 ]

Looks like we've actually had a malformed rustdoc reference in the rustdocs
for Registration::new_foreign_owned() for a while that, when fixed, still
couldn't resolve properly because it refers to a private item.

This is probably leftover from when Registration::new() was public, so drop
the documentation from that function and fixup the documentation for
Registration::new_foreign_owned().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Fixes: 0600032c54b7 ("rust: drm: add DRM driver registration")
Cc: <stable@vger.kernel.org> # v6.16+
Link: https://patch.msgid.link/20260122221037.3462081-1-lyude@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/kernel/drm/driver.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index f30ee4c6245cd..e09f977b5b519 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -121,7 +121,6 @@ pub trait Driver {
 pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
 
 impl<T: Driver> Registration<T> {
-    /// Creates a new [`Registration`] and registers it.
     fn new(drm: &drm::Device<T>, flags: usize) -> Result<Self> {
         // SAFETY: `drm.as_raw()` is valid by the invariants of `drm::Device`.
         to_result(unsafe { bindings::drm_dev_register(drm.as_raw(), flags) })?;
@@ -129,8 +128,9 @@ fn new(drm: &drm::Device<T>, flags: usize) -> Result<Self> {
         Ok(Self(drm.into()))
     }
 
-    /// Same as [`Registration::new`}, but transfers ownership of the [`Registration`] to
-    /// [`devres::register`].
+    /// Registers a new [`Device`](drm::Device) with userspace.
+    ///
+    /// Ownership of the [`Registration`] object is passed to [`devres::register`].
     pub fn new_foreign_owned(
         drm: &drm::Device<T>,
         dev: &device::Device<device::Bound>,
-- 
2.51.0


