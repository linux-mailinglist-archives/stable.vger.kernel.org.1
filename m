Return-Path: <stable+bounces-239348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JBHGxFg5mkqvgEAu9opvQ
	(envelope-from <stable+bounces-239348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:19:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97281430FE1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF4623280E67
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A08033AD99;
	Mon, 20 Apr 2026 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zo9tebck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53633A70A;
	Mon, 20 Apr 2026 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700017; cv=none; b=Sf4FOm5W/Mitng/ZN7tteJ+kA0VAKFwRv/KHPK39I7DyMOCbSEFAvSUJySKOnWClcqb7J33ievStBOBhy8I0AY6ITwtUPLskVYYHTwWWWmRKs7x/iSvKup61hL3dpQ/aqOTQc8/xPX+/RTWpis3ePYvdz5WgzyETvD6TUKE+XTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700017; c=relaxed/simple;
	bh=AVjyD4dNMXBDxkbSAPXzh+coTsWaaP9aBn8EmecrsOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pT3fQAGwAv6BCGglHaQFOaKnhgn68JrYvPwyeI03mS5kTahwnMx3LXfiHuBDfg6GoVq0D9ILvE1Da439DYh8seErZ+63Nsb/g2MO0LSZzArs4qDOR+qDBZm1ujb5U+FuzTbVjbJYyiMBy0FqEq4UjhEUvYkpbmxBHR8o+JehiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zo9tebck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B8CC19425;
	Mon, 20 Apr 2026 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700016;
	bh=AVjyD4dNMXBDxkbSAPXzh+coTsWaaP9aBn8EmecrsOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zo9tebckC7O5/o2mZZ2Oa+beYAJ1ckEaKstEBcc/XP6jwixArP8rpYRRSLWXXZanl
	 KEn9c+XjmzvzkdaTTPKjfllg0sd8+tV3qD1yJetrk6b+LZm4y1KpTGDcvmLrS6gpz+
	 +aBxxz/Q22DXc4+AHETc0q2s1XL1wNzqcTgn1j6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 002/220] RDMA/irdma: Fix double free related to rereg_user_mr
Date: Mon, 20 Apr 2026 17:39:03 +0200
Message-ID: <20260420153934.106843371@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239348-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97281430FE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 29a3edd7004bb635d299fb9bc6f0ea4ef13ed5a2 ]

If IB_MR_REREG_TRANS is set during rereg_user_mr, the
umem will be released and a new one will be allocated
in irdma_rereg_mr_trans. If any step of irdma_rereg_mr_trans
fails after the new umem is allocated, it releases the umem,
but does not set iwmr->region to NULL. The problem is that
this failure is propagated to the user, who will then call
ibv_dereg_mr (as they should). Then, the dereg_mr path will
see a non-NULL umem and attempt to call ib_umem_release again.

Fix this by setting iwmr->region to NULL after ib_umem_release.

Fixed: 5ac388db27c4 ("RDMA/irdma: Add support to re-register a memory region")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260227152743.1183388-1-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c454a006c78e0..496d3fedaa9e6 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3721,6 +3721,7 @@ static int irdma_rereg_mr_trans(struct irdma_mr *iwmr, u64 start, u64 len,
 
 err:
 	ib_umem_release(region);
+	iwmr->region = NULL;
 	return err;
 }
 
-- 
2.53.0




