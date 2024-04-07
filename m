Return-Path: <stable+bounces-36189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1889B009
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 11:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F971F21882
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03012E4A;
	Sun,  7 Apr 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtgsIPqp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D412B7D
	for <stable@vger.kernel.org>; Sun,  7 Apr 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712481341; cv=none; b=rjiGyyHpYWVcfQImUoZiY1TJ5Fcyn8fHkQVbtfdJOw6ymqugN4JJZFZvdCl1m+KpqtqPcfUk3np7Yw11fuFs6wW9l+A8G1UB8HP6C6UostdVPy+wjX2eo3AsGyKtxnNarDYLXgLcYkukgbSYjxvo/1igPVwxI+uK9TxVnnv+gR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712481341; c=relaxed/simple;
	bh=Ze4d/tSDvZ2g7AYif2BYCV/XrDeqFjfAmiUaT9rrZfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qtXy8azK5HMjG9MSBTCAsgk7An69KXhesJSFrpAK7dHAPzivS0I7bfjUcEEEN+rcrfB7WCe4ECrMbSpkCHQLa5BUdnqKGahE4fHb1NiZ5GfUUSdwzfkUEp9+CaPqiqVD+GSag+0+jxlsk4t1YMKzmTOO6HckrCg/cWnq0thnwC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtgsIPqp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2825013a12.3
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712481339; x=1713086139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZz3MC840yZiyjU2iCflebsmKP1jFfr+YX8wQcQ7who=;
        b=jtgsIPqpHcsL1BfjvONYRNwu+sfiKgNSTCKoR9IL2D7ftRGSYneMoOgXGz3gqDQ9jz
         dsZ60TB/VyjzPuUMuiSauNQUNqrWlZipPIYYceCRK5psIqklHMz9OMbQsk4k9fZeqzPk
         FLfIixXewrP80Qc6Fxb0Fqv/+pdVyKANTqmctB/hov4DPiGZciZ9nfRO6KV0lPLWBpQa
         NFIUBroWZd9JXbQ7GbebfpbHFpqLbHShU08LJzKucYe34+C5kNfpNj1KosxVP80blYv9
         542hVIkhjQfTvkWTmk0T1kbG0r5F15cFjUfKCxIaaoKpWVKAnHomSxpQUe3GHspQ7gHB
         gyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712481339; x=1713086139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZz3MC840yZiyjU2iCflebsmKP1jFfr+YX8wQcQ7who=;
        b=gF/rEDUXOjpUsdTHa7Eui2tIShGdN9VVGuZAVq+H7ljXT3uoklHgK8gH6O7b07ChTh
         1bb411h/7xtrMk4o/iWz63mHfF6kt9IlU8H6AhKXVBMRCS2cYqwC1lkMa22NWvU/WJhg
         vu1HWi+Q66AlqVyVbwkxDsJhnUa2ImrLNXW9s4QYas1hZ587epc3nMNTdfTDd0miK+qJ
         A8BpIzrjyVUt5r59+L0JdYkMTelAWaR89HXC5PEvDN7XkVuYWw7GgwskL3W4yYmHPWJo
         7VMNOW/mXKXUzayWKvIVuLV0OUcDlbDAJv8gjmxYfnSoVkA9D7/QhTaHTFc7HZ8eLtsO
         m5iA==
X-Forwarded-Encrypted: i=1; AJvYcCV4NmkZPLGi3E5BvS7DIH/UfE3/YeNJ3CzRe0BOQRVWv5uyeVRCaJzMA+nAfjSzqusJYY4SO77xjNWybSAiJ+Hcztq7mopd
X-Gm-Message-State: AOJu0YxRBOjcjxugl1axSNXiRIyzKEWLTzouXhkvKBrcEUvUR1bXeNIu
	7jSDzbW7jyqP8+vnP9h6sUgGJ2iQTTn9GfqwgewAAa2fAqW15us2
X-Google-Smtp-Source: AGHT+IG/v6pXK0c/WnbmNuveLTIDxp62sKFRmQTKE5oyK98ydkDjwD6izLdX3yaiAqsJRY89kjBBSA==
X-Received: by 2002:a05:6a20:5529:b0:1a7:509b:2a2d with SMTP id ko41-20020a056a20552900b001a7509b2a2dmr3494266pzb.12.1712481339436;
        Sun, 07 Apr 2024 02:15:39 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:402c:cd44:6086:c23a])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b002a29160df67sm4293667pjb.27.2024.04.07.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 02:15:39 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org,
	stable@vger.kernel.org,
	"min15.li" <min15.li@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH for 5.15.y] nvme: fix miss command type check
Date: Sun,  7 Apr 2024 18:15:28 +0900
Message-Id: <20240407091528.5025-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "min15.li" <min15.li@samsung.com>

commit 31a5978243d24d77be4bacca56c78a0fbc43b00d upstream.

In the function nvme_passthru_end(), only the value of the command
opcode is checked, without checking the command type (IO command or
Admin command). When we send a Dataset Management command (The opcode
of the Dataset Management command is the same as the Set Feature
command), kernel thinks it is a set feature command, then sets the
controller's keep alive interval, and calls nvme_keep_alive_work().

Signed-off-by: min15.li <min15.li@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f06e5c1706b..960a31e3307a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1185,7 +1185,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return effects;
 }
 
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+static void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 			      struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1201,6 +1201,8 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
@@ -1235,7 +1237,7 @@ int nvme_execute_passthru_rq(struct request *rq)
 	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
 	ret = nvme_execute_rq(disk, rq, false);
 	if (effects) /* nothing to be done for zero cmd effects */
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
-- 
2.40.1


