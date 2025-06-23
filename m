Return-Path: <stable+bounces-156639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1995AE506A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490894A0E61
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA31F21FF50;
	Mon, 23 Jun 2025 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+Zs/5jF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD631F4628;
	Mon, 23 Jun 2025 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713903; cv=none; b=cmRsY+NXXGl/JjcfZ3Rw/83GcMjrswyiiGzUed1NDXsPfmJKI0eRt29bZBaveJ5N5YlR1LK/1hBdvR6ENKT2ixZdagO7cqVbDzkVLQZVILuX/vwGXDgTzlFNNRSUcXaoHCpHK3tc+KS4BOTNylyko3q0yu3RTZ9a0zP/HsW6pJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713903; c=relaxed/simple;
	bh=Qh/QBJ/B5Xs/CXjFvRQ2/fwXamfUsH+2JqzLnesRhTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCqT+v/Sbd40iXd12vKY1z+NoybtI8lU0fcJ3bTIyzBrQZQxahL3iLdtdawGyeOZ3cdUNQYGDmnYPZp0HsUjWQSqIQ6AWDoxAu2XlfmcvSlGQ+GqEClkN0q3/u0W15nSSvHg0kHsSrqleulM9ITsxREJRIJ79fiRbZDw/FIrpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+Zs/5jF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34240C4CEED;
	Mon, 23 Jun 2025 21:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713903;
	bh=Qh/QBJ/B5Xs/CXjFvRQ2/fwXamfUsH+2JqzLnesRhTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+Zs/5jFJjtNXvZZOM31cW7n8ijGB7z28gWxa/XW8z5l27VBr+Ntw0M8EwZgVlCpO
	 ZCcmIedNLo+RiIj8WJdOXVBphf6PGNnPxaA69yl3O4qTECNZHDd5UEoUXzJLOF7vsx
	 eEtR2j3Eu3+k7Zmlf5SshZ325po3ScTa41wEMokc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.10 173/355] media: gspca: Add error handling for stv06xx_read_sensor()
Date: Mon, 23 Jun 2025 15:06:14 +0200
Message-ID: <20250623130631.909632656@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

commit 398a1b33f1479af35ca915c5efc9b00d6204f8fa upstream.

In hdcs_init(), the return value of stv06xx_read_sensor() needs to be
checked. A proper implementation can be found in vv6410_dump(). Add a
check in loop condition and propergate error code to fix this issue.

Fixes: 4c98834addfe ("V4L/DVB (10048): gspca - stv06xx: New subdriver.")
Cc: stable@vger.kernel.org # v2.6+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
+++ b/drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c
@@ -520,12 +520,13 @@ static int hdcs_init(struct sd *sd)
 static int hdcs_dump(struct sd *sd)
 {
 	u16 reg, val;
+	int err = 0;
 
 	pr_info("Dumping sensor registers:\n");
 
-	for (reg = HDCS_IDENT; reg <= HDCS_ROWEXPH; reg++) {
-		stv06xx_read_sensor(sd, reg, &val);
+	for (reg = HDCS_IDENT; reg <= HDCS_ROWEXPH && !err; reg++) {
+		err = stv06xx_read_sensor(sd, reg, &val);
 		pr_info("reg 0x%02x = 0x%02x\n", reg, val);
 	}
-	return 0;
+	return (err < 0) ? err : 0;
 }



