Return-Path: <stable+bounces-14398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38568380C5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12E41C28672
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8226F1339AB;
	Tue, 23 Jan 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jxQZVNA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1F133435;
	Tue, 23 Jan 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971889; cv=none; b=bjZKVjFh7+/LWk+xktavxhjHS4p/CUu4Ifmn0EEH7ABL0+8X6h8hYW5WGEX6Fq0ivUWvMPfpjJyGEJ/Eo6Uopm7XcMFX250P76KBCS/mLctLZNgdZQq7x6RFLsVvWbaVCF9vlE20UNiGc+RRPfNfb0gChMFfH46SvY+S8o/RzPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971889; c=relaxed/simple;
	bh=QoKFIZGHRxDjF7GCB8aYGM8O2gSj6VVNN7CwEqrLA+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOMITGKQFdM54BFtgDFqSHzBwKYXOZfBVMHdmFhi5UEvIJQoAil27AQM+0Nji/JD+MIIvV6Qzgd/lMaFV5e5Mz3TAcmUVV8Sf5C+VqXkvW9b643OCp6TTChHr4OiWwyV/qOMT6RJFspsriaos5ldGLLDoVMR94GlpaNXNy/LrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jxQZVNA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F130DC433F1;
	Tue, 23 Jan 2024 01:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971889;
	bh=QoKFIZGHRxDjF7GCB8aYGM8O2gSj6VVNN7CwEqrLA+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxQZVNA+lk78kL7BlIM2fI5faOHbMv6N3Rx/Azy88xpcAI3aw9cV4J3Mkd9hVlW6v
	 hdfMbCRp7QfP6KrsuNO+8Z1k1huItDmEwElpnd5q6kCg1X9TLJQbEjdWA48LxOtIOv
	 TvgI2zeXWhRDksl/NN0lHkecysjoiV+oSRAa77oI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 255/286] tty: dont check for signal_pending() in send_break()
Date: Mon, 22 Jan 2024 15:59:21 -0800
Message-ID: <20240122235741.858103450@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

[ Upstream commit fd99392b643b824813df2edbaebe26a2136d31e6 ]

msleep_interruptible() will check on its own. So no need to do the check
in send_break() before calling the above.

Signed-off-by: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20230919085156.1578-15-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 66aad7d8d3ec ("usb: cdc-acm: return correct error code on unsupported break")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 145c26401218..a45e6e1423d8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2479,8 +2479,7 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 	retval = tty->ops->break_ctl(tty, -1);
 	if (retval)
 		goto out;
-	if (!signal_pending(current))
-		msleep_interruptible(duration);
+	msleep_interruptible(duration);
 	retval = tty->ops->break_ctl(tty, 0);
 out:
 	tty_write_unlock(tty);
-- 
2.43.0




