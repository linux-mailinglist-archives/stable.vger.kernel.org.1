Return-Path: <stable+bounces-212088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ItbGd4temnd3gEAu9opvQ
	(envelope-from <stable+bounces-212088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:40:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A60A42A5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69E18300BEBA
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EEF23E358;
	Wed, 28 Jan 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXor8ZfI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED250155757;
	Wed, 28 Jan 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614361; cv=none; b=Q8oK5WnkgzmxTGjl19D8bwPXHwfvgk34ltONe5bmkDRX+jEJcgM6Niu1zL3G64zyztZZehb7XLBvXcRGDo0e4A2/zKfOTSyUPwhhF5UegvtQVO6lUIF5bft9KpBlb34zvbpL0VUJpbuCW/sjDormTN7ZOElePbiHlK96FbyzlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614361; c=relaxed/simple;
	bh=NrgUM5w7qE0qZBORCy4LaVJPgbs/yNjQVDExmCkjPLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a20wIptHPMeHXO2Z5oBWQPpM+2XGYTXgoPfV4foWiRQCVfE/Aniw9NQPzNaSPcD8fETaFTwllRW2LvN+NEZrdt1sbxhoqrWB3BmW9JOWqbgY2F5MxKnIETyRhx48icKhlyxG8dq3Pt1oziyx3uExizS6zyKd6vQblPhAYa6fnrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXor8ZfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A74DC4CEF1;
	Wed, 28 Jan 2026 15:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614360;
	bh=NrgUM5w7qE0qZBORCy4LaVJPgbs/yNjQVDExmCkjPLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXor8ZfIkGkmOCKMZNf9AgK+G73azc3WolhKvVVlGBay4WWx5LSGJkjmyMpQsKnrH
	 Rs2IwbbdoML5nKQeM3nU0m6tb1HbIeBDzxSmlNSDSbBKdY4grDB/vg1MtaxlFFMR4f
	 PUiCXbnN/IAM5ly9adVEQGP22MvsC3LCUCbdokCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 113/254] ata: libata: Call ata_dev_config_lpm() for ATAPI devices
Date: Wed, 28 Jan 2026 16:21:29 +0100
Message-ID: <20260128145348.890170268@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212088-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,yoxt.cc:email]
X-Rspamd-Queue-Id: B9A60A42A5
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 8f3fb33f8f3f825c708ece800c921977c157f9b6 ]

Commit d360121832d8 ("ata: libata-core: Introduce ata_dev_config_lpm()")
introduced ata_dev_config_lpm(). However, it only called this function for
ATA_DEV_ATA and ATA_DEV_ZAC devices, not for ATA_DEV_ATAPI devices.

Additionally, commit d99a9142e782 ("ata: libata-core: Move device LPM quirk
settings to ata_dev_config_lpm()") moved the LPM quirk application from
ata_dev_configure() to ata_dev_config_lpm(), causing LPM quirks for ATAPI
devices to no longer be applied.

Call ata_dev_config_lpm() also for ATAPI devices, such that LPM quirks are
applied for ATAPI devices with an entry in __ata_dev_quirks once again.

Fixes: d360121832d8 ("ata: libata-core: Introduce ata_dev_config_lpm()")
Fixes: d99a9142e782 ("ata: libata-core: Move device LPM quirk settings to ata_dev_config_lpm()")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Wolf <wolf@yoxt.cc>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Stable-dep-of: c8c6fb886f57 ("ata: libata: Print features also for ATAPI devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b748c8ead39de..e51a27ae0a7d2 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3047,6 +3047,8 @@ int ata_dev_configure(struct ata_device *dev)
 				     ata_mode_string(xfer_mask),
 				     cdb_intr_string, atapi_an_string,
 				     dma_dir_string);
+
+		ata_dev_config_lpm(dev);
 	}
 
 	/* determine max_sectors */
-- 
2.51.0




