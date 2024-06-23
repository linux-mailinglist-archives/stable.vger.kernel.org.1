Return-Path: <stable+bounces-54949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3464913B7C
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB43B227D6
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB919DF7E;
	Sun, 23 Jun 2024 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/eF+Mlh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C834E19DF76;
	Sun, 23 Jun 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150351; cv=none; b=MSyOusrIWipqY/yHJVOgvhwfWOzYXB1gbaa8huM8/K9y/l78Tnoipzznvc/CoRxv/rs+OAalw7+JqKJKjtWP4VDVY4HFSQ5aHO2g1aqyA8/2xAm+V4t2Ra3iNvzhHLihoV/QGPOA+8IttCaoRlweVQ7yV8IGdvCn5mS11YD6rcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150351; c=relaxed/simple;
	bh=UFJOeOlxlBYISUBkI7g+MZSSN4z+o6pCrFb1a6rKpw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqviK3/TiGlLZ4cIQEm3dfWhIu2xHGlbSYX3BUyWwt/mb8ukfcbJJ6DkEi6thPnm9UF0Elww1MGwPShOrII1raNAf0jiMTtnTvaFpuMNfIGXpzYwf7ygbA9VK7+nt5tRhWXm3KQmg9JO+qWmuIqPi43xHLn2OZcmFkmpiGE3AmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/eF+Mlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017BFC4AF07;
	Sun, 23 Jun 2024 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150351;
	bh=UFJOeOlxlBYISUBkI7g+MZSSN4z+o6pCrFb1a6rKpw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/eF+Mlh/jMjXcD4SK/3tPT78mNBhpV6FRf7lEUzkFm4OKabe1Z09iQwMKTNOHRtB
	 5OhHpsteJTa4D+uoME05p9rBJE1+RoOaFBD9j8/HyECx+LmAgQBcoJqN7pKfrjvklR
	 Ce0NqRIqPblMg+OIdKFIJYFRj4iW+sFfQJSc2HKQvkBSvwcm8c7287hOS7BpqLThdi
	 SrHgvfSmq85oYOz4Iq9t3AsRpR6vnbfDcU1QG/v1OYlzywjn6p71HN2ebgQg+1iwlT
	 HtAu0K38pQs2TqpfMlBhtvHYEG4Viqn7msCY3s5/Iu6JkAroABbJ0kwGWnRQ8GG7O8
	 bgwxSQi0L+z4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 2/2] mei: demote client disconnect warning on suspend to debug
Date: Sun, 23 Jun 2024 09:45:47 -0400
Message-ID: <20240623134548.810179-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134548.810179-1-sashal@kernel.org>
References: <20240623134548.810179-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
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
index 7310b476323c2..5cd29deb79858 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -268,7 +268,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
-- 
2.43.0


