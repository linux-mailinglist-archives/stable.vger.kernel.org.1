Return-Path: <stable+bounces-93915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17E9D1F62
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1811A1F22788
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA885149C57;
	Tue, 19 Nov 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiiNLbh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0FC1459F6
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731991011; cv=none; b=gQs8r845AHTTrPUy/MbJhYyXPg5Pzg54YQMAHZmgx3OifEvL4c84kiPIz/3sXEywzDdkG6ncpNxSI2SHNlcTCKKJljgcs/0HphGCfZEeAVcoEg+pgPhTMcl3Td0gLq04qdNou5ZZ9SqGfhxS2rxzvkCs/LfZnUKjiHtfGyS1H84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731991011; c=relaxed/simple;
	bh=eo+7c0qDXEZZH2RhSc0QGz1aYIKL8VHJNkyf8qHmnC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHZGk4QwY1+F/u5Z+XsckpQzyfBp0C499Ooa847usF/iEoGSsO0d3zk/cKmpyn3fet3FeNrQKMJrH4BJxVn+s3NjtNLRHa/21ZeT/fZKHYv3UySr7MOlKby3dnIOaLtl+JilakzuClMt4AXhaCNVnoF3IuS9CTq5HxN01xbNzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiiNLbh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE0CC4CED2;
	Tue, 19 Nov 2024 04:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731991011;
	bh=eo+7c0qDXEZZH2RhSc0QGz1aYIKL8VHJNkyf8qHmnC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiiNLbh0K4MmQgUZSPExk2aalHdXeVE0DPmQ6DVqzi0sdgsfKWkunI5FAwKLBy6S5
	 qOQk/Uik3jueQ8BNBicUu9YavngpzwOlZAMbaqyCqP3gx/eedJxVKlupPV6d8zBM8+
	 jjBWEbnIDpu2Kj3wTXJAnEG55UhDff86tMCuohAND25nkR8qcTYOAm/sJW0g6SoKA0
	 v80g6v81hlPut2RfWJzIZElcL8V+gnGFRZqUDloHMkFtpCjGSBK1AcUIwJJVnWWYDK
	 9xczFGAwcRf9QTpHT5G1LyrwyhBvVrwfmmeF3sTT6qRfwvAe3ladTgVBZ7VdbXTkb6
	 22nfJAHZAo7lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Bluetooth: ISO: Fix not validating setsockopt user input
Date: Mon, 18 Nov 2024 23:36:49 -0500
Message-ID: <20241118073726.1726166-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118073726.1726166-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 9e8742cdfc4b0e65266bb4a901a19462bda9285e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Present (different SHA1: 6a6baa1ee7a9)      |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 16:19:25.499178298 -0500
+++ /tmp/tmp.RbdMAtXjGb	2024-11-18 16:19:25.492023976 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 9e8742cdfc4b0e65266bb4a901a19462bda9285e ]
+
 Check user input length before copying data.
 
 Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
@@ -5,24 +7,27 @@
 Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
 Signed-off-by: Eric Dumazet <edumazet@google.com>
 Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu:  Bp to fix CVE: CVE-2024-35964 resolved minor conflicts]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
- net/bluetooth/iso.c | 36 ++++++++++++------------------------
- 1 file changed, 12 insertions(+), 24 deletions(-)
+ net/bluetooth/iso.c | 32 ++++++++++----------------------
+ 1 file changed, 10 insertions(+), 22 deletions(-)
 
 diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
-index d24148ea883c4..ef0cc80b4c0cc 100644
+index 27efca5dc7bb..ff15d5192768 100644
 --- a/net/bluetooth/iso.c
 +++ b/net/bluetooth/iso.c
-@@ -1500,7 +1500,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
+@@ -1189,7 +1189,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
  			       sockptr_t optval, unsigned int optlen)
  {
  	struct sock *sk = sock->sk;
 -	int len, err = 0;
 +	int err = 0;
- 	struct bt_iso_qos qos = default_qos;
+ 	struct bt_iso_qos qos;
  	u32 opt;
  
-@@ -1515,10 +1515,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
+@@ -1204,10 +1204,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
  			break;
  		}
  
@@ -35,40 +40,28 @@
  
  		if (opt)
  			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-@@ -1527,10 +1526,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
- 		break;
- 
- 	case BT_PKT_STATUS:
--		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
--			err = -EFAULT;
-+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
-+		if (err)
- 			break;
--		}
- 
- 		if (opt)
- 			set_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
-@@ -1545,17 +1543,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
+@@ -1222,18 +1221,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
  			break;
  		}
  
 -		len = min_t(unsigned int, sizeof(qos), optlen);
--
--		if (copy_from_sockptr(&qos, optval, len)) {
--			err = -EFAULT;
+-		if (len != sizeof(qos)) {
+-			err = -EINVAL;
 -			break;
 -		}
 -
--		if (len == sizeof(qos.ucast) && !check_ucast_qos(&qos)) {
--			err = -EINVAL;
+-		memset(&qos, 0, sizeof(qos));
+-
+-		if (copy_from_sockptr(&qos, optval, len)) {
+-			err = -EFAULT;
 +		err = bt_copy_from_sockptr(&qos, sizeof(qos), optval, optlen);
 +		if (err)
  			break;
 -		}
  
- 		iso_pi(sk)->qos = qos;
- 		iso_pi(sk)->qos_user_set = true;
-@@ -1570,18 +1560,16 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
+ 		if (!check_qos(&qos)) {
+ 			err = -EINVAL;
+@@ -1252,18 +1242,16 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
  		}
  
  		if (optlen > sizeof(iso_pi(sk)->base)) {
@@ -92,3 +85,6 @@
  
  		break;
  
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

