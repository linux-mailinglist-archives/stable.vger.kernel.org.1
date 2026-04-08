Return-Path: <stable+bounces-234888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGq6Ifyi1mlqGwgAu9opvQ
	(envelope-from <stable+bounces-234888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:48:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C3B3C1983
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E682302F4AD
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28553D9034;
	Wed,  8 Apr 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j2432133"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE13D8125;
	Wed,  8 Apr 2026 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674022; cv=none; b=VC1miQxvQJXyxdLK690FPgrX7eojTnx7biekq/qgkF6jEPUvqLG6gVbfF4TRkz22sJ55+J3HQhLztRYXCBH4hbVQz3qjcT0Kua8zY0rCPKZhHm5HXD8X61L+3ehJv+eYGXCOzLk4XttWBtau0MOE/4FTkfnN3YgJxCKY86sis5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674022; c=relaxed/simple;
	bh=30qu4f4U+4ZkD+7bnRDbf7PPncSUcfOXIWMEbtXRtfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swscDLboPJCXz5MQEfOOl/HwjJmKUTZZXywzAh8ICRlbPoG5+BBFwmCnJOzi/qeJyNpWQJRF/pSxTEnx8MxUeODEDN03+lLANiAQduazfY24xvcvkNpTK0eTLhzwJ5Q/v5zSP/ra0nN1ectoatEU1+8Um5KGbh/GWk3Of+uSMWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j2432133; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3978BC19421;
	Wed,  8 Apr 2026 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674022;
	bh=30qu4f4U+4ZkD+7bnRDbf7PPncSUcfOXIWMEbtXRtfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2432133Vp7HVY0nJFN2ikhp3rHewsT5Y+sE+tIrmEUUfxB8sv48YAvAZ0LkvCeHE
	 qxU1LtesTSbYDrVSDD27kuj8OoC1m4T1vXXwnlzhLzdintNGVRHFy8AdVZ6tL6HeNy
	 HazzTGuTabTmrTVqbFhaLcl3Loz56HyzZRDucxSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Eggers <ceggers@arri.de>,
	Fabio Estevam <festevam@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 6.12 180/242] nvmem: imx: assign nvmem_cell_info::raw_len
Date: Wed,  8 Apr 2026 20:03:40 +0200
Message-ID: <20260408175933.821835548@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234888-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,arri.de,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arri.de:email]
X-Rspamd-Queue-Id: 41C3B3C1983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Eggers <ceggers@arri.de>

commit 48b5163c957548f5854f14c90bfdedc33afbea3c upstream.

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
Link: https://patch.msgid.link/20260327131645.3025781-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/imx-ocotp-ele.c |    1 +
 drivers/nvmem/imx-ocotp.c     |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -131,6 +131,7 @@ static int imx_ocotp_cell_pp(void *conte
 static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *cell)
 {
+	cell->raw_len = round_up(cell->bytes, 4);
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -589,6 +589,7 @@ MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids
 static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
 					 struct nvmem_cell_info *cell)
 {
+	cell->raw_len = round_up(cell->bytes, 4);
 	cell->read_post_process = imx_ocotp_cell_pp;
 }
 



