Return-Path: <stable+bounces-77434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80052985D2F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401AF287986
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEB01DC04F;
	Wed, 25 Sep 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No+oQ5kO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEEC1DC045;
	Wed, 25 Sep 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265763; cv=none; b=DDJI120gFd3xalH8JJVyRszkSmfu0FF1DSFAzTKh2N3UKQehM1U9JjflwXu3s6ZWStgz07OslF1Fjt6W6pz5K5kgMNmR5HJ7QLPeXmurVFYqvLMWqhvw+1fss42pNhe8VTTa9vH5rJQEobJxTKb4/EWJp0XE2EFI2H/Ip9xE9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265763; c=relaxed/simple;
	bh=4kStu5cFgDRLN5FvWQV8v4gaCJQ4kcCDjuaA2FKp+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaocsHeg9bgGdJxqGt3kKlqS0JeygKpEK8F9vFirZ2MC0Ezx45baR/RDkHxa5o9pySZ/rWNfkz1O2PlOymqjBedyEHEyHujm4l49eHjvjOLsSzZHCergoQQpPXQt0MvpO2VlTG/Op3yM+/qDC23F/NRMjb/4tmtW9JchnYvvk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No+oQ5kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEB7C4CEC7;
	Wed, 25 Sep 2024 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265763;
	bh=4kStu5cFgDRLN5FvWQV8v4gaCJQ4kcCDjuaA2FKp+9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=No+oQ5kOld1uCaqvxepfi6bYNqMTgg8rTqWEZhvaodaG3UUUm8nnWqVuG8aegNVFq
	 xaRQhQzf/b0pScMo3Qs9kNq0N13N7pTw1rV774rgW+cUnX9zhlXzVNuqfGulfnofx3
	 4UiAuYYvJ4nlr2RLo85dCyJ/Y8W39c1MHzQY1O+3CmFPvPfnn3dlSafdp0d8cUmcTx
	 54ZZhPuio2OzLu8x6KlvaWD/wSnPSBWbSivd0Z2hsQYhlbnwQsJ+/db5+ExYGYQ9Or
	 xwOc6h+oYwNdXILpsylWfWmJzolaljzEmtFPJSGsPjJls7XZXu3V5pj/sp02fQMOD/
	 mj+cTMtKkK5WA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 089/197] ALSA: asihpi: Fix potential OOB array access
Date: Wed, 25 Sep 2024 07:51:48 -0400
Message-ID: <20240925115823.1303019-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


