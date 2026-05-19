Return-Path: <stable+bounces-249471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEs6EdkIDGoRUQUAu9opvQ
	(envelope-from <stable+bounces-249471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:53:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EDB5786A5
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25148309F2D2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E6839EF11;
	Tue, 19 May 2026 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="kbXdHB8F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FC39D6D4
	for <stable@vger.kernel.org>; Tue, 19 May 2026 06:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172843; cv=none; b=CVYp2lOCau77h+iDm8cs88t9MiwnN0gTJb/HR/vq4PeGjX1gUu7PJdq67lzSrzrqYqzymJpzbiJGjktMJ6whwEhNoqo0dS0/ZlGImBr2Qx8TkV/8Ks1v+VLep/Aj7ftczMUlZzpGGVfLZqe+JOIHoW+5nqcaM/vIU6zgCBecbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172843; c=relaxed/simple;
	bh=MQCFbZ3T0Cv/Ph/FRR02W3Cr8hDPWbgSkEbNklJIDjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbOmgm//40uul399I1wpdG91okXP5C94D0TyuB3eDKD1PXHUXfy4/vT2RcpMNLhr6ZIxTwAi9gPuqCCqzP+nLi3CQ4WN3naSb6B75yiB7fxeh/ABu2M/99hkhf3o8PHCiDR7FZ+ed0M3R8lMfGn/+Lfd+o6U4T1hrGmL/gQtSls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=kbXdHB8F; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8025500cc7so2452877a12.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779172842; x=1779777642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilstlfRPhBZeYWhJ1uRBmJ2rJZHG0b5shZT6RRPeE68=;
        b=kbXdHB8FKTUVidwzRYhRX4F/IMXm39wwq7483muiFfSgX/7rJoyq4Z4XdRohNgPCBO
         NKeW5rE5Xpb8BMX5ame8X3QUDN4W0xAm3CLFhEs3eaqb9fYMitYvUNArxSP9PMGWRWNk
         jsRYPLW4Jj8HSFoNuyImJlT96VxgPeTOOLMtcpC77/5R7f4E2/5cusKNnEJcaQYXmoP7
         A/W6PExLTdkFTkOiEIziZu8HUs4Ffd2UeNHE9ooqPxaegKrQhU/KdqA4Pqyj187Nql2p
         L4K+npTTPGw5R8eIpawFJGrjhjhWexJAeKLCNQ7saqcohwvwxnP1mm8XmmiP1FQATNSS
         FqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779172842; x=1779777642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilstlfRPhBZeYWhJ1uRBmJ2rJZHG0b5shZT6RRPeE68=;
        b=KxHA8nPP1+Pd6A3ixKYgozDCKQJJ65EcDVCN8i8aNyO4dl6DI45ovn6dBbZPmYzlDv
         wP84jih3BokB7hKR1Cj/O1T8uxUbVdokxgjZFvz08OWS6Rvkl+E5oT01z7d7IwhtffTD
         VtMezO9UjqHv5imeVpcyuLVBxeEVNy1pCgPwj1Xj0aBY38b4BoaMh6ntDMqqfJZ68bPE
         C3HKYGa7Ro6t0xX0VxBjhkgt2faB0tlgPmB7Lm7A4as7eLssM5W8frRfJucD7GiElNA0
         +ogGYyDy+uJHhEYCnggS2qPepSfbFEvNpzuWkXIxrRLsf0tA2yYASp7bbeaB7ciybp1P
         kGzw==
X-Forwarded-Encrypted: i=1; AFNElJ8XhFGTB1t5bgaskUsA3AIwtGjSZKJ9GiujYd6QVezkfCDPKRivPqR2FeWoFt/PH0WFMv0S62Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyafTNvyWVZDBuxWm738edkTGM9b5fCd6aIXdE5ZAOlMi17SM
	Diw6W1wJ9lLbZJ+6r+frYcNOZ+zGMv97ponR0WJgRA+39mwTzuaI1DqMJQXOpnHEwTI=
X-Gm-Gg: Acq92OHXXB7RBDDhNEBCgJIxmCXobGaR9DhYdvuAhkCjiCT5GWHjYfMBupQYc/tMuut
	JmLnin6WdMuekNw7XZVinb0HAR77xD9xBi/tdaf1l7LlOLQGCgcWnZyfB2RyHp2u0JwHwTadZGe
	czXHCYwxrrcXbPfi8Uy2w3TAdx3WLC/ybJ8gaXh9Mhou0rPThVdKz/QpcTIC167i6wxPg5YuOje
	TSukiHAAjYD2AL+7J/jOUUV0vqJzLgUB1RSasC7ERfE36Z+5asrvA+uaPSIhX1srYSwZCZ0aEEe
	5mJ2ZKCgMgP+ktaNR/Mgz/n3by191aYM/bPVPlkuKO1p0DZIaFpYrJDWm/bWTSpaG5yOaph0IIb
	l7cvbZzkFWjPEnaO3YpY5HIyWELVSxJn5hL563h02B1q9VjQZb8NKpD/0MysYb8HRxVXisWQ07W
	1XFzRrvUhLvvGj8CyIYpL4BSqgwzg3WjX5jujD6cLW4LjXnAeB8/PIlRVNRWI3qzgEfiuRZAmmz
	acyQP21TkzJLrw1laRD5Km559JxT0xi4iRLq0l96QCgH3SGXViG2pElag==
X-Received: by 2002:a05:6a20:3d1d:b0:3a1:90ef:7e37 with SMTP id adf61e73a8af0-3b22ebe1b1amr21126082637.33.1779172841901;
        Mon, 18 May 2026 23:40:41 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb0ff0edsm16016589a12.20.2026.05.18.23.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:40:41 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: loic.poulain@oss.qualcomm.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: wwan: iosm: fix potential use after free in ipc_imem_cleanup()
Date: Tue, 19 May 2026 12:10:26 +0530
Message-ID: <20260519064028.60992-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249471-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cse.iitm.ac.in,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,cse.iitm.ac.in:mid,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F3EDB5786A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During cleanup, the ipc_protocol_deinit() is called before the tasklets
are cleaned up. The tasklets may concurrently access the memory
allocated for ipc_protocol and so it could result in a use-after-free.
Fix that by moving ipc_protocol_deinit() after ipc_task_deinit().

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Not tested on hardware.

 drivers/net/wwan/iosm/iosm_ipc_imem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 4405c8531888..939364daf5c7 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1256,8 +1256,8 @@ void ipc_imem_cleanup(struct iosm_imem *ipc_imem)
 	ipc_imem_device_ipc_uninit(ipc_imem);
 	ipc_imem_channel_reset(ipc_imem);
 
-	ipc_protocol_deinit(ipc_imem->ipc_protocol);
 	ipc_task_deinit(ipc_imem->ipc_task);
+	ipc_protocol_deinit(ipc_imem->ipc_protocol);
 
 	kfree(ipc_imem->ipc_task);
 	kfree(ipc_imem->mmio);
-- 
2.43.0


