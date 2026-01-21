Return-Path: <stable+bounces-210748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEHNKz/YcGmUaQAAu9opvQ
	(envelope-from <stable+bounces-210748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:44:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370E57B70
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DADE060B679
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7533481242;
	Wed, 21 Jan 2026 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHEhbICj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BC2E54D1;
	Wed, 21 Jan 2026 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001282; cv=none; b=He4Ny/T+oyc9j+yqlMLwFio7cwapNp53OUBu6RzX6fx//1yL9O8XIj+YXHuXjoNc7ZGVxd3i5iu/waH0yE4xsxe08WV1m267kcHBpSf72X1xXJdaJzx6rvPs2Ag+RT6J/O1JRhS+2PN7fpqHnOuZeS7Ed34J3JTHnNmqU3cELP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001282; c=relaxed/simple;
	bh=RaYvlksJ/SpSfgzayP+dQQSt2W74WOsYndcSkAgl/IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDElqe6rhzUPTAMU/qxEaVR90xzkV+78WM/65U8sTs6wEe+mmGvRu73Jjvv1VYZB15GLs+uqfQ2kSZabQsHmYQbBzA0hBfM/W0wJN5dKl5wXdzSLeGDufUxaQ5HW/x7AxggmrNOcPdnqSSwF90ngaTr/sIxeSLQKooJhx58lUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHEhbICj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769001280; x=1800537280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RaYvlksJ/SpSfgzayP+dQQSt2W74WOsYndcSkAgl/IQ=;
  b=gHEhbICjljdWsgRiZtO5sRjMDHDl6rMbuPT7R8MRdF0XMXjqyVtCFGtU
   91YdrjnEGcbtshm7TG9kEGr4fzyLlk8kAynpoJ3FFC5SJpmuC8aF+gjnH
   nBXvnQufFmqEaQ9tyqEX5PcE9fq2Lqe23z2p6HqUt+UK1KNxRB8NANKJq
   EAmEE3NCO5W8+gW6CrGjSlMIOrdGx4C/glHNUViZIT/jhbUr1HWIASdf6
   F3gqd2YflwfyPyR/9AytpZ2OfEZbAmMXUWonYfQhoOlgIeDhVW3racX62
   DhyfOWnceexP6ewCzQCim0P5uyMJ5e07+jAdvjFTdse1XNI1AeQFD2Ox4
   A==;
X-CSE-ConnectionGUID: ET6o7Ux5Q8mhfdwLAZu4Eg==
X-CSE-MsgGUID: EW/1UPfDTYuuAQH211ieVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69424281"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69424281"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:14:40 -0800
X-CSE-ConnectionGUID: n7HsbLOYRJmY6N9lQ5fuMQ==
X-CSE-MsgGUID: 5iEdnD6ATmSJ+1cMvUtNhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206872405"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:14:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] PCI: Fix BAR resize rollback path overwriting ret
Date: Wed, 21 Jan 2026 15:14:16 +0200
Message-Id: <20260121131417.9582-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
References: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-210748-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 2370E57B70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The commit 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize
rollback path") added BAR rollback to
pci_do_resource_release_and_resize() in case of resize failure.

On the rollback, pci_claim_resource() is called which can fail and the
code is prepared for that possibility. pci_claim_resource()'s return
value, however, overwrites the original value of ret so
pci_claim_resource() will return incorrect value in the end (as
pci_claim_resource() normally succeeds, in practice ret will be 0).

Fix the issue by directly calling pci_claim_resource() inside the if ().

Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path")
Link: https://lore.kernel.org/linux-pci/aW_w1oFQCzUxGYtu@intel.com/
Cc: stable@vger.kernel.org
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6e90f46f52af..9c374feafc77 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2556,8 +2556,7 @@ int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size
 
 		restore_dev_resource(dev_res);
 
-		ret = pci_claim_resource(dev, i);
-		if (ret)
+		if (pci_claim_resource(dev, i))
 			continue;
 
 		if (i < PCI_BRIDGE_RESOURCES) {
-- 
2.39.5


