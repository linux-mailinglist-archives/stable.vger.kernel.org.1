Return-Path: <stable+bounces-44067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CED8C5112
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792AA1F2141C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6F12F5A4;
	Tue, 14 May 2024 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PCy7vtMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8912880A;
	Tue, 14 May 2024 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684033; cv=none; b=nj7P0iLMoncjswJLGNOh5bT0J5zJ5vcgqf4cuIIEgEgRdQdMgFlulHW412E74JHLxjcB4Y2O0NGhfbxiPA+9HHTUPqiW6x2B1PovgziaB5xBqCZEwLzQM3LE1SP9wMIj8oJ0urzBdirdj8jLfVxfGvG8h20fPHnQjE+fAfAR8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684033; c=relaxed/simple;
	bh=TBKGuXcafzvLg7tjDHbPg5q0D6oS3JI7sxFuDct3UuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSCa/c/2sKPxW0Dz/hr9D0XqamKW5LyMBGKr/bxIRz3Xmhjd1iW+n5yAwQ0RbFYCKwaxMgxAbY3V+BlBgS7zx97gqaVPoUwpAAoCDF7tX9dLrlAFLdAdwQi1YswiE+ucUvCeiEtxLvRTfZxUCvWXyk3zhcoD/4Z5Xqmu+eYp/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PCy7vtMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AEBC2BD10;
	Tue, 14 May 2024 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684033;
	bh=TBKGuXcafzvLg7tjDHbPg5q0D6oS3JI7sxFuDct3UuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCy7vtMY5OQLQ4LEZdY0mGQpMosvVZFqPtsC5l8wq2GlJLutlUS+R7yo7GxAAMLxF
	 FFUoA+pIrbb8JG490xfZ4F6jhXjNXgvbENkCuDjXU9f/YcN3xVg1Ed+r9LTS/zmSDG
	 G8zVCL28ZlpVv+pkxoA7z7U3qh98HbWNFRcsVs5I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
	Eddie James <eajames@linux.ibm.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.8 310/336] hwmon: (pmbus/ucd9000) Increase delay from 250 to 500us
Date: Tue, 14 May 2024 12:18:34 +0200
Message-ID: <20240514101050.321845612@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lakshmi Yadlapati <lakshmiy@us.ibm.com>

commit 26e8383b116d0dbe74e28f86646563ab46d66d83 upstream.

Following the failure observed with a delay of 250us, experiments were
conducted with various delays. It was found that a delay of 350us
effectively mitigated the issue.

To provide a more optimal solution while still allowing a margin for
stability, the delay is being adjusted to 500us.

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Link: https://lore.kernel.org/r/20240507194603.1305750-1-lakshmiy@us.ibm.com
Fixes: 8d655e6523764 ("hwmon: (ucd90320) Add minimum delay between bus accesses")
Reviewed-by: Eddie James <eajames@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/ucd9000.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -80,11 +80,11 @@ struct ucd9000_debugfs_entry {
  * It has been observed that the UCD90320 randomly fails register access when
  * doing another access right on the back of a register write. To mitigate this
  * make sure that there is a minimum delay between a write access and the
- * following access. The 250us is based on experimental data. At a delay of
- * 200us the issue seems to go away. Add a bit of extra margin to allow for
+ * following access. The 500 is based on experimental data. At a delay of
+ * 350us the issue seems to go away. Add a bit of extra margin to allow for
  * system to system differences.
  */
-#define UCD90320_WAIT_DELAY_US 250
+#define UCD90320_WAIT_DELAY_US 500
 
 static inline void ucd90320_wait(const struct ucd9000_data *data)
 {



