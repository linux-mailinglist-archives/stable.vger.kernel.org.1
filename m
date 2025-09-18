Return-Path: <stable+bounces-175668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BEDB36995
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BB3568238
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA803568E4;
	Tue, 26 Aug 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWWb6R91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942734F490;
	Tue, 26 Aug 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217653; cv=none; b=LbTWv2a0ly9GM3Yxa+IAZbzH8wQbMqI/gxKKrr85B6iQi/SakeACtjJQGfwYV6vKZ9kw4HY8YDMprGZLbafUypCWYT6lGMYPLVVAoSY+5npXJIl7vj+d7U7v384bKbTKPrvkoa5qrEJS9I5mTJW+iwCHegz+mCZW0SvijM863jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217653; c=relaxed/simple;
	bh=muxJVE1aPru3lWv471NDnoApyLVT1RrJ63fSzeeDK+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+Lne2x0DjEbHM2F4udKuo/6lDS0qAY6a3yc2mln/Y23Pv329geKIR54LbIvhg3E5XQJLKXF8TICmQR5TmpQ6J5t31fS1tcNt39JWP3NtszbRSkM8rVb1tOE2w5l0vMTEW8rmYc+TIGlWortoUMu2jXh0K51UOfCpiCfl4p7sGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWWb6R91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A08EC4CEF1;
	Tue, 26 Aug 2025 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217653;
	bh=muxJVE1aPru3lWv471NDnoApyLVT1RrJ63fSzeeDK+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWWb6R91BLi6W9K6Xucxzc9LnxJwNtruRVWk9MFocI0OCU+PmgQDxb6j4N/PI44QW
	 k3QsVBtxIzQZHq9XPpA4N8RxxwSKdT9jVcTG7FfoIkSJ4rf5OCbJmEn4JEXTWdrzZv
	 vyc36qgiYwXApspfVTo/+jPyt8106oHC/W+Lh4Fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 224/523] usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default
Date: Tue, 26 Aug 2025 13:07:14 +0200
Message-ID: <20250826110929.986952138@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benson Leung <bleung@chromium.org>

[ Upstream commit af833e7f7db3cf4c82f063668e1b52297a30ec18 ]

ucsi_psy_get_current_max would return 0mA as the maximum current if
UCSI detected a BC or a Default USB Power sporce.

The comment in this function is true that we can't tell the difference
between DCP/CDP or SDP chargers, but we can guarantee that at least 1-unit
of USB 1.1/2.0 power is available, which is 100mA, which is a better
fallback value than 0, which causes some userspaces, including the ChromeOS
power manager, to regard this as a power source that is not providing
any power.

In reality, 100mA is guaranteed from all sources in these classes.

Signed-off-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Jameson Thies <jthies@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20250717200805.3710473-1-bleung@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/psy.c  | 2 +-
 drivers/usb/typec/ucsi/ucsi.h | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 571a51e16234..ba5f797156dc 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -142,7 +142,7 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 	case UCSI_CONSTAT_PWR_OPMODE_DEFAULT:
 	/* UCSI can't tell b/w DCP/CDP or USB2/3x1/3x2 SDP chargers */
 	default:
-		val->intval = 0;
+		val->intval = UCSI_TYPEC_DEFAULT_CURRENT * 1000;
 		break;
 	}
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index f75b1e2c05fe..ed8fcd7ecf21 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -305,9 +305,10 @@ struct ucsi {
 #define UCSI_MAX_SVID		5
 #define UCSI_MAX_ALTMODES	(UCSI_MAX_SVID * 6)
 
-#define UCSI_TYPEC_VSAFE5V	5000
-#define UCSI_TYPEC_1_5_CURRENT	1500
-#define UCSI_TYPEC_3_0_CURRENT	3000
+#define UCSI_TYPEC_VSAFE5V		5000
+#define UCSI_TYPEC_DEFAULT_CURRENT	 100
+#define UCSI_TYPEC_1_5_CURRENT		1500
+#define UCSI_TYPEC_3_0_CURRENT		3000
 
 struct ucsi_connector {
 	int num;
-- 
2.39.5




