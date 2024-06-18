Return-Path: <stable+bounces-52882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7082690CF24
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFDA1C22453
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7313790B;
	Tue, 18 Jun 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1t+2s/D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5413E022;
	Tue, 18 Jun 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714690; cv=none; b=S4ThrHvsTUllKyvAnioKJS+eOLvqxKIr/8tp8NHvUs3rqY8Jj8UfCdYXvzoyyth2d8u4xrLFnsGhv6pfPSh3wq0btxnAOA2/WKaRT45tIF2VVoAOHWX+TQkPB0dMkphuiiVP+3+zDvdcQj9xvaRw4NniJTfv4ZjLNaDDrpUCn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714690; c=relaxed/simple;
	bh=kf6DIaXa+2Ep4GaE8gBYCioVs2ShgpmuLtx2zLjp4hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etDeEEGCkckqqjCJC5P8ZlQ55ApyVzRa/UNW5YaRyN6mKjp6Ni5Bw5+CmmcoXVHugQNnEdlDz9tiSFpaa7B/natmygMH+I13lU6vdOWGHiz70RJA4QAL9XJEvA33YtshiheYAThBgT8HSlqDDT14ywzKW1zEiBPa5i44TTmDy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1t+2s/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025D5C3277B;
	Tue, 18 Jun 2024 12:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714690;
	bh=kf6DIaXa+2Ep4GaE8gBYCioVs2ShgpmuLtx2zLjp4hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x1t+2s/DsTBoZ0wKkqDyViGCN30KAOEMNJDDDBCE58mTOB5ERgezQbhPHj7+Lx8b4
	 Ffdws/hCyk2QGJVf+23JIL9Frerelj1lgKYXmScFH9wkqXM5QBQae+Jz7VoK3MkNZw
	 HOS88bGbyAsiSHIYkd2e99dS8RC8STmWz8NXOlc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 055/770] NFSD: Replace READ* macros in nfsd4_decode_setattr()
Date: Tue, 18 Jun 2024 14:28:28 +0200
Message-ID: <20240618123409.412894564@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 44592fe9479d8d4b88594365ab825f7b07afdf7c ]

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 42d69c0207ce8..cda56ca9ca3fc 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1298,7 +1298,7 @@ nfsd4_decode_setattr(struct nfsd4_compoundargs *argp, struct nfsd4_setattr *seta
 {
 	__be32 status;
 
-	status = nfsd4_decode_stateid(argp, &setattr->sa_stateid);
+	status = nfsd4_decode_stateid4(argp, &setattr->sa_stateid);
 	if (status)
 		return status;
 	return nfsd4_decode_fattr4(argp, setattr->sa_bmval,
-- 
2.43.0




