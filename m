Return-Path: <stable+bounces-123786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7AA5C771
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410A93B38E1
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4825E836;
	Tue, 11 Mar 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H2GT7AXq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4925BACC;
	Tue, 11 Mar 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706958; cv=none; b=Fb5ahyr/gj/40bSIqDXIuXzQU/9MaVstCEas1qzmSrUiIRRL2+8iLYlHA91onWN2W6O02uRREywLdxlfVBYMaAjlgKiCntMfPnRVjIOqNZOuXvqWJDwldrAfH1Mdq3RW/ZFq96WTnQKkxFo0TnKJzt1KvqMv4t4tuIIGCJToRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706958; c=relaxed/simple;
	bh=9wKWYwAroQaSfYqYVK5stpr1hoYIzszW6tVB81AodKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cr/f9+y08vKnBy43ZD+9lbng2GW6Mg74//M50u/f5iZQVpithx/CCm0lwUBDCvxxEP5PFLuNBy52cTEMtlKe92xaq8y8koYdFlbu1F7M8yUB5Kfq4MU68hJgLanvn9neQqdr+E3d/9cgQMAEd4rmN/nTMOc2vy1Bryn5BuA2oYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H2GT7AXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF5DC4CEE9;
	Tue, 11 Mar 2025 15:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706958;
	bh=9wKWYwAroQaSfYqYVK5stpr1hoYIzszW6tVB81AodKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2GT7AXqH9AsCBZNU04A3eUjHxJHkgMqV8rsZSLBQssuXWSSA2/kKyUrskheHHbk0
	 VAI4LMblqqBggVY15oIWUgHbcaQlkiH22EInGzkIAhsGC+nbFhNfIgXYpBZTZu9DUX
	 mdtkRnO5FcYZ5R95MLAgehCY5ybTCBLze231utAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Han <hanchunchao@inspur.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 227/462] HID: multitouch: Add NULL check in mt_input_configured
Date: Tue, 11 Mar 2025 15:58:13 +0100
Message-ID: <20250311145807.331548059@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Han <hanchunchao@inspur.com>

[ Upstream commit 9b8e2220d3a052a690b1d1b23019673e612494c5 ]

devm_kasprintf() can return a NULL pointer on failure,but this
returned value in mt_input_configured() is not checked.
Add NULL check in mt_input_configured(), to handle kernel NULL
pointer dereference error.

Fixes: 479439463529 ("HID: multitouch: Correct devm device reference for hidinput input_dev name")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f36ddcb4e2ef2..006af6e143073 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1594,9 +1594,12 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		break;
 	}
 
-	if (suffix)
+	if (suffix) {
 		hi->input->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
 						 "%s %s", hdev->name, suffix);
+		if (!hi->input->name)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.39.5




