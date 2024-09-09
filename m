Return-Path: <stable+bounces-74096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE71972599
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 01:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F581C2349C
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87D18DF61;
	Mon,  9 Sep 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKZ3/aPJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEC8F5A
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923459; cv=none; b=uboWyGklk1knlc+CQhEjTwjQiew8c7hdY8RF4B9fhqCGL5OAjGCadbRSKLr2uN738BtMI4Va+kvXayEhbfwlnnfYfrihdbvEFtWAFo5Um1qb9loOp7pzyCa2tv752TGN7cyz8mLAN/bdjsLXJmRI7V2uOQIYz6273sSJhGzpyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923459; c=relaxed/simple;
	bh=oIJ+rL9mrzFg4nGv/QDKfFNqVzSKCzfZHCECytF9GaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtlZUMUzkorc44Vup/BmR09+mh+JJNrT+SCwNM2CmimpTDigOEHx4rUWvzMSWMoth/1CEVbDirNDVOzfJX1G4mXOM7VqnSOdn//uwdbUfEqhvz20oB1s6xWSJUSs8h2S5lw9ygaxf8ho9XVlyqrhtiZGA+AsdDgwDi0RL0Rec3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKZ3/aPJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-205909af9b5so38046845ad.3
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 16:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725923457; x=1726528257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HZh2alFMXDh+0I/PORIOhnSxg+pPIbp0SXWJnUsPdc8=;
        b=dKZ3/aPJXZwtJzWP81XMv7DqcmuX/AtHE3unEJqebD8Udq+++xwB1bRKw47irZp0Ti
         1U6cy707YyykpWF3zVzzz4puMyjZedxFVqyP69i/1Iw8JGo+tEcauaXAwdTC+mRLdvyo
         qyajQknXqCjEJJG+o+K803JRNZhTw9B2iEIgMjDTpjiz+P7FOZY/xQFB400ke+xxrWgk
         XcXLND/cTOC5TrJRrvuBd6IhB2uu5V3F9JzrLbdjIlQFK5tH7ORfDsTGbzSxoP1XSKmG
         RFbHyT7xwjoabCtEDx/IksaxgjwFEzTB2dpTmkcnrO/UD/ND5Yud0nurYazpU20yqw/L
         h1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725923457; x=1726528257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZh2alFMXDh+0I/PORIOhnSxg+pPIbp0SXWJnUsPdc8=;
        b=npVNkJ/qn55Eef5MgMu3rjt6UMWaMZ/WUrGbpBH9jsrEjSURdE/IRjgAWb+EdziVjo
         Zkm0rGkRvqFDDB5bvAv+RsGgd3dlSSeFec/RkaQzgFdg3D/2wgc0+W3KoW7tc8lBkZhk
         EQEfMv/EDtKaR1LtS/bBDTtX9nwxo7/Z6xQqz+esbrQ/mYcIX7xdILlmXPkh63MeW6La
         FJKqg7JtN5maig9a0VtiJ6Upld7Op/hSEBEvsgSJRTaX1CBebokvNIUbOSpDVjfIdl9E
         01z5fjXC9cPm824wmtR7CtlkWte/BzyQFx4vfY3llRDuRhl90NYW2oOhiiWM68N6+Kx0
         azng==
X-Gm-Message-State: AOJu0Yy51jz8z2xVSBRjNumv4unBaJ2EjkyWDPTAvC75XTC4oxxb3R2Q
	E2JFVo4atACnlHBZIlTR3Qlu3p4vxS9AqjPG8dWI1CilyBEy3yhe+jvg+jna
X-Google-Smtp-Source: AGHT+IESr7aqaFYafXyI6JKtm7pyBKvfYvTxTuZZEkVIJRvwKK2UAxFj9kISZL43m5zUfDG0cGmFJg==
X-Received: by 2002:a17:902:eccf:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-206f05faedcmr185190525ad.56.1725923456398;
        Mon, 09 Sep 2024 16:10:56 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d825ba5bcesm3776085a12.90.2024.09.09.16.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 16:10:55 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	syzbot+958967f249155967d42a@syzkaller.appspotmail.com,
	Yonghong Song <yhs@fb.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Diogo Jahchan Koike <djahchankoike@gmail.com>
Subject: [PATCH 6.1.y] bpf: Silence a warning in btf_type_id_size()
Date: Mon,  9 Sep 2024 20:09:58 -0300
Message-ID: <20240909231017.340597-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yhs@fb.com>

commit e6c2f594ed961273479505b42040782820190305 upstream.

syzbot reported a warning in [1] with the following stacktrace:
  WARNING: CPU: 0 PID: 5005 at kernel/bpf/btf.c:1988 btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
  ...
  RIP: 0010:btf_type_id_size+0x2d9/0x9d0 kernel/bpf/btf.c:1988
  ...
  Call Trace:
   <TASK>
   map_check_btf kernel/bpf/syscall.c:1024 [inline]
   map_create+0x1157/0x1860 kernel/bpf/syscall.c:1198
   __sys_bpf+0x127f/0x5420 kernel/bpf/syscall.c:5040
   __do_sys_bpf kernel/bpf/syscall.c:5162 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5160 [inline]
   __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5160
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

With the following btf
  [1] DECL_TAG 'a' type_id=4 component_idx=-1
  [2] PTR '(anon)' type_id=0
  [3] TYPE_TAG 'a' type_id=2
  [4] VAR 'a' type_id=3, linkage=static
and when the bpf_attr.btf_key_type_id = 1 (DECL_TAG),
the following WARN_ON_ONCE in btf_type_id_size() is triggered:
  if (WARN_ON_ONCE(!btf_type_is_modifier(size_type) &&
                   !btf_type_is_var(size_type)))
          return NULL;

Note that 'return NULL' is the correct behavior as we don't want
a DECL_TAG type to be used as a btf_{key,value}_type_id even
for the case like 'DECL_TAG -> STRUCT'. So there
is no correctness issue here, we just want to silence warning.

To silence the warning, I added DECL_TAG as one of kinds in
btf_type_nosize() which will cause btf_type_id_size() returning
NULL earlier without the warning.

  [1] https://lore.kernel.org/bpf/000000000000e0df8d05fc75ba86@google.com/

Reported-by: syzbot+958967f249155967d42a@syzkaller.appspotmail.com
Signed-off-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/r/20230530205029.264910-1-yhs@fb.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
(cherry picked from commit e6c2f594ed961273479505b42040782820190305)
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 kernel/bpf/btf.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7582ec4fd413..2c58a6c3f978 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -466,10 +466,16 @@ static bool btf_type_is_fwd(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
 }
 
+static bool btf_type_is_decl_tag(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
+}
+
 static bool btf_type_nosize(const struct btf_type *t)
 {
 	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
-	       btf_type_is_func(t) || btf_type_is_func_proto(t);
+	       btf_type_is_func(t) || btf_type_is_func_proto(t) ||
+	       btf_type_is_decl_tag(t);
 }
 
 static bool btf_type_nosize_or_null(const struct btf_type *t)
@@ -492,11 +498,6 @@ static bool btf_type_is_datasec(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
 }
 
-static bool btf_type_is_decl_tag(const struct btf_type *t)
-{
-	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
-}
-
 static bool btf_type_is_decl_tag_target(const struct btf_type *t)
 {
 	return btf_type_is_func(t) || btf_type_is_struct(t) ||
-- 
2.43.0


