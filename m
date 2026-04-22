Return-Path: <stable+bounces-240360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAmUD9Dy6GkdRwIAu9opvQ
	(envelope-from <stable+bounces-240360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:09:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD62448467
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29259303B8E3
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6C238F226;
	Wed, 22 Apr 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLdUHqnY"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5AC37CD54
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873917; cv=none; b=ZfSV1FtKgHSsYv0wtF9KNLjzlIp+IRFaZpGltNLb5Y2tFRVZeXnUVP5p64BcGle5NjkD7hjtLVuE4MAfQeR7xG2b1uQEi+xbgrB7QfRRhVm6LWZt172lwFgDrrYbBn7c8ury7N2L6NeuoxpOfFjF2/NdP/CAKksPZ8/m01DGHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873917; c=relaxed/simple;
	bh=AtnVryVx9lrXSxBtUvHjd0g9UDr19+73eoU6BB1Ndsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAy2ZLrFoMi1rWHbt58h23Qho3uPaanoNqcw5bfIANtAiqivpeTd3QfDjD5KaVrUBPoQQC0/M7ifttFcJpAsr1aeiEFsYYCHxO0izvREyYzHfyLal/Lhaz7PUZZc8M9ywn6RJk1XotNn+0ys7qtavFoYgaSP/iopNddTIUbmsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLdUHqnY; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89fc349b5ceso79902316d6.3
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873914; x=1777478714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAsi8zUH7ChWQsvBus194I1lIQB9uLlb+xLBIearhJU=;
        b=aLdUHqnYoPmjaVv77TbajnV64t+k67UNr+/eSkA92z9mGge6w60zePtKDJkemqRBsz
         FaVj66iKYrFVWCzc6tdvGP7B2rP8/HuwDJ3k9OzI9MSpzlVC2j5b11vxwafuoBxVDH+E
         yvMKawCmuFVOsH0UJLDMl7KpdhvB+RuKlI5QaIRI1f62Y3/bHY8+VBH+dzvSgry/16mS
         sA8OsDIwRjx3wuDwP2MjoT9djMOdoThLtP0vLcYRoe+0Nb0FTObW2JNX9dtr3sap3Qsh
         wkOqM+0Bb4lwdehyaWuYGU4l8/alXO1vapd9/7+hbxe9JAQ+neL6XbHsiMFvSDxhUxhn
         X9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873914; x=1777478714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LAsi8zUH7ChWQsvBus194I1lIQB9uLlb+xLBIearhJU=;
        b=kdDLTwfm+PuT2o9ckmS73nE8qhoJ0iY0QjU5/tNp9I3pLhipN66XSneAmz5J2u0a40
         nrFW5HqXDgaLumbkA+Gm1aTybMLF4OAVbJaYdqhuv/IAcsFEIBD7Kgmqzon7wH10fnYc
         vxqFPwAEsgIO3sVLLYq/KM8N85LEW/g2gS7UKOvMJn/BP5oRlnpOybsr+r6XUUBR/SFd
         Lkvw9hJad8XvkvKCrv88hA5R7sqJQEKd4/Q/HJZ+FVAIIyqkdBH0Om3MMaC32YUq93aQ
         vlVyU9oZFQyJ3drEsWca7JuwHJrD7aJYk8OmV23Cmt5UAzx+mtnKg3E/7QDw7zZeazDG
         2q2g==
X-Forwarded-Encrypted: i=1; AFNElJ/6OAvR9GCEsEUEBQTmtUrNfD5lNB0JgUAlZRiuuf+eXxImHWEZJJVLHMI0OL59OeokF/GXmGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZi+aGkCaBcC//ehkSxhDMo3gbZ2qn1gcVmn6NbZCBxpQEzOh2
	3emkm/s9UiTY5dIWQ7KLwUHhj8mECvg/pg5MNXweF1ULjzikmwJTp4ux
X-Gm-Gg: AeBDievcOXAJGqINCzzz2Y8p1l3Y4LygreO0nkjANSz1koZu+m4Yw0QunyeNcYbfpxs
	nD8/POo2YtvjbY9bDfa/44giTqn+Cc4gdWQtcquZM+RkpQB24PHo22iB6tPcDyOIkSmRDkd8WlZ
	Dfz2ZJXiV4dmW3DbrSMGVrl20gp11lSrO5OkrFWhrthJirCBJLtAdN8jUTAIEyMPGr5L3PIo4KO
	EBQdcMduHrFnhE/oPgx6/umJxXz31uwyCJD0JQDIYxStC+7M6n7qdeilpwjP3yM9LAgwJGXzRW0
	FCFLCM0JHKYqPqQKps3AZVBk97jSk7SJFS9qWKHMOlhmmkeA91YUGv7pgBSfdGVzsGoOYTFprz0
	oT0rG5B5QUpvWQJtYTOq2iPqyf14pOC2+OCNtXmZCf90qsalrGVp1yTPs/LeDWLG5cjv9FEj8ue
	zvcW1XTKwEqW23LV8542VsItYOPC4k9zIPxuaY7On6iI+Wt4p2kFe/3PYZGiO7GIt6XV2RBpXJI
	cx5aV6jDUEW9EJLT1mSa9EZL8fOmkg=
X-Received: by 2002:a05:6214:400a:b0:8a0:846e:8850 with SMTP id 6a1803df08f44-8b028042ba3mr348401516d6.20.1776873913609;
        Wed, 22 Apr 2026 09:05:13 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:12 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 6/6] net/ncsi: validate GP payload lengths before parsing
Date: Wed, 22 Apr 2026 12:03:42 -0400
Message-ID: <20260422160342.1975093-7-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240360-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AD62448467
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ncsi_rsp_handler_gp() now bounds MAC and VLAN counts to software
and GC-reported limits, but it still assumes the advertised GP
payload is large enough for the fixed fields plus the consumed
filter-table bytes. A short GP reply can still make parsing start
past the payload or walk beyond its tail.

Validate that the declared GP payload covers the fixed GP prefix,
the consumed MAC and VLAN entries, and the checksum before parsing
the filter tables.

Fixes: 062b3e1b6d4f ("net/ncsi: Refactor MAC, VLAN filters")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 94354dca23ea..565d38fd4b92 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -899,6 +899,8 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct ncsi_rsp_gp_pkt *rsp;
 	struct ncsi_channel *nc;
+	size_t needed;
+	unsigned int payload;
 	unsigned short enable;
 	unsigned char *pdata;
 	unsigned long flags;
@@ -924,6 +926,14 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
 	if (rsp->mac_cnt > mac_nbits || rsp->vlan_cnt > ncvf->n_vids)
 		return -ERANGE;
 
+	payload = ncsi_rsp_payload(nr->rsp);
+	needed = offsetof(struct ncsi_rsp_gp_pkt, mac) - sizeof(rsp->rsp);
+	needed += mac_cnt * ETH_ALEN;
+	needed += vlan_cnt * sizeof(__be16);
+	needed += sizeof(rsp->checksum);
+	if (payload < needed)
+		return -EINVAL;
+
 	/* Modes with explicit enabled indications */
 	if (ntohl(rsp->valid_modes) & 0x1) {	/* BC filter mode */
 		nc->modes[NCSI_MODE_BC].enable = 1;
-- 
2.53.0


