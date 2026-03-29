Return-Path: <stable+bounces-230969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL1oLVB3yWntyAUAu9opvQ
	(envelope-from <stable+bounces-230969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 21:02:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9368353B4F
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9B71301AF62
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B938644E;
	Sun, 29 Mar 2026 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atOremrL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24231C862F
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 19:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810854; cv=none; b=d+ipyxCN6UMOKZUMkpOE+r12QLOsQqgO0yU8Owj1CsDPKsiooD6hKoxbiBMDNSXlQ/FhE9rqTtGspAB+wmz6Tb6Y3MxYxaGnPIjej5N7bet4RkjnoV2eyqotVELib82vgMZAOXKeMG5ig4zREAgCOH9BTuzWGtVu5be4tXi8ODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810854; c=relaxed/simple;
	bh=XQCPzJhZ2kxsvNzsyz7iOaWsSty5HK6uks1lpyfPqJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6LFWTyXvHBFTHJS6BLqWFYtDc2MSyKWwCi+5YnnjOOlhbN9HTFbJJWaOrnvbJzIkbciX2LDji6TQjHRM3c4jScLVDgUeM3EzFIuUTeaU9KtxvxAdKdD1X7wwjAd49wfV9g74cKOggMu26H1tGv7uZXWrfGengIXhVGI3f+7e3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atOremrL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so3514131a91.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 12:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774810853; x=1775415653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gnh0uYoTrakzMqa8ayVORbXmnsfDVgazJoZT9TbWcI=;
        b=atOremrLMeK0mAjYLR3nrtprFY0wOrF+VQJI6VF9lBDEGbrVDJafD6GivNwlHCoSEg
         0GdmnzKtbRfyOxSjB2T/ozjioynck3iA8oozN2LkMm1Q+VRDf4U2ZHcPXI1/oCdRm4Q0
         +g1ZO8wlLfwnyGy0LH44e3Qw2cl5ooidCOcwinyQfkmujK1S7a2BvsMK9ljpLs11JhHS
         nInwGkByBEsL+S/KUkunZepxddUl/UHENfKUUS1xeEVTWH6SIecXXwZ0rs7PourA3t9S
         6lUkjh19/lPwWMYdO+TgAhtT+B2mPySv7vpMkDpVEFPRB7Sm8kI18oAQXWkMgzL2hTGY
         gBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774810853; x=1775415653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gnh0uYoTrakzMqa8ayVORbXmnsfDVgazJoZT9TbWcI=;
        b=n59+evJZfxmPZFeHkbumT7y2BATrZ0HFEtceHY1W4r2aIbDxQ6lRm8oQWjOaef7A9M
         DISU0u1UUTbNZujMGwDOef/xgqd0a3JXorib7PMat+UEe1mYJ/TmU5/Ol+pQTjVYizxD
         c9wOR7mMRVrKbcLN+D4P6LFbqfQtKOKqnUaGNMDsx3qV8xZff/JAu6aJ5B/aJCm2C5b8
         u3NkfELEIdUFIrS36vhctyqvMZzQwm2ac6cqtl8V8hQ55VOuAbqIfdiDnDpQ4DLx791S
         plIJAtat7PVWpUaWzx4hOw9Beku6l9SO5RIDG8wkabA7BfcrbVv+IKZzbzb3MeVZkFhE
         Qotg==
X-Forwarded-Encrypted: i=1; AJvYcCUxSD+QroKZWNQCFxL0QPu26om+4Ovwtn+4q6a21OEPLaw25Hbykl7ztr32RQ/dVDSx61hCyR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRy79Rev+AzK/arKD8EUaPEndn6hKSs8Nr1fw43I0ezbkuKihz
	TX7Mq1KCyO6WQxZ0ZoycCayJ7yK+eNOGDsZeHxx73AR+vTgb76dPS7ik
X-Gm-Gg: ATEYQzwqOs1E61u/1n72Al+9zV6A4cIw9UdpSr1HGytdsa/LnvG2mZI05kNxJjAC0FF
	F9oyr6VDRoxyDB4+EpZydw/pup0xDZL+bQVgqgSCCrvFxLGElLV+K7NPVeAi0aRT7RyZb0pBM8x
	vRGEjmIEs3tp37MzoQ4rR5iAVhh39DTmW8IMpT2hS+AxkHC+TzaQjultYNJ4C1OI5RvrcDgDtgI
	atUbXMo0gGBzBXWDvvh0WV0WVvSW1J9OaM5OwmiJ8IkVJ7KJpcBYyhYFOQP3Pe5oAu7WqcX79X7
	/YAVafzwowMOR5z6xRcQFJCsRX1uAJPbDrQN5xoxSZDjy2R5aLF1n/N9C3sEjAfAmbA7kgzTXi2
	21FJyelHW3JyG/Dy7Y4Ev0rEdQb4OoKM8rS6QiY7+UMraL7PRCT/+zkST9R+OdqEoUPv6YDi6sh
	bISPX6U7jD90qtpYVdXVuhJ/lc
X-Received: by 2002:a17:903:228e:b0:2b0:5453:1932 with SMTP id d9443c01a7336-2b0cdc263c6mr106483985ad.15.1774810853211;
        Sun, 29 Mar 2026 12:00:53 -0700 (PDT)
Received: from ubuntu24.. ([240e:47e:3870:786a:45b9:eb23:e7cd:d2fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242676e13sm57685335ad.28.2026.03.29.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 12:00:52 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Wang Yaxin <wang.yaxin@zte.com.cn>,
	Fan Yu <fan.yu9@zte.com.cn>,
	"Dr . Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Yiyang Chen <cyyzero16@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] taskstats: set version in TGID exit notifications
Date: Mon, 30 Mar 2026 03:00:40 +0800
Message-ID: <ba83d934e59edd431b693607de573eb9ca059309.1774810498.git.cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1774810498.git.cyyzero16@gmail.com>
References: <cover.1774810498.git.cyyzero16@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,zte.com.cn,uni-hamburg.de,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230969-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyyzero16@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9368353B4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

delay accounting started populating taskstats records with a valid
version field via fill_pid() and fill_tgid().

Later, commit ad4ecbcba728 ("[PATCH] delay accounting taskstats
interface send tgid once") changed the TGID exit path to send the
cached signal->stats aggregate directly instead of building the outgoing
record through fill_tgid(). Unlike fill_tgid(), fill_tgid_exit() only
accumulates accounting data and never initializes stats->version.

As a result, TGID exit notifications can reach userspace with
version == 0 even though PID exit notifications and
TASKSTATS_CMD_GET replies carry a valid taskstats version.

Set stats->version = TASKSTATS_VERSION after copying the cached TGID
aggregate into the outgoing netlink payload so all taskstats records are
self-describing again.

Fixes: ad4ecbcba728 ("[PATCH] delay accounting taskstats interface send tgid once")
Cc: stable@vger.kernel.org
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
---
 kernel/taskstats.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 0cd680ccc7e5..73bd6a6a7893 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -649,6 +649,7 @@ void taskstats_exit(struct task_struct *tsk, int group_dead)
 		goto err;
 
 	memcpy(stats, tsk->signal->stats, sizeof(*stats));
+	stats->version = TASKSTATS_VERSION;
 
 send:
 	send_cpu_listeners(rep_skb, listeners);
-- 
2.43.0


