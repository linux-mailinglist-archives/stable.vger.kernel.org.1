Return-Path: <stable+bounces-161299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB50AFD4A8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BA718898B1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B952E613C;
	Tue,  8 Jul 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KKvNiViK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABD2E5B12;
	Tue,  8 Jul 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994174; cv=none; b=tcRAHMyZJoRnLBm8QRh6WzTThAZkiXiwRymZVIs49kuwUKWH6C5Yir103/fLZ0swjReG9YSuwHvO7DG2CVNnuyM/GFMFFY8QGhl3rNQfhA4jeY1NfxK9VEbIEm8PxRbnyqAOrCUg0tccX0opelT8T64mB4l8Q+VpTUsLt6w24oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994174; c=relaxed/simple;
	bh=eGByNdQ2Xhtz3j74BeOuOzH001/UG66KXMWVtgB6R50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW7qX3/1XDaagxiJufnWlc1p5uJMVhU30i3Uh1biCFkB5E5B+eo78BbYXA6VE/81ZnhQFAHjZRrfZ3fyA4gSt6RFLkEigCRM6YUhwgHs7Fi1NgaLqtYdJa5TDSqHtazE4vd4E+7FklhOUMPsu1qRhkp2WIMDSAM4ssr+IlyX+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KKvNiViK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E350DC4CEED;
	Tue,  8 Jul 2025 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751994174;
	bh=eGByNdQ2Xhtz3j74BeOuOzH001/UG66KXMWVtgB6R50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKvNiViK9chJNaQJAPCHTn0dcHRzdqpkJHv9sysrTVpsYUy+rxbQMBuYKvGbHOW53
	 9Cl6YlsC61xtBY29iXd6gVAjzUXMmF8qm3RuDyxcsUanfIaakc8NVRGkyMVE2gme1M
	 gyRsOi93dM3dlh6P54hFXGUeeUwaNh3iH2YV4iDM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Hongliang Yang <hongliang.yang@cixtech.com>,
	Fugang Duan <fugang.duan@cixtech.com>,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH 5.15 151/160] usb: cdnsp: do not disable slot for disabled slot
Date: Tue,  8 Jul 2025 18:23:08 +0200
Message-ID: <20250708162235.500529094@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chen <peter.chen@cixtech.com>

commit 7e2c421ef88e9da9c39e01496b7f5b0b354b42bc upstream.

It doesn't need to do it, and the related command event returns
'Slot Not Enabled Error' status.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable <stable@kernel.org>
Suggested-by: Hongliang Yang <hongliang.yang@cixtech.com>
Reviewed-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
Link: https://lore.kernel.org/r/20250619013413.35817-1-peter.chen@cixtech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-ring.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -772,7 +772,9 @@ static int cdnsp_update_port_id(struct c
 	}
 
 	if (port_id != old_port) {
-		cdnsp_disable_slot(pdev);
+		if (pdev->slot_id)
+			cdnsp_disable_slot(pdev);
+
 		pdev->active_port = port;
 		cdnsp_enable_slot(pdev);
 	}



