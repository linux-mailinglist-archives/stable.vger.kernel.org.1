Return-Path: <stable+bounces-140167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11DAAA5D4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506393AF9C5
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF328D85D;
	Mon,  5 May 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIpZqge4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1913174FA;
	Mon,  5 May 2025 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484263; cv=none; b=VdJZchsIIbrfCZkhjVt9oh306whAnTq/Q39nYe9kd7V6q3KFqdM09gd1WlLxk1kOjb7W641ATCt5aK+0c/C/fl1iMAcAEvRf0mEw6ddyXhx9oScgHTEetIREbC4nLP7+fb1Xircg3iScWaQdflZpkRDyAntag67XPyfemo5DEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484263; c=relaxed/simple;
	bh=lJeDHJ0IZPuWQ1C8iqTXkcL2Ha+shOeOLEp2gMAKE2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wr19acnhAtdiWyJc/jTq+zbdCvI9x6gTt0qoLAwfaTJJ1Qdnmrk8NS6zaNS03kdQf3xMYyeM7tYb3mC1H13sdIeIFOCAkzajd7770nqZ6tH6mY5fQ+8MgAfMin9sKbQKJtGm80eZwFplTbijZaUgz4HaZsc62W2xloR+lWLJMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIpZqge4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB296C4CEF1;
	Mon,  5 May 2025 22:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484262;
	bh=lJeDHJ0IZPuWQ1C8iqTXkcL2Ha+shOeOLEp2gMAKE2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIpZqge4Sjq1cEk/jhP7ZRShfaetW6qdy/c7w/tV/KhgnY4JbmDxRjOBq9xMQYjNi
	 K2CAld4kirLaa+9cjJRzGnthONq2Q0Ut+BzZQ/ZNUj0+cVjoOFvUlwyzXgrNCA3RJb
	 Z4gYvFinBLeyfam6YNhgR54R9PCjnaR3hNiz/N1VjixXZWW0Lfl8GtuE0/W+jN5Ile
	 XO+Fk3KDHdJKOuKlKtlp6glT48TpOu/UCUhC3FD0PILsGnb1aVgxNcBVhkZgJVI6xn
	 Nxg3hd+wbTevulLWT100FllBqGEWbWucKHfgw8fVtKwPDhgk7ooARk4aka45JP6qpr
	 S+30UturcDDxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Andreev <andreev@swemel.ru>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Sasha Levin <sashal@kernel.org>,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 420/642] smack: recognize ipv4 CIPSO w/o categories
Date: Mon,  5 May 2025 18:10:36 -0400
Message-Id: <20250505221419.2672473-420-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Konstantin Andreev <andreev@swemel.ru>

[ Upstream commit a158a937d864d0034fea14913c1f09c6d5f574b8 ]

If SMACK label has CIPSO representation w/o categories, e.g.:

| # cat /smack/cipso2
| foo  10
| @ 250/2
| ...

then SMACK does not recognize such CIPSO in input ipv4 packets
and substitues '*' label instead. Audit records may look like

| lsm=SMACK fn=smack_socket_sock_rcv_skb action=denied
|   subject="*" object="_" requested=w pid=0 comm="swapper/1" ...

This happens in two steps:

1) security/smack/smackfs.c`smk_set_cipso
   does not clear NETLBL_SECATTR_MLS_CAT
   from (struct smack_known *)skp->smk_netlabel.flags
   on assigning CIPSO w/o categories:

| rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
| skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;

2) security/smack/smack_lsm.c`smack_from_secattr
   can not match skp->smk_netlabel with input packet's
   struct netlbl_lsm_secattr *sap
   because sap->flags have not NETLBL_SECATTR_MLS_CAT (what is correct)
   but skp->smk_netlabel.flags have (what is incorrect):

| if ((sap->flags & NETLBL_SECATTR_MLS_CAT) == 0) {
| 	if ((skp->smk_netlabel.flags &
| 		 NETLBL_SECATTR_MLS_CAT) == 0)
| 		found = 1;
| 	break;
| }

This commit sets/clears NETLBL_SECATTR_MLS_CAT in
skp->smk_netlabel.flags according to the presense of CIPSO categories.
The update of smk_netlabel is not atomic, so input packets processing
still may be incorrect during short time while update proceeds.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 357188f764ce1..d8f9922804974 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -915,6 +915,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
 		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
+		if (ncats.attr.mls.cat)
+			skp->smk_netlabel.flags |= NETLBL_SECATTR_MLS_CAT;
+		else
+			skp->smk_netlabel.flags &= ~(u32)NETLBL_SECATTR_MLS_CAT;
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
-- 
2.39.5


