Return-Path: <stable+bounces-93939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FEF9D21AA
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACB81F22B76
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8497F198A07;
	Tue, 19 Nov 2024 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krn2GXSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B71885BF;
	Tue, 19 Nov 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005365; cv=none; b=q3JTQSml5c8Kcco8G4q5GaFRfGkJ/ZJTdI0w7eEDoApCWB3iuOfBlL5cMs9nawCfOO0gGai3DXqXvfs3n4qfCePhjDb86R4+BV/Ie/bhQXmYPJILSj6tk+S2CiXxwFFZS1j8ZfFWY1i6jCr66Y2FXMSO2xBXHPVU31Kgo9RSSyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005365; c=relaxed/simple;
	bh=6pSt/3agggkzfOOflqIswigaRjWoWiwPtgZJNnrCLVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfJTw6LpF3C7rtWGg5D6Sx9W7eqKIFHPRayR69DMAe/U1TlZtsd2sEh3rVan5tvvXf70U63rHCrY51AuQn86SDI4qcfLGQURlHBYmYWyeZtcOnI7Mg0vQoJWZlnIllDKeJqqXiJnVgORQ+CT50qcjTkY4XnwlAiTVuZWBtqC7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krn2GXSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38943C4CED1;
	Tue, 19 Nov 2024 08:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732005364;
	bh=6pSt/3agggkzfOOflqIswigaRjWoWiwPtgZJNnrCLVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Krn2GXSoYT+aZqFlnlIfnz0JQL4YEejqCpJscyLhC6ET6gbQ0vEPxWWvCfXOWFBDt
	 0hqCCgcVlEhwh5CU4DWU8reREFTXRPLkRgahYPRm6O/BGiZIxxoeBPwh+CeOdKs1Tq
	 qe1fsC8J/X60NTbvZPmct6/oVfkv7pBuZKtXW0GpRniCo3UdP0OxXVwsi3p5udBWZb
	 mzoLhbfuvW6F51VYP6qDbFbHOXLv/KLgruw5fJ0u/jwiK0Et3/TLUXKWRfZtlW0SkS
	 2ENliqdpwtgT8SanNC/IFJJyva3eWn74vyONaX30miQYKwTTE97Zd/8wv7y/R+IgT/
	 U8xw4mmE6Bi7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 4/7] mptcp: update local address flags when setting it
Date: Tue, 19 Nov 2024 09:35:52 +0100
Message-ID: <20241119083547.3234013-13-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119083547.3234013-9-matttbe@kernel.org>
References: <20241119083547.3234013-9-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=matttbe@kernel.org; h=from:subject; bh=7CKnHeiIcL2LfHx3nubHzjydY6n8OUTlxZHPcUInqK4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPE3krtpRCr369o62piZrMcFDC9vXsT2UrmOZ4 v3E7XZT0u2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxN5AAKCRD2t4JPQmmg c542D/9jjvgYMP6dkLr3vFz66VCMYelHJIjYbWIvhSlsTWaH0/Wnls8w8UcD3FzBoiwqVG7eknt LiT9vonAd27UgFEfq8W2RyufFikdjqDiUx6s1JgudlT9F5TRGFKuZZhXfAcLJAzJmtTKkdfEm90 6mrGlYXQSaFMxbBl/a1KVMp33nAuchR1if0HJ//8DhaEYB5h76AIld4GqOccypecBxEGsf9nbGN dCpbWq80rhOpxb1XnDzNb2WX4O3vO9ZRZnc2DACLO7baSro2DfwgO6AfvgBPga/HGTegFVtNH95 6MI3+1pk1Esl8Lriilfc0o+EDMW/4EJ04HCVb+SOX7HAA4LekifjnIVDhBWYf8wfuJcCHgilPXp o2IVFd6DnQxlj8QhApHX5kDIAo5BjBiDl6K7NYlC9OfOvDVNkcUwBKdurH0VDWNlnqlY3oEoItC 1iIGVul2TuGfIHHQJoPKjPS0jQ8LXyQDseBPwR0sxwOJfZzra+jtx1JCZiy48I5Ed3lKAMNganR igDgJvmeWxMmJQmPgcC1T2eGC+A1FYZmifUV+HbUjzvydVa32iGpU/VBrlCCmxWF6jeYkffArRX 5917quCdvc5kOn+Mz2I3AGZOzE1gSepuIuI6OtvxUkfrQGDiqfxucCp+dOnNnI8bjHM0IYjnWjq yzuXA9rAssDJjMA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit e0266319413d5d687ba7b6df7ca99e4b9724a4f2 upstream.

Just like in-kernel pm, when userspace pm does set_flags, it needs to send
out MP_PRIO signal, and also modify the flags of the corresponding address
entry in the local address list. This patch implements the missing logic.

Traverse all address entries on userspace_pm_local_addr_list to find the
local address entry, if bkup is true, set the flags of this entry with
FLAG_BACKUP, otherwise, clear FLAG_BACKUP.

Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-1-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_userspace.c, because commit 6a42477fe449 ("mptcp:
  update set_flags interfaces"), is not in this version, and causes too
  many conflicts when backporting it. The same code can still be added
  at the same place, before sending the ACK. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ca3e452d4edb..195f84f16b97 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -565,6 +565,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 				 struct mptcp_pm_addr_entry *loc,
 				 struct mptcp_pm_addr_entry *rem, u8 bkup)
 {
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -585,6 +586,17 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	    rem->addr.family == AF_UNSPEC)
 		goto set_flags_err;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &loc->addr, false)) {
+			if (bkup)
+				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+			else
+				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
 	release_sock(sk);
-- 
2.45.2


