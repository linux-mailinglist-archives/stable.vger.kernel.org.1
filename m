Return-Path: <stable+bounces-177245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3FFB40460
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFCA7BC49C
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD982D8DC0;
	Tue,  2 Sep 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dm/6i9f8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0F314B96;
	Tue,  2 Sep 2025 13:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820040; cv=none; b=UgSBVKmlbtRV+wRs4fVdwO0D2ErUvQRUWpl5DTbmgTIbnlormrzZCGLomq7hhlE9edNSy3FioRSAJgQWtmphkNEUTFPRn9Z1s6IYqnY8mnSF7HIpKZl+oyN8ZlaZNvsN0UgTtSOOtrp+6WDV5KZEm8OFQQcjeELLPDRJiLe2sJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820040; c=relaxed/simple;
	bh=LN182FArJIon6/vyqVUFjO66K7CdihhQWjwV+4A521Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccLbbDMIjRR5zu27QnPoOqXLA5HoW9fYQlxwsvox/SL7RCFG0fY3ueRiV3vjCo2QsOBgLYbOZleGm+6PdyEbzH6EeJ4Wb9XwGRvO0NdwCFbyEMwPVNuwUg6MRKB5x/kCUIPWdVYG1b58Em8VwigVSVvbkYOhO8MNrFr5aP1C2Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dm/6i9f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACA7C4CEED;
	Tue,  2 Sep 2025 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756820040;
	bh=LN182FArJIon6/vyqVUFjO66K7CdihhQWjwV+4A521Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dm/6i9f8epSbxG4KPZgCnyy2HD0D15TULkljySdmmpWt8lwEZu+CkACqwB/j3IR/V
	 XEDNrlrQRxvuYzqHjIIALIoIavkGdn31fXQMc0ArSi4WYaywjt/zxAPRo5gqV9HPO5
	 tIh8v802xtGUSy9FaZ3GR2vhLOZ00iAIHkn02lYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping Cheng <ping.cheng@wacom.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.12 75/95] HID: wacom: Add a new Art Pen 2
Date: Tue,  2 Sep 2025 15:20:51 +0200
Message-ID: <20250902131942.488419034@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
References: <20250902131939.601201881@linuxfoundation.org>
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

From: Ping Cheng <pinglinux@gmail.com>

commit 9fc51941d9e7793da969b2c66e6f8213c5b1237f upstream.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_wac.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -684,6 +684,7 @@ static bool wacom_is_art_pen(int tool_id
 	case 0x885:	/* Intuos3 Marker Pen */
 	case 0x804:	/* Intuos4/5 13HD/24HD Marker Pen */
 	case 0x10804:	/* Intuos4/5 13HD/24HD Art Pen */
+	case 0x204:     /* Art Pen 2 */
 		is_art_pen = true;
 		break;
 	}



