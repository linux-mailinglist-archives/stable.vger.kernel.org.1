Return-Path: <stable+bounces-238419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDIQLOHQ4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:19:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07F417573
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AABE931013C1
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE5936920F;
	Fri, 17 Apr 2026 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LozCgFjd"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F236BCC0
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406346; cv=none; b=G7lFyQ3gLE2v0rpROdRtFeXq+/Chcf5GrY78Qel6077r2J0GHy7fqmYndqBSygTnuW2N8RV6o/TWyG//qwdfUuabCv3KEtNbc0vvbkdxWxDQIbnSppLkoFiQuGRZ3TP5LvpEcwrrNaMT3RZnw6z6Rbskzjmk1vkCiuWij0gQuKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406346; c=relaxed/simple;
	bh=2IOSrS/BCoF+OLbUXBknmlZ3v2w7geVGIulEGVdpUXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7gOXXmATX3Y0PpD2Vc2rGx7y7tHrS7DFj9TKG8cFOLZ0na2/LRdXJ4yHLmkuN6vVlgWSRxu+o44C1eM6b6uwcn+97jjTMm1FLOobD8WNn2OikGvKnc9rn8OzOVSSmo0DjYAeAyfETg4Gywxp96SFizG+1vEet01tcHGejghOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LozCgFjd; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56d9f191ae6so225285e0c.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776406344; x=1777011144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WeGK87I6I6uRVhZdQgQ7htgqEpuNuywO5trnD/VR80=;
        b=LozCgFjdJG6nOtYMPHyGdKrrNHUSpnNRVlL4WX1VHq9YkuGFVQx2BU4oCmaihZoPpm
         gGJX4F4+V63CPYESviJ97H8HcIyZ6tmTQ4iEOE0rXTt0ioA1zCxEoNiXNoUvPeH/Os1l
         cK/oPdZRhaRCzD1y67+tTwJOeNw9SypoEyDh+3VDGZe0QqxOu6SDSDlxEbc/WrFO2GE2
         tHRwR7U/JIwWG4JlJ1ZA9cQJVhngeU4tn0rHMII3kamxCX+sTYdSEgH466WSWN1FEUyV
         zRmgqERDE2PyRe2X6+eDC29eyMTt7uzOgzfQY9UkvLg4nQh9hl7YEyZ9bqsZCBmd1Y5A
         CqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406344; x=1777011144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6WeGK87I6I6uRVhZdQgQ7htgqEpuNuywO5trnD/VR80=;
        b=eHXuD52I8X005PiEJLNzWw7Yx0xrAtILba2FQpUBOMQs8dTPd0m5U+/99TkoueVF5w
         3aeGJ7D5sLZG8miO5Y2c4aQLG3hCw22KLlRjqtF9j7fdFrSrHPWCpNbRsji9ZeXkWi9f
         kPRzTqtr3H8UkSKKZBwVJyW+24jRFdc4vox4/6+C3IEJM+AvdTLGnhjr/UJcZCg+D9T8
         4BpKA2ahBIsEempO0XmkujlvKsLhDPcnUgRb5l/T+IJJALTlGS71QCJZxRjxyY61cvxy
         8VB33jQd7/L9iAQyqaRjakFeoMEiijgd8W969AbJb6fBLN3L1WmZ0j8BGHz7Rog+nU5z
         zTCA==
X-Forwarded-Encrypted: i=1; AFNElJ9fgfp1mFDoKRSysuC49VAdokOpulE8gfsHbpPyR7AXMf//ZQof/Gw9CQT/zhkltnLU5AdmK4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy94xxgHjUsNY0ATojorOgHwQEWKJ6xLSk5lsuhqh6jhiYVBbeK
	bISlHyYkoRcxZ2Ivy3rqNrFDadAFMgmpbrFW3q6SIfhqUeyt90VmObzT
X-Gm-Gg: AeBDievGe1i96uwKMHIxq1WtHve/JvRtjhuraRUKNVrqy2AiFhpiAqQKRtJlqwaBEWD
	pztPyK7TzxGdZErkUMo0FXe4P/w0wxgh62idEiF4x3MdKaLGJ6xZQ/RCQlekCSjdeg7KVlwHUne
	szd2b4g0S/TNtStAiPEQdtQKq6mn5Q01n+5MKOFkPO1MfSKbwcy6qzToHRDU14UEcNX30ffzU/4
	DM+bp7wpHX1u5CVW8TfvgtcU2gFno58js/LHtemR8wObU9+z8AaU154wgGjTRRHh8C0xZhP11MV
	L+Fb/m3S+eYgsAS5jSgeSjGMMLN1JC2JvgbIRb3ioTK3KA8FWxeQJMEsiH3hWZcs2wsHzbGvXVW
	PNj7tChbbSJQIbQSy2gqxVJLWT/56hY9FdHVA6+mzQQInpJzG2MmIqT7QA0jnWZjRb0o52ELIxY
	zt9lbHQveD/++jPbNw0oLPedKyC8mxmHr+d1WJ+0prhL/HYB9CHhC3
X-Received: by 2002:a05:6122:1795:b0:56e:e80c:bb25 with SMTP id 71dfb90a1353d-56fa5a9dd17mr699227e0c.13.1776406344185;
        Thu, 16 Apr 2026 23:12:24 -0700 (PDT)
Received: from localhost.localdomain ([102.244.98.124])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589093a8bbsm297947241.3.2026.04.16.23.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:12:23 -0700 (PDT)
From: Delene Tchio Romuald <delenetchior1@gmail.com>
To: gregkh@linuxfoundation.org
Cc: error27@gmail.com,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Delene Tchio Romuald <delenetchior1@gmail.com>
Subject: [PATCH v6 3/5] staging: rtl8723bs: fix out-of-bounds read in portctrl()
Date: Fri, 17 Apr 2026 07:10:46 +0100
Message-ID: <20260417061048.62484-4-delenetchior1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417061048.62484-1-delenetchior1@gmail.com>
References: <20260417061048.62484-1-delenetchior1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238419-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[delenetchior1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,get_maintainer.pl:url]
X-Rspamd-Queue-Id: 2E07F417573
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
Signed-off-by: Delene Tchio Romuald <delenetchior1@gmail.com>
---
v6: drop the unrelated cleanups (ptr = ptr + X -> ptr += X,
    ether_type inversion into direct return NULL); the patch
    now only adds the short-frame length check before
    dereferencing the LLC header (Dan Carpenter).
v5: return NULL directly on the short-frame and non-EAPOL
    error paths (Dan Carpenter).
v4: add Fixes: tag and Cc: stable (Dan Carpenter).
v3: rebased on staging-next; sent as numbered series with
    proper Cc from get_maintainer.pl.
v2: rebased on staging-next (v1 was based on v7.0-rc6 and
    did not apply).

 drivers/staging/rtl8723bs/core/rtw_recv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index e30617875a69d..b476f7a03a234 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -539,6 +539,14 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 
 			prtnframe = precv_frame;
 
+			/* Ensure frame has LLC header and ether_type */
+			if (pfhdr->len < pattrib->hdrlen +
+			    pattrib->iv_len + LLC_HEADER_LENGTH + 2) {
+				rtw_free_recvframe(precv_frame,
+						   &adapter->recvpriv.free_recv_queue);
+				return NULL;
+			}
+
 			/* get ether_type */
 			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;
 			memcpy(&be_tmp, ptr, 2);
-- 
2.43.0


