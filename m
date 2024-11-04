Return-Path: <stable+bounces-89699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFED9BB4B7
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 13:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C4D282E74
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232781BC063;
	Mon,  4 Nov 2024 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ae89BToA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA0469D;
	Mon,  4 Nov 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723525; cv=none; b=hLXbkRamVf/5JzgCkx78Wy60aAD4LUOiJvcnqvXYq9a5+440YmBGoiUnLkVrWroElFIgUsBPrAJXCfUoqBI/wHegXgNuxMF13bEpwSwdK5IxaQwO5Poetvqb/UaroAu4n1q4uEmnY1RU2ismIK5wfhHFCC3HyDE6XMWS7SzwXe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723525; c=relaxed/simple;
	bh=ktXADb2L4YbquYcw8h41zKoCmTKGDsB6Exef3tr4tLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7pYAb65AetgdxlSddPLZft9Y1X9TGqa3RrU/U5dOlJkE5cBYXpPotvHyjg+HidLG8OL7p0SjjHS0LFDpx0//X6SHrFgDr/m5ItimuSllTr3lZ+EGzMJD0+FXYG1JpzR5uUWhF61tIPv8J423ZSddhQdpQSMXB69I8nzvtjatig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ae89BToA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAF2C4CECE;
	Mon,  4 Nov 2024 12:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730723525;
	bh=ktXADb2L4YbquYcw8h41zKoCmTKGDsB6Exef3tr4tLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ae89BToAhjCxhZwnie7U8CKIXAb+aphkCPoUny/eCKQLJTEpHipnqG8cPRKZY4LO5
	 eCTSEO8ZddpISTZVXffrMaRTT4GteIITHMdUWEEj198//nYAdeMrCc0QT3FAlaD/Ke
	 hrHiB2E4OklUnzcE3bhvUeXbgBFrZUWVkFoOLQ1o3IYAXalkiyy+6qgTIYYIFyNbhV
	 M1BSUH1UdpSMHF2Yo2PHL2nuewkdvntl9GufcDu0TxHRa0Sszs7FtO1oyGMaaZfu/R
	 BSAvyOl70Jxfvo6jCbP5c9p6tvCRD/MS0cp7PsiBeVFWlq41gkBlPppX0B5eBDiS+B
	 kYs70ycntZ9vg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 04 Nov 2024 13:31:42 +0100
Subject: [PATCH net 2/2] mptcp: use sock_kfree_s instead of kfree
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-net-mptcp-misc-6-12-v1-2-c13f2ff1656f@kernel.org>
References: <20241104-net-mptcp-misc-6-12-v1-0-c13f2ff1656f@kernel.org>
In-Reply-To: <20241104-net-mptcp-misc-6-12-v1-0-c13f2ff1656f@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MQFc3/F65zsONOCIocs6pTTtcJR1zCiohpdkaVkUFOk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnKL67mTM0SMEyipPfUKA+39u6cKCmZBPUVW7vG
 sce1DgQCh6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZyi+uwAKCRD2t4JPQmmg
 c/dqEAC4H7P2/Z0jPo8xAQdMO1zwOF5GPe0kivOLAWHKj5OsFpu8oVnN00MqomMa8wIdooJYN9i
 7umbdsJj/GUOOyEYCDACG8RCCFcnJyV121msrD/3RsBXJlduOLYHiE3c4VMXdmsqRksh+Vei8AC
 xo+BKBCOtCb1+APUSULhOlK+8c8Gck+6Jz8IjixW9WqU7JGbNx/dMoquBweuRu2ZTiSVQmS202U
 Fht0RJgK9CTfiyyf4zYjkJAfw25fAM+B4HrUWOI7Y2rSIUrk4b9c2INeFEDW9itvkB/uYGPEVbd
 wCQD9hBoGCAaAqP98xP7aQaTp0I9Hxo1hPbPCfHGFZOudZK8MtrD3kPcyd4xKhOLCdoxPHLCJ1F
 xChp1Tse4lF68FnMgD9Ej0MikX15J/L+erkuSXWAWZ2YFYtidjJr+zOR0yMacq3IuVmr6aqzOlv
 gMiUw56WJLotZGOtIDdalWKKZH6M/xva3S3VaTgQlUw/o0ev4DQvr12/FvAzSyPlGCruzbDF7Mm
 nkmlmtq5bBhpqDm17asY7SHehVi7eRb7/OuUCpSK5ENEQ3fNOHr1W/csIy1q3kx/d53noneq9xc
 m7OcWMkgu3dWTscLxSDUObWXbL1jHhpDp9K1K/hYZc0kVOWZzUDA5XySakHCvxUK0UKe4RsrhRz
 lBUaVUlIpFYeUJQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The local address entries on userspace_pm_local_addr_list are allocated
by sock_kmalloc().

It's then required to use sock_kfree_s() instead of kfree() to free
these entries in order to adjust the allocated size on the sk side.

Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2cceded3a83a211ffa83f5511fa16f153b49e6bf..56dfea9862b7b24dd0eaa8bbedcf22a7f6829ccf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -91,6 +91,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct sock *sk = (struct sock *)msk;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
@@ -98,7 +99,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
 			list_del_rcu(&entry->list);
-			kfree(entry);
+			sock_kfree_s(sk, entry, sizeof(*entry));
 			msk->pm.local_addr_used--;
 			return 0;
 		}

-- 
2.45.2


