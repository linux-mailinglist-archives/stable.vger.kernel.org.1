Return-Path: <stable+bounces-36465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3D889C06D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0CFB2ADD5
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97732762DA;
	Mon,  8 Apr 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LX5XOPbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360A2DF73;
	Mon,  8 Apr 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581405; cv=none; b=uJcjaafWPchLX5LkolYmXNAKNXiVSa2mMA12FDozJD12nVrijyVF6lhCjrZHhSVsOOznt7LIwo4TsoI90M5wuQkEcwSO9W7MERFHGYzU8BMxltfnwT+Wqt7THoHbVboCRpzpbQJ5KDUcSQIMEMF+jB+06BWJja+kqz53ivbfgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581405; c=relaxed/simple;
	bh=pyktpuonQeYvpydggD62+vI7bJILeR44fAa3rd9UBxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRomLNK2iOnzQAI+MA8ksYTu3AhLz/yC0iJ63zziRlMWdf6V0WuhwUmxuQLnw41azRbXe2UGii8gvTlhE0Gqjq3kQxPSiCrOrFcGGsGf49lnwwVe6HvJ/8OZmUCxTHTfP0oElz3wks8ZaX6HZZeoceeZK3Gd+Wz8qeVTgVEwSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LX5XOPbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA0FC433C7;
	Mon,  8 Apr 2024 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581405;
	bh=pyktpuonQeYvpydggD62+vI7bJILeR44fAa3rd9UBxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LX5XOPbNWrTHLoSenR0C3nV7+vct7zgGCb8NGw4no/u+861kWt9iesG4jlfKjxJsQ
	 fPt9HMq5U2RdR/ePZpWbGGT+8iMISxz8OJiuRhY5Zqcz3hDp6kpsnulaMx64groQk8
	 atby4GzIIq57P8lSIl78Jjg9EP+LPH05WJnWIVQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/138] tls: adjust recv return with async crypto and failed copy to userspace
Date: Mon,  8 Apr 2024 14:57:09 +0200
Message-ID: <20240408125256.705178193@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 85eef9a41d019b59be7bc91793f26251909c0710 ]

process_rx_list may not copy as many bytes as we want to the userspace
buffer, for example in case we hit an EFAULT during the copy. If this
happens, we should only count the bytes that were actually copied,
which may be 0.

Subtracting async_copy_bytes is correct in both peek and !peek cases,
because decrypted == async_copy_bytes + peeked for the peek case: peek
is always !ZC, and we can go through either the sync or async path. In
the async case, we add chunk to both decrypted and
async_copy_bytes. In the sync case, we add chunk to both decrypted and
peeked. I missed that in commit 6caaf104423d ("tls: fix peeking with
sync+async decryption").

Fixes: 4d42cd6bc2ac ("tls: rx: fix return value for async crypto")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/1b5a1eaab3c088a9dd5d9f1059ceecd7afe888d1.1711120964.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e40f6ed65e6a2..7166c0606527f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2244,6 +2244,9 @@ int tls_sw_recvmsg(struct sock *sk,
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
 					      async_copy_bytes, is_peek, NULL);
+
+		/* we could have copied less than we wanted, and possibly nothing */
+		decrypted += max(err, 0) - async_copy_bytes;
 	}
 
 	copied += decrypted;
-- 
2.43.0




