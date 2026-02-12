Return-Path: <stable+bounces-215943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PcxDJ6mzjWl96AAAu9opvQ
	(envelope-from <stable+bounces-215943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:04:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C09BF12CD25
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 12:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51ADF300B9FB
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3E344D81;
	Thu, 12 Feb 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi0PRiJV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CD1D5CD9;
	Thu, 12 Feb 2026 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894243; cv=none; b=C7i64zfSwcA9rly+rg9GToK9V0bdwvXkmvyfIkbV6Vzgk/8+c90AXFzFamqMZDioWtHs5VtPWzGv7zqQ8eHggp669hADDn+eCCfi3QbYihvWEhFR4vkf8+ArLPEaiQxqXd6zKAbX6n2+GDIXGSPL43X7VJo1VzR0HQtS63998n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894243; c=relaxed/simple;
	bh=5vSbprRosksE04vwNa8oFaR5lXnaQ5PV1yZExADSpyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5IG9jdYOc1pPd4qtjqN7vmqxNIHostmpVMX6ytXboAiyTAeqB8nhr6Pa7GD+YF3xc+z4/1AO83ukXQFjzbFfb0TYYdoZR4djItW0E/CU/GBQKgnOFu1Ltovq8Ku+v9Y4Vu2E2SjQYifEZ+oMeMAqajUKTOPDDosLAHyORU5D6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi0PRiJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B93C19422;
	Thu, 12 Feb 2026 11:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770894243;
	bh=5vSbprRosksE04vwNa8oFaR5lXnaQ5PV1yZExADSpyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oi0PRiJVSkn8ncOEdV4em5QI9hBsxAAytVUMx3YSv5JtHfih12nlBjIEKVP8whuO2
	 L7P8S74lMGl6SmM5B79M/ELgVSNB7yHUMm2Uwa8HYgmPZb+99ygDqGMZ9roPo7B4dh
	 eGzRkkzwZT4iY4N1M3f5uHcDnswb0QrBkQpcGnfjJw/I3VpKEq2U1JeTp0843KOO+5
	 +IOL58eHTlvQr7b+K3xLuvmJWHPYqTPNbw7U340QwESrwUh8wBdK3+Yvni2soxd6sl
	 jNcN83U3MKgvZglqHFHrPthTL/Bsug71JAhwuTFTJwCR3hgP2X4lTyCTzZjdBrppkv
	 6zQ8zVUkPSAaQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: pm: ensure unknown flags are ignored
Date: Thu, 12 Feb 2026 12:03:45 +0100
Message-ID: <20260212110344.781836-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122947-enforced-elective-e753@gregkh>
References: <2025122947-enforced-elective-e753@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3827; i=matttbe@kernel.org; h=from:subject; bh=5vSbprRosksE04vwNa8oFaR5lXnaQ5PV1yZExADSpyI=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7N090WWr9oKTn2UGz2pmi+eYXW8X6byUckdttZfl2q uuPO1ZGHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOpCGdkaPK9UrNToibkyISU GJFb/lPVZ1lYH0+SE41afynjaNLnLkaGs7J2Bp2FcpxHC2ZxXj90LEH4n2nZbo4jJ/1m7HkfXra TCwA=
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
	TAGGED_FROM(0.00)[bounces-215943-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C09BF12CD25
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
  Conflicts in pm_nl_ctl.c, because commit 69c6ce7b6eca ("selftests:
  mptcp: add implicit endpoint test case") is not in this version, and
  caused a conflict in the context which is not related to the
  modification here. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  4 ++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 68e05bd3526e..e3ab2f5ef304 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -124,6 +124,10 @@ id 8 flags signal 10.0.1.8" "id limit"
 ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
+ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags unknown
+check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags  10.0.1.1" "ignore unknown flags"
+ip netns exec $ns1 ./pm_nl_ctl flush
+
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 354784512748..e50075be0e4d 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -22,6 +22,8 @@
 #define MPTCP_PM_NAME		"mptcp_pm"
 #endif
 
+#define MPTCP_PM_ADDR_FLAG_UNKNOWN _BITUL(7)
+
 static void syntax(char *argv[])
 {
 	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
@@ -238,6 +240,8 @@ int add_addr(int fd, int pm_family, int argc, char *argv[])
 					flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
 				else if (!strcmp(tok, "fullmesh"))
 					flags |= MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else if (!strcmp(tok, "unknown"))
+					flags |= MPTCP_PM_ADDR_FLAG_UNKNOWN;
 				else
 					error(1, errno,
 					      "unknown flag %s", argv[arg]);
@@ -436,6 +440,13 @@ static void print_addr(struct rtattr *attrs, int len)
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


