Return-Path: <stable+bounces-232982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHi/FvZPzmmjmgYAu9opvQ
	(envelope-from <stable+bounces-232982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:16:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE038831A
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 13:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40D633089A05
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CFC3AD538;
	Thu,  2 Apr 2026 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0+qgjpy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330A3BD647
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128424; cv=none; b=RpttoxUCQFO+w3KZ9CBV5uNTAI2TMulPkW4mf4t7/sY5uzaLmVj9bGh1JP0iJ6S0DzzA28We9quJsMTpOqg+2vw1kaqiiEPiPHQEayZtfUqhVVaN4bIQbSBdD6MRx2zRQrGxGcH4ObATkffbtvuYm/Lxo18DVFCy3UmZfrD3G0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128424; c=relaxed/simple;
	bh=M3qc+I0F4GxcD+gA9/TwfMiwtyU/hxqmGiXMVLoB57E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOAqaeocntm9RQh9Tnw5O3MrihZXQkWrE2RbYCFdGumvup5MeVc6RIhxv3prdGrdlL2KuoVnfRTOetYR0L1oxstDFNhaxWYYPe8CxxiXkLCT90TujXq0O8jJA5RkuzDRgJO1zKyIn30kggMOTcKRKWzYta8pzS8RaFLiUGDgKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0+qgjpy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso277703a12.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775128422; x=1775733222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=52SFoVGW63tsAPzIixeFMpTy1AONlrZUgj2OkRsGPn8=;
        b=m0+qgjpyrhJBtn2aI/eEA+e1kTWd4weyd9m3IShAtZe4hxXD8JTXbyjutVumaV9rVw
         HDm8521aX+wNkkW5ndORp/igTwPG8Pr2C0t9FLVPSZHgF0iM9ncTzW/J9mq76SYYMEOr
         +Sw/VQUeAqP9dTbgXdMYrELLhooHlELKkZDjLZz2OJgXgwnUsYL9vbBIRrQSe5ygiDzG
         QVaLpPoCuDdDhgn3jqeNnPDWsP5BfPwYJSriBPuxB8rQ0PvNoFORnyXU8aJYWaNkM8lc
         lXQJ8j/xzE7Y739gvVdkCpiXH4NDKKEZE7oPpnySEZsqS6ytV4H/PW3lw4XBXSJ4oHip
         Eing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775128422; x=1775733222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52SFoVGW63tsAPzIixeFMpTy1AONlrZUgj2OkRsGPn8=;
        b=TjDjB9PdI0P+Sgml3LMTmkOGhv4QXDS+brA068AYg6PF2ZeXfT/Gok9MHy1y401hDI
         nS/cleXAjcBPRy0EuINquI28WwiAPGyC99t5drdAYQEIUi80mzaz+PtQqLQazUGnAzCC
         KKhVPNyTWOs7gL+Q+uia7lknO8TX9Xm4GAoe611OW+CyOL20mJuIwiBT0dZ0UTDb794O
         Qb8t0Uc86UEkGhFAoTrWsgrgFpaCPPQGzjqwytt4GVBUHMYllQEX6hhh8C6XJVX1HZw2
         Z9EuVuGbWvtb4RPDzizzsWkO0pV0HTFgsIVD++1f8SAaGVLue9G3OF1pjS5mQqOeOwHR
         RfRw==
X-Forwarded-Encrypted: i=1; AJvYcCX45apcHnyVfZWCTUb1zuXX8jPY2xUX7pVaMeQe6z6KuAlWmXddBPB3gLjVN2/JaQ9AYVmOjlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZKID3TOR8bsXtN8xjxfTSpfL8CiHx6FB3LUFj1PJmvMXzu+U
	Pu8hcNQbl4RyBEEtDMCmKx3vRMlVS2jmGvURh/6MmNEkL0w44p29JXIp
X-Gm-Gg: AeBDiesCa1AKhN25Mw1YzPTVOfEZ/4KlxZJNF47157gXuZSbmucQPcl0lG0h/hlMBrV
	l8RNUYFkpUsXIT7Y9G4HfLnaIPcC0hFWuQFvqSRIUfPy0tl0zWry1N3N4PpBaB83o+g8/iIh5X5
	zqhoSzbQsWYaZfTNz62/w1BoDfjVfSNE7DGsC3xeY8jSNLBBP6aOiKi9gRcfEC0Xl1masMcnlWn
	aG2O4MbQN7ZEsVnxjZLITVewIzk4CJ8qpbASZV98/59xEOZ+y38cgY3J+Fe56R5v9EM0SWfF8NV
	Xr7HJ0fE0zQ3o2XopxpQpHKkG6xoZM1YpJxa2YUJlCdw28LeNnPEKiKwuYrynJgPp31utxjBXz8
	6qOY5c/a5PNIh9uRtUegDKhM2HtDrcsOdnd4Lnu1WMt+3G7Brr8mw+XtzBCXq4qJ731ImUhcoKM
	owXrlRwTxTfgMX8U2br7fhXEAPsuEFW92WW+gu7YVIev5iXA==
X-Received: by 2002:a17:903:2acb:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b269cee743mr73394715ad.43.1775128422073;
        Thu, 02 Apr 2026 04:13:42 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497c0f3sm27090325ad.41.2026.04.02.04.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 04:13:41 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH] prctl: require checkpoint_restore_ns_capable for PR_SET_MM_MAP
Date: Thu,  2 Apr 2026 19:13:32 +0800
Message-ID: <20260402111332.55957-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[openvz.org,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-232982-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFCE038831A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

prctl_set_mm_map() allows modifying all mm_struct boundaries and
the saved auxv vector.  The individual field path (PR_SET_MM_START_CODE
etc.) correctly requires CAP_SYS_RESOURCE, but the PR_SET_MM_MAP path
dispatches before this check and has no capability requirement of its
own when exe_fd is -1.

This means any unprivileged user on a CONFIG_CHECKPOINT_RESTORE kernel
(nearly all distros) can rewrite mm boundaries including start_brk, brk,
arg_start/end, env_start/end and saved_auxv.  Consequences include:

  - SELinux PROCESS__EXECHEAP bypass via start_brk manipulation
  - procfs info disclosure by pointing arg/env ranges at other memory
  - auxv poisoning (AT_SYSINFO_EHDR, AT_BASE, AT_ENTRY)

The original commit f606b77f1a9e ("prctl: PR_SET_MM -- introduce
PR_SET_MM_MAP operation") states "we require the caller to be at least
user-namespace root user", but this was never enforced in the code.

Add a checkpoint_restore_ns_capable() check at the top of
prctl_set_mm_map(), after the PR_SET_MM_MAP_SIZE early return.  This
requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN in the caller's
user namespace, matching the stated design intent and the existing
check for exe_fd changes.

Fixes: f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
Cc: stable@vger.kernel.org
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 kernel/sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index c86eba9aa7e9..2b8c57f23a35 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2071,6 +2071,9 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
 		return put_user((unsigned int)sizeof(prctl_map),
 				(unsigned int __user *)addr);
 
+	if (!checkpoint_restore_ns_capable(current_user_ns()))
+		return -EPERM;
+
 	if (data_size != sizeof(prctl_map))
 		return -EINVAL;
 
-- 
2.43.0


