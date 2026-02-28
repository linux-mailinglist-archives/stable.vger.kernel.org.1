Return-Path: <stable+bounces-220541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF6eBZ48o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:06:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7351C69A1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38B3530A417B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90D3D16D3;
	Sat, 28 Feb 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+K4mwOf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BE3D16CC;
	Sat, 28 Feb 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300424; cv=none; b=Dg0DkkAINfAkbk5MpWG7U3QLwZ5DixtYiV+XNHSfEreJ1VrDvxFdnJoEzsIgbGhcosQ47PEDJ1swJ2J51l9u3SD3POZj0n1RVpMqkW2wFnTi0Dtnfw8dFGO/4ksQ0yJv2uqdMp09OSzCHmIiKUhtrzaNdTYDhWGZ//nlytBV1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300424; c=relaxed/simple;
	bh=YsgnVC5mvlJ8X8mgQnsL8yzWbVEER0wnQ52gvS/bdnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iloUZFWMvZZgbHVrsxlaEARaAG5KnKHDLG5cq1b0ngXg9JP3+r9792HJPOhU4C4niTsia7/du48vYaKiFvdegMZJON0iYoFhsau/r/bmQZTeAD+6fgkRIOdHwPI/LUZbbZlNhYC+J2eOWMWWP0IloOC7X/wCaFeHPVpjxggPIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+K4mwOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6506CC19423;
	Sat, 28 Feb 2026 17:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300424;
	bh=YsgnVC5mvlJ8X8mgQnsL8yzWbVEER0wnQ52gvS/bdnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+K4mwOfhbxIbDZPpIeGfcBsO5LmoOK1VnZ3A3ragumRvAMZiq8yJGam0IgueAD+X
	 csvfmudBB7cBK6XoXYo9WCN7BjBOoSPDXyFcWRQCSgkZeMegcD/IJpyY98rgp7EFHe
	 DlMh3aNMUhe/Xt9l7Iu0T+AjXrP99dfSSi9gsrNKFMtoxkNXyhTPgNvftOUuaWP6+Z
	 biFLvBv7n1C/qnapypxu0e2diRd+2uEHTETGuQLaEkqU6+F2S7AXmXDztRWfEGL/Ha
	 DGGH5xDgxOY4dEQNVn3dPTsynX2Qd/kvCLgSotN72HfNQ4qJs7MTG2k6Fg5gPciAI7
	 dRJbq6p8D0IcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 462/844] bnxt_en: Fix deleting of Ntuple filters
Date: Sat, 28 Feb 2026 12:26:15 -0500
Message-ID: <20260228173244.1509663-463-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220541-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD7351C69A1
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

[ Upstream commit c1bbd9900d65ac65b9fce9f129e3369a04871570 ]

Ntuple filters can be deleted when the interface
is down. The current code blindly sends the filter
delete command to FW. When the interface is down, all
the VNICs are deleted in the FW. When the VNIC is
freed in the FW, all the associated filters are also
freed. We need not send the free command explicitly.
Sending such command will generate FW error in the
dmesg.

In order to fix this, we can safely return from
bnxt_hwrm_cfa_ntuple_filter_free() when BNXT_STATE_OPEN
is not true which confirms the VNICs have been deleted.

Fixes: 8336a974f37d ("bnxt_en: Save user configured filters in a lookup list")
Suggested-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20260219185313.2682148-3-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 64832289e18d0..c4657bb3acc18 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6212,6 +6212,9 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 	int rc;
 
 	set_bit(BNXT_FLTR_FW_DELETED, &fltr->base.state);
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state))
+		return 0;
+
 	rc = hwrm_req_init(bp, req, HWRM_CFA_NTUPLE_FILTER_FREE);
 	if (rc)
 		return rc;
-- 
2.51.0


