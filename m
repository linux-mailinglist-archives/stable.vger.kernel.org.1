Return-Path: <stable+bounces-49877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5BA8FEF39
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBBC1F21E5C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2AC1CB322;
	Thu,  6 Jun 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="evHHmtlv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7151A2570;
	Thu,  6 Jun 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683755; cv=none; b=TaUpxZeOQ7krBIVcA07VtwuzKyRu6WOf4I72zi8QtugvsrsA3IN1p2PcW1fLJNMyGSGor7GOvWwx+CMi5g39nmhNYeBdsripCjC9R6QW2ojsGdjdgeVTiQXo5OwiRjjen4JH+EQEKljNOjIHcoa3NJq1MEwtm4s++QWQMHa9Suo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683755; c=relaxed/simple;
	bh=CqwSdnK5L3X5HgkUdpJFlMDChQJ3ICh998Ved70xfxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkSiaflm8MUlU9i1asaIAaSzyMzrRggugzgKA4od6n2jBANXQSHpssbegYLVtAKeKwYYMmLKIKWHOdqyslCLRK+T70ypUCyoX/xPGwqKVa+99sODGgw00C1L16cA0Gu9zyt8VPhaMKTt0f8MFo95vsTg97AU5gAPwxW675NQVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=evHHmtlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4847EC2BD10;
	Thu,  6 Jun 2024 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683755;
	bh=CqwSdnK5L3X5HgkUdpJFlMDChQJ3ICh998Ved70xfxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=evHHmtlvZu8571TlnTuGYkwzzvCA+CeOpHKat4ka5u1vz1yBQYOT+XyKeXrw3zWyn
	 bSWqsXQKJ6R2mcI1pVXA424D8BlbCEx7KnhZVwlJ1ID9v4jbHrqr+4wg2ieZM3bCkd
	 Dhmnq1RThSTHaLjcr+dpqITjlnzOVW/udSJIC0mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 727/744] ALSA: seq: Fix yet another spot for system message conversion
Date: Thu,  6 Jun 2024 16:06:39 +0200
Message-ID: <20240606131755.785408208@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 700fe6fd093d08c6da2bda8efe00479b0e617327 ]

We fixed the incorrect UMP type for system messages in the recent
commit, but it missed one place in system_ev_to_ump_midi1().
Fix it now.

Fixes: e9e02819a98a ("ALSA: seq: Automatic conversion of UMP events")
Fixes: c2bb79613fed ("ALSA: seq: Fix incorrect UMP type for system messages")
Link: https://lore.kernel.org/r/20240530101044.17524-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_ump_convert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index f5d22dd008426..903a644b80e25 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -729,6 +729,7 @@ static int system_ev_to_ump_midi1(const struct snd_seq_event *event,
 				  union snd_ump_midi1_msg *data,
 				  unsigned char status)
 {
+	data->system.type = UMP_MSG_TYPE_SYSTEM; // override
 	data->system.status = status;
 	return 1;
 }
-- 
2.43.0




