Return-Path: <stable+bounces-255061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKDgBDZwGGoSkAgAu9opvQ
	(envelope-from <stable+bounces-255061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:41:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B55F5200
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AB6131C58B8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465C53F39CE;
	Thu, 28 May 2026 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngt0zBZV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC593F0AB3
	for <stable@vger.kernel.org>; Thu, 28 May 2026 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984531; cv=none; b=a+u7GZN4wLPa/wsPb053gfPzZRVnnGydKOcGkBoGtR4OKsQUm+0BnPbhythdnVQWOLabBOGQNz6pwriMLoEO0d+wgBrVl6amAasaLetA7DHi4d5XV9UdchVC2FV3WopXwWZIYChgKmutdDECwBJ753KGVc4sP4b+OB8sknD36kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984531; c=relaxed/simple;
	bh=ArFEvS4iIE1COp0yWeMQ913sIk1iOU6y5FWc4jgQSiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkeAvpKyIMyssZElvL+VrqyCN9MelsI6g4gOpxOFq9jj8jhZDhWh6NxZU+waJtSjlcOpsHAmtQFzQ7H6i4/jf62aaRFB6gvcOtpO/TfR5WflphkdxxKChr9cDoaLVIYAXL8VXQkEX3/xjXPY4YGcs9Z+5cVG38wieG6gGCNeQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngt0zBZV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eedc94d37so281220f8f.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779984527; x=1780589327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vx53jYFxFDkAaLXRXoaHF+KJ6Qv4XL53bOT7CIR8w+k=;
        b=Ngt0zBZVdrv9VisRHKAKEEYXzwa2DNKEprnFQ/4lSjytKPMaWTWAdd/81jdBsGFHIN
         fC9zY4DJLTPs4Ndv97boyWNpGKH+JpvHCRE3XTgsFFjVtiLO0HPUvLMA76TWnV08lxc3
         3w2XbN1ww4l0xZXXr/8KHN4MPdzbDyync+wc9RPixnWJ1AX5UpZXAM1BRukQYfCKLjGR
         pWkgnR5ksnby8EwqFTNiWoNWDqQmKj9inGdjIViJ7MaRL3aKK9DJxXNyMjSgGVlb+0eX
         tGsChi+BOajyjx4HemewYkfEupCGxfJ5GM01hZIWFRcX1otZTyA+EBuuadGQvwSPN0yb
         RWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984527; x=1780589327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vx53jYFxFDkAaLXRXoaHF+KJ6Qv4XL53bOT7CIR8w+k=;
        b=qUdr7UsUWsTUVkFUgHXfiDCy3bXHqdRDMEBk7e80Rc/fB8CV/0LmiTcJZFtF3vEWUI
         qaAOqWquGYoKhnDQefUO8F5kp2/YlELg3xdTCCja3Z8QUaFz1QswJN0fZw1lhoMFRKTx
         Cjgr60gsz0Zb4WBntFiWCOB1GccqWLDH3S31EQW+cV65gNL8oGWlMWVgDG1so8+AfMJA
         yq2sH4/FuzGnZMQ43bdmJz7dBavMmxXAKPUY0DcnlNy5S97FU983w65ArF034u4RDRn+
         HbXjYco52TFkSWGaPDbLelJZEgVEP9Lg5bnGV5R8306sQlMn7+ky5AUU2gwe2M8ayC/q
         xIeA==
X-Forwarded-Encrypted: i=1; AFNElJ8cvVa7tpU4QZnAaeDCrovyoe2entJNypuJzFDm67fG3W43So8ZsTm/FjzOd7miZv2Sktco1eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztHYVyAmJsh1TbNWQm3iGeDXdqA+cqz0thvqnHIaIHSaXle4mm
	V4uR0g6sxbFZ3DDNWmLVCHdD2AajPpe1374p4G5yF+fq3Umr969orw4=
X-Gm-Gg: Acq92OFOdPYfFicnZLxTAfPJvFD30noTfxZAZppkfqgJZht/bi/hd3QmAjdmHmOhgDL
	tc9usjoBwznL5wDw1CI8UNeFw2Tu9tyxelCkWGLaCk7dr9EE0Avt/UZ+1/mA50I0N+AgwNkMozw
	xVp7bPcMrzdyMR8eIrXLUAJiV0IpLgKwHDmZ94J5D2WhvmMST/EjhM5BtrbsjjDXjgEnBrDzira
	GGygS3pEsT48lhlmHGo/p1idjKsoK3rKGFUeIgr9wycds4oEC1C3lwgDaGT0LVpJx7ey8siA+OU
	ud7vButvSL+omQU4Llxq6+LcWbGa32zgTQaw8sQm7uWn820q3wJ33jVLcSz5FzdnrJqtr46o5tF
	CakQ5qxLZAr1gGdSy6lvzTCt2fR1qMkK1RPgyxV2eaRABxrS5h4aouBqBIf4MKtU3ywr3lPtBWG
	w/Wj1Gootg5kmurqQt
X-Received: by 2002:a05:600c:a012:b0:490:5191:6e26 with SMTP id 5b1f17b1804b1-490519170bamr421905655e9.18.1779984527176;
        Thu, 28 May 2026 09:08:47 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee4491d77sm6950094f8f.4.2026.05.28.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:08:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: shaper: use kfree_rcu() in net_shaper_flush()
Date: Thu, 28 May 2026 16:08:45 +0000
Message-ID: <20260528160845.2636043-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255061-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AB1B55F5200
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net_shaper_flush() frees shaper objects with plain kfree() after
xa_erase(), but net_shaper_nl_get_doit() and net_shaper_nl_get_dumpit()
read shaper objects under rcu_read_lock() via xa_load().  This creates a
use-after-free window where an RCU reader may still hold a pointer to a
shaper object that has been freed.

The race is:

  CPU 0 (reader)                    CPU 1 (flush/unregister)
  rcu_read_lock()
  shaper = xa_load(...)             xa_lock()
  // shaper points to valid obj     __xa_erase(...)
                                    kfree(shaper)  <- frees immediately
  net_shaper_fill_one(shaper)       xa_unlock()
  // use-after-free
  rcu_read_unlock()

Other code paths in the same file already use kfree_rcu() correctly
(net_shaper_pre_insert error path, net_shaper_notify_down,
net_shaper_cap_pair_update, and net_shaper_rollback as of commit
b8d7519352ba).  The struct net_shaper already contains an rcu_head field.

Fix by replacing kfree() with kfree_rcu() in net_shaper_flush() to
defer freeing until after the RCU grace period.

Found by source code audit.

Fixes: ff7d4deb1f3e ("net-shapers: implement shaper cleanup on queue deletion")
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/shaper/shaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index dea9270f3e57d..92a6939787240 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -1475,7 +1475,7 @@ static void net_shaper_flush(struct net_shaper_binding *binding)
 	xa_lock(&hierarchy->shapers);
 	xa_for_each(&hierarchy->shapers, index, cur) {
 		__xa_erase(&hierarchy->shapers, index);
-		kfree(cur);
+		kfree_rcu(cur, rcu);
 	}
 	xa_unlock(&hierarchy->shapers);
 
-- 
2.47.3


