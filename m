Return-Path: <stable+bounces-157082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0A1AE5263
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8CF17CDFE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9CA2222CA;
	Mon, 23 Jun 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2WvGaabM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604B4315A;
	Mon, 23 Jun 2025 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714992; cv=none; b=ZdnWVyO5HJ9JY457cbHQ3Q6dHEEv07asiYOLCMv1kTN68tG8ZfbV/L2MB45W7Raaxup3Ejw8bZS4sD5Efp76nprpG3MK55I+eiMI98PFS/P3OeCn+v4ze68K1t8rvUTqw6z0u452vd0/dTZYvWNgn70SDFQD9VdVc8agERM6k1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714992; c=relaxed/simple;
	bh=iIQPAj8vuQovK5CES3gWrC5JadHSAHHUrxqzYMfy6cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTPwCOoAlY2QndyhCfH3i4BGqGJss/F9RmCjvjBaZcQHEyWArpECqrSwAS0HMe6GhI5iu4Aor9wpeculLsBuLjEOvjgzJFrr5VqdKqqQGLgCKSvNjmsCrq+1PjEij4eO6yIgl2PNwJjHqWegN+oHK5QJCoLbyRsTlc0Uo+Dg9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2WvGaabM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9330AC4CEEA;
	Mon, 23 Jun 2025 21:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714989;
	bh=iIQPAj8vuQovK5CES3gWrC5JadHSAHHUrxqzYMfy6cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2WvGaabM3amziZyyJlVBnwJz7uFw9HAGIwpit1dUD7Q3m2G7sWjl+i0roPMxy5qUN
	 N2cSeKp6HvigmhWiBpIc7XvG5i+zX0kJ+/zEzQatEDdwxW9IY1f1W92sNFD1nNro+G
	 pSrjeHERNBOinDSYP2/XzZorFVNKlLc1emd2ysIE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 430/592] bus: fsl-mc: increase MC_CMD_COMPLETION_TIMEOUT_MS value
Date: Mon, 23 Jun 2025 15:06:28 +0200
Message-ID: <20250623130710.662899012@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

[ Upstream commit 23d060136841c58c2f9ee8c08ad945d1879ead4b ]

In case the MC firmware runs in debug mode with extensive prints pushed
to the console, the current timeout of 500ms is not enough.
Increase the timeout value so that we don't have any chance of wrongly
assuming that the firmware is not responding when it's just taking more
time.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20250408105814.2837951-7-ioana.ciornei@nxp.com
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/fsl-mc/mc-sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index f2052cd0a0517..b22c59d57c8f0 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -19,7 +19,7 @@
 /*
  * Timeout in milliseconds to wait for the completion of an MC command
  */
-#define MC_CMD_COMPLETION_TIMEOUT_MS	500
+#define MC_CMD_COMPLETION_TIMEOUT_MS	15000
 
 /*
  * usleep_range() min and max values used to throttle down polling
-- 
2.39.5




