Return-Path: <stable+bounces-212242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CHkIRkxemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3392A4AA7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9915230E81A0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229282FD7D5;
	Wed, 28 Jan 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tUM1bXOn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2B22F5473;
	Wed, 28 Jan 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614860; cv=none; b=Cji1y1NBop2xLAzYLiv37UHcRqZzDFRQ1+nIA1bIzRRgOmShReuAaRXWh7EVtccgA79+8DqG/xOfj0q5KkM/LXF++oAWc6M0pl0cj7dFRh3cjrV7omettooucqOxYl1Aln4x4Fr4srUCeMn3IWdgi3T2CgvVb4bkBB+jtPNcGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614860; c=relaxed/simple;
	bh=t8SVoBzG200rbJ3GnMePWMIQrHD3r7cE2TKSnh7187M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kc3HJcnHkqLm81vlTII+NL4boTzX39BLdYCsF+otjgfKKd+6jwbSohynKR3J/LJ0/bGHNoQFppMhKbxxiIgRoTalPCuWcOhW/WqDw0eHPegiEgnJp9bUHcQhOyqTDbC/GM9jCYoKFn2c6lapMnEZrQvn29xpTwBcxmUjATYDCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tUM1bXOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D65C4CEF1;
	Wed, 28 Jan 2026 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614859;
	bh=t8SVoBzG200rbJ3GnMePWMIQrHD3r7cE2TKSnh7187M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tUM1bXOn/0mUMDfZgIuFZjsmmoHWxTZgh2XXMwjIclK+8vM2l/AMRhoPEEZO1Lflb
	 JGktq5f+JBi761gqDklfmrN+33Bs0vc+NwT3F1upg+49daPmmPYewwB8DsgQuHs/rQ
	 cBZYfvnxevlNJ4zxeVCMX9NRV5uk9oTRXZRDi8mU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wojtek Wasko <wwasko@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 001/169] posix-clock: Store file pointer in struct posix_clock_context
Date: Wed, 28 Jan 2026 16:21:24 +0100
Message-ID: <20260128145334.064031969@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-212242-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.dev,linutronix.de,nvidia.com,davemloft.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A3392A4AA7
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wojtek Wasko <wwasko@nvidia.com>

[ Upstream commit e859d375d1694488015e6804bfeea527a0b25b9f ]

File descriptor based pc_clock_*() operations of dynamic posix clocks
have access to the file pointer and implement permission checks in the
generic code before invoking the relevant dynamic clock callback.

Character device operations (open, read, poll, ioctl) do not implement a
generic permission control and the dynamic clock callbacks have no
access to the file pointer to implement them.

Extend struct posix_clock_context with a struct file pointer and
initialize it in posix_clock_open(), so that all dynamic clock callbacks
can access it.

Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/posix-clock.h | 6 +++++-
 kernel/time/posix-clock.c   | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index ef8619f489203..a500d3160fe8c 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -95,10 +95,13 @@ struct posix_clock {
  * struct posix_clock_context - represents clock file operations context
  *
  * @clk:              Pointer to the clock
+ * @fp:               Pointer to the file used to open the clock
  * @private_clkdata:  Pointer to user data
  *
  * Drivers should use struct posix_clock_context during specific character
- * device file operation methods to access the posix clock.
+ * device file operation methods to access the posix clock. In particular,
+ * the file pointer can be used to verify correct access mode for ioctl()
+ * calls.
  *
  * Drivers can store a private data structure during the open operation
  * if they have specific information that is required in other file
@@ -106,6 +109,7 @@ struct posix_clock {
  */
 struct posix_clock_context {
 	struct posix_clock *clk;
+	struct file *fp;
 	void *private_clkdata;
 };
 
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2cc45c0..4e114e34a6e0a 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -129,6 +129,7 @@ static int posix_clock_open(struct inode *inode, struct file *fp)
 		goto out;
 	}
 	pccontext->clk = clk;
+	pccontext->fp = fp;
 	if (clk->ops.open) {
 		err = clk->ops.open(pccontext, fp->f_mode);
 		if (err) {
-- 
2.51.0




