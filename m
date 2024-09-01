Return-Path: <stable+bounces-71915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35F1967854
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533A4B2077A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312A17E00C;
	Sun,  1 Sep 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hgW9mjTk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE25381A;
	Sun,  1 Sep 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208238; cv=none; b=rOenVgOuy0eS0/N4DvRDF49wCS/+RBp1+sfN+P4QiLx7NM5VUUUBJJoI2nxnbTlZrzsiFkOFjCOBulTPsH2qQaCsZYLaPrbjJHWHm2mlo1D4z/G4yHIISVblPmhTUsSdRNc6Nb9Pg3hQwKydp39Iapu6csGmiu6OQCG9DiHnGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208238; c=relaxed/simple;
	bh=Xq8AxDe3ODyhsEpAHsMoPoYqsBWHGIFPBL+HO3xDgrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPG+fvkAfu7qNTktdtUk7oNenop5nbbpMFuovwBSEpQ2z/whZ5UkUJ7WLWgO517Bkv03mY6jkAPZ9khm90vzsE69+6IMg5SoRa9O51oiYgbQ/MsxODttIhxnbk47FSwBKR6xhmuQ87sxQmaM91LFTyUit7yPzMNMu+T049Q1Sn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hgW9mjTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3B3C4CEC3;
	Sun,  1 Sep 2024 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208237;
	bh=Xq8AxDe3ODyhsEpAHsMoPoYqsBWHGIFPBL+HO3xDgrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgW9mjTkUiyJ6qZKYR1s7gTsLX37kQCdK/8J+4MXNjKqOzxyCitdOLYk61eUBHmvs
	 NzW8dWIpqb05zvhI2BIVCEnHE3ulicbagsNnCePKt3QL9hwUPDHNrAAprBoH008EOT
	 9oGNUUOMy2NXy2HZFf2yXrEbmhQdgZ/ccdmv6r/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.10 003/149] ALSA: seq: Skip event type filtering for UMP events
Date: Sun,  1 Sep 2024 18:15:14 +0200
Message-ID: <20240901160817.595200510@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 32108c22ac619c32dd6db594319e259b63bfb387 upstream.

UMP events don't use the event type field, hence it's invalid to apply
the filter, which may drop the events unexpectedly.
Skip the event filtering for UMP events, instead.

Fixes: 46397622a3fa ("ALSA: seq: Add UMP support")
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240819084156.10286-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/seq/seq_clientmgr.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -537,6 +537,9 @@ static struct snd_seq_client *get_event_
 		return NULL;
 	if (! dest->accept_input)
 		goto __not_avail;
+	if (snd_seq_ev_is_ump(event))
+		return dest; /* ok - no filter checks */
+
 	if ((dest->filter & SNDRV_SEQ_FILTER_USE_EVENT) &&
 	    ! test_bit(event->type, dest->event_filter))
 		goto __not_avail;



