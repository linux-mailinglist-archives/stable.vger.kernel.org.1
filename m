Return-Path: <stable+bounces-236928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ERgEpsb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFD33EF5CE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 327B4302402A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83953161BF;
	Mon, 13 Apr 2026 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="up3ePUhc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93E31619C;
	Mon, 13 Apr 2026 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098151; cv=none; b=Qzw2IsJ3nI7ivpkfcrR6AMhsJ5MvL7O3okhAA2zqGDYHxYQMqdNT2eaAoGiV2gjvplYQ3PMqwbI5GC2FnS1QkJzKzdwIQpSYBJ51l5isQsDiS2d3v9BLL6kaCcD1QLdaki06r50NQkOsTm0d3R3laURosEbxwXGYiBBkFCq5ZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098151; c=relaxed/simple;
	bh=gOu1N6JikeAaZqIlWXSOCudDVHVJL49qAh/9QLbYlBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzZwXhVM3mOOnj765ddJA2HnMVJucAgiuLLTDNp6FOtnT0fHy/LXLmfOCMTQRRWwZR/qyhZwfxJoZcOc+da4lVnhI3Dk/sXbDl0I/ftfOOdi64lPCtepf6OjJ4CP/N7vy1xBMqkPuuvsW6vo6m48g+ku9JI4dCPbTZLyxKztxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=up3ePUhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2F1C2BCB3;
	Mon, 13 Apr 2026 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098151;
	bh=gOu1N6JikeAaZqIlWXSOCudDVHVJL49qAh/9QLbYlBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=up3ePUhcaqSn9HTi71iTdQLXmkURDLByr5K9Zk9jgica0XDFiSP26bsFGCZeqh222
	 uoqZg/ZS4jUyXgRiqyTHMdLM3K0UnnQV0l8IiC8CPb3VaXDZrHE1HUFsOMKOYfUjWa
	 CDsCXigo/WaxvMZZ4k3QDVCdCQvk/KC50JXizpdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yochai Eisenrich <echelonh@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 414/570] net: sched: cls_api: fix tc_chain_fill_node to initialize tcm_info to zero to prevent an info-leak
Date: Mon, 13 Apr 2026 17:59:05 +0200
Message-ID: <20260413155845.981328464@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,mojatatu.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-236928-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: DDFD33EF5CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yochai Eisenrich <echelonh@gmail.com>

[ Upstream commit e6e3eb5ee89ac4c163d46429391c889a1bb5e404 ]

When building netlink messages, tc_chain_fill_node() never initializes
the tcm_info field of struct tcmsg. Since the allocation is not zeroed,
kernel heap memory is leaked to userspace through this 4-byte field.

The fix simply zeroes tcm_info alongside the other fields that are
already initialized.

Fixes: 32a4f5ecd738 ("net: sched: introduce chain object to uapi")
Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260328211436.1010152-1-echelonh@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 3b12c3534b1b3..4c8ab5b05b663 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2672,6 +2672,7 @@ static int tc_chain_fill_node(const struct tcf_proto_ops *tmplt_ops,
 	tcm->tcm__pad1 = 0;
 	tcm->tcm__pad2 = 0;
 	tcm->tcm_handle = 0;
+	tcm->tcm_info = 0;
 	if (block->q) {
 		tcm->tcm_ifindex = qdisc_dev(block->q)->ifindex;
 		tcm->tcm_parent = block->q->handle;
-- 
2.53.0




