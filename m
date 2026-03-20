Return-Path: <stable+bounces-227631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJg1MUPCvWmEBQMAu9opvQ
	(envelope-from <stable+bounces-227631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:55:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD92E1846
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 22:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E966730382BF
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAFC3D47A0;
	Fri, 20 Mar 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEHHC/5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2535C1BD
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774043688; cv=none; b=Aldnq/AckIsnV+wjdA57jE/DgJk2Kkn0kAZUGf59/9IS89FxOqeStwG8PbJYCXndf5t9OzFfRGKBvuOLUMz8ldccivlgYdDvri8vgozilGmvLZIg4yhHUmH+ZHpTDp5TQBmjCfjgcHaPW2YWEfiACbEyfRGc0B0TUUYJOCryb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774043688; c=relaxed/simple;
	bh=tgEkR7vaYqT2gQ+X2o/EEdnRvQLJlvz9zp/WeDmtYCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIjufOR/XBrEcBynVA4V53+6nxrqFpiHTxhy3WkU7cWylVEKcIpuub78J4N6epsbvwtUVQqiVQEzfZ6V3nq+k/kbEJWjwbm7yFHekuojKpWe0ORPt9pXZhbaG3WLnavMh81G2DpNurjzSkkOOIqNZx8v1xh4/8FulWk4eSN9yQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEHHC/5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A902CC2BC87;
	Fri, 20 Mar 2026 21:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774043688;
	bh=tgEkR7vaYqT2gQ+X2o/EEdnRvQLJlvz9zp/WeDmtYCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEHHC/5uK1orBPw14XjoHRMcxuMpFkZGYUM1W4ftgAP532VQOxEaRPAwEqVSHdotf
	 eJEtXvTe0GJp3C/mQeq1NVsYsxPSSuFPB6E7EzsKeExhYNg8INVH/HTXXyHYmbPOea
	 rz1wSiz+bRXqSyryc9lKyrNFj8vFoLK5DvcOVxY5aeaJ+7XMhOW9fIWp+P/vRdh17l
	 9O9Fs4bn8YQbx3ss9u63XdaYELV2343DI/HjE7YEzTrajnWO/W3rTfbVegV9NtQ59+
	 Bik2ieBWwQwZ++gSvSmJyVg6a/y1Nq1/kmBmymrutq2j0hWoqtgTr5naG+q2tMAAzT
	 JRNmUXyote2kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ata: libata-scsi: report correct sense field pointer in ata_scsiop_maint_in()
Date: Fri, 20 Mar 2026 17:54:45 -0400
Message-ID: <20260320215445.132838-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320215445.132838-1-sashal@kernel.org>
References: <2026032032-sludge-profanity-a10a@gregkh>
 <20260320215445.132838-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227631-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7AD92E1846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit e6d7eba23b666d85cacee0643be280d6ce1ebffc ]

Commit 4ab7bb976343 ("ata: libata-scsi: Refactor ata_scsiop_maint_in()")
modified ata_scsiop_maint_in() to directly call
ata_scsi_set_invalid_field() to set the field pointer of the sense data
of a failed MAINTENANCE IN command. However, in the case of an invalid
command format, the sense data field incorrectly indicates byte 1 of
the CDB. Fix this to indicate byte 2 of the command.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 4ab7bb976343 ("ata: libata-scsi: Refactor ata_scsiop_maint_in()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bfabf27adfce5..b55443e31f403 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3611,7 +3611,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
-		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
 
-- 
2.51.0


