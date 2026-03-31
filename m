Return-Path: <stable+bounces-231856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDPkEaT8y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56936D71E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612F93115F9C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D8426D0B;
	Tue, 31 Mar 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FjvjpDBQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE50426D05;
	Tue, 31 Mar 2026 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975247; cv=none; b=HXW29ug9bv4N0Wxp2/g785gy9KkO9tIoB1Z+oy6iHX01DKYHHSuy8zrkCA7oz9/KrIzcz7Z71S5C/NU6vXnCpLHpITJTu4PxXQ9HPVfkLBlIWJtYgdtn3QR3XJ0hscD7/Uc5OdS/zh/Rd4DGg7qiV6Z297wdM6H6MpK7elT6rBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975247; c=relaxed/simple;
	bh=MhBO4gOm09NSA0Rh1T8v0o0pHWEwbFYA/JvokkY3JS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDDoVKDjnZ9Cb3MV9Pa2Xchct6SqZ31G4xGWrei5IKTl0rBI4Uan1MoVWbzR1iBXHnC1yt13ZXWvHzBO8HqrIEKhTM45WZEYQHpUsU23WZAZxhH23vRPPN8LNJbvR7STqa/I4Jg7tPRrBrEj8ELOaNeMki4I/SKI5Gx/v4NSuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FjvjpDBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B6C19423;
	Tue, 31 Mar 2026 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975247;
	bh=MhBO4gOm09NSA0Rh1T8v0o0pHWEwbFYA/JvokkY3JS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjvjpDBQ3PuBHY/0LDKC9qDUUOH6FFXrsQE+enNsc+ktMjbulPhaDT+MAfD7bhvnN
	 gAiXzdOIpltB7jCeWkYuFB0RgCu2LcIbVWkVI6QIc+ONqUuStJh0SDau+UqIOZ1N9R
	 2++8wRB997zzM6rwV05BIop6i2osnVtkTFCUIoYs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.19 220/342] RDMA/ionic: Preserve and set Ethernet source MAC after ib_ud_header_init()
Date: Tue, 31 Mar 2026 18:20:53 +0200
Message-ID: <20260331161807.069969327@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231856-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9E56936D71E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abhijit Gangurde <abhijit.gangurde@amd.com>

commit a08aaf3968aec5d05cd32c801b8cc0c61da69c41 upstream.

ionic_build_hdr() populated the Ethernet source MAC (hdr->eth.smac_h) by
passing the header’s storage directly to rdma_read_gid_l2_fields().
However, ib_ud_header_init() is called after that and re-initializes the
UD header, which wipes the previously written smac_h. As a result, packets
are emitted with an zero source MAC address on the wire.

Correct the source MAC by reading the GID-derived smac into a temporary
buffer and copy it after ib_ud_header_init() completes.

Fixes: e8521822c733 ("RDMA/ionic: Register device ops for control path")
Cc: stable@vger.kernel.org # 6.18
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Link: https://patch.msgid.link/20260227061809.2979990-1-abhijit.gangurde@amd.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -508,6 +508,7 @@ static int ionic_build_hdr(struct ionic_
 {
 	const struct ib_global_route *grh;
 	enum rdma_network_type net;
+	u8 smac[ETH_ALEN];
 	u16 vlan;
 	int rc;
 
@@ -518,7 +519,7 @@ static int ionic_build_hdr(struct ionic_
 
 	grh = rdma_ah_read_grh(attr);
 
-	rc = rdma_read_gid_l2_fields(grh->sgid_attr, &vlan, &hdr->eth.smac_h[0]);
+	rc = rdma_read_gid_l2_fields(grh->sgid_attr, &vlan, smac);
 	if (rc)
 		return rc;
 
@@ -536,6 +537,7 @@ static int ionic_build_hdr(struct ionic_
 	if (rc)
 		return rc;
 
+	ether_addr_copy(hdr->eth.smac_h, smac);
 	ether_addr_copy(hdr->eth.dmac_h, attr->roce.dmac);
 
 	if (net == RDMA_NETWORK_IPV4) {



