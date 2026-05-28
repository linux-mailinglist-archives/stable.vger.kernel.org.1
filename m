Return-Path: <stable+bounces-255219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NMvMYKeGGpblggAu9opvQ
	(envelope-from <stable+bounces-255219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF6D5F7941
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 040CA3033AEA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A1330B2D;
	Thu, 28 May 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fDdDAQqq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774E34040F;
	Thu, 28 May 2026 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998296; cv=none; b=awKjAN3mrbNsIZP3VOkJQqQOSUofhfQxvMORStMIzzrY1+OlDNSorWbmljx2Zf59aQxvmr0RTnykGRGMuOMbB4h/m2dHr9hmaJejmJfuhgt2M0yUN7Rxs9JCqLmdkEc/XRMRTsniaMLcQRkMK3Obz8B8Ykfx52c5Jhn2IPdBpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998296; c=relaxed/simple;
	bh=Q09E5pgzT4mpjjbRalxTPlkkWlt95ipSwfX2rT1G17g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iszAwd6y6RFNgNDrfxyXWvfsJDLZTxHnQ7YXKxYavYoiSkEXot9lGGFULvXCtQscMAmOE2JDXUDO214UwGEpvlecodQ5aVwJCyfdygFYS8fyJlofvleGvJODuBl78GR72F4Jpi+5IonNuS7Fo3VeKdS/s/LctNf1S+LY0FCg+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fDdDAQqq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EE71F000E9;
	Thu, 28 May 2026 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998295;
	bh=CqWolaGS2vqdFTGKC+Lp78Eg7SHfnA4l2vqLZ4NiD6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDdDAQqq6wGfbMbz5lbGO1sYLDU+LORb/eHM3RsuLUGLj4XeXKr2jbudQrKY64phL
	 2Hena55TH/oCTUEJWSkZt1rQSLoKiNlnE4HdQajiL1CXk2YOIPMhNoEIPHvj6Ak/iE
	 8kXXj1lAJkvaMOxIKgkJ/I2IKoX+4mHUiIxh6qt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heechan Kang <gganji11@naver.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 7.0 124/461] fwctl: pds: Validate RPC input size before parsing
Date: Thu, 28 May 2026 21:44:13 +0200
Message-ID: <20260528194650.571663501@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255219-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,naver.com,intel.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,intel.com:email,nvidia.com:email,naver.com:email]
X-Rspamd-Queue-Id: 6BF6D5F7941
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/fwctl/pds/main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -362,6 +362,9 @@ static void *pdsfc_fw_rpc(struct fwctl_u
 	void *out = NULL;
 	int err;
 
+	if (in_len < sizeof(*rpc))
+		return ERR_PTR(-EINVAL);
+
 	err = pdsfc_validate_rpc(pdsfc, rpc, scope);
 	if (err)
 		return ERR_PTR(err);



