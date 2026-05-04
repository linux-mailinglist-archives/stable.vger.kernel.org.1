Return-Path: <stable+bounces-243238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGPeHiap+GmdxgIAu9opvQ
	(envelope-from <stable+bounces-243238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35824BEBF1
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D543064CDE
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF23DD53E;
	Mon,  4 May 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBM3SAX/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993E3A2574;
	Mon,  4 May 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903372; cv=none; b=Q42/c9PjuO2n1wMj58GFXX+eYDKnQ9t0E05C1g/vMtWwJ5SjQYBQZIO9UDZu6N42LBx088dhHHMVpZQE77gXuqKa8XEfcG2kQw7kA+Up7bp3PiVkMiAAYxqEkAwFeX/f0oq2vX1Qr4gSE6RnGyQM1SPcQFzo1MHpvLJ1/4ZYYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903372; c=relaxed/simple;
	bh=e8baQaSzhzOSu5EqjgRK/t5FWrL1M1z9Go069Rs3ces=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU9VDP/c/u/vEl/MWvVgTE2Yj4oLrRAH/pegMH0xQhAV+wh72tp5UkthuznDOYJkOA00Wv/U8i5H+7FDVL8x62YI0XY/ntJ6LeZD/1jFsdjA/GYchhSfKZoEDKwFNXAL45xKi1zrZXw3wxCVOefrdj6k89qomkbjwHOxpRuJr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HBM3SAX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB36C2BCC4;
	Mon,  4 May 2026 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903372;
	bh=e8baQaSzhzOSu5EqjgRK/t5FWrL1M1z9Go069Rs3ces=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBM3SAX/tt6l5VE9eTpRlzvvsVVneeFsglRcJtGdiZ0cagvrtxh9snpssRXMITEzh
	 6Z0HFazJb0JnRitqohutWKWQyw/y6UyOxqzZYTZc0tNrLUyj2EazXm4iOIZzd+aCMm
	 vtRgqxUQbyupW8pkrpyzOwBzkzQwlIvNyl+Mcako=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Laurent M Coquerel <laurent.m.coquerel@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 7.0 176/307] crypto: qat - fix IRQ cleanup on 6xxx probe failure
Date: Mon,  4 May 2026 15:51:01 +0200
Message-ID: <20260504135149.487979498@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: E35824BEBF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243238-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,apana.org.au:email,intel.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

commit 95aed2af87ec43fa7624cc81dd13d37824ad4972 upstream.

When adf_dev_up() partially completes and then fails, the IRQ
handlers registered during adf_isr_resource_alloc() are not detached
before the MSI-X vectors are released.

Since the device is enabled with pcim_enable_device(), calling
pci_alloc_irq_vectors() internally registers pcim_msi_release() as a
devres action. On probe failure, devres runs pcim_msi_release() which
calls pci_free_irq_vectors(), tearing down the MSI-X vectors while IRQ
handlers (for example 'qat0-bundle0') are still attached. This causes
remove_proc_entry() warnings:

    [   22.163964] remove_proc_entry: removing non-empty directory 'irq/143', leaking at least 'qat0-bundle0'

Moving the devm_add_action_or_reset() before adf_dev_up() does not solve
the problem since devres runs in LIFO order and pcim_msi_release(),
registered later inside adf_dev_up(), would still fire before
adf_device_down().

Fix by calling adf_dev_down() explicitly when adf_dev_up() fails, to
properly free IRQ handlers before devres releases the MSI-X vectors.

Fixes: 17fd7514ae68 ("crypto: qat - add qat_6xxx driver")
Cc: stable@vger.kernel.org
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Reviewed-by: Laurent M Coquerel <laurent.m.coquerel@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/intel/qat/qat_6xxx/adf_drv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c
+++ b/drivers/crypto/intel/qat/qat_6xxx/adf_drv.c
@@ -182,8 +182,10 @@ static int adf_probe(struct pci_dev *pde
 		return ret;
 
 	ret = adf_dev_up(accel_dev, true);
-	if (ret)
+	if (ret) {
+		adf_dev_down(accel_dev);
 		return ret;
+	}
 
 	ret = devm_add_action_or_reset(dev, adf_device_down, accel_dev);
 	if (ret)



