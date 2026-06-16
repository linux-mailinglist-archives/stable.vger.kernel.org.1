Return-Path: <stable+bounces-264042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 21CsGdVtMWptjAUAu9opvQ
	(envelope-from <stable+bounces-264042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:37:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 157116913A3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:37:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gw4MEMZI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264042-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264042-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6B6431289D6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F036DA00;
	Tue, 16 Jun 2026 15:30:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202B43D513;
	Tue, 16 Jun 2026 15:30:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623818; cv=none; b=NA5ykb0mZ9SZJdNdx5jSyBrJ3vrNHZQDzAdPNupCGdBKAmtCDlwsx3MWipqmHj+f9Mcq9gn0WYuwCkEAIsLqZVgTQov15C3q85TWVp5/HDQMxMxXDihT151F4ByW0GTjVY5YCW4rHWlIre0VFjhBO9TiLAgL//kXoosozedTFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623818; c=relaxed/simple;
	bh=Eunj+6xhBtsfs7+GytcitGbQya6Bs54pxNQP1dQKxVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9MiPEowSIMlogNkB+mRrx293oEK4uItPVyeph7anHcof/JXqgei1DBatQy68jaYgJvvNbr3XwbvhCXetQbERwdwn0WjSqstfXco4boVsGg6XZhyF0k8oXZyyJ7v6kGY0pXs5UUWGw3F97QDojTtO4O+mLL3sPvWZG5dHz1anD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gw4MEMZI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ABB1F000E9;
	Tue, 16 Jun 2026 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623817;
	bh=4cPrDNXvJl0eY2UrVtdUoCocqJ1ACDa7G5ldh5GDF8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gw4MEMZIy7Z0+GK4ofq6w8zL0brEYUrBRNuEP/CuBLY2xdgiCPGXFMRvn3fMzM1cf
	 4KskPE2wo2XWJRdN1KZr3J1ZkgHy1GgXGe19RZlPOUc1/MpKMKULJs1HloNSwC168O
	 eo9674nthcG3DwYd7xZHT755ohzg1AQwCDp7ryKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <error27@gmail.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 7.0 222/378] RDMA/core: Validate cpu_id against nr_cpu_ids in DMAH alloc
Date: Tue, 16 Jun 2026 20:27:33 +0530
Message-ID: <20260616145121.994512067@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264042-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:error27@gmail.com,m:yishaih@nvidia.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nvidia.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 157116913A3

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yishai Hadas <yishaih@nvidia.com>

commit 323c98a4ff06aa28114f2bf658fb43eb3b536bbc upstream.

The cpu_id attribute supplied by user space through
UVERBS_ATTR_ALLOC_DMAH_CPU_ID is passed directly to cpumask_test_cpu()
without first verifying that the value is within the valid CPU range.

Passing such untrusted data to cpumask_test_cpu() may lead to an
out-of-bounds read of the underlying cpumask bitmap: the helper expands
to a test_bit() that indexes the bitmap by cpu_id / BITS_PER_LONG with
no bound check.

In addition, on kernels built with CONFIG_DEBUG_PER_CPU_MAPS it trips
the WARN_ON_ONCE() in cpumask_check(); combined with panic_on_warn this
turns a bad user input into a machine reboot.

Reject any cpu_id that is not smaller than nr_cpu_ids with -EINVAL
before it is used.

Reported by Smatch.

Fixes: d83edab562a4 ("RDMA/core: Introduce a DMAH object and its alloc/free APIs")
Link: https://patch.msgid.link/r/20260525142136.28165-1-yishaih@nvidia.com
Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/ag68qoAW3P04J7pT@stanley.mountain/
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_std_types_dmah.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/infiniband/core/uverbs_std_types_dmah.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
@@ -47,6 +47,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_
 		if (ret)
 			goto err;
 
+		if (dmah->cpu_id >= nr_cpu_ids) {
+			ret = -EINVAL;
+			goto err;
+		}
+
 		if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
 			ret = -EPERM;
 			goto err;



