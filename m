Return-Path: <stable+bounces-210509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DXtCmlYcWkNEwAAu9opvQ
	(envelope-from <stable+bounces-210509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:51:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1F5F138
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D39714EBB34
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36443635C;
	Tue, 20 Jan 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFxja0nK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F342883E
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914040; cv=none; b=WeFg3ZSsgv0kh4PqtMGeR5KAkoj4sQOrqXZ2QE610SmKSGBJoh4Bf0ITwjw/151xnfhHMxMuXF1e2abjmLFopF1nN5Fd+q5Hqd8OdjGaZT5Om7SLGtuo4XO3RlzFiFVETn6Cl7xBxvANHLFQM00NS2QFMwQ84vb3Z3hpyLiq4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914040; c=relaxed/simple;
	bh=hZnrNZfXst39zLGkbh10tf7ZjeDgW9+c30f9Hrffiek=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HYDN4LPKSQMQIludhIgwt/iGdypQztGwm5IfIzLpUcnXu5mDEtWpJj6m0Ykqfr2F59ko8s1ubCEFjqsxWM5PXsD/XAMefkv7pv1WMjiqPLVb7RfQtLEpjnLmirbMNv3AO/yzELxZ0E79D8NAQvJROvNucstgcG9tSpNPqPtDbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFxja0nK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08177C16AAE;
	Tue, 20 Jan 2026 13:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768914039;
	bh=hZnrNZfXst39zLGkbh10tf7ZjeDgW9+c30f9Hrffiek=;
	h=Subject:To:Cc:From:Date:From;
	b=hFxja0nKXKSCQcGSDbCVnw/FCmvj0dgR8mJ6sZw1k2vwoSruNkhg4O3mKXM3TwTSW
	 cnOQiPevAPPTXswmWfOaw1sEGPgQ1x0Sg3fsWsiKOwYa4635rwaQZ4mg/FtrNFpPZh
	 lnxgRPP/TuoYikZclgih8/FxX1Iu0RtVu/esk4ds=
Subject: FAILED: patch "[PATCH] phy: rockchip: inno-usb2: Fix a double free bug in" failed to apply to 6.12-stable tree
To: vulab@iscas.ac.cn,neil.armstrong@linaro.org,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 14:00:36 +0100
Message-ID: <2026012036-dress-salvaging-8848@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[33];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210509-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linaro.org:email,msgid.link:url,gregkh:email]
X-Rspamd-Queue-Id: B9A1F5F138
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e07dea3de508cd6950c937cec42de7603190e1ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012036-dress-salvaging-8848@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e07dea3de508cd6950c937cec42de7603190e1ca Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Fri, 9 Jan 2026 15:46:26 +0000
Subject: [PATCH] phy: rockchip: inno-usb2: Fix a double free bug in
 rockchip_usb2phy_probe()

The for_each_available_child_of_node() calls of_node_put() to
release child_np in each success loop. After breaking from the
loop with the child_np has been released, the code will jump to
the put_child label and will call the of_node_put() again if the
devm_request_threaded_irq() fails. These cause a double free bug.

Fix by returning directly to avoid the duplicate of_node_put().

Fixes: ed2b5a8e6b98 ("phy: phy-rockchip-inno-usb2: support muxed interrupts")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260109154626.2452034-1-vulab@iscas.ac.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index e5efae7b0135..8f4c08e599aa 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1495,7 +1495,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 						rphy);
 		if (ret) {
 			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
-			goto put_child;
+			return ret;
 		}
 	}
 


