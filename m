Return-Path: <stable+bounces-181397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3733FB93197
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34822A82E8
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C3A2E765E;
	Mon, 22 Sep 2025 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dVvLeITU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0618C2C;
	Mon, 22 Sep 2025 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570440; cv=none; b=T3miXO3AZOuQB4DbroAkQA4bKY3eIoeeg0j87J8Cfj3EpPYFsWryAOKpzwYObw59TITe/zueyolnhJBDQfu9vu7jMoGqOLxjj8x1qSU5F8CgesQY9VuVtA72L5ardc3TS/csz8N4O3cVLAZrpSCgt9p+RsFwXTCqxl+fijFkZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570440; c=relaxed/simple;
	bh=3kaPCucswmDEL7740QcRPllkEzIou3iXnT0Ixv9+Qp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbbCKPi69aGDOvSYTcnEXknMN2BPZex8AfeCyRIS+Kbtp+qYGfQVyCS3yjHx6wtv/uTDNbp4dQb/Kg38VKa2PgJk+rWAlHXZD+SMp1tNIVH7uQTjj800QR2bUhyl2cLVUkNAxv3V7FsnFdokHoaVb7P+k4ZPXTcBTtAx6D1+HdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dVvLeITU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F41DC4CEF0;
	Mon, 22 Sep 2025 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570439;
	bh=3kaPCucswmDEL7740QcRPllkEzIou3iXnT0Ixv9+Qp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVvLeITU4D44LuPLVSf/yUwaSfAk0KiSRgrCXS3gZpB06AVa02tzbm7jrlbqS0uZ4
	 whtLN+sC5aHocyRZaCV/FfttuS9Hpd8l61m1GdaMAqISXp0IpztW2uvc8ZxyoMG8TS
	 HIazZWfYhTBs2tl8zQIVzGPMsaoGNezO+vAJ+kmc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Chandra <rahul@chandra.net>,
	stable@kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.16 140/149] platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk
Date: Mon, 22 Sep 2025 21:30:40 +0200
Message-ID: <20250922192416.397528145@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antheas Kapenekakis <lkml@antheas.dev>

commit 225d1ee0f5ba3218d1814d36564fdb5f37b50474 upstream.

It turns out that the dual screen models use 0x5E for attaching and
detaching the keyboard instead of 0x5F. So, re-add the codes by
reverting commit cf3940ac737d ("platform/x86: asus-wmi: Remove extra
keys from ignore_key_wlan quirk"). For our future reference, add a
comment next to 0x5E indicating that it is used for that purpose.

Fixes: cf3940ac737d ("platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk")
Reported-by: Rahul Chandra <rahul@chandra.net>
Closes: https://lore.kernel.org/all/10020-68c90c80-d-4ac6c580@106290038/
Cc: stable@kernel.org
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20250916072818.196462-1-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-nb-wmi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -670,6 +670,8 @@ static void asus_nb_wmi_key_filter(struc
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
+	case 0x5D: /* Wireless console Toggle */
+	case 0x5E: /* Wireless console Enable / Keyboard Attach, Detach */
 	case 0x5F: /* Wireless console Disable / Special Key */
 		if (quirks->key_wlan_event)
 			*code = quirks->key_wlan_event;



