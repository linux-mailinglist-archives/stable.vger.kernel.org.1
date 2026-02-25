Return-Path: <stable+bounces-218046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IreNd9PnmleUgQAu9opvQ
	(envelope-from <stable+bounces-218046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:26:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB5718EA58
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0F27300830D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF02505B2;
	Wed, 25 Feb 2026 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vMbwLs2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB732494FE;
	Wed, 25 Feb 2026 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982811; cv=none; b=Ci23bjSk3TkUtJep19Z4TyCBXoUUfg6WxBleikQZgWaoY1DLG14Dz8i1gL70MDQDbGnE/tnMlEO/tGRQ6ZeNAFI3JDP/4BCg2gj2kj0gGpQtOl+IQSBTwVeyXMGkctDLkE/Tzpezl/9O2QK0Q4928u/SrV6Q/KC/Nm6OSmuHBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982811; c=relaxed/simple;
	bh=3veGEpr9IWV/uQRVKmwYZGzwiiArIpJAgnsOB4LUuig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MagXy7wQsDPNac0/9VLlvTLVRIAb/tZaCw4DA9g2WNLIt20t9Vom/OiNnglTvq7bgIvYFkPHHI6QEeMXoC/eHwhiEFkFCTxZka/DpbBdAGTK8WWVTzbjYFVL2H099tcWoLgbCw4pflLrRwKGjna0iQ3rEHn8S651IkkvCncJGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vMbwLs2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEB5C116D0;
	Wed, 25 Feb 2026 01:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982811;
	bh=3veGEpr9IWV/uQRVKmwYZGzwiiArIpJAgnsOB4LUuig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMbwLs2L2LGLlHiaEmMfbBYEukoOYLCZ0Qp31FSs3nLu/2vWjaOsvJ0N0cpX7yhS+
	 g79OT+j65WlLzGEUpZiJTJyCnTVYXv/u5Sq1Asyidy01Ai9sIyBcWNgKHCkzOxxqBu
	 SjjlsvbUjtgvrGyhXYP940CY58gQZSaDwMMKosXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	YunJe Shin <ioerts@kookmin.ac.kr>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.19 001/781] RDMA/siw: Fix potential NULL pointer dereference in header processing
Date: Tue, 24 Feb 2026 17:11:50 -0800
Message-ID: <20260225012359.735763472@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218046-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7AB5718EA58
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YunJe Shin <yjshin0438@gmail.com>

commit 14ab3da122bd18920ad57428f6cf4fade8385142 upstream.

If siw_get_hdr() returns -EINVAL before set_rx_fpdu_context(),
qp->rx_fpdu can be NULL. The error path in siw_tcp_rx_data()
dereferences qp->rx_fpdu->more_ddp_segs without checking, which
may lead to a NULL pointer deref. Only check more_ddp_segs when
rx_fpdu is present.

KASAN splat:
[  101.384271] KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
[  101.385869] RIP: 0010:siw_tcp_rx_data+0x13ad/0x1e50

Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
Link: https://patch.msgid.link/20260204092546.489842-1-ioerts@kookmin.ac.kr
Acked-by: Bernard Metzler <bernard.metzler@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/siw/siw_qp_rx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1435,7 +1435,8 @@ int siw_tcp_rx_data(read_descriptor_t *r
 		}
 		if (unlikely(rv != 0 && rv != -EAGAIN)) {
 			if ((srx->state > SIW_GET_HDR ||
-			     qp->rx_fpdu->more_ddp_segs) && run_completion)
+			     (qp->rx_fpdu && qp->rx_fpdu->more_ddp_segs)) &&
+			    run_completion)
 				siw_rdmap_complete(qp, rv);
 
 			siw_dbg_qp(qp, "rx error %d, rx state %d\n", rv,



