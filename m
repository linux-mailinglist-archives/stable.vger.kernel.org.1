Return-Path: <stable+bounces-1817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B57F817E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A9A282645
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6293418B;
	Fri, 24 Nov 2023 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="enj9P3hx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B898339BE;
	Fri, 24 Nov 2023 18:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA00DC433C7;
	Fri, 24 Nov 2023 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852345;
	bh=/LFpPrrhulETCkWK1yMWU2/nA5G7m1K0jk0nmql+cpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=enj9P3hx7LXlCEkmBJQOZ00HK8qr68OTeAxbS6Dow65nmZFGK39i1LThaAJNnUaLr
	 z3GyKg4lWCZD1H0RNdpgStu4mqFDwRcGspnMOj3+7JkHeZ8V911g+SxgbdPbiUz2+4
	 VKlFRJvNifyb8xNiVDncz9zZiDOn2l2Mmx4Eew38=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.1 318/372] media: lirc: drop trailing space from scancode transmit
Date: Fri, 24 Nov 2023 17:51:45 +0000
Message-ID: <20231124172020.991013546@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Young <sean@mess.org>

commit c8a489f820179fb12251e262b50303c29de991ac upstream.

When transmitting, infrared drivers expect an odd number of samples; iow
without a trailing space. No problems have been observed so far, so
this is just belt and braces.

Fixes: 9b6192589be7 ("media: lirc: implement scancode sending")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/rc/lirc_dev.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -276,7 +276,11 @@ static ssize_t lirc_transmit(struct file
 		if (ret < 0)
 			goto out_kfree_raw;
 
-		count = ret;
+		/* drop trailing space */
+		if (!(ret % 2))
+			count = ret - 1;
+		else
+			count = ret;
 
 		txbuf = kmalloc_array(count, sizeof(unsigned int), GFP_KERNEL);
 		if (!txbuf) {



