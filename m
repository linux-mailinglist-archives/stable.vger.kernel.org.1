Return-Path: <stable+bounces-219107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MOQNhFZnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-219107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:06:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE4A1908A1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EA48310E1A2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B8F2820AC;
	Wed, 25 Feb 2026 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VOJLTt/T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767827FD44;
	Wed, 25 Feb 2026 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984040; cv=none; b=IH+DVjPR49xRc/px5hAUUe5OKcE/a7EI4sP3vp1gkzRecXX3kA+wKyNyev2FtmgT21Va3OVCqAbbIFOIdURasn1wFSVdejf2m02uE+3eMGJ7HWROe/qNoM7NPYj4yYdxSuMN9M4S9OCAKZgK9kptYx3QguwCNx+N0JK4q0dnAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984040; c=relaxed/simple;
	bh=pb19MSRlqDlVeRP3yF1EP8UsmBodLoJhPrEYR+76tZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igcdCXuNX5HhPZnbpXMA9tX+WmvtZY4twtDTtN024nrrds2RJbnowrnqJNyR+ElJox0ZUi3c6Zp8BmnNEKQz1ynASNKHmylsQWDmIDz+Gz1/7mEj2dEm1G6ECqOvlzE7yw/0dCsNzymlGcF/MrOQG7yf4751rS6ojHLcgoygjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VOJLTt/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4102BC116D0;
	Wed, 25 Feb 2026 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771984040;
	bh=pb19MSRlqDlVeRP3yF1EP8UsmBodLoJhPrEYR+76tZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VOJLTt/Tj3iyAR3v3JhPTqinBmPD/Fte6E8Ajgv9+nlJ0jiRCfnB7mG33EMhx9nqS
	 u27q3c846lfz3EC03mE3tLlEx1+SE1qFOMSbr26n1jCQa8WLNNZ3yLbkcgws0S065w
	 myVlKTZDCMy4Zsr1jKAAIhVb29UQj8ds7ustaKJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 241/641] Documentation: tracing: Add PCI tracepoint documentation
Date: Tue, 24 Feb 2026 17:19:27 -0800
Message-ID: <20260225012354.712112738@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219107-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,msgid.link:url,alibaba.com:email]
X-Rspamd-Queue-Id: 2DE4A1908A1
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuai Xue <xueshuai@linux.alibaba.com>

[ Upstream commit 8236fc613d44e59f6736d6c3e9efffaf26ab7f00 ]

The PCI tracing system provides tracepoints to monitor critical hardware
events that can impact system performance and reliability. Add
documentation about it.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
[bhelgaas: squash fixes:
https://lore.kernel.org/r/20260108013956.14351-2-bagasdotme@gmail.com
https://lore.kernel.org/r/20260108013956.14351-3-bagasdotme@gmail.com]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20251210132907.58799-4-xueshuai@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/trace/events-pci.rst | 74 ++++++++++++++++++++++++++++++
 Documentation/trace/index.rst      |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/trace/events-pci.rst

diff --git a/Documentation/trace/events-pci.rst b/Documentation/trace/events-pci.rst
new file mode 100644
index 0000000000000..03ff4ad30ddfa
--- /dev/null
+++ b/Documentation/trace/events-pci.rst
@@ -0,0 +1,74 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Subsystem Trace Points: PCI
+===========================
+
+Overview
+========
+The PCI tracing system provides tracepoints to monitor critical hardware events
+that can impact system performance and reliability. These events normally show
+up here:
+
+	/sys/kernel/tracing/events/pci
+
+Cf. include/trace/events/pci.h for the events definitions.
+
+Available Tracepoints
+=====================
+
+pci_hp_event
+------------
+
+Monitors PCI hotplug events including card insertion/removal and link
+state changes.
+::
+
+    pci_hp_event  "%s slot:%s, event:%s\n"
+
+**Event Types**:
+
+* ``LINK_UP`` - PCIe link established
+* ``LINK_DOWN`` - PCIe link lost
+* ``CARD_PRESENT`` - Card detected in slot
+* ``CARD_NOT_PRESENT`` - Card removed from slot
+
+**Example Usage**::
+
+    # Enable the tracepoint
+    echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
+
+    # Monitor events (the following output is generated when a device is hotplugged)
+    cat /sys/kernel/debug/tracing/trace_pipe
+       irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_PRESENT
+
+       irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_UP
+
+pcie_link_event
+---------------
+
+Monitors PCIe link speed changes and provides detailed link status information.
+::
+
+    pcie_link_event  "%s type:%d, reason:%d, cur_bus_speed:%d, max_bus_speed:%d, width:%u, flit_mode:%u, status:%s\n"
+
+**Parameters**:
+
+* ``type`` - PCIe device type (4=Root Port, etc.)
+* ``reason`` - Reason for link change:
+
+  - ``0`` - Link retrain
+  - ``1`` - Bus enumeration
+  - ``2`` - Bandwidth notification enable
+  - ``3`` - Bandwidth notification IRQ
+  - ``4`` - Hotplug event
+
+
+**Example Usage**::
+
+    # Enable the tracepoint
+    echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
+
+    # Monitor events (the following output is generated when a device is hotplugged)
+    cat /sys/kernel/debug/tracing/trace_pipe
+       irq/51-pciehp-88      [001] .....   381.545386: pcie_link_event: 0000:00:02.0 type:4, reason:4, cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, status:DLLLA
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index b4a429dc4f7ad..0a40bfabcf19b 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -54,6 +54,7 @@ applications.
    events-power
    events-nmi
    events-msr
+   events-pci
    boottime-trace
    histogram
    histogram-design
-- 
2.51.0




