Return-Path: <stable+bounces-227587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIR1BheGvWnQ+gIAu9opvQ
	(envelope-from <stable+bounces-227587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:38:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9A62DEC77
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FFE03206409
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CD13C3453;
	Fri, 20 Mar 2026 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zR2G/Uv3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD66399353
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027896; cv=none; b=u8oNRI9u6MhaDVOhKjqtpdO6LpyGBkeGTqNlkSDdTvzqAVdjtIaNDgQ0Bv9TBrdhat/vJbcgPphxE879gHmkxW15opz9j1f8TFzME7kIqUUFSMqV+wxAV92acIX6qgXZATYqqL6v8ey9N+2kKHKXYMWLd6sCmba3qj5veNXGQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027896; c=relaxed/simple;
	bh=oD9F1SNAB+cgLimOsQjaB/dKvwl7V/OP7iW6tfqqFJ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pmvEoqDFb4CfesxO3iG4AT17BjZhzZvgi6tA6qVEIbb3eFpM5ws62HoMps2RhEIncb6RVsgEkrAvflUPIf0phnXYnp/yWxZP8m2VCpjw1WuWK4OYUGxbhZiOVzARKQF0YItP9fH4u/vwXCO2nTMz/Vfr4A55b/fksyWPMvTF9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zR2G/Uv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C02C4CEF7;
	Fri, 20 Mar 2026 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774027896;
	bh=oD9F1SNAB+cgLimOsQjaB/dKvwl7V/OP7iW6tfqqFJ0=;
	h=Subject:To:Cc:From:Date:From;
	b=zR2G/Uv3CSV2/OA2ZYtsAck06QIFda+qeC8FO3PnC3A/qbu/egIQBrcYh3pLKNPQQ
	 1Q4h6YXGj8/6gfUmPysqJSvjOiuM0pMmgF+aNWRJl0JQHFSPoTMfTcA4nlbhM00ir5
	 8u3Jt0H8BDtQHGl+BifWSnykSfL9oRd3McM8zKv8=
Subject: FAILED: patch "[PATCH] ata: libata-scsi: report correct sense field pointer in" failed to apply to 6.12-stable tree
To: dlemoal@kernel.org,cassel@kernel.org,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Mar 2026 18:31:32 +0100
Message-ID: <2026032032-sludge-profanity-a10a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227587-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.943];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,roeck-us.net:email]
X-Rspamd-Queue-Id: 6D9A62DEC77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e6d7eba23b666d85cacee0643be280d6ce1ebffc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032032-sludge-profanity-a10a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6d7eba23b666d85cacee0643be280d6ce1ebffc Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Fri, 20 Mar 2026 12:48:01 +0900
Subject: [PATCH] ata: libata-scsi: report correct sense field pointer in
 ata_scsiop_maint_in()

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

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ad798e5246b4..3b65df914ebb 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3600,7 +3600,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_device *dev,
 
 	if (cdb[2] != 1 && cdb[2] != 3) {
 		ata_dev_warn(dev, "invalid command format %d\n", cdb[2]);
-		ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
+		ata_scsi_set_invalid_field(dev, cmd, 2, 0xff);
 		return 0;
 	}
 


