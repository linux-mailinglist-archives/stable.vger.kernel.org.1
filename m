Return-Path: <stable+bounces-236671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBJkEa4e3WmsaAkAu9opvQ
	(envelope-from <stable+bounces-236671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B3D3EFEAD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 350353289AF7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27C30ACE6;
	Mon, 13 Apr 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gr+VpElZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB12E11B9;
	Mon, 13 Apr 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097504; cv=none; b=s8O9A+43e8FK4QYCwvMTgdCaX5Qe99ZdntMHFlh+dZTY0e//uXy4L+iR1aF6DrdwRYhLjZByfmcyVtA8tiJ9WhQjtP6NEAIKUz/c51Mt6aLzfH+dRr+BrhkOfkBMmgk0C6c4dbZrMuwFDNb4CZW7Dgbyg6NhcINDSkMwkuqT4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097504; c=relaxed/simple;
	bh=Aq2Qrwv09lhiDQKrF8boulP9cGppnxObaMBHXLS2rU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh2bn1iQNdjj/K2oeLhS2oibOGX66M9bVPsNpGhhso9Bd6+s+EkRwBrexbHI3Q1fdglbK7psVw4G/eVnz26HwL4FL5najDw+kRdJZdqN3+uC5NHhUKqXl2GSAlUU3YRzvAOfE+mSfa3dSIHkd2C0O+89QGeXQydWkDQmp/qbIm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gr+VpElZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA14C2BCAF;
	Mon, 13 Apr 2026 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097504;
	bh=Aq2Qrwv09lhiDQKrF8boulP9cGppnxObaMBHXLS2rU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gr+VpElZYGy1eOqYjXKNdVljy+zwFLpRzUCrx99yjUxZ5c3IcEaxoAvq1qc5XXNrD
	 jbOOSLjGZEVkU+Lt8ISODHGe0QXWCow+uKws/aeR8La3GCCSECYiraB8TwOR/CEfDR
	 LpFsoVQ3BJQYs2pdRCHxAB6AwSjGUGRtxDFqHFzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 129/570] octeontx2-af: devlink: fix NIX RAS reporter to use RAS interrupt status
Date: Mon, 13 Apr 2026 17:54:20 +0200
Message-ID: <20260413155835.275517107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236671-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 98B3D3EFEAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 87f7dff3ec75b91def0024ebaaf732457f47a63b ]

The NIX RAS health report path uses nix_af_rvu_err when handling the
NIX_AF_RVU_RAS case, so the report prints the ERR interrupt status rather
than the RAS interrupt status.

Use nix_af_rvu_ras for the NIX_AF_RVU_RAS report.

Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Link: https://patch.msgid.link/20260310184824.1183651-2-alok.a.tiwari@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 8a63277aab1af..4991fafd04bad 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -326,10 +326,10 @@ static int rvu_nix_report_show(struct devlink_fmsg *fmsg, void *ctx,
 		rvu_report_pair_end(fmsg);
 		break;
 	case NIX_AF_RVU_RAS:
-		intr_val = nix_event_context->nix_af_rvu_err;
+		intr_val = nix_event_context->nix_af_rvu_ras;
 		rvu_report_pair_start(fmsg, "NIX_AF_RAS");
 		devlink_fmsg_u64_pair_put(fmsg, "\tNIX RAS Interrupt Reg ",
-					  nix_event_context->nix_af_rvu_err);
+					  nix_event_context->nix_af_rvu_ras);
 		devlink_fmsg_string_put(fmsg, "\n\tPoison Data on:");
 		if (intr_val & BIT_ULL(34))
 			devlink_fmsg_string_put(fmsg, "\n\tNIX_AQ_INST_S");
-- 
2.51.0




