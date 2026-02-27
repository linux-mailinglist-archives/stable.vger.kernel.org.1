Return-Path: <stable+bounces-219893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFUCE90BoWlVpQQAu9opvQ
	(envelope-from <stable+bounces-219893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:30:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB9C1B20D5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71073304D258
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 02:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1852D3231;
	Fri, 27 Feb 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HgBqOf6V"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4E92C0298
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159420; cv=none; b=FoEF3+w4yore+Tz77cjqUH+l7ahjcc1nG3lISGu2HSwlYHy6OVwKRIZybOWoS5Nh/uoKjYArYgCxRcFp1f1bRzoigvCw886KkT62J19+wEc18EugqonmBzc4GaA7z4e0grsRzyjYt20z30bYDadmnnEve9ymXoAqEX7n6aa1lhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159420; c=relaxed/simple;
	bh=pQ0MFWAxCxFLIZNr76cL3VIHJBTqVratI5ShPt7AhAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDbb/cDWX65KAuWIL1+pcTQWA2c0kuSlwmJi1g3KdICdHCLkHD2azjC8JK8Ko+VfF6w15BWGMlGSvGvQwOaoiQlA0jofcG5mEw+Ov/YgSITX3gQAzib8M5fob6hupshN9tTm3zIsdYuvTuu74XNAuHGLzG44weHliA0F8xTMacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HgBqOf6V; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Lw
	jabNB3JnR2Q0SZOOjUX3FitX+XlP+BsG4D3eosGpc=; b=HgBqOf6VCPEzqm818m
	VTvIcBA3gbjm58Y0y65QE2cqrc/yAD//qUaLMNqAkp23uVLMyVOlG7dxDyLybMM6
	W8nYqdXkOz7GEYEmCaak6knIvwr/yPS9+yqn8Jt1SpA7IVkSCZqkcBa5+8bH7tyz
	K2ow3KGTnLYkB939Yveg9BTc8=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnmZGTAaFpctbSQg--.72S2;
	Fri, 27 Feb 2026 10:29:41 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] ice: fix devlink reload call trace
Date: Fri, 27 Feb 2026 10:29:14 +0800
Message-Id: <20260227022914.1378328-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnmZGTAaFpctbSQg--.72S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1rGFWDuw18GFWfuw13twb_yoW5Wr4fpF
	W8C34YkF1rXr4S9w4DWa18uF15Wa95J3s09Fs7Cw4rZ3WDCrn0vrnrtFya9FykCw4IqFWa
	yr40kw1jkas8ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_ID7rUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7BUo8GmhAZXaaQAA3O
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219893-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,molgen.mpg.de,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mpg.de:email]
X-Rspamd-Queue-Id: 7AB9C1B20D5
X-Rspamd-Action: no action

From: Paul Greenwalt <paul.greenwalt@intel.com>

[ Upstream commit d3f867e7a04678640ebcbfb81893c59f4af48586 ]

Commit 4da71a77fc3b ("ice: read internal temperature sensor") introduced
internal temperature sensor reading via HWMON. ice_hwmon_init() was added
to ice_init_feature() and ice_hwmon_exit() was added to ice_remove(). As a
result if devlink reload is used to reinit the device and then the driver
is removed, a call trace can occur.

BUG: unable to handle page fault for address: ffffffffc0fd4b5d
Call Trace:
 string+0x48/0xe0
 vsnprintf+0x1f9/0x650
 sprintf+0x62/0x80
 name_show+0x1f/0x30
 dev_attr_show+0x19/0x60

The call trace repeats approximately every 10 minutes when system
monitoring tools (e.g., sadc) attempt to read the orphaned hwmon sysfs
attributes that reference freed module memory.

The sequence is:
1. Driver load, ice_hwmon_init() gets called from ice_init_feature()
2. Devlink reload down, flow does not call ice_remove()
3. Devlink reload up, ice_hwmon_init() gets called from
   ice_init_feature() resulting in a second instance
4. Driver unload, ice_hwmon_exit() called from ice_remove() leaving the
   first hwmon instance orphaned with dangling pointer

Fix this by moving ice_hwmon_exit() from ice_remove() to
ice_deinit_features() to ensure proper cleanup symmetry with
ice_hwmon_init().

Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
[ Adjust context. The context change is irrelevant to the current patch
logic. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8e0f180ec38e..8683883e23b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4920,6 +4920,7 @@ static void ice_deinit_features(struct ice_pf *pf)
 		ice_dpll_deinit(pf);
 	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
 		xa_destroy(&pf->eswitch.reprs);
+	ice_hwmon_exit(pf);
 }
 
 static void ice_init_wakeup(struct ice_pf *pf)
@@ -5451,8 +5452,6 @@ static void ice_remove(struct pci_dev *pdev)
 		ice_free_vfs(pf);
 	}
 
-	ice_hwmon_exit(pf);
-
 	ice_service_task_stop(pf);
 	ice_aq_cancel_waiting_tasks(pf);
 	set_bit(ICE_DOWN, pf->state);
-- 
2.43.0


