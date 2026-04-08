Return-Path: <stable+bounces-234057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHuPKXia1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:12:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7123C0285
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2EA0302E7D5
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD713D47A5;
	Wed,  8 Apr 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKhtC6K+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307E2347517;
	Wed,  8 Apr 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671874; cv=none; b=p/vXxoQhN/HXgsfLaLTZHndN+FekTz7iAE4azaSRGz4GMTO62FnfgLS2VGS9G5laEQuGwmOun9NxJHOqxKWvFsNfo+hb9vcRItjDzqKAcHP83PWpobgGxQ7ZyFvkOIrYKxMh3EX1DM+r2CKSCVkymtL71lyVWns8F3JrNUAJDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671874; c=relaxed/simple;
	bh=MlEij6w22pQo0MzaI+bFVClHPSB3GlM3zaKjrRZOjMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXBKDVkOkzQSHV0crQVEyD6SyqCz+MuRLqF+D8xoHoZQsHJEo6BOcUkVz8dPps504FZA5Js9ZnrGfSAU8vvb6DKOQNB4zm0ylqD6AcD6K98NvQgDxcNOGrd8EhhZrtDOzD0AVJvkB6ZO9GCn5wFljEWPszCgXNlZ62M+1hqsamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jKhtC6K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC894C19421;
	Wed,  8 Apr 2026 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775671874;
	bh=MlEij6w22pQo0MzaI+bFVClHPSB3GlM3zaKjrRZOjMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKhtC6K+Sqj+nHEC9lrbFNp9o4jU5MX0DbKTJHq7Qnz3TLGrE8fd6bfwEMkaq3ggM
	 0r9rXruNpjt585mxmpnvnPQoJk6O85ktQeuqhZBn0Ce9Pot9KQt9xUkaDEsEiuO29q
	 ZRl/nBNwPyF2WKSSlQnzSnoUO37Iw/Y1TjfL47is=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Tyllis Xu <LivelyCarpet87@gmail.com>,
	Dave Marquardt <davemarq@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 102/312] scsi: ibmvfc: Fix OOB access in ibmvfc_discover_targets_done()
Date: Wed,  8 Apr 2026 20:00:19 +0200
Message-ID: <20260408175937.573918188@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.ibm.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-234057-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 3D7123C0285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyllis Xu <livelycarpet87@gmail.com>

commit 61d099ac4a7a8fb11ebdb6e2ec8d77f38e77362f upstream.

A malicious or compromised VIO server can return a num_written value in the
discover targets MAD response that exceeds max_targets. This value is
stored directly in vhost->num_targets without validation, and is then used
as the loop bound in ibmvfc_alloc_targets() to index into disc_buf[], which
is only allocated for max_targets entries. Indices at or beyond max_targets
access kernel memory outside the DMA-coherent allocation.  The
out-of-bounds data is subsequently embedded in Implicit Logout and PLOGI
MADs that are sent back to the VIO server, leaking kernel memory.

Fix by clamping num_written to max_targets before storing it.

Fixes: 072b91f9c651 ("[SCSI] ibmvfc: IBM Power Virtual Fibre Channel Adapter Client Driver")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Link: https://patch.msgid.link/20260314170151.548614-1-LivelyCarpet87@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ibmvscsi/ibmvfc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -4928,7 +4928,8 @@ static void ibmvfc_discover_targets_done
 	switch (mad_status) {
 	case IBMVFC_MAD_SUCCESS:
 		ibmvfc_dbg(vhost, "Discover Targets succeeded\n");
-		vhost->num_targets = be32_to_cpu(rsp->num_written);
+		vhost->num_targets = min_t(u32, be32_to_cpu(rsp->num_written),
+					   max_targets);
 		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_ALLOC_TGTS);
 		break;
 	case IBMVFC_MAD_FAILED:



