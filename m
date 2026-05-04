Return-Path: <stable+bounces-243176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKc9Hjeo+Gl+xgIAu9opvQ
	(envelope-from <stable+bounces-243176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1244BE913
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E9B3043FE4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35BE3DE431;
	Mon,  4 May 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B+B3ouCq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872893DE422;
	Mon,  4 May 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903211; cv=none; b=IW7HHDxnRKL+UfPJJnLqvlmXVuZwqsquOeqSppKqxhdOY5StP5s+cGf2+ruy1xvSbaYSwoaER82eBCJtA6cdgzZPcW8IEk+KoaY0rpwVfl5n2orWJlOBBJ9q4SjjoYY8IjBwPKh9htcBN6vxlbqCYjS3Of0+HgRLI1/jaEJ2JVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903211; c=relaxed/simple;
	bh=Cz0BRt3uYJuIQ/xAqLlgF8sALnPn0hMDUCykdmJ+Iog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPNqSAn+XMyFXWm5UpT/cfgbRwwt76CfXho1pG8y1kG0wlcBeaEnTZiI4nLUiPxqhLDhFomJgTres0nGGznC3ZfyTsFFvTVQosU8eDvB1QPmJESBlajMKPFfdzKQGLv94CQyjq2ey4Tq4abQPQ/UE3VRfX2iqLQIMPIW8r5wnwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B+B3ouCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5013C2BCB8;
	Mon,  4 May 2026 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903211;
	bh=Cz0BRt3uYJuIQ/xAqLlgF8sALnPn0hMDUCykdmJ+Iog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+B3ouCq0dwJZjI/51pcSg/PTsyBnICJIDD4nNb+4Vzem/a6C4NL49ReNGzFoXZmf
	 rDIvx7UA/DfQKoBH9AQzkXolONTEJz6xeVSMKn83PnV0MbH6yMTxqf0a1w4+LSR+ba
	 K6KafDR5tTjgd+j2IvWMBHZor9f9Tx9nyiriQwjc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Zhaoming <yuanzm2@lenovo.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 147/307] net: mctp: fix dont require received header reserved bits to be zero
Date: Mon,  4 May 2026 15:50:32 +0200
Message-ID: <20260504135148.308188216@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CE1244BE913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243176-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,lenovo.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuan Zhaoming <yuanzm2@lenovo.com>

commit a663bac71a2f0b3ac6c373168ca57b2a6e6381aa upstream.

>From the MCTP Base specification (DSP0236 v1.2.1), the first byte of
the MCTP header contains a 4 bit reserved field, and 4 bit version.

On our current receive path, we require those 4 reserved bits to be
zero, but the 9500-8i card is non-conformant, and may set these
reserved bits.

DSP0236 states that the reserved bits must be written as zero, and
ignored when read. While the device might not conform to the former,
we should accept these message to conform to the latter.

Relax our check on the MCTP version byte to allow non-zero bits in the
reserved field.

Fixes: 889b7da23abf ("mctp: Add initial routing framework")
Signed-off-by: Yuan Zhaoming <yuanzm2@lenovo.com>
Cc: stable@vger.kernel.org
Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>
Link: https://patch.msgid.link/20260417141340.5306-1-yuanzhaoming901030@126.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/mctp.h |    3 +++
 net/mctp/route.c   |    8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/include/net/mctp.h
+++ b/include/net/mctp.h
@@ -26,6 +26,9 @@ struct mctp_hdr {
 #define MCTP_VER_MIN	1
 #define MCTP_VER_MAX	1
 
+/* Definitions for ver field */
+#define MCTP_HDR_VER_MASK	GENMASK(3, 0)
+
 /* Definitions for flags_seq_tag field */
 #define MCTP_HDR_FLAG_SOM	BIT(7)
 #define MCTP_HDR_FLAG_EOM	BIT(6)
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -441,6 +441,7 @@ static int mctp_dst_input(struct mctp_ds
 	unsigned long f;
 	u8 tag, flags;
 	int rc;
+	u8 ver;
 
 	msk = NULL;
 	rc = -EINVAL;
@@ -467,7 +468,8 @@ static int mctp_dst_input(struct mctp_ds
 	netid = mctp_cb(skb)->net;
 	skb_pull(skb, sizeof(struct mctp_hdr));
 
-	if (mh->ver != 1)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto out;
 
 	flags = mh->flags_seq_tag & (MCTP_HDR_FLAG_SOM | MCTP_HDR_FLAG_EOM);
@@ -1325,6 +1327,7 @@ static int mctp_pkttype_receive(struct s
 	struct mctp_dst dst;
 	struct mctp_hdr *mh;
 	int rc;
+	u8 ver;
 
 	rcu_read_lock();
 	mdev = __mctp_dev_get(dev);
@@ -1342,7 +1345,8 @@ static int mctp_pkttype_receive(struct s
 
 	/* We have enough for a header; decode and route */
 	mh = mctp_hdr(skb);
-	if (mh->ver < MCTP_VER_MIN || mh->ver > MCTP_VER_MAX)
+	ver = mh->ver & MCTP_HDR_VER_MASK;
+	if (ver < MCTP_VER_MIN || ver > MCTP_VER_MAX)
 		goto err_drop;
 
 	/* source must be valid unicast or null; drop reserved ranges and



