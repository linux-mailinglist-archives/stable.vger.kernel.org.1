Return-Path: <stable+bounces-110250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04ECA19EDE
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 08:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6906E3A19A6
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 07:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E02120B219;
	Thu, 23 Jan 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nPgc0KvF"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47691BD01F;
	Thu, 23 Jan 2025 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617107; cv=none; b=ZfTFzYk4GE0LlkvUiFx0iW6FdXN9Ymj9C17jXiltb6cQrU7kILTbwnBLi5uQpWOCdt2pC3FXHnZ8ijOYLtYBC/vR4HyMPLK+T1SXo633HdnOPaOb3TANjR2kP9pPoLGXJT4oUfIWEVxu04N2LebJF9S/kib3zYzh6Gn/FNwNNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617107; c=relaxed/simple;
	bh=Debs92GqllIvAo5tz//ts3ajdhLFtAitLJrVVjdqBw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pxe1sYmbGa1mYgW5/JJR8M+pKjuUfV6UanMnoRs3QiY3tzZt/qwRCUfcsysN2FY0dPyFdipyiAoWsTNy8IdhjWvcU6rwRA+JU69OzMHlHqgo/a92KjKkw2HaoKSyn9OEasMeLPUui0apxzmCdoyUMnCd03SKlAFKgzRLDSZtfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nPgc0KvF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737617092;
	bh=Debs92GqllIvAo5tz//ts3ajdhLFtAitLJrVVjdqBw8=;
	h=From:Date:Subject:To:Cc:From;
	b=nPgc0KvFnQsgcmBz6nL7PVbWNpMqc0xTZmcKiei/kB3EXKi4GVDoHvolxaByrDc2+
	 b8wqO6embvBMw2MmOqEYeooIJ5iQwNzeVEsjCA6ve2uNxYNLM6ZehHxpcVTt/4HpQ+
	 jlEZDjV4aymiFEEc0wIZmnUC5JrFWMs1xbvJmnAE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 23 Jan 2025 08:22:40 +0100
Subject: [PATCH RESEND net] ptp: Ensure info->enable callback is always set
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250123-ptp-enable-v1-1-b015834d3a47@weissschuh.net>
To: Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737617091; l=1710;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Debs92GqllIvAo5tz//ts3ajdhLFtAitLJrVVjdqBw8=;
 b=4Al51+qegCJBhYdwnvbSjp14rgVlerdoz/4tUDHZtdP5i2+8gsmxpgR9VHN3WoVl8/mo96/41
 zQ29mJfDQzXA3d/gwBvCNMcag0ocRtDk6cywydr6rt8DuZSN+a1OOi9
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


