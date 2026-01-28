Return-Path: <stable+bounces-212284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKXgMTkxemlT4gEAu9opvQ
	(envelope-from <stable+bounces-212284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BC9A4B2C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ECF731C7A25
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AD2305E2E;
	Wed, 28 Jan 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="boVIvIZi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B73033F4;
	Wed, 28 Jan 2026 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615003; cv=none; b=QlhE2veIh/uxd6TmPQe8GaIZUNt5BRAT5YOSzacs+CYA5yVsmPFWxD3wKY6x13e+Vmx4hjma+w3XRcvaKCbeI86tMbvbdQqbOUXa0VAmB+oWosbo4qY9mLm0RuzdEc8f9rLTlivTg6WUe+gTEEfJB4LRrQA4yQETj5ubqiU+C1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615003; c=relaxed/simple;
	bh=yGd2gnC0Z2xCfrYCMckzyG+vayaGNzQ5SKis5x7FviQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/UteRDGA5vACM23ioehlTBPNIsCQ/WZQMWLwql5KE/yZ00D8idUvueaEYuAQrd8UNtjwkKQO9EfAW2W7TnpgbBpU2GjZcUpbDYHLh+bDebcB8O3MZLsOfSV/uXAp2LLZUkF3nBNfcju3J+aSeSeErFnQ+l1a+HAKfgK07QM6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=boVIvIZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A068AC116C6;
	Wed, 28 Jan 2026 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615003;
	bh=yGd2gnC0Z2xCfrYCMckzyG+vayaGNzQ5SKis5x7FviQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boVIvIZi0+R6YPbqMt7LK+hh68xgkEY2RWiwescm6v14D0c5m+hGJQV8alzPNNkTF
	 Nac8Cluln73sEspXDvqepb0GZ1/dxbXCnVm40tt1u+PfQFVFitQRKerTWDMarTAGAJ
	 T/3WrYwkMaQ8OiDbWvKNKfGfFQvxps53bIfDypt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 017/169] ata: libata: Call ata_dev_config_lpm() for ATAPI devices
Date: Wed, 28 Jan 2026 16:21:40 +0100
Message-ID: <20260128145334.635443055@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212284-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 38BC9A4B2C
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index cdb41b66bff2b..fba5166168978 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3073,6 +3073,8 @@ int ata_dev_configure(struct ata_device *dev)
 				     ata_mode_string(xfer_mask),
 				     cdb_intr_string, atapi_an_string,
 				     dma_dir_string);
+
+		ata_dev_config_lpm(dev);
 	}
 
 	/* determine max_sectors */
-- 
2.51.0




