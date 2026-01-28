Return-Path: <stable+bounces-212243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJFbKhY3eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:19:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C738A56B9
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A60930A1960
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD592F6921;
	Wed, 28 Jan 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQWH4Lht"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2302E764D;
	Wed, 28 Jan 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614863; cv=none; b=UHzAtrkc6Dra088chai8CChVbHb2mtWVeiLhscY/aI5QbfpsuJ9+8/4qzNyHeh8fi+ZlQVt6GMlpDEDO2d4GuR53UGSgKnVq3NMR4QvfmVe3v+7NHiOuwinMPIWme9FAtRerkdZ+98K6sJTX5wC0JNTx1aNorbi8Gtqehc283+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614863; c=relaxed/simple;
	bh=3SkcTKh2pgUnO89s5PO8f2E7SyK0CSl/aRr1aiqtlx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoJJWZ+iqX9qfJdHEEjJWp/ixyImf6kDIHe0K4nSeax0S/LTlnYVLtNPtlwkZWzhZDU0wXuQDbMGE+fWrp2Rqt9nGD2o/GZ1uCT72OS9AM1u1NYhsso99MtsuAc0nBQxXvNb30bND5oK2vlIc9FJBYheMLDO6LPBF3epF2Cx8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQWH4Lht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3FEC116C6;
	Wed, 28 Jan 2026 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614863;
	bh=3SkcTKh2pgUnO89s5PO8f2E7SyK0CSl/aRr1aiqtlx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQWH4LhtN5BZzkzcK+WwshPi427zAtito0w1eBzgnK5qqNqTG6rOYqo/I7hNONVWp
	 lheUxzQRrEwyCutKajxi+xhsXFk7ym1UJ2N5pbr1o2atFZcy3cjKPEMk3TfvfjqKWm
	 EugzFi1u4AU5D9I0wmYJ8S+ay/tGrnWU8ktf3KvE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Wojtek Wasko <wwasko@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 002/169] ptp: Add PHC file mode checks. Allow RO adjtime() without FMODE_WRITE.
Date: Wed, 28 Jan 2026 16:21:25 +0100
Message-ID: <20260128145334.099814052@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.dev,nvidia.com,linutronix.de,davemloft.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212243-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,davemloft.net:email]
X-Rspamd-Queue-Id: 2C738A56B9
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wojtek Wasko <wwasko@nvidia.com>

[ Upstream commit b4e53b15c04e3852949003752f48f7a14ae39e86 ]

Many devices implement highly accurate clocks, which the kernel manages
as PTP Hardware Clocks (PHCs). Userspace applications rely on these
clocks to timestamp events, trace workload execution, correlate
timescales across devices, and keep various clocks in sync.

The kernel’s current implementation of PTP clocks does not enforce file
permissions checks for most device operations except for POSIX clock
operations, where file mode is verified in the POSIX layer before
forwarding the call to the PTP subsystem. Consequently, it is common
practice to not give unprivileged userspace applications any access to
PTP clocks whatsoever by giving the PTP chardevs 600 permissions. An
example of users running into this limitation is documented in [1].
Additionally, POSIX layer requires WRITE permission even for readonly
adjtime() calls which are used in PTP layer to return current frequency
offset applied to the PHC.

Add permission checks for functions that modify the state of a PTP
device. Continue enforcing permission checks for POSIX clock operations
(settime, adjtime) in the POSIX layer. Only require WRITE access for
dynamic clocks adjtime() if any flags are set in the modes field.

[1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html

Changes in v4:
- Require FMODE_WRITE in ajtime() only for calls modifying the clock in
  any way.

Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_chardev.c | 16 ++++++++++++++++
 kernel/time/posix-clock.c |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index bf6468c56419c..4380e6ddb8495 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -205,6 +205,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_EXTTS_REQUEST:
 	case PTP_EXTTS_REQUEST2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (copy_from_user(&req.extts, (void __user *)arg,
@@ -246,6 +250,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_PEROUT_REQUEST:
 	case PTP_PEROUT_REQUEST2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (copy_from_user(&req.perout, (void __user *)arg,
@@ -314,6 +322,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_ENABLE_PPS:
 	case PTP_ENABLE_PPS2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		memset(&req, 0, sizeof(req));
 
 		if (!capable(CAP_SYS_TIME))
@@ -456,6 +468,10 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 
 	case PTP_PIN_SETFUNC:
 	case PTP_PIN_SETFUNC2:
+		if ((pccontext->fp->f_mode & FMODE_WRITE) == 0) {
+			err = -EACCES;
+			break;
+		}
 		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {
 			err = -EFAULT;
 			break;
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 4e114e34a6e0a..fe963384d5c2a 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -252,7 +252,7 @@ static int pc_clock_adjtime(clockid_t id, struct __kernel_timex *tx)
 	if (err)
 		return err;
 
-	if ((cd.fp->f_mode & FMODE_WRITE) == 0) {
+	if (tx->modes && (cd.fp->f_mode & FMODE_WRITE) == 0) {
 		err = -EACCES;
 		goto out;
 	}
-- 
2.51.0




