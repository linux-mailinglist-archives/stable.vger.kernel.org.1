Return-Path: <stable+bounces-230108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLotCupowmlScwQAu9opvQ
	(envelope-from <stable+bounces-230108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:35:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E333067F2
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01BE13072FE2
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00993E4C6F;
	Tue, 24 Mar 2026 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmiIw88N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061B18E02A;
	Tue, 24 Mar 2026 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348263; cv=none; b=cbybia+xHzaYd6HGly2WLIvV9mwwu+vPxiOxswQrQy2LbM3BxWYr7WOI0swvr7KI6tAzXmg+hAbMa5erCK10a1M4zHOJ94gM36IKk350PqDTAg0ABBoxujM8XrzntP7upBZ0j0O2+XChmXPNQoszO4PrTpfE7FfCLzQcEGeLpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348263; c=relaxed/simple;
	bh=O5oLilp5PYvGLIHjlXW3o/oo9dXA5vlBEiYCNSbf/i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulvb8uEZFKs5nqxI9uBdHny4/1ttGiZnjuDBYpGDVuvCCErb+DWoY1BRnisso85v9xt+7J8IVk1Tsh1M3uXLY3vZi682VjW0hbFQglN0wUxfQ5eU1UYUrZMvZB61P2AbHX5eKE1ZpMpESaIyxiY2DKjzZx9V3tPm+fVLrwFCWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmiIw88N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE756C19424;
	Tue, 24 Mar 2026 10:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348262;
	bh=O5oLilp5PYvGLIHjlXW3o/oo9dXA5vlBEiYCNSbf/i8=;
	h=From:To:Cc:Subject:Date:From;
	b=rmiIw88NVq03EST+qWMT8JG7lJ9qCfrb30OwRpxP7VyQHtjpIptEEe1ymboC+5QIE
	 wtL77SnPDsJs6tQhOmtnPgD7ZvlgMxHgom023F+08BFF6pvGlqy0ELoXFHnWYmccjy
	 oJtEs5q4PABIZiMadOhve50H8QhWCjxmBsSM9yUEOLyKZIy/mASXvVv5aIYe7I+bc8
	 4mldpYn0L+pZj24Eu4VWYzxJ4CsRx91l6z91xEvGQ1m2rk9VldVDVtFdJp5R+MkJcF
	 i9frbaNM4IB9v592LtpiF5r9GeQOVg4XZr/0UCYQzlND3646mUZPqjDiW3ynGMEfxw
	 Mbplv5dDwm/wA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4z2K-0000000478n-1Y5z;
	Tue, 24 Mar 2026 11:31:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Saravana Kannan <saravanak@kernel.org>
Subject: [PATCH] spi: fix resource leaks on device setup failure
Date: Tue, 24 Mar 2026 11:30:42 +0100
Message-ID: <20260324103042.980740-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230108-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0E333067F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make sure to call controller cleanup() on late device setup failures to
avoid leaking resources allocated by setup().

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Cc: stable@vger.kernel.org	# 5.13
Cc: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9fe9f99183bf..cb00619864cf 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4091,7 +4091,7 @@ int spi_setup(struct spi_device *spi)
 	status = spi_set_cs_timing(spi);
 	if (status) {
 		mutex_unlock(&spi->controller->io_mutex);
-		return status;
+		goto err_cleanup;
 	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
@@ -4100,7 +4100,7 @@ int spi_setup(struct spi_device *spi)
 			mutex_unlock(&spi->controller->io_mutex);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
-			return status;
+			goto err_cleanup;
 		}
 
 		/*
@@ -4136,6 +4136,12 @@ int spi_setup(struct spi_device *spi)
 			status);
 
 	return status;
+
+err_cleanup:
+	if (spi->controller->cleanup)
+		spi->controller->cleanup(spi);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
-- 
2.52.0


