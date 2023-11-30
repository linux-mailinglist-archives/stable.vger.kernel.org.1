Return-Path: <stable+bounces-3199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1647FE787
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 04:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7623D28224D
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA584CB4C;
	Thu, 30 Nov 2023 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="PwNEgOl5"
X-Original-To: stable@vger.kernel.org
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A81A6
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 19:06:17 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E427D7A2ACB
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 03:06:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 926A47A2CB5
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 03:06:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701313576; a=rsa-sha256;
	cv=none;
	b=Xp5OHSusbnFBH8amUOGXclSavgRDwe0p9HCJ1koQuiLOJkqz+2Xkv94CqiikilvMezom7Y
	TjqpCP/NI6ylAvmvcwS0oL7/J378BRzEl1fmxuUDuaIE/0Aobia2A830eqFgndtEmDtNUC
	1qdatWWoWwggn7WO5kgPB/Hv18jA0IGOsC3hjoEoEreuGd+VcvIkmUoSbXUk3VFiqv+ujF
	czgy15T0FLD5w0JrHMX2mpYMUNhIp/kCQgkVfbQP6uDKW2o1VQSUxupB036gO4By6HyDC8
	1C29guNKB0REP3UIa2T4bnyC18QYIDl6nruWjNVBtja43hxpdMHtLxsP8oeicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701313576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ccsHIG/MaSH8K7q2Qw52sP38xj73xpiVGOXjj432OvA=;
	b=BWiOULoiWFMdANEUX4uLToH38S0xLHLHXwZMceNVVzGM9ioB+gjrytyOFNiL+nTiwjIOM5
	Yfx4QogwwZWJKs32ElqFCNjpkpkH7hPa9mQZ89DJGyCwZr5fntAxpry0GhOvy+EuZmO8tg
	ql00tHSWyRjLiLw/3PtZpt99h/U7GYaM604xJ14MAQA/Mw4JdOsO1TZVE2e8TKrVRWhIb8
	tS/kO0sH3hQl5YWDedUzcCllLWOEFryFi5Iv6QbYZnHdjqp7DF5CtfI9bVRrCIwBC4Po6H
	XVX3tkJU3s7p+1Nde1vkUCBBMJ+jpM4v/EZDYfUgEnxbEVqTd2L/IrVAZshxjg==
ARC-Authentication-Results: i=1;
	rspamd-d88d8bd54-fg62g;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Print: 0c666dac1871a783_1701313576741_3470723254
X-MC-Loop-Signature: 1701313576741:2122855724
X-MC-Ingress-Time: 1701313576741
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.7.89 (trex/6.9.2);
	Thu, 30 Nov 2023 03:06:16 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4Sgh0m281hzRV
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 19:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1701313576;
	bh=ccsHIG/MaSH8K7q2Qw52sP38xj73xpiVGOXjj432OvA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=PwNEgOl5zh8XFWTs+Bagpfl9wBNex1i+UAZUYc6oB0WTgxO6uCjuMdd4NXS9q6Lmf
	 eVgvklTw58m4auUC7sySOAYxspoYcwJFoA1V+Ihcr1xR/Zpqw55UMVKjum9YZyGYdz
	 oLRDEvo554uxL97jn+thaGcaWbtrg5NLyI1v+uAaK0IP4UkSp0sNjqyk8CscNeRM27
	 Dl180SPRHQRJbbBIqm2DNVAWlewPepnvr2my0H+mCQb7CO7FHJcEA+dM19Egff+0Xn
	 RyzOR/sqeluU/m0lVOzwx3UV/2uyu/WSirewzh0zsevaoxZGTt1mjYDlYVyZVn34KA
	 RuDBEYxpVL4sQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e009d
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Wed, 29 Nov 2023 19:05:34 -0800
Date: Wed, 29 Nov 2023 19:05:34 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: stable@vger.kernel.org
Cc: mcgrof@kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 5.15.y] proc: sysctl: prevent aliased sysctls from getting
 passed to init
Message-ID: <20231130030534.GA2067@templeofstupid.com>
References: <2023112228-racoon-mossy-ce5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112228-racoon-mossy-ce5e@gregkh>

commit 8001f49394e353f035306a45bcf504f06fca6355 upstream.

The code that checks for unknown boot options is unaware of the sysctl
alias facility, which maps bootparams to sysctl values.  If a user sets
an old value that has a valid alias, a message about an invalid
parameter will be printed during boot, and the parameter will get passed
to init.  Fix by checking for the existence of aliased parameters in the
unknown boot parameter code.  If an alias exists, don't return an error
or pass the value to init.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 0a477e1ae21b ("kernel/sysctl: support handling command line aliases")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/proc/proc_sysctl.c  | 7 +++++++
 include/linux/sysctl.h | 6 ++++++
 init/main.c            | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index caa421ba078f..4192fe6ec3da 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1780,6 +1780,13 @@ static const char *sysctl_find_alias(char *param)
 	return NULL;
 }
 
+bool sysctl_is_alias(char *param)
+{
+	const char *alias = sysctl_find_alias(param);
+
+	return alias != NULL;
+}
+
 /* Set sysctl value passed on kernel command line. */
 static int process_sysctl_arg(char *param, char *val,
 			       const char *unused, void *arg)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 47cf70c8eb93..32d79ef906e5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -210,6 +210,7 @@ extern void __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name);
 #define register_sysctl_init(path, table) __register_sysctl_init(path, table, #table)
 void do_sysctl_args(void);
+bool sysctl_is_alias(char *param);
 
 extern int pwrsw_enabled;
 extern int unaligned_enabled;
@@ -251,6 +252,11 @@ static inline void setup_sysctl_set(struct ctl_table_set *p,
 static inline void do_sysctl_args(void)
 {
 }
+
+static inline bool sysctl_is_alias(char *param)
+{
+	return false;
+}
 #endif /* CONFIG_SYSCTL */
 
 int sysctl_max_threads(struct ctl_table *table, int write, void *buffer,
diff --git a/init/main.c b/init/main.c
index 63737af8de51..5c81d7fb2fe9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -540,6 +540,10 @@ static int __init unknown_bootoption(char *param, char *val,
 {
 	size_t len = strlen(param);
 
+	/* Handle params aliased to sysctls */
+	if (sysctl_is_alias(param))
+		return 0;
+
 	repair_env_string(param, val);
 
 	/* Handle obsolete-style parameters */
-- 
2.25.1


