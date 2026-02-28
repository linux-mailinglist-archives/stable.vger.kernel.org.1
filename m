Return-Path: <stable+bounces-220287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MPtMnYvo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD21C57D0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3562306CDA2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50A738656A;
	Sat, 28 Feb 2026 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtdBTjAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FE386560;
	Sat, 28 Feb 2026 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300191; cv=none; b=Bfds5kR+tH2cq3ie0EU8+CgyomhmEosJforHb4IlvHjWLa4YjgepPuMgAlcoljWIebHvKQGJTiOmQ2sI7mgNSMID6X/EjVzyBdBFWcD6bpJg70yMk8ny/koVrSV/jOn20ovHHMtQGdluNAQkLaI3zIX3XawxS/pz6tkMRFfdcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300191; c=relaxed/simple;
	bh=GloLR+sZqazsOEMcwKjjsr0557JMWt8dkvyqSApCE9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKR2rA5jJFohgNS0mJaQbIFmu0FAl9darJrjBGC/zuLhdRLfYtf9lRFlgNSt7HvUuJ5xtyOYFMcdn7RB5qNALoIxUT5No3/Gd8KBzBfxEcoK9heXaRn3BVyDPca09G4oTEsOvWBa57mixQFd3Ltv4nyZspGXo91z7PrV1E/mF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtdBTjAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9567BC2BC9E;
	Sat, 28 Feb 2026 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300191;
	bh=GloLR+sZqazsOEMcwKjjsr0557JMWt8dkvyqSApCE9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtdBTjACa/yFaXq/ju7AXSSRnYTKRNH+SNtM7zBIjVLMiVtbswf54hkk7lW7k5dvN
	 l3do1peelqnl5fJrzf+p6sws8jEPN1HE7GWSpUoriADlC3ss5N9p2nq7Je4mEkshbC
	 7HgXdaw8/i69Qz7YsPOKz3UqUaspBDHhsFyd5w9lQsl5wotto+XN4ktfbZWJnr9mIR
	 rOfiQg6Rq802UlN3oXmZ6vdBaj3NIsRPyv8cQZ0j6AikkwYSUkFAxHG4ewlU08kqr4
	 sZfzdMnxIT+ngwh2OuUF1eHc+A6gH3KQl7NkMPVay4vXVZflk4tK0kT/Z+IP+goLSt
	 QH7FaJYzf+pLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rui Wang <rui.wang@ideasonboard.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 209/844] media: rkisp1: Fix filter mode register configuration
Date: Sat, 28 Feb 2026 12:22:02 -0500
Message-ID: <20260228173244.1509663-210-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220287-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 71AD21C57D0
X-Rspamd-Action: no action

From: Rui Wang <rui.wang@ideasonboard.com>

[ Upstream commit 5a50f2b61104d0d351b59ec179f67abab7870453 ]

The rkisp1_flt_config() function performs an initial direct write to
RKISP1_CIF_ISP_FILT_MODE without including the RKISP1_CIF_ISP_FLT_ENA
bit, which clears the filter enable bit in the hardware.

The subsequent read/modify/write sequence then reads back the register
with the enable bit already cleared and cannot restore it, resulting in
the filter being inadvertently disabled.

Remove the redundant direct write. The read/modify/write sequence alone
correctly preserves the existing enable bit state while updating the
DNR mode and filter configuration bits.

Signed-off-by: Rui Wang <rui.wang@ideasonboard.com>
Reviewed-by: Stefan Klug <stefan.klug@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260105171142.147792-2-rui.wang@ideasonboard.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-params.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
index c9f88635224cc..6442436a5e428 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-params.c
@@ -411,12 +411,6 @@ static void rkisp1_flt_config(struct rkisp1_params *params,
 	rkisp1_write(params->rkisp1, RKISP1_CIF_ISP_FILT_LUM_WEIGHT,
 		     arg->lum_weight);
 
-	rkisp1_write(params->rkisp1, RKISP1_CIF_ISP_FILT_MODE,
-		     (arg->mode ? RKISP1_CIF_ISP_FLT_MODE_DNR : 0) |
-		     RKISP1_CIF_ISP_FLT_CHROMA_V_MODE(arg->chr_v_mode) |
-		     RKISP1_CIF_ISP_FLT_CHROMA_H_MODE(arg->chr_h_mode) |
-		     RKISP1_CIF_ISP_FLT_GREEN_STAGE1(arg->grn_stage1));
-
 	/* avoid to override the old enable value */
 	filt_mode = rkisp1_read(params->rkisp1, RKISP1_CIF_ISP_FILT_MODE);
 	filt_mode &= RKISP1_CIF_ISP_FLT_ENA;
-- 
2.51.0


