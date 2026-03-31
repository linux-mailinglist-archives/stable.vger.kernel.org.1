Return-Path: <stable+bounces-231992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKf6CmD9y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:59:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD236D974
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59206310292D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CA933E372;
	Tue, 31 Mar 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="inGLyvOQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BB2D1F40;
	Tue, 31 Mar 2026 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975595; cv=none; b=stdHun/NMT2Dc1xLcLd987NWkMpbAYhdkL17M+KxP87zkTDxMu0oqeFJYS5Tn4sIB6j60B2w4RhhLryyBXuWEPb51OSPoSj5aMvkkaQ2uhNM0Kh81K0a1xY9gRfnk3jKl+k88u4hnI72XAM3TfIFMG4Z4KsLtggqsTh+lXcyxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975595; c=relaxed/simple;
	bh=IYLrf/6YGoEbneBobd3N6vKM1iR7t6tMBeb9kF9lwTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sa5LxINtYpyyWAJEcLOWvP53WrviZQl6Hfoz2OBjRG4nf8L+3v9+uLi4aUt9X6OM2ACQc1ZoAcJOSaTeT3f+eeG+TC95Beov/lEKZy3N1J8aMOArRrlBfMmDqp1mJ2QqIe5J6zdTw2PA+6bmZ8aCjnvZwXxzzqwyDQzh4ExHCWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=inGLyvOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB68C19424;
	Tue, 31 Mar 2026 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975595;
	bh=IYLrf/6YGoEbneBobd3N6vKM1iR7t6tMBeb9kF9lwTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inGLyvOQcG0dqILRHLTQ9nJ1B/PBPMiLHzgXBSwKOPpptYsx/ft70Ar/xj/bI0W/u
	 HSDqXZoL1BfThHQKDia7OwoXWEeOcheHR0NGgRqhPl4blMnTajGR6Qcq4XIJkeVeEp
	 /+mJucCbn4m2TRSLNnZ3VbM3ARgvsGOuoeoGWvmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Metz <peter.metz@unarin.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 013/244] platform/x86: intel-hid: Add Dell 14 Plus 2-in-1 to dmi_vgbs_allow_list
Date: Tue, 31 Mar 2026 18:19:23 +0200
Message-ID: <20260331161742.196720563@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231992-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,unarin.com:email,qualcomm.com:email]
X-Rspamd-Queue-Id: A7CD236D974
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Metz <peter.metz@unarin.com>

[ Upstream commit 6b3fa0615cd8432148581de62a52f83847af3d70 ]

The Dell 14 Plus 2-in-1 (model DB04250) requires the VGBS allow list
entry to correctly enable the tablet mode switch. Without this, the
chassis state is not reported, and the hinge rotation only emits
unknown scancodes.

Verified on Dell 14 Plus 2-in-1 DB04250.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221090
Signed-off-by: Peter Metz <peter.metz@unarin.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/20260213044627.203638-1-peter.metz@unarin.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/hid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 04056fbd92196..0b21d8317db30 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -180,6 +180,12 @@ static const struct dmi_system_id dmi_vgbs_allow_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro Rugged 12 Tablet RA02260"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell 14 Plus 2-in-1 DB04250"),
+		},
+	},
 	{ }
 };
 
-- 
2.51.0




