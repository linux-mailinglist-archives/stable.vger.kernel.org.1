Return-Path: <stable+bounces-247686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDklFS8QB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:23:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A30C154F66C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509AF30BA25C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85545BD57;
	Fri, 15 May 2026 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="utCJYCQ6"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F197843CEE9
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845564; cv=none; b=giIq/yvkxC86149Q6K4E41oVXjtVEytj0sgD5pQFV+WebvrPgJrEBvun5E1B0Ml8dHYf71RR4dVTI6pLWZNRVkgiycAok5PUfDFVyPZp+tn8K3JdCrdPSO+AaqmnvLQKpj8bKgQAxUPaud2x147E6znWq0el9evka7LERaD4t1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845564; c=relaxed/simple;
	bh=2iW10A+od+SYz8UGX3VEfEvxjcv6/yNCbTtZ4fJlAjc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=klXgYdO/4fMMbCH7JEu8vLdT2/kdeMA2WWXoJoMrIoFPd5PPkfs6j9Bp5mRbVSjrlOeEBM+eyGfjJ+lKn/6Echw1IfrtJ11Krfb7MZ6XWfDJDiQjAvrp2NRFnQUsY0+2zgjIxwg+g/R3zRnb7RiLKGfHd/73Vg4gM06pO20q+cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=utCJYCQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEA2C2BCB0;
	Fri, 15 May 2026 11:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845563;
	bh=2iW10A+od+SYz8UGX3VEfEvxjcv6/yNCbTtZ4fJlAjc=;
	h=Subject:To:From:Date:From;
	b=utCJYCQ6Jz2EY6LvrzLJpBuB4mFcyxH0088VwfxE26YHdygVwhUJKZ4QTaIAJ/vfs
	 MLAUBfZmJBSIJKQ0VMFnFz7ZBmJovIJpg+miWbyJGvlUmvZGWUZVqXOVP/hhHNh5su
	 3C1IU8CnSdA/MYiTPIHKdCtfOz+MSk8v5OsALLPw=
Subject: patch "iio: adc: nxp-sar-adc: Avoid division by zero" added to char-misc-linus
To: andriy.shevchenko@linux.intel.com,Stable@vger.kernel.org,daniel.lezcano@oss.qualcomm.com,jic23@kernel.org,lkp@intel.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:45:55 +0200
Message-ID: <2026051555-disbelief-kitty-8054@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A30C154F66C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247686-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,intel.com:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: adc: nxp-sar-adc: Avoid division by zero

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 7e5c0f97c66ad538b87c04a640573371fb434b4f Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 16 Apr 2026 11:01:22 +0200
Subject: iio: adc: nxp-sar-adc: Avoid division by zero

When Common Clock Framework is disabled, clk_get_rate() returns 0.
This is used as part of the divisor to perform nanosecond delays
with help of ndelay(). When the above condition occurs the compiler,
due to unspecified behaviour, is free to do what it wants to. Here
it saturates the value, which is logical from mathematics point of
view. However, the ndelay() implementation has set a reasonable
upper threshold and refuses to provide anything for such a long
delay. That's why code may not be linked under these circumstances.

To solve the issue, provide a wrapper that calls ndelay() when
the value is known not to be zero.

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603311958.ly6uROit-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/nxp-sar-adc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9d9f2c76bed4..705dd7da1bd2 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -198,6 +198,15 @@ static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
 		writel(0, NXP_SAR_ADC_IMR(info->regs));
 }
 
+static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, unsigned int cycles)
+{
+	u64 rate;
+
+	rate = clk_get_rate(info->clk);
+	if (rate)
+		ndelay(div64_u64(NSEC_PER_SEC, rate * cycles));
+}
+
 static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
 {
 	u32 mcr;
@@ -221,7 +230,7 @@ static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
 	 * configuration of NCMR and the setting of NSTART.
 	 */
 	if (enable)
-		ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3));
+		nxp_sar_adc_wait_for(info, 3);
 
 	return pwdn;
 }
@@ -469,7 +478,7 @@ static void nxp_sar_adc_stop_conversion(struct nxp_sar_adc *info)
 	 * only when the capture finishes. The delay will be very
 	 * short, usec-ish, which is acceptable in the atomic context.
 	 */
-	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80);
+	nxp_sar_adc_wait_for(info, 80);
 }
 
 static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
-- 
2.54.0



