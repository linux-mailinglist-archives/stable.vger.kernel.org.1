Return-Path: <stable+bounces-88362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2BB9B2598
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD8B2815F5
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979FF18E368;
	Mon, 28 Oct 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j1+XKI8z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524F018E04F;
	Mon, 28 Oct 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097163; cv=none; b=innts1fNUX3P48bjLcB5Ur9vG3nbqaAH2QZPltjDhqlFkEgJg0RIyqcT2l/k1v2NSxwvIYLL1Wg3Vo1Hg3cT59D4rOiC/ViCC94VtxOA1bFJMiJ+JboskkPQDA7Z2EIQEAKMWYQ0F5pFRPpvfRoa6iPdtQUbS+3Sh+ZG6D8Xbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097163; c=relaxed/simple;
	bh=P0OnamUFSxCC6G6eSN9WvZfCv8kJyCT5vhh57mRwAS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdVZKGSvNElFXeaaUW9jK95vNLOCxALiq25oN6VwqxVnexxIqOVISGwk82qITggrgixW569T3mVE129EH4OHyJNAgnXRCX0zTuVlwP5J3sCFFS4kgEyIKPDV6u1++8NXojp2mijDJh8Gh8ZGnu8txmKtezNmq5TcJDKIf79tT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j1+XKI8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E402AC4CEC7;
	Mon, 28 Oct 2024 06:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097163;
	bh=P0OnamUFSxCC6G6eSN9WvZfCv8kJyCT5vhh57mRwAS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1+XKI8zTS3u6R+v2wxEitIvzOIigxnCaPY60oSn0xudgzUwm36hBIVc9cpF4Ss/M
	 tNC4lYIncjsaeGTziTLaNrgYXFIpL4oRvDHnVpZrDG/ZNJYjtkUmbqaN4Mtj92dy5I
	 8nyfKwJ/rk8+70rcXrAmvOIbp3Xp54/rO4fTPPXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Sundberg <simon.sundberg@kau.se>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/137] bpf: fix kfunc btf caching for modules
Date: Mon, 28 Oct 2024 07:24:08 +0100
Message-ID: <20241028062259.033038981@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 6cb86a0fdece87e126323ec1bb19deb16a52aedf ]

The verifier contains a cache for looking up module BTF objects when
calling kfuncs defined in modules. This cache uses a 'struct
bpf_kfunc_btf_tab', which contains a sorted list of BTF objects that
were already seen in the current verifier run, and the BTF objects are
looked up by the offset stored in the relocated call instruction using
bsearch().

The first time a given offset is seen, the module BTF is loaded from the
file descriptor passed in by libbpf, and stored into the cache. However,
there's a bug in the code storing the new entry: it stores a pointer to
the new cache entry, then calls sort() to keep the cache sorted for the
next lookup using bsearch(), and then returns the entry that was just
stored through the stored pointer. However, because sort() modifies the
list of entries in place *by value*, the stored pointer may no longer
point to the right entry, in which case the wrong BTF object will be
returned.

The end result of this is an intermittent bug where, if a BPF program
calls two functions with the same signature in two different modules,
the function from the wrong module may sometimes end up being called.
Whether this happens depends on the order of the calls in the BPF
program (as that affects whether sort() reorders the array of BTF
objects), making it especially hard to track down. Simon, credited as
reporter below, spent significant effort analysing and creating a
reproducer for this issue. The reproducer is added as a selftest in a
subsequent patch.

The fix is straight forward: simply don't use the stored pointer after
calling sort(). Since we already have an on-stack pointer to the BTF
object itself at the point where the function return, just use that, and
populate it from the cache entry in the branch where the lookup
succeeds.

Fixes: 2357672c54c3 ("bpf: Introduce BPF support for kernel module function calls")
Reported-by: Simon Sundberg <simon.sundberg@kau.se>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/20241010-fix-kfunc-btf-caching-for-modules-v2-1-745af6c1af98@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb4073781a3c7..bb54f1f4fafba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1924,10 +1924,16 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 		b->module = mod;
 		b->offset = offset;
 
+		/* sort() reorders entries by value, so b may no longer point
+		 * to the right entry after this
+		 */
 		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
 		     kfunc_btf_cmp_by_off, NULL);
+	} else {
+		btf = b->btf;
 	}
-	return b->btf;
+
+	return btf;
 }
 
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab)
-- 
2.43.0




