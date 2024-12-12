Return-Path: <stable+bounces-102232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8560E9EF18F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5358188B7FE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0205C213E6B;
	Thu, 12 Dec 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="18xo2yiI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFF23694F;
	Thu, 12 Dec 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020476; cv=none; b=LnnP2bQag/t7Wc8NBlSOPpZlh9Pi4bOT5ZOajVs621Pc06sWHlU+MTLz9dBKlRJBirvDHP2Y6EYinfFMscfnwsykhQKG5eApsK4NvnvtHCErY5TIymQQEDJsUDqEgdHvYodCaCe7P/UtKEpxyH2lJ1BjV9Z9IW+tpfafiDnkohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020476; c=relaxed/simple;
	bh=ROpecMe8uNY3rrpl6ggpcU4bPiKJfDHk9bcm9O1sdZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idWgYolmUsoZBSRssujKmGKAuBFDGgic1Wcmoio138SmzfIGoaSR8kWsplORMwofa91gnB9zdBC1LwbZdKc6PzjCBmHBKtvdZKchbszAtTUwS91LhNL1UjPAsu4VhNx1RiRcqjU6Esu7Za6KbfzYh2GtApBaBDN+USfg+/masWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=18xo2yiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209C6C4CECE;
	Thu, 12 Dec 2024 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020476;
	bh=ROpecMe8uNY3rrpl6ggpcU4bPiKJfDHk9bcm9O1sdZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=18xo2yiI5OqXjiQU15EquiA3/8sHLNP2KWlUDv2ROsFG1RJ9I6DkoNk4nAMiRvQ+r
	 rMQBvykjytuIDA+0tcJ9GsWWGJzCE985DbjSWyBPqH1IqOIyo4ShWbThd9h1ZY39gM
	 VzuWN8RXrKDBIkiiOJ6RQ6GvLxhkv4xgg7jcaD0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.1 476/772] leds: lp55xx: Remove redundant test for invalid channel number
Date: Thu, 12 Dec 2024 15:57:01 +0100
Message-ID: <20241212144409.602251437@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Vokáč <michal.vokac@ysoft.com>

commit 09b1ef9813a0742674f7efe26104403ca94a1b4a upstream.

Since commit 92a81562e695 ("leds: lp55xx: Add multicolor framework
support to lp55xx") there are two subsequent tests if the chan_nr
(reg property) is in valid range. One in the lp55xx_init_led()
function and one in the lp55xx_parse_common_child() function that
was added with the mentioned commit.

There are two issues with that.

First is in the lp55xx_parse_common_child() function where the reg
property is tested right after it is read from the device tree.
Test for the upper range is not correct though. Valid reg values are
0 to (max_channel - 1) so it should be >=.

Second issue is that in case the parsed value is out of the range
the probe just fails and no error message is shown as the code never
reaches the second test that prints and error message.

Remove the test form lp55xx_parse_common_child() function completely
and keep the one in lp55xx_init_led() function to deal with it.

Fixes: 92a81562e695 ("leds: lp55xx: Add multicolor framework support to lp55xx")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Link: https://lore.kernel.org/r/20241017150812.3563629-1-michal.vokac@ysoft.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/leds-lp55xx-common.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -580,9 +580,6 @@ static int lp55xx_parse_common_child(str
 	if (ret)
 		return ret;
 
-	if (*chan_nr < 0 || *chan_nr > cfg->max_channel)
-		return -EINVAL;
-
 	return 0;
 }
 



