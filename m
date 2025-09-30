Return-Path: <stable+bounces-182349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DABBAD7B8
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6318D189BCFB
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA10302CD6;
	Tue, 30 Sep 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0+oiRKYv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C41FF1C8;
	Tue, 30 Sep 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244653; cv=none; b=j0E35WRU4cKVoUtKALrAKPXxsHe+J7h6QKjxAJPJ+oNbGn+aVDr0NNXppnTMtkNmu0zz9xcVHg+RYdVb9HaTXHSCLsqil2e6JlE11CYdw7akOoTgdsc+gduUUMeZSacyyfRUY+sY7DW3JyJMy9TsSVdUTTEjdUH/nSZEzgE/gqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244653; c=relaxed/simple;
	bh=E5H8uEBbuwXFCJqMfUsNKuyq3ceKXdIAkn0tuf+N470=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhXpJgPul7eHUPYNuc57P/Fmm8NGWKf9CTqMttcvPVzJ3fia+bxF5Z9LpoxR2oT7hvx2Wn6j90f2gv8Zte7C/2FyR957h6+eKn51397Bc1EdETh8ic3Gw4/+0s5vmLGSMmx2m6JKnWhJ6gu0ZL5XMb5QETW5HayXhFUdrazSRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0+oiRKYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A029FC4CEF0;
	Tue, 30 Sep 2025 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244653;
	bh=E5H8uEBbuwXFCJqMfUsNKuyq3ceKXdIAkn0tuf+N470=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0+oiRKYvOLnbhe3eVz34M7rsCkaRz5DG0iJ6pWBXHGjrV7TNBMXQO+3LVginOaTqS
	 lCyq8jVLqa6a3cnt5IFg0NoDhKzA1BTGbmugNUhR0blgf7jf3P1M763fvxX2WkxKRL
	 Ov7dSrYH16jB469dsgj7/YRCl6nADCcB9uyh6lw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Clark <jjc@jclark.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 073/143] broadcom: fix support for PTP_PEROUT_DUTY_CYCLE
Date: Tue, 30 Sep 2025 16:46:37 +0200
Message-ID: <20250930143834.149194844@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 6e6c88d85623dc0c5c3faf185c12bd723efde5ee ]

The bcm_ptp_perout_locked() function has support for handling
PTP_PEROUT_DUTY_CYCLE, but its not listed in the supported_perout_flags.
Attempts to use the duty cycle support will be rejected since commit
d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to
ptp_clock_info"), as this flag accidentally missed while doing the
conversion.

Drop the unnecessary supported flags check from the bcm_ptp_perout_locked()
function and correctly set the supported_perout_flags. This fixes use of
the PTP_PEROUT_DUTY_CYCLE support for the broadcom driver.

Reported-by: James Clark <jjc@jclark.com>
Fixes: d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to ptp_clock_info")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Tested-by: James Clark <jjc@jclark.com>
Link: https://patch.msgid.link/20250918-jk-fix-bcm-phy-supported-flags-v1-1-747b60407c9c@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/bcm-phy-ptp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index eba8b5fb1365f..1cf695ac73cc5 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -597,10 +597,6 @@ static int bcm_ptp_perout_locked(struct bcm_ptp_private *priv,
 
 	period = BCM_MAX_PERIOD_8NS;	/* write nonzero value */
 
-	/* Reject unsupported flags */
-	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE)
-		return -EOPNOTSUPP;
-
 	if (req->flags & PTP_PEROUT_DUTY_CYCLE)
 		pulse = ktime_to_ns(ktime_set(req->on.sec, req->on.nsec));
 	else
@@ -741,6 +737,7 @@ static const struct ptp_clock_info bcm_ptp_clock_info = {
 	.n_pins		= 1,
 	.n_per_out	= 1,
 	.n_ext_ts	= 1,
+	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE,
 };
 
 static void bcm_ptp_txtstamp(struct mii_timestamper *mii_ts,
-- 
2.51.0




