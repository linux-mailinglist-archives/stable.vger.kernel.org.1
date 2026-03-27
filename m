Return-Path: <stable+bounces-230655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGQaBneFxmlALQUAu9opvQ
	(envelope-from <stable+bounces-230655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:26:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC0A3452A4
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAFB130F6456
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78A3F20F6;
	Fri, 27 Mar 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFjInnA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0503F1679;
	Fri, 27 Mar 2026 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617419; cv=none; b=ITJCNONw0F1R/h8fYJXUMrhGjeJR/hvGniCOznk/6XukXTQDpA8KkCvyWwlODQ0fvvL24tLnkZsFWEipreTDaI0AgYHAtZYVNHQPlS6SxiA6D49Sj28RpimUbykiKVmWNebjwB0yQtsmHa19sJKCA/mwIJG+q1oDySob3ORQnR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617419; c=relaxed/simple;
	bh=mP3+pIJqTHTO1gjsmh7erbRzVcxiFgunadHJlxC09Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgdjlgw0hZMFOoTuiSD1BotIjCOO9yVg5hXxk9Y6Y8uOr/YuwRaQZmRtFFq72YASflwPmBugseZzsfnE1WAlrfFmFWrtmvgA2IabUmfh8AwcXqpti8w7t7vTbthU9LWbxk4h6QHm4poC678L0kUduXuizOsV8YNNKLgXvhS0jFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFjInnA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E85DC2BCB0;
	Fri, 27 Mar 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617419;
	bh=mP3+pIJqTHTO1gjsmh7erbRzVcxiFgunadHJlxC09Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rFjInnA4W5eGEjTFg4XBCqFIexqhXf6KbfYLV4bIDxbzHHaZiMn8nbyR1NcGpf0WW
	 7ABoBXmu8aMjtS6VPsNufHXbc2/05GMr36oGFGzKRQurQQCJchdEncCw1+o4W+FEfA
	 v047jhljZkhAcmPPRBFd4ORzGPjUC40ZXgjtH45BEZEqyl5dUg6UvkMHgePtgNdhOr
	 2vso+VibjMzXxCWcaVV78Tv8fs3e3NfXZ7JFZMk4AoeMMeVfMyhL014T0mAOuWxl/D
	 kFwe4bXFhiyGLIUvlkHiQkknnoQuBXfZfqCsEL4odAabYu/BwpyTZ8zHAKQ440CSNZ
	 NLJ/WSSGXNIhg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Christian Eggers <ceggers@arri.de>,
	stable@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/2] nvmem: imx: assign nvmem_cell_info::raw_len
Date: Fri, 27 Mar 2026 13:16:44 +0000
Message-ID: <20260327131645.3025781-2-srini@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327131645.3025781-1-srini@kernel.org>
References: <20260327131645.3025781-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arri.de,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BC0A3452A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christian Eggers <ceggers@arri.de>

Avoid getting error messages at startup like the following on i.MX6ULL:

nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4
nvmem imx-ocotp0: cell mac-addr raw len 6 unaligned to nvmem word size 4

This shouldn't cause any functional change as this alignment would
otherwise be done in nvmem_cell_info_to_nvmem_cell_entry_nodup().

Cc: stable@vger.kernel.org
Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
Signed-off-by: Christian Eggers <ceggers@arri.de>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/imx-ocotp-ele.c | 1 +
 drivers/nvmem/imx-ocotp.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index 7cf7e809a8f5..a0d2985c6d03 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -131,6 +131,7 @@ static int imx_ocotp_cell_pp(void *context, const char *id, int index,
 static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *cell)
 {
+	cell->raw_len = round_up(cell->bytes, 4);
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 7bf7656d4f96..108d78d7f6cb 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -589,6 +589,7 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
 static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *cell)
 {
+	cell->raw_len = round_up(cell->bytes, 4);
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
-- 
2.47.3


