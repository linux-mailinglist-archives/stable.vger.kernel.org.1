Return-Path: <stable+bounces-246661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNVWBjaQA2ru7QEAu9opvQ
	(envelope-from <stable+bounces-246661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:40:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2895296FA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE42630C4FE3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53FF3C277F;
	Tue, 12 May 2026 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFgIX3Cx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934B3AF646
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617486; cv=none; b=JEOzbocoJf7Og+USDf5H2uViZLN1oI8fvDxcxLKyxGWxM10t0GXgGeN8f6BPQ+sgY87Thk/O3ch8uk/U9W9GO6/YOOTM1t3p4/4ic/ZAA1Mk/j0SwtFmw0MoIxI0JWsW9SVaTtCQWZTBIgtOn8ZSn6fO7qCfkOcZT8Z5LPLHbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617486; c=relaxed/simple;
	bh=xacbW+Wl6peUre2gYAzbj/4sgl6sTi+VTDCe9eRVMF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCvdftLyQEoWsCloNbER14GE3b3ZRYucRpOEX1fCYLS3WzGvQ269a0n+ndJI4MHmyNdryLiSpUUiOTdMyVIZ0rEwtdzPGrRbBmFCAl2Ey7/0UKbHgm7JzroaP9i+nJgvKpEkSRCEKlJDb0WemzSNX+PaOkBoyMxPwHFiFeGLjTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFgIX3Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9CFC2BCB0;
	Tue, 12 May 2026 20:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778617486;
	bh=xacbW+Wl6peUre2gYAzbj/4sgl6sTi+VTDCe9eRVMF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFgIX3CxxOl2KDxDx1G4J+u6JB0HcKpWjg0q4OXFpyf3fHT6rjEm0qLMh17TMnnom
	 Cj8Y6w8FCHDEQXq6my0TZDEa8o00EesLxeWj8R6WmvukQBQuYxWaXxZ0zsf31toqbU
	 c6j3fSjLw+2HYO1qyg/SU4U51peND2n/0HM8Zppll1NdShDMxD6kHcDUkEk8v+VmNU
	 N4b7UiMoRq5wITapfzUXoM54wrdLqYvQjXjv5KlvxKUcTH8euKj+/GDsHvgcxvzWpu
	 IMaGe+QlD574KehqzCG3rng0OK+qHSSNTjVJzkPuWWA4Y77ddBV8OmFQIdJUxreQPQ
	 fZMc9ay19mlFA==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: gary@garyguo.net,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12.y] rust: allow `clippy::collapsible_if` globally
Date: Tue, 12 May 2026 22:24:39 +0200
Message-ID: <20260512202439.308523-1-ojeda@kernel.org>
In-Reply-To: <20260512201618.304954-1-ojeda@kernel.org>
References: <20260512201618.304954-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0E2895296FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[rust-lang.github.io:url];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246661-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.413];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:email,rust-lang.github.io:url]
X-Rspamd-Action: add header
X-Spam: Yes

Similar to `clippy::collapsible_match` (globally allowed in the previous
commit), the `clippy::collapsible_if` lint [1] can make code harder to
read in certain cases.

Thus just let developers decide on their own.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/rust-for-linux/DGROP5CHU1QZ.1OKJRAUZXE9WC@garyguo.net/
Link: https://rust-lang.github.io/rust-clippy/master/index.html#collapsible_if [1]
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://patch.msgid.link/20260426144201.227108-2-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
(cherry picked from commit 2adc8664018c1cc595c7c0c98474a33c7fe32a85)
[ Removed Binder change. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Greg/Sasha: I based this on the other one, i.e. this needs to be applied
after the one I am replying to.

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 2c6b5339c471..fe352fdd6d7c 100644
--- a/Makefile
+++ b/Makefile
@@ -453,6 +453,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Aclippy::collapsible_if \
 			    -Aclippy::collapsible_match \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
--
2.54.0

