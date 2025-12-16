Return-Path: <stable+bounces-202389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF94CC2E1C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3553330B43FF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F203624A7;
	Tue, 16 Dec 2025 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so48KJk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AA362149;
	Tue, 16 Dec 2025 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887741; cv=none; b=Tj+Rm6N9IccJGMYWq8wfCWFVhtIRGDpUo/60QI+eSh8t9ZQ0p2MNqdpjEAm0sNjX95W62Ys1GTLhkNQLJX4EB5y8ioUDQPwHGduPZV+tswLk8LMOVvyRaDIaQNNESISka8kMvH5DFytL/O+H0riYzoaYiDoWu0iGzGRKZjRxMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887741; c=relaxed/simple;
	bh=ZGAC2jnz7q418fOK2D+97qmfw+5fPl8FeUKDfSXMHwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u++Hw/dhOQu02dldN+aJ3gsk7Jz+u9h87uAcojQ4ZF67e7MUMpGZuouQJa/201StFWcp+6ZKsaB0ibgSW/3dj741v1JTaD+3el9qLVvbC68/MiFh10XvRBR0wKDAK4WV00l5GC8Q1agz2iYIM4VdWNnzmJIjTTVtnV4AgxShzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so48KJk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EA2C4CEF1;
	Tue, 16 Dec 2025 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765887741;
	bh=ZGAC2jnz7q418fOK2D+97qmfw+5fPl8FeUKDfSXMHwI=;
	h=From:To:Cc:Subject:Date:From;
	b=so48KJk/JX46A88sCm27XG97Z1DG+kqoVXtLvOyLqyxCEWJfUDw6gIIc+GUAn72gI
	 2xasCg7ApT9ziYNJEkyyOokRwP07kBCUD0t9oEdnLt/VISs3zhwUFLyOtfYIKPCEXM
	 I03eQYQWlfb//xx0veVFqQIJovHABfxtd0q6G3WOcXuNf7GBBlzkehENGxkWaDN5Yc
	 AUBh+rC1HtCg+AYEvxtZwPRsIuDh07zQ7Zq4b8nnWzfcFaeYvv+ZwXIdweLe+jgtYu
	 2puC3giONE+wtf5TiWcv9b9o4T/N1uW2eb8U/tqo/9KJTcxWug7Ngh+8aUYBQcy9KN
	 q8zH1tGH/tgiA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	lumag@kernel.org,
	ukaszb@chromium.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: typec: ucsi: Fix null pointer dereference in ucsi_sync_control_common
Date: Tue, 16 Dec 2025 06:22:02 -0600
Message-ID: <20251216122210.5457-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing null check for cci parameter before dereferencing it in
ucsi_sync_control_common(). The function can be called with cci=NULL
from ucsi_acknowledge(), which leads to a null pointer dereference
when accessing *cci in the condition check.

The crash occurs because the code checks if cci is not null before
calling ucsi->ops->read_cci(ucsi, cci), but then immediately
dereferences cci without a null check in the following condition:
(*cci & UCSI_CCI_COMMAND_COMPLETE).

KASAN trace:
  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:ucsi_sync_control_common+0x2ae/0x4e0 [typec_ucsi]

Cc: stable@vger.kernel.org
Fixes: 667ecac55861 ("usb: typec: ucsi: return CCI and message from sync_control callback")
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Add stable tag
 * Add Heikki's tag
---
 drivers/usb/typec/ucsi/ucsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 9b3df776137a1..7129973f19e7e 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -97,7 +97,7 @@ int ucsi_sync_control_common(struct ucsi *ucsi, u64 command, u32 *cci)
 	if (!ret && cci)
 		ret = ucsi->ops->read_cci(ucsi, cci);
 
-	if (!ret && ucsi->message_in_size > 0 &&
+	if (!ret && cci && ucsi->message_in_size > 0 &&
 	    (*cci & UCSI_CCI_COMMAND_COMPLETE))
 		ret = ucsi->ops->read_message_in(ucsi, ucsi->message_in,
 						 ucsi->message_in_size);
-- 
2.43.0


