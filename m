Return-Path: <stable+bounces-188992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3757EBFC36C
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3998623F1A
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B0347FEA;
	Wed, 22 Oct 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mA+nzBVN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7mzJ7up"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A3347BB5;
	Wed, 22 Oct 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139746; cv=none; b=s4m6Wcaenr5mCtBcrxYd2uNteyUYtA8feaED/Lku6DjGV8nwFJEMCGi6WtkqKwlG7kbw3JbVUo43fpbvZb9o4EI3G1I2VTu439kwXjgk8/90YFdh8dtfujY6m8Bj0KKeG/hs+EGESRfVouqd7+kKRt51d6Qkg1zxBN10SYou77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139746; c=relaxed/simple;
	bh=lASrV+lg74tI5vkAZ1p8e1vRd8+2vg9y+XEuoj3s9Uw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SIRJTr22B/pjaUbdUBQIMVdLD/HRjZ4V4WeCWXx/GTlkr9x4neKcCs6v0TuNRWBqQL+O/c3YM6trsjWVT2sz5onmljRIT38WLafK+TV1q0XkIQ8Im6To98Pr6TGchNSRGN+FzgG9GBKaziT3JeaSQl+yT9BQ4YkAGV3HUULbYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mA+nzBVN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7mzJ7up; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Oct 2025 13:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761139740;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2nGgeh8WCh5wwSwOMhpS9Pzc4rU4sUJV1uqh4EHJzU=;
	b=mA+nzBVNSLBZkuMhX1lxV1a0RM1BSrzV9l/hgZkLknPK+VtYHp3QxYY7NVM3u/iii6slue
	M6wFHXnOZ/d1v6uTSShCGzouilbsSEEOFHHtjxHW2PPNgPIKrhW1pAHbZZ2UzeKK0WmtEP
	ELrRZ4x5Cg8dod8LnOiiaPW5AICzF9IoGBGJ6PGDGVsftQBGzWiK1nsEfGAbUP7KU2BaHk
	d0WmYvg8q3KsAXPU8eEUcSbepEa28TotSMjkRPD9WugoMW099rIuwpcWKdKq8kOii5+7Xv
	Z2S+ij1TkhJn8beBJB80rplwAZHJqVM4kWJueT3t6zxZtWUKW7jxID5y8eLMkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761139740;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2nGgeh8WCh5wwSwOMhpS9Pzc4rU4sUJV1uqh4EHJzU=;
	b=J7mzJ7upEd8C4mSzAwDiwRinxvVbvlD9ZbVmQYrujjmBvaAfJsvpel+oy/vVoRlOhmy32N
	Rm+eIF4vfjC89QAg==
From: "tip-bot2 for Miguel Ojeda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool/rust: add one more `noreturn` Rust function
Cc: Miguel Ojeda <ojeda@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, Needed@tip-bot2.tec.linutronix.de,
	in@tip-bot2.tec.linutronix.de, 6.12.y@tip-bot2.tec.linutronix.de,
	and@tip-bot2.tec.linutronix.de, "later."@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020020714.2511718-1-ojeda@kernel.org>
References: <20251020020714.2511718-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176113973927.2601451.11243642514167472736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     dbdf2a7feb422f9bacfd12774e624cf26f503eb0
Gitweb:        https://git.kernel.org/tip/dbdf2a7feb422f9bacfd12774e624cf26f5=
03eb0
Author:        Miguel Ojeda <ojeda@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 04:07:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Oct 2025 15:21:54 +02:00

objtool/rust: add one more `noreturn` Rust function

Between Rust 1.79 and 1.86, under `CONFIG_RUST_KERNEL_DOCTESTS=3Dy`,
`objtool` may report:

    rust/doctests_kernel_generated.o: warning: objtool:
    rust_doctest_kernel_alloc_kbox_rs_13() falls through to next
    function rust_doctest_kernel_alloc_kvec_rs_0()

(as well as in rust_doctest_kernel_alloc_kvec_rs_0) due to calls to the
`noreturn` symbol:

    core::option::expect_failed

from code added in commits 779db37373a3 ("rust: alloc: kvec: implement
AsPageIter for VVec") and 671618432f46 ("rust: alloc: kbox: implement
AsPageIter for VBox").

Thus add the mangled one to the list so that `objtool` knows it is
actually `noreturn`.

This can be reproduced as well in other versions by tweaking the code,
such as the latest stable Rust (1.90.0).

Stable does not have code that triggers this, but it could have it in
the future. Downstream forks could too. Thus tag it for backport.

See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
for more details.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Cc: stable@vger.kernel.org # Needed in 6.12.y and later.
Link: https://patch.msgid.link/20251020020714.2511718-1-ojeda@kernel.org
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a577057..3c7ab91 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -217,6 +217,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	 * these come from the Rust standard library).
 	 */
 	return str_ends_with(func->name, "_4core5sliceSp15copy_from_slice17len_mism=
atch_fail")		||
+	       str_ends_with(func->name, "_4core6option13expect_failed")				||
 	       str_ends_with(func->name, "_4core6option13unwrap_failed")				||
 	       str_ends_with(func->name, "_4core6result13unwrap_failed")				||
 	       str_ends_with(func->name, "_4core9panicking5panic")					||

