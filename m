Return-Path: <stable+bounces-133538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F0FA9260F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256EB465678
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7431E25E1;
	Thu, 17 Apr 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFos7TDT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33FA1CAA7D;
	Thu, 17 Apr 2025 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913379; cv=none; b=KttFpClBeQRvaRL1Q7gwpSG7XT54Cxm+H2C/3cqdYBbZuCjweHxWp/jGAKIQ9PAlV9sEDalj3syblr28ZNjywoL7/60bvGeubA/9x7N1SKCjGZu6wwSqjgLczd8UcSIG39xEfzAq5gp0ZGzAFXBL5SjqlRKATrWu42bqDwpl0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913379; c=relaxed/simple;
	bh=F3d0fIgJZdNDxtQcePKCLu//Adzp3z1NUmwxdgQBYrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtZGUIyWAZiKhOhUsxyiu+EVJKTt8qt9UILWFpuZ/MOtF5rIfrTb/xoQBa5lwx22LIWbqo+1vpYGy7EIXl8KPAwfmo8a9rjVllonzUZyQTlUtpfgHMr5t7IVBlOpBD+pzOW7id9MZ7Z+EQ+FxbcZSrtv3wWVuX2xcB5hPcd8WCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFos7TDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B5C4CEE4;
	Thu, 17 Apr 2025 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913378;
	bh=F3d0fIgJZdNDxtQcePKCLu//Adzp3z1NUmwxdgQBYrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFos7TDTmMUJxOOCixcoXgHKld0S83gJrVsKlr2Uov8YBl4MD4k9SlKQe2lOdTslc
	 dDyK8uZGvHy1FruPs4G9RjTPO4KxJC6IiLYVN1iwx9STzcmRwRff6lnvd74cD7Nerr
	 wqN3M2+LmVFs41b+feDy0a4LG3LdebQ8lFz4fXh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 6.14 319/449] i3c: Add NULL pointer check in i3c_master_queue_ibi()
Date: Thu, 17 Apr 2025 19:50:07 +0200
Message-ID: <20250417175130.957545454@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>

commit bd496a44f041da9ef3afe14d1d6193d460424e91 upstream.

The I3C master driver may receive an IBI from a target device that has not
been probed yet. In such cases, the master calls `i3c_master_queue_ibi()`
to queue an IBI work task, leading to "Unable to handle kernel read from
unreadable memory" and resulting in a kernel panic.

Typical IBI handling flow:
1. The I3C master scans target devices and probes their respective drivers.
2. The target device driver calls `i3c_device_request_ibi()` to enable IBI
   and assigns `dev->ibi = ibi`.
3. The I3C master receives an IBI from the target device and calls
   `i3c_master_queue_ibi()` to queue the target device driver’s IBI
   handler task.

However, since target device events are asynchronous to the I3C probe
sequence, step 3 may occur before step 2, causing `dev->ibi` to be `NULL`,
leading to a kernel panic.

Add a NULL pointer check in `i3c_master_queue_ibi()` to prevent accessing
an uninitialized `dev->ibi`, ensuring stability.

Fixes: 3a379bbcea0af ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/lkml/Z9gjGYudiYyl3bSe@lizhi-Precision-Tower-5810/
Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250326123047.2797946-1-manjunatha.venkatesh@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i3c/master.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2561,6 +2561,9 @@ static void i3c_master_unregister_i3c_de
  */
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
 {
+	if (!dev->ibi || !slot)
+		return;
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->ibi->wq, &slot->work);
 }



