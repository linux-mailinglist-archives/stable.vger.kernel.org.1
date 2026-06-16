Return-Path: <stable+bounces-263968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RYdGCrhsMWr8iwUAu9opvQ
	(envelope-from <stable+bounces-263968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:33:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C951691223
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:33:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tTDUCtY4;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263968-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263968-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 701D1318A471
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BCC449EA8;
	Tue, 16 Jun 2026 15:23:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A001E8320;
	Tue, 16 Jun 2026 15:23:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623439; cv=none; b=HT+IO9nQmYySnkkdxMEg5TEDs+unWIKoMT+CtzjDhP8rOed9MI5VyzoFu54MS+HjIJ2WG/p1W7fvuq1Jg//WUDErgLuoccs0kf2wjyYSOqEsQHOizDTaD/ojAh08/iVMe8hgz7ljjMOuikQbk2yFpcTEXNT1DdL4RAYoSNVPb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623439; c=relaxed/simple;
	bh=y+/272BZKLprXG14fXgX6yO2FJfR2CMNIBQK5NoThAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQl4vxiVtMHLvrYjt8t7a41cMfS+FZd4c9vdqCOYot1wXjreV0G8pakFGrBZJAKOTedydU7sx+tN6K6rU/MUhG0dwHtr4dJnX3+5Xj07gNWLX0GVaLDtEkvYuMFIl+sdeNO9PmNqtge5wpEYmQpHkr9g/3I85vHfUGQLwBREz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tTDUCtY4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3961F000E9;
	Tue, 16 Jun 2026 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623438;
	bh=vBdfucXv0BSEc+51hsE67r6fmaIA4M3tfCTccI1UsOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tTDUCtY4yAAFsvRfvoGfaU176TmNVbm7YqjNqy2kJXCt+FPv7FiibtzmUnq2u0aqt
	 +0naILjNcNKlbtb4oZE8YaEEzfKXHJptJ12olY9ir+sXX94+dA0lyr9a0047FmhkEB
	 XxmvDN+hLqQmSJhnWUMdewvcYQDYU8mAdmjzFWI4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 105/378] bnge: fix context mem iteration
Date: Tue, 16 Jun 2026 20:25:36 +0530
Message-ID: <20260616145115.892901946@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263968-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vikas.gupta@broadcom.com,m:dharmender.garg@broadcom.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C951691223

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vikas Gupta <vikas.gupta@broadcom.com>

[ Upstream commit 3847d94783c0b893c27ff0b26a3325796d9444c6 ]

The firmware advertises context memory (backing store) types
through a linked list, with BNGE_CTX_INV serving as the
end-of-list sentinel.
However, the driver incorrectly assumes that the list is strictly
ordered and prematurely terminates traversal when it encounters
an unrecognized type (>=BNGE_CTX_V2_MAX). As a result, any valid
context types that appear later in the chain are silently skipped,
leading to incomplete memory configuration and eventual driver load
failure.

Fix this by traversing the entire list until the BNGE_CTX_INV sentinel
is reached, while safely ignoring only those context types that fall
outside the supported range.

Fixes: 29c5b358f385 ("bng_en: Add backing store support")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index c46da34134179c..3f07311d065e24 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -259,7 +259,7 @@ int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd)
 	struct hwrm_func_backing_store_qcaps_v2_output *resp;
 	struct hwrm_func_backing_store_qcaps_v2_input *req;
 	struct bnge_ctx_mem_info *ctx;
-	u16 type;
+	u16 type, next_type;
 	int rc;
 
 	if (bd->ctx)
@@ -276,8 +276,8 @@ int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd)
 
 	resp = bnge_hwrm_req_hold(bd, req);
 
-	for (type = 0; type < BNGE_CTX_V2_MAX; ) {
-		struct bnge_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+	for (type = 0; type < BNGE_CTX_INV; type = next_type) {
+		struct bnge_ctx_mem_type *ctxm;
 		u8 init_val, init_off, i;
 		__le32 *p;
 		u32 flags;
@@ -286,8 +286,14 @@ int bnge_hwrm_func_backing_store_qcaps(struct bnge_dev *bd)
 		rc = bnge_hwrm_req_send(bd, req);
 		if (rc)
 			goto ctx_done;
+
+		next_type = le16_to_cpu(resp->next_valid_type);
+		if (type >= BNGE_CTX_V2_MAX)
+			continue;
+
+		ctxm = &ctx->ctx_arr[type];
 		flags = le32_to_cpu(resp->flags);
-		type = le16_to_cpu(resp->next_valid_type);
+
 		if (!(flags &
 		      FUNC_BACKING_STORE_QCAPS_V2_RESP_FLAGS_TYPE_VALID))
 			continue;
-- 
2.53.0




