Return-Path: <stable+bounces-215045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALWoGlLxiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:38:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981B011095C
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993E0308AFD5
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF44737998A;
	Mon,  9 Feb 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="039rXvhm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328723B604;
	Mon,  9 Feb 2026 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647491; cv=none; b=grrFY5iTu7uwNMtTfcy79R5xDo+2qrElG4dcBWVT/XL9GFWFMDHtujdGWMDncoYkZcyVu+UjUqjDspNfvqp4+bEjehPEhAzn8S37KBL3WYy1AgB+Ra2DXFi7UNEU6gVPvGa9BGMpxKmwOvntsGUsKAUouYqO24zt/h9F67rxPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647491; c=relaxed/simple;
	bh=P0hEjtAuPI2NTCrQteKURMJxd84etoB2TPmZQQGSQ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+UWFqgtohujn5gr8H3cPAENDHwBCw10QEIv/GY9Ni0S6GtGCJnnXKP275rG/MdkorK0as9c/fGJUR4hGDYYUhhiSvH7NSNPcAF7rPhcfB/PkdanFnR5tfa7XRmQCGp4ogGSzh5muBRBe0UXVeYtO/cchsaOr9Z4R1ECwR0lye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=039rXvhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CEBC116C6;
	Mon,  9 Feb 2026 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647491;
	bh=P0hEjtAuPI2NTCrQteKURMJxd84etoB2TPmZQQGSQ6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=039rXvhmIzxyDWpAiCNeUnbz+um/qzetinvH8KQUxjMs963XwSPUVkhLDyE1iIR2l
	 Smrt8V+nEJzh7RmEXWM4fwcVQFmd6Y9TRqfb9tjg1puOcnlLPkWchKBAYGiCiRK73U
	 BuE73fyOorVrnNArrR9DEHidR+GD6WUJJeulpbL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alain Cousinie <alain.cousinie@laposte.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 115/175] platform/x86: hp-bioscfg: Skip empty attribute names
Date: Mon,  9 Feb 2026 15:23:08 +0100
Message-ID: <20260209142324.550902757@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215045-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,laposte.net,amd.com,linux.intel.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,laposte.net:email]
X-Rspamd-Queue-Id: 981B011095C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 6222883af286e2feb3c9ff2bf9fd8fdf4220c55a ]

Avoid registering kobjects with empty names when a BIOS attribute
name decodes to an empty string.

Fixes: a34fc329b1895 ("platform/x86: hp-bioscfg: bioscfg")
Reported-by: Alain Cousinie <alain.cousinie@laposte.net>
Closes: https://lore.kernel.org/platform-driver-x86/22ed5f78-c8bf-4ab4-8c38-420cc0201e7e@laposte.net/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260128190501.2170068-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index dbe096eefa758..51e8977d3eb4a 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -696,6 +696,11 @@ static int hp_init_bios_package_attribute(enum hp_wmi_data_type attr_type,
 		return ret;
 	}
 
+	if (!str_value || !str_value[0]) {
+		pr_debug("Ignoring attribute with empty name\n");
+		goto pack_attr_exit;
+	}
+
 	/* All duplicate attributes found are ignored */
 	duplicate = kset_find_obj(temp_kset, str_value);
 	if (duplicate) {
-- 
2.51.0




