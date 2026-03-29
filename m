Return-Path: <stable+bounces-230968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFJUKXNzyWmcyAUAu9opvQ
	(envelope-from <stable+bounces-230968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 20:46:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08165353A39
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 20:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B7873015E1E
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E5B219EB;
	Sun, 29 Mar 2026 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3vP/eeu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911302C0260
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774809968; cv=none; b=bWT0t9DQpfpP5k68gnTN2vdq8KtDVHgPS43/o+q0J1oPQ3MRPyVtD54h7BvA4X+mmO6p0Ampbb1zhb9mqdCRBZjzUmeLZQR0ZZaI4zymhP47uJRKpXen8L9CZj94mUcH2da9QOouL6v9mHegDbi3xmcMfIC/q8k6ESmWmsN1z/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774809968; c=relaxed/simple;
	bh=XQCPzJhZ2kxsvNzsyz7iOaWsSty5HK6uks1lpyfPqJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXCLRAJYxfa7HtbPOOvhpt4b9ZelliVom6RwNo+aCffe+yB8UsIJEb/PkYbjqYyPDDQ8rq6aDRHA7hddGg+fziED/0wQOo91e/XzhYpPgdNGFZIBiD/pLzkAJfOLFwUc2lIx27rVGZEtnWCTjQha9f0ZfM6Rp8T+INVmsJXmRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3vP/eeu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0afa0210bso18737295ad.2
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774809967; x=1775414767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gnh0uYoTrakzMqa8ayVORbXmnsfDVgazJoZT9TbWcI=;
        b=g3vP/eeu7ifoe8w2UpCHFalfnjvJxA0J0ymXKydZc/LEN/AlWSy70A4nvGRNmycY0+
         mP76XqaBspmwogjQB7GvC8IvSHwX8YCuilTo+VUAnHaQSieIf5mOAmYkbk+qHXrJzaqt
         /3TTUhUZ1tYwmshR2QzjoJFJRX6t+ylSqBSWkS9O8Qii9Jw51XOa7F6sH5wFYsxfJ710
         FF5ZjprAOW20A8Q/VTk4/EReBVRIg/t/9FqHODUIcDIyP9YjdBgq82HSczqzc4nkEKrT
         A7M8UYl9wWVUvUzTUtE16FoYsnnT9IJYQhTgrsBFsddiybWbC1d5vMVF7mRY8deeCnba
         baGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774809967; x=1775414767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/gnh0uYoTrakzMqa8ayVORbXmnsfDVgazJoZT9TbWcI=;
        b=ZVBygLFKJYoij8WlQWHDC8PePYU8Q43odQXIWnLcG++g9g20f30TQd9FvKlixTKpfw
         8nDpjpNiLn8o2mvEiIrw9UPg3iba/KpkaJNeRR3WH4YYycf1FQULUkVX6+fenrEKxCRY
         NBMFv7Q/Yebff4961O/PTytJB/Bp0SHpmn92QPGT9AP0HKWIorFl1DVNt4odktBIpAZK
         CzaYihmxwaclviIRtszFPBzEOvxa1FzecsKcYtzwXuMyrsjXVuuVVbsiMu9su8zzpWUT
         4HEBO3bBhMENBRKq/QQLbxmC7FpUA+jUrfhZpJaGEkMrWAYkBwW2VwQuHfymG0j2OI2y
         5Aeg==
X-Gm-Message-State: AOJu0YwjFpBr7lU/a81I1uBMYt5Kr95zc0LEw8Y2heoGACCq4iMKIEFd
	aZDEjqsOUhv84YnQXw7KCqeQ/MidEmHD8FnTtrMk0rIOCNkkU3pd70ap/w7nETgMizQ=
X-Gm-Gg: ATEYQzy2acnkktN5Fw9WbBsnDTjGmcfO3Nr+B70gPn6ORLr2SkP3I9rQfrBIhu/Yu0x
	4/oJRNlP3GaBhPHCThdiXZ8RAbztPS/d5WCMeItonNcoV3LfCXeuWyeH6jrZhZz+/c5GZFdtzMP
	4z8xVRYoWOoYr3ZEdwa7u33YwwAF5wH6iYYW4kuj3yks/YT2nGw+hjFcPyNboof9sLuar+xYHhY
	wMrwcliAg4cQ28aK+JjYl83ePGH+3T8DJJJnGj89ESeZq1LpfME3qL1/y7/vrUbofsxDxHGsT3f
	cJCZc+8wywNezOqagudaWDm5Nfb8trd2v9sHwQNyizeTMkMENBo/St7WvtM5zpQw/7QwN8/edY9
	mQ+Gwk7o+Am09u28Oe9iYuG+s4DiOXT01h+2+Im2u1o2Z3R4hXy6NBKEqwQo4LLpJiO48KIx+1s
	GEZpXfGB61IaDjcs9hBq+brLWK
X-Received: by 2002:a17:903:32c5:b0:2b2:45b7:307f with SMTP id d9443c01a7336-2b245b73c3emr53938905ad.9.1774809966770;
        Sun, 29 Mar 2026 11:46:06 -0700 (PDT)
Received: from ubuntu24.. ([240e:47e:3870:786a:c44d:f04a:d78b:4017])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642b43sm69630355ad.9.2026.03.29.11.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 11:46:06 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: cyyzero16@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] taskstats: set version in TGID exit notifications
Date: Mon, 30 Mar 2026 02:45:53 +0800
Message-ID: <ba83d934e59edd431b693607de573eb9ca059309.1774806788.git.cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1774806788.git.cyyzero16@gmail.com>
References: <cover.1774806788.git.cyyzero16@gmail.com>
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
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-230968-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cyyzero16@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08165353A39
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


