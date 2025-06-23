Return-Path: <stable+bounces-157261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BB8AE5330
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B378188CC99
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF8223DE5;
	Mon, 23 Jun 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="es6dYSXa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A32222C2;
	Mon, 23 Jun 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715436; cv=none; b=czZ8m8sm8hczQNUtxMXCi0tMRm+DENYzPONRI8bKs1BNAHbSkf/3WtrN1uXtgH7n0vorkuau0E4rA7KcR7Yoi/WK6Kcuh+vPrhHbX7GGsyiPuuWI8GVbn5gJId/32RobwqenQ/rtOU1PVP9alyAKri80RIUROlAgWRtE8dSlKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715436; c=relaxed/simple;
	bh=GkxsvDIq5AtESo7A4XNveNWGHtV0gH1y7bBx5Bd7o7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juzx9Xfu4V9KzYFSPYgmmekP3erZDpTFfq63lSRGyLqnbTGok2MIH1aTIw7TUlAp+XBvRVojSIEHvElaIVd7bxigbmadxfaj+Ge0EIImffOuIkyzvW6R5Cycg7sOBXuAPWgsDnlc6I8IIb5nqdjKBnkcJRctFgvH0sR0LLI9RM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=es6dYSXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA36C4CEF1;
	Mon, 23 Jun 2025 21:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715435;
	bh=GkxsvDIq5AtESo7A4XNveNWGHtV0gH1y7bBx5Bd7o7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=es6dYSXamSTGywSS/fusqenqcpE1euEMPaVsNqsHCl3UD62IQ0mn58O1Fo4TawtHY
	 ETvuutNe42fAtvclM1a8UhXFVi6X97akKV3l5TgIV7wK2+yJ+ANL41KI34BJXx5RL8
	 yXRgFfuoxmUsduzDVotwIj6hPXIW+YuTAGMrQ7sc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.15 458/592] cifs: deal with the channel loading lag while picking channels
Date: Mon, 23 Jun 2025 15:06:56 +0200
Message-ID: <20250623130711.323524488@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit 66d590b828b1fd9fa337047ae58fe1c4c6f43609 upstream.

Our current approach to select a channel for sending requests is this:
1. iterate all channels to find the min and max queue depth
2. if min and max are not the same, pick the channel with min depth
3. if min and max are same, round robin, as all channels are equally loaded

The problem with this approach is that there's a lag between selecting
a channel and sending the request (that increases the queue depth on the channel).
While these numbers will eventually catch up, there could be a skew in the
channel usage, depending on the application's I/O parallelism and the server's
speed of handling requests.

With sufficient parallelism, this lag can artificially increase the queue depth,
thereby impacting the performance negatively.

This change will change the step 1 above to start the iteration from the last
selected channel. This is to reduce the skew in channel usage even in the presence
of this lag.

Fixes: ea90708d3cf3 ("cifs: use the least loaded channel for sending requests")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/transport.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1018,14 +1018,16 @@ struct TCP_Server_Info *cifs_pick_channe
 	uint index = 0;
 	unsigned int min_in_flight = UINT_MAX, max_in_flight = 0;
 	struct TCP_Server_Info *server = NULL;
-	int i;
+	int i, start, cur;
 
 	if (!ses)
 		return NULL;
 
 	spin_lock(&ses->chan_lock);
+	start = atomic_inc_return(&ses->chan_seq);
 	for (i = 0; i < ses->chan_count; i++) {
-		server = ses->chans[i].server;
+		cur = (start + i) % ses->chan_count;
+		server = ses->chans[cur].server;
 		if (!server || server->terminate)
 			continue;
 
@@ -1042,17 +1044,15 @@ struct TCP_Server_Info *cifs_pick_channe
 		 */
 		if (server->in_flight < min_in_flight) {
 			min_in_flight = server->in_flight;
-			index = i;
+			index = cur;
 		}
 		if (server->in_flight > max_in_flight)
 			max_in_flight = server->in_flight;
 	}
 
 	/* if all channels are equally loaded, fall back to round-robin */
-	if (min_in_flight == max_in_flight) {
-		index = (uint)atomic_inc_return(&ses->chan_seq);
-		index %= ses->chan_count;
-	}
+	if (min_in_flight == max_in_flight)
+		index = (uint)start % ses->chan_count;
 
 	server = ses->chans[index].server;
 	spin_unlock(&ses->chan_lock);



