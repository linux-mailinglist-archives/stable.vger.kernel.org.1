Return-Path: <stable+bounces-17687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA58477F5
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 19:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29D31C2484F
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 18:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921AD81746;
	Fri,  2 Feb 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn9YKNnx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC1A8173C;
	Fri,  2 Feb 2024 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899186; cv=none; b=EZiLpxdHQAREia5wJogTAVM/3autd0nVuSxsPkcWiOKUBfUAD9qMJbo7wj30supQowCb3+haS6ye7YrSxRxPpi1X/U7rjqhj+O9JHYCcDuTIgY+bNGahgybvCuMkHXViJ2REcdmbn5ApAU3SOGIpQyo4BeinfifrVGUQkq7sw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899186; c=relaxed/simple;
	bh=Qr+fqsk161MORGjbj+AuRQbkUHTaVTmpVbjLBFAYQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dY2S0Gdj32usBl1ygXoCrs8vBhvPyGaj6W53M0gqCpRlRfLV0zITO0SBzUKEUAclVXKhDky5Welju2Jp0eOYXDidQqp3J0BwjTO42pGEaVaFBbT0eZUFRYtJ4VLEGS+OdZbHJOQ08B5L1/e0RVBOdd7EJEKNvDQY5YiAYow6x2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn9YKNnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF719C433C7;
	Fri,  2 Feb 2024 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899185;
	bh=Qr+fqsk161MORGjbj+AuRQbkUHTaVTmpVbjLBFAYQIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zn9YKNnxdit6ujgi1j4uIgcJW9PwOMjM/XvYFrSsYPLJSx1sUr5xwnBKcbmYyyEDw
	 Evbywt/6CIOIPAhuIuwad2C9XnPtO63s5BquEt7IYihSyTJqao8zz80YszdkxPhrC0
	 VXA47Mm+kVUyRGWD+rh5uZENSgkBu0r7LRxpIgmhLcTJFVO6E3ZLy4aMYooGvLoAkR
	 EdB0ikqzMc+IHEGOzxmLQZTU3zYOO8QXWGZNYO5AlCtfyA5aejriFFBefe4ckARuzt
	 qilXm85V2FyNP7lmbMbwV5W3tMREwGYHbtuvsY2mjoUtiWUM0wHFNL2JsxlQqqRdM9
	 xQfwvlOyaAF3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.7 12/23] cifs: cifs_pick_channel should try selecting active channels
Date: Fri,  2 Feb 2024 13:39:08 -0500
Message-ID: <20240202183926.540467-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit fc43a8ac396d302ced1e991e4913827cf72c8eb9 ]

cifs_pick_channel today just selects a channel based
on the policy of least loaded channel. However, it
does not take into account if the channel needs
reconnect. As a result, we can have failures in send
that can be completely avoided.

This change doesn't make a channel a candidate for
this selection if it needs reconnect.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 4f717ad7c21b..8695c9961f5a 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1026,6 +1026,9 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 		if (!server || server->terminate)
 			continue;
 
+		if (CIFS_CHAN_NEEDS_RECONNECT(ses, i))
+			continue;
+
 		/*
 		 * strictly speaking, we should pick up req_lock to read
 		 * server->in_flight. But it shouldn't matter much here if we
-- 
2.43.0


