Return-Path: <stable+bounces-16840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BCE840EA2
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D2C6B24E22
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030B615A4B6;
	Mon, 29 Jan 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pAGta8oZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6958158D71;
	Mon, 29 Jan 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548318; cv=none; b=K8248JibuyU9QUF9GlgL980TMcpkKmL5t8EP1erf0j3oZF5fb8pmzfi8YpWATlIIm/KziofB6F37mIzhmQU1Fbl5LYyxrb0ija9C977k7Yk3noxuCk+z7+RfbSwKJuvAI/Fd3rpRUapvXiL2c7ld9RUPkQEiqVMleNDroD7Ooac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548318; c=relaxed/simple;
	bh=F9YcEt0nqGCqf04bm98MkUmxciGSdGZ9aDyouSkpX94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKACcFdXpSI++fpqiT57u0wRtxJYmswBXm8ca2dZYlh5tjEx0PTP7J82ZD/jTerX77r47d4HwiJHSKuarr5kgf2Bz9vueMuUsKWpNKImRh1OyQE3qKfFBU8OXyElrWJm3Nrz3wNn90hcs9ijSFGtERqjk0lsqWgtgdyYiAopt6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pAGta8oZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206B5C43390;
	Mon, 29 Jan 2024 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548318;
	bh=F9YcEt0nqGCqf04bm98MkUmxciGSdGZ9aDyouSkpX94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pAGta8oZGwmW996NPhiNvQp/zI0CSv+a24/N3HVWHE+5wXngFAt79tMogq6LD62C4
	 WFCvn4a3lhi0E0JtYMqPi85jsqZZa3actfy3+XxIsKDKjo7+FfKEbqdfR/Owfl8bFt
	 osw3vDUJS5cXlBzFCh9lXLoluhe+m8vtbD6Txq4s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 321/346] firmware: arm_ffa: Add missing rwlock_init() in ffa_setup_partitions()
Date: Mon, 29 Jan 2024 09:05:52 -0800
Message-ID: <20240129170025.918914934@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit 59b2e242b13192e50bf47df3780bf8a7e2260e98 ]

Add the missing rwlock initialization for the individual FF-A partition
information in ffa_setup_partitions().

Fixes: 0184450b8b1e ("firmware: arm_ffa: Add schedule receiver callback mechanism")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20240108-ffa_fixes_6-8-v1-1-75bf7035bc50@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 6146b2927d5c..ed1d6a24934e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1226,6 +1226,7 @@ static void ffa_setup_partitions(void)
 			ffa_device_unregister(ffa_dev);
 			continue;
 		}
+		rwlock_init(&info->rw_lock);
 		xa_store(&drv_info->partition_info, tpbuf->id, info, GFP_KERNEL);
 	}
 	drv_info->partition_count = count;
-- 
2.43.0




