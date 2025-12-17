Return-Path: <stable+bounces-202823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3493CC7C3D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49F5730FA7DE
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F38034F27B;
	Wed, 17 Dec 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkZMk3Rf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61F34B1AC
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976285; cv=none; b=qKc7bypoC8lCpJikTCPhMilkRqRz5eSDFHV11MCOHYwi7H/B7/E65Al8NpQauv9oOK3j4wBTG3hzu1mX4LjDa4rMGWJOzUj7xcwxZBz+tflLhCmHYypkmYycZPxENQWiMc5j2qnZUlyQ0bwyDSeazi4VG1KHONOt6Svoz2DB2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976285; c=relaxed/simple;
	bh=SZnCdTyKaSLAbq/w5ae+5W9P3TCfTqARU6rrGxRItYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2NS6OkJDMR0WQ8UDBE8WdBveuVbt9cGAmtq9Lc0GCaDcl82rOaJliLxKSE2ROQU9HkJD4rPIIF97Vtx/L3GpXCknfXMzCwPMpHjbqKddaUp1bg61ED5MB5S49Y482PPmTBEjnPHGj0izssJ+6yegAz9Nh5KhuqB786Uq1bAdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkZMk3Rf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7f6282195a9so503156b3a.2
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 04:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765976283; x=1766581083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19nxpEKwGS7FQgHQH9ItvDMFClxV8pWJ4CiL9LfKCs0=;
        b=YkZMk3Rf8izIZxEypeYZRidmU0DRh26aCOQdpNYkAJR5mf8MvE85JHAugxt+0oW4Th
         ess1vSGrfjA4QpvytxbUmIH0Zz4X/Xk2ei2edGtd4d7rjGgZdFEViQwPUStyJQFe7oGE
         WHHojGbQ1ux3IWz7XzFbgN6L85YgZAMy5jK6rVmIYQOoOMwPv3uUb6I2cVpihF8Jqn32
         vCGzXfawokhnUjt8roT4qDLEPcI25azrhRtZavDi6Y7b8T4/wj7yuBhEGv7+8XNahwid
         /uvxeV26d+58ms5GUQfrNtbn9j57mb0+IoIL+WODETwpauyhRXw/kyh4y6qsc9OE7cOt
         RVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976283; x=1766581083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19nxpEKwGS7FQgHQH9ItvDMFClxV8pWJ4CiL9LfKCs0=;
        b=HI1ZyYcxcq6n9NSUtqWCaQd1GVsfWHzu7vwOak2Pf/2LlDRJnKN7K2FIAYYUSAqB+0
         DHCHdHw2/LilwNIkM8i82Ijv7ESGIPSfWNPrWGek1UKpddmmMRNLiad83cqvQB1Eyc4s
         E1pcaXqv5rljlQ3er7yl8nu2xymyPuDA31fQlz+rihzAMpq+AjihmRUEk7nk1IvLWeoU
         /8YemIq+cKH5FNkYosSIMsHB98Yxq4W4U4YsIONyM1AZ3hwFlbE5Fv+2MHuYHMait9NG
         EpI7ddeuJ/bsrwQomg+WxQgZ/QnIZSwIOLnvSBoUr64Kjx46ZMel5jU8yuqE5tOEX1c+
         ggoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmtecG2KEqyiuAbYG9Pfna5VU8CDOT6PD6QQw5yhYlOHtRf04FLDtW8UJldV3+j990BNS3Ypw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJkqDi/GwOTegAhided7McK1GqzTvhr3en5PzSTNTicYjyegrv
	smnFW766n7wc8EeR3D7RZndQpY09+sA8eQUgZe/beQc8OIdzUkF7nhKH
X-Gm-Gg: AY/fxX5Gd2p4sKNIXpoa3SqGosr7aBnYVE1JoSKIcicpgLmCnqlOD6YdkcTDncq3aqJ
	Uc3RDQEJl9Mb5E2ryOVMwYeQ2BOhYwDtEzTE8V5zKlkuh/esFkzBMgbtESIsLh/juPqRsgOAYmL
	M4SKBGgBb+bWhD6/q4wDQR2zlQUbm+XWlOLNejF2n8pskdhXAHjU1jpqEpmzCAdw5dFZ3zL89j9
	F2FjyAb7Vhns2Dzw2wJRng0TNOH6bAzUj1n+nCNh+9Ai9/wROA3ulgySa1UQXt8bk5gvjqaYEi/
	zZhpoC3vYYyKuAY9sYblDaq0YY/hpAZ7h1nCU79j0WmAD3hl5M1CqfTvEpyX0N945yDDLB7S5aU
	NVgaXD2IEiayj9lgtX5nBbIwVnyYAjSkyZ8norDKZASJnqQ2CDPq7EJMQEwqoUY/hPTj2sy3teS
	xYSEr1jTBCJyMIQSeugODXps2h5Rp3hRGUf0GlDkJSK+A6NMhjm2ZIkadvr9Km0CUCxrWbZpsmy
	H/nDJSfNR8=
X-Google-Smtp-Source: AGHT+IGljT05kcE0gnGjJhZSXdc45btqsT9idbNMlheRL+reQ+D2Cuw4RN6rf32Fhx0ASJ9iIYpshg==
X-Received: by 2002:a05:6a00:929b:b0:7ab:9850:25fb with SMTP id d2e1a72fcca58-7f667731a61mr12221010b3a.2.1765976283395;
        Wed, 17 Dec 2025 04:58:03 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fd974aeb37sm839335b3a.11.2025.12.17.04.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:58:02 -0800 (PST)
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
Subject: [PATCH v2 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED in nfc_llcp_recv_disc()
Date: Wed, 17 Dec 2025 21:57:45 +0900
Message-Id: <20251217125746.19304-2-pioooooooooip@gmail.com>
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

In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state, the
code used to perform release_sock() and nfc_llcp_sock_put() in the CLOSED branch
but then continued execution and later performed the same cleanup again on the
common exit path. This results in refcount imbalance (double put) and unbalanced
lock release.

Remove the redundant CLOSED-branch cleanup so that release_sock() and
nfc_llcp_sock_put() are performed exactly once via the common exit path, while
keeping the existing DM_DISC reply behavior.

Fixes: d646960f7986fefb460a2b062d5ccc8ccfeacc3a ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d2..ed37604ed 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	nfc_llcp_socket_purge(llcp_sock);
 
-	if (sk->sk_state == LLCP_CLOSED) {
-		release_sock(sk);
-		nfc_llcp_sock_put(llcp_sock);
-	}
-
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
 		sk->sk_state = LLCP_CLOSED;
-- 
2.34.1


