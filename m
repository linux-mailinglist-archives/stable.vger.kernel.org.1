Return-Path: <stable+bounces-82193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC9E994B95
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49EC1F27B29
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667EA1DED60;
	Tue,  8 Oct 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ahfy7FKO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235861DE3AE;
	Tue,  8 Oct 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391454; cv=none; b=EIXvfpZneTHAnLbrc1NpF5ASomA26m+mNJI9O75MnheHrWuJXWYHBuSruI/6CA3XLlQPfjg/MKomZnEGsx0GioDtAmFlF1pOQ8EqQg2gLbYOHuMWpsjbL7F1zkz4s0T6zt8+geG4dHKphBdiOEFsNsTFIP1rvMj6UDSUuWF4Cps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391454; c=relaxed/simple;
	bh=XkS/hj9edexZu6T0ofnd9GrupNrQcencINDY632Smjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gT2Z7yjg7iQ3cD6FuFL4bkYQ4+JBKy/PUQfy6MHzZCi3mR/uBlndvGGMq6Y4W2/EPq5ybCyzQu5i2v7AFgG0F00o7VeLtBUL9tbjmQA4cMvNMIVK9otrhtETzUVs+vI0juJs6Na+GZ69RyRiCSielc36Tao9q+wR08wGArpD1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ahfy7FKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE5C4CEC7;
	Tue,  8 Oct 2024 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391454;
	bh=XkS/hj9edexZu6T0ofnd9GrupNrQcencINDY632Smjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ahfy7FKO0D/fjsFNe0hQNlx9j9yOsLSjxA9MbgtNd/snmEy/3cXxOO4jhNS1mp06B
	 S7u4pxWiq069VnafOkwjmE+HjUiEiA/OEVtOGpYThky2vFNopAaJS7XsP1XPqO0zav
	 8hQFTFt187uQFtnygxXPFwuuEusFyZHjryRLpdQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 120/558] ACPI: EC: Do not release locks during operation region accesses
Date: Tue,  8 Oct 2024 14:02:30 +0200
Message-ID: <20241008115707.088364255@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit dc171114926ec390ab90f46534545420ec03e458 ]

It is not particularly useful to release locks (the EC mutex and the
ACPI global lock, if present) and re-acquire them immediately thereafter
during EC address space accesses in acpi_ec_space_handler().

First, releasing them for a while before grabbing them again does not
really help anyone because there may not be enough time for another
thread to acquire them.

Second, if another thread successfully acquires them and carries out
a new EC write or read in the middle if an operation region access in
progress, it may confuse the EC firmware, especially after the burst
mode has been enabled.

Finally, manipulating the locks after writing or reading every single
byte of data is overhead that it is better to avoid.

Accordingly, modify the code to carry out EC address space accesses
entirely without releasing the locks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patch.msgid.link/12473338.O9o76ZdvQC@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 55 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 38d2f6e6b12b4..25399f6dde7e2 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -783,6 +783,9 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	unsigned long tmp;
 	int ret = 0;
 
+	if (t->rdata)
+		memset(t->rdata, 0, t->rlen);
+
 	/* start transaction */
 	spin_lock_irqsave(&ec->lock, tmp);
 	/* Enable GPE for command processing (IBF=0/OBF=1) */
@@ -819,8 +822,6 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 
 	if (!ec || (!t) || (t->wlen && !t->wdata) || (t->rlen && !t->rdata))
 		return -EINVAL;
-	if (t->rdata)
-		memset(t->rdata, 0, t->rlen);
 
 	mutex_lock(&ec->mutex);
 	if (ec->global_lock) {
@@ -847,7 +848,7 @@ static int acpi_ec_burst_enable(struct acpi_ec *ec)
 				.wdata = NULL, .rdata = &d,
 				.wlen = 0, .rlen = 1};
 
-	return acpi_ec_transaction(ec, &t);
+	return acpi_ec_transaction_unlocked(ec, &t);
 }
 
 static int acpi_ec_burst_disable(struct acpi_ec *ec)
@@ -857,7 +858,7 @@ static int acpi_ec_burst_disable(struct acpi_ec *ec)
 				.wlen = 0, .rlen = 0};
 
 	return (acpi_ec_read_status(ec) & ACPI_EC_FLAG_BURST) ?
-				acpi_ec_transaction(ec, &t) : 0;
+				acpi_ec_transaction_unlocked(ec, &t) : 0;
 }
 
 static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
@@ -873,6 +874,19 @@ static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
 	return result;
 }
 
+static int acpi_ec_read_unlocked(struct acpi_ec *ec, u8 address, u8 *data)
+{
+	int result;
+	u8 d;
+	struct transaction t = {.command = ACPI_EC_COMMAND_READ,
+				.wdata = &address, .rdata = &d,
+				.wlen = 1, .rlen = 1};
+
+	result = acpi_ec_transaction_unlocked(ec, &t);
+	*data = d;
+	return result;
+}
+
 static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 {
 	u8 wdata[2] = { address, data };
@@ -883,6 +897,16 @@ static int acpi_ec_write(struct acpi_ec *ec, u8 address, u8 data)
 	return acpi_ec_transaction(ec, &t);
 }
 
+static int acpi_ec_write_unlocked(struct acpi_ec *ec, u8 address, u8 data)
+{
+	u8 wdata[2] = { address, data };
+	struct transaction t = {.command = ACPI_EC_COMMAND_WRITE,
+				.wdata = wdata, .rdata = NULL,
+				.wlen = 2, .rlen = 0};
+
+	return acpi_ec_transaction_unlocked(ec, &t);
+}
+
 int ec_read(u8 addr, u8 *val)
 {
 	int err;
@@ -1323,6 +1347,7 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	struct acpi_ec *ec = handler_context;
 	int result = 0, i, bytes = bits / 8;
 	u8 *value = (u8 *)value64;
+	u32 glk;
 
 	if ((address > 0xFF) || !value || !handler_context)
 		return AE_BAD_PARAMETER;
@@ -1330,13 +1355,25 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (function != ACPI_READ && function != ACPI_WRITE)
 		return AE_BAD_PARAMETER;
 
+	mutex_lock(&ec->mutex);
+
+	if (ec->global_lock) {
+		acpi_status status;
+
+		status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &glk);
+		if (ACPI_FAILURE(status)) {
+			result = -ENODEV;
+			goto unlock;
+		}
+	}
+
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
 	for (i = 0; i < bytes; ++i, ++address, ++value) {
 		result = (function == ACPI_READ) ?
-			acpi_ec_read(ec, address, value) :
-			acpi_ec_write(ec, address, *value);
+			acpi_ec_read_unlocked(ec, address, value) :
+			acpi_ec_write_unlocked(ec, address, *value);
 		if (result < 0)
 			break;
 	}
@@ -1344,6 +1381,12 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
 
+	if (ec->global_lock)
+		acpi_release_global_lock(glk);
+
+unlock:
+	mutex_unlock(&ec->mutex);
+
 	switch (result) {
 	case -EINVAL:
 		return AE_BAD_PARAMETER;
-- 
2.43.0




