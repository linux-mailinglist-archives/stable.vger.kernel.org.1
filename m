Return-Path: <stable+bounces-77615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF96985F27
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF721C25CD2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4A21F410;
	Wed, 25 Sep 2024 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC7zksRX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0E21F407;
	Wed, 25 Sep 2024 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266485; cv=none; b=gLp3b0OP2xMMj62561xsMSQJdSIG7bnBFQbENpZ2mvYAKGHusvEfu/ZRCprYCJJM+4WfB3+HiB8R6Zull3Yxmdq/ZD6RipGFQrZop77TtGL4Oh0ssrFllc2KUkthCsp41OXMwNF6x42zS0+z5Uc8rL4VjwIXRipQfQkFdwvtLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266485; c=relaxed/simple;
	bh=4kStu5cFgDRLN5FvWQV8v4gaCJQ4kcCDjuaA2FKp+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUgn2JHztn0aLsa512KmWud0IMZdinb3lBd8bvsU8spOrML+yrzUgr8R4lBRsXiyWm2iv5sf/Khv46iaaGbPMAvzJh7GI7x7TLa8JSqdiRPzCQqL4BaTK60ZqGkGRVrSbpeynWEqG7UeSbMCQh/0Rfz0gIgBDjqnybc9kgg0a7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC7zksRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553D5C4CEC3;
	Wed, 25 Sep 2024 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266485;
	bh=4kStu5cFgDRLN5FvWQV8v4gaCJQ4kcCDjuaA2FKp+9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BC7zksRXKBdEHNdK+Fa32lWZ3HnZYnWoQ5p30KZj6SIW2FOHPcsWH+3rqtCgjPU+Q
	 5Mc+QVicRkWV84HQTvv2Z8zZsc0roqvUmwooroaT+C5RQurTrtvhGRPcXA/QLRVr7b
	 vNZlu3zVX6ArThoijErEJiELCZVaLCsA9ei6VdgJTvTf288qTHvnztqdPyW7V9DjcE
	 DDsjvGcGhkz6z+2GWfATLkfklUFFWFsC5ZU5tbfjwGic0R4nZlE6nEhY3tC0o2L9ZG
	 rTBXAemssE2GnxQsSHisMT5de2rDc69oDhDceda6esSaUYx7J/t4OohpogCFtO9iUV
	 ti4RaCm2ReP6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 068/139] ALSA: asihpi: Fix potential OOB array access
Date: Wed, 25 Sep 2024 08:08:08 -0400
Message-ID: <20240925121137.1307574-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7b986c7430a6bb68d523dac7bfc74cbd5b44ef96 ]

ASIHPI driver stores some values in the static array upon a response
from the driver, and its index depends on the firmware.  We shouldn't
trust it blindly.

This patch adds a sanity check of the array index to fit in the array
size.

Link: https://patch.msgid.link/20240808091454.30846-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/asihpi/hpimsgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index d0caef2994818..b68e6bfbbfbab 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -708,7 +708,7 @@ static u16 HPIMSGX__init(struct hpi_message *phm,
 		phr->error = HPI_ERROR_PROCESSING_MESSAGE;
 		return phr->error;
 	}
-	if (hr.error == 0) {
+	if (hr.error == 0 && hr.u.s.adapter_index < HPI_MAX_ADAPTERS) {
 		/* the adapter was created successfully
 		   save the mapping for future use */
 		hpi_entry_points[hr.u.s.adapter_index] = entry_point_func;
-- 
2.43.0


