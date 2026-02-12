Return-Path: <stable+bounces-215944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBLnELG+jWkZ6gAAu9opvQ
	(envelope-from <stable+bounces-215944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:51:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E612D2E3
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C39E3008C91
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457A34DB72;
	Thu, 12 Feb 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u57jX9Km"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2482FE579;
	Thu, 12 Feb 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770897066; cv=none; b=tnM7znYteFrXyaQ4S4nJy/2RMEB10xjg3OjkKktvmpAbKuBYzKy++seN698Rumn8OpoEwCrdDNVfIBzgrWaRDwvMaAXMSOllhonSn1xdBgee224kbeJyOzHvNVZjticw2ho7CoJsmM5NCkQkrl4GfpYcYBNiGHJ4TXlm241fMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770897066; c=relaxed/simple;
	bh=WmbzLKDB0Uaqeg3tAn1+tey25NxlODgd+5JE8M2pG88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbFMEIEaHUc1f+G+6DbdLh67Uc5DDigpdyD/a4xtffEHhtmDwitlb9uTRDdGHQ0kcKFf1E4bHsei3g0iOFre9RBWkeo9gC3RUTO5NbOVfPYr9UFROxqzMBWa07KcSMepoVzanvmrg+B3ekTnVYZtAWVGprvw/4JpiLoAIqy7u7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u57jX9Km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A76C4CEF7;
	Thu, 12 Feb 2026 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770897065;
	bh=WmbzLKDB0Uaqeg3tAn1+tey25NxlODgd+5JE8M2pG88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u57jX9Km3ju/LH5+ytVyhvQI7LBpNCKNjSu0bNZicWxQGrCsqvWMJgTtNG8qHZQc8
	 F4gyV6SkzMrxOrwOaVq+MdXupEwq7hBD7RAdYBCvgMogXywJELcqDrMPXzcZNJCF3A
	 LSxd/ZXa0aW0W+acrNEvleYAHC8Aqv0jzFy3bFJvetotbMpHa5zZpGeCaI5gStW3Sv
	 /a/KD/9pC/mjS0YemjqzLlCmd+WzDaxVZ2CT6ZmULkqb92yrMIsS68mY8L/x+RhY/b
	 9qsb2n+PWf18h11G6CbU3xTQfajQ2v+wtDcur05YHqUhcJZRIovfN6vE7TxiQZNfD1
	 ob/6/tDBmAgdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] selftests: mptcp: pm: ensure unknown flags are ignored
Date: Thu, 12 Feb 2026 12:50:57 +0100
Message-ID: <20260212115056.898313-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122947-clapping-zookeeper-5d32@gregkh>
References: <2025122947-clapping-zookeeper-5d32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3927; i=matttbe@kernel.org; h=from:subject; bh=WmbzLKDB0Uaqeg3tAn1+tey25NxlODgd+5JE8M2pG88=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ79y18opx92rg+kGnPjfLyFRdsnnU5/fF+cWlXRu/6o DOnv++a31HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRcyGMDDceskVdfbDNO/zy aV/L21PtpxuezHkt/dJlo+RrllPRUy0YGX6ZeJ4NPaUR1VrKrq2wQb334qNg/6Tt59V/m2QuKdM 1ZQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215944-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5E6E612D2E3
X-Rspamd-Action: no action

commit 29f4801e9c8dfd12bdcb33b61a6ac479c7162bd7 upstream.

This validates the previous commit: the userspace can set unknown flags
-- the 7th bit is currently unused -- without errors, but only the
supported ones are printed in the endpoints dumps.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251205-net-mptcp-misc-fixes-6-19-rc1-v1-2-9e4781a6c1b8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.sh, because some refactoring have been done
  later on: commit 0d16ed0c2e74 ("selftests: mptcp: add
  {get,format}_endpoint(s) helpers") and commit c99d57d0007a
  ("selftests: mptcp: use pm_nl endpoint ops") are not in this version.
  The same operation can still be done at the same place, without using
  the new helpers.
  Also, commit 1dc88d241f92 ("selftests: mptcp: pm_nl_ctl: always look
  for errors") is not in this version, and create a conflict in the
  context which is not related to the modification here.
  In v5.10, endpoints couldn't be re-used directly, so the flag is
  tested before.
  Conflicts in pm_nl_ctl.c, because commit 69c6ce7b6eca ("selftests:
  mptcp: add implicit endpoint test case") and commit 371b90377e60
  ("selftests: mptcp: set and print the fullmesh flag") are not in this
  version, and caused a conflict in the context which is not related to
  the modification here. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  2 +-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 7d194f5c2939..9d95d7e5b70a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -80,7 +80,7 @@ if mptcp_lib_expect_all_features; then
 subflows 0" "defaults limits"
 fi
 
-ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags unknown
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.3 flags signal,backup
 check "ip netns exec $ns1 ./pm_nl_ctl get 1" "id 1 flags  10.0.1.1" "simple add/get addr"
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index b24a2f17d415..c6d7e0f2a8b8 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -22,6 +22,8 @@
 #define MPTCP_PM_NAME		"mptcp_pm"
 #endif
 
+#define MPTCP_PM_ADDR_FLAG_UNKNOWN _BITUL(7)
+
 static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|get|del|flush|dump|accept [<args>]\n", argv[0]);
@@ -236,6 +238,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_SIGNAL;
 				else if (!strcmp(tok, "backup"))
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+				else if (!strcmp(tok, "unknown"))
+					flags |= MPTCP_PM_ADDR_FLAG_UNKNOWN;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
@@ -373,6 +377,13 @@ static void print_addr(struct rtattr *attrs, int len)
 					printf(",");
 			}
 
+			if (flags & MPTCP_PM_ADDR_FLAG_UNKNOWN) {
+				printf("unknown");
+				flags &= ~MPTCP_PM_ADDR_FLAG_UNKNOWN;
+				if (flags)
+					printf(",");
+			}
+
 			/* bump unknown flags, if any */
 			if (flags)
 				printf("0x%x", flags);
-- 
2.51.0


