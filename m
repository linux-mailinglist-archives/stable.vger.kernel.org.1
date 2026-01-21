Return-Path: <stable+bounces-211084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKhaA383cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:30:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0D5D434
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8559672D515
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350E3D647F;
	Wed, 21 Jan 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fv6bWGK7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C139341F;
	Wed, 21 Jan 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020387; cv=none; b=KOzfXUJP3xyQmzpvoH21ENMiJfLSotzQpjPdLY39hJBO38gaIBJTVUQcy+J+sF38i4+yDTxYTCj2m4megREC8mNnJrvO4kzFARW9dXWEGtZaOkqRXu1EJm6AGlg7LD2Y19+ehJiOjcKN+6tUj9X3yv28SsY5DgkQO0zVRlLngJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020387; c=relaxed/simple;
	bh=HWnuXf3Gpigl89E5XLwcYxiGNdnA81uEGtAmgXJTs5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inIhgybYvyyV23Wl94+VhUypZYVnr5sUSjBHQC8h93Vi9aa3N3Kme3VcJWBnjNB73e81RsCFL+SWGedi1+e+BzNMlEXvUfeb77yhcCz/aG1RkDUzgM7mQwUKhUToUBjsi4QP7sQYh8ph5DAZyNptgxiRnAKg1Fqs1UqPPNIosmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fv6bWGK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE92C4CEF1;
	Wed, 21 Jan 2026 18:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020386;
	bh=HWnuXf3Gpigl89E5XLwcYxiGNdnA81uEGtAmgXJTs5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fv6bWGK7OtD7NMzBebRoGcjmkPGrWQ5guSSASbyKWbRSfJUtlK5qENPTHYYMrE6mH
	 7mAKlALQde7vIia7H8Sur+YV5CtWsNSp86XXhwCui325aJRDRxUWuiYajPKVeP33/X
	 uVA+0D41k8fO1kE+7AqDik5RisUiEQm0eijAfQWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Pavel Pisa <pisa@fel.cvut.cz>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.18 099/198] can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.
Date: Wed, 21 Jan 2026 19:15:27 +0100
Message-ID: <20260121181422.117158041@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-211084-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,fel.cvut.cz,pengutronix.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,pengutronix.de:email]
X-Rspamd-Queue-Id: B3F0D5D434
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Ille <ondrej.ille@gmail.com>

commit e707c591a139d1bfa4ddc83036fc820ca006a140 upstream.

The Secondary Sample Point Source field has been
set to an incorrect value by some mistake in the
past

  0b01 - SSP_SRC_NO_SSP - SSP is not used.

for data bitrates above 1 MBit/s. The correct/default
value already used for lower bitrates is

  0b00 - SSP_SRC_MEAS_N_OFFSET - SSP position = TRV_DELAY
         (Measured Transmitter delay) + SSP_OFFSET.

The related configuration register structure is described
in section 3.1.46 SSP_CFG of the CTU CAN FD
IP CORE Datasheet.

The analysis leading to the proper configuration
is described in section 2.8.3 Secondary sampling point
of the datasheet.

The change has been tested on AMD/Xilinx Zynq
with the next CTU CN FD IP core versions:

 - 2.6 aka master in the "integration with Zynq-7000 system" test
   6.12.43-rt12+ #1 SMP PREEMPT_RT kernel with CTU CAN FD git
   driver (change already included in the driver repo)
 - older 2.5 snapshot with mainline kernels with this patch
   applied locally in the multiple CAN latency tester nightly runs
   6.18.0-rc4-rt3-dut #1 SMP PREEMPT_RT
   6.19.0-rc3-dut

The logs, the datasheet and sources are available at

 https://canbus.pages.fel.cvut.cz/

Signed-off-by: Ondrej Ille <ondrej.ille@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Link: https://patch.msgid.link/20260105111620.16580-1-pisa@fel.cvut.cz
Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -310,7 +310,7 @@ static int ctucan_set_secondary_sample_p
 		}
 
 		ssp_cfg = FIELD_PREP(REG_TRV_DELAY_SSP_OFFSET, ssp_offset);
-		ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x1);
+		ssp_cfg |= FIELD_PREP(REG_TRV_DELAY_SSP_SRC, 0x0);
 	}
 
 	ctucan_write32(priv, CTUCANFD_TRV_DELAY, ssp_cfg);



