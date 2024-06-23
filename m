Return-Path: <stable+bounces-54944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EC4913B70
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567E6280A49
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315FF19CD07;
	Sun, 23 Jun 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKhy+4ip"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAC183095;
	Sun, 23 Jun 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150342; cv=none; b=uaED2pfNtVOF+sG7Kn3wWJlw6QqdMZqim9z3oC5VlKzVFlQYuyl29WOxYKZcloyAe84t3uuwroVLvixEouLQFxL+U2mkbrpwGTtnMEUSI0QbiZ6/vfwyjvsaQ5Veqs9k6sO0x2el3OXW/4ryP6sxaWYLHkMn/uHmK5s+eedjJYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150342; c=relaxed/simple;
	bh=yrn8IB4GK2xfaYBhl2B1FmZuyslzHz28+PlSSOmFO7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbynukfoeddrV07axnW2x0xBN9PvpnG2FoCCWBVa9NlsUSBgYbDHzKmCWR1y+paAjv52MOHSlAJXYuh09cPSxswItM1JpmI+KepqMKQLjm2247oy0mVrYZAw4yKqwWx8zxkfFivby0cExTQCvTwpFHfEnr8r08l0SzbHN4/+xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKhy+4ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223FC32781;
	Sun, 23 Jun 2024 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150341;
	bh=yrn8IB4GK2xfaYBhl2B1FmZuyslzHz28+PlSSOmFO7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKhy+4ip1fJFC1nzODMYuixA0u67QV8EELkr95IAidoEksKq02TW6PO1wH2JVU/6X
	 sDnfKSK7IWTdRxOfjdUoh1HqZU0mggqXxnKxkIX7JzzQYjXSOq0aCm61tK6Fm17nL9
	 k2648Em4V/HCE8JBPta7iSfJOp0n3Jk5mfuQHpv6gnEl/liWKHWTWmqhpJGZPZAz9Y
	 UgeDONz1o+EIaSjmatn5/8NV99c4ALqtzxS8wyqhDtilERCZjRw9qZh6M8D+wO8IVH
	 xbYuR7usP05sepfWgF8XOm/wi+Lch2NHyd1I8oXLyTuuTCBNHX0y2sA7hE/1MXlUFf
	 wKCG4ToU6LC3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 2/3] mei: demote client disconnect warning on suspend to debug
Date: Sun, 23 Jun 2024 09:45:36 -0400
Message-ID: <20240623134538.810055-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134538.810055-1-sashal@kernel.org>
References: <20240623134538.810055-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
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
index 786f7c8f7f619..71f15fba21ad6 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -327,7 +327,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
-- 
2.43.0


