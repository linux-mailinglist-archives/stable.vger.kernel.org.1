Return-Path: <stable+bounces-243391-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N1iERar+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243391-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19124BF1A8
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1E07305C5B8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720513D5667;
	Mon,  4 May 2026 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cOYAKPup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ACF40DFD4;
	Mon,  4 May 2026 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903763; cv=none; b=GC+SlTYuRUStmdTfsBeWeBZ7upo6PtUxeog22om1g3lTsqrl+rPxJ3kjG4lRZIsLDHb9VWBTGeQ2Ojy1wB2M7WNF9V1nhO+4oRmg+ohy6gLW8YVVRhr8eXV5qY6F0fpJgvHOUZfrrQW0s5fH/qh8Sys11whBkGJpxrWx5zPxsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903763; c=relaxed/simple;
	bh=rF67f38UHQtLWlZ6LAlEo5QmuQj/2R1pjWL/XquRrzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOXE5ClQfrs89Aa6ig2PlGh9KWeIeTJXYZfGGn6Xbu5od5sa7FPEqkP90DywEh788OtcC5wptB5NdjvcqY+FFaracKz08tAlccHdBnG3ng+J6qEMuKwzYpEOXQXTYv+EafX7OjdFWz7YPHL1/yfXCq4SOfwdRrO4Pkjy2fNF6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cOYAKPup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6BCC2BCC4;
	Mon,  4 May 2026 14:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903763;
	bh=rF67f38UHQtLWlZ6LAlEo5QmuQj/2R1pjWL/XquRrzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOYAKPupvmGiNpdEYUY5njWqFMnkcHoSHQc1qiakay+jo/+zCbn+1GnfALewqiILB
	 Wq0FvdSKZowWGvHGZXW1oa+gjy96iOnZCOvDd8B+QIR1DqmxHb5wqaPJ1WSLaqP4gA
	 5v4ktPKd97JmoVffmkXExfDh9QIM9iHHxe2GxHDk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.18 020/275] kbuild: rust: allow `clippy::uninlined_format_args`
Date: Mon,  4 May 2026 15:49:20 +0200
Message-ID: <20260504135143.688077555@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A19124BF1A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243391-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,rust-lang.github.io:url]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

commit 10eea3c147141c90cf409b8df56d245c9d7f88d9 upstream.

Clippy in Rust 1.88.0 (only) reports [1]:

    warning: variables can be used directly in the `format!` string
       --> rust/macros/module.rs:112:23
        |
    112 |         let content = format!("{param}:{content}", param = param, content = content);
        |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
        = note: `-W clippy::uninlined-format-args` implied by `-W clippy::all`
        = help: to override `-W clippy::all` add `#[allow(clippy::uninlined_format_args)]`
    help: change this to
        |
    112 -         let content = format!("{param}:{content}", param = param, content = content);
    112 +         let content = format!("{param}:{content}");

    warning: variables can be used directly in the `format!` string
       --> rust/macros/module.rs:198:14
        |
    198 |         t => panic!("Unsupported parameter type {}", t),
        |              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
        = note: `-W clippy::uninlined-format-args` implied by `-W clippy::all`
        = help: to override `-W clippy::all` add `#[allow(clippy::uninlined_format_args)]`
    help: change this to
        |
    198 -         t => panic!("Unsupported parameter type {}", t),
    198 +         t => panic!("Unsupported parameter type {t}"),
        |

The reason it only triggers in that version is that the lint was moved
from `pedantic` to `style` in Rust 1.88.0 and then back to `pedantic`
in Rust 1.89.0 [2][3].

In the first case, the suggestion is fair and a pure simplification, thus
we will clean it up separately.

To keep the behavior the same across all versions, and since the lint
does not work for all macros (e.g. custom ones like `pr_info!`), disable
it globally.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://lore.kernel.org/rust-for-linux/CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com/ [1]
Link: https://github.com/rust-lang/rust-clippy/pull/15287 [2]
Link: https://github.com/rust-lang/rust-clippy/issues/15151 [3]
Link: https://patch.msgid.link/20260331205849.498295-1-ojeda@kernel.org
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/Makefile
+++ b/Makefile
@@ -492,6 +492,7 @@ export rust_common_flags := --edition=20
 			    -Wclippy::ptr_cast_constness \
 			    -Wclippy::ref_as_ptr \
 			    -Wclippy::undocumented_unsafe_blocks \
+			    -Aclippy::uninlined_format_args \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
 			    -Wrustdoc::missing_crate_level_docs \



