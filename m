Return-Path: <stable+bounces-137923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B90AA15B0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00204A60AD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8FF2517BE;
	Tue, 29 Apr 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ut2Fozt4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0D2459EA;
	Tue, 29 Apr 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947546; cv=none; b=nOyrTo0onmYuiBZCy6Wz1PebRO9WzxeeU6jus9nApJV7zuOJJgQ2BB4ESa97yGoS5fxTCUjEA6Quqs2TgQ6GykAKZQU0+bBk5kLHdqzfXNWlpauUE9J5Qr6K5OZuV8s2PBfCZcHgLN0mefZRWYIwXgpBjwMpFwCj7bcivg8A23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947546; c=relaxed/simple;
	bh=gH7P3yBHE9rEkxN/TOYb9b+amJSIPD1/fi2CnQTdhxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKqy5VhZK+WC2Pxy7ukzHV8gIOI1rXyzo2bwr4vGTyW8U02qkn0tym2IWW6NDgQxVQUnVZxvk8rmM5r4rqJhqa1NGeabETKFYJ0lbhJdj28SWTyf76bJo6sNomoETg8u6I2LgDztO24HJUuvW9TtpcbFjJpqRE01JVZw2A+qMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ut2Fozt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568B2C4CEE3;
	Tue, 29 Apr 2025 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947545;
	bh=gH7P3yBHE9rEkxN/TOYb9b+amJSIPD1/fi2CnQTdhxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ut2Fozt4+v4eS9w3ZvMuWIStlzrYKBS8WbDwZx8LyWXWdsVgWm960Nazn2wp5nTRe
	 BDx5wfHpIfrfJpz/Mnr/rkhuyCzon10JssBu1wqzLRUXefvU0Fj7Ljr+PXVizMvpFH
	 W9jDcTKMVr/PyGNaE/RGQA8EgNKAjR17liI68sag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 028/280] s390/sclp: Allow user-space to provide PCI reports for optical modules
Date: Tue, 29 Apr 2025 18:39:29 +0200
Message-ID: <20250429161116.255869961@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit e9ab04490667249633fb397be17db46a8fa6d130 ]

The new SCLP action qualifier 3 is used by user-space code to provide
optical module monitoring data to the platform.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Stable-dep-of: aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except for ISM devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/char/sclp_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/char/sclp_pci.c b/drivers/s390/char/sclp_pci.c
index a3e5a5fb0c1e7..c3466a8c56bb5 100644
--- a/drivers/s390/char/sclp_pci.c
+++ b/drivers/s390/char/sclp_pci.c
@@ -27,6 +27,7 @@
 #define SCLP_ERRNOTIFY_AQ_RESET			0
 #define SCLP_ERRNOTIFY_AQ_REPAIR		1
 #define SCLP_ERRNOTIFY_AQ_INFO_LOG		2
+#define SCLP_ERRNOTIFY_AQ_OPTICS_DATA		3
 
 static DEFINE_MUTEX(sclp_pci_mutex);
 static struct sclp_register sclp_pci_event = {
@@ -116,6 +117,7 @@ static int sclp_pci_check_report(struct zpci_report_error_header *report)
 	case SCLP_ERRNOTIFY_AQ_RESET:
 	case SCLP_ERRNOTIFY_AQ_REPAIR:
 	case SCLP_ERRNOTIFY_AQ_INFO_LOG:
+	case SCLP_ERRNOTIFY_AQ_OPTICS_DATA:
 		break;
 	default:
 		return -EINVAL;
-- 
2.39.5




