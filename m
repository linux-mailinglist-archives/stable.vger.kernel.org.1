Return-Path: <stable+bounces-227351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CWqGNwxvGnxuQIAu9opvQ
	(envelope-from <stable+bounces-227351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:26:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C802CFF63
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4DA4306A829
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD1330FC1E;
	Thu, 19 Mar 2026 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9TDFjXW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9F244694
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940697; cv=none; b=YcbnFa3vPEEojPckq9d268x1dThYoLOVav2ZRTOVrbOTo2ljtYs7WvrXuIJjJpg7gAJhqudGYV07jwUn647GRPN4F10BU04sO9fsrKuMhDK/SmivnVNIet59Qz/1twB5mSoQ96f8TjkfVn8d6nzk5aupPekODdI8rh83A3N43Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940697; c=relaxed/simple;
	bh=QPbJcRbKerA+3iTpTGiNSDAZkUtpE9YH3B85ibI0koQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2PrT/ENzv4xBuMussuFi8dGdb33EYkEenwQj9X1XRSuKQ500a2UwP+AyvZXLO2oCe/Hx6Uf3oOmp382rKkFnvkTt0wA2bEoggGCUTgcBIkPDER74BsbfhSbiN0GHSiOoPeOApJtuLuN/pPBH8BLJERySRTIwMvMV87214mqyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9TDFjXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73317C19425;
	Thu, 19 Mar 2026 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773940697;
	bh=QPbJcRbKerA+3iTpTGiNSDAZkUtpE9YH3B85ibI0koQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9TDFjXWnTadoRzsa/Wx67704kaPith3HD2jTkEENaJrZ1rfqHqORKPDNKf4Rshoy
	 1zlXa+B9OXD5Lp5XU4BDnXgb/8/jAgJNnjz5iz9t//Zg6b8uZKoXuMVs0KGrzEbA6U
	 eepRXcc5GIp4uSfxIaEDXLuIJVoauaaNjF203Md0hhTMWBvGyofWNqyFOizJOOUODc
	 SgOeOOJVf1hve+90iBFJ149M1gZ/+65PRx+3u6hp1U59KbXihLiA3m2NWABidMOj6E
	 zk0SzOiS7QqzQtv46clhiB0kBa0dTiTf18QhIXKxowjkWPC2m/yoTyoJvsWnCVABYk
	 vVyx//5xP4XJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] iio: buffer: Fix wait_queue not being removed
Date: Thu, 19 Mar 2026 13:18:14 -0400
Message-ID: <20260319171814.2756731-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171814.2756731-1-sashal@kernel.org>
References: <2026031730-control-earplugs-97b6@gregkh>
 <20260319171814.2756731-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227351-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,huawei.com:email,baylibre.com:email]
X-Rspamd-Queue-Id: A6C802CFF63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nuno Sá <nuno.sa@analog.com>

[ Upstream commit 064234044056c93a3719d6893e6e5a26a94a61b6 ]

In the edge case where the IIO device is unregistered while we're
buffering, we were directly returning an error without removing the wait
queue. Instead, set 'ret' and break out of the loop.

Fixes: 9eeee3b0bf19 ("iio: Add output buffer support")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index e02a4cb3d491c..d0bcb9c57f965 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -194,8 +194,10 @@ static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
 	written = 0;
 	add_wait_queue(&rb->pollq, &wait);
 	do {
-		if (!indio_dev->info)
-			return -ENODEV;
+		if (!indio_dev->info) {
+			ret = -ENODEV;
+			break;
+		}
 
 		if (!iio_buffer_space_available(rb)) {
 			if (signal_pending(current)) {
-- 
2.51.0


