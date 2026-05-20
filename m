Return-Path: <stable+bounces-250585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EjpAmD0DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:50:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B3C594B2F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD98C33571D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D11372691;
	Wed, 20 May 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZBIt102"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB63A3833;
	Wed, 20 May 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295797; cv=none; b=ur9dy7ZAJ2jg6QA4CLRKBk63x/ORoWXvCk5ImVW+DIC2Bs4PCNTcBlMvRRELAlnP6SqN3qAEK4IOilV4iFKguUZKqArCRFl9jf3D3TIYe+kpaWObd7lUNzIQsrRzHo3vSaf0q3tSRTow0/q8uLc9vx9BAu1hM/yaJpiLPmWBaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295797; c=relaxed/simple;
	bh=OhwNnaojFxoe3BHjBZUpv/6gRdgqqSpfvgeQiExuhiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqmjjvUVnqrq+QfQ7OYhxrqwE2X3289WJkTOL4E6S9aD760q0qfPvsgn2geCkkPiYpBqBr/tdGMddybawFPBTbLxOPbeDDGR5frwB8Q3kW5X3U+pSqpDBQTscpIE/DYQCvLyA/k++WwpD5YE88klJAgp/yscKdDcJphd1bJpPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZBIt102; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BBF1F00893;
	Wed, 20 May 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295795;
	bh=LPz6Cj2KU+YNgaM62bqKl1nM5iZT5ClOGrV+S9FIyYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sZBIt102vYe7hZ5pOqTOXpaTwtZcMW1fPAQOnrgRIEgzLOGgGN8REPsAAjVYZJlyH
	 IjFLne1Gsk32hS3JX+eGCH+FmnTVTvH9YIfklA1UJJ1YvZZSYyrljzQfL4QI6lSaWP
	 Rx/SHcKs/fi7onubWDLBD8A5hUPfaMsRhtDZ39sk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0554/1146] soc/tegra: pmc: Correct function names in kerneldoc
Date: Wed, 20 May 2026 18:13:24 +0200
Message-ID: <20260520162200.717797859@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250585-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 62B3C594B2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit ec0e4da5d679f9da1cc198927951f70fdf28f001 ]

Commit 70f752ebb08c ("soc/tegra: pmc: Add PMC contextual functions")
added the functions devm_tegra_pmc_get() and
tegra_pmc_io_pad_power_enable(), but the names of the functions in the
associated kerneldoc is incorrect. Update the kerneldoc for these
functions to correct their names.

Fixes: 70f752ebb08c ("soc/tegra: pmc: Add PMC contextual functions")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/pmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 8268a41c471a9..b889c44f8fddf 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1005,7 +1005,7 @@ static struct tegra_pmc *tegra_pmc_get(struct device *dev)
 }
 
 /**
- * tegra_pmc_get() - find the PMC for a given device
+ * devm_tegra_pmc_get() - find the PMC for a given device
  * @dev: device for which to find the PMC
  *
  * Returns a pointer to the PMC on success or an ERR_PTR()-encoded error code
@@ -1747,7 +1747,7 @@ static void tegra_io_pad_unprepare(struct tegra_pmc *pmc)
 }
 
 /**
- * tegra_io_pad_power_enable() - enable power to I/O pad
+ * tegra_pmc_io_pad_power_enable() - enable power to I/O pad
  * @pmc: power management controller
  * @id: Tegra I/O pad ID for which to enable power
  *
-- 
2.53.0




