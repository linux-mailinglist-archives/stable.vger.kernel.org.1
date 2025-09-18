Return-Path: <stable+bounces-171140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1DB2A707
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8453C4E3B96
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2B21D88D7;
	Mon, 18 Aug 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j8sRzo7B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C17F335BA8;
	Mon, 18 Aug 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524945; cv=none; b=TJMY00VPTGyS+SOJ9yohN0Wx2pKeLrYA8mOn8cHR88dVdl2KQ+vHw4U1HcSizJDL7ZSoHzkyCWpm36SOt9BruU2IztkxLwUnnEavVnrhKDUbByQKYY4ZNW7j7fdCZ0zpYgMIEU46JsSD3fsOqRT2xdbOP+U5Q+x/uKZ7s45SAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524945; c=relaxed/simple;
	bh=TYu3x5uc7ql98o0EF7oOH32PiEXlkyDfy7IJ3KpNGOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8wu1AnlDk76kv8ewtaEhIB39SSN/901MaKd+UCN6C4bPKiNowUN1iTBYQclqKdp77MNJXwU+Fx3z5Rk4J0CYFJtXnw/tVcLuxHf5GksKmgWkotMfw65vQcIKkLZ/sbd/ypk8JAHnY5HyyJGA4QoBczpcz7FW160cmYcC6knbwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j8sRzo7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0622C4CEEB;
	Mon, 18 Aug 2025 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524945;
	bh=TYu3x5uc7ql98o0EF7oOH32PiEXlkyDfy7IJ3KpNGOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8sRzo7BAjU1hVaHZGzpfIxE+U6Ofih3KpLyjqV8KDaPH4luWFXp8WPMmRmqDmAzW
	 KXYiqzDcRW3WPaEQ2sjLZ0ZEGJyoIER3Ci08Ysvsi/iaVdz6zKjqR217wHGHg5C7Xo
	 p0tZ37AK68F0HKzAdeRdeq4SVmbR3wutd48cyv38=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 112/570] ata: ahci: Disallow LPM policy control if not supported
Date: Mon, 18 Aug 2025 14:41:39 +0200
Message-ID: <20250818124510.119392231@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 65b2c92f69d3df81422d27e5be012e357e733241 ]

Commit fa997b0576c9 ("ata: ahci: Do not enable LPM if no LPM states are
supported by the HBA") introduced an early return in
ahci_update_initial_lpm_policy() to ensure that the target_lpm_policy
of ports belonging to a host that does not support the Partial, Slumber
and DevSleep power states is unchanged and remains set to
ATA_LPM_UNKNOWN and thus prevents the execution of
ata_eh_link_set_lpm().

However, a user or a system daemon (e.g. systemd-udevd) may still
attempt changing the LPM policy through the sysfs
link_power_management_policy of the host.

Improve this to prevent sysfs LPM policy changes by setting the flag
ATA_FLAG_NO_LPM for the port of such host, and initialize the port
target_lpm_policy to ATA_LPM_MAX_POWER to guarantee that no unsupported
low power state is being used on the port and its link.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Link: https://lore.kernel.org/r/20250701125321.69496-9-dlemoal@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index aa93b0ecbbc6..04c9b601cac1 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1782,7 +1782,10 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	if ((ap->host->flags & ATA_HOST_NO_PART) &&
 	    (ap->host->flags & ATA_HOST_NO_SSC) &&
 	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {
-		ata_port_dbg(ap, "no LPM states supported, not enabling LPM\n");
+		ata_port_dbg(ap,
+			"No LPM states supported, forcing LPM max_power\n");
+		ap->flags |= ATA_FLAG_NO_LPM;
+		ap->target_lpm_policy = ATA_LPM_MAX_POWER;
 		return;
 	}
 
-- 
2.39.5




