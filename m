Return-Path: <stable+bounces-179642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D25B58183
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A2B204A07
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 16:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB33265CA4;
	Mon, 15 Sep 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsB9wMXK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4688263F32
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952217; cv=none; b=ZKRuWOerUDRoqbc14iT/KKOQ3olPzZEVFQGTmaOl/w1klrJlK/VWmdxQcHxd+epRUO8P9xK6/5lFJedi322ePz94btOYdIqTjleTS9WSZFR96JR+EDRb0lWLhLK5lpe8nEHvY0F4ZH0ZrDw02csweyuhJj+q/eq1IbZ4zjWeCmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952217; c=relaxed/simple;
	bh=lz+21+pXWAdvl2nNDlkXW3ZFI2U/V3++gCtr1F/cu+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPHe90DZneL8QQBaCBTdsVhOd+66KKCp0RVp1ydmLOD2awDQAlROTdZv/rnZVFXVzBNYoBGiryuVG2pBOk24H4+tVNd2W5umDP5GZt8BGp4+rDyRv8Sz6K0Cysyd/2dO1zcKkuioGtJy0x1Z6wVR8xjRFyqUE/4frz6gzoHQOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsB9wMXK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757952214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyjSpWLvfqnwtpmHwJJOxa1B89j7LM2tZ53OHGLbRxs=;
	b=gsB9wMXK+0ghL3q7a/L5hYCT42ZoFaw016gabU6JxZMqPN4g/bZL0KvgGkQ+hr+g4s0Y7N
	uD69kk6iFdWwGesLC2YWzzeV1yRJ7CQ3uJJ2dzgMgJ0UGHexCoE8bBOnaGNILo7popICzv
	Av0mngneEKamVoZROGDHWRIk+J7gi+Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-KNBwPhDCNOq2SrONAa-ZUw-1; Mon, 15 Sep 2025 12:03:32 -0400
X-MC-Unique: KNBwPhDCNOq2SrONAa-ZUw-1
X-Mimecast-MFC-AGG-ID: KNBwPhDCNOq2SrONAa-ZUw_1757952211
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b04271cfc88so328564466b.1
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 09:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757952211; x=1758557011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyjSpWLvfqnwtpmHwJJOxa1B89j7LM2tZ53OHGLbRxs=;
        b=Cs2/Ea+Yn1zg570qY9eIxVSoZJw6+mTwJtZi9f6gtrUGH/o+jWF9qqBUnKtnqKFgex
         JSXROdrmUQQyJtOnXpZjyg2nnegS+OrEFYzVGTZCem6tEprT8FyBt7HbPA4URsloDcL1
         AGwKgfqwN+ZFQI19/gVxHyUjeEehCYdFIUso32TAEvc26nHJtk31XXZl1Y8RlHisLaGM
         oo1QQnE0t5oZdpxVhCosulk+E7VlCzXGJUaExZh0p//3gl4Qs1T60sjFwXPRAUTlGXbS
         mEOG3qOXL8xa4ARbBwZUCiOMxfIRVrZN8lMZ0aXiLvImPoyPMrISgMgIZ6GzL9/gdp5p
         MZiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVVUd81la87YcOYlXUuy11wJ8kykh4a6aHG7ov+kLH958Yxp/jL75nAu/qJrt/V9u0jfQnxwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1bQdIy0Av6QWdm/1qJzJKNRmdI2XsiS8ek2xWLXxF6IPfhV3
	9Cy8sgkWmLq+/rSsu2G+XrY4/R9PhH5JmyNDc6gp4M7GeT+TVdK1/0aW84LcEnilZcybimitKIQ
	wZvuwDJtw2eWryWWzUoBIUZB/LOg/+zIQbDsm5VPDBAeMRG/1K7J5TO2X0g==
X-Gm-Gg: ASbGncu1HFVDABsiwmkqFiEcXOpZ1ZOrO+8on/rLzJvNsGdfKTRAXan0yNjRch0Q3ku
	U2Kska1uXkZOq7s0RmzBDA9/Wtt1I02b9E46vuqVl9zB5PFgx65fyhDgiE5zCkJcwJ7C50LPTiJ
	ZUQ6OcZ1L2gsb8iQd7Lh/Bfr7iKXBm7PUW25S9Lewq0dYgEVCZQaQhA5st37Y5OBHR9W/olDyNF
	pPr8jaG1s+gd1FSyDF01n8yQ55EaB7Az+vFI18K35ppZzuTrOS2FwJHyMgkF1XzF1G/KoOu4tro
	moro3gD7DqXU4bh1gGuvTffOf63+
X-Received: by 2002:a17:907:d16:b0:b04:3402:3940 with SMTP id a640c23a62f3a-b07c35d4d02mr1305642066b.27.1757952211041;
        Mon, 15 Sep 2025 09:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNtSBH6QlKSIfQdtkhP6WbRqJLxZsgUpRv3jEYGQSqAMd7B74yXmlLS/60ot7X5iMC+KioIg==
X-Received: by 2002:a17:907:d16:b0:b04:3402:3940 with SMTP id a640c23a62f3a-b07c35d4d02mr1305636166b.27.1757952210298;
        Mon, 15 Sep 2025 09:03:30 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd413sm988048866b.71.2025.09.15.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:03:29 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:03:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 3/3] vhost-net: flush batched before enabling notifications
Message-ID: <7b0c9cf7c81e39a59897b3a76d159aa0580b2baa.1757952021.git.mst@redhat.com>
References: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93d3101a6c78f17a19bb0f883d72b30f66d1b54.1757952021.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
sendmsg") tries to defer the notification enabling by moving the logic
out of the loop after the vhost_tx_batch() when nothing new is spotted.
This caused unexpected side effects as the new logic is reused for
several other error conditions.

A previous patch reverted 8c2e6b26ffe2. Now, bring the performance
back up by flushing batched buffers before enabling notifications.

Link: https://lore.kernel.org/all/20250915024703.2206-2-jasowang@redhat.com
Reported-by: Jon Kohler <jon@nutanix.com>
Cc: stable@vger.kernel.org
Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 57efd5c55f89..72ecb8691275 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -782,11 +782,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		if (head == vq->num) {
 			if (unlikely(busyloop_intr)) {
 				vhost_poll_queue(&vq->poll);
-			} else if (unlikely(vhost_enable_notify(&net->dev,
-								vq))) {
-				vhost_disable_notify(&net->dev, vq);
-				continue;
-			}
+			} else {
+				/* Flush batched packets before enabling
+				 * virtqueue notifications to reduce
+				 * unnecessary virtqueue kicks.
+				 */
+				vhost_tx_batch(net, nvq, sock, &msg);
+
+				if (unlikely(vhost_enable_notify(&net->dev,
+								 vq))) {
+					vhost_disable_notify(&net->dev, vq);
+					continue;
+				}
 			break;
 		}
 
-- 
MST


