Return-Path: <stable+bounces-240125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHX5LLxV52nz6gEAu9opvQ
	(envelope-from <stable+bounces-240125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:47:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6F439B8D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABCC33011521
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8073F9FB;
	Tue, 21 Apr 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBv0HISO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B273B19B6
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768420; cv=none; b=DvakjAXuTzQGLvKzhDtIBiuJ8m2ZHU6zIbGsWleM0ri3w5cK34VYUuy3VBj7gJiUj6Tcl1ROLuaOuOSf/015kBWxVGxQQSyliDuyj1i78JWWqANA0+/ZaK1IhFzkGcMFcwY3aGhz5CGwu2tDQ5uMsHCIR0ILzwfyPyK/ARJx2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768420; c=relaxed/simple;
	bh=YE4xEaEm8Z1Zs64xYb7Sws3wIREFQx5oDmUEPY36rg4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=H3bcgYxXTmmOU7Rojj9bnYLOsl9u7Csv8bugAchsZF6RT0XUCQMAEKIILWq9Vv/2VJWpGSJMOQCRdC5tYLCjkF9+0jfuNxGdB5808vrKv0tlBB3hp3sAgqokNabVtNFP8meWtXB6O4pQ0WPyv0wPXGobWBQ8Phf2LtysSU8r/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBv0HISO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e06219cbso51720545ad.3
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776768418; x=1777373218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/udOUGzEjCi79/97ZZ0JQxYDEIsvCahdDGc/3JE8Y1U=;
        b=jBv0HISOQleBOC7oZWnca21gfJnBPMDtXTTs56oqZKBiRyX3bD4kVGawtDFhiyBtzg
         H3dC3GfZSQ4MvBApXUIvqeIJx3/rYun8p/xxsmoi19qyDGyOu8LGPiC8MXyQ1OLby1ex
         alxHVccPKHHgzqULf6q5+0qKFNkPocLKCStu8F6b6DCBrsR8tLZoHFQlEwvb/s/ucnJ6
         aX/SI63SLk/rs8YmGbVuH732c6C/3ouKjc8mQmN9uiRmVY4ULIaDldqp4vuJuFp0hB63
         VCZyp895oCEIs6zDRh2KKyVLC0JFrD4zHqwLa/wStdbx1m8omvNw11KlFvff0OJEpixd
         Hlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768418; x=1777373218;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/udOUGzEjCi79/97ZZ0JQxYDEIsvCahdDGc/3JE8Y1U=;
        b=Tji7/B58PNWlQkdrOorgAOqrOPAa/iob3qhkBcGpnDEB6vEU5RQjnLN8H3kITXaa+W
         HG6U8Ls8Z8MT2RCYpSBGkSjQiPut6lRiBzVGTT16NZq9q6Z3aAl4YEOP4uPv1jmGzEaB
         YEGO9BAWcFEPCQ9AWfHu+hm4YfYrNqymqUmiufj5DjHXbi76KylJ4jzQzJVgRQllMuj1
         Imt1Ub2V5vcwc280uX9W0y3bcLjNVPpORn86j57BcEL3tkpWBxO4XRaeDzEep3lwUMVe
         nw5Jr66Yhn1jAfvz0kSSyALtQc0mloeKgbo4ENXNDvZR8htIWEp7tbJ9Hwa6Gg0HcWjG
         zqsA==
X-Forwarded-Encrypted: i=1; AFNElJ8DP1CfELGU8v112og//R9lXLLgCwQk6pqKRE8nJ0oaCZ8Dq2xzdgrdgdbsB/j/wAmZ4mbp0zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yLMdn0x4BTp52h3dsG4L0jYSz5pCxAL5rTmU6gq7E19bdnhh
	u1pyoqB4RkUk8NakrDQeuBnicBaAb+FbigUvD0tTciisMzV+EU8K8gFhOGsHEkXotoqIKCJ25xM
	d+XDWuisf8NbbOTOreSSrEtNN6w==
X-Received: from pga26.prod.google.com ([2002:a05:6a02:4f9a:b0:c79:8685:ebfc])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7285:b0:39f:27ab:2454 with SMTP id adf61e73a8af0-3a08d90d557mr19311506637.49.1776768418015;
 Tue, 21 Apr 2026 03:46:58 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:46:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421104652.211276-1-joonwonkang@google.com>
Subject: [PATCH] mailbox: Clarify multi-thread is not supported in blocking mode
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, sudeep.holla@kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	akpm@linux-foundation.org, Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240125-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBA6F439B8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Unlike in non-blocking mode, multi-thread has not been supported in
blocking mode. This commit is to prevent clients from having wrong
assumption by explicitly specifying this fact to the API doc.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
v1: Abandon the previous attempts to support multi-thread in blocking
  mode and instead declare it is not supported.

 drivers/mailbox/mailbox.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index bbc9fd75a95f..b00f7a32e866 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -258,6 +258,10 @@ EXPORT_SYMBOL_GPL(mbox_chan_tx_slots_available);
  * over the chan, i.e, tx_done() is made.
  * This function could be called from atomic context as it simply
  * queues the data and returns a token against the request.
+ *  In blocking mode, it is caller's responsibility to serialize threads'
+ * access to a channel if multi-threads are to send messages through the
+ * same channel, i.e. caller should not call this function until any
+ * previous call returns.
  *
  * Return: Non-negative integer for successful submission (non-blocking mode)
  *	or transmission over chan (blocking mode).
-- 
2.54.0.rc1.555.g9c883467ad-goog


