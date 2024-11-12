Return-Path: <stable+bounces-92642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3369C5820
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DC2B34E4F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F6121765D;
	Tue, 12 Nov 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nib+dnYX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA220E31D;
	Tue, 12 Nov 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408113; cv=none; b=TzcZ/eFPzyorn89vTezDoSIu2JjKlUTNw0vhvE+SF4VQk1sr9xtx8lWflGf/rGI9sVBDI59SdnU+LDTIiocU87WacRxfzVJzC/alpIcL16xmeTwzEKU68orP+ZPzPNeLnoIDNsapg3mhiK14Kf38/e4iA9YsPgBkATh1FzCCPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408113; c=relaxed/simple;
	bh=LH2YYkfyEbi7DF3UOSoqzdHGhScENDCVZRVMPjxkmDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZIaERM517C17a4F0oWjhBMX16s9YF0RK2aCKah0PZyvO2fTcb4bWaun+kHV0TgqyiXoBsT1ROPm9LnflaIQOJvyQ3//XyVStPSB9863/jGgbZuv/Mrzujxx/5QEQRZOhwrh6rJorqhCjREhvpFtT9JFEQd1uJytWEiNZbxPQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nib+dnYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0296AC4CECD;
	Tue, 12 Nov 2024 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408113;
	bh=LH2YYkfyEbi7DF3UOSoqzdHGhScENDCVZRVMPjxkmDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nib+dnYXEjFsB8RXo6TvQODFSbhFlhNL2dAooci0ses/LoOrcED2lAfq7XvEN+0Uf
	 dWocZPodugTSjD/e6tUMqj4g2uh1nvq4vB/I0AJs8xEouhMZG0ViJ/3O8cpFdE4bdQ
	 9Gcm6kKwSlLO0D5GM7tPCG5gxi6juaLOFqtNM4I0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 032/184] HID: core: zero-initialize the report buffer
Date: Tue, 12 Nov 2024 11:19:50 +0100
Message-ID: <20241112101902.098990588@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.com>

[ Upstream commit 177f25d1292c7e16e1199b39c85480f7f8815552 ]

Since the report buffer is used by all kinds of drivers in various ways, let's
zero-initialize it during allocation to make sure that it can't be ever used
to leak kernel memory via specially-crafted report.

Fixes: 27ce405039bf ("HID: fix data access in implement()")
Reported-by: Benoît Sevens <bsevens@google.com>
Acked-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 988d0acbdf04d..3fcf098f4f569 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1875,7 +1875,7 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 
 	u32 len = hid_report_len(report) + 7;
 
-	return kmalloc(len, flags);
+	return kzalloc(len, flags);
 }
 EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
 
-- 
2.43.0




