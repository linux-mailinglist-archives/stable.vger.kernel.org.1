Return-Path: <stable+bounces-238616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mq0nIpYR5GmpQAEAu9opvQ
	(envelope-from <stable+bounces-238616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 01:19:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAEC42293D
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 01:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D354301951A
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 23:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCE0312826;
	Sat, 18 Apr 2026 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uie/wktH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01587239E7D
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776554385; cv=none; b=qJAjxpkhAOZwPHyBSo5pksQgRx6hShDB0UUyVF57NdmqdRZi5m275A+EYRWhtwDc0LpFE5mWiObIuybtZlfwVmDSNDkyjVmgdm35rkUg6Bw6yLkjmzJCQ+KKp7Bv/3t7owqP0//bL7zAJbu+Qb+MF5JRzj0ZeKneY5nHY39v4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776554385; c=relaxed/simple;
	bh=MD2UontMftkg1gI0xmR4BUolmbWb4P/h19KYEa0qgBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jxoCXxfvAwiz0R3WfOSWJb1SFHsT62f6Jgo9p7Hxh9pj8APBzWO2BVipPGNMntyzSVtVvOEebqKyH1KFPNdCgFHerZ1SIam9dk/b2qj4jqcOiU05ivdGy1K1MraJMX8ZRW2leb9tLrTXttIZN5Da4sM67Wuy9L1F08m3mKMEa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uie/wktH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE1CC19424;
	Sat, 18 Apr 2026 23:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776554384;
	bh=MD2UontMftkg1gI0xmR4BUolmbWb4P/h19KYEa0qgBE=;
	h=From:To:Cc:Subject:Date:From;
	b=Uie/wktHZVu2HpiAuIAWxTgwoSKefcP2+hzbQicqHtiYUQYFOMV3fMJTWkNpEoxVL
	 l5PTQQqs4xqPvFBJB2iqgjCDKJdUZTK5lO6Nu+iV4Zr0aYFWv1t5cJj63E+UvMVZBu
	 LLGdDLjECdXXjrhmssqS9Y2nnqu5VRN4+59i6HLH0nDylsQ8wa9UsHgi3Itt/Ny8MD
	 dyTAP5qt7vU3E/cFrriywwBIRftc6XboIQ/jyENK9UiGTt1ifx4B32u+Q89cV3Ru3h
	 2RVb3ERWUfI/eBm5ZnMo5MyDDDGTMM3gVp/gXa09/U1iP8GlB/IZIPOkbPX0LbkkcR
	 Plt4H1J6hf8AA==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.15] i3c: fix uninitialized variable use in i2c setup
Date: Sat, 18 Apr 2026 16:19:28 -0700
Message-ID: <20260418231928.994943-1-nathan@kernel.org>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238616-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EAEC42293D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jamie Iles <quic_jiles@quicinc.com>

commit 6cbf8b38dfe3aabe330f2c356949bc4d6a1f034f upstream.

Commit 31b9887c7258 ("i3c: remove i2c board info from i2c_dev_desc")
removed the boardinfo from i2c_dev_desc to decouple device enumeration from
setup but did not correctly lookup the i2c_dev_desc to store the new
device, instead dereferencing an uninitialized variable.

Lookup the device that has already been registered by address to store
the i2c client device.

Fixes: 31b9887c7258 ("i3c: remove i2c board info from i2c_dev_desc")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Jamie Iles <quic_jiles@quicinc.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20220308134226.1042367-1-quic_jiles@quicinc.com
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This fixes the previously reported -Wuninitialized that gets upgraded to
an error on 5.15:

  drivers/i3c/master.c:2203:3: error: variable 'i2cdev' is uninitialized when used here [-Werror,-Wuninitialized]
   2203 |                 i2cdev->dev = i2c_new_client_device(adap, &i2cboardinfo->base);
        |                 ^~~~~~

As my previous messages pointing out this fix for a simple cherry-pick were
seemingly ignored, I sent the patch hoping it would get this issue finally
resolved.

https://lore.kernel.org/20260318023542.GA2596820@ax162/
https://lore.kernel.org/20260413185112.GA501334@ax162/
---
 drivers/i3c/master.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index dee694024f28..5df943d25cf0 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2199,8 +2199,13 @@ static int i3c_master_i2c_adapter_init(struct i3c_master_controller *master)
 	 * We silently ignore failures here. The bus should keep working
 	 * correctly even if one or more i2c devices are not registered.
 	 */
-	list_for_each_entry(i2cboardinfo, &master->boardinfo.i2c, node)
+	list_for_each_entry(i2cboardinfo, &master->boardinfo.i2c, node) {
+		i2cdev = i3c_master_find_i2c_dev_by_addr(master,
+							 i2cboardinfo->base.addr);
+		if (WARN_ON(!i2cdev))
+			continue;
 		i2cdev->dev = i2c_new_client_device(adap, &i2cboardinfo->base);
+	}
 
 	return 0;
 }

base-commit: b9d57c40a767db4d2ef905abb91f73cbe0a791e1
-- 
2.53.0


