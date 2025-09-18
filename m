Return-Path: <stable+bounces-170173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70945B2A328
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE2C172E39
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2801C31CA72;
	Mon, 18 Aug 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v2dhiNdN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969527B355;
	Mon, 18 Aug 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521767; cv=none; b=lSy6VImkhcIafchcbVS9m4kw2jd6C7rbbV+2GBK1A81FtnSLfHh84X+mI6Kr2VYwdIY14IY4U8LU8TYOXIUjBc0Z5drmeBg1gm/ewvOI6P9ygiwX5xAmsr6wMtVJU5/8pIc38RWkOwB+cEjDoMu0mW/VvenfVMgp8ktTGgKUYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521767; c=relaxed/simple;
	bh=TNZ3LFm//iulHZCEqcOk3UDvVoDNf5bve8Qjf0JZ1kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMZbIqJqLm3JaDkL9o2no4m5angKo+K6za8rCsxCcOyVcPGyWDxNRDNEbkPhyP9M2zBxLjiQ4J04sqF1P3OH5DVfqRqyqtdsXpg4NQ3/x07m0ncBPE2h/oXzMmEiFTS8/MXYscJ078jbfjAjkhJGuzmCIswiadlKiQbpWf5JVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v2dhiNdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E19C4CEF1;
	Mon, 18 Aug 2025 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521767;
	bh=TNZ3LFm//iulHZCEqcOk3UDvVoDNf5bve8Qjf0JZ1kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v2dhiNdN6QLaXJVuKr4qkpFDBXSDGxd/ZoPv4YtOjWYWq9Kz5btJFTnqnpOcM7oG2
	 7tRRYk3NK+8fcsh4Xu+0Q5BlfRrX3YJ8FjAfbTnmh2H5tCz5etnEw/yLhqe15gvDhe
	 y1zzLIbIem8Vr+5f302f3XMmVyOlJyBKsPbCDf9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 084/444] ata: ahci: Disallow LPM policy control if not supported
Date: Mon, 18 Aug 2025 14:41:50 +0200
Message-ID: <20250818124452.101442562@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index a6a66d794763..61d34ca0d9f4 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1785,7 +1785,10 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
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




