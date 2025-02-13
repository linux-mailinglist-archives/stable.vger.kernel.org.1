Return-Path: <stable+bounces-115991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D58A3466D
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD831884936
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5799978F30;
	Thu, 13 Feb 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q/tkb5Dp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532A26B0BF;
	Thu, 13 Feb 2025 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459955; cv=none; b=RcFH1LiNSYacjr1A2o4fOPmUYfIjzoqEbu3Srx3CyyRrvGeefLXjV87hPQW9l8MDEKbWUN7JELod6gMJp6BtKHz55G3c2gONEHyLGTuPt/+4mCh4u2PekkboXHH1Pxr4wgzv6e2cWHBbXZoxhpZ2dacg3Ha7eXvCvcvGGVFLv/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459955; c=relaxed/simple;
	bh=XpIYhru6Uj18OHJqUInpsOAI0nbkmbjLAG3kRUXa7Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqTPtKe8LNij3V6RZESg4VKoRDzad0TW5Yw2jbwm9qyCTS8y18vGXHu6vA/H/mzlyTuiZlgYwZY8YY+8tcSHBqM+k9WtgQqX25lXZjDGr+MUVvRJ+ZxOlrxKs8m2WQyO+IXC+JR72lJlBodJNkhCcxPrXX3r3LGHfLDzRVkUej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q/tkb5Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34767C4CED1;
	Thu, 13 Feb 2025 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459954;
	bh=XpIYhru6Uj18OHJqUInpsOAI0nbkmbjLAG3kRUXa7Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/tkb5DpWWt4yQAOugU3DpSiazuGOn+qJBH4RNeey7OFyaZpsdjouemrhmKkz5NST
	 utinzc7FnQFg1PDAKyvQh1iR5m45c7uZvR9rrw93G8D/U7feTDR9TQl/7a0QKPjPFa
	 gTqMmR2TexbLcouVTznk2nudvKV/p3+w/QuG4JUo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Baumann <daniel@debian.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6.13 382/443] ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD 870 QVO drives
Date: Thu, 13 Feb 2025 15:29:07 +0100
Message-ID: <20250213142455.348992981@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Baumann <daniel@debian.org>

commit cc77e2ce187d26cc66af3577bf896d7410eb25ab upstream.

Disabling link power management on Samsung SSD 870 QVO drives
to make them work again after the switch of the default LPM
policy to low.

Testing so far has shown that regular Samsung SSD 870
(the non QVO variants) do not need it and work fine with
the default LPM policy.

Cc: stable@vger.kernel.org
Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Signed-off-by: Daniel Baumann <daniel@debian.org>
Link: https://lore.kernel.org/linux-ide/ac64a484-022c-42a0-95bc-1520333b1536@debian.org/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4143,6 +4143,10 @@ static const struct ata_dev_quirks_entry
 	{ "Samsung SSD 860*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_NCQ_ON_ATI },
+	{ "Samsung SSD 870 QVO*",	NULL,	ATA_QUIRK_NO_NCQ_TRIM |
+						ATA_QUIRK_ZERO_AFTER_TRIM |
+						ATA_QUIRK_NO_NCQ_ON_ATI |
+						ATA_QUIRK_NOLPM },
 	{ "Samsung SSD 870*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
 						ATA_QUIRK_NO_NCQ_ON_ATI },



