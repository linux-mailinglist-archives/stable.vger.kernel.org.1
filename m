Return-Path: <stable+bounces-230101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBUnDOpgwmmecAQAu9opvQ
	(envelope-from <stable+bounces-230101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:01:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB6306171
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B9D3235B0F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0843DEFE1;
	Tue, 24 Mar 2026 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej/su665"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F3A3E0225;
	Tue, 24 Mar 2026 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345856; cv=none; b=rouHLuk7qn3P9BWJe7EgDk0r/kZj+Rf2BPyPdzz/vnHmCl5ReeMsVzOyDFbDjZNTgWhLqTjO75cHdb6re3PBo0YBwL0G5V57Kj1VXFpjFoJlGN8y97B3l84rdYCR85AVi9++c6ihM3S7nVZKBzJAdA93A86Tw/afm/SHdHQAfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345856; c=relaxed/simple;
	bh=qr05f7GL58ruAJ4cL/ZakCzrxQR0FA5VbILQ6QQ/W/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIM6X+nQal3jFJAmPqUzawyV3gXPLcJ3ZYvWyDbEUWc0qjBRHa6LBGe46nIH/EFAYJUuc7X2nsWmD5qRmsK9bwlWJblIA1OmjPx7ztwrggmk8n/oJcdec1auSoYKO+IcEyFLHKbS+7EsDaWQyiQNXBXHHSiRs5TIr8aUe+Y3vyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej/su665; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043DEC19424;
	Tue, 24 Mar 2026 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774345856;
	bh=qr05f7GL58ruAJ4cL/ZakCzrxQR0FA5VbILQ6QQ/W/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ej/su665NkLZwqizRq3QilZlDqSDcRhFJNNeqJnVK7F+4IQgJtErBGmjTfDE2Xb/R
	 agtwXq3Fi/wNVukwmpHGTKo/z4iHsYMTBHLIZGK44cGBO1elid0EpewjL7rKFwwv+U
	 LEklmiwIkZXlSLPRxTJsQcBBaYObur6T8fF3Ro8HYrz3G/UDKr0jf34ZbSEiq0TV21
	 xg0b29wX9l/GHJD1s3ByeQwrNh9Y2q3mHYy0sr9pviJWYG7AcY3IPCq1vlpY+laNX7
	 bNgECbr4QE/827YgWwqw48SmA9PJ1g2yGUoc80/0N59gaBftb1W6M+vy+IQyfd4dPt
	 9eNrvSUXqFGzw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/2] selftests: mptcp: join: check removing signal+subflow endp
Date: Tue, 24 Mar 2026 10:49:39 +0100
Message-ID: <20260324094936.1826804-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324094936.1826804-4-matttbe@kernel.org>
References: <20260324094936.1826804-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=matttbe@kernel.org; h=from:subject; bh=qr05f7GL58ruAJ4cL/ZakCzrxQR0FA5VbILQ6QQ/W/0=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIPxRmfL026+WFDwpWH+bpP5pTdcnv/5ZNdye7AlYH5f A03L3516ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIsxYjwyGPBsXK5OVFHuzr mDlmvNuTeVLM0uWhzpmLups+Fa/UXszIsD3s7ec7t7cYveaX+aBpOzf02nXOoHtXTs7u3qa09d/ eMg4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230101-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[msgid.link:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[matttbe.kernel.org:query timed out,stable.vger.kernel.org:query timed out,martineau.kernel.org:query timed out,kuba.kernel.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6CB6306171
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 1777f349ff41b62dfe27454b69c27b0bc99ffca5 upstream.

This validates the previous commit: endpoints with both the signal and
subflow flags should always be marked as used even if it was not
possible to create new subflows due to the MPTCP PM limits.

For this test, an extra endpoint is created with both the signal and the
subflow flags, and limits are set not to create extra subflows. In this
case, an ADD_ADDR is sent, but no subflows are created. Still, the local
endpoint is marked as used, and no warning is fired when removing the
endpoint, after having sent a RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260303-net-mptcp-misc-fixes-7-0-rc2-v1-5-4b5462b6f016@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but in this kernel version 'run_tests' doesn't support
  parameters set via env vars: positional parameters need to be used.
  See commit 595ef566a2ef ("selftests: mptcp: drop addr_nr_ns1/2
  parameters") and commit e571fb09c893 ("selftests: mptcp: add speed env
  var") which are not in this kernel version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 044ba9c4e169..973f76557f23 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2407,6 +2407,18 @@ remove_tests()
 		chk_rst_nr 0 0
 	fi
 
+	# signal+subflow with limits, remove
+	if reset "remove signal+subflow with limits"; then
+		pm_nl_set_limits $ns1 0 0
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,subflow
+		pm_nl_set_limits $ns2 0 0
+		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		chk_join_nr 0 0 0
+		chk_add_nr 1 1
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0
+	fi
+
 	# addresses remove
 	if reset "remove addresses"; then
 		pm_nl_set_limits $ns1 3 3
-- 
2.53.0


