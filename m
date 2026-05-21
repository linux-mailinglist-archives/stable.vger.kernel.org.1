Return-Path: <stable+bounces-253554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFR1FjgPD2p7EgYAu9opvQ
	(envelope-from <stable+bounces-253554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:57:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A0E5A6896
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F533312B148
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BF3D79F0;
	Thu, 21 May 2026 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="Y8TlLJyQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52F3CA49C
	for <stable@vger.kernel.org>; Thu, 21 May 2026 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368795; cv=none; b=A3bA4cSCXCBt15IkWvf3KKj20TsInRiBt9xE+ODQF89LYNm52551SjafnKwP/Qrs4JhfbPdxkfKZs77//TzE/tvebrR+kUB3ISb39gIG31PtJUFjfeii2XPnoX81PQHSd83jFQtpREHItK0XW0EYs4S9Fd8JJ2OYbuDYP0ESi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368795; c=relaxed/simple;
	bh=nX9Vgd+V0fziR82rO9KeXEsRhY2FBkrGWRZZ9r/BIFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeKaQNqri0AHGAfUmiDvvt0vP8REuIUaGkjcUKZ2AygtKNaAwbEow0KIVlo8QYxkCPDtnauOmcH/RoBm8KWeG8uZmEBAopuTojJT0Jde9SzI6dchVHLhpFc0yPt3dsLkQQPIwS+AmjYmbr5chHs2H08PEG8NunVKeJJd1t/rQjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=Y8TlLJyQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso45464885e9.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1779368792; x=1779973592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxyMlG8EwUtEsp3NYwSblykgw5/x0TK+TVpqnBy/4gY=;
        b=Y8TlLJyQTNTUz2h459L7uUaTT9d5iDWpe+YHIgwv6FSPXjDzGEjVtIMHVgcXUkLalY
         1xc894PD0psavVGlTfDuif6VUDjVuubPxcCAw6/p3JWTe3+ohnold1ESUOrsmU3Vqa6C
         5g+i9SAR8TFgHfdAecC5m6gJiq0kcA+pcfakUOqcE94L8VkE18fJh6S6b7ELcb2YuyJu
         RBtUoaVgLTtzQwhpIfECSceICPN/zRQYbKVCJ3pp8lmhrEdz+p0CgC/N+hLqSNdU9+ox
         REnASHB01D0BGcg+dTUWtVbCc9aEZeXkLeokcK1EsafjAtyh63dJ/QPgVItpoNTDU7Jb
         WGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368792; x=1779973592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxyMlG8EwUtEsp3NYwSblykgw5/x0TK+TVpqnBy/4gY=;
        b=g96PFiYuTySvyG79mn+63Om3c4e15F4JFL6yTD+JzJQW3tvzj3Xc3k8UvwqOHlIgB5
         q91gWy7rTgTmxEu5lLzAime3f1s1O/gL7vr2Tm7uHAr/eTULVH+hJaBI//WFtvVD71Ve
         W8/3Kvxu9HjMHP2rvyZw92UfFCr30HhZWryzUR3wMaxCnu5UIRPMGj/MWFXH5A9kn6eU
         0Dvv9l2zn3ffHmpVeRDjV/etJRDE6fJj1wGDUJzrkhp0cPyFVGaNvOcTZMLN4ZqbLLTk
         9zmzblP1jt4pKM2izJn0QoxfDK+HA3lXUdhfzL3zNqZJTZQbPLmBbe+3bX27Rs+RA5IN
         4nVA==
X-Forwarded-Encrypted: i=1; AFNElJ/QSUMEkR9OK4jnrawiJRh2oGR7VICYfEP1/0EuEZtlN5/WfQYiQWx0Q0jwLSWfW6kQBRsSUCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDve3hkuHfy99bPkQaWn5dhv07b4kPJT82UQ0WwQQoNXxveTXk
	aXELSO47MOo3tAgweFSc0QWxdIoYYVRahMe5LKZ75olHQA5YyVhzUT2nJAyX35QuFaKxTAYT3EE
	qWW4Y
X-Gm-Gg: Acq92OFUNT1LbVJjTwfSUr+MQ90/bF2SaX8Pw3epydYrxz2WySMyWKtQd+uO8eGsVLa
	3F6dl6DPA/RPD1GumrMsIf27LUgXEAAy9doynOeJgAk3YkC6GZm/Sgn5iWaG/9pb18incMWnx9A
	JsM9peY9YAIYkRVn+q7JhAQuGyTo2XGDj7XEsZiS33Ohrb3AzIho1XLhgDyAehmg82nxV0cuZoS
	MoLSE+/hmL5Zf35ErKZ+q+lNZdrxfqJSq+4JvW7U6jYaiEmhLcRo6MOTx6x+VU/m8f84SNtadZv
	JbROgYo58KWqd9mb7gGFS14GXiIgrT/AJZr7NsHTx/vtIZnSHQ8Yrbts7gjO7a9nMJQlr0QFyoW
	j2F2sdaAoJ+0PMJ0Vd0dP8ykOsJq/3K4UEkOzoEKwB4u+zsCAh27Zo5QaOL61s7/SnMeGocPIQ1
	rHXFiBBX0imeDtMy7q9XSERgQVKeXY3/GxgDE=
X-Received: by 2002:a05:600c:468b:b0:490:b07:5f27 with SMTP id 5b1f17b1804b1-490360c9534mr32130495e9.24.1779368791147;
        Thu, 21 May 2026 06:06:31 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26dc::3df:8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa93cea9sm2582382f8f.35.2026.05.21.06.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:06:30 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Corey Minyard <corey@minyard.net>
Cc: Gilles BULOZ <gilles.buloz@kontron.com>,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	stable@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: Fix user refcount underflow in event delivery
Date: Thu, 21 May 2026 14:06:27 +0100
Message-ID: <20260521130628.3641050-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253554-lists,stable=lfdr.de];
	DMARC_NA(0.00)[readmodwrite.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Queue-Id: B3A0E5A6896
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matt Fleming <mfleming@cloudflare.com>

ipmi_alloc_recv_msg(user) takes the temporary user reference owned by the
receive message, and ipmi_free_recv_msg() drops it again. If event delivery
fails after allocating receive messages for earlier users,
handle_read_event_rsp() rolls those messages back with
ipmi_free_recv_msg().

That rollback path still drops user->refcount explicitly after freeing each
message. The extra put can free a user that remains linked on intf->users,
so later event delivery may dereference a freed user or trip refcount_t's
addition-on-zero warning when ipmi_alloc_recv_msg() tries to acquire
another reference.

Remove the stale explicit put and the now-dead user assignment. Keep the
list_del() and ipmi_free_recv_msg() calls; they are the required rollback
operations.

Fixes: b52da4054ee0 ("ipmi: Rework user message limit handling")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 869ac87a4b6a..52561a880e54 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4477,10 +4477,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 			mutex_unlock(&intf->users_mutex);
 			list_for_each_entry_safe(recv_msg, recv_msg2, &msgs,
 						 link) {
-				user = recv_msg->user;
 				list_del(&recv_msg->link);
 				ipmi_free_recv_msg(recv_msg);
-				kref_put(&user->refcount, free_ipmi_user);
 			}
 			/*
 			 * We couldn't allocate memory for the
-- 
2.43.0


