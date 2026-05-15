Return-Path: <stable+bounces-248144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKDbFQJIB2qrwQIAu9opvQ
	(envelope-from <stable+bounces-248144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:21:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE520553132
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00AD6310BADF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C73E00A8;
	Fri, 15 May 2026 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7AeP6Tf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80353CF045;
	Fri, 15 May 2026 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860983; cv=none; b=k9ed4hlPH8GBTv/qaeGBTF2l+oUTgQ4DP2kIhjJ4vBvlbPkTsCv5OSh2KPaj/G/edgPp2fmLmTUcmTIJOA1SmTmQkNKjdOwcm0MdxyiqMk/sFT25cjaJNh66QCjkGFm/Gfe82wlyufUR8/+QqImdJGYIl6EU6N438xEWCsOluaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860983; c=relaxed/simple;
	bh=Xyq4I1JVTTDZj7s5rr2BuEC4gn7hepMaQhlaElsgr8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uA5aDHZhHwJpNXd6lugY0uMhPixgL1YUUhhNI9XhmVGkuogtPPn4bo7YbH5L/fhMEBUDMikN1ByJ/xKscLAjxxb3rYisW3Bz6qVlk+Kgdm92jv4e4UOPuL994pwmmOoT6HvkXmmsC+5fOCUNKHmGJ01rfiFU1RNB/kQq3eMtQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7AeP6Tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF6AC2BCB0;
	Fri, 15 May 2026 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860983;
	bh=Xyq4I1JVTTDZj7s5rr2BuEC4gn7hepMaQhlaElsgr8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7AeP6Tf9qPQC37IdbQedK4Zdp7l4moXEKcngEKPFudiY/x88VNmaSQEdGBrZVmoQ
	 FqBla+1cgVREcfhJ/dSOOByPqbRy5yS53+Us37pLaNuOD/WTmDtFc00fuiw+9a8aXO
	 C0HU58xgq2nnQ+Op9hvSglt1k0Av3EzK9WaMSl6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sina Hassani <sina@openai.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.6 152/474] iommufd: Fix a race with concurrent allocation and unmap
Date: Fri, 15 May 2026 17:44:21 +0200
Message-ID: <20260515154718.314731343@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CE520553132
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248144-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openai.com:email,nvidia.com:email,intel.com:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sina Hassani <sina@openai.com>

commit 8602018b1f17fbdaa5e5d79f4c8603ad20640c12 upstream.

iopt_unmap_iova_range() releases the lock on iova_rwsem inside the loop
body when getting to the more expensive unmap operations. This is fine on
its own, except the loop condition is based on the first area that matches
the unmap address range. If a concurrent call to map picks an area that
was unmapped in previous iterations, the loop mistakenly tries to unmap
it.

This is reproducible by having one userspace thread map buffers and pass
them to another thread that unmaps them. The problem manifests as EBUSY
errors with single page mappings.

Fix this by advancing the start pointer after unmapping an area. This
ensures each iteration only examines the IOVA range that remains mapped,
which is guaranteed not to have overlaps.

Cc: stable@vger.kernel.org
Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
Link: https://patch.msgid.link/r/CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com
Signed-off-by: Sina Hassani <sina@openai.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommufd/io_pagetable.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -552,6 +552,16 @@ again:
 		unmapped_bytes += area_last - area_first + 1;
 
 		down_write(&iopt->iova_rwsem);
+
+		/*
+		 * After releasing the iova_rwsem concurrent allocation could
+		 * place new areas at IOVAs we have already unmapped. Keep
+		 * moving the start of the search forward to ignore the area
+		 * already unmapped.
+		 */
+		if (area_last >= last)
+			break;
+		start = area_last + 1;
 	}
 
 out_unlock_iova:



