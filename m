Return-Path: <stable+bounces-4229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93080469C
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78852281171
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3B8BEC;
	Tue,  5 Dec 2023 03:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iTMdQGHa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B46FAF;
	Tue,  5 Dec 2023 03:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009A9C433C9;
	Tue,  5 Dec 2023 03:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746978;
	bh=gG2BdIuva8n2oPni+k4KoQZhJ0ORCcqmL+IXTmsQ/oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTMdQGHaReBco602Yueh8jGELzLU6vGcTO0xrLZIySYy6KpnVznWRvYmfHqCJL3wW
	 cf+1O5B+302zMFzYcBu0BeAcZVlG3kko4hEV/JSRKewglCYiPSKB6uMKHqtGawMyQD
	 u0Lsfxfwf9BWYdm0a+GlBfB0KUbBscC69g708dxw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.1 007/107] mmc: cqhci: Increase recovery halt timeout
Date: Tue,  5 Dec 2023 12:15:42 +0900
Message-ID: <20231205031531.979334810@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
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

From: Adrian Hunter <adrian.hunter@intel.com>

commit b578d5d18e929aa7c007a98cce32657145dde219 upstream.

Failing to halt complicates the recovery. Additionally, unless the card or
controller are stuck, which is expected to be very rare, then the halt
should succeed, so it is better to wait. Set a large timeout.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Link: https://lore.kernel.org/r/20231103084720.6886-3-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/cqhci-core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -984,10 +984,10 @@ static bool cqhci_halt(struct mmc_host *
 /*
  * After halting we expect to be able to use the command line. We interpret the
  * failure to halt to mean the data lines might still be in use (and the upper
- * layers will need to send a STOP command), so we set the timeout based on a
- * generous command timeout.
+ * layers will need to send a STOP command), however failing to halt complicates
+ * the recovery, so set a timeout that would reasonably allow I/O to complete.
  */
-#define CQHCI_START_HALT_TIMEOUT	5
+#define CQHCI_START_HALT_TIMEOUT	500
 
 static void cqhci_recovery_start(struct mmc_host *mmc)
 {



