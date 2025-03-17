Return-Path: <stable+bounces-124728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693CA65AEA
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747A93B5831
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7EF1B423D;
	Mon, 17 Mar 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c29/RMJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129981B3939;
	Mon, 17 Mar 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232789; cv=none; b=B+4AsSvOcbmIpJFIoUxxFHusi0163iKQwVD+Rbl46nl5yPtQwsjV3BLh3KlvJo2bAqtRykqUeO5MIl4oL4QF8em4ojmz6WXhEgXwFmU8RpkIR95ztqwBEyLfOTYWmtS2r4DCbB4snvdqYfrZahJJfK/biIJX8sVl8/YqL3ZLjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232789; c=relaxed/simple;
	bh=wERbn4kBmMeAPJCDjs03pPXuCHSsoNStUceXsER8kfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCWfHv0tBDThws+avyalKEdMwjSeKZaNTe3qapiVokZwfWdh8798zYAQdRB8dOYFTwug+vrgyxAxmKA0bVyJH7Fb9SvxJjUyA4BGiUGsCCQDfcLQu754ytZZz87/TD6E9ik/9+UpOhFHIQQMrsJ9hQx9pOHreY4aI8OUaAQckPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c29/RMJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DFDC4CEEC;
	Mon, 17 Mar 2025 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232788;
	bh=wERbn4kBmMeAPJCDjs03pPXuCHSsoNStUceXsER8kfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c29/RMJmA2Qn1op7meFNHGcS3taIA6oFQyis3TENTVDak/fX5dawK/Kg5Q6zwXhAo
	 K5KvWEX2weUC+mNVK3hzyX6BrIHebDPZ0MO8VPaeKIUrnEUxBJ9cfmhIG+hVKVmYCb
	 duYJUfOPYI6M5kcUOr58B5JgfetjFD1LRya+gQ4R1+wweXe86/sUjYChpNjC9t7Uuc
	 PulWntsOPFm4tCVimby8ZY2CGXa8Sbm26952b5Gxy7/a915ot4LidEPExx1vxdu+yh
	 34v5njjrLzldp3gXIKTGDyHyFhQ1w/AJK6LoNM0AcFtdCJPrg+vm68UdqxJmSDW1Ml
	 9/Lsozk//3FDQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 6/7] net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
Date: Mon, 17 Mar 2025 18:32:49 +0100
Message-ID: <20250317173250.28780-7-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317173250.28780-1-kabel@kernel.org>
References: <20250317173250.28780-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix internal PHYs definition for the 6320 family, which has only 2
internal PHYs (on ports 3 and 4).

Fixes: bc3931557d1d ("net: dsa: mv88e6xxx: Add number of internal PHYs")
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: <stable@vger.kernel.org> # 6.6.x
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 74b8bae226e4..88f479dc328c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6242,7 +6242,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
@@ -6269,7 +6270,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
-- 
2.48.1


