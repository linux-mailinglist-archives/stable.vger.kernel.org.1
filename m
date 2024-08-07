Return-Path: <stable+bounces-65768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7F94ABD2
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499112823AD
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253E78C92;
	Wed,  7 Aug 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lk8GNonC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B627448;
	Wed,  7 Aug 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043356; cv=none; b=fKtaTBptH31tHyrvzNtfWbut1nvOu5lnt+VpksM/Pbv5mrgd00llMdzdz6/cKM7J4FKpIFSVtTj8qtNdm/ZoZ0ZX+uqmzlrVOtVpihqKVEs+j9aZAh7oUHmQnE5KVS26yfupAoW33g6U39DKV9WeINFrcvZP78MG3+JQld1W4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043356; c=relaxed/simple;
	bh=TeTI5aYTo7wL0U3l/Jsiv1CjnjTBMkgqasLYgotE1XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiIpQcXJwxndHSkWlTANInV9rm0AcSlWaDO8V6Kgk5/WwuzdTmIUvfo3HA3peRByA5CfCRWEhHc09e/QZ8PggdrNNW4oECGQaGXCwoWF2vpvFcnkDohVjhQ/xtYqOzLm38Lmb69HX4Tsr9YN/cy9lHxK8tH5Rd0f0R2zJtyN6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lk8GNonC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB23C32781;
	Wed,  7 Aug 2024 15:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043356;
	bh=TeTI5aYTo7wL0U3l/Jsiv1CjnjTBMkgqasLYgotE1XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lk8GNonCn4TYIhTHAKL+PJQ9ef1ktiRl28g3ZLbafbpLNccczXNxR7zlKuByn1OrA
	 z1nhMmaDfLiDo6C+aooIkPpWPtRqxixyqxr5nYU/gdMr3YHeqC7DoJ6GzFR3gRZD6l
	 Ir06WcdcSQ0VkDM6wedhHFuRZmBCE5/LNvxYbX8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kiran K <kiran.k@intel.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 061/121] Bluetooth: btintel: Fail setup on error
Date: Wed,  7 Aug 2024 16:59:53 +0200
Message-ID: <20240807150021.410720036@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
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

From: Kiran K <kiran.k@intel.com>

[ Upstream commit e22a3a9d4134d7e6351a2998771522e74bcc58da ]

Do not attempt to send any hci command to controller if *setup* function
fails.

Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btintel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 3da3c266a66f3..a936219aebb81 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2845,6 +2845,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		btintel_set_dsm_reset_method(hdev, &ver_tlv);
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
+		if (err)
+			goto exit_error;
+
 		btintel_register_devcoredump_support(hdev);
 		break;
 	default:
-- 
2.43.0




