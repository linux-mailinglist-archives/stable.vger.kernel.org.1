Return-Path: <stable+bounces-212417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBx8Jk02eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:16:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A608BA55C0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23108308B32C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC22FE044;
	Wed, 28 Jan 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AEZvw6pY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D02F25EF;
	Wed, 28 Jan 2026 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615448; cv=none; b=FVa5gdQSmrDQVs3s578G1Ui0hepVJHq6vJtBkJmtBxiBM7Ncqjm8c/DGjeidbLB6xP1gsJE9R4h0C2to5/XMGUnujHnGVu2NNauG/BopdgfKwQ9+BvqViG7NJs3Vu0SY0CY7myIgMu4kI0ahhWghR5gV/mdt7hBHcMAvM4ra2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615448; c=relaxed/simple;
	bh=NPOB0+UHxq2JTEip4Zya0iNl3UrxwL70h6z2RScXxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0rqZkGnjUCgjkOGuQe0gOUvmPeV8jzA8sPBPVBxxM3CeKMYb/eGJkPRxRIPbrAtQAZSYXCe2ce5ljsWRmBqFuYEUqXXo44cNt+/2D67aOtJXvQDQptUOrOMHhn2e0RQYVo9bb2i6QFfTwTDi0/EPC58mTekvTboFZjCqswy/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AEZvw6pY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D7C4CEF7;
	Wed, 28 Jan 2026 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615448;
	bh=NPOB0+UHxq2JTEip4Zya0iNl3UrxwL70h6z2RScXxhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AEZvw6pYRExNCGXKOU4liEWFSnZ1U2UVNAnOj7okbPpuiQwaBddNDJFZOw4Fn0yqL
	 uKanW4X48AqAsjXO/NHH/fQc8lCfSw0diVZJgtcc/Qb4j7wM1GHF/l8Gg6g3aPM4X2
	 Rm5mtrTqXiJ8bvEOlbgD6Txc8kewXYPD264Bip4k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 013/227] ata: libata-sata: Improve link_power_management_supported sysfs attribute
Date: Wed, 28 Jan 2026 16:20:58 +0100
Message-ID: <20260128145344.819260909@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212417-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,yoxt.cc:email]
X-Rspamd-Queue-Id: A608BA55C0
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index b2817a2995d6b..04e1e774645e2 100644
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




