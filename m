Return-Path: <stable+bounces-138039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7FAA164C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9D218843E7
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC94238C21;
	Tue, 29 Apr 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WxRaFM68"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E987E110;
	Tue, 29 Apr 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947921; cv=none; b=oR2wbFjmM9jpVRby7EQn+i91zxHWHzzP7eTQb0DyNCfYcvXewnSP+qaClqYAkpo+KnDq1jXtWHCCHd/e2bl0BdDAkkFqcCG5f6yyxsMr4tdbFSa30R+SqxiqFz6QkDHpfW4hbYFbGkvYZakUcGN0QUVmGrZAW+T04k4MC3ymb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947921; c=relaxed/simple;
	bh=cH8vP567O8DyDXEP2qOsDb9/QzYvlnXQQ9F0ZNyyiNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9kUX/TSZ8lhbnRXbUuxjG3yxg9/j8djEd3Zarz6liWTC/OJpaHsjIlPEk19ha2DkztgwnjwU6N1TLr7vtXq2NLj2845HYu3uzQS3r7ko8HP4TtTiTHjNbXwIIYktgPiSM5yu4OH6GX8fU8nXO6A72h0QDEvDoBQ5zikspeeuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WxRaFM68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C500C4CEE3;
	Tue, 29 Apr 2025 17:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947920;
	bh=cH8vP567O8DyDXEP2qOsDb9/QzYvlnXQQ9F0ZNyyiNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxRaFM68b29a+wJoICChS5AmginZyWWeJJGasQg3jPz+KRik1m92zoqIn++dwWWN8
	 joGkp69sxRIYSMb2QZOI+JSXyDosm1BIBDWzX0dU53aaRgAl5NujuUBHesEp77NKYR
	 45vmEIbMB6vSJ2Em9EH510Cr9O+AYV2LhUVJLE9I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miao Li <limiao@kylinos.cn>,
	stable <stable@kernel.org>
Subject: [PATCH 6.12 145/280] usb: quirks: add DELAY_INIT quirk for Silicon Motion Flash Drive
Date: Tue, 29 Apr 2025 18:41:26 +0200
Message-ID: <20250429161121.059919320@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

From: Miao Li <limiao@kylinos.cn>

commit 2932b6b547ec36ad2ed60fbf2117c0e46bb7d40a upstream.

Silicon Motion Flash Drive connects to Huawei hisi platforms and
performs a system reboot test for two thousand circles, it will
randomly work incorrectly on boot, set DELAY_INIT quirk can workaround
this issue.

Signed-off-by: Miao Li <limiao@kylinos.cn>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20250401023027.44894-1-limiao870622@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -383,6 +383,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x0904, 0x6103), .driver_info =
 			USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL },
 
+	/* Silicon Motion Flash Drive */
+	{ USB_DEVICE(0x090c, 0x1000), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =
 			USB_QUIRK_ENDPOINT_IGNORE },



