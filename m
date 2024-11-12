Return-Path: <stable+bounces-92251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153239C5486
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640C6B32B5B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BDD213EEC;
	Tue, 12 Nov 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VRdSG2kG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022519E992;
	Tue, 12 Nov 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407045; cv=none; b=b8YkOM7up4suhicyE9P7oDU70ZKAIbAqzAbGHD5c+dMpxC8sR+zv76WOogXZQfvpC3v1PCHcLbpDk4LlB7nT5SlhkqnXwL9xJHVR3XDzWPVNq7Lhm3OBGkou9GjzQ+4lzZnpGLKM1NrxhSUozEHaSkRZpHLoSQyRjtiISiwAhRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407045; c=relaxed/simple;
	bh=MbHMe8x/GlFKKXMULfwLeEb6K/gQ0SrEf4jGqIkVaZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXPxndP0qA0AeZxly12kbRjUMIUvx6LW8Cr3eN8pMMFeAZqOiijw2rJPuF8uQ8Lmu5caJNOjnnsYdP8iwf+JLKb7j7zRSgd0xk9Cw3j+BDNNfW5bIc9NbvWNxukLQqUcyc7TQJPuhJO0LnhCStvP2BwxAN7PnW72qFdV5hALngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VRdSG2kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F6EC4CECD;
	Tue, 12 Nov 2024 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407045;
	bh=MbHMe8x/GlFKKXMULfwLeEb6K/gQ0SrEf4jGqIkVaZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRdSG2kGnOCm95O9OwUi+GKVksRFwd8+rJO8qE2xgRr95rw17H7aGNC39YqlOzkF6
	 KdOe7OUibS4YP6lVPJ9bKkOFqpNubnD2f5t4Q1elVmMOY8vIsxr8yEzbHgQoToAUxa
	 sFHIhhEqPuxisDpaOkvGgebUHjKzurlcKmzbPWwM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.15 34/76] media: cx24116: prevent overflows on SNR calculus
Date: Tue, 12 Nov 2024 11:20:59 +0100
Message-ID: <20241112101841.086748931@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
References: <20241112101839.777512218@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit 576a307a7650bd544fbb24df801b9b7863b85e2f upstream.

as reported by Coverity, if reading SNR registers fail, a negative
number will be returned, causing an underflow when reading SNR
registers.

Prevent that.

Fixes: 8953db793d5b ("V4L/DVB (9178): cx24116: Add module parameter to return SNR as ESNO.")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/cx24116.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/cx24116.c
+++ b/drivers/media/dvb-frontends/cx24116.c
@@ -741,6 +741,7 @@ static int cx24116_read_snr_pct(struct d
 {
 	struct cx24116_state *state = fe->demodulator_priv;
 	u8 snr_reading;
+	int ret;
 	static const u32 snr_tab[] = { /* 10 x Table (rounded up) */
 		0x00000, 0x0199A, 0x03333, 0x04ccD, 0x06667,
 		0x08000, 0x0999A, 0x0b333, 0x0cccD, 0x0e667,
@@ -749,7 +750,11 @@ static int cx24116_read_snr_pct(struct d
 
 	dprintk("%s()\n", __func__);
 
-	snr_reading = cx24116_readreg(state, CX24116_REG_QUALITY0);
+	ret = cx24116_readreg(state, CX24116_REG_QUALITY0);
+	if (ret  < 0)
+		return ret;
+
+	snr_reading = ret;
 
 	if (snr_reading >= 0xa0 /* 100% */)
 		*snr = 0xffff;



