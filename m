Return-Path: <stable+bounces-212281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH+YJao3eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:22:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2691A57A0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC81131C4217
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FC530E84B;
	Wed, 28 Jan 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z6Qeehj4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23098302163;
	Wed, 28 Jan 2026 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614993; cv=none; b=LQZ0vCbnNGmam1YNxYKTU/4TLIVFtbG8LB0kmGdPOY0AKTPeAfVAvoV09Mb8HCGXWhOZnhEVosk83N8CBxJN3eYN7wxJ2J7fCKCERpkxHnG9tAAK3397hFYElMBALNXRBUJ0vHftfrPbSSWUtR2/KO+RANjwiCKyg5o6PZCtDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614993; c=relaxed/simple;
	bh=vXyjk19kuizrE4/SrHV+5N7eliwoPjj16lpTSmz8aAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBRzUOYxW1ueevx73g4So5xSQI4gHRmP2JN9hUFBuDscNxm5axfk1oalHOHooDovd594B1aOr+71YX1KhnIVIqqIaAPWpjPfOFwVeZHBgPzFe1XiQDHqkcR6Gc+ZjkASEAkfiujyxdVQtcuapgp+9wEvsv6lGUYcgD79H9HwN0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z6Qeehj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F88C4CEF7;
	Wed, 28 Jan 2026 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614992;
	bh=vXyjk19kuizrE4/SrHV+5N7eliwoPjj16lpTSmz8aAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6Qeehj4NBF+BPG29PgvY7mkpmbtnXremo3k4+Q5gGrucml0z4vd23Epn3yVJZpGm
	 8AgksiqcFFhtp2eSqs+pmAmekumkXdjRkrATHlMN/bRKImBJDMNQKoVUVBxAlFuTTT
	 OBea602BPTrkS2Yhd6TOMphotaZNkOk/i2E2dFPo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 014/169] ata: libata-sata: Improve link_power_management_supported sysfs attribute
Date: Wed, 28 Jan 2026 16:21:37 +0100
Message-ID: <20260128145334.528576255@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212281-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,yoxt.cc:email]
X-Rspamd-Queue-Id: E2691A57A0
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit ce83767ea323baf8509a75eb0c783cd203e14789 ]

The link_power_management_supported sysfs attribute is currently set as
true even for ata ports that lack a .set_lpm() callback, e.g. dummy ports.

This is a bit silly, because while writing to the
link_power_management_policy sysfs attribute will make ata_scsi_lpm_store()
update ap->target_lpm_policy (thus sysfs will reflect the new value) and
call ata_port_schedule_eh() for the port, it is essentially a no-op.

This is because for a port without a .set_lpm() callback, once EH gets to
run, the ata_eh_link_set_lpm() will simply return, since the port does not
provide a .set_lpm() callback.

Thus, make sure that the link_power_management_supported sysfs attribute
is set to false for ports that lack a .set_lpm() callback. This way the
link_power_management_policy sysfs attribute will no longer be writable,
so we will no longer be misleading users to think that their sysfs write
actually does something.

Fixes: 0060beec0bfa ("ata: libata-sata: Add link_power_management_supported sysfs attribute")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Wolf <wolf@yoxt.cc>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index cad3855373cb1..5fbbdf6f87e34 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -909,7 +909,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
 	struct ata_link *link;
 	struct ata_device *dev;
 
-	if (ap->flags & ATA_FLAG_NO_LPM)
+	if ((ap->flags & ATA_FLAG_NO_LPM) || !ap->ops->set_lpm)
 		return false;
 
 	ata_for_each_link(link, ap, EDGE) {
-- 
2.51.0




