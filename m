Return-Path: <stable+bounces-232078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHimAaIDzGmPNQYAu9opvQ
	(envelope-from <stable+bounces-232078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:25:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E42236EAF3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F4BF32258FF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F43F8E04;
	Tue, 31 Mar 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UzU/PyHP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47D2C15B2;
	Tue, 31 Mar 2026 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975819; cv=none; b=TRlns7IZtOI7Qk31Jiu7HPpxeCEU1AjJFOM7PP5am/yv59/OWjcNGAwuGbzwdXyBaKJSw9it/dMmVLNeyP0g8GA+wHomJWWj5k4jToI1GJVK5o5s4szv2u71/COIjzv3nmgLi2Mb+xGfQwhfMuUQbUC8IhwUbwFeWu4yqUTiOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975819; c=relaxed/simple;
	bh=A4X22uY5dYjh/HFZXkbLFg10dpuqfpoT+hUJIY4NwB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL6xA9kjNdo8VszjRCSZm+COUQS7ux5JizVHdJAgFsB6ftLT+dzzeudIFjPCKjTjj4Y6aCBcIAgrZXG+y8sLDxhAzWsruAqhzq3mmeI/noXNgg6babVwwO2A8OjTkIio9AMWpD6Tpj/7M8kEwKEoK4QM5DfjfQq7NgK0S6NAUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UzU/PyHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83670C19423;
	Tue, 31 Mar 2026 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975818;
	bh=A4X22uY5dYjh/HFZXkbLFg10dpuqfpoT+hUJIY4NwB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzU/PyHPkA3lnc5eWyt7SZCQZkBCtLdKIpOqxfACaICehvfd7NCV4XEYp42/BjBxu
	 UyeiKhiFecsoylVMZI7kq4MQCVa2Y5Plq09ZElUGRqIEzTcnPFUDQbLI3liJxzMq6Z
	 UqquK9KGW0PFqT3Ya/mFgQuBiw5lu7iT66Zbu4xQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 097/244] Bluetooth: btusb: clamp SCO altsetting table indices
Date: Tue, 31 Mar 2026 18:20:47 +0200
Message-ID: <20260331161745.257577621@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232078-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 4E42236EAF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 129fa608b6ad08b8ab7178eeb2ec272c993aaccc ]

btusb_work() maps the number of active SCO links to USB alternate
settings through a three-entry lookup table when CVSD traffic uses
transparent voice settings. The lookup currently indexes alts[] with
data->sco_num - 1 without first constraining sco_num to the number of
available table entries.

While the table only defines alternate settings for up to three SCO
links, data->sco_num comes from hci_conn_num() and is used directly.
Cap the lookup to the last table entry before indexing it so the
driver keeps selecting the highest supported alternate setting without
reading past alts[].

Fixes: baac6276c0a9 ("Bluetooth: btusb: handle mSBC audio over USB Endpoints")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 9d3236321056b..b8bf4dfea11c2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2350,8 +2350,11 @@ static void btusb_work(struct work_struct *work)
 		if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_CVSD) {
 			if (hdev->voice_setting & 0x0020) {
 				static const int alts[3] = { 2, 4, 5 };
+				unsigned int sco_idx;
 
-				new_alts = alts[data->sco_num - 1];
+				sco_idx = min_t(unsigned int, data->sco_num - 1,
+						ARRAY_SIZE(alts) - 1);
+				new_alts = alts[sco_idx];
 			} else {
 				new_alts = data->sco_num;
 			}
-- 
2.51.0




