Return-Path: <stable+bounces-30024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4134888907
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 03:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F456282A87
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65D01586CB;
	Sun, 24 Mar 2024 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuMjR+Zw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A721514EC;
	Sun, 24 Mar 2024 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321531; cv=none; b=Ywkjx08B6lBBKfnaL8J+/y/fKgL7yXVjO7OBeVwxIRXIwChs9I41WKmSLMe88WsgWEb3yXm347SRiGBpt70QH1SI75bYCTDK9WQ5x/8ltwnUnaOvUvVMEWbND1+Pce4pQfRHHqDhHxMVE++wEt62dyoDmXjhBzygh/lCTYAWueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321531; c=relaxed/simple;
	bh=rUzDKGth/ccwZ7iKH6Jz+5Q6eJnmE3TflhykP87e3wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuqRodHJHEFyOw2hpqSDMgB0Kcdrgucl/Tj0rW5MDjP/WZOdiQhVe+w4C+FimUsP9JgHyrnzMHVqM8SQ7BPGzczkP293KVZCACTQRZ1FMhsPYLh7qiV5lhL5lwMU2URYLjC4VHk7f91Bja/Q886KV6t8dbolMAYYjW13G1SSaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuMjR+Zw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DB7C43399;
	Sun, 24 Mar 2024 23:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321530;
	bh=rUzDKGth/ccwZ7iKH6Jz+5Q6eJnmE3TflhykP87e3wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuMjR+ZwUSpp8VqduA/RBSi3o7wuWxEz7JrQOP8p0BOviHWLRCrbqNh1NgfjfhZJt
	 dClBkyTPU1ZLbr2BLapNdDs6IbKJE7YlA+Ik6LwwVX/eyO+esLf7AR0ms8bAMk49KB
	 tpm8lVWp3IQxMS3LXVdpBPGNUNyBr5w2nL17aHWzPuaIOF7UwTm34fuwFD6p+THwIy
	 xMRGqmTJ9wMKIWShRNHoVVOljDUDWtKBicVXcHdUN/3yVGqmYvPoEcpNDsw8o6Oj8K
	 8Smru3UQE34kruNQHoJUE/pAbye3pHQ1qqARg7xku5oxjamv5huom7PuZO3A0LoH0I
	 s297kbsYC9ksw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gen Xu <genxu6@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 257/638] wifi: mt76: mt792x: fix ethtool warning
Date: Sun, 24 Mar 2024 18:54:54 -0400
Message-ID: <20240324230116.1348576-258-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gen Xu <genxu6@gmail.com>

[ Upstream commit 7b4f9cd6a5fc221895b1d9be83ee3c13c00d09ab ]

Add a missing EHT related field to fix the following ethtool warning:
[98179.287352] mt7921e 0003:01:00.0: ei: 74  SSTATS_LEN: 73

Fixes: c74df1c067f2 ("wifi: mt76: mt792x: introduce mt792x-lib module")
Signed-off-by: Gen Xu <genxu6@gmail.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index f111c47fdca56..2fb1141e5fa96 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -332,6 +332,7 @@ static const char mt792x_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_bw_40",
 	"v_tx_bw_80",
 	"v_tx_bw_160",
+	"v_tx_bw_320",
 	"v_tx_mcs_0",
 	"v_tx_mcs_1",
 	"v_tx_mcs_2",
-- 
2.43.0


