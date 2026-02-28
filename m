Return-Path: <stable+bounces-220107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIVROiMpo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151101C50E6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B8C1309BAA2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C80C47D94A;
	Sat, 28 Feb 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu1BLb9t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F947DD4A;
	Sat, 28 Feb 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300016; cv=none; b=KFPE8cFcfLI8tOJubopxy8ItR4ziqKF5T8LIFctswqAX+1fo99ZpToT5NkAoIvL30ZX/+Y2zxfw75Giw17O6GkIRuC4GHBX4iCn+v2A7lKSuaX9aiG/SaQaq+n9V7nYCpARXdPSXhNwlkeK7Sh9pfoDYV+ybvut0x0mLGhoYhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300016; c=relaxed/simple;
	bh=GhDcMxB0dkxuFqlAzjTKzKEfE96+SmqNYcX3i2Jy8N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wl9El+fNVwqkWCVOLG62UNwyomFq8TK4gXEOkot7WXUR9VFtvmf27UWLEqwgmYp0hqLemDjhqopmDHygJxACee9ZCGSW9l+PdUl+rGbL6d3gUPdIDGrQC/v4KSkIqg71kxVpAPAIlWfgfQyCMyM4CDXHIzL3JfcNpvHTyYHlYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu1BLb9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFD7C19425;
	Sat, 28 Feb 2026 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300016;
	bh=GhDcMxB0dkxuFqlAzjTKzKEfE96+SmqNYcX3i2Jy8N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yu1BLb9tvJ338iqFApxUKuwNCy8LaVWqJHTecJJYnqGbNVoKV3Q88n3IvCao2TXWt
	 GJ97yDbmYzQcNgeNKiewtuYt7DHXlIB8dQ91WNXeDkn68mDBwZ/KUUgKA9lZGM5zzc
	 PWBnGiPZ0rvgiCwEUsTIY30sCYJLPwp1ija7g7pJCvxmqOzMNjh80nrZ3YmU3m5O2r
	 LzqDZMNRgAwtlEOj04FlqI/XNIuuev1vo4Abrx/Ar/L58mdBi+x+APX4MuX9AX2ATG
	 mk9Ipox2HZvDQnC0f9Sxxt/Z4uUHq5p5+RTIptV6dRN6ZqT5TZWhBwR69CiaANkFol
	 z/FLElqdtpZ1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 029/844] objtool/rust: add one more `noreturn` Rust function
Date: Sat, 28 Feb 2026 12:19:02 -0500
Message-ID: <20260228173244.1509663-30-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220107-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zulipchat.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 151101C50E6
X-Rspamd-Action: no action

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit c431b00ca6afc5da3133636ecc34ee7edd38d6cc ]

`objtool` with Rust 1.84.0 reports:

    rust/kernel.o: error: objtool: _RNvXNtNtCsaRPFapPOzLs_6kernel3str9parse_intaNtNtB2_7private12FromStrRadix14from_str_radix()
    falls through to next function _RNvXNtNtCsaRPFapPOzLs_6kernel3str9parse_intaNtNtB2_7private12FromStrRadix16from_u64_negated()

This is very similar to commit c18f35e49049 ("objtool/rust: add one more
`noreturn` Rust function"), which added `from_ascii_radix_panic` for Rust
1.86.0, except that Rust 1.84.0 ends up needing `from_str_radix_panic`.

Thus add it to the list to fix the warning.

Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
Fixes: 51d9ee90ea90 ("rust: str: add radix prefixed integer parsing functions")
Reported-by: Alice Ryhl <aliceryhl@google.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565/topic/x/with/572427627
Tested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://patch.msgid.link/20260206204336.38462-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3fd98c5b6e1a8..37ec0d757e9b1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -197,7 +197,8 @@ static bool is_rust_noreturn(const struct symbol *func)
 	 * as well as changes to the source code itself between versions (since
 	 * these come from the Rust standard library).
 	 */
-	return str_ends_with(func->name, "_4core3num22from_ascii_radix_panic")				||
+	return str_ends_with(func->name, "_4core3num20from_str_radix_panic")				||
+	       str_ends_with(func->name, "_4core3num22from_ascii_radix_panic")				||
 	       str_ends_with(func->name, "_4core5sliceSp15copy_from_slice17len_mismatch_fail")		||
 	       str_ends_with(func->name, "_4core6option13expect_failed")				||
 	       str_ends_with(func->name, "_4core6option13unwrap_failed")				||
-- 
2.51.0


