Return-Path: <stable+bounces-42487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9676E8B7343
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376E01F2117C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6561D12CDA5;
	Tue, 30 Apr 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9X4zLmP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480F17592;
	Tue, 30 Apr 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475823; cv=none; b=SFRk00gapZDdNg7A+BfAArrBtPQDUu5c+PKSjWYcmHlql8TMpZDMvwU2LYiLl5y52lWrcowM9rzbEln+LdY57/ooFelGTztaR4PHwbDDlycY9+p+QufKtioJ9mxwB61VpB/b/l/2Qk31Vj5tzhKYO/MXbO6kpkNQaBIuH/qsfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475823; c=relaxed/simple;
	bh=KlVTx/jmPA2yyRIGjjCtIp3BzkvC2VNe7JqXXnjvQmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lruaOgw32kVKfcbK1nEGP+cJqpZxn2DFz8TcqFQuKTR+aMhKabvh8cx6uHpB66FYDEibAn5GDvPL7Zb62TwCKNZT3Dc9IoLsgW02cKgou20rXhcwS52g2dDg4IpAqthU3XRhpFpwiRILrvLAV6ofIStXah07wmCAj6QIAqIAJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9X4zLmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21EFC2BBFC;
	Tue, 30 Apr 2024 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475823;
	bh=KlVTx/jmPA2yyRIGjjCtIp3BzkvC2VNe7JqXXnjvQmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9X4zLmPXXvOzIcvR4VfmJViIx8SLq8YK+thxdM7HumncRs7fVDxQK+azfeTDM8cD
	 k+GQSolux947a5WJDZATKaifiXCKlK0d0lUwr0QqIfjyE94svRTYoAApa5CQtqIOSj
	 dPPA+cGVbuC2C7wVUh94Hjuy9SWPgwjrbTOeLJ6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yaraslau Furman <yaro330@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 04/80] HID: logitech-dj: allow mice to use all types of reports
Date: Tue, 30 Apr 2024 12:39:36 +0200
Message-ID: <20240430103043.531674743@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
References: <20240430103043.397234724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yaraslau Furman <yaro330@gmail.com>

[ Upstream commit 21f28a7eb78dea6c59be6b0a5e0b47bf3d25fcbb ]

You can bind whatever action you want to the mouse's reprogrammable
buttons using Windows application. Allow Linux to receive multimedia keycodes.

Fixes: 3ed224e273ac ("HID: logitech-dj: Fix 064d:c52f receiver support")
Signed-off-by: Yaraslau Furman <yaro330@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-dj.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 08768e5accedc..57697605b2e24 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -965,9 +965,7 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
 		}
 		break;
 	case REPORT_TYPE_MOUSE:
-		workitem->reports_supported |= STD_MOUSE | HIDPP;
-		if (djrcv_dev->type == recvr_type_mouse_only)
-			workitem->reports_supported |= MULTIMEDIA;
+		workitem->reports_supported |= STD_MOUSE | HIDPP | MULTIMEDIA;
 		break;
 	}
 }
-- 
2.43.0




