Return-Path: <stable+bounces-238593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bJQWE9ah42lvJQEAu9opvQ
	(envelope-from <stable+bounces-238593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 17:23:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D69421739
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 17:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 617D2302DA09
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40042E718B;
	Sat, 18 Apr 2026 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aK9wBP7G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7927F010
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776525776; cv=none; b=m3zCDIsqMuOiCw/V6X1qZRxGL0qTAZ1UQkDHSEQnk25UT1KaYxRgCnuTQe0wgTzWzfEw9D3EvK+rEXe8SxyZxcTpgQY/NGUWTn4RsXBf0WFuiKzdPYZqui2s0d1Q2rt1dXrxRH/MR2va4Lg44W81qxpoxtK8UNy1vnMIiBJusCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776525776; c=relaxed/simple;
	bh=wMIQQgxCfalY9WXiOfBb13fu+fvGlMWOcyORM73qBtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5i+TAM1zTyXB8E//LDPlku4fsGwXQZ9low0M+WoMpkCJdMpGbNKAvfk2/dOEDGVnZm8tuuw5IL/3ua77R+js911R4Cz0nHAyoLEYZE18Cs0N8WDy8dqtzDPVBT8GqHycrZGxTtu/4aGXXdcqZgoXxuTD3z45bOaHLIj7lIEzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aK9wBP7G; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so11979665e9.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776525774; x=1777130574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMsRufTR+ikJPYI8IiM5SL7gmmFmr9I36g89RZG6mjs=;
        b=aK9wBP7GbP39FZzCQ9ZeYziaYq3r01bqVRsidr4WpSV/MQruSSQyUl2lhO7ZEkUIT6
         A0wjlyslNLy7QN72YY24/gQ6CDGSWwfn32/mN1FNJm9DWvUQkPplaReRztPwcslQTyRb
         4NDzX9m0ioBFC31n62aJJ/oa4tQ6BUoN5jiT7URznaXn2LQoeknQmNiWvPqWVv0z842K
         r0JQk9FAbiEZNNzFdYgnszdswPInWIqlck2RNUh6WMTLq4TSGxg76Chmq3eNWdbJ8vPF
         GKFoNwZ8QoqINt6lx8BsvaTxfAnVB1Jy8xY9ge3fu7MX8KGZ6ygML+sqMyFMo9io5r8T
         5zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776525774; x=1777130574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMsRufTR+ikJPYI8IiM5SL7gmmFmr9I36g89RZG6mjs=;
        b=NZlwe7TDsyoi3cNipVzYR3jwrtDGXntFAP7BezTzuycvyuQRQnBsDO/3px5dg9kwey
         KYM1C163Y3ezgGXbsGv5OkRkhoz2V13h+flboUv4v0lCezUVxRMlY0fu8+sD8Hy08B3/
         MpOhdbmTUHk4oFOIpnQHMAmjvFUlIBDwf9vZUlxkq+LhIxymYcyBMiofWlCwrNKFFPXf
         I/0c10Hak+AevxdvUB3IrUx8UOYoH2lCVPTlTeabB10fzEprQfvfFM3UvGfsWwNqZfY+
         HiAIns2HHr/CsnHJhJ9adgsh5tEv6rdCvBgyWjMji0gZYmuyR1b6JGgmbivafExVa0ga
         ndxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ekxr3JAwU/AmigtPv7rJjT55iL7O45EbyI7Fch5arnOQ95I1KmuAcgsPS+cRlppag1kLX9ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz6jGNFbVQ9sPB8jhXZjexIfEJNO4RN7yhPs2C/MdHzcY9yWBo
	FITfpH/AyPF9/2vkiIcWHfQeLJohSo/n9nk1113sk0T/BxB7HRw+EBm0
X-Gm-Gg: AeBDietYz3GS42ZHQ8i3+3T7d1g4zldSysbyeo3YvQ8Wv1DibZJLHCFDLI62Rk/7KEP
	tWB0vlnRDw/cPvCQMhoHVBQ9jefuBCuBLpAZuZZjYqEqVvSTiLJ8jkUXvzP3BDhpYP0VL7LON/C
	I6TSQFh5JcdQ9Tnkbgra3QND2lFHK89gqixOhxI4RPEtk7N9p4CsejZp+4dKhVlFLRrkOZYowr4
	f9H2ry6SllfEPWVcdJ1TDoIOt04RSpd8Ju/4EZxbmi3exD+3OSucm9sY2mX7zCwInL/Tru4kEQ2
	32V4+3TNncE1AgyUCxzdEed13KfTlqr7ur+52KuQAKSC5vcf8iGuiawAoFTVJgGiWGSCsdCzzX8
	VkFXycc7pMf8xRs+/7hO8QG4fawLDGW7XhpS+IiFLcRDF+TNbOapiOTJJNQ1zd836B3nbOGRvRX
	1FxVhdOv3cVy3bOR5ETX5A2RjEnYkGTCHFZDVFtVrKbv/QNe8E3ozamzO7nL5P9UspG/YxCy+Rs
	ACQ3GX++uxRV1wuPk1X9Q==
X-Received: by 2002:a05:600c:628b:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-488fb8afffcmr97497815e9.9.1776525773621;
        Sat, 18 Apr 2026 08:22:53 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc143a0fsm144564165e9.14.2026.04.18.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 08:22:53 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] eventfs: Use list_add_tail_rcu() for SRCU-protected children list
Date: Sat, 18 Apr 2026 16:22:50 +0100
Message-ID: <20260418152251.199343-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	FREEMAIL_CC(0.00)[efficios.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238593-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76D69421739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit d2603279c7d6 ("eventfs: Use list_del_rcu() for SRCU protected
list variable") converted the removal side to pair with the
list_for_each_entry_srcu() walker in eventfs_iterate(). The insertion
in eventfs_create_dir() was left as a plain list_add_tail(), which on
weakly-ordered architectures can expose a new entry to the SRCU reader
before its list pointers and fields are observable.

Use list_add_tail_rcu() so the publication pairs with the existing
list_del_rcu() and list_for_each_entry_srcu().

Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 81df94038f2e..8dd554508828 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -706,7 +706,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 
 	scoped_guard(mutex, &eventfs_mutex) {
 		if (!parent->is_freed)
-			list_add_tail(&ei->list, &parent->children);
+			list_add_tail_rcu(&ei->list, &parent->children);
 	}
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
-- 
2.53.0


