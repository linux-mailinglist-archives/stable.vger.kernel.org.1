Return-Path: <stable+bounces-230099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBiqGvNgwmmecAQAu9opvQ
	(envelope-from <stable+bounces-230099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:01:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF105306188
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A58131112CD
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A153DFC83;
	Tue, 24 Mar 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF5PKtOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26DD3DE443;
	Tue, 24 Mar 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345853; cv=none; b=O0VvvFkBbk3wNXf1sIm18mG79mjWn6qK2IjckQro5H+q5XqjkyZeVuyphM+cV7OcTfVE5al+atToDJCiQ+731lems3KrRwya0/3CMkW553XzXzZDTbvyqrjphhLMdT8T5yDj3bmp0dZvc86mRQBx1rgyANaD+YHk6XQhM8LHKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345853; c=relaxed/simple;
	bh=DCQTYAwvE+Nv8AeY+nkNUCgLaO8QEk8j7Fnrz9I6lvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbVlvbRJjTV1tec2k4jCoXOUvBD/ChRU0f1PmmBK1ly/tzJ+0hrcVXg7YHXeeEZHlxIJPKXjJLcxRiSb12tqUAKIK4fJgxjDx8ozxWCkFsX64jPQED/vwDbVF23SQ5UqA9Tpcj9JX3koKBCJrN4Oxw9qVDK0SyAufxyNB9oUpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF5PKtOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36072C2BCB1;
	Tue, 24 Mar 2026 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774345853;
	bh=DCQTYAwvE+Nv8AeY+nkNUCgLaO8QEk8j7Fnrz9I6lvk=;
	h=From:To:Cc:Subject:Date:From;
	b=eF5PKtOGtbgpuyQhCZhlcwrgkwtz7Uf+BbukRan2h8GmRz/3c6thDi5e/zkZl0U/T
	 av7oSb87qMX8aVgTArr7zf/+eZiR3kqB8MzeIqGhajQGF83325AANMneCvzNaQheh2
	 VfbOh2S0KcQ+fqfBHohKgpt5tlD9KOEcbH3Zybr9BSXhXWQsYfiQkEx0Me0deBliHR
	 cBz6KZMqIzWn0ooyQ4hZFnTONY9J9u12t9kZq2116QW+AQ6VVu+Fls/4b7TzkaMW96
	 CYGHpkOSC8XGRmesRsGZThc34smvb37lzzPY0nDBrpapCgq/CgV5FGBi2TDQk6rcIs
	 aJbKPavmHN1eA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 0/2] selftests: mptcp: specific fixes for v6.1
Date: Tue, 24 Mar 2026 10:49:37 +0100
Message-ID: <20260324094936.1826804-4-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=matttbe@kernel.org; h=from:subject; bh=DCQTYAwvE+Nv8AeY+nkNUCgLaO8QEk8j7Fnrz9I6lvk=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIPxRkq7jJf3jc3vMZ2w+nbVSKHjSUbE+x3CP/zizrWX GFn2bKro5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCIXrjP80369ep7OFXGZSb/Z 9F2qP5zo4Nx2+HLXGfctCdn1VSdmuTEyXK/TP/Pj4qILyppR/+0t3r6/fjmyW6bJo1974uzAbTf WMAIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230099-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF105306188
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Here is one fix, plus a new version of a patch including an adaptation
required for v6.1.

The first patch fixes an issue with the MPTCP Join selftest, only
visible in selftests from the v6.1 tree: it is required to explicitly
stop the test with another dedicated helper.

The second patch is a backport that needs to be adapted to work with the
selftests suite on v6.1.

Matthieu Baerts (NGI0) (2):
  selftests: mptcp: join: implicit: stop transfer after last check
  selftests: mptcp: join: check removing signal+subflow endp

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.53.0


