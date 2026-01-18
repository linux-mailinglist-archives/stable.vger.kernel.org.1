Return-Path: <stable+bounces-210192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F110D392F1
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 06:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC0B8300E7DD
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 05:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06526234966;
	Sun, 18 Jan 2026 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2vTsYgJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E08500967
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768715435; cv=none; b=f76a9X2bOnH+WyKtsNH+cgLoJ5WTKLMmeJs2Keh2D7ZIiGTuEz4cR5UvILkVXtnQAt3fwM3SMuN1UIBjIvZ1nkpURGCu2B4IQqPBReIeiG81L4qgX8eRC2w7bPR83as5060+DjYTRHQxq2b4u5S5mRTZnqB84Miz30Bq/rafot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768715435; c=relaxed/simple;
	bh=GfcRaK2pcsb4oVJ6XjyLGPbp0zJDY6rlyPIWDvnOnEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L92ZxNlmjGZDPGp03+ANITnfGwDXP2vKWWuD5586YRPhGwBYxfn8U1o0WPuBfa691U1j1RVYIrVj8l6+r+skG0m9Vlsy33LzlxcFof0PoxZ8HlifS1Z9t/NrHD1SiET5I7MdOcPsKs9gwwSXDSpMtwRjE9xXJl4LOJSHCr22lfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2vTsYgJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a58f2e514eso21192205ad.3
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 21:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768715434; x=1769320234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj342H2LaLV+gyhYxrcl0PGxuK97XEMltdhcCPFun6I=;
        b=f2vTsYgJdrpU6qu9zRwEoZTSh5yyUJvap1fdRXBotuwFsZ+6T+9yiwifl6iUSWo4PY
         RC+dkrOdWjls2sbjtAhw3DKwcdKWonpmt/0R7DgnYONcTCC8lBzkBjZjJK9lmWdd0eA4
         KyE0aQc6PRfHzyTVM/EM83rgya47jP+eJJG1PJNme6067+Z9gerVMeF5/YuhNFUT7vle
         4stBkSFjrj8SF+cQnmTGW2l/aoJj1zgR/9flACK+srww/D6iWCJWHGSjFJy7m/ia2zCy
         DERtZmcbJ+M/K1DfQPU256T9jpKQf+QfvkalAkbp8U5CUaog+jJS4STo1gz0FBCRmIK+
         K0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768715434; x=1769320234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj342H2LaLV+gyhYxrcl0PGxuK97XEMltdhcCPFun6I=;
        b=sqJ+ksGEGlljWZsdXfyz8JPf8DVMTdIWOKtYkbf1y3zPXdG8oefLIgNcdyo3wXbwNi
         UsXI3aVKlkxNMLdaxeGQBYeL7GpWq/ioQwJiGX32hr4xPLOkJ6Gg4z49PwJgPov3paU3
         jQDTDfRYe+XczBB3IQ3n0VHtmpCIZanZdtJzy59GqlelymZ/wj8arHx21YM19yuiSqiH
         Dn6lJQ/muR8l8JCJ26AdeVg1LTocZhaYQYAr/+HMlRwDkoIMuEXrjJi5NXWpjSVRLQK0
         9ykkDxuHqg9/43dvTKLnteDpY1ajuBRzOvi+3V8f6K78caHfuqWUg79KcOi+wUtD3qw8
         F5eg==
X-Forwarded-Encrypted: i=1; AJvYcCXCo6WsKpZKdHLqezz2vGone+qBzFIL2U5xkWH5k0VaSkI5qB9gACuPcUdfXJRdPj0s8zqF6W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlze5YoKILhl1ipH2iW6lHjcNXLWRZGKPS3IID11CVewNns16
	T6pSmGkSuVq0cS0rohIzOI9ISB8ZMmxBTreK94eB0q1iTtaXq7tasNID
X-Gm-Gg: AY/fxX6OMiVdmpbmVhunTnE2Ulj92jhDpbNQU8HWMSt0o6ZLwOMoANirh+g7i+sWyZ3
	YpmS3jyUr7lE2bMjAFoDeiWLnRKt0CBHNtS4WHAu8rqfrMmNJmgSDFKCRvv4+2yNhMGc2REHdk+
	9ipmC9hXnlbC5p3prcXrDxPniuGFfILFzBmmzRZFfSrdaOqpqZeQNPk+kZItas6YWDAUOnfcSZD
	lCLigLbTLWxpCGxeieuRqwQ9GCmwygu7OyML8sGXOIZn6N6BnHYAMG0puBdnYqS/EnwWO5SvPna
	qAe39Y7dtCJrztKFSbQIjJyV7fdqJ+ica5w8vMTVLepdWuy/LtWvw+ZaKmgP8U7nrNtXGavLlcO
	eFKd4hxjB/bx/esh5BVEumorypmnfY2q8V/UibH0n7vScvQmy/sX/ObViAYr4rDtCptWBK3BWSB
	bc8XGgyh6nZ/I=
X-Received: by 2002:a17:902:ce83:b0:2a2:d2e8:9f2d with SMTP id d9443c01a7336-2a71893cef6mr68173985ad.48.1768715433805;
        Sat, 17 Jan 2026 21:50:33 -0800 (PST)
Received: from vaishnav ([103.105.225.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719412d38sm49794665ad.87.2026.01.17.21.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 21:50:33 -0800 (PST)
From: vaishnav.sabari.girish@gmail.com
To: jsgirish@gmail.com
Cc: Ilikara Zheng <ilikara@aosc.io>,
	stable@vger.kernel.org,
	Wu Haotian <rigoligo03@gmail.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 01/10] nvme-pci: disable secondary temp for Wodposit WPBSNM8
Date: Sun, 18 Jan 2026 11:20:16 +0530
Message-ID: <20260118055026.14828-1-vaishnav.sabari.girish@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilikara Zheng <ilikara@aosc.io>

Secondary temperature thresholds (temp2_{min,max}) were not reported
properly on this NVMe SSD. This resulted in an error while attempting to
read these values with sensors(1):

  ERROR: Can't get value of subfeature temp2_min: I/O error
  ERROR: Can't get value of subfeature temp2_max: I/O error

Add the device to the nvme_id_table with the
NVME_QUIRK_NO_SECONDARY_TEMP_THRESH flag to suppress access to all non-
composite temperature thresholds.

Cc: stable@vger.kernel.org
Tested-by: Wu Haotian <rigoligo03@gmail.com>
Signed-off-by: Ilikara Zheng <ilikara@aosc.io>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e4caeab739c..29e715d5b8f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3999,6 +3999,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-- 
2.52.0


