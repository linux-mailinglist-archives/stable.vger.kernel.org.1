Return-Path: <stable+bounces-156876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7CAE518B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6B81B62D34
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D1222599;
	Mon, 23 Jun 2025 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vI8XCIGq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B194F221FD2;
	Mon, 23 Jun 2025 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714482; cv=none; b=Kh9/MMTHy8IWX8qnDg/kOc7RIAE05CcQFvlKwu/iFUZgELbMCljYNqRxS+2ilP1YZdoBIVT2xFHVkUwU7d2uq5aaYNtcNlqf4ip0IQQgZaIWQkPRSWSgkickuwdqhBViGshOKE/662gHC4Py0brpEp8pAR9rlxuuBRxaKBl2uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714482; c=relaxed/simple;
	bh=Tnbd0HF1AA72mt2mYfn381e3oVpIkhWlZ4xmva4Xats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+V+sSslQoZCO66QD/sJeGele4AO9RGSLtWFjNFlMJhlIZFRaIlNTTBIIl3RBQ4Vrp22rKKW53iV1QspHm7xL8Ef0EEYHWz9F0yaddwrOekZawPGJfOELuG3d0aRR8tWP0v767SMN2n4XE4cDAeMmRxChCY0y11F0CkC6vMcGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vI8XCIGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDF4C4CEEA;
	Mon, 23 Jun 2025 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714482;
	bh=Tnbd0HF1AA72mt2mYfn381e3oVpIkhWlZ4xmva4Xats=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vI8XCIGqQSOdCL1c1F7aeU3lEvivp+SjqDTkG+rdh21G1+VaUdYVpbzRjHVFwEwjC
	 YFnPYXT9/uDJDj77lGoUq29bJXiCf/nUX0eLJdljTrAFe7LNS5/xI6Wmlx8u0rz8OC
	 2Be2obPSR+2XWZ+QFPhEE3qEUhrAMcrEV0dxDWwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15 211/411] media: gspca: Add error handling for stv06xx_read_sensor()
Date: Mon, 23 Jun 2025 15:05:55 +0200
Message-ID: <20250623130638.980760473@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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



