Return-Path: <stable+bounces-243487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EICOE0Kq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F024BEF3A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B412305E46B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDF13D9029;
	Mon,  4 May 2026 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bAND1jP7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019C3AA4F8;
	Mon,  4 May 2026 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904010; cv=none; b=hy/vmq9dOloS0qi1y9tibtyLLeE3koUEwXArNd+Th6csC1u6YIchD+fjX/2nA/KisyyWUlh4AzU45+fH6TQIi2mJjcNTPiqHb0batxdgFj4pkRrDYjVpsAWkSrnWTTM9LET8Zvj+lgHQjXXZYf5sNWMWRS04EtzwZRrfFfyAPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904010; c=relaxed/simple;
	bh=KVOBMvo9u7TvfOFk4qW2SR9Gei1bbGYHRz/hMGfVMNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue3ABAX3E3nrs3qX0ZQgP/mbt9wS8PGD+1IuGyvkHzji47864dpS0TAbXIMlerTk2yhUYUxVp5Hy/qt+03iQtU0sypcJQxhJ4NqIiFWPrgFUHqOczeV1aIEFwcttBpFpSJyjq+Hekl7Ji4OVlxlRE87nISjHDcVlE14quD/3f/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bAND1jP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383E8C2BCC4;
	Mon,  4 May 2026 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904010;
	bh=KVOBMvo9u7TvfOFk4qW2SR9Gei1bbGYHRz/hMGfVMNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAND1jP7kI9/aZRYjZCUj+LXQFpRIQ6yFv4cmHYjCmr4sFiHCK5fiJvNRZM14QVZD
	 /p8Ib+J5+kU6GAEcntLr2BFWrBs91syUqRPZBS/DOnzzR1GU8p9eYZ9M83IrI2BU/c
	 Ca6MyrXrrgEYlq+uYdbJpnMCS7MTlNqn1ILDlUYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Laurent M Coquerel <laurent.m.coquerel@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.18 148/275] crypto: qat - fix IRQ cleanup on 6xxx probe failure
Date: Mon,  4 May 2026 15:51:28 +0200
Message-ID: <20260504135148.428253112@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C5F024BEF3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243487-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

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



