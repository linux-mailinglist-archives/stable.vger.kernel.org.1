Return-Path: <stable+bounces-212285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKGfOlAxemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86248A4B6A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE67E306195D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B1430F548;
	Wed, 28 Jan 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LJ92hhoM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3AE30EF7F;
	Wed, 28 Jan 2026 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615006; cv=none; b=Dzm6Bf81z9t2eQrZwllGZIure1VCNJ1Q+3bbEarkwjUVosYFYcYyfv96uN0qSWYH3O6BmCtmS3Fs+60T2tTK1bVJCDHdu6fwJojvii0/WN5g0jz0PvnLig2deo91UNtAz1L768rbM9JFncj2blAljxdNxdz8X7cdlQJJUaSz+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615006; c=relaxed/simple;
	bh=pg2NRNgcm16VcKoo/BhGSs4WTEm0KfHtZD32DMSkMc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYeI58IIdpRMxNwH1u0KDBzVb95mCdMbXTvT08OfFGDdEHl3ICfICFDcRqWSmFIrgF9RQ3PRlCtP/c4CiJtcea9M5ntsC31VcCehpCabVIz4GE469sIory0rb4eX/3ogCpfJX2EHm5CvBP4IBK6Kc4lL/PNj9yguoOP2e6O+KIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LJ92hhoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2746FC116C6;
	Wed, 28 Jan 2026 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615006;
	bh=pg2NRNgcm16VcKoo/BhGSs4WTEm0KfHtZD32DMSkMc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJ92hhoM+1mmsoPMvKlpWLKdTWN9wtlFrynqQXoCj+H/nXIMKRenzciRd1wrTHqe0
	 7dIrSy2WAumHDCdGnvbN0noAvik9l01XPXS9SKG+I0jkXzJqvVKFNe3I3y7AIhcHpi
	 HiJBBmp84b9dXBKFD5ZySwnzXUd0UO5ngkK8rQZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 018/169] ata: libata: Print features also for ATAPI devices
Date: Wed, 28 Jan 2026 16:21:41 +0100
Message-ID: <20260128145334.671906543@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212285-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 86248A4B6A
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit c8c6fb886f57d5bf71fb6de6334a143608d35707 ]

Commit d633b8a702ab ("libata: print feature list on device scan")
added a print of the features supported by the device for ATA_DEV_ATA and
ATA_DEV_ZAC devices, but not for ATA_DEV_ATAPI devices.

Fix this by printing the features also for ATAPI devices.

Before changes:
ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133

After changes:
ata1.00: ATAPI: Slimtype DVD A  DU8AESH, 6C2M, max UDMA/133
ata1.00: Features: Dev-Attention HIPM DIPM

Fixes: d633b8a702ab ("libata: print feature list on device scan")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Wolf <wolf@yoxt.cc>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fba5166168978..33454d01c2044 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3075,6 +3075,9 @@ int ata_dev_configure(struct ata_device *dev)
 				     dma_dir_string);
 
 		ata_dev_config_lpm(dev);
+
+		if (print_info)
+			ata_dev_print_features(dev);
 	}
 
 	/* determine max_sectors */
-- 
2.51.0




