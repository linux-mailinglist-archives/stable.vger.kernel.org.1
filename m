Return-Path: <stable+bounces-248610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDfeEoBYB2pmzgIAu9opvQ
	(envelope-from <stable+bounces-248610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:31:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A6D5552AC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3C732B3A5F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581153FBB4A;
	Fri, 15 May 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SldXS1ki"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6413FBB40;
	Fri, 15 May 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862173; cv=none; b=K7qLAgh3TBWQLDsYpZX03lysU3Q3xHUOq4311V6tsMVHx4WOuKgeHHEsIR27OAeLCEwVPB05BdRL6m8/qfGfcabdJoVekc/8q2wkOXbBmmdQ3Y4qcFM4rlXQNRJBVgNIHleTJdLVIlFZi8pS4jiREOiXHJB1Rli/XFm05bIpk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862173; c=relaxed/simple;
	bh=eljk+e9Mrxgw39gRTkICb+Colj8Uwz5xjpRa6Iodemk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucg+y5ubCId1YhA5MtuK0QnuQy4Wf5WwgTBBhVLxCKGi04bDIY535ZQeL2jSSgfZK+XRy5PJpggGB5XkwjuvA7ykMwu5Mp6REeZbfJ7X+FIwc6LEGUzK3JxrZXHfcfrzZKmAFxdKQQd1naNYwb8Wmoh37poOm0696X1DkWsvcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SldXS1ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE63C2BCB0;
	Fri, 15 May 2026 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862172;
	bh=eljk+e9Mrxgw39gRTkICb+Colj8Uwz5xjpRa6Iodemk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SldXS1ki5qnTVMXYyqi/lsc15dTYugHTwbrrFRVdZ5q59fm/g55wfhFVTHtVkCysm
	 51zZQ+sBmaD9gPKvPV9opnlTHDx9Mv9dY27I46+W4vhBITNkaRKpS3ooZ7JS67dYT5
	 b45TCGigzvdS/H0gD1C2sHXl/O7rx15jyoWUKFg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyes Bourennani <lbourennani@fuzzinglabs.com>,
	Alexis Pinson <apinson@fuzzinglabs.com>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 136/188] batman-adv: fix integer overflow on buff_pos
Date: Fri, 15 May 2026 17:49:13 +0200
Message-ID: <20260515154700.279383213@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C1A6D5552AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248610-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,narfation.org:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyes Bourennani <lbourennani@fuzzinglabs.com>

commit 0799e5943611006b346b8813c7daf7dd5aa26bfd upstream.

Fixing an integer overflow present in batadv_iv_ogm_send_to_if. The size
check is done using the int type in batadv_iv_ogm_aggr_packet whereas the
buff_pos variable uses the s16 type. This could lead to an out-of-bound
read.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Lyes Bourennani <lbourennani@fuzzinglabs.com>
Signed-off-by: Alexis Pinson <apinson@fuzzinglabs.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_iv_ogm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -335,7 +335,7 @@ static void batadv_iv_ogm_send_to_if(str
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	const char *fwd_str;
 	u8 packet_num;
-	s16 buff_pos;
+	int buff_pos;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct sk_buff *skb;
 	u8 *packet_pos;



