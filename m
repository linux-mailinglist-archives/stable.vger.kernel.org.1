Return-Path: <stable+bounces-269369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yTTlFqqCP2oeUAkAu9opvQ
	(envelope-from <stable+bounces-269369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 09:58:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C76D16D8
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 09:58:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=stu.xidian.edu.cn header.s=dkim header.b=qMNL0ixL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269369-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269369-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=xidian.edu.cn (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59E0930095E1
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208437F8DB;
	Sat, 27 Jun 2026 07:58:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849637AA78;
	Sat, 27 Jun 2026 07:58:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782547108; cv=none; b=W2DbMxmVJAuVnOlF5fy3/45O6XuVylurAlGmHpm0EQ1X1Ffs6L78MRNTWGH/ToZT/WjJGWgeO3dOYHnQaSHKoxTrr66cOmk8D65q+q6UMPsL2wCdyjHZ2/DABlpW2FthsJSwyvm95lNBM3+7CrwN0TRowruiOPPJNu8qM9Tr958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782547108; c=relaxed/simple;
	bh=uKsmwRbFkAPzLSbmz/EgjDiiE/b+rvjpTIO9sq9y184=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UISC7SWGYx9zPvFzT2yilqr+/6Y8yKXZz2uiOX2eykLFEVoYf0Emo5Noq6CU5zUGPL1cqi9tFEkebs5f1Q+l6Wl2Q2Uy8kayjPOxH0g1rrJQtuc6XjGSyhzvvOh3Ig5GvLQQe0NbnYqOXOJTUQ++Y5L7/vh7Gkre2LHwHvZ+EkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=qMNL0ixL reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Lrqx86hECs
	lCO4nKXn0DaJ+MUmPGKXBLgwU+8p/idZk=; b=qMNL0ixLB+8kE5HZm8Et8UMO8l
	GGJuv8QhoIy7PJvcHWT8Ok2d7dVWozKlpXACoEqx4jGXEG/wi9Y/SiNeVw9OFKXY
	K8HIfBpjHwxHIhQSuqfJAN99gNUC+aOKJr3WDtA4Nrek5wAvGITGgHiJHzKgL/qz
	vrklTWcFkSeM2Ha8k=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkBGjjOOgj9qNFsdAA--.20220S2;
	Sat, 27 Jun 2026 15:58:10 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: jdelvare@suse.com,
	andi.shyti@kernel.org
Cc: wsa@kernel.org,
	hkallweit1@gmail.com,
	djkurtz@chromium.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] i2c: i801: Fix hardware state machine corruption and stack-out-of-bounds
Date: Sat, 27 Jun 2026 15:58:04 +0800
Message-Id: <20260627075804.478990-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkBGjjOOgj9qNFsdAA--.20220S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1fWw47Ww1xZr4UtryDtrb_yoWrGry3pa
	1jk3s0vr4Dtr4akFn8tr4rZFyF9a1rGrWUGr9Fgw1DZa13G340yFyrtFyY9F4vv34jvaya
	qa4UtFnruF1jya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr
	0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnvtADUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAQUREWo+l+ZrMQAAs7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xidian.edu.cn : SPF not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jdelvare@suse.com,m:andi.shyti@kernel.org,m:wsa@kernel.org,m:hkallweit1@gmail.com,m:djkurtz@chromium.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:25181214217@stu.xidian.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[25181214217@stu.xidian.edu.cn,stable@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_PERMFAIL(0.00)[stu.xidian.edu.cn:s=dkim];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269369-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,chromium.org,vger.kernel.org,stu.xidian.edu.cn];
	DKIM_TRACE(0.00)[stu.xidian.edu.cn:~];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[25181214217@stu.xidian.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,stu.xidian.edu.cn:mid,stu.xidian.edu.cn:from_mime,xidian.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D2C76D16D8

Under extreme conditions (e.g., fault injection or transaction timeouts),
the i801 SMBus controller driver exhibits two error handling issues:

1. When i801_check_pre() fails, the driver jumps to the 'out' label
   and clears the INUSE_STS and status flags without holding hardware
   ownership, corrupting the hardware state machine.

2. When a transaction aborts and returns from i801_access(), the
   stack-allocated union i2c_smbus_data is destroyed. However,
   priv->data is not cleared. A spurious interrupt can then trigger a
   stack-out-of-bounds read in i801_isr_byte_done(), caught by KASAN:

  BUG: KASAN: stack-out-of-bounds in i801_isr_byte_done drivers/i2c/busses/i2c-i801.c:592 [inline]
  BUG: KASAN: stack-out-of-bounds in i801_isr drivers/i2c/busses/i2c-i801.c:648 [inline]
  Read of size 1 at addr ffff8881026dfd91 by task in:imklog/218

  CPU: 2 UID: 0 PID: 218 Comm: in:imklog Tainted: G        W        N  7.1.0+ #1
  Call Trace:
   <IRQ>
   ...
   kasan_report+0xca/0x100 mm/kasan/report.c:595
   i801_isr_byte_done drivers/i2c/busses/i2c-i801.c:592 [inline]
   i801_isr drivers/i2c/busses/i2c-i801.c:648 [inline]
   __handle_irq_event_percpu+0x222/0x830 kernel/irq/handle.c:209
   ...
   </IRQ>

Fix these issues by:
- Bypassing hardware register cleanup if i801_check_pre() fails.
- Using WRITE_ONCE() to clear priv->data in the exit path, paired with
  READ_ONCE() in the ISR.
- Calling synchronize_irq() conditionally on the error path before
  returning to ensure any in-flight ISR finishes before stack memory
  is reclaimed.

Fixes: 1f760b87e54c ("i2c: i801: Call i801_check_pre() from i801_access()")
Fixes: d3ff6ce40031 ("i2c-i801: Enable IRQ for byte_by_byte transactions")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
Changes in v2:
 - Split error paths to bypass hardware register cleanup on pre-check
   failure.
 - Added READ_ONCE() check in ISR to prevent OOB access.
 - Conditionally use WRITE_ONCE() and synchronize_irq() on the error
   path to prevent race condition without performance regression.

 drivers/i2c/busses/i2c-i801.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 32a3cef02c7b..a14d26ee938d 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -562,6 +562,13 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
 
 static void i801_isr_byte_done(struct i801_priv *priv)
 {
+	/*
+	 * Use READ_ONCE to prevent compiler optimization and ensure
+	 * visibility of the cleared pointer from the process context.
+	 */
+	if (unlikely(!READ_ONCE(priv->data)))
+		return;
+
 	if (priv->is_read) {
 		/*
 		 * At transfer start i801_smbus_block_transaction() marks
@@ -905,7 +912,7 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 
 	ret = i801_check_pre(priv);
 	if (ret)
-		goto out;
+		goto out_err;
 
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
 		&& size != I2C_SMBUS_QUICK
@@ -938,6 +945,17 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	 */
 	iowrite8(SMBHSTSTS_INUSE_STS | STATUS_FLAGS, SMBHSTSTS(priv));
 
+out_err:
+	/*
+	 * Prevent UAF/OOB in the ISR.
+	 * For successful transactions, the ISR has completed. For aborted or
+	 * timed-out transactions, flush any in-flight interrupts before
+	 * destroying the stack-allocated data.
+	 */
+	WRITE_ONCE(priv->data, NULL);
+	if (unlikely(ret != 0 && (priv->features & FEATURE_IRQ)))
+		synchronize_irq(priv->pci_dev->irq);
+
 	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
 	mutex_unlock(&priv->acpi_lock);
 	return ret;
-- 
2.34.1


