Return-Path: <stable+bounces-126621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D73A70979
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 19:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B89E1899644
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB1D1F9A83;
	Tue, 25 Mar 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onbHTxWs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5A1EE7C4;
	Tue, 25 Mar 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928193; cv=none; b=gFoZFcHL3Cq8i6eBPRP8NRrqv1kuNtx3Dk4+a/kA+3KIuXt7tDo8Bn4nSFa3wpt0bQFNr+C7ec74j9xJa3sYph+gmQJLKFmoGHYPxlw7KI/hhLfaWHHk6oTOeBmsYLXly5x8J2EE8VgeNm5c+NzJXdfnyEhNWSOdEJIUts5GSUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928193; c=relaxed/simple;
	bh=qKysUtbqgECWt4ejiYMsB2WxYSks8fISKOCETNl/QNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QGmVrQ4swGKg47jQ/WJyThrl2Od+Orm7FDJnzh7f2iDbYeDjohtbi/AHzXhzjl3lQruv4UAhYLrOEiRHE3W3gwIm/o2DTrBg6Ly4ReAwgumtwdSzHhdJqjHzfw1hmExEVi+gcs5XVquZl+Ki63zq/6SJkNDE3AbOKd16NuuZHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onbHTxWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45D3C4CEED;
	Tue, 25 Mar 2025 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928192;
	bh=qKysUtbqgECWt4ejiYMsB2WxYSks8fISKOCETNl/QNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onbHTxWsjeljn4tpPE6gzpjcOA/ERluhHEn6FdNJDZetPD6+oz0B2Bb1dnPodL1hw
	 meQsmPRivI1pxzQRzz5bvd4BbXcgRk+5cxsXMh/FQN7Z0eh3qOHVAc0hAdo5eCy+4p
	 bXc/GGX07YFvkxabRoYbb+cdKH7HORb4jbiGgXBudd/OHXtSnWsAe+QHZ8EEoKAZ0w
	 gvRUf2yMQ1gwhSnt/vRHmEpLPRV3eC/mTwckGNi3VcaKdTXOBVPVz06ebWRn8uaOVw
	 OIaKNmHT/5YeA3KMb1pmu0XuPFjiZYC0+gKFUe7vUnfiDntaJSuJEKlJUUPqWhZxIZ
	 mLDMH2/XTWGcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tasos Sahanidis <tasos@tasossah.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/2] hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}
Date: Tue, 25 Mar 2025 14:43:06 -0400
Message-Id: <20250325184306.2152429-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325184306.2152429-1-sashal@kernel.org>
References: <20250325184306.2152429-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Tasos Sahanidis <tasos@tasossah.com>

[ Upstream commit 815f80ad20b63830949a77c816e35395d5d55144 ]

pwm_num is set to 7 for these chips, but NCT6776_REG_PWM_MODE and
NCT6776_PWM_MODE_MASK only contain 6 values.

Fix this by adding another 0 to the end of each array.

Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
Link: https://lore.kernel.org/r/20250312030832.106475-1-tasos@tasossah.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 3645a19cdaf4d..71cfc1c5bd12e 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -420,8 +420,8 @@ static const s8 NCT6776_BEEP_BITS[] = {
 static const u16 NCT6776_REG_TOLERANCE_H[] = {
 	0x10c, 0x20c, 0x30c, 0x80c, 0x90c, 0xa0c, 0xb0c };
 
-static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0 };
-static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_REG_PWM_MODE[] = { 0x04, 0, 0, 0, 0, 0, 0 };
+static const u8 NCT6776_PWM_MODE_MASK[] = { 0x01, 0, 0, 0, 0, 0, 0 };
 
 static const u16 NCT6776_REG_FAN_MIN[] = {
 	0x63a, 0x63c, 0x63e, 0x640, 0x642, 0x64a, 0x64c };
-- 
2.39.5


