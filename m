Return-Path: <stable+bounces-255681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK32Nr6jGGrClggAu9opvQ
	(envelope-from <stable+bounces-255681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:21:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB865F8732
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBD2A3011566
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7822F8E83;
	Thu, 28 May 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="14AJLWBF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF9282F17;
	Thu, 28 May 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999595; cv=none; b=ZTiDp03/DsbWUO5TsJivFt99DbpF/JMTiljCp4mC5D7dukFq983wDXj3O6zRYywDUtvfTWuUHI7LGomS3/eu4P2TkRjBL0E+93VBrWagehV6DKaOYKynOlmQikjHN1kp9vlSH2YqSrzfZubzrX9jT2fYRIML4n8oE9BYsuondGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999595; c=relaxed/simple;
	bh=X6OESti9zL5yK6oBm8j+t+R0Rre0Y1Bzp0TVfz2t8eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kwlqq1w5zsRIpQ6QET7kcMUqHCUt9opBXK5DvFLBIwIBSnNo2CoTna+13MxRHidaSLpB52Q4G2oabHGp6LggvvBG4emgxR9heBZ8p7USu5CNrQNssWRFmtSyf0p9PAViWP4cYRm12g53oSX8q+WG1hC43bbowIutrLeOqiQa/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=14AJLWBF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971CE1F000E9;
	Thu, 28 May 2026 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999594;
	bh=MR++RK1ghOyr8eGJW/DjraIMsejNYB2ezXLc/kO7AHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=14AJLWBFx/d0HTsHz2kR5BfV+kkWGfLYCjkzlKX34JQxWWc9//sIXdlXrAxtn7V5X
	 ToxnwgqJ3OJCzn4UN/OwF9hxzWOc1onmKLXgcAN7F4j2BACbPrgnnKWCSWrgKnxVum
	 A3JOS5wA73J3pwh8y1JWZwmMuK1q9uWzOfcoGQwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heechan Kang <gganji11@naver.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.18 123/377] fwctl: pds: Validate RPC input size before parsing
Date: Thu, 28 May 2026 21:46:01 +0200
Message-ID: <20260528194641.905690913@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255681-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,naver.com,intel.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,msgid.link:url,nvidia.com:email,naver.com:email]
X-Rspamd-Queue-Id: DCB865F8732
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heechan Kang <gganji11@naver.com>

commit e7537735028c3ad4b0bfc02ff8fa2a1a28aa04fe upstream.

The fwctl core allocates the device-specific RPC input buffer with
fwctl_rpc.in_len and passes that buffer to the driver callback.

pdsfc_fw_rpc() casts the buffer to struct fwctl_rpc_pds and then calls
pdsfc_validate_rpc(), which reads fields from that structure before
checking that the input buffer is large enough to contain it. A short
in_len can make pds_fwctl read beyond the allocation.

Reject pds RPC buffers that are smaller than struct fwctl_rpc_pds before
parsing any pds-specific fields.

Fixes: 92c66ee829b9 ("pds_fwctl: add rpc and query support")
Link: https://patch.msgid.link/r/20260517062232.1858747-1-gganji11@naver.com
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Heechan Kang <gganji11@naver.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/fwctl/pds/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index 08872ee8422f..68fe254dd10a 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -362,6 +362,9 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 	void *out = NULL;
 	int err;
 
+	if (in_len < sizeof(*rpc))
+		return ERR_PTR(-EINVAL);
+
 	err = pdsfc_validate_rpc(pdsfc, rpc, scope);
 	if (err)
 		return ERR_PTR(err);
-- 
2.54.0




