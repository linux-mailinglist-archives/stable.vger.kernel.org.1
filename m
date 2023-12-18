Return-Path: <stable+bounces-7654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1277E81759B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51B9B22C7D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866774E03;
	Mon, 18 Dec 2023 15:36:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A656740A1
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3ac28ae81so12285795ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913801; x=1703518601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zn886VlaZ+IsOpHxOxkQ4p0F/OGkWHSEgf9dzTIIexM=;
        b=TrD2RhZX1WR3pjPQXh0WSPpcFURFYPE8Rit0rGCMFsUrmp/j6wZLSBs28Ob7Mdvkrz
         yeUZde7ZWr1atYvrA18tdXxOcy3tZ3TDZsrDODLQTD86XlJwohyy/Lb6b9mAJ8Z8QLby
         eElUb2NwZ3UsCi6MCCt24krhkjcTm6gaWZPGWxQ7B8ck4tPuW+Od6UYJrrSLHAMpqIkE
         wa5A2sVrZyt6kPg5bUiH3fZ6ng6SFYAyHzFys4wWdTP6u7bTe5l5bwy2T3qYmKPxaB9V
         jjkY+jw1VBhbuJIU4xIBR78zMG7gVOjl2UdIUBihorEcHvvMeMiQh1xJMrKn3Eh5aqRM
         VY0w==
X-Gm-Message-State: AOJu0Yyn1aJmXkYH2hxZ/3axat/sfutl9+1aHyuQOIJ0roof59VnRAwj
	6X8XYD3flC+vAmPAAvV7tvA=
X-Google-Smtp-Source: AGHT+IHUSC+mjsgUqfD9pcZyC87Js95u4M0rJ51nOwF6dov+/t7LziLRvcuXW4lAhcHeVY0BrjeMJQ==
X-Received: by 2002:a17:90a:6d88:b0:286:6cc1:3f17 with SMTP id a8-20020a17090a6d8800b002866cc13f17mr11967630pjk.78.1702913801622;
        Mon, 18 Dec 2023 07:36:41 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:41 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Tobias Klauser <tklauser@distanz.ch>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 025/154] ksmbd: use netif_is_bridge_port
Date: Tue, 19 Dec 2023 00:32:45 +0900
Message-Id: <20231218153454.8090-26-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Klauser <tklauser@distanz.ch>

[ Upstream commit 1b699bf3a8786f7d41eebd9f6ba673185fa5b6bd ]

Use netif_is_bridge_port defined in <linux/netdevice.h> instead of
open-coding it.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index d1d7954368a5..4995f74fb21c 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -505,7 +505,7 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 
 	switch (event) {
 	case NETDEV_UP:
-		if (netdev->priv_flags & IFF_BRIDGE_PORT)
+		if (netif_is_bridge_port(netdev))
 			return NOTIFY_OK;
 
 		list_for_each_entry(iface, &iface_list, entry) {
@@ -614,7 +614,7 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 
 		rtnl_lock();
 		for_each_netdev(&init_net, netdev) {
-			if (netdev->priv_flags & IFF_BRIDGE_PORT)
+			if (netif_is_bridge_port(netdev))
 				continue;
 			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
 				return -ENOMEM;
-- 
2.25.1


