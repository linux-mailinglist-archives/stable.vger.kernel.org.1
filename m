Return-Path: <stable+bounces-7687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9428175C9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90171C24D48
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E05BF88;
	Mon, 18 Dec 2023 15:38:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72175A874
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b4e6579a9so626878a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913910; x=1703518710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8XzlNwLAPCiS7VbD7wKiFpSnYpzhQxay5KFwKtKvBo=;
        b=tbOVwNASSzJ4OVvN6J6CpQuCtEHWxK5XXH0wPMOqRHxkfUX/rc16HDElBF/HQ0qI9s
         USq1atfTCLSR4nkcCRIYjI4AWyoTag3vtYCG0EpSJgKM1f+9XKiKfO/mxDb1hWKv5TvQ
         cE4fqxyvn/d1aaqP4zdewjewIoefRP7VfQQJ0oPynUJIe29XqdBghHOy+mdcqD9c+DBi
         WgH8OtE7XTMWIe3eI18xqNkPsg0xFY0rDwDp5+2pfSFYdRHrBTjO1t+6pWm+TsLiU11d
         8b3zBeLJRSzhjz8TxQ/gc+KMkqBuQpBsCaoUwbD/j5a4CZP8U6jwalqKcNEFuhyqm6ue
         PfVg==
X-Gm-Message-State: AOJu0Yx1rmudxSXGiydn6t5GZZamH6/0Af59Jh7NWPMzdVbILyvXVZNg
	lqd4fwAm0XtZENFu/Qs/YQc=
X-Google-Smtp-Source: AGHT+IE4lbr/YhF3Tgk9L7JeqK7Y02clJF/vgyBvcH2XP2EEI4hVMLxt2GV52aZc0tGDEZoMly3tvQ==
X-Received: by 2002:a17:90a:ba8a:b0:28b:4e25:c777 with SMTP id t10-20020a17090aba8a00b0028b4e25c777mr789368pjr.27.1702913910274;
        Mon, 18 Dec 2023 07:38:30 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:29 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Tom Talpey <tom@talpey.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 058/154] ksmbd: decrease the number of SMB3 smbdirect server SGEs
Date: Tue, 19 Dec 2023 00:33:18 +0900
Message-Id: <20231218153454.8090-59-linkinjeon@kernel.org>
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

From: Tom Talpey <tom@talpey.com>

[ Upstream commit 2b4eeeaa90617c5e37da7c804c422b4e833b87b2 ]

The server-side SMBDirect layer requires no more than 6 send SGEs
The previous default of 8 causes ksmbd to fail on the SoftiWARP
(siw) provider, and possibly others. Additionally, large numbers
of SGEs reduces performance significantly on adapter implementations.

Signed-off-by: Tom Talpey <tom@talpey.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 7bac4b09c844..ef4891b54447 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -32,7 +32,7 @@
 /* SMB_DIRECT negotiation timeout in seconds */
 #define SMB_DIRECT_NEGOTIATE_TIMEOUT		120
 
-#define SMB_DIRECT_MAX_SEND_SGES		8
+#define SMB_DIRECT_MAX_SEND_SGES		6
 #define SMB_DIRECT_MAX_RECV_SGES		1
 
 /*
-- 
2.25.1


