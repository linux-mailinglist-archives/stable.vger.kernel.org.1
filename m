Return-Path: <stable+bounces-146567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC73AC53AE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3A51BA3FA7
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09427A926;
	Tue, 27 May 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xukf/pX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB38194A45;
	Tue, 27 May 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364622; cv=none; b=rJpZ6qKesOWJzPMPCRStZNpUvAGQxGomMsbxIu7Twm1M+uCyD4eUJF5W63CJ7jSo5BvGIiWZOOPeemyYoUpN1OeuEYO/lkBD1RVBl1ty8atBreym0WfNsfAyvHc3f+YYlukeIgHSL40cZpxTpugQIZak5YqMwW1W2RUVTDBoMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364622; c=relaxed/simple;
	bh=WVAomNXggE1i8oFO0YkrkZv1MOwFl1nDmaqzw9ewxOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNYJaS7ky19mgxm1lMEP2Pj9D0x3XF/TWfRKoRwWYnI2BlTc/carLm0fypQXsjBpVb5I47U6ohT4CqJtIKJ0Ks+pWlxSmbSXeHsmW3so54LGHLc6gP4VBcDnKjBaeR+71B4OlxaHWl7apU4Y0gWXmQAJLCV3YmBSQR4/UMBs5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xukf/pX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D05C4CEEB;
	Tue, 27 May 2025 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748364622;
	bh=WVAomNXggE1i8oFO0YkrkZv1MOwFl1nDmaqzw9ewxOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xukf/pX4SEhxeNetbgaC27tWGIzGVxDUJAVohOUU/QAwx5d/ihmb+3jsm90ho1yqS
	 9dn/w/qLwnO+yWyU+I0Y11rLfJSJiVXfhIWtmJhv4TVukdfzk6eZHDUKhfvO0IaSyo
	 35JHwz3L5IOJfIfi3NTlpskYdxtpQsKmEhjfkHLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 083/626] Bluetooth: Disable SCO support if READ_VOICE_SETTING is unsupported/broken
Date: Tue, 27 May 2025 18:19:36 +0200
Message-ID: <20250527162448.419565103@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pedro Nishiyama <nishiyama.pedro@gmail.com>

[ Upstream commit 14d17c78a4b1660c443bae9d38c814edea506f62 ]

A SCO connection without the proper voice_setting can cause
the controller to lock up.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bc5b42fce2b80..8894633403519 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -932,6 +932,9 @@ static u8 hci_cc_read_buffer_size(struct hci_dev *hdev, void *data,
 		hdev->sco_pkts = 8;
 	}
 
+	if (!read_voice_setting_capable(hdev))
+		hdev->sco_pkts = 0;
+
 	hdev->acl_cnt = hdev->acl_pkts;
 	hdev->sco_cnt = hdev->sco_pkts;
 
-- 
2.39.5




