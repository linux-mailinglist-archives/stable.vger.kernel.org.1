Return-Path: <stable+bounces-7689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C5D8175CB
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDE6283DF4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBB5BF99;
	Mon, 18 Dec 2023 15:38:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148BF5BF82
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b9460a9easo497501a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913916; x=1703518716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J17vItaEa9r/mrrNBn9YrN4LKC6YF8KUbUXIAiPIQoU=;
        b=WLJ4Akvbzr3A5o7ABn9xsKtqLqb6l7lwna17doxvtYSZEJildeLfjU7+SXFAKYd/Bj
         UXUuH6HXv1its3WBnmysH0Eqi1zszb4ThGiQxXZNiF0BIccWV+nMRPceOBnjH+v9pGdS
         g0w4Is9Ypgj9SoQpOu84YZihvjIl4v0YFNQWkzXM8jn3bhszLbdGaGBxg+jNwUFRlCgQ
         HMtu6ft0HUlhj/DNMTPhQCZvN19Ot373a5mxOgv8fBQzNP+01qJnpDoJTTrDhw6a9Zxj
         ctIBtxuaQoncKBIXepemwWm65URKV2BeCTB7bdprGMGa5t67tod7Atl0HrjqNs9fSSTS
         XfAg==
X-Gm-Message-State: AOJu0YxSHQEMbjMG8uS9JqBB+pf+ToJPuRLJpcOQW941JxyrTlc9NqW1
	08yBSQp6WklOztCSZXSY8hw=
X-Google-Smtp-Source: AGHT+IF90stN1ZIHUrmzDi9GE7wJt4osJA3/6yJ53HjNtYbKAdYS60En0zVFFg0pcjGV4Llzpb+fuw==
X-Received: by 2002:a17:90a:202:b0:28b:3d8b:ab5b with SMTP id c2-20020a17090a020200b0028b3d8bab5bmr1627049pjc.69.1702913916381;
        Mon, 18 Dec 2023 07:38:36 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:35 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 060/154] ksmbd: hide socket error message when ipv6 config is disable
Date: Tue, 19 Dec 2023 00:33:20 +0900
Message-Id: <20231218153454.8090-61-linkinjeon@kernel.org>
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

[ Upstream commit 5876e99611a91dfb2fb1f7af9d1ae5c017c8331c ]

When ipv6 config is disable(CONFIG_IPV6 is not set), ksmbd fallback to
create ipv4 socket. User reported that this error message lead to
misunderstood some issue. Users have requested not to print this error
message that occurs even though there is no problem.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index 4995f74fb21c..20e85e2701f2 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -428,7 +428,8 @@ static int create_socket(struct interface *iface)
 
 	ret = sock_create(PF_INET6, SOCK_STREAM, IPPROTO_TCP, &ksmbd_socket);
 	if (ret) {
-		pr_err("Can't create socket for ipv6, try ipv4: %d\n", ret);
+		if (ret != -EAFNOSUPPORT)
+			pr_err("Can't create socket for ipv6, fallback to ipv4: %d\n", ret);
 		ret = sock_create(PF_INET, SOCK_STREAM, IPPROTO_TCP,
 				  &ksmbd_socket);
 		if (ret) {
-- 
2.25.1


