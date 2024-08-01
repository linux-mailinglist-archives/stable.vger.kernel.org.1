Return-Path: <stable+bounces-65159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09E943F46
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A471C21AFC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929A21E2133;
	Thu,  1 Aug 2024 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXI2cbPV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BC1E212B;
	Thu,  1 Aug 2024 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472691; cv=none; b=RY9AFukulDyhvsVZVLpwxVu0fvGWZpP2tfyLFQhfAqsi91ZIQY0zjt6WrSDgsEaSZ/zQ4/ar5GCFQXmW3Vch52Y8uXojdXQVtYaO1jMZwBccZrqhej5Ir6oKECO381aUs+zLGwP+nTKYa+NvyGyiFTILZszKPqjVM+xlMabErG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472691; c=relaxed/simple;
	bh=TkoEEKu1ztIP3gH5y6xT1oaAiTIPLr4A2ziDkNQc/EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0s17Bw0xRyA/dh4GrDwI80P4/9mQDtpc4RJ657I0PtnmhviITkw/6GKgZg8omlm4uhz+X3CyWt4FvdENjlYr1lNR7wmIzZUtg+iAhqxHVALQz66r9mQI2dll/MDrYgz63I31VrqeCijDU3a16rIv0uvfck1tvscJZS+m4pLBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXI2cbPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C69EC4AF0C;
	Thu,  1 Aug 2024 00:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472691;
	bh=TkoEEKu1ztIP3gH5y6xT1oaAiTIPLr4A2ziDkNQc/EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXI2cbPVNox6i7XoFlctrd+TLJvOZJ5OneiQ8RJTMMUhyX091vN5sSNWlt005YKTn
	 DlY9Fyv9LZMEmzAmUQco0YwyHH1nyQXQ34tOaEf+HfTICU7oUHsPiaDyKZO2r7qeFC
	 0uDKDOnxj8xI3o3bMe5ri642k2Mfubf6pB/WRv6ktaHAHIz93PtoLdl7tNhX4T+sc/
	 SEwklfseA/DMB2Np1G2QtKx3EDO9YSO2eLIsLIfPTvSDzh634KwyR8WNh3YaHboJgF
	 cHSqSsO8bn3AJhxGCw3aJjqdpGl41PI6q6+/yc6acVxx/3YSsCaaFymh1mMZn6LjNi
	 31XOF33YhstPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Casey Schaufler <casey@schaufler-ca.com>,
	Konstantin Andreev <andreev@swemel.ru>,
	Sasha Levin <sashal@kernel.org>,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 22/38] smack: tcp: ipv4, fix incorrect labeling
Date: Wed, 31 Jul 2024 20:35:28 -0400
Message-ID: <20240801003643.3938534-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Casey Schaufler <casey@schaufler-ca.com>

[ Upstream commit 2fe209d0ad2e2729f7e22b9b31a86cc3ff0db550 ]

Currently, Smack mirrors the label of incoming tcp/ipv4 connections:
when a label 'foo' connects to a label 'bar' with tcp/ipv4,
'foo' always gets 'foo' in returned ipv4 packets. So,
1) returned packets are incorrectly labeled ('foo' instead of 'bar')
2) 'bar' can write to 'foo' without being authorized to write.

Here is a scenario how to see this:

* Take two machines, let's call them C and S,
   with active Smack in the default state
   (no settings, no rules, no labeled hosts, only builtin labels)

* At S, add Smack rule 'foo bar w'
   (labels 'foo' and 'bar' are instantiated at S at this moment)

* At S, at label 'bar', launch a program
   that listens for incoming tcp/ipv4 connections

* From C, at label 'foo', connect to the listener at S.
   (label 'foo' is instantiated at C at this moment)
   Connection succeedes and works.

* Send some data in both directions.
* Collect network traffic of this connection.

All packets in both directions are labeled with the CIPSO
of the label 'foo'. Hence, label 'bar' writes to 'foo' without
being authorized, and even without ever being known at C.

If anybody cares: exactly the same happens with DCCP.

This behavior 1st manifested in release 2.6.29.4 (see Fixes below)
and it looks unintentional. At least, no explanation was provided.

I changed returned packes label into the 'bar',
to bring it into line with the Smack documentation claims.

Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8c790563b33ac..88bcda1f07bff 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4228,7 +4228,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	rcu_read_unlock();
 
 	if (hskp == NULL)
-		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
+		rc = netlbl_req_setattr(req, &ssp->smk_out->smk_netlabel);
 	else
 		netlbl_req_delattr(req);
 
-- 
2.43.0


