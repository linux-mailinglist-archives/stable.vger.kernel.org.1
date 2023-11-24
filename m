Return-Path: <stable+bounces-471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9887F7B38
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8104EB20EE0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F42AF00;
	Fri, 24 Nov 2023 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+KmluZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F82D787;
	Fri, 24 Nov 2023 18:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5036C433C9;
	Fri, 24 Nov 2023 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700848979;
	bh=6UhsmQXdPZiHGmOxwdWqWoZrrILameD6ptxu+YkThg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+KmluZs6Y28HWTadDGiJm7lStp8SpHrssJ72XkySca1zwMGrwcIGiudXkhGQH8qw
	 h+gRTnBJBUQqwP/lJa9dY7fsRh7q96K7iOT+n0YW81m5+DlLlDGNaKc5fmdFzCDETn
	 729c4IxQvp1c+MeoGy+LOOOzycUpipe2C8X/X7ts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Ferner <joe.m.ferner@gmail.com>,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 4.14 50/57] media: sharp: fix sharp encoding
Date: Fri, 24 Nov 2023 17:51:14 +0000
Message-ID: <20231124171932.159789782@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171930.281665051@linuxfoundation.org>
References: <20231124171930.281665051@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Young <sean@mess.org>

commit 4f7efc71891462ab7606da7039f480d7c1584a13 upstream.

The Sharp protocol[1] encoding has incorrect timings for bit space.

[1] https://www.sbprojects.net/knowledge/ir/sharp.php

Fixes: d35afc5fe097 ("[media] rc: ir-sharp-decoder: Add encode capability")
Cc: stable@vger.kernel.org
Reported-by: Joe Ferner <joe.m.ferner@gmail.com>
Closes: https://sourceforge.net/p/lirc/mailman/message/38604507/
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/ir-sharp-decoder.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/media/rc/ir-sharp-decoder.c
+++ b/drivers/media/rc/ir-sharp-decoder.c
@@ -23,7 +23,9 @@
 #define SHARP_UNIT		40000  /* ns */
 #define SHARP_BIT_PULSE		(8    * SHARP_UNIT) /* 320us */
 #define SHARP_BIT_0_PERIOD	(25   * SHARP_UNIT) /* 1ms (680us space) */
-#define SHARP_BIT_1_PERIOD	(50   * SHARP_UNIT) /* 2ms (1680ms space) */
+#define SHARP_BIT_1_PERIOD	(50   * SHARP_UNIT) /* 2ms (1680us space) */
+#define SHARP_BIT_0_SPACE	(17   * SHARP_UNIT) /* 680us space */
+#define SHARP_BIT_1_SPACE	(42   * SHARP_UNIT) /* 1680us space */
 #define SHARP_ECHO_SPACE	(1000 * SHARP_UNIT) /* 40 ms */
 #define SHARP_TRAILER_SPACE	(125  * SHARP_UNIT) /* 5 ms (even longer) */
 
@@ -177,8 +179,8 @@ static const struct ir_raw_timings_pd ir
 	.header_pulse  = 0,
 	.header_space  = 0,
 	.bit_pulse     = SHARP_BIT_PULSE,
-	.bit_space[0]  = SHARP_BIT_0_PERIOD,
-	.bit_space[1]  = SHARP_BIT_1_PERIOD,
+	.bit_space[0]  = SHARP_BIT_0_SPACE,
+	.bit_space[1]  = SHARP_BIT_1_SPACE,
 	.trailer_pulse = SHARP_BIT_PULSE,
 	.trailer_space = SHARP_ECHO_SPACE,
 	.msb_first     = 1,



