Return-Path: <stable+bounces-236536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPQOBA0a3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:30:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 860AC3EF18A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75A093056267
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF482FFFA4;
	Mon, 13 Apr 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2KR77Eg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB02459D1;
	Mon, 13 Apr 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097159; cv=none; b=XgG+AlxtwZbqm65wgpcWl/2WuO3wT2lO9oaKGOqoZ3ubbDMBCPNMsMtWG9kPN4tdl7V40MH0LbGmP04hRhJWNvM8ZFQFb4AH6wSuthWFwmXO5p5BKtohs3+SKNNDnFiafXSN/xY2GVNrbjS3+0l2OlMQojjekQ6+f0qEl2A8uTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097159; c=relaxed/simple;
	bh=z1hTyQyf1jPKvbqA0lxl/7yacPYhz8Hb0vjYyyvrCd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEfAl5MjllS0uZL74EJW7K9MQNtJApIFf8XVEPZ4a2B9K94ba2reQavcg6s1GZAuBiyUFnulP0/hCUBJKDMaXT6iZ+90q8FV9+0uppdbuTGb8x6kfnChJJYoHoAQpUgZbjqy8MGvYlaFuO0470BBefFhjPsuUW31DPACZwK4vDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2KR77Eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8010C2BCB0;
	Mon, 13 Apr 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097159;
	bh=z1hTyQyf1jPKvbqA0lxl/7yacPYhz8Hb0vjYyyvrCd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2KR77Egj7/lbj/WTS5/6NwMCZ0+iczzNrD5+8CUVMfpgy+V5+JMr1QRy9z5nFzV3
	 EwjV1EASvhkS90X6WFjsoX06sS5W/16mAayl8ISjImQtlN4URNlbSKaUla0yIR4XDt
	 7nVRn44y+rbk9CXvGu4XHa6kCEGSpBJrVj9elGTQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	Peter Chen <peter.chen@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 029/570] usb: cdns3: remove redundant if branch
Date: Mon, 13 Apr 2026 17:52:40 +0200
Message-ID: <20260413155831.515237560@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236536-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 860AC3EF18A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongyu Xie <xiehongyu1@kylinos.cn>

[ Upstream commit dedab674428f8a99468a4864c067128ba9ea83a6 ]

cdns->role_sw->dev->driver_data gets set in routines showing below,
cdns_init
  sw_desc.driver_data = cdns;
  cdns->role_sw = usb_role_switch_register(dev, &sw_desc);
    dev_set_drvdata(&sw->dev, desc->driver_data);

In cdns_resume,
cdns->role = cdns_role_get(cdns->role_sw); //line redundant
  struct cdns *cdns = usb_role_switch_get_drvdata(sw);
    dev_get_drvdata(&sw->dev)
      return dev->driver_data
return cdns->role;

"line redundant" equals to,
	cdns->role = cdns->role;

So fix this if branch.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20241231013641.23908-1-xiehongyu1@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 87e4b043b98a ("usb: cdns3: fix role switching during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 7242591b346bc..d272d7b82bec1 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -528,9 +528,7 @@ int cdns_resume(struct cdns *cdns)
 	int ret = 0;
 
 	if (cdns_power_is_lost(cdns)) {
-		if (cdns->role_sw) {
-			cdns->role = cdns_role_get(cdns->role_sw);
-		} else {
+		if (!cdns->role_sw) {
 			real_role = cdns_hw_role_state_machine(cdns);
 			if (real_role != cdns->role) {
 				ret = cdns_hw_role_switch(cdns);
-- 
2.51.0




