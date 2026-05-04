Return-Path: <stable+bounces-243502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNdTOYaq+GnXxgIAu9opvQ
	(envelope-from <stable+bounces-243502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:17:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E54BEFF6
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E48B304185C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664CD3D5667;
	Mon,  4 May 2026 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkCCEPuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6833AA4F8;
	Mon,  4 May 2026 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904049; cv=none; b=Nw6lDawCRjYVyCp5MQhQJsGr5HcXGcCzCKU/CF01sHOKhr+mg6J57ZoCdMkLCIQL2omaZsWEe/R83ZJ3zoFzCiLe8GN2wAKUks5jsFWsETOHRt1mExeK+rG07K0Jf8Z/IsApsoRJ33QzlThZSwzEImpBODBcm9m8b0Dr/l+Y0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904049; c=relaxed/simple;
	bh=WpZZD7JardDsPE8bNcHsHkeny9yjHL6ICzXy1HgNb8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jF4iBPlgApPn/dMkmNvjBPDD204UZUvjWS/cbk8/BK+qvtbHA6YH7xdmfIzDwIaSGCLWb8LprEl3JnmDm/zLlAYikb75OIbIMkmc+u0K9yO3F0NEHjbKSdOD6S6/Ebr2PLRSNMU6xe3MRDP4L7qnGntVOK9mqfWSOqDKMfZ2XQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vkCCEPuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5367C2BCB8;
	Mon,  4 May 2026 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904049;
	bh=WpZZD7JardDsPE8bNcHsHkeny9yjHL6ICzXy1HgNb8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vkCCEPuRRq81LfFuRo+xaih/01tRBftTI+PkX8jbcsUyMSksvkgp+GJ+IOPuVx1Uk
	 DcM1LQLOnn8G+VQfDXjMgtWK1hPBchkicbfVDIQCW2wtI0PV1tjb/xWN5nKVcylSDG
	 eXSRQH1JFlpxKkiCN8Ebe1em6oIBi++1VTiF8S+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	hkbinbin <hkbinbinbin@gmail.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.18 131/275] RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv
Date: Mon,  4 May 2026 15:51:11 +0200
Message-ID: <20260504135147.767594422@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 750E54BEFF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243502-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.dev,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,nvidia.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: hkbinbin <hkbinbinbin@gmail.com>

commit 7244491dab347f648e661da96dc0febadd9daec3 upstream.

rxe_rcv() currently checks only that the incoming packet is at least
header_size(pkt) bytes long before payload_size() is used.

However, payload_size() subtracts both the attacker-controlled BTH pad
field and RXE_ICRC_SIZE from pkt->paylen:

  payload_size = pkt->paylen - offset[RXE_PAYLOAD] - bth_pad(pkt)
                 - RXE_ICRC_SIZE

This means a short packet can still make payload_size() underflow even
if it includes enough bytes for the fixed headers. Simply requiring
header_size(pkt) + RXE_ICRC_SIZE is not sufficient either, because a
packet with a forged non-zero BTH pad can still leave payload_size()
negative and pass an underflowed value to later receive-path users.

Fix this by validating pkt->paylen against the full minimum length
required by payload_size(): header_size(pkt) + bth_pad(pkt) +
RXE_ICRC_SIZE.

Cc: stable@vger.kernel.org
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Link: https://patch.msgid.link/r/20260401121907.1468366-1-hkbinbinbin@gmail.com
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rxe/rxe_recv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -330,7 +330,8 @@ void rxe_rcv(struct sk_buff *skb)
 	pkt->qp = NULL;
 	pkt->mask |= rxe_opcode[pkt->opcode].mask;
 
-	if (unlikely(skb->len < header_size(pkt)))
+	if (unlikely(pkt->paylen < header_size(pkt) + bth_pad(pkt) +
+		       RXE_ICRC_SIZE))
 		goto drop;
 
 	err = hdr_check(pkt);



