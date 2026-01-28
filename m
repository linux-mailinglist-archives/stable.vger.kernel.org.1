Return-Path: <stable+bounces-212419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKodBDo5eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:28:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FAA5ADD
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24733198957
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5523033C4;
	Wed, 28 Jan 2026 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vm/vHTR5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE73033F4;
	Wed, 28 Jan 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615455; cv=none; b=I3qEr/FNOdHtBJsni+uRUgT95RPOlH9WjP+Qiv+zWzmVtPnDpW4Go89z/nhThMZY6J+4RvnrWwwqpK/CzxjgGIjWXmpWHKEr19md9DYrod1u2ZfHp/sDFi9C0DPBulJQCGAueG4rxxXsAshe/ifSxMpJdhP3VhRhOjgdzoPhlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615455; c=relaxed/simple;
	bh=8bEYkkeM27xq1ln76w0J2gogAxCckDwrft2marES+Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uxzaq7qvV+D+93MK7cLy70qiso36ZDwNu+AN0XyTtFtQFcpFqccc5ICVTu6BgV0HVbVnSDrUSof9mqv3CIpgfMx9e1VPgEVHC3LYC38Iar2tVbo2diajuC+5+gaew2vcKwMaUKOV3fiiaBGNlUIhxzrVGaeuOIb4OHkI6gcUSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vm/vHTR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5238DC4CEF1;
	Wed, 28 Jan 2026 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615454;
	bh=8bEYkkeM27xq1ln76w0J2gogAxCckDwrft2marES+Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vm/vHTR53YNitnChs/86p6BB2wZ4tg9qIGH1Nn+bPhuQc9oSVNHv6VUABx3BflVRZ
	 69f6QKz7KlIgjBRGY50Y8U9y6/boK2yXLi3BVdh4XonuIFqepHnjia0Q/eOKZHvkm9
	 wIBmnEy8jJjEL4Vh2Aown0DoSyFAyZqJjQ5JVku8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 015/227] ata: libata: Add DIPM and HIPM to ata_dev_print_features() early return
Date: Wed, 28 Jan 2026 16:21:00 +0100
Message-ID: <20260128145344.891933097@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212419-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2D3FAA5ADD
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 89531b68fc293e91187bf0992147e8d22c65cff3 ]

ata_dev_print_features() is supposed to return early and not print anything
if there are no features supported.

However, commit b1f5af54f1f5 ("ata: libata-core: Advertize device support
for DIPM and HIPM features") added additional features to
ata_dev_print_features() without updating the early return conditional.

Add the missing features to the early return conditional.

Fixes: b1f5af54f1f5 ("ata: libata-core: Advertize device support for DIPM and HIPM features")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Wolf <wolf@yoxt.cc>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 490cc0d628d3b..c41714bea77e8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2872,7 +2872,8 @@ static void ata_dev_config_lpm(struct ata_device *dev)
 
 static void ata_dev_print_features(struct ata_device *dev)
 {
-	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK) && !dev->cpr_log)
+	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK) && !dev->cpr_log &&
+	    !ata_id_has_hipm(dev->id) && !ata_id_has_dipm(dev->id))
 		return;
 
 	ata_dev_info(dev,
-- 
2.51.0




