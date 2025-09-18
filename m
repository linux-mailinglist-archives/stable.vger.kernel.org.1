Return-Path: <stable+bounces-174291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74222B36265
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4566188F356
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA7307AE8;
	Tue, 26 Aug 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mHeuztCB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE22FC008;
	Tue, 26 Aug 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214000; cv=none; b=NM3sfLdX6b5B8pRdwnVh9b48en3bsbFWYYW+NgdY2Gkjfz7wMCFaAjwEgLg4HC1q6r1FlrQn1ARbcy3qH/yWOb473i+zqKI5j7JKIvYmm/EB9Cdfab8r5ZrXWmZeUqyl3d2SHoKZc8BBFLJjoVSjcFeakQaPxPnlJgZZ4ASZAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214000; c=relaxed/simple;
	bh=ZF68WFhbV/N9jTABDhp/eUqfL8brNiyuGay/6dhPv0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVuNBvPr4vKWI69v03eGiXfdH76nL2YJdHXzRtx8xrro5Q6vbq9l5cs0619XgGUQKW0bxP5WkzhK0qCFFUJPQdZ2lHusVNOTlwaAmc8rSxMT7w3rjg3XDRrJkRbFVY79bnMMbsRTkSlydWSLq4GBP6+qYSoTWuFEF0pmpimgloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mHeuztCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D108AC4CEF1;
	Tue, 26 Aug 2025 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213999;
	bh=ZF68WFhbV/N9jTABDhp/eUqfL8brNiyuGay/6dhPv0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHeuztCBKGwVCd5oSF978TMvwrKqBEVQ6QZ4huc+F3lkCa355AUu7S55SQr9MkApk
	 i4LorDg1Q6wjhyPcMdktnRlCvW/IpPj3KHsSqaHwiL2ahbzHId/ISWe/tRO8kQpbmK
	 XViWnTzAiGwkN8ueOtNiQvlO0QR56rwRi1Dacnew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 560/587] Bluetooth: hci_conn: do return error from hci_enhanced_setup_sync()
Date: Tue, 26 Aug 2025 13:11:49 +0200
Message-ID: <20250826111007.271239821@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit 0eaf7c7e85da7495c0e03a99375707fc954f5e7b ]

The commit e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to
hci_sync") missed to update the *return* statement under the *case* of
BT_CODEC_TRANSPARENT in hci_enhanced_setup_sync(), which led to returning
success (0) instead of the negative error code (-EINVAL).  However, the
result of hci_enhanced_setup_sync() seems to be ignored anyway, since NULL
gets passed to hci_cmd_sync_queue() as the last argument in that case and
the only function interested in that result is specified by that argument.

Fixes: e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to hci_sync")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 549ee9e87d63..ff9d2520ba74 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -339,7 +339,8 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	case BT_CODEC_TRANSPARENT:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-			return false;
+			return -EINVAL;
+
 		param = &esco_param_msbc[conn->attempt - 1];
 		cp.tx_coding_format.id = 0x03;
 		cp.rx_coding_format.id = 0x03;
-- 
2.50.1




