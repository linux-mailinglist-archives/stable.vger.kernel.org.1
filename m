Return-Path: <stable+bounces-49451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B68FED4E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78C31C232F0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9779219D08D;
	Thu,  6 Jun 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DvUPW7G/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE219D082;
	Thu,  6 Jun 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683472; cv=none; b=REt22DZWWlsIzH90Pdza8aZZfBsPTiTa581/nJr3w4hF4AL2CP0dW03Dvv6/SKKuwmKrfqQSG2pBDxD+97ZOITrYGDythvrg3YZVuIGvf0J4c+vp++CzShFs2z+qOEXV3NspHHHsCTUyx8V3W6HICDsa0OdlwHJrdoxhwTqeghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683472; c=relaxed/simple;
	bh=Y1pc5/JLmYAdpYZDmMmR4gHVWfrkwXGOjCZWmVI89Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVzyJFVEL4dZJ3ElLe0KZzZldyQxMwjw8rpxsIwsgUXCm4SYG0H3yaOzytsGkKyaH4bvz4TWiLA+oQ6Ay9Wt8NdgjfXdW4EVFV7nn1ElRTZB7buHDoCUAqR1P0nB/4iLfotWhXgAzRe84xgdDJQ+mkzpW9J0UFmspcvc25bwk5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DvUPW7G/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F26FC32781;
	Thu,  6 Jun 2024 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683472;
	bh=Y1pc5/JLmYAdpYZDmMmR4gHVWfrkwXGOjCZWmVI89Zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvUPW7G/pcvsJegpwzODlUFAmBwz/ZFDRFGdVCjn1laqcmpnqQB47APIYp4RSfJo4
	 mRywQ+hlxySFSFGP51+12qe4sHQzT4BXwYx59sLltbr7bjxSKFdZfrk8lqHSoQAacR
	 5QuOqmPmL7azjracjNDhB0BsmECnE8ZdPCsTqRbQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 415/744] serial: max3100: Lock port->lock when calling uart_handle_cts_change()
Date: Thu,  6 Jun 2024 16:01:27 +0200
Message-ID: <20240606131745.785204549@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 77ab53371a2066fdf9b895246505f5ef5a4b5d47 ]

uart_handle_cts_change() has to be called with port lock taken,
Since we run it in a separate work, the lock may not be taken at
the time of running. Make sure that it's taken by explicitly doing
that. Without it we got a splat:

  WARNING: CPU: 0 PID: 10 at drivers/tty/serial/serial_core.c:3491 uart_handle_cts_change+0xa6/0xb0
  ...
  Workqueue: max3100-0 max3100_work [max3100]
  RIP: 0010:uart_handle_cts_change+0xa6/0xb0
  ...
   max3100_handlerx+0xc5/0x110 [max3100]
   max3100_work+0x12a/0x340 [max3100]

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240402195306.269276-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max3100.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 5efb2b593be33..45022f2909f0a 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -213,7 +213,7 @@ static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 	return 0;
 }
 
-static int max3100_handlerx(struct max3100_port *s, u16 rx)
+static int max3100_handlerx_unlocked(struct max3100_port *s, u16 rx)
 {
 	unsigned int status = 0;
 	int ret = 0, cts;
@@ -254,6 +254,17 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
 	return ret;
 }
 
+static int max3100_handlerx(struct max3100_port *s, u16 rx)
+{
+	unsigned long flags;
+	int ret;
+
+	uart_port_lock_irqsave(&s->port, &flags);
+	ret = max3100_handlerx_unlocked(s, rx);
+	uart_port_unlock_irqrestore(&s->port, flags);
+	return ret;
+}
+
 static void max3100_work(struct work_struct *w)
 {
 	struct max3100_port *s = container_of(w, struct max3100_port, work);
-- 
2.43.0




