Return-Path: <stable+bounces-171433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 087DDB2A9B4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FBE1BA48D4
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0649C31E119;
	Mon, 18 Aug 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NwuIcQjt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82FD350843;
	Mon, 18 Aug 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525906; cv=none; b=EnKCawo0AkNrJxAsj/sImmWnmmyO+MhTE3AGzNa2zL+EoAZ2JsB3nuxf4P38RRyenecQBTijfjqIgfau9rnJygpwGPRgL3NvPKmVmG1SbzTZKFW9brB7C80KgSnra2l2VD8xFqIp6Z1Xd6GL2xMpzWbbrDIFwVPtdbpOT2n307M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525906; c=relaxed/simple;
	bh=OHo9sEgq0ib1q0DG1Nn5saWg06xWRdqaQm96YOYKNUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7rLRWFzMY57cV9NRLjbxTbr0pZ73zkfTi2iG23026Js/TLXvwPxveX4DyYrESSRpzzWtfLCPIekT0N2FwEh/5fJu0krRCGMsddW7tm3i12BlMNwfzG+NEiItRcKZVAPF9ai8j7Qg4cNmlqSr2avnrwVaLJKClwTZWhJ4dusAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NwuIcQjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25118C4CEEB;
	Mon, 18 Aug 2025 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525906;
	bh=OHo9sEgq0ib1q0DG1Nn5saWg06xWRdqaQm96YOYKNUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwuIcQjtknxrmrM5b88W6znJ4z1nUwLx8Aavjlqs8YxDghfeo/9nKDjLELsfYeIj2
	 LML2B+HLPl2JWA4u/6n52g4rqJyCxpt7FKwOgc56UvJphVOGSDTnTWXAq85gHt6JTV
	 ZlbqAOgbVgDJz9t+qwXW6X1uGpLRBIaghtM9xF4g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Chen <chenl311@chinatelecom.cn>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 401/570] HID: rate-limit hid_warn to prevent log flooding
Date: Mon, 18 Aug 2025 14:46:28 +0200
Message-ID: <20250818124521.300479868@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Chen <chenl311@chinatelecom.cn>

[ Upstream commit 4051ead99888f101be92c7ce90d2de09aac6fd1c ]

Syzkaller can create many uhid devices that trigger
repeated warnings like:

  "hid-generic xxxx: unknown main item tag 0x0"

These messages can flood the system log, especially if a crash occurs
(e.g., with a slow UART console, leading to soft lockups). To mitigate
this, convert `hid_warn()` to use `dev_warn_ratelimited()`.

This helps reduce log noise and improves system stability under fuzzing
or faulty device scenarios.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c | 4 ++--
 include/linux/hid.h    | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b9748366c6d6..4fd3fff4661c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -663,9 +663,9 @@ static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
 	default:
 		if (item->tag >= HID_MAIN_ITEM_TAG_RESERVED_MIN &&
 			item->tag <= HID_MAIN_ITEM_TAG_RESERVED_MAX)
-			hid_warn(parser->device, "reserved main item tag 0x%x\n", item->tag);
+			hid_warn_ratelimited(parser->device, "reserved main item tag 0x%x\n", item->tag);
 		else
-			hid_warn(parser->device, "unknown main item tag 0x%x\n", item->tag);
+			hid_warn_ratelimited(parser->device, "unknown main item tag 0x%x\n", item->tag);
 		ret = 0;
 	}
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 568a9d8c749b..7f260e0e2049 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1239,6 +1239,8 @@ void hid_quirks_exit(__u16 bus);
 	dev_notice(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_warn(hid, fmt, ...)				\
 	dev_warn(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn_ratelimited(hid, fmt, ...)				\
+	dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_info(hid, fmt, ...)				\
 	dev_info(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_dbg(hid, fmt, ...)				\
-- 
2.39.5




