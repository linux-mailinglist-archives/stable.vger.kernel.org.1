Return-Path: <stable+bounces-110219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6EFA1989F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 19:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7853AAC71
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F08215772;
	Wed, 22 Jan 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pardySH8"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03971215057;
	Wed, 22 Jan 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571222; cv=none; b=UFX/XZ1Nir8bnT6XgnWIGeU8N2c/GmQPepvvBQX9hqGvLJOrn8h0nQoZrf7bVBDAiU3xWtopvSLjTx4aAYXlaFIbv7xYFKxJpxh3CF6GpkPDxeKXcxiubcO8EizCD0OmRVO406nIhqoM7ttELriUNacK68OGhmJK7/CPyOxzF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571222; c=relaxed/simple;
	bh=Debs92GqllIvAo5tz//ts3ajdhLFtAitLJrVVjdqBw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iZPuEe3LCVjRJR6eyFNWhy8vYzPAZWHVg+YJ+awmsUYPHk/Vr/CriJ4RRL4m8RzrnT3R0aKihSmjPSOKaX2FkHt+xTFPcATiy+/3rwQ3OGoxaUAEBo5OceWX4y1jQZKBI2DcrVJu+IVDGu+a4CESYpCEedhoHR1TKGvyo9s5Ul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pardySH8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571215;
	bh=Debs92GqllIvAo5tz//ts3ajdhLFtAitLJrVVjdqBw8=;
	h=From:Date:Subject:To:Cc:From;
	b=pardySH8rQ//PNMhNnhfO0S9Kb9bYl6BNhH9umof92Qe2PdDuI8oTSFdjS7Zr3AAS
	 BFUMKQqpiYpvppahv0JVb6qPv4WPWGO7xRj25PEKvozHxO3uK98Gxy49KJoRtPahKp
	 OhooVS8g+6PLjsfOFsyrbCMX7KMXrXr+qwal4qpI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 22 Jan 2025 19:39:31 +0100
Subject: [PATCH net] ptp: Ensure info->enable callback is always set
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-ptp-enable-v1-1-979d3d24591d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGI7kWcC/x3MQQqAIBBA0avErBvIsaK6SrQom2ogTFQikO6et
 HyL/xME9sIBhiKB51uCXDZDlQWYY7Y7o6zZQBU1lSJCFx2ynZeTsdNK6960VFMHOXCeN3n+2Qi
 WI0zv+wE2v3XFYQAAAA==
X-Change-ID: 20250122-ptp-enable-831339c62428
To: Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571215; l=1710;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Debs92GqllIvAo5tz//ts3ajdhLFtAitLJrVVjdqBw8=;
 b=N2LjNeJvrpV5p42JOGr0mBhFbB6jEM5Cdh5udh6WlX+/Wtkd5GG+B2VLWWqnuEhdBbISCcPtR
 EzVXImsofqkDdf6CKcUXI4W1XZyyFtRvmAdWmFy7mqImaolt+/lfrzb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ioctl and sysfs handlers unconditionally call the ->enable callback.
Not all drivers implement that callback, leading to NULL dereferences.
Example of affected drivers: ptp_s390.c, ptp_vclock.c and ptp_mock.c.

Instead use a dummy callback if no better was specified by the driver.

Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/ptp/ptp_clock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index b932425ddc6a3789504164a69d1b8eba47da462c..35a5994bf64f6373c08269d63aaeac3f4ab31ff0 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -217,6 +217,11 @@ static int ptp_getcycles64(struct ptp_clock_info *info, struct timespec64 *ts)
 		return info->gettime64(info, ts);
 }
 
+static int ptp_enable(struct ptp_clock_info *ptp, struct ptp_clock_request *request, int on)
+{
+	return -EOPNOTSUPP;
+}
+
 static void ptp_aux_kworker(struct kthread_work *work)
 {
 	struct ptp_clock *ptp = container_of(work, struct ptp_clock,
@@ -294,6 +299,9 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 			ptp->info->getcrosscycles = ptp->info->getcrosststamp;
 	}
 
+	if (!ptp->info->enable)
+		ptp->info->enable = ptp_enable;
+
 	if (ptp->info->do_aux_work) {
 		kthread_init_delayed_work(&ptp->aux_work, ptp_aux_kworker);
 		ptp->kworker = kthread_run_worker(0, "ptp%d", ptp->index);

---
base-commit: c4b9570cfb63501638db720f3bee9f6dfd044b82
change-id: 20250122-ptp-enable-831339c62428

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


