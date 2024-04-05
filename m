Return-Path: <stable+bounces-36146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C022589A37E
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 19:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E295E1C216E4
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11039171664;
	Fri,  5 Apr 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSSKk9vj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA42916132B;
	Fri,  5 Apr 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338242; cv=none; b=HYjUqNUdqBR1q8tn4iB3TAddpTRpDBMtNjSjGq/dQ614eLa6T/pm51kwy75nAKPna3n5JFks2hnQneCavu9LlXPJj/MXNoPcRm/8tZm7QTSwO4zAOn4rgah/PRm7dyXnG4SbSOrIvlclF60NIoB0T389jwTETqe1wHYZw0p9pSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338242; c=relaxed/simple;
	bh=JmJWRFqaN4fpcnp3j8sehmjBiBJSiY9vT0z0AqxntVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hognvxs5U7CL5AuH+q1vwXoDUcir8zq8+dZIurVnu1qOdKcNoTuKP8eH49Tcw7q9cwWSgFYJAPWbN58bK8/NnZlpynhbApjkz++/aDfC4Uc1iCbYbcC6SKcUPLGKJRu8O5x9spMVhJ7PBMfeoBxYTmSX8hKfaWauD9kfGTUIf2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSSKk9vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1912EC433F1;
	Fri,  5 Apr 2024 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338242;
	bh=JmJWRFqaN4fpcnp3j8sehmjBiBJSiY9vT0z0AqxntVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSSKk9vj9S489bIvwJWVrC5QUPk3OrL2f4BNJS4Pr/oHW9Ub2Wmc8GfSb7hvjVRs8
	 ff38kSTrb83LGipCm+Bot8rfwnFpg0RBPglbwotEJlK6OqBgL8UYgYJ5hRnrJqvY+V
	 D8Gv2pmTBoUDWOeOjK19DGZmS49GqNya4h01nNo8jqSqzeigV46+UqYd2fLTwAXYcZ
	 6kLBZlIpkOHj6VZ3MUDTRioZc/5h8DFDdqBdGxZteKzT4RuPCdn7c2LIe8uHNVykr8
	 eyvsbFs9gAdVU+hH0/pMSM1y4YptLzLngCINyx5jr1lnmV0idX/qkMBVkoyLRgtJCJ
	 pBEOQ/3c9DvLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Davide Caratti <dcaratti@redhat.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] mptcp: don't account accept() of non-MPC client as fallback to TCP
Date: Fri,  5 Apr 2024 19:30:35 +0200
Message-ID: <20240405173034.1471178-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040524-stitch-resolute-ead5@gregkh>
References: <2024040524-stitch-resolute-ead5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3508; i=matttbe@kernel.org; h=from:subject; bh=YmdsKse0Kap7VhQqGo7ToCdwNcOQp486numoobr1WO0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEDU6rr7eFvYGqTgb4Nt9IftHrSgAt1u+nPTe0 7lC1zxufTqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhA1OgAKCRD2t4JPQmmg c1qiEADdqObqTb/2jK6/ezQFoi7HSFB65HiVP1NvbfQrJbr4C4bzf+0yOTa/keIe54wLUiQJG9N KJ3QCU8ZH4HwGzPTVIa13K67SeZlwcMJw6QWlMlVO+k/lljiHia6KF0KfPuEPEVkef5rRY6OP0A FgNwyDnyPZ9oAuBn4RQva0rPC4ZzJlvYA+wyf5zcUtpzUKogtjJW33oxD5n294pQs6rm5mpm/48 rOPR+gdnt7T6vgC5cGqcwiacUpglRzXgBkUfO6TjAr2b0WYuHNLHjsF7gnknZkf9eHiMvHvgS4G c/oX/AAH8NcXuI76lYw2E0DpdcMxOSBcFtPksJFZ6FWZ9LnCRyIMZ+jzjhhzmlC6LGULOBvAC6s zBJ4670kSYNC5zjRu4RiVAJkCxQ79Gttkwc7Zdzc/9uQoNksyAiQa4834/doA2BYAt9mZMROpRn vzVTSLMek7D9gyoamEl0wcYj4wSZ5GFzEeDq4b8EcE6y2Rj3HmAFtvk6jRBQsu68I4mUQUyCvAo MUQt9IqUltIUriQlKch8LjzTmuYWz9WZv2rHWTfUPVFFHTqxxIS7j0+IOCxEfd1kCyW4/dftp7m +WMZ7Vyre6GsDdbqLW25Xbsv1veDAB4Q0lxgPL2QJzgJLyq30e1aMGIVR/16RFOW5S8nsTZOnGD Yzbn4yR11JhFcqQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

Current MPTCP servers increment MPTcpExtMPCapableFallbackACK when they
accept non-MPC connections. As reported by Christoph, this is "surprising"
because the counter might become greater than MPTcpExtMPCapableSYNRX.

MPTcpExtMPCapableFallbackACK counter's name suggests it should only be
incremented when a connection was seen using MPTCP options, then a
fallback to TCP has been done. Let's do that by incrementing it when
the subflow context of an inbound MPC connection attempt is dropped.
Also, update mptcp_connect.sh kselftest, to ensure that the
above MIB does not increment in case a pure TCP client connects to a
MPTCP server.

Fixes: fc518953bc9c ("mptcp: add and use MIB counter infrastructure")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/449
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240329-upstream-net-20240329-fallback-mib-v1-1-324a8981da48@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 7a1b3490f47e88ec4cbde65f1a77a0f4bc972282)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - Conflicts in protocol.c: because commit 8e2b8a9fa512 ("mptcp: don't
    overwrite sock_ops in mptcp_is_tcpsk()") is not in this version, but
    it depends on new features, making it hard to be backported, while
    the conflict resolution is easy: just remove the MIB incrementation
    from the previous location.
  - Conflicts in subflow.c: because commit a88d0092b24b ("mptcp:
    simplify subflow_syn_recv_sock()") is not in this version, but it
    depends on new features, making it hard to be backported, while the
    conflict resolution is easy: just move the MIB incrementation where
    the subflow context is dropped (fallback to TCP).
  - Conflicts in mptcp_connect.sh: because commit e3aae1098f10
    ("selftests: mptcp: connect: fix shellcheck warnings") and commit
    e7c42bf4d320 ("selftests: mptcp: use += operator to append strings")
    are not in this version. The dependency chain looks too long, and
    probably not worth it trying to resolve the conflicts here when many
    CIs use the selftests from the last stable version, not this old
    stable one.
---
 net/mptcp/protocol.c | 3 ---
 net/mptcp/subflow.c  | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index adbe6350f980..6be7e7592291 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2218,9 +2218,6 @@ static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
 		local_bh_enable();
-	} else {
-		MPTCP_INC_STATS(sock_net(sk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	}
 
 out:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 607519246bf2..276fe9f44df7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -595,6 +595,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			if (fallback_is_fatal)
 				goto dispose_child;
 
+			if (fallback)
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
+
 			subflow_drop_ctx(child);
 			goto out;
 		}
-- 
2.43.0


