Return-Path: <stable+bounces-228173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jk9EhdNwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B40FC2F463B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0159930A236A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7EB3B7746;
	Mon, 23 Mar 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jm6limMb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1C3B7742;
	Mon, 23 Mar 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274348; cv=none; b=KfM+zj9BK4WpckdZlKVwhkIQ2Nf9UPBYos2xBD9P+qTiwEodQ7f+jrRGgDdXLgDwoQmSSDCO2g26CLyvWoHdTHixkJDpxfLtw1i9jbAE0BgGL1qT5yEO6f3I8L0f1WgnGad5pd8yQKO8Uy9SSxvghe2aH/HxjSRohX1a1jt3Sok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274348; c=relaxed/simple;
	bh=lZVilTglRIqc7vOzvDe8Cm7axUJ5iFSvXe703csHhJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqwOevWLCXy3avKqwY5Vv7MpcZAwlro6tVuGQ3HqilUGDy3vryxhrECUlMEBkCryk0kNMsEwJhrBQeOqEEkM7J5s4oIf9IhokeT7y60DgV47ElLBttno87ZaArc0VocPiwjNdKlkULgBl0bqGKrLZGUkhz3ztxJ+vMYAaVChuXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jm6limMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02194C2BCB9;
	Mon, 23 Mar 2026 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274348;
	bh=lZVilTglRIqc7vOzvDe8Cm7axUJ5iFSvXe703csHhJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jm6limMbHnt1iEAR0/6R58NJ/2ERda5rY7w6hPk86sQ0EbnOtT8mkWfCuOfb0YZ6m
	 QdGfs9iOmu2TUo6uGUvLtVUxIQa2rEDygpbz6LI6/5c3kKMF9OPI9wJHTVZpHH4EaX
	 44F1entuAQpSaDPcIvrdBBbwgCACW+DDtXE9cp1o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Rahul Pathak <rahul@summations.net>
Subject: [PATCH 6.19 189/220] irqchip/riscv-rpmi-sysmsi: Fix mailbox channel leak in rpmi_sysmsi_probe()
Date: Mon, 23 Mar 2026 14:46:06 +0100
Message-ID: <20260323134510.566310765@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228173-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,summations.net];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B40FC2F463B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit 76f0930d6e809234904cf9f0f5f42ee6c1dc694e upstream.

When riscv_acpi_get_gsi_info() fails, the mailbox channel previously
requested via mbox_request_channel() is not freed. Add the missing
mbox_free_channel() call to prevent the resource leak.

Fixes: 4752b0cfbc37 ("irqchip/riscv-rpmi-sysmsi: Add ACPI support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Rahul Pathak <rahul@summations.net>
Link: https://patch.msgid.link/20260315-sysmsi-v1-1-5f090c86c2ca@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+++ b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
@@ -250,6 +250,7 @@ static int rpmi_sysmsi_probe(struct plat
 		rc = riscv_acpi_get_gsi_info(fwnode, &priv->gsi_base, &id,
 					     &nr_irqs, NULL);
 		if (rc) {
+			mbox_free_channel(priv->chan);
 			dev_err(dev, "failed to find GSI mapping\n");
 			return rc;
 		}



