Return-Path: <stable+bounces-238194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD3ODVvg32kzZwAAu9opvQ
	(envelope-from <stable+bounces-238194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:00:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 834784073FB
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B59F314623A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440DE381B0D;
	Wed, 15 Apr 2026 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqqQ7ElU"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC673195E4
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279351; cv=none; b=lX9fQrBZA6HXkeLoq5uw+KUxGxW0EgjpBqSFSWPcaJoXdn7PKWds9F4s5yuPWWotM1PDBIrh9YVaC/B+sXfrXHOjiZAvxJfVewk80ZKMkL6KW92/PaxYIbYM3ZGJrwzxoNa4ApGBx0PTdTrorTZpjrjBUL4OQo3qGrtvQHe2goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279351; c=relaxed/simple;
	bh=Fd2F7C28NBMqNA7NBSvFz00bwpJ9oafZoR1UGpaikho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV7IZ6iZoBbN/QJdHkcQGDyQh3aq4ItE63q45RrQYz8vy+vbR9CfkIlXHIJuCj6t6B8ceqMFjmXrzgAcqBOR6q9zFSEr1xU8uj/VzuuJPjynijKdqmx0vcU7Oa6uIVULArkmRxnUzgDYDCT5zN1WM6lVdOMOqeoVswDKRWAlBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqqQ7ElU; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56f65f62b4cso1267396e0c.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 11:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279347; x=1776884147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YWqAx6Tf+rAcS8XG7Epy7pp0WO11keOg96xigh14Ss=;
        b=OqqQ7ElUaRrx6kjYKxLgahroiU6Bb2wtur14s5j/3v/tq0uKrXLIWXommn70iFXqTS
         1xvB+nOe+iEAuvOPDCewbTc3iXVmU7HerxbgPmm3vMTMEa/uqyz/DjQF0ZGAWZyj8Ja6
         Ne0/0ba8CzJoeXYhv2dZKp6g2yCunetK09aPZAKykfpT5hiSwdjksZ22AFi4PDHg5jlT
         DWKi0MgTvmsmAAMQTxf4Lv1rw5kwCJUju+U2ZkP6FYX5b14i2HpRZOTPgXC+MK3jugEY
         g7xxOO+k5xx8cVmqOW9bWA6dvbZ2wjVrGmYNkjgFYOyjsC2mcF7mPoJ1SKF6ixTbOPEC
         jZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279347; x=1776884147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6YWqAx6Tf+rAcS8XG7Epy7pp0WO11keOg96xigh14Ss=;
        b=EZ+4uJhRD2RS/MDmhUzCiXOLLnH8EkWd6QwQE2usdK8DlK7kko64DZFJthQ32akUWf
         O/81Y0NcB9sfwaRaOImXRfw6XLo9QpoN0qsSrXKE77GsY6R13x2P7BoH+hsp6OHZalw8
         FoWXA3IC6+BlnRu6Zwc84k0ysL9CHuho55HOtm1mZQyH0BtaDLhfRQ/rOFt3EpNOaa1T
         N3XGCMUGGZ8WNwPSb0Q4iErwPhrmlbh+HmsEje6mmnXBHPeObqrQq6byY4tM2T62Wt7v
         BnFV40dRkR7InVubms7S9atylm9Bpv5cX9kL223eXlkMW8gluR2zoUMnlehDwEYfuVOG
         tdQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aTOzlmXvaPyyowiMl0BVLXh7PlEDCKiHkbTE24/T/EVwFDbRY14yvK2bPUpxZtscCSwjVHtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34qe8HqVBc/StDBM8KNxvt077ETAzKtdhrQp5M0hc2/I+fGOj
	L7U8eXSpjuVJu+mnmTBixc4lAbyDMxn8O18LlmhnHgsJKdPn9w8ug4Ie
X-Gm-Gg: AeBDievh466R9eR7VGI2+2PCFh5D/qvSOxfucKIWGGCuhNv0YsaiwT93ZXk/AUdzT+P
	W0HIfUtkoD9PLo/3xSfx1O2H7lIMnYx3KjM9/4Tys+GRjLaSTrnCx3/tnvpvmYp0X+2KXwNdDo8
	TWeX5nsVkILIW3uf4SCHkARcuJLyg//y1x6MK4G/VexE8gQEfj6x9RAcq5JbBNHyeh9e6d5jlKJ
	uf/pWvN4T3EKTZppk7tv07ZXMKO4lJfMZDOJJjWkYMG5heAahzLZmf9eBtJPfCqjdG0+EaWg80V
	uPleLvnFoRx+G5LjTWXWCbyXnMNYIeqIXZR23bdestt93v+CEaWuBprN38bVhIjvBs/rvslRa3j
	iONvnSq5iq2VuBljvHe6oli19YyB8rcMOncBdMTuQCuLQ4hZ9lyRGqgEgQ229NiXrII/eLQwcdc
	yDWQiCsTzF91BWATh+3E/A7eRw6AFwJSs0IwHKpsBUxKf2GbWtA+TJ
X-Received: by 2002:a05:6122:8483:b0:56f:6add:9041 with SMTP id 71dfb90a1353d-56f6adda1bbmr4615042e0c.11.1776279347467;
        Wed, 15 Apr 2026 11:55:47 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f89feb56esm1647484e0c.15.2026.04.15.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:55:47 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org,
	error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v4 3/5] staging: rtl8723bs: fix out-of-bounds read in portctrl()
Date: Wed, 15 Apr 2026 19:54:59 +0100
Message-ID: <20260415185501.440492-4-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415185501.440492-1-delenetchior1@gmail.com>
References: <20260415185501.440492-1-delenetchior1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238194-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,get_maintainer.pl:url]
X-Rspamd-Queue-Id: 834784073FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In portctrl(), when 802.1X port control is enabled and a non-EAPOL
frame is received, the ether_type is read from the LLC header
without verifying that the frame actually contains enough bytes to
hold the MAC header, IV and the LLC header plus two bytes of
ether_type. For sufficiently short frames, the memcpy() that loads
be_tmp reads past the end of the receive buffer.

An attacker within WiFi radio range can exploit this by sending a
crafted short frame. No authentication is required.

Validate the frame length before dereferencing the LLC header; drop
the frame if it is too short.

Found by reviewing length validation in the receive path.
Not tested on hardware.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v4: add Fixes: tag and Cc: stable (Dan Carpenter); carry Luka Gejak's
    Reviewed-by.
v3: rebased on staging-next; sent as numbered series with proper
    Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and did not
    apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 28 +++++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 00b69571bbb83..c0a1c2ab710ee 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -539,17 +539,25 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 
 			prtnframe = precv_frame;
 
-			/* get ether_type */
-			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;
-			memcpy(&be_tmp, ptr, 2);
-			ether_type = ntohs(be_tmp);
-
-			if (ether_type == eapol_type)
-				prtnframe = precv_frame;
-			else {
-				/* free this frame */
-				rtw_free_recvframe(precv_frame, &adapter->recvpriv.free_recv_queue);
+			/* Ensure frame has LLC header and ether_type */
+			if (pfhdr->len < pattrib->hdrlen +
+			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
+				rtw_free_recvframe(precv_frame,
+						   &adapter->recvpriv.free_recv_queue);
 				prtnframe = NULL;
+			} else {
+				/* get ether_type */
+				ptr += pattrib->hdrlen +
+				       pattrib->iv_len +
+				       LLC_HEADER_LENGTH;
+				memcpy(&be_tmp, ptr, 2);
+				ether_type = ntohs(be_tmp);
+
+				if (ether_type != eapol_type) {
+					rtw_free_recvframe(precv_frame,
+							   &adapter->recvpriv.free_recv_queue);
+					prtnframe = NULL;
+				}
 			}
 		} else {
 			/* allowed */
-- 
2.43.0


