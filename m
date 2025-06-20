Return-Path: <stable+bounces-155132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC143AE1E16
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533D93A732B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FECA2BD5BF;
	Fri, 20 Jun 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sV7t5IOP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314CC2980D3
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432138; cv=none; b=pnhFXRJ47qBrQuInC2SGyFCBy50Vold++ehLlN52Mq994pc9AQcRPRPd6EFbgFjlU86prPmmDHQTkPC8desXQF0MEBF+AGNfCRwUd3bIQL6UPMnBmtiU4nI2dI7ZDSIRxo85ilr1kOx7/nI14/FOLiqNt4CU1scq46q+boMQCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432138; c=relaxed/simple;
	bh=avr5+OhKDVuAlIqMxG8DMTuJZIFFuWufOmT6kpRof0k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tXJ4hWGlWxQvkHi4aSmCNuTt1WOQed7HNbZtIdfOFMUOtepqy6V6OiyOG6N2VVCuCcrZTVjKtV0CvrBh3fcsev1QDKtBZRFG1XyHfzwr6b3Z2jDF7GWrIk3lYsB0Y/bt+9HJpXenGeQUHld4+Q+WEh08uoF26QL0RQRWFDemzdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sV7t5IOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46697C4CEEF;
	Fri, 20 Jun 2025 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432137;
	bh=avr5+OhKDVuAlIqMxG8DMTuJZIFFuWufOmT6kpRof0k=;
	h=Subject:To:Cc:From:Date:From;
	b=sV7t5IOPQh4Wi1YWWDZyRR6Awd27JBRVtchVO55iMh+rrcf6zqa4bNId3uhnc3gBv
	 ZWUwkkGCsKjUXXohyFWsHLOXLkFwOuZir7mcUoWKPRzw3fMfVZrAcYGV1sSLNfO2aE
	 R+1Pw5uZFwisBzV6xkbkShIKNHY4v5iyTCzH7NNQ=
Subject: FAILED: patch "[PATCH] cifs: deal with the channel loading lag while picking" failed to apply to 6.1-stable tree
To: sprasad@microsoft.com,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:08:54 +0200
Message-ID: <2025062054-luminance-hacker-c550@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 66d590b828b1fd9fa337047ae58fe1c4c6f43609
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062054-luminance-hacker-c550@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66d590b828b1fd9fa337047ae58fe1c4c6f43609 Mon Sep 17 00:00:00 2001
From: Shyam Prasad N <sprasad@microsoft.com>
Date: Mon, 2 Jun 2025 22:37:12 +0530
Subject: [PATCH] cifs: deal with the channel loading lag while picking
 channels

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

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 266af17aa7d9..191783f553ce 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1018,14 +1018,16 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
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
 
@@ -1042,17 +1044,15 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
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


