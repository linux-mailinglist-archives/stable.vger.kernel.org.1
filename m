Return-Path: <stable+bounces-202824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 950A0CC7C49
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 203BD303ADFB
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A620733CE90;
	Wed, 17 Dec 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMFcY1bV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4B34E75D
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976290; cv=none; b=ki7p2g4t6ee0vNP84DsuTvBwwJVk20XN8q2cRtRAn4C6+9CJG+Lc8BlTGn/5hSjedPN+1yimCxVw7Dsvwm3eJ/T4xHJMn2yvPOBU+gUZZya2meXQ+0sHqMEFou1TuAeXFXnoLkHqxfKLZ0KC6566CBTdvWgrxpAzKQyyMGSoRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976290; c=relaxed/simple;
	bh=CloEhhB+uejblLuhuXn8n5zkfy2FIPc3okx6zsJmi1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HI3YWqe01ZOTEF+j1jNKLLBVzrAhyyLM4dmBYDNwzzR5Q9W74fMzhs5ZYHN4KamHO3umP0kUcEoow7rn81LLGQT5n1lzT4zPEPxh49HnGsLWPYXruRnNjVy3vWdJTKVJFpvNe+HkSMW6zuGXgFYA9wuVcqMgqzcerUr1B4nyJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMFcY1bV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b9a2e3c4afcso334221a12.1
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 04:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765976288; x=1766581088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdG/M5hQwjEekQuQim1OPFLT3tKylIxu+drVZWp4rT8=;
        b=UMFcY1bVYx2NbabxTsP2TBO8GCD/QQphBVd0VcZ9BQfppxqwkeb6G8VQpei7ivgmoq
         0d3iry2VSThXjAduO676eJX4zbaLnIhdAtMbOi9GbzSQUgbmQORiLneGG546BjorGms4
         2uCtlMHhK4kMemTHttFwR/M5GyQqje9qPLVJypOuo+Tw08UUC/FdFcx3BMeCqi32vc5R
         9DS6Vp+nRsjNnrbgA/VB3Fp5zicHbG/vzKPEiXtHvyOq1Z8k65W18BxQGi8CkCXFxHa1
         KCRKrzIO/Hh63Xh09hjMcoBCxkN2mvY718dYXNBKjQfuPcVPK/HO4INWE4yO/ifafuHC
         E9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976288; x=1766581088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdG/M5hQwjEekQuQim1OPFLT3tKylIxu+drVZWp4rT8=;
        b=BjBBOPTKCUK/lTqoyvVXi/LdnhFdiKQ4hMVnW7nVW+Zm1kxrq4k7KWFRJbAWlLkNoV
         Abmm4RJ6BqRcA2DtUdO7XM3o6P1+t42L0bVL3uACsZcibRiSoXRnL2FXRNixbNqZiIoC
         IvszqHgHgEG5difaOW36iyXRYE+7TF3D85QHvy2JMsi7k5iC+7nrPIiasMT41giO3e6f
         0qJfH11JSV5h4lvfJJzodlZEZaxG7S98yov51KnVn17Nu7EQcP3jO6ZvJ3YrdKOkcDK9
         IdoPz+geld6vLIKxV5aY63y//QEq6hzrl0GIiPfmeiSQt1sTTY98UW/q5QHY1mwyfNRD
         T/FA==
X-Forwarded-Encrypted: i=1; AJvYcCW71XdvCQ2220FsFe7mmHjjW96eziyK0VpJJGD8sjkgIBG/CszQvXww5/GtxeQPlvISkKuZ7kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3x5sG1MFpv0JCVvD3Pz6k6ZoDNUo1i0riU2E9qu2bSYybwiif
	FE0sNH7jvBIbqCfF5A4fgE185Ypxr2I6E0evGnBX8tn61gt41wW9oF13FTNIvWdF
X-Gm-Gg: AY/fxX57B5P0nmw7W0lXL1vGTK7UYQvtX+rM9NoyuG8AzjYk2WQdfNn7r8jxU0+3316
	p6zosx+R62jbYap2bJ/1BRyU7BSBJq4oNOYy79VGdWEAEy3+c5qjSKgkpr1WHvlvNSB/JzNs82J
	e0vzeY1OGRV8tGJlCJqcgnNvYBvaS9BTqnkTN1xFdXap9QZKgkJLrrosPwf/ZheGsLrSDa0zhA1
	qN7H2c4hbkjBl34Yry1QK+oYqLbQ/KF0LM7rHHb86oW+mwjQocUYKrbY1oYgLeYbRaQ3U1N3JIG
	eJgqzUHnkNzn8Hg+svElTythUh4dB4ieQ0yOWVk2Kmn6N8t2WXF6ogTmQgFVO8WXsST920aGTEF
	4zdWLCg9N453aRPhV09/ICqSar+232SJrJWIEEiXdNR1GeHNliJyIZSE6jUI5CBA0RBqsLlyS8d
	BSiY01/F0N8F05DowX440RBJdYIjJWqiZhXNaffFfnrwJJJUbSG7Qay4jQEui89XD3Y9LAxWkr
X-Google-Smtp-Source: AGHT+IFZs9GsdtlAivxApIzkVEWP8L1/mtLGAQcCbK/sMWOJTBXjsnO6H1lzfZPhfrYX00deaC1B1w==
X-Received: by 2002:aa7:8886:0:b0:776:19f6:5d3d with SMTP id d2e1a72fcca58-7f6674439a0mr13348568b3a.2.1765976287906;
        Wed, 17 Dec 2025 04:58:07 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fd974aeb37sm839335b3a.11.2025.12.17.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:58:07 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v2 2/2] nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()
Date: Wed, 17 Dec 2025 21:57:46 +0900
Message-Id: <20251217125746.19304-3-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217125746.19304-1-pioooooooooip@gmail.com>
References: <20251217125746.19304-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_hdlc(), the LLCP_CLOSED branch releases the socket lock and
drops the reference, but the function continues to operate on llcp_sock/sk and
later runs release_sock() and nfc_llcp_sock_put() again on the common exit path.

Return immediately after the CLOSED cleanup to avoid refcount/lock imbalance and
to avoid using the socket after dropping the reference.

Fixes: d646960f7986fefb460a2b062d5ccc8ccfeacc3a ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index ed37604ed..f6c1d79f9 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1089,6 +1089,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
-- 
2.34.1


