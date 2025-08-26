Return-Path: <stable+bounces-173639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CA1B35DA4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829797A1EDC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2D267386;
	Tue, 26 Aug 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZwHfaUGl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301218DF9D;
	Tue, 26 Aug 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208770; cv=none; b=XeMzBlFS7LGOkzrntYH9WKBwCxp9xUQ3IP/surarYObx1bbcQ4/6iZVjCg4oU8n43V2BFJlRb0xbltzPCcpFrIfitnsG95pgFpVwrHH/gS89oQqgVapZIMybQRYAQOhHBIOEpn+Sv+XrC83zGwngGt+yGdONgycsZn38ArmgoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208770; c=relaxed/simple;
	bh=EtZRtzjEZlOZT9hgROLcwL3EQ8RiXTqQt4PzfcquxeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnqMsjuaIti9HjI6lyXaKMHab48RsWkkhLziSugBgVxMlHkDGtVq2yVN0CifrA40krseLRDlOSx9R1dkdIo9jxj0gx51aEtqZmJWLJHJ9KhDClzOtvM961jzUKLTRiObCvgwxlIPNnQw/64YfAYORmcKv8p58LWuj6SMwwlb1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZwHfaUGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0A1C4CEF1;
	Tue, 26 Aug 2025 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208770;
	bh=EtZRtzjEZlOZT9hgROLcwL3EQ8RiXTqQt4PzfcquxeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwHfaUGl4UcUBwoN81ZIypxpaKh2Ys4vPq9syhhwjf9jTEON8EH9cqdwV3j+npu3s
	 eS3QcYDxzTIJwTDSjH0inYaVdyPUQa0bxa7TfUy6Bt2G4y0q+GgjVL++b8SQX6hBrG
	 SlkUT8RxuCjJXyoVMO++kH2EVmqbWaFBvjtxjB3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 237/322] iio: light: as73211: Ensure buffer holes are zeroed
Date: Tue, 26 Aug 2025 13:10:52 +0200
Message-ID: <20250826110921.757893875@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 433b99e922943efdfd62b9a8e3ad1604838181f2 ]

Given that the buffer is copied to a kfifo that ultimately user space
can read, ensure we zero it.

Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250802164436.515988-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/as73211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -643,7 +643,7 @@ static irqreturn_t as73211_trigger_handl
 	struct {
 		__le16 chan[4];
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);



