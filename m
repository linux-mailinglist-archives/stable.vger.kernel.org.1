Return-Path: <stable+bounces-245388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLKLCBeYAmoauwEAu9opvQ
	(envelope-from <stable+bounces-245388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 05:01:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B70B4519203
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 05:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFBF9303CD1C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333837BE8D;
	Tue, 12 May 2026 02:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUXsqkG6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C537A494
	for <stable@vger.kernel.org>; Tue, 12 May 2026 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778554648; cv=none; b=hfqO90xGHeHVFQyxItwNyZiiSee8/0gh7OoPPkfIO2ajeKSi7Q9b/wMSvF0xB/XqgjZ//e9czPWISpNwdmywljfYL280A+NcFgKSEQlzsris3QORfgD3Xzc654X85Zr9B8IYdMLloj5XjWIkgrEiuuPa3sTT8RYF6+JwY6aZyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778554648; c=relaxed/simple;
	bh=uWjlxtYqM8O9PbBaqjl5LZYeF1d3R6cX3VIkmy+f0DI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLQQ9AnO3tEVqKJcT00JvGGwVUZUHyGyNS5u3WnVoSZlqAp3jlDkV7ZBiurz6ubH6A1KjOcvB/fE5F62CKuay0OicJlXEL0vIuyyGsDlXuBa068WwoGxYTeutOOZZlIv8M8+D7WBtvnVoo9GACPwmEzk3keZxeqyT2J8PtBVWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUXsqkG6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so14792875e9.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 19:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778554645; x=1779159445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9QcQu8wpJ9VO6w2kG9ZZWYLEhIyK8o9x8PX+zgD3Ms=;
        b=pUXsqkG6iQFyxKFm7cdN5i/qlC2WgAcykjIymGb8n9mA7zFFH7NVUEjexTBqC/iZ+7
         OHIiuHdk2IVD0iAvYjCWN2ftbGXNnC0DTlvWpXTljWLY8Fdl0Mg8a2ZBwDO9DpBS4OHw
         njzoWTomwfHvm5O8WIQYb5QLYrEhkf005JonjFHi6jx4LXZj+VtpnAYLvwTyMeVsY1QZ
         IbAo2m+buuNWu1k/LDSEzwoW3RYjf9m9MXXUXpGeIWSX5DMOjCc4vzDhkej8XFrRwej7
         QzUxsRJwFkYqqgZaqAP3d1spNiFyheaXG9BRrX/menkxeJI2OqXQeZMMw6B/rEAqtw5A
         i8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778554645; x=1779159445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9QcQu8wpJ9VO6w2kG9ZZWYLEhIyK8o9x8PX+zgD3Ms=;
        b=e2wCNzJ6k9+jJ55uqMkL2tfZvzH7w5UvHg/sggbCcQx+dk7Bui1OLKfbPlefzu0AYi
         npJPM0qBw64nCgM9rrz+hIPDhz7iqZVDVhAH/TM8nbGseUoshvOiMBU+zQifwbcP/BLk
         v5h2csiXo4YndImClE45pLa7b93rWLiKg/J3vv3RARtmGk0AkuT02paSf2dpb8QpAJCg
         q+KR6E7SgBF/J92PDbp7f7qhQXMPZC1doYd5jq79K2MK7XLhC2HqJQCMDKYI9sqYtkF3
         NQjgvcfjD3sJlfOESKmBtgNpTZAwOEJzJMqA3iP2qMOwMlrYShVqqPcjLQsO6ttOCV3Z
         GXNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3FZPRg7WWEFpbuKXh4pkDAnLNAniFYKV+m7Ca/ugGZU362wXSyHuALwze3kHejNCrsh8HPRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRb1zU9sa3bgEWgtbXtmPGQ5zzxsm2FoCrMphqAOPqRl30IMty
	YPa8ovqs+7HYIAprqaK2sNjV+nCMCAASymqpTAnPb06lHTH5Sli41Eax
X-Gm-Gg: Acq92OEcWPUVRRjo6jx5LXl2SIaoko0swIJk7vDfLn7QQSVdRiPBjlYwWFUQFH4mpJJ
	7M+WbBH8uSdZV7oQMSyPZgEvCgETdy/mb1xIlBUuybTDI8HbEZLajPebhgJHM+MaDKJF4SRV+aG
	TgGLyY5z7ZbujO3oeya2G4iMjWWZ7hn9qP7h8M5fEwXug/fJwtCyC1Vhz56pa32Bgb0ilLOwHdZ
	iE4BfPEbxpnaqZej50ZI6dU8FljwyZljFBA1FBOCEA3z6igJcoEibagyghbvTSCcWL1Dlrf6iqz
	tn+qB5aEkO/uwxiumZT39dVOP5SpZ64aAXzQ64M/zkjveFecipDTL/NQSi5GAO+W+vWp5INbTXs
	CwPtTap3/bOuzSBPLj9CKU3ri7LsCsIhb54RQl4EDjWZVwRAB7gOPW4Zv0IQqn7pFgQ40db04s5
	Q8WEAoy6nUhREgaPPhCyVN0U/iGRDSFDRzZyg5olThiu5JJ8xooX0oZFjw9YjoG+/secQ9LfA8F
	vegUjpMVmhlQr8qLVtfqMF8gzSovFoHvh1eytmzAhXkXYFWwFeBmkyZs+I=
X-Received: by 2002:a05:600c:35d4:b0:48e:74dc:999f with SMTP id 5b1f17b1804b1-48e74dc9b4cmr210451815e9.6.1778554644651;
        Mon, 11 May 2026 19:57:24 -0700 (PDT)
Received: from CNCMK0001D007E ([45.10.155.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e90548185sm12892665e9.8.2026.05.11.19.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:57:24 -0700 (PDT)
From: chalianis1@gmail.com
To: miquel.raynal@bootlin.com,
	srini@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chali Anis <chalianis1@gmail.com>
Subject: [PATCH] nvmem: layouts: onie-tlv: fix read_post_process assignment
Date: Mon, 11 May 2026 22:57:15 -0400
Message-ID: <20260512025715.50645-1-chalianis1@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B70B4519203
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245388-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chalianis1@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cell.np:url]
X-Rspamd-Action: no action

From: Chali Anis <chalianis1@gmail.com>

Assign the onie_tlv_read_cb callback directly to
read_post_process instead of calling it during assignment.

The field expects a function pointer, not a function call.

Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout driver")
Signed-off-by: Chali Anis <chalianis1@gmail.com>
---
 drivers/nvmem/layouts/onie-tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 0967a32319a2..0242f64fe713 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -124,7 +124,7 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
 		cell.offset = hdr_len + offset + sizeof(tlv.type) + sizeof(tlv.len);
 		cell.bytes = tlv.len;
 		cell.np = of_get_child_by_name(layout, cell.name);
-		cell.read_post_process = onie_tlv_read_cb(tlv.type, data + offset + sizeof(tlv));
+		cell.read_post_process = onie_tlv_read_cb;
 
 		ret = nvmem_add_one_cell(nvmem, &cell);
 		if (ret) {

