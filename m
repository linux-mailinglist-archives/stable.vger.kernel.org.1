Return-Path: <stable+bounces-245432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DQbFxL3AmqvzAEAu9opvQ
	(envelope-from <stable+bounces-245432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:46:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F451E037
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700FC3013794
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECA3B27DB;
	Tue, 12 May 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DOi+iGsj"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF93A3E97;
	Tue, 12 May 2026 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578587; cv=none; b=mn80A7Q9MaGUJlM5FCvl5bc7O2EZZWH2qsw3wOO7zl2h+IcBnblMCqxWocSe6whfqRPDpGpVAM+uqQCofgpnOrGnZF0bsXcICCMwZh9V6IPLDVcOuTQuIy/pwpjP7jEgFPROJm+zc4xwfxRDxV8vSIBxP8s0qJrfvwsnIv95gsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578587; c=relaxed/simple;
	bh=NnrNnFy9Y1vO5MXisXKwMIEOG7SFfUeXATqrBPEJLEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJb8dVm+L8Bb77hDzhiTuXlfYP0IEDORiWBowubZA8jLJxZ8FLgM/KLnORyz10iU8j3dpjiftm5jaUHpKRtmLfIuR4YDgMcp7Gki2MxJaUJ+wk4ZLTWF7+WdO+KFhv7RQfmJ8OC2CmL3uusl7wfaYSi4BGKKtB9nZq2d+kne7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DOi+iGsj; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IS
	HE+wcoI0DEJx32nE6Rs/MB0pl+aIUtEQO/LvMDFyU=; b=DOi+iGsjbkM8oIcZO7
	1MxT+NQjqUFk8IN5UUDilGee4IRlf62cGw6HsJBUBrYfAHKThExAmyM3UbpEgWoV
	IVZHdAVCGfJcjRtAMeIrYccp1Jilv5ZvVXUqJndSf6fckuyInuYfeKTcfe6JsNT6
	wyKP0+K063zxEDDSKbhQ+4Mto=
Received: from wmy.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3Hxdo9AJqoF2gAw--.21286S2;
	Tue, 12 May 2026 17:35:52 +0800 (CST)
From: <w15303746062@163.com>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] i2c: i801: fix hardware state machine corruption in error path
Date: Tue, 12 May 2026 17:35:34 +0800
Message-Id: <20260512093534.348655-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Hxdo9AJqoF2gAw--.21286S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw18Zr43AF1DWryxtrW8Zwb_yoW5XFWUpa
	yUKrZ0k34Dta1j9F4DJF4xuFyruw1fGay7Kr1vk3W5Za13G3WFvryIqFy5uFykJ3savaya
	qF1qqa9ruF4qvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzwZcUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5Bl2WmoC9HnUvgAA3e
X-Rspamd-Queue-Id: B73F451E037
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245432-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	R_DKIM_ALLOW(0.00)[163.com:s=s110527];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w15303746062@163.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[163.com,none];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.014];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xidian.edu.cn:email]
X-Rspamd-Action: no action

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

A severe livelock and subsequent Hung Task panic were observed in the
i2c-i801 driver during concurrent Fuzzing. The crash is caused by an
unconditional hardware register cleanup in the error handling path of
i801_access().

When i801_check_pre() fails (e.g., returning -EBUSY because the SMBus
controller is actively used by BIOS/ACPI), the kernel does not actually
acquire the hardware ownership. However, the code jumps to the 'out'
label and executes:

    iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));

This forcefully clears the INUSE_STS lock and resets the hardware status
flags without owning the controller. Doing so interrupts ongoing BIOS/ACPI
transactions and totally corrupts the SMBus hardware state machine.

Consequently, all subsequent i801_access() calls fail at the pre-check
stage, triggering an endless stream of "SMBus is busy, can't use it!"
error logs. Over a slow serial console, this printk flood monopolizes
the CPU (Console Livelock), starving other processes trying to acquire
the mmap_lock down_read semaphore, ultimately triggering the hung task
watchdog.

Fix this by moving the 'out' label below the hardware register cleanup.
If i801_check_pre() fails, we safely bypass the iowrite8() and only
release the software locks (pm_runtime and mutex), strictly adhering to
the rule of not releasing resources that were never acquired.

Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
Cc: stable@vger.kernel.org # v6.3+

Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
 - Reused and moved the existing 'out' label instead of adding a new one,
   fixing a build warning regarding an unused label.
 - Dropped the inaccurate mention of "another thread" in the commit message,
   as i801_access() is serialized by a mutex.
 - Added Fixes and Cc stable tags as suggested.

 drivers/i2c/busses/i2c-i801.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..b29c99ed3883 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -931,13 +931,13 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	 */
 	if (hwpec)
 		iowrite8(ioread8(SMBAUXCTL(priv)) & ~SMBAUXCTL_CRC, SMBAUXCTL(priv));
-out:
 	/*
 	 * Unlock the SMBus device for use by BIOS/ACPI,
 	 * and clear status flags if not done already.
 	 */
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
+out:
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
 	mutex_unlock(&priv->acpi_lock);
 	return ret;
-- 
2.34.1


