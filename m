Return-Path: <stable+bounces-182787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B295BADD8F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B741380474
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E53B3043DD;
	Tue, 30 Sep 2025 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bl0ddrEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78F16A956;
	Tue, 30 Sep 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246085; cv=none; b=rPfYKcIC2gwyNv/VR6FvpkTl2X9IOsi1lXeWDhp3MC/fTb2qdZ3xlzc2AR63VUCVAmi3JcTPpTMn4JNfoK+Ua96NxmZ4MeeBtTmcYVkv7TUCxjUgNncM7GumjJNPebeSwojrcHL9ckKMzVoGnvTzG5QTNrXxKXxQ+A3wSBPuMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246085; c=relaxed/simple;
	bh=4brhJC3WeTpYFQbq0iYjUG+U5PkHdh3s1BH3qNnf+kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBtUMGdHiANV9h4e0XU+XJeXHTWFIHXgLQcoKt9Ef/u1Es9XBX9CQnVRJIyY8zVWKl30Tj4IOHvnDFrrcal6wpNuoZJYX0eaDadDQ/7u/8MBd9lTnjt9NHFIJ+Q1lCLIPtwtQDTmAG9duH7TohpHUEL1dfkx7uzRD7IH2k666O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bl0ddrEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2667CC4CEF0;
	Tue, 30 Sep 2025 15:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759246085;
	bh=4brhJC3WeTpYFQbq0iYjUG+U5PkHdh3s1BH3qNnf+kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bl0ddrENa/mfP3gFBj3HPbsubK3dYBCXaN0jgKjkuBJw4s0TH+k0fz3YSCwuzoOwY
	 Dd88BtYlfhNtNX5J2LhDaKnUNUfZ8DiLKW2wJVf1kD88s5T092nr+WVx66X4HXcrXJ
	 a9xPwfq5b18T91muLt5IWVPPyKDt1Ew3bsXBBgoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 48/89] Bluetooth: hci_sync: Fix hci_resume_advertising_sync
Date: Tue, 30 Sep 2025 16:48:02 +0200
Message-ID: <20250930143823.910278926@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
References: <20250930143821.852512002@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 1488af7b8b5f9896ea88ee35aa3301713f72737c ]

hci_resume_advertising_sync is suppose to resume all instance paused by
hci_pause_advertising_sync, this logic is used for procedures are only
allowed when not advertising, but instance 0x00 was not being
re-enabled.

Fixes: ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_sync.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5f5137764b80a..333f32a9fd219 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2604,6 +2604,13 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 			hci_remove_ext_adv_instance_sync(hdev, adv->instance,
 							 NULL);
 		}
+
+		/* If current advertising instance is set to instance 0x00
+		 * then we need to re-enable it.
+		 */
+		if (!hdev->cur_adv_instance)
+			err = hci_enable_ext_advertising_sync(hdev,
+							      hdev->cur_adv_instance);
 	} else {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
-- 
2.51.0




