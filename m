Return-Path: <stable+bounces-78286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A30F98A9AB
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 18:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EACB24FE8
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E819306F;
	Mon, 30 Sep 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXzjRDLu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A54192D63;
	Mon, 30 Sep 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713464; cv=none; b=isi3WRlAwKEsGMzKKml+QIFjS8fIxQe0yeibdTz+aMmGQ5ISqUZxhoSR8XkvDFG4KngSOrV2kf2awNRaC2+h2lGh5UxEY4Jj4lrD988TVYXwuM/3UqMLi4cs4KEZtq7f3AsX4no44vh51k+TT7KazUwFPuQcUicHUDjgac9AAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713464; c=relaxed/simple;
	bh=LuWZmlEl90l+h/fcAwJcJAWvKf2Ce+f9pJsYi9NlZfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOogHfQvGl5eu8seoJ+SC8J1HInnrBtooi5cK+HsGWqeOnTttQR4SyH9CaINtBCtYdnOMkpypm4yL9KW9beKSnXzTw8TLicKzkyCfJIJcmhfqPcdPPvb3I+oQc0WNISTkgGOxIwmP0RWAS3IVSGZHJ/0f5Lw5s/Nuvh1bsI1Jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXzjRDLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0033DC4CECE;
	Mon, 30 Sep 2024 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727713463;
	bh=LuWZmlEl90l+h/fcAwJcJAWvKf2Ce+f9pJsYi9NlZfQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OXzjRDLuPPwuYQtECUg9oMRfgD0vTHxikNUiNeNxrkBM9Ga8P1kVTUHUT6iTE5I3u
	 rKPK7x63SarjyGtE3Pc9KrqbcNMv67/jlFmfhTbNDe9kFEm+JFLzDWiIfZ5fWACD6i
	 kkCo1+Y6J8SQs3twoDQBrXSmEIDjdYgWo5Lh6Qbt7UUyeBSjF9Xzj5pQotQCu0/jzi
	 lUpYg0clx6wvVzYKzaHVbEaivvaByMzuM45c/chZXG5IIV/1V3ox0fnWgq2XDP3zwG
	 w94X+z+by1tOQo+vaq15eZj6P88sO3sWR4KhIUiwcpv4OHriIG++XjkBOBhG8FIKmE
	 eVb3aoUdj7tuw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.10.y] mptcp: fix sometimes-uninitialized warning
Date: Mon, 30 Sep 2024 18:23:46 +0200
Message-ID: <20240930162345.3938790-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3272; i=matttbe@kernel.org; h=from:subject; bh=LuWZmlEl90l+h/fcAwJcJAWvKf2Ce+f9pJsYi9NlZfQ=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm+tCRbT2FVB51qBPHsTkRz8nwZaSgm/0QKbZ48 Pm1BrtTwsuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZvrQkQAKCRD2t4JPQmmg czkyD/9qNobxHWxb03ZlAbDMlsYfcHPobqLM2N7mTRDO0wWUnyp8sFth/jE6L4TF56mmfo+g5ed WwL3jfV5hmPRukBalLZ6WOAyKkQxJursMqFt1kRloq3W0c8LcT4FM2IudV/BzM/cjGTL8Np1dn3 1i8wo+TlZPTEm10Q1QZA18TWVL6TdOv46PLFqZzccdHag2L37o6qzuz1uW70wUHWBJljWKHtEhn MeQi0bj66CpVOKsXMcrKqb9EXyCVa18X/9sDUmQo/D90ibb7wXBBv3Sn2iK2pKcUj5jUD8VBkuu AQRQhKqhv5aqZBTcm+2Cz+GCa/oVjpfMOW8tJtSOv/f+bhRUtGNZzqL+YbiHQEvGP8kBKHtV9oD lpdLIZoBtJaWLZ1tkJ6bGmGlVXOBWjKY419K6V6xpkzYJZCY/lDN/eAbHmU0kBesv4qZ1/SS+FG d0KTGcLw0ttv2n0Nm85MNUbgdKqjWcpwC5r7RqsnBQVj/4hmPwWBvq6cYpJwgYKb0EvIGrU+m8K AL5KI4jkMMIIk1VoI8+b6funvpRdylGGLXISrM1JkhnInwVxP59S02Cd3t/xMyjfxC6cA9AQAd1 xVAZZOW7UuotRAFodwH6UF2Nhy7HgAu2ZDBYwU0wmSPLcf7p4xaSvZOeKZdEuA7t+xaHtilOHRx fuRsuczGsiE9NkQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Nathan reported this issue:

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 LLVM_IAS=1 mrproper allmodconfig net/mptcp/subflow.o
  net/mptcp/subflow.c:877:6: warning: variable 'incr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    877 |         if (WARN_ON_ONCE(offset > skb->len))
        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/asm-generic/bug.h:101:33: note: expanded from macro 'WARN_ON_ONCE'
    101 | #define WARN_ON_ONCE(condition) ({                              \
        |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    102 |         int __ret_warn_on = !!(condition);                      \
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    103 |         if (unlikely(__ret_warn_on))                            \
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    104 |                 __WARN_FLAGS(BUGFLAG_ONCE |                     \
        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    105 |                              BUGFLAG_TAINT(TAINT_WARN));        \
        |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    106 |         unlikely(__ret_warn_on);                                \
        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    107 | })
        | ~~
  net/mptcp/subflow.c:893:6: note: uninitialized use occurs here
    893 |         if (incr)
        |             ^~~~
  net/mptcp/subflow.c:877:2: note: remove the 'if' if its condition is always false
    877 |         if (WARN_ON_ONCE(offset > skb->len))
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    878 |                 goto out;
        |                 ~~~~~~~~
  net/mptcp/subflow.c:874:18: note: initialize the variable 'incr' to silence this warning
    874 |         u32 offset, incr, avail_len;
        |                         ^
        |                          = 0
  1 warning generated.

As mentioned by Nathan, this issue is present because 5.10 does not
include commit ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling"),
which removed the use of 'incr' in the error path added by this change.
This other commit does not really look suitable for stable, hence this
dedicated patch for 5.10.

Fixes: e93fa44f0714 ("mptcp: fix duplicate data handling")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/20240928175524.GA1713144@thelio-3990X
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8a0ef50c307c..843c61ebd421 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -871,7 +871,7 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
 	struct tcp_sock *tp = tcp_sk(ssk);
-	u32 offset, incr, avail_len;
+	u32 offset, incr = 0, avail_len;
 
 	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
 	if (WARN_ON_ONCE(offset > skb->len))
-- 
2.45.2


