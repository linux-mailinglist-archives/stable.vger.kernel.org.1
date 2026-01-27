Return-Path: <stable+bounces-211900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEcGNXU9eWkmwAEAu9opvQ
	(envelope-from <stable+bounces-211900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 23:34:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A02289B1B1
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 23:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 544ED300729F
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59395283FDF;
	Tue, 27 Jan 2026 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="H/UI+WBj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLx0Fc1s"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71E139579;
	Tue, 27 Jan 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553261; cv=none; b=Wcc39R5lKOOXXbD+HrCORWiyg66bFgLLCTXtXVnHvPofJV4oqP1xm0jNAhUJNNALe2RuAQr87Xf5rzNK5ff6pVncQEpbYSyDP7yJbE2WMSd+h3ZJbx4tCdJoD4EHvgxRZ2/CDTTkeiiefOQeTvj22OIXKERfadGCqGchOM5M7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553261; c=relaxed/simple;
	bh=H8H6FtEovmDTj3VEtMuO2YPLy0LbX/TUyKYkc+sm5iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blqgT5THRdU42Z/RuYcH2qgYMzqch918ia54gGl49NuoGAnopPAOLqD6paPLSFwMazwiCOPWfmM6StEeSCHavceO6anVHaM2ZUsTjfnhdLPhHQY2PVVm6IuDxFuezpxJmnYrx8G5J8+zfXk2+xxVSekCCELLW4/AwBFnP/dqITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=H/UI+WBj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLx0Fc1s; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 50B181D00113;
	Tue, 27 Jan 2026 17:34:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 27 Jan 2026 17:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1769553258; x=1769639658; bh=ZLdnLf5vx9
	xJmO7CqVhMxoDPL4AY1OQZUyB28WIUVJo=; b=H/UI+WBjdItgV5ZiuckV7xgect
	keUWXSfHbwRnRoygu1mgLOnKMz2HadCL2zRNfU0MJbKvBZNNqO2saaytLUzCs4US
	cS9XysTnKTHQ30pGl+BhwN/TJIw6RZwqp/d2qOyOzp4+2XHglNLrTmyBpPF2rqJC
	1e5IEJEbTw8ljOhaCGpJaH5Hx/j5mqsglJUTvPX1++1+P6tP7Rpni+zR2RFyD/Ee
	mxk2wovZqvrXl5HioALQ/fPs7+C/VmDpt+Y5lAHnxeGdS8RVmXlZm3oxd5QVNgUP
	jNavHy8GPlgVChUlxz0KwW1UwISev3e3XQAqY/MA2NaObZzEYo/uMOrc2d+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769553258; x=1769639658; bh=ZLdnLf5vx9xJmO7CqVhMxoDPL4AY1OQZUyB
	28WIUVJo=; b=mLx0Fc1shEw4nVIDALO1ARM+g9zH435GYcKJ8LHSriHPknuP1Fq
	UzcpQL4U8LyqhBSgNht50TQyuSD+esUw7wvKD57GVOUlTWpHFfTVnpuGZmNxa9K2
	RATUYH4Og6SGtrFpVpGWzK+CmFH1VQMu+glacDw5oZnSWa512VbltCN68Xykf6P4
	BhETU/b+aN9LuFlLJS9d2MWKKfcMv9pLNP4rGt7KvklH9YmTRgLgR8A4P/LCmGy2
	BboyMMrxYmDpQsiWio8Lob4TcH8xr3bLBLu29tWUeT4awRDYYR+6tAQXpoOY9wmW
	15C71hNmT7eT5J9qy3mCzXoh/kRODHGGmzg==
X-ME-Sender: <xms:aT15aXrSFHbwqDBYk4_oyPoLCV4x3-JEbLHd8C0OL2ja1XzAyJohDw>
    <xme:aT15adGHBR9ehPo-M7zGOSFFxfKFWtD7cPIWESzODj4T7YA2mNIVe-oTPxsS3dAEK
    sgN0T88KYYA5fWfnyxvZjZD05_wIQRXqQ2kTFW2tO7GuEHYpxq6cQ8>
X-ME-Received: <xmr:aT15aXut9yew4b6aBGLktr6sFJGUryDVjw_d8N_kIhpPmlQ_EwTT5YUb5dm0SNwPx2y5RqbXDs_qoOMI_1UHJfGnsxIpS_14faup-Q01VIMn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfgrkhgrshhhihcu
    ufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqne
    cuggftrfgrthhtvghrnhepkeevteefgeduheffudfgtedvuedvjeeviedvfeelgedvtdeh
    tedvjefggedvtdeunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehs
    rghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhu
    rhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvggrshhpheeisehouhhtlhhoohhkrd
    gtohhm
X-ME-Proxy: <xmx:aj15afVF4jyqRelSNxafwXSLreXGQDE-HgLSi83VIVSNXajXhBbdMw>
    <xmx:aj15aTF6IM4oxxkSn-isGeJdoIJqOfSecsHIigubjoVPf6fkXi_smQ>
    <xmx:aj15aR03aZohNJ-9NUVH0LjK-Gmzv2_XMPr0h7A8sJmE0SlOjSXBqQ>
    <xmx:aj15aVNCInBK_RoKLsQ_RycTPqPkGWJpFv4e-QgtSyv7fyZkGgx2ug>
    <xmx:aj15aRmR8MiKGBB0TNzq0Rx5dZm7j1KwD_x0A22H7-bvruY0Mve4SNUo>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 17:34:16 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Andreas Persson <andreasp56@outlook.com>
Subject: [PATCH] firewire: core: fix race condition against transaction list
Date: Wed, 28 Jan 2026 07:34:13 +0900
Message-ID: <20260127223413.22265-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sakamocchi.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sakamocchi.jp:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211900-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sakamocchi.jp:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o-takashi@sakamocchi.jp,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A02289B1B1
X-Rspamd-Action: no action

The list of transaction is enumerated without acquiring card lock when
processing AR response event. This causes a race condition bug when
processing AT request completion event concurrently.

This commit fixes the bug by put timer start for split transaction
expiration into the scope of lock. The value of jiffies in card structure
is referred before acquiring the lock.

Cc: stable@vger.kernel.org # v6.18
Fixes: b5725cfa4120 ("firewire: core: use spin lock specific to timer for split transaction")
Reported-by: Andreas Persson <andreasp56@outlook.com>
Closes: https://github.com/alsa-project/snd-firewire-ctl-services/issues/209
Tested-by: Andreas Persson <andreasp56@outlook.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 7fea11a5e359..22ae387ae03c 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -173,20 +173,14 @@ static void split_transaction_timeout_callback(struct timer_list *timer)
 	}
 }
 
-static void start_split_transaction_timeout(struct fw_transaction *t,
-					    struct fw_card *card)
+// card->transactions.lock should be acquired in advance for the linked list.
+static void start_split_transaction_timeout(struct fw_transaction *t, unsigned int delta)
 {
-	unsigned long delta;
-
 	if (list_empty(&t->link) || WARN_ON(t->is_split_transaction))
 		return;
 
 	t->is_split_transaction = true;
 
-	// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
-	// local destination never runs in any type of IRQ context.
-	scoped_guard(spinlock_irqsave, &card->split_timeout.lock)
-		delta = card->split_timeout.jiffies;
 	mod_timer(&t->split_timeout_timer, jiffies + delta);
 }
 
@@ -207,13 +201,20 @@ static void transmit_complete_callback(struct fw_packet *packet,
 		break;
 	case ACK_PENDING:
 	{
+		unsigned int delta;
+
 		// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
 		// local destination never runs in any type of IRQ context.
 		scoped_guard(spinlock_irqsave, &card->split_timeout.lock) {
 			t->split_timeout_cycle =
 				compute_split_timeout_timestamp(card, packet->timestamp) & 0xffff;
+			delta = card->split_timeout.jiffies;
 		}
-		start_split_transaction_timeout(t, card);
+
+		// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
+		// local destination never runs in any type of IRQ context.
+		scoped_guard(spinlock_irqsave, &card->transactions.lock)
+			start_split_transaction_timeout(t, delta);
 		break;
 	}
 	case ACK_BUSY_X:

base-commit: 6b617317e5bc95e9962a712314ae0c4b7a4d5cc3
-- 
2.51.0


