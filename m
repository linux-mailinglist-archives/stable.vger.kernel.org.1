Return-Path: <stable+bounces-252566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNtpAwP8DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-252566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95131595F22
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 487873138554
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D46F3F9F25;
	Wed, 20 May 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MV6Mx1zl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D33F789B;
	Wed, 20 May 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301012; cv=none; b=FnsoBzf0/QUWS/b3ZRWcGJ8J90jLGqaiXVExYF3HEmhhQpCRQmNznA3E0AP2qaM7EH2nAK7ACaVbG2YPWbohRZcbps2fd/pG2ZoGp/yV+NI/vyJLwrYxCV5I2xg0CKhn/32xfKlf/w9aysmrKmZjVTf8u9swNdWktmgDPy1b6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301012; c=relaxed/simple;
	bh=iKNiWwlAyx1b5hZLMO4i4QXVJuRGwl1SzqhTp9iIB3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX4ZchuPRyC0L5275tN7/YtX4wy90KOeMawkhTdeKV+uk7D5bEg88scYClCVDi8xu67n/kvvubt3AoDm2xvvE1RZ44eS+ATzWXYgxPLl4Sw3mDJzTcWy3uoN6UCgps+7eQTUAUumHGGTzVi6zfXf7yTR1xfGBRPbka6z5x77+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MV6Mx1zl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079B51F00893;
	Wed, 20 May 2026 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301009;
	bh=PgSRGKAcpjsXSCLca73rDXDahjjwn1PQQqG9j/Q0hX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MV6Mx1zl+ClJupqjBYd9p90Mq8Oj0XCKpr7NNCzW8MhNRHKZWFkq4TfSlT5RtT6Zb
	 +V57EnLvVOsAkLPwsq/DAfcElJieR+lqwUJ6/y8+dQPOOfrf+OXfXxYFDXlp/jwYMV
	 1gaZEQaxLlo2fsrSWGgAJhXNdxGv9+thuvTis9gI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 341/666] cxl/pci: Check memdev driver binding status in cxl_reset_done()
Date: Wed, 20 May 2026 18:19:12 +0200
Message-ID: <20260520162118.624689997@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252566-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,zohomail.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 95131595F22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Ming <ming.li@zohomail.com>

[ Upstream commit e8069c66d09309579e53567be8ddfa6ccb2f452a ]

cxl_reset_done() accesses the endpoint of the corresponding CXL memdev
without endpoint validity checking. By default, cxlmd->endpoint is
initialized to -ENXIO, if cxl_reset_done() is triggered after the
corresponding CXL memdev probing failed, this results in access to an
invalid endpoint.

CXL subsystem can always check CXL memdev driver binding status to
confirm its endpoint validity. So adding the CXL memdev driver checking
inside cxl_reset_done() to avoid accessing an invalid endpoint.

Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
Link: https://patch.msgid.link/20260314-fix_access_endpoint_without_drv_check-v2-4-4c09edf2e1db@zohomail.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6e553b5752b1d..09a2bc817d645 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -994,6 +994,9 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	 * that no longer exists.
 	 */
 	guard(device)(&cxlmd->dev);
+	if (!cxlmd->dev.driver)
+		return;
+
 	if (cxlmd->endpoint &&
 	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
 		dev_crit(dev, "SBR happened without memory regions removal.\n");
-- 
2.53.0




