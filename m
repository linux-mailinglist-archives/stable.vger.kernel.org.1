Return-Path: <stable+bounces-170380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A06B2A3D9
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE639188E1B5
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74BC31E102;
	Mon, 18 Aug 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vugcfiD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454331E0E6;
	Mon, 18 Aug 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522440; cv=none; b=tPPfJmiEklXappq1sZ1q7vIz4Lh9SGZtamRha5SxhBNUvGUsH6bhMjGl3fDRzX741RcujiSB0qZhvTtq3Uzc73R3owb0VdBWDpaHaraQ8bqLp4lEBtzA6q9IjqOkXkm73/yE7l6QIMd7eZDYrWWpCr+LOYg42e9at+UVcmwSlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522440; c=relaxed/simple;
	bh=1AG7oJKK9FjT5KnQhQqM16aXtdEl8Xh2NBNKrRJeDr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UopNantrpnnG7qdaWs7/WCi4EuvNj+01GugPWrAe7WDTz16SyPmJItcDNp33m8wsgA2K1hLVeN1xd7zXFnwLD7a7DS7k/30lJaUff49RfFi+39fwmp1JR1zd8rs5sbX5oShfRd5hx81d/61ZbEDdQYQkhFzLMZ1w40/aaWAy6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vugcfiD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B07C4CEEB;
	Mon, 18 Aug 2025 13:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522440;
	bh=1AG7oJKK9FjT5KnQhQqM16aXtdEl8Xh2NBNKrRJeDr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vugcfiD4evPRcPJbPJIQOpEEV8UBGuuJyq14o2kwbY9UMcGXkaPs03LsMmX41c3H0
	 iwDA9oUm3qZZ9PwEQUin4iqUXr5yQsjnQUzU6z1yZYlPFc+s9/blEG0hBtEt2e94hl
	 LjxLO6YkYH4yvGWij5yTJcOLeZJoqr9OBiBcUA60=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Guo <alexguo1023@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 317/444] media: dvb-frontends: dib7090p: fix null-ptr-deref in dib7090p_rw_on_apb()
Date: Mon, 18 Aug 2025 14:45:43 +0200
Message-ID: <20250818124500.833971726@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

From: Alex Guo <alexguo1023@gmail.com>

[ Upstream commit ce5cac69b2edac3e3246fee03e8f4c2a1075238b ]

In dib7090p_rw_on_apb, msg is controlled by user. When msg[0].buf is null and
msg[0].len is zero, former checks on msg[0].buf would be passed. If accessing
msg[0].buf[2] without sanity check, null pointer deref would happen. We add
check on msg[0].len to prevent crash. Similar issue occurs when access
msg[1].buf[0] and msg[1].buf[1].

Similar commit: commit 0ed554fd769a ("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
Link: https://lore.kernel.org/r/20250616013231.730221-1-alexguo1023@gmail.com
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/dib7000p.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index c5582d4fa5be..24f13a866735 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -2256,8 +2256,12 @@ static int dib7090p_rw_on_apb(struct i2c_adapter *i2c_adap,
 	u16 word;
 
 	if (num == 1) {		/* write */
+		if (msg[0].len < 3)
+			return -EOPNOTSUPP;
 		dib7000p_write_word(state, apb_address, ((msg[0].buf[1] << 8) | (msg[0].buf[2])));
 	} else {
+		if (msg[1].len < 2)
+			return -EOPNOTSUPP;
 		word = dib7000p_read_word(state, apb_address);
 		msg[1].buf[0] = (word >> 8) & 0xff;
 		msg[1].buf[1] = (word) & 0xff;
-- 
2.39.5




