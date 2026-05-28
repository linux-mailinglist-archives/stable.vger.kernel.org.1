Return-Path: <stable+bounces-255936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GeqBn6nGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF7A5F91FD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08E963062148
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8A33372A;
	Thu, 28 May 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r2SE64VL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB425F7B9;
	Thu, 28 May 2026 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000294; cv=none; b=GmuzCa+ZFs8ZjT2c/rYOhZE5GrR1tOqxhhh0ZiPV+ty742g7KtdzuWeIINohotoNoAbXev0nWEvX74bEJDWnoiBLtjXIEDigxbLoN04nvJTZsLcKgXpRU1afwGqM1qxrhN4MWaw+MU1z27p0Htx8tNQ6FjSXt3Np7RA3AW4PDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000294; c=relaxed/simple;
	bh=7FGRltKymDszJgbwb8leSzAFWdXeA/IeLWGWJXOqrr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCJLclKuSHfowfP5SEMiT8IqLZItToi+kX6HwV8mBDPE7W0HODXxo00fO9NG7ipwvGa/CcqEjeQVQBWpshfmuOpqor+KXZmVRKe4PJRVPSuFEULvbKPIruOk+iWeahB3gu29QzJDxnpjRX9YvfOfEy5hwT+Ap8HAD8Q2YjYyOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r2SE64VL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7D11F000E9;
	Thu, 28 May 2026 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000293;
	bh=Capd6fK6zvGRNGrHX7SOUJN56MGZ+9F0qwn/JKZLYbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r2SE64VLMidTnJxBd26GuLb+jlAM2dmW4REfDOToN7xsv1JcwjPlJfIvUcTgfPAok
	 KE6oAk4g2OvwKDTBKF1gMooD7UMDYehtSO+Do//72xsuEdR0Mo5x6dNNXuYb/5AquF
	 xCbWaW2J8kunwgVUyGejMa6/Aw4orTsIsjSyrKB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 371/377] tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
Date: Thu, 28 May 2026 21:50:09 +0200
Message-ID: <20260528194649.171916536@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255936-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,asu.edu:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2FF7A5F91FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit bddc09212c24934643bd44fc794748d2bbb3b6cd ]

In the SIOCGIFHWADDR path, tap_ioctl() copies 16 bytes of an
uninitialised on-stack struct sockaddr_storage to userspace via
ifr_hwaddr, but netif_get_mac_address() only writes sa_family and
dev->addr_len (6 for Ethernet) bytes, leaving sa_data[6..13] uninitialised.

Those 8 trailing bytes leak kernel stack contents; SIOCGIFHWADDR on a
macvtap chardev returns kernel .text and direct-map pointers, defeating
KASLR.

Initialise ss at declaration.

Fixes: 3b23a32a6321 ("net: fix dev_ifsioc_locked() race condition")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260520075736.3415676-3-bestswngs@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 1197f245e8737..6fd3b14273b37 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -919,11 +919,11 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 	struct tap_queue *q = file->private_data;
 	struct tap_dev *tap;
 	void __user *argp = (void __user *)arg;
+	struct sockaddr_storage ss = {};
 	struct ifreq __user *ifr = argp;
 	unsigned int __user *up = argp;
 	unsigned short u;
 	int __user *sp = argp;
-	struct sockaddr_storage ss;
 	int s;
 	int ret;
 
-- 
2.53.0




