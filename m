Return-Path: <stable+bounces-60816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE393A58C
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474BC1F2319C
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5860158848;
	Tue, 23 Jul 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3lhGuiJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7713D521;
	Tue, 23 Jul 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759137; cv=none; b=pRcdG8qKulaWsOQi+E0gLgUq5oDbHYhzb5TKacjlK9qq1EVRBce2maziO8jV5WoTIU03FpHDGYhYApg+3Nf84JN5f9WEFBOi+GMui0a1x7eE29GluGJxMaWpBPAEMRTN9T315O8TuVbWOL6OwmjFsBbv4z5YXfTlu2/WVrdJEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759137; c=relaxed/simple;
	bh=KBvBQeHL5gZ40isuX/YoXYfPfLbIb+3aQ5bk5YnUTbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6G6nwNs22Ugo290l5GgSBtmCJQLYxeahCK2UQ+p/HZNmlnCed0PhG12kQq0tvD2+0mJahGvU0o2/t9Ct9wU/FJH1cox2k3O3PAtV/9i2kbAvmjXOrCg0a1eLT5JbSht4PjEpmFsSTwmH47cveSdpBDLCLLGfdqTXw+gU4U+WCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3lhGuiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D10C4AF0A;
	Tue, 23 Jul 2024 18:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759137;
	bh=KBvBQeHL5gZ40isuX/YoXYfPfLbIb+3aQ5bk5YnUTbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3lhGuiJXdNSz9cHKi4JPGj2EoU6LAYlYgbbVatryYkaipg/rhkxBOzbDblZgBzTe
	 guqHOmEv8bI4TKmuigHLrCXzchXPbivOI3PjYEflhIPBq/YJ/f/1K5gjh/tq9fFUSA
	 VvP4JUC7ktdj0xulcRKUif3xPuqY/xYlhStV2X7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/105] ACPI: EC: Abort address space access upon error
Date: Tue, 23 Jul 2024 20:22:52 +0200
Message-ID: <20240723180403.416523901@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180402.490567226@linuxfoundation.org>
References: <20240723180402.490567226@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit f6f172dc6a6d7775b2df6adfd1350700e9a847ec ]

When a multi-byte address space access is requested, acpi_ec_read()/
acpi_ec_write() is being called multiple times.

Abort such operations if a single call to acpi_ec_read() /
acpi_ec_write() fails, as the data read from / written to the EC
might be incomplete.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 77d1f2cb89ef3..fc3dc83bb8707 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1314,10 +1314,13 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_enable(ec);
 
-	for (i = 0; i < bytes; ++i, ++address, ++value)
+	for (i = 0; i < bytes; ++i, ++address, ++value) {
 		result = (function == ACPI_READ) ?
 			acpi_ec_read(ec, address, value) :
 			acpi_ec_write(ec, address, *value);
+		if (result < 0)
+			break;
+	}
 
 	if (ec->busy_polling || bits > 8)
 		acpi_ec_burst_disable(ec);
-- 
2.43.0




