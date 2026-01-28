Return-Path: <stable+bounces-212069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMlBGpsuemlq3wEAu9opvQ
	(envelope-from <stable+bounces-212069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:43:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE795A44A6
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54F3D30D5D17
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FA113B7A3;
	Wed, 28 Jan 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gW5eDavs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C723EAB7;
	Wed, 28 Jan 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614296; cv=none; b=D+0ldyhGiVBFSMUc1AA27skz0TRc1eu9dzzzoFuwLoQXXOpeWue22+3N17DXK5TYrYEYUxDaOStgNXGgbFPaw+g6wZgO9GWRgNYCui+tQN8qGyo3RM6TmRhm8XiCKpfBmCyhWqP7iM69tIVZR2Bzuw0dly/FlhlynDf9MqKeyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614296; c=relaxed/simple;
	bh=amKYw3QpffiPMJ5mdy8dtv6E91vLuHRVn7X7PtNuCbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1QJsgdKtbwalC0tE1jXv63tgxMvW82IgCrS2HD2N+lGRBlzAQs2xNzokoTh07wGJ4qRK7hfqfJTBGJS2SIptxqhv92r9tlnEbLqtBUhNx6H7AJJH7OryRVCKKGKEPSLDYoKWEo8Unermv05TcFv827vp0j4KfNKxSjy1a8p5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gW5eDavs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E6FC4CEF1;
	Wed, 28 Jan 2026 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614296;
	bh=amKYw3QpffiPMJ5mdy8dtv6E91vLuHRVn7X7PtNuCbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gW5eDavsDgPgU14T+LCHbgIRiVi133oW5YCOs3278gOBmo4fpd2KRprxgjMLxo/4U
	 obtkFF0vLMqEbQFS4/xtx1ioEw3GgnqTpVnVtvBceB2ijTBjWQzcIAxfJFdIAMRNSK
	 knr/aegyirANFwFdUENykfu9dgRfoEqzsS6edsn8=
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
Subject: [PATCH 6.6 093/254] posix-clock: Store file pointer in struct posix_clock_context
Date: Wed, 28 Jan 2026 16:21:09 +0100
Message-ID: <20260128145348.174456760@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.dev,linutronix.de,nvidia.com,davemloft.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-212069-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE795A44A6
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index a6487a9d60853..b130bb56cc4e0 100644
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




