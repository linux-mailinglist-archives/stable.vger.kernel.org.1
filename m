Return-Path: <stable+bounces-17281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CB84108C
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E715028728D
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ADF15B985;
	Mon, 29 Jan 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VriH4QfY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058515FB05;
	Mon, 29 Jan 2024 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548643; cv=none; b=c1mLKLSmhljQEmU4l9GyBq5V7/EQcDukhLotOgiyG7FbUNISocs4nsMtveifIgYxG1Ag3V7bmiYeQSyvYRalvFoBhWht4HlMNLHM1YzMziGUwt1KQKb3/2rKNG8WEGgxJsouvn5mgXh6NupxIYYGPWxfx2l+BdmFTwopJeqIMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548643; c=relaxed/simple;
	bh=BLW0I0YKixMD+UhTRLAKUJ/1gt5d8Sk4zGiydVP2u+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbCqEr8uWHRRaXQBrxakKQWPN2Pb8P7iLSWwoeQ7/bycJsVzw/DrZW2NEu1LexPkglGvaopIji7euhaZgIFVM/Cf0EClMj5PcBMHQM83u9aO7j7oMerwWXL9iN5CzPgM2CVppUquRlGb0yKLYeLk5YABsaotNO9wVFGlY64JEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VriH4QfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BFAC433F1;
	Mon, 29 Jan 2024 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548643;
	bh=BLW0I0YKixMD+UhTRLAKUJ/1gt5d8Sk4zGiydVP2u+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VriH4QfYjpn8C7M44r65l0G376o2uwmSmvfjhfQPL0VAVisnDNMH0RwXfQDdXit99
	 mQCK5/ahjKNtvjrxjeArEKa0roEU6JDxXtYn9ksXMLYlhIMEqb0QeRcLZ/9PAIEAu6
	 ZxrZwyZCBmJAMD933vZWjrdRTO0iAXPc8jDJoUpQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 320/331] cifs: fix stray unlock in cifs_chan_skip_or_disable
Date: Mon, 29 Jan 2024 09:06:24 -0800
Message-ID: <20240129170024.245624889@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 993d1c346b1a51ac41b2193609a0d4e51e9748f4 ]

A recent change moved the code that decides to skip
a channel or disable multichannel entirely, into a
helper function.

During this, a mutex_unlock of the session_mutex
should have been removed. Doing that here.

Fixes: f591062bdbf4 ("cifs: handle servers that still advertise multichannel after disabling")
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index bfec2ca0f4e6..f5006aa97f5b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -195,7 +195,6 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
 		pserver = server->primary_server;
 		cifs_signal_cifsd_for_reconnect(pserver, false);
 skip_terminate:
-		mutex_unlock(&ses->session_mutex);
 		return -EHOSTDOWN;
 	}
 
-- 
2.43.0




