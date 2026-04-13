Return-Path: <stable+bounces-236950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HBWNJUj3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-236950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:10:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2959F3F0E84
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D773054F73
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B61D5AD4;
	Mon, 13 Apr 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1sBMQcx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1A2D5A19;
	Mon, 13 Apr 2026 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098207; cv=none; b=GyBM6fq3zlPBU6Gjkrxq5tmgYjHUngYMFC9y/Ezc8q5JF6BnEcmF3EvMZBoot9Ez94QirTOyCXfKztNdtA3htId0XCJwoJ5m5Jff7XFhzy8oMk0fgvKcY3xaaTvPUC1QvZsPPJVCuy2xshmMCgtjKixn5qwgOErDw1DepSt9hqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098207; c=relaxed/simple;
	bh=umOb7iyZo5TEuQW1j8NfaVnqPrkeHIEFCQ0b+T8fuFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oceKC+CgsolyPq5wxCHid8PC6oi/5cKzvFlOpwQOYRk2Z+jvpHZkCRNsO9GF9GPxuN5FvP3hkW+nDOUyt1SDx3uzXIMQkKrLMiCJ/XFoUhsgeQl2tghQKHKhv12JytI/gC4ZEcwZ9LK873JVhAX7fmpcXvF1OSmYiMWe76O2rW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1sBMQcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49910C2BCAF;
	Mon, 13 Apr 2026 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098207;
	bh=umOb7iyZo5TEuQW1j8NfaVnqPrkeHIEFCQ0b+T8fuFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1sBMQcxA4LPvBmreoMcz1UB/djq2T8hIT7xOOxg2f7XvlG4rE5CPv5sJVBROGIO3
	 4RAYFj0HFU4nVDCWu+P6l4iZLy4AJmPFfK10y5/D4qch39+GzmL1/tpO0SaztBlwyn
	 ub4MrCo/LnIyHxzgcAn9OF4coceJ0Gbc/aNMQicg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 434/570] net/sched: cls_fw: fix NULL pointer dereference on shared blocks
Date: Mon, 13 Apr 2026 17:59:25 +0200
Message-ID: <20260413155846.731321606@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,asu.edu,mojatatu.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-236950-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,asu.edu:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2959F3F0E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit faeea8bbf6e958bf3c00cb08263109661975987c ]

The old-method path in fw_classify() calls tcf_block_q() and
dereferences q->handle.  Shared blocks leave block->q NULL, causing a
NULL deref when an empty cls_fw filter is attached to a shared block
and a packet with a nonzero major skb mark is classified.

Reject the configuration in fw_change() when the old method (no
TCA_OPTIONS) is used on a shared block, since fw_classify()'s
old-method path needs block->q which is NULL for shared blocks.

The fixed null-ptr-deref calling stack:
 KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
 RIP: 0010:fw_classify (net/sched/cls_fw.c:81)
 Call Trace:
  tcf_classify (./include/net/tc_wrapper.h:197 net/sched/cls_api.c:1764 net/sched/cls_api.c:1860)
  tc_run (net/core/dev.c:4401)
  __dev_queue_xmit (net/core/dev.c:4535 net/core/dev.c:4790)

Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q helper to get struct Qdisc")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260331050217.504278-1-xmei5@asu.edu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_fw.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
index a2f53aee39097..a4ffee135c855 100644
--- a/net/sched/cls_fw.c
+++ b/net/sched/cls_fw.c
@@ -245,8 +245,18 @@ static int fw_change(struct net *net, struct sk_buff *in_skb,
 	struct nlattr *tb[TCA_FW_MAX + 1];
 	int err;
 
-	if (!opt)
-		return handle ? -EINVAL : 0; /* Succeed if it is old method. */
+	if (!opt) {
+		if (handle)
+			return -EINVAL;
+
+		if (tcf_block_shared(tp->chain->block)) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify mark when attaching fw filter to block");
+			return -EINVAL;
+		}
+
+		return 0; /* Succeed if it is old method. */
+	}
 
 	err = nla_parse_nested_deprecated(tb, TCA_FW_MAX, opt, fw_policy,
 					  NULL);
-- 
2.53.0




