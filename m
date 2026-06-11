Return-Path: <stable+bounces-262693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IidRI/auKmq0uwMAu9opvQ
	(envelope-from <stable+bounces-262693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 14:49:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B71167206E
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 14:49:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262693-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262693-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D18300B5B5
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0EC3F8ED8;
	Thu, 11 Jun 2026 12:49:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3463F44EE;
	Thu, 11 Jun 2026 12:49:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182195; cv=none; b=EFC5km4PQiuiVpTOTsAIf3pf+pQj68TK9poUK1OxKdtLtJbnvDNko2t9a6sCFveJUC/hTggMiSrgjb3muIoinVXA5BTIyFdoKej+7ECoSz7RAEtKgjrpSCiQ0Tc6yK/B8OvQ9pkCjPP4KTOc97zVtUD64VG5Cr3+yMU98ZdDXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182195; c=relaxed/simple;
	bh=+CIffkiCpybkFqljx4po8zyKQJgzZwg28AYJiPCM+Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4MgI906Nxb6dZ0Ly6j6yyiVpsgFMWYTjBjAIkAfBTwZKAorVZKo/xQ9+wZRPzIQEZeTtwLNez3xoUB0S+4cScVNSu9rzh2thd5M7K9KSm6WZbzfM64pncxKf9+Q4sRwJ377bOpRb5u8tF8rh3vNS9hAI+qCh8tiMUBFVXCIZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowAAngNPmripqi+wVEw--.407S2;
	Thu, 11 Jun 2026 20:49:44 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: peter.chen@kernel.org,
	gregkh@linuxfoundation.org,
	thierry.reding@kernel.org,
	jonathanh@nvidia.com
Cc: linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: chipidea: tegra: fix refcount leak in tegra_usb_reset_controller()
Date: Thu, 11 Jun 2026 20:49:40 +0800
Message-ID: <20260611124940.80010-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAngNPmripqi+wVEw--.407S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrAw18Xr17tw18Aw15XFb_yoW8XFy5pF
	4jk3y7CFWDtw4rAa17Jw15uFyfWanIyrW5Gws3t34rZwsxG3yUJryjkayFgasrAr4qga90
	qr4UKF95uFyIvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8PA2oqh4V3ewAAsE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262693-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:peter.chen@kernel.org,m:gregkh@linuxfoundation.org,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:linux-usb@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B71167206E

In tegra_usb_reset_controller(), reset_control_deassert() is called on
a shared reset control to increment its deassert_count before toggling
the reset line.  If the subsequent reset_control_assert() call fails
(e.g. due to a missing reset controller device or an invalid internal
state), the function returns an error without ever balancing the prior
deassert.  Since the reset control is shared, the leaked deassert_count
remains elevated, preventing future reset_control_assert() calls from
taking effect on the reset line and leaving the USB controller in an
inconsistent state.

Fix the leak by calling reset_control_deassert() in the error path of
reset_control_assert(), ensuring the usage counter is properly balanced
before returning the error.

Cc: stable@vger.kernel.org
Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 372788f0f970..8d313345665c 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -138,8 +138,10 @@ static int tegra_usb_reset_controller(struct device *dev)
 		return err;
 
 	err = reset_control_assert(rst);
-	if (err)
+	if (err) {
+		reset_control_deassert(rst);
 		return err;
+	}
 
 	udelay(1);
 
-- 
2.50.1 (Apple Git-155)


