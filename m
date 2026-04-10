Return-Path: <stable+bounces-235556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEjgHklk2GlDcwgAu9opvQ
	(envelope-from <stable+bounces-235556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 04:45:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF923D1898
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 04:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37A4730649E7
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17B1DED49;
	Fri, 10 Apr 2026 02:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="KItVt9wK"
X-Original-To: stable@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950C62F39B5
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788926; cv=none; b=gxCvYfTd9E9Phc1RSiAL4RSJfpxacZDJREavlCbOlaAUE1BR4S6lBDgSFz4/LtXyxYdB9D+mlSUtpNhWSUuq4Sg+O5QIh1sCPTXa4T1US7Zb3dhAi2k6OQXemDomFzGhP3BViY4DjWxSPYZEPsfx+C2RQEtcQDi1ixkVTHTCmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788926; c=relaxed/simple;
	bh=a4lni9hcsti9FZ1wRpFGW1X6Y+us/2ONM6YdbyDS/ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aNf/s2+VXu4lTtw7BGR0f/0j6ETShkGX/W/wUcfMpV9L7q9ZMc2rwz/XJAt/9XiPe56NRfTqnB9lnDha1rlgF2/IO56clEAPgVsP4L6m6ClEx0pR5HdMM4LFUXEDPunUbHzm7yvobnDPz/8Z4RNN1qMb/wpvxCYpQHuez+BFH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=KItVt9wK; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1775788923;
	bh=ruYH7ms7tY97YQislZdAnstwK+shvlV+EpfW2XTw8BM=;
	h=From:Subject:Date:Message-Id;
	b=KItVt9wKLHzB+W40SxDPW0oUFzAkSPlRErLEM5pTb05qUa3voV+hYwA3n53Vw/Hd3
	 jDi1EhnuVkF2eeSnhN4ICxzLuDbfJaNJw/Ky8xqKXHEpoh/hpBtLHZm5gIFzVPqilr
	 eNAVT460HLrCshLXQes/Y0+o0NKToS1AnbrbIjhI=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.22) with ESMTP
	id 69D8637300004E7D; Fri, 10 Apr 2026 10:42:00 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 5399577602229
X-SMAIL-UIID: 4C3470BD7AEE45A6807157EBF20EDA74-20260410-104200-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	arielsilver77@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	mchehab+huawei@kernel.org
Subject: [PATCH 5.10.y] media: dvb-net: fix OOB access in ULE extension header tables
Date: Fri, 10 Apr 2026 10:41:55 +0800
Message-Id: <20260410024155.3765938-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235556-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.cn:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[sina.cn];
	TAGGED_RCPT(0.00)[stable,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.cn:dkim,sina.cn:email,sina.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AF923D1898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ariel Silver <arielsilver77@gmail.com>

[ Upstream commit 24d87712727a5017ad142d63940589a36cd25647 ]

The ule_mandatory_ext_handlers[] and ule_optional_ext_handlers[] tables
in handle_one_ule_extension() are declared with 255 elements (valid
indices 0-254), but the index htype is derived from network-controlled
data as (ule_sndu_type & 0x00FF), giving a range of 0-255. When
htype equals 255, an out-of-bounds read occurs on the function pointer
table, and the OOB value may be called as a function pointer.

Add a bounds check on htype against the array size before either table
is accessed. Out-of-range values now cause the SNDU to be discarded.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Ariel Silver <arielsilver77@gmail.com>
Signed-off-by: Ariel Silver <arielsilver77@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 drivers/media/dvb-core/dvb_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index c594b1bdfcaa..c8cbe901bcf0 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -228,6 +228,9 @@ static int handle_one_ule_extension( struct dvb_net_priv *p )
 	unsigned char hlen = (p->ule_sndu_type & 0x0700) >> 8;
 	unsigned char htype = p->ule_sndu_type & 0x00FF;
 
+	if (htype >= ARRAY_SIZE(ule_mandatory_ext_handlers))
+		return -1;
+
 	/* Discriminate mandatory and optional extension headers. */
 	if (hlen == 0) {
 		/* Mandatory extension header */
-- 
2.34.1


