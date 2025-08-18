Return-Path: <stable+bounces-171670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F9B2B450
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 01:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7C71BA17EE
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 23:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82121FF3F;
	Mon, 18 Aug 2025 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PS+ztpUJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1583451B0
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558522; cv=none; b=CLjDlBllzccoaCLIsAnNE2OYvQKdqIc/hphPo5+5c3Kio1ZSbtyKXmjMdy0uRzDpZ5XWmL3CCCMgKcfWTCfnQSMhLi6pbzqXQZtRt77Xu2s3urQY4f6Rbl4V4pNqohS09bPeT77DP/HpYExUS8cINXU2n76R1stbhDBDg0mMGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558522; c=relaxed/simple;
	bh=JraMXGzZfamdhXAsqrNUv9qSB49LjBciNHKNdQcAsV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HceHeLf7crqJvL/TzHeOBnAIKe8TbhL53DN6xDH36IOseDY9saMjOZoYKh4HcgNH8IN4Wk9DkBt3/Ou6fmlQWz7i3NGcJwunYnKeak1u3l+8oiwPGpKBzAXgVLjUKZA2l1+FfDfMEbbjrXRpSOGZ7CZ6On6nbxg7hvZtTkXyM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PS+ztpUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2C9C4CEEB;
	Mon, 18 Aug 2025 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755558521;
	bh=JraMXGzZfamdhXAsqrNUv9qSB49LjBciNHKNdQcAsV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PS+ztpUJ9lSwB2FkurheZms2CH1zrZfZcd8eeSRDr4TfIDfdaRAUlajOxyvIkInK1
	 3RD4iIjog7XUsIi27QoomU4/wsJqSEYFSmLd60Qh5jFvnJPtKVoSA8Bu0oqokvCGd0
	 wxf+Wxn2hrkMoWl4lbqXQRm9s/DCwqQaGDWMxuN8EEmQp0q7e55EVIMlbFqiRQmlpB
	 TIUHQmfqQ6u4gQ+xgt/E3PwFt6NxldqIWdALtH8OTPIUww3r5CmJHSYzGM0U8K7DPa
	 +5S9dOtVIJ3U8+LimO8XC7ORT0S3bOHzBUIjwMo8VMvbvFUkV5K8ugUVRtLvwvMz0Y
	 meUUNFd833UsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] USB: cdc-acm: do not log successful probe on later errors
Date: Mon, 18 Aug 2025 19:08:38 -0400
Message-ID: <20250818230839.135733-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081847-resident-transform-fcca@gregkh>
References: <2025081847-resident-transform-fcca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 79579411826647fd573dbe301c4d933bc90e4be7 ]

Do not log the successful-probe message until the tty device has been
registered.

Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20210322155318.9837-9-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 64690a90cd7c ("cdc-acm: fix race between initial clearing halt and open")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 571b70b9231c..50d439201302 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1510,8 +1510,6 @@ static int acm_probe(struct usb_interface *intf,
 	acm->nb_index = 0;
 	acm->nb_size = 0;
 
-	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
-
 	acm->line.dwDTERate = cpu_to_le32(9600);
 	acm->line.bDataBits = 8;
 	acm_set_line(acm, &acm->line);
@@ -1531,6 +1529,8 @@ static int acm_probe(struct usb_interface *intf,
 		usb_clear_halt(usb_dev, acm->out);
 	}
 
+	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
+
 	return 0;
 alloc_fail6:
 	if (!acm->combined_interfaces) {
-- 
2.50.1


