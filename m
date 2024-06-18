Return-Path: <stable+bounces-53653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627BF90D747
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 17:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4491C28B20D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175224B29;
	Tue, 18 Jun 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuXU8WD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D52374C;
	Tue, 18 Jun 2024 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724518; cv=none; b=Cs7Bi/s2yBRCCCGAqzTZddADe/L4LaEbbS3NXwwV2ujQXbXZJtPNmyx15kgrxKlvdpZpqC2L9E/T1K53zY2qqsgRSjKdElkfUnsF2t4mcfYM51d49NCt+JpVkVxUwzt7d3FTUeYxj/KK4HmXEthOJuPO1KEKdo0yKGFZO4Plooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724518; c=relaxed/simple;
	bh=du4uYRUyBre9GJwIUBABF9CFXaOVppE+rA63dxQj/GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3eZxxrN/mFHgx8yPdEYLqEAfABblr2rw8+S1+tgAR0hEs9Ik9268nsZa1+m+yE8l9f/OOQ2W5M7xfHTRwjTTi1DEBcepYakVCZNCWrQLOrDZRHK9N6PpKbtVJ6NE5mQVNdYqQ51v3wEfJ8aEtrVy4+11N3tJhcqQMSwawBys80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuXU8WD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549BFC4AF1D;
	Tue, 18 Jun 2024 15:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718724517;
	bh=du4uYRUyBre9GJwIUBABF9CFXaOVppE+rA63dxQj/GA=;
	h=From:To:Cc:Subject:Date:From;
	b=GuXU8WD4ncpWVPQNdyAljUrihqX9fP+D4i3pcFGb3IKduXOYnEXWHgzeokqQeHHpn
	 N1Uiv3c+Ltk4SzI65+XCFLqdBY1Sd62A1k3mAb7Fv8A7wsgcg721ss2s9b1zjXsqeH
	 EJQt/9W3DJdcFffBlbyW8QqZ2dXFAPXTP4YbCVU4iV50oxnepN8uTvucKgRS1y4O6n
	 Df+qfUKZrblXwfoGPw44hdOgiqhpwhuuDszIHi4BiGqXSrty1BlNG/CMk4CiFN9LHX
	 PYV/nxLa0muWF6ZhpoM3QMAqZ8ZrO/TFBaKdUCc5N1vZRQE5RmCOt5skfHHHoOy4S5
	 3bWFGzkyb+xnQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>
Cc: stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: ahci: Do not enable LPM if no LPM states are supported by the HBA
Date: Tue, 18 Jun 2024 17:28:29 +0200
Message-ID: <20240618152828.2686771-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=cassel@kernel.org; h=from:subject; bh=du4uYRUyBre9GJwIUBABF9CFXaOVppE+rA63dxQj/GA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIKl8+Z4JxYGP/5UPfB5+eeO3zind8bXdlSJGa5ckLtt ENv/jzy7ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE1v9j+Cuc5RB90GpvgtTx 5+FX26d8e6XNPyHsTnTmzcYFLhN/vV/G8D9q2+smT8F75TN0rui3ndi+y7b495wbAfdSburd7tx 4k4MJAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

LPM consists of HIPM (host initiated power management) and DIPM
(device initiated power management).

ata_eh_set_lpm() will only enable HIPM if both the HBA and the device
supports it.

However, DIPM will be enabled as long as the device supports it.
The HBA will later reject the device's request to enter a power state
that it does not support (Slumber/Partial/DevSleep) (DevSleep is never
initiated by the device).

For a HBA that doesn't support any LPM states, simply don't set a LPM
policy such that all the HIPM/DIPM probing/enabling will be skipped.

Not enabling HIPM or DIPM in the first place is safer than relying on
the device following the AHCI specification and respecting the NAK.
(There are comments in the code that some devices misbehave when
receiving a NAK.)

Performing this check in ahci_update_initial_lpm_policy() also has the
advantage that a HBA that doesn't support any LPM states will take the
exact same code paths as a port that is external/hot plug capable.

Side note: the port in ata_port_dbg() has not been given a unique id yet,
but this is not overly important as the debug print is disabled unless
explicitly enabled using dynamic debug. A follow-up series will make sure
that the unique id assignment will be done earlier. For now, the important
thing is that the function returns before setting the LPM policy.

Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1: Add debug print as suggested by Mika.

 drivers/ata/ahci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 07d66d2c5f0d..5eb38fbbbecd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1735,6 +1735,14 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 	if (ap->pflags & ATA_PFLAG_EXTERNAL)
 		return;
 
+	/* If no LPM states are supported by the HBA, do not bother with LPM */
+	if ((ap->host->flags & ATA_HOST_NO_PART) &&
+	    (ap->host->flags & ATA_HOST_NO_SSC) &&
+	    (ap->host->flags & ATA_HOST_NO_DEVSLP)) {
+		ata_port_dbg(ap, "no LPM states supported, not enabling LPM\n");
+		return;
+	}
+
 	/* user modified policy via module param */
 	if (mobile_lpm_policy != -1) {
 		policy = mobile_lpm_policy;
-- 
2.45.2


