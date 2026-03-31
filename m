Return-Path: <stable+bounces-231488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEl6IPH1y2nlMwYAu9opvQ
	(envelope-from <stable+bounces-231488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:27:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D693F36C9A3
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 755AE30459CC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983EF3E92A5;
	Tue, 31 Mar 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lA8WU46u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B81F30E0DC;
	Tue, 31 Mar 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974302; cv=none; b=pbCBLCmSvo7i6BxBsdiylzJpYTZRtDkE4MeLlemNj0Fk1wzxH0Qbfe8tuJNN7D77apE0egPuiRQKHQCxaLs+/q0lUoLkpuWjoPuEehbyBzaFfJNxuS+vUYvGshVj4u2wVV7XwsEYgQthevHak2aM4kDk1YQ3YV8dbIOJqxfOpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974302; c=relaxed/simple;
	bh=xR4cnQOvAbK0/wqG2t4wLZcIA5exNZNmKycVfmsIlbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cogvEHYu1iUTEByta+JmsYTrApJU4ut3WCspO3WMU6+WN3CGovKC1aSpOTXeW0qECJbMGqeB16yS+IDHhLwzZWxYMOehYU1AXWJdDtwsZiMBrJGxqRFdH0t+T3xzy8dnIuQXGcRn42zA0NfK4qqbdihN94hrS2TlKSfip+YBV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lA8WU46u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA7CC19423;
	Tue, 31 Mar 2026 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974301;
	bh=xR4cnQOvAbK0/wqG2t4wLZcIA5exNZNmKycVfmsIlbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lA8WU46uWD67Cs9CujhdFOmUMcHnHjay5ZrOlxeWJuvCjHP+dCeCf7jhv6YlXIVL9
	 JH1iQcri7YpIjwu4aPHPz9twQSOtcTzzUgl1M2v2uua28VvRyyoZH9mxDZgvLd/l8K
	 iZNe8AJs86LkIGXZe25kSt9sz+WxcE/x7M76idEg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/175] spi: intel-pci: Add support for Nova Lake mobile SPI flash
Date: Tue, 31 Mar 2026 18:20:16 +0200
Message-ID: <20260331161730.966478605@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-231488-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D693F36C9A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>

[ Upstream commit 85b731ad4bbf6eb3fedf267ab00be3596f148432 ]

Add Intel Nova Lake PCD-H SPI serial flash PCI ID to the list of
supported devices.

Signed-off-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://patch.msgid.link/20260309153703.74282-1-alan.borzeszkowski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-intel-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 5c0dec90eec1d..43692315ea305 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -86,6 +86,7 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa823), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0xd323), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xe323), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xe423), (unsigned long)&cnl_info },
 	{ },
-- 
2.51.0




