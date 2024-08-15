Return-Path: <stable+bounces-68450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07595325A
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0876C1F21B64
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2011ABEA7;
	Thu, 15 Aug 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VVoKu1UI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB901ABEB6;
	Thu, 15 Aug 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730609; cv=none; b=R+PLc1cJHNuB+Mkv3ZSQXN4V9qbp3PVFdSL8CLhFwRh6IncMt9uvv0FNfXGgODQHujLoN5C05NpemqZWC1zDrRw9z/PtzqrmgeVdvXsDwMPWIDqj3Gugfq9MleriIaEg3uQhwSokAJW+HBY/+Snyd+wTZLI6FOKWthIauoDSTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730609; c=relaxed/simple;
	bh=VfjlkwwWQFaxsbnb3F+gwgs7SrjRD3NURL0b0Y6cdrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yxx/Xaqs/aEkUy2PBl0G3WAw3heDPn1EPF46HgpMvsyVgcNjqzdQJHcojUgsVIfB1KZk1V9ZSXzuxrcDObXQolSS29cfESXOG7eDiRuBkg/yU0Pjj/6WbjJtkcuX3cO5Gbuej3AS16Rhel/7igqOAuuQ1r1F8PixdxQJdrtyaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VVoKu1UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E858C32786;
	Thu, 15 Aug 2024 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730608;
	bh=VfjlkwwWQFaxsbnb3F+gwgs7SrjRD3NURL0b0Y6cdrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVoKu1UIk4dmBczg/5Oxllyok92Z9ZQygjSkMJXZuhLfJvZcHy4gNAFVWvQ0Oj2AS
	 eWSmkrnNjXJ0PAuaosyHj0ZxcQ3aRPm1vKfBPqg9xJj782YHTWt1S5sdOPVbX+Ib36
	 6dlbBvBL6mg2r2CLRUpkkNGC7NFGNIP+4LvJKqss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15 460/484] selftests: mptcp: join: check backup support in signal endp
Date: Thu, 15 Aug 2024 15:25:18 +0200
Message-ID: <20240815131959.240886891@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit f833470c27832136d4416d8fc55d658082af0989 upstream.

Before the previous commit, 'signal' endpoints with the 'backup' flag
were ignored when sending the MP_JOIN.

The MPTCP Join selftest has then been modified to validate this case:
the "single address, backup" test, is now validating the MP_JOIN with a
backup flag as it is what we expect it to do with such name. The
previous version has been kept, but renamed to "single address, switch
to backup" to avoid confusions.

The "single address with port, backup" test is also now validating the
MPJ with a backup flag, which makes more sense than checking the switch
to backup with an MP_PRIO.

The "mpc backup both sides" test is now validating that the backup flag
is also set in MP_JOIN from and to the addresses used in the initial
subflow, using the special ID 0.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in mptcp_join.sh because 'run_tests' helper has been
  modified in multiple commits that are not in this version, e.g. commit
  e571fb09c893 ("selftests: mptcp: add speed env var") and commit
  ae7bd9ccecc3 ("selftests: mptcp: join: option to execute specific
  tests"). Adaptations have been made to use the old way, similar to
  what is done around.
  Also in this version, there is no "single address with port, backup"
  subtest. Same for "mpc backup both sides". ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1588,10 +1588,19 @@ backup_tests()
 	# single address, backup
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+	chk_join_nr "single address, backup" 1 1 1
+	chk_add_nr 1 1
+	chk_prio_nr 1 0 0 1
+
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
-	chk_join_nr "single address, backup" 1 1 1
+	chk_join_nr "single address, switch to backup" 1 1 1
 	chk_add_nr 1 1
 	chk_prio_nr 1 0 0 0
 }



