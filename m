Return-Path: <stable+bounces-215797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IwqGbxxjGn6oAAAu9opvQ
	(envelope-from <stable+bounces-215797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:10:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5151241A8
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F123027B61
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A63346A9;
	Wed, 11 Feb 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REaRL0za"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCEC32E6A2;
	Wed, 11 Feb 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811797; cv=none; b=dXC/aEd4pVdx1CphYnOlUC9yN009TeNxt55C8uDLjZBaY1ee4p3pszKQrP0e/bCpgH2Z3mjLjsPg42qQk5glqRhVRJLOKk2wLIXRfOu2MnpUd3M4uo5Rk0Euo69t26kWhrmN0VuEGQXNJLQvpDBpk84NO1yNkyWQ4ErphttJ5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811797; c=relaxed/simple;
	bh=pt1wvKyVyfg01TU7c1rk35773c3ENgvMi0pfYLFFq8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGkmsz2YvtAbFOAH8pBQKtO/AftBFiifsi0aCw8Hslzx9aC3FZEA5Q3t4+4M/MaO7wkCzEc3JZBxKJvSWz5NR/ZchGF3+2nmw1j8mL7zBcip3TjuQB3f97BlJJy784zIW63xVwC174d5LkcUTa+b54RnEZP7VqWVmoDd44mxkwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REaRL0za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE02FC4CEF7;
	Wed, 11 Feb 2026 12:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770811797;
	bh=pt1wvKyVyfg01TU7c1rk35773c3ENgvMi0pfYLFFq8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REaRL0zaOQp4CtUgXqsbl4nNZkCmmkIYyP51utLo8zzWVuAUYUBlQydXkwbT4O14C
	 /RecPZxs2wlhVD6lU4t1QrfT5RPSl2ns7hTF3/vOXFte8ztaTlMz+1yPznew6ERuvQ
	 tjIWCctrmcncXV/aEFP/+KLAXzmQo4wVfQ7Kg+JbxJ/DyoL7oqL+CiHzhOj7rDiZy9
	 3IS22QRa6S91cLLstK690aNhd65p4WoN4bcWnwzFXDskuCW+Pz6J62/P3WibibvGY1
	 qvDwcqnf4BKhP+gE0L8BdG33cB9uc31em/frvUedMrcpw+ahM3I+TIMNnzQxf5yUlX
	 hx5OIeExBqw8Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] selftests: mptcp: pm: ensure unknown flags are ignored
Date: Wed, 11 Feb 2026 13:09:42 +0100
Message-ID: <20260211120941.3779945-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122946-puppet-visiting-41e4@gregkh>
References: <2025122946-puppet-visiting-41e4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3436; i=matttbe@kernel.org; h=from:subject; bh=pt1wvKyVyfg01TU7c1rk35773c3ENgvMi0pfYLFFq8g=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7CtumRlXb8lz77RkiodX+4NLiyU83zlNbtOP8HG2rP /wrzOfv7ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI7geMDLN1DCZ/LWx6zXd6 ZiBj2tcjb+t+K25PbBN9YVfJVcAeycPwPy3364Re9mShhAXBjlXOD3jX34jcaNZ/VEVA5fn/fa9 mcwMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215797-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA5151241A8
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
  the new helpers. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  4 ++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 3528e730e4d3..c089d4e06d59 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -127,6 +127,10 @@ id 8 flags signal 10.0.1.8" "id limit"
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags unknown
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1" "ignore unknown flags"
+ip netns exec $ns1 ./pm_nl_ctl flush
+
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1 2>/dev/null
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 234c267dd2aa..f586f1272bd7 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -29,6 +29,8 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#define MPTCP_PM_ADDR_FLAG_UNKNOWN _BITUL(7)
+
 static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
@@ -825,6 +827,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 				else if (!strcmp(tok, "fullmesh"))
 					flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (!strcmp(tok, "unknown"))
+					flags |= MPTCP_PM_ADDR_FLAG_UNKNOWN;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
@@ -1030,6 +1034,13 @@ static void print_addr(struct rtattr *attrs, int len)
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


