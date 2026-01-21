Return-Path: <stable+bounces-210938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJq1HoMtcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-210938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:48:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6D05C810
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EC808AE19E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F743A641A;
	Wed, 21 Jan 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="If/3UyhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050534165B;
	Wed, 21 Jan 2026 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019892; cv=none; b=LXTyL3Rgw5WLeBtDEHX0VeD2A13h5qHoQ2kIOHlvAunVAHbPD8mCP4M60ZG/PfpfpmSf3gNDkMCoS6PgO4B/0IWWAWHpPUKeq4tZRSC0lI0M/UBlgLz7Y++BxUFxqfQUZDh2Zfo8zrNxTIqXmC19vssQOc1e6a1MlRWqEdu3zmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019892; c=relaxed/simple;
	bh=ODgy8vD2m1QY9Tm5QxQ+pwVNztO82QVAD1CLe21owNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlxGWLLUMMcpcc3CvZgxOsw0EZiqgWSarfvpAfyQjqySc0W+FwsEe0qQ5hNhdfZgokbEvQsfR9y4pHbtjZ7RAwq8v9Gn52e0zwdcIDI8w5FW2lQcLN1dpqVKIbUppCQRMLVq8V5pKgVAcB1Kxte+lGD12bFaZTLKkiawhJ3Tt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=If/3UyhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFCAC4CEF1;
	Wed, 21 Jan 2026 18:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019891;
	bh=ODgy8vD2m1QY9Tm5QxQ+pwVNztO82QVAD1CLe21owNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=If/3UyhBUlsQobHe+I3fqXhQ7Is26MFHpBp6tr1v7myT+Ec4Zm6U08gHUrxyfy5QV
	 UfjAcReBdCPi63EWVRIEeENez0XYA6+rfI+ij8nw0+MwFAF3ijpbw/9RBrOXIsKmMt
	 J/SGHdHvfhWrtLEfCQqwUo0eplto/G4psjue1Prc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bruno Faccini <bfaccini@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Hyeonggon Yoo <hyeonggon.yoo@sk.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Len Brown <lenb@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12 139/139] mm/fake-numa: handle cases with no SRAT info
Date: Wed, 21 Jan 2026 19:16:27 +0100
Message-ID: <20260121181416.462434999@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-210938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nvidia.com:email,sk.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0E6D05C810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bruno Faccini <bfaccini@nvidia.com>

commit 4c80187001d3e2876dfe7e011b9eac3b6270156f upstream.

Handle more gracefully cases where no SRAT information is available, like
in VMs with no Numa support, and allow fake-numa configuration to complete
successfully in these cases

Link: https://lkml.kernel.org/r/20250127171623.1523171-1-bfaccini@nvidia.com
Fixes: 63db8170bf34 (“mm/fake-numa: allow later numa node hotplug”)
Signed-off-by: Bruno Faccini <bfaccini@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/numa/srat.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -95,9 +95,13 @@ int __init fix_pxm_node_maps(int max_nid
 	int i, j, index = -1, count = 0;
 	nodemask_t nodes_to_enable;
 
-	if (numa_off || srat_disabled())
+	if (numa_off)
 		return -1;
 
+	/* no or incomplete node/PXM mapping set, nothing to do */
+	if (srat_disabled())
+		return 0;
+
 	/* find fake nodes PXM mapping */
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		if (node_to_pxm_map[i] != PXM_INVAL) {
@@ -117,6 +121,11 @@ int __init fix_pxm_node_maps(int max_nid
 			}
 		}
 	}
+	if (index == -1) {
+		pr_debug("No node/PXM mapping has been set\n");
+		/* nothing more to be done */
+		return 0;
+	}
 	if (WARN(index != max_nid, "%d max nid  when expected %d\n",
 		      index, max_nid))
 		return -1;



