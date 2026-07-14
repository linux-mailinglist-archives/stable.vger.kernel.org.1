Return-Path: <stable+bounces-274579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ehliH6SyVmpGAQEAu9opvQ
	(envelope-from <stable+bounces-274579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A62759211
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M9n0OKtE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274579-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274579-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E0F5301C1B7
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376D42BC54;
	Tue, 14 Jul 2026 22:04:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3842BC34
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066665; cv=none; b=lli5G3vLUcsfV1MsPSDO6WZnuta3h5hZ12TZTE066xqjZpg2jdxrOndS+h8C2siHNHhqf6+bTJMnxXRt/wDu+Ez8m5I+9GMtmndZbpUaNl77oDXtwF+gOCuKSp2y0PteEY8nKosRy2eAwf8EuIjoaZUfiLx69rRAQPzPhlS6VuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066665; c=relaxed/simple;
	bh=qdwlIFN/WJODidDBBtB/v0QvyEHJCTfneBun7brqC2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r805z+0zZXBtB6vuZ7DTC9DArU26a5nKtO13iT5zcUdml30aQT7n3wLdc4zBVdkLt0yxzKb/7IXVjCuqthxRjCJZovjVcTWyTpYQB3/K6nM3oB+IwXNlDZp8hZuuxXp35SJTxaGcQQS7vLz4jsyh4KWVReRTEGtFlUGQfgroJ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9n0OKtE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31DE1F00A3D;
	Tue, 14 Jul 2026 22:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066664;
	bh=qiniJsr/CkWs6bFCwA5poRO3/B7AW1H9zxpTmVnmV6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9n0OKtEB/4vw+TsPc6zcezsSLpHVMTPKQmVBhFtQ+UpPQo9QhmVSbauGB5cwtx5N
	 x5NdlrPeVQw589fJyfp+2WXLnQrOcx2kj8maHcM9dQofBXX6MlTO+/VphJWi7I1eri
	 jDXYnvj8Luojh6yRUGIi3pnIMx8i1Z/dqKLrJP661RptsVFgkHtw1NShoFZzcbIKgN
	 G7b7AwnM5DcIA1zkikaW5GdV2owIOmNYJN9MPllJFukyucEFbCGb5OIVyySP3h2+ON
	 lfzJR0AGiWMzzEpdsFqovPsNYgzy+NhlCqdlcxU0pmf1K9JY3O1QG/ICdk006o9YOO
	 M6PTzDVddSRfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Simon Richter <Simon.Richter@hogyros.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] PCI: Prevent resource tree corruption when BAR resize fails
Date: Tue, 14 Jul 2026 18:04:17 -0400
Message-ID: <20260714220421.3334071-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714220421.3334071-1-sashal@kernel.org>
References: <2026071358-dominoes-employee-70eb@gregkh>
 <20260714220421.3334071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:ilpo.jarvinen@linux.intel.com,m:Simon.Richter@hogyros.de,m:alex.bennee@linaro.org,m:bhelgaas@google.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274579-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linaro.org:email,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hogyros.de:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78A62759211

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 91c4c89db41499eea1b29c56655f79c3bae66e93 ]

pbus_reassign_bridge_resources() saves bridge windows into the saved
list before attempting to adjust resource assignments to perform a BAR
resize operation. If resource adjustments cannot be completed fully,
rollback is attempted by restoring the resource from the saved list.

The rollback, however, does not check whether the resources it restores were
assigned by the partial resize attempt. If restore changes addresses of the
resource, it can result in corrupting the resource tree.

An example of a corrupted resource tree with overlapping addresses:

  6200000000000-6203fbfffffff : pciex@620c3c0000000
    6200000000000-6203fbff0ffff : PCI Bus 0030:01
      6200020000000-62000207fffff : 0030:01:00.0
      6200000000000-6203fbff0ffff : PCI Bus 0030:02

A resource that are assigned into the resource tree must remain
unchanged. Thus, release such a resource before attempting to restore
and claim it back.

For simplicity, always do the release and claim back for the resource
even in the cases where it is restored to the same address range.

Note: this fix may "break" some cases where devices "worked" because
the resource tree corruption allowed address space double counting to
fit more resource than what can now be assigned without double
counting. The upcoming changes to BAR resizing should address those
scenarios (to the extent possible).

Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
Reported-by: Simon Richter <Simon.Richter@hogyros.de>
Link: https://lore.kernel.org/linux-pci/67840a16-99b4-4d8c-9b5c-4721ab0970a2@hogyros.de/
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/linux-pci/874irqop6b.fsf@draig.linaro.org/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-2-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1eceabef9e84d7..58dddb8b4d1d2f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2388,6 +2388,11 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		bridge = dev_res->dev;
 		i = res - bridge->resource;
 
+		if (res->parent) {
+			release_child_resources(res);
+			pci_release_resource(bridge, i);
+		}
+
 		res->start = dev_res->start;
 		res->end = dev_res->end;
 		res->flags = dev_res->flags;
-- 
2.53.0


