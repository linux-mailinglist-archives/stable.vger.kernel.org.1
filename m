Return-Path: <stable+bounces-154745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCDADFF24
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356FD3AC1B5
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 07:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC0225CC73;
	Thu, 19 Jun 2025 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KhZ5txEb"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71D248F5E;
	Thu, 19 Jun 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319478; cv=none; b=VwCHDt5g3UEj8GhaI9m9WG0OlDQ6G33bL2kPZjo/w2Ot4H6HKXmbl26TzotSleuG9rcu+YWj888soPEPIYC+L0GZX6pn/R3XlLjiUpVzj4HYakXDY9hRpc+lZ7wDhr12LZKG6gN+k6KXWUlw/inVnfFOcl0VmrlHbSWY3MC5t3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319478; c=relaxed/simple;
	bh=bHviAsuIfo6IGBrp4AOVqEtcYY9AbeOAmKOPuRF1lX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUP56yryHr+yFe8G9DCcojuumT8aJMTaYFW0mBgeJ0P6Fzp4mGhppBF4I3L6GaMjz/CV52RlUdrgzeZ3Bwi6VcJpIbVHXyKvjUfTWE+KkoN7wOVvX2OVZwEFLG88RQNIGWetv6EPXsDGjTNtpy9/akZZjAuU0+4Z2xxlEn5OqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KhZ5txEb; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1750319434;
	bh=KLFd8Hwc+BrcRkjztF5W0V4sgqqXjZ/dOj8l+EYvXyg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KhZ5txEbfemuKc9MIOVayZDf2OJzjO5+7gVLmzLg70Y8ayT5xAjfwdLinsN8hA/It
	 x3k08jauRitDjhpasq1Eiibw6EW+55NpTfjIngnMQqKXX0zVOvIwEJZ7xwypZHcJ6v
	 mt/EeaYiPTVooNmeGXGcvQtfo7YRzVvrTYM1ErAE=
X-QQ-mid: zesmtpip4t1750319413t17bb649b
X-QQ-Originating-IP: 9KKOypkCNDr4Fi7xRB09P3ZgHq9XVHrO7PfHQnwmCcw=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Jun 2025 15:50:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13789221876025690801
EX-QQ-RecipientCnt: 11
From: WangYuli <wangyuli@uniontech.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: ikepanhc@gmail.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Renato Caldas <renato@calgera.com>,
	Hans de Goede <hdegoede@redhat.com>,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH 6.1/6.6] platform/x86: ideapad-laptop: add missing Ideapad Pro 5 fn keys
Date: Thu, 19 Jun 2025 15:47:04 +0800
Message-ID: <F7FB9E816BFCD1DE+20250619074704.56965-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NzouuX5M12cOBvMscSOvIUovI2Hyf0KLYYKwn87zSATWV6tI+yqUYgkQ
	5hXFSrfGm3wrZ9hZGkdrjrsD6fo7Jwfbx3MBW9E//tKfJwdcyEs06fBuiHiIQ3btiAZpvV7
	pp6r4ASfJuDI5AxZVEO11BTd34wLN1NpKLCWFauR+SC6ryrVDSIqScQeG3iXcksEbbL8riH
	KLiOnm/U54lNlaDCFVwXkyUyTugXr6Sge9nTdj6/cstPN71k1lWzjnwTgOgo56lKHAHy4BF
	k3i3JCfOZHuN16dp8XCuxquhqAfp+sNSpoL82O4h74sFWl8Jm8kIMVAohzgua8XZ27l/086
	N25vrvTUy8Ax6WL0ssHdWsj4o6/rSadUyQPJkfQIlpSWnWNuf5Ycw+k2oaZj1woSxF47rVC
	0iK/38Od5/cwHpSE8aE//iDCw98qVli2zfto3vBI/UsHVTdwINK+RAvBueMMDEofLBjtONy
	pCDlo+h9S2nTATVjyAsk903cHG3LF/7mtQ4skTUZF2bhCSI5GmChdE81vDCo8cWjg+ERbAe
	kO6eMMSDuJc0lWdaPh5U+bGelsxoF0CuuAHjCcSPYNTu5h7YWZmDWQ8eGc0YIYI0ixYxYvJ
	Se3uhLOkde/FhicTqmZUrQV0ukeV0KFRvrGPpddid/Hxz91nkgiJ9KwLqWIx1JqFgyD6hVX
	Qkk9PuE0BhI60oOG7r/msy+EQlUnRwgPQ3nqJZX0oKWfKaifZQ/pKfF93H4NdxGjwG70C79
	TO9Hw6f7zEOPBYCrDWVA3jd+XcoWoaxoL3YZduEx2Bn0ZjgajqRkEwy3RCWfudXOorPA87b
	FzLgH2MuWn5tABUSY3YnyhUUMQ+PvO9xR5qSXzSkCWuYK9XOA7byZ20oParnD/Wl8TPS1EK
	WBH6Ks3QjTTUC/IZnMky5FwhCb1wK5pH7Dbiw1ixu91F++EINqG6uBLmedPOxxjHi0iXq6Z
	t6zDxYCgJHUO2Eb/jh6A8n3zmcU6QObeCri6G/AqWljnXXdm4LIM2BxsHwwR6p82YO5IkG6
	QFZmNyDP57qYI7sl19k5qX4t5mPoE=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

From: Renato Caldas <renato@calgera.com>

[ Upstream commit 36e66be874a7ea9d28fb9757629899a8449b8748 ]

The scancodes for the Mic Mute and Airplane keys on the Ideapad Pro 5
(14AHP9 at least, probably the other variants too) are different and
were not being picked up by the driver. This adds them to the keymap.

Apart from what is already supported, the remaining fn keys are
unfortunately producing windows-specific key-combos.

Signed-off-by: Renato Caldas <renato@calgera.com>
Link: https://lore.kernel.org/r/20241102183116.30142-1-renato@calgera.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/platform/x86/ideapad-laptop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 88eefccb6ed2..50013af0537c 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1101,6 +1101,9 @@ static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY,	0x27 | IDEAPAD_WMI_KEY, { KEY_HELP } },
 	/* Refresh Rate Toggle */
 	{ KE_KEY,	0x0a | IDEAPAD_WMI_KEY, { KEY_DISPLAYTOGGLE } },
+	/* Specific to some newer models */
+	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
+	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
 
 	{ KE_END },
 };
-- 
2.50.0


