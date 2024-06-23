Return-Path: <stable+bounces-54951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A30F5913B82
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 16:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2E1F24076
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06EE19E7D5;
	Sun, 23 Jun 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uikhtEkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBE01836D5;
	Sun, 23 Jun 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150356; cv=none; b=jJolGnErsvCq//Ygpk1SFwgnhRIaaBIlW870t07Bf5KsuO9/iIpgWYuA/p0fR9gu0jOIIETjQxY3a73Muf/40E06R6uTRvR0uerN2Nh8ZT4JONeU5tc/+rJKiSrjl99NoLI6gFksBRTrDYnbcJaV1GcdOxW2hThxvcmfHEMWYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150356; c=relaxed/simple;
	bh=Lvwlpo562o6c0PcIk5nCn4hbfXuM2Lbz9iOHYp/N42k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6JzrrUWaFuyeSkP9WkPWhOdwEUITlC288E6pDKgVlosIAMSZLT/SIVoG9/npAAZroEonVdMbWMYXdPRIDs5pGOfhtKnYxExhOYFT9k/xYA/9dMXi80vLQKULLe+00X9nRLbsRTH4v0D/toWbzVGV1dVvY0ZqBPEkcnSSRdNMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uikhtEkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC08C4AF09;
	Sun, 23 Jun 2024 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150355;
	bh=Lvwlpo562o6c0PcIk5nCn4hbfXuM2Lbz9iOHYp/N42k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uikhtEkXn2V1BqA5m9hHJNAW0VN31WiWm8HGNrPtR2glbWNFw9xVwvQ5ZmVXZpXkO
	 OpovlFQPM/W6ajdfdlooSdSlcAMK/XVEZ4VVFlouq+JlHnTFrFQJQ4ZcgXZsoqB7jZ
	 PqVrjtX+7IQ2K4go+nJzD2FwJWrjoLxizRFdmJe+nnS7sVDe2AudiTjJVC3OgCycrn
	 bNcEGv1BLzautTWlKiXln2mTpMDnJRycVEJ6GNUHQNOn2Z/KGks1BWOFG3F5t+sqD9
	 HjEWNbri5Gyv2ehJ1s3IB6YNGYmtiRKOmZafeCoOr56epoGOKcZhCerH404fTxRFLD
	 ZsXa9AkYIuuIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 2/2] mei: demote client disconnect warning on suspend to debug
Date: Sun, 23 Jun 2024 09:45:52 -0400
Message-ID: <20240623134552.810231-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134552.810231-1-sashal@kernel.org>
References: <20240623134552.810231-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.316
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit 1db5322b7e6b58e1b304ce69a50e9dca798ca95b ]

Change level for the "not connected" client message in the write
callback from error to debug.

The MEI driver currently disconnects all clients upon system suspend.
This behavior is by design and user-space applications with
open connections before the suspend are expected to handle errors upon
resume, by reopening their handles, reconnecting,
and retrying their operations.

However, the current driver implementation logs an error message every
time a write operation is attempted on a disconnected client.
Since this is a normal and expected flow after system resume
logging this as an error can be misleading.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240530091415.725247-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 87281b3695e60..e87c2b13c381e 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -271,7 +271,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
-- 
2.43.0


