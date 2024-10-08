Return-Path: <stable+bounces-82632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47013994DB6
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781981C246F4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F2F1DF27C;
	Tue,  8 Oct 2024 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y3VBxw1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD51DF279;
	Tue,  8 Oct 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392903; cv=none; b=G8glwRqXP+FpMVcpWBK2yeMlDPcFFga4fVwnxC5q/Oqm2wpatBaU8EPggBbn7e5byOuISDiANDG634x2O7gbL8Np6OQECQ3wndYOPnpxVDD6wx0LSsobNhbKvM8blVFLJqnyhq1PMkp8crocUX8ElRbu+r6mruVY4fduYLHlJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392903; c=relaxed/simple;
	bh=XnWAVRXfk/YXgGTkQKefavdcJBWPRNf6imD0o8ZLojo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWyWE9kXdn8fi1sEAFGEk54Jjn+BuoLPo2BOns3/O/PEgZBsoZm/8kKErr1H6xiYKYRfF2LtOMRuYHT7ck/EvY47XTqulfNrLYWKgxNW5KkPDNNNgQVi4ElbSITRa8VMjZioVrGAd5x9xHPqjcP6ccLfORd8aJqLi+RSUVVUnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y3VBxw1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43553C4CEC7;
	Tue,  8 Oct 2024 13:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392903;
	bh=XnWAVRXfk/YXgGTkQKefavdcJBWPRNf6imD0o8ZLojo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y3VBxw1p/PIClnrwkPWY7sq3udlLMxzZdQ5qJsfY8WiihsF8wfgV1KA8mpcTqdUyQ
	 I0h0IN3ytVHWdeqeSqrUi2zogn3M2w4MiOYUYbR8u8e202QeTPxUehBErtUVbBKacD
	 /tu3yK9pFVEJ21B3E9YjOIKPQMy85E0TQBHJHAdQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.11 554/558] ALSA: control: Fix leftover snd_power_unref()
Date: Tue,  8 Oct 2024 14:09:44 +0200
Message-ID: <20241008115724.033345014@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit fef1ac950c600ba50ef4d65ca03c8dae9be7f9ea upstream.

One snd_power_unref() was forgotten and left at __snd_ctl_elem_info()
in the previous change for reorganizing the locking order.

Fixes: fcc62b19104a ("ALSA: control: Take power_ref lock primarily")
Link: https://github.com/thesofproject/linux/pull/5127
Link: https://patch.msgid.link/20240801064203.30284-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/control.c |    1 -
 1 file changed, 1 deletion(-)

--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1168,7 +1168,6 @@ static int __snd_ctl_elem_info(struct sn
 	info->access = 0;
 #endif
 	result = kctl->info(kctl, info);
-	snd_power_unref(card);
 	if (result >= 0) {
 		snd_BUG_ON(info->access);
 		index_offset = snd_ctl_get_ioff(kctl, &info->id);



