Return-Path: <stable+bounces-85623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7A99E821
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C6B255F6
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C81F1E378C;
	Tue, 15 Oct 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qanj3RXJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE11C57B1;
	Tue, 15 Oct 2024 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993737; cv=none; b=eckBLT9wNSYYWEUHtdEJ8HDTAIKYFxBZPDzPI5boV1h32QM+jJsuKIvSSpJkgZharUPaq/CTys4Phhr+ChAkeKKmN/oxLPF6+SJSFh+sFpea81wzKR72dnWvhSvKeytXJd8TsPirVSnwQxLWApZNlAAMB7teHtLQLzWotvg961I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993737; c=relaxed/simple;
	bh=3ShOYmdRcq64R4lCMTAfQ/5aw4eu516rlgdB2YKfNE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1BH3fKt5GwCzfscxWLFxnrrzDiABCbZm0DG1iby8q9AY3r5Q296hmE1Bqnyv/p4QIiGmPzhahyuovF9Q/23nSNW1XNSDH6zMS4LABH2gVSiiszcnSaXXI0FfWTyEAley4iEPChRlZ6SJhKYT7uiiRWPTTYxponP6WHOovn+yg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qanj3RXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E215C4CEC6;
	Tue, 15 Oct 2024 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993737;
	bh=3ShOYmdRcq64R4lCMTAfQ/5aw4eu516rlgdB2YKfNE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qanj3RXJ7br8lN6uzkXD2jOWhJMmRWl7cYy37UFO8BFS2HehvSJ+IKqKM3vPGYyzh
	 LgzY0Ca9xvy2QLR906ZmAvZ4Du00O3NfCoVE/NpzynHb5kueH1m1mLls74AxqhibSs
	 e+lDg03SXstoBW9K0dV2hJ8aCwnKtLaX0BXwDgiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Hans P. Moller" <hmoller@uc.cl>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 501/691] ALSA: line6: add hw monitor volume control to POD HD500X
Date: Tue, 15 Oct 2024 13:27:29 +0200
Message-ID: <20241015112500.228242638@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans P. Moller <hmoller@uc.cl>

commit 703235a244e533652346844cfa42623afb36eed1 upstream.

Add hw monitor volume control for POD HD500X. This is done adding
LINE6_CAP_HWMON_CTL to the capabilities

Signed-off-by: Hans P. Moller <hmoller@uc.cl>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20241003232828.5819-1-hmoller@uc.cl
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/line6/podhd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -507,7 +507,7 @@ static const struct line6_properties pod
 	[LINE6_PODHD500X] = {
 		.id = "PODHD500X",
 		.name = "POD HD500X",
-		.capabilities	= LINE6_CAP_CONTROL
+		.capabilities	= LINE6_CAP_CONTROL | LINE6_CAP_HWMON_CTL
 				| LINE6_CAP_PCM | LINE6_CAP_HWMON,
 		.altsetting = 1,
 		.ep_ctrl_r = 0x81,



