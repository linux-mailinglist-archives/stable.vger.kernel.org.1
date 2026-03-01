Return-Path: <stable+bounces-221796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI5eJv+Yo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD91CB46B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02AF33014517
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53DB2EA481;
	Sun,  1 Mar 2026 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvCmHDe3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB42DB799;
	Sun,  1 Mar 2026 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329159; cv=none; b=uZkWrMsnYCX+ZNQQH/wYP+tnx2N1yIxoL/pwz7EFrFj2TxMW7FmDIMOrTxN5/W2TVv7BE3iT2cWvIgr9XLAymKgQX9EG56NTAYIQ8xqeo0jejEoLHzXaEmoXDs+X0qrwpr0TcAYTmFbunm6frNhp+KGwDwVJtOGINEg4hoKzVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329159; c=relaxed/simple;
	bh=AyiKFNuAPGcp1cKB8OHfwUhAGRjcr3aAvgJp9HKMWA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LF9hDhSnxWE5aL9eZVw1swFjEWL4PiaXMWgmtaivTqouckjARwYk7c7huv0gvV05XYZUQzQla16IG5M58VW+D8KuyD11OwlN+YH/g6Cx455+yUdJgzAwmu4OjAOAltjuJNCngGOK5tqo073mjOgl9SewgOOS7gFySD9BiNygXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvCmHDe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7DDC19421;
	Sun,  1 Mar 2026 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329159;
	bh=AyiKFNuAPGcp1cKB8OHfwUhAGRjcr3aAvgJp9HKMWA0=;
	h=From:To:Cc:Subject:Date:From;
	b=IvCmHDe3fMWmSR3Uq0R1bzYiG40HqWdT/3xFo5UC4zvhfG4SFfbaq2mkrwQvLZc1G
	 VoSwJgp0Qmm82ylSAhYhDO8K1E1i5p7ZeozDZJ/aEoPEkmnulB9VUpKRInWih6vcxZ
	 RjvotA2OhsFOMWul07/D5fPXLwB0UEeFINlqCVvQlOOaYYhIeSYB1hGCMVf+ZvF7tv
	 H8kbX3onjVV3GP8XShBtXjGdXzXNAXu/hyTdyXOCZ1BIYUq81HxlXTIayI+7RLol5U
	 TS5Uv1UbX9rceG2sMK7dVHn+30NSPbtOs1yWD5ND+wIm05/230AyHLgmPEdzYSu2yA
	 bZ6/uaf3/ETPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cnitlrt@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:17 -0500
Message-ID: <20260301013917.1700213-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-221796-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 13BD91CB46B
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From be054cc66f739a9ba615dba9012a07fab8e7dd6f Mon Sep 17 00:00:00 2001
From: Ruitong Liu <cnitlrt@gmail.com>
Date: Sat, 14 Feb 2026 01:59:48 +0800
Subject: [PATCH] net/sched: act_skbedit: fix divide-by-zero in
 tcf_skbedit_hash()

Commit 38a6f0865796 ("net: sched: support hash selecting tx queue")
added SKBEDIT_F_TXQ_SKBHASH support. The inclusive range size is
computed as:

mapping_mod = queue_mapping_max - queue_mapping + 1;

The range size can be 65536 when the requested range covers all possible
u16 queue IDs (e.g. queue_mapping=0 and queue_mapping_max=U16_MAX).
That value cannot be represented in a u16 and previously wrapped to 0,
so tcf_skbedit_hash() could trigger a divide-by-zero:

queue_mapping += skb_get_hash(skb) % params->mapping_mod;

Compute mapping_mod in a wider type and reject ranges larger than U16_MAX
to prevent params->mapping_mod from becoming 0 and avoid the crash.

Fixes: 38a6f0865796 ("net: sched: support hash selecting tx queue")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: Ruitong Liu <cnitlrt@gmail.com>
Link: https://patch.msgid.link/20260213175948.1505257-1-cnitlrt@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/sched/act_skbedit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 8c1d1554f6575..5450c1293eb50 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -126,7 +126,7 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 	struct tcf_skbedit *d;
 	u32 flags = 0, *priority = NULL, *mark = NULL, *mask = NULL;
 	u16 *queue_mapping = NULL, *ptype = NULL;
-	u16 mapping_mod = 1;
+	u32 mapping_mod = 1;
 	bool exists = false;
 	int ret = 0, err;
 	u32 index;
@@ -194,6 +194,10 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 			}
 
 			mapping_mod = *queue_mapping_max - *queue_mapping + 1;
+			if (mapping_mod > U16_MAX) {
+				NL_SET_ERR_MSG_MOD(extack, "The range of queue_mapping is invalid.");
+				return -EINVAL;
+			}
 			flags |= SKBEDIT_F_TXQ_SKBHASH;
 		}
 		if (*pure_flags & SKBEDIT_F_INHERITDSFIELD)
-- 
2.51.0





