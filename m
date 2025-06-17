Return-Path: <stable+bounces-154175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C637ADD842
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C245D19E0205
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90C2E54D9;
	Tue, 17 Jun 2025 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0L9RoCBe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8E2DFF1F;
	Tue, 17 Jun 2025 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178344; cv=none; b=QfcBCU5ME0VzF3yFAXWxPSr13FcMonf84dF9R6dtnN1UCaiuZd0BJh9ib4tg4TyX6lPN5wMqvreZJh/BUSyIydcFweDlsDZB3YBV27ODz/nQLHALp1lcx84gKtSz3WS+zBX+MT9L6JnfSqt+N2F8IAYAuSAcaac+UVI76JSxf+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178344; c=relaxed/simple;
	bh=GJoYqscII4zAO0rOkp2D/v+BxMLPpkcEwNm7mEylm1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZXj4f3+/7bX8GmIoM61IYWEbrxehfzRvvnRMCZhws5ZVraJqfjN4cXdSsROu1hrsfjuuICyaceWocdr6LV1Ix7LNljasYN2E8MpmXo9+zj7q6aCcVzNRMppi1zBE5R3kkczPYM36tRBQNbyEooiCaBZruAWjNynyVq514axLNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0L9RoCBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD468C4CEE3;
	Tue, 17 Jun 2025 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178344;
	bh=GJoYqscII4zAO0rOkp2D/v+BxMLPpkcEwNm7mEylm1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0L9RoCBezzGLNN29o+q6wsbcKGh/M2svQxi8f6aWa21oJcR/CrJGtTqD3H6cd720A
	 oKPUzrwPkdlB68Wlx9UmvM2bzxrmTpRppJ/m27Oaqru4Bv/mzj36/2KCHb1G3t9oOE
	 uYkFUX0skupYsuIKfuQDXTk0eVKV7IUN/tkSmBbs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Kane York <kanepyork@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.12 482/512] objtool/rust: relax slice condition to cover more `noreturn` Rust functions
Date: Tue, 17 Jun 2025 17:27:28 +0200
Message-ID: <20250617152439.131646178@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit cbeaa41dfe26b72639141e87183cb23e00d4b0dd upstream.

Developers are indeed hitting other of the `noreturn` slice symbols in
Nova [1], thus relax the last check in the list so that we catch all of
them, i.e.

    *_4core5slice5index22slice_index_order_fail
    *_4core5slice5index24slice_end_index_len_fail
    *_4core5slice5index26slice_start_index_len_fail
    *_4core5slice5index29slice_end_index_overflow_fail
    *_4core5slice5index31slice_start_index_overflow_fail

These all exist since at least Rust 1.78.0, thus backport it too.

See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
for more details.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later.
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Kane York <kanepyork@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Reported-by: Joel Fernandes <joelagnelf@nvidia.com>
Fixes: 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
Closes: https://lore.kernel.org/rust-for-linux/20250513180757.GA1295002@joelnvbox/ [1]
Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
Link: https://lore.kernel.org/r/20250520185555.825242-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/objtool/check.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -222,7 +222,8 @@ static bool is_rust_noreturn(const struc
 	       str_ends_with(func->name, "_7___rustc17rust_begin_unwind")				||
 	       strstr(func->name, "_4core9panicking13assert_failed")					||
 	       strstr(func->name, "_4core9panicking11panic_const24panic_const_")			||
-	       (strstr(func->name, "_4core5slice5index24slice_") &&
+	       (strstr(func->name, "_4core5slice5index") &&
+		strstr(func->name, "slice_") &&
 		str_ends_with(func->name, "_fail"));
 }
 



