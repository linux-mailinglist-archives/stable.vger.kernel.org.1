Return-Path: <stable+bounces-243997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMjqNAqb+WkS+QIAu9opvQ
	(envelope-from <stable+bounces-243997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:23:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 397744C7D41
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C6AB30557E8
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB78E3CFF48;
	Tue,  5 May 2026 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/V46l9W"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DF22083
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965622; cv=none; b=KeXsLlPGKPT8TQZUA1oeH1ixJIcakMNHoJfxAMucjIlg0HxQxjX9BpG6s9pwwdGLxNhbzgsxWLrm+HCq8BICbn4QRKTCdqSz+unxdG8YCTO1t/htjRRS/CLDda0mvnC4ygvOgks+GlJerq1PtTfM02kPGuEknlWWqb77IXMus28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965622; c=relaxed/simple;
	bh=z4+eW0mQ+yC1v90F/v5PDtz5WkVGIG6MzvBABs37gNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LsoryXz0RsLAPD4tfM/ZeaZCU7Lx9qDq8sNIOY4NpvNYJx2VSoI7GWLdThryzHFtZuJAMfreI3PHvB4/Y53Tl2W0SCFUEoRUx3sykmzDujjBzmkGJuJTSE5R8Fs9cvt5tGUIKwcKxiA/eQT7+2cUiotIvToKNHxUTTf85NN/1oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/V46l9W; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-836ebdeb969so799458b3a.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777965621; x=1778570421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuFfjsO/bZxdiI4c964U/c9Cqd75USB3mn6RrlPw2fs=;
        b=j/V46l9W7k/IOzQjVQ513dBy1xrsLiVVUCuJeL+i69jtHindnOUTKcz3O2Kd2Mfbg1
         Pb74DwVlKDFB3PycMJjCiX1S5Iwnd8qeRvojlVZ8KqK3z0wHy6vUWvjzqwWe3Byw3B1i
         RvNSffLHkPymOFZKp1/cjoBKJyHr2FVTSyoH31pb8DnoM2mqqazQzs7ypgduZwxRCB/5
         K7jKlh7qz9RnKp65UQEQuY9GFtjcD6RnUBnUXbPQmqfR0NP4F26kB4elA0B2yORj0FAr
         oY44BZJcKlPjAwdY5dyn4y6uuNxAhE12KT5dG9kwkAsfYPOJVQT9GTQUEixcKBCzJpRX
         SY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965621; x=1778570421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuFfjsO/bZxdiI4c964U/c9Cqd75USB3mn6RrlPw2fs=;
        b=eBFYHoF2j9U6jw3C4h6uUOOPwSaWiciFOlm1kd9oA3yu75+9AzfCr66dyEt15b6o2E
         dvsqtHYgByalmi3knSMrRL1yOYwC6tEcD7yuYo4lWXhtrzep95oyFYMu2PM8HmhHStpe
         ZOVxlcRdPkNBQA9UzHlrnkJ3yyqgml9fzysIOU8TlUTuHndpfuXpYARHBXVFMLSNPf4V
         PvkcR3cwgZN0sfPXFY4GrHZA67JllBIcrevn2Y3Qw2OAQkQiLf2yQYCxxLcLu/xc3Cax
         5phY2c7G5tN5cqeq3l3OJy6jsDivBhGgw9W+PF1Z8fxEDLSwq5IRegw+kCBbnDJTPS1M
         AP2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8nmekibXxNua+GV+76KUL37q7SAJ8GQ40vaGKQLVEUcXhNsCI0pbf9Oi64tA8FWjDt2BWHJTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTAZlEEZFbRI8bRwoGfgX4N0QsvKZK7VJ6hTsxq2+q9aKYrC6J
	ZGZg1S/5UQlaj3A/OdpIV4rlgcrFJTgllLpg4yga6Wf27OBspoFalX+P
X-Gm-Gg: AeBDiesvwm6luKoOxZT+dhNe1zI5toYGgnB8RsZb/Z6MdB5Ly9kdnWHjgJg0mrgX9gh
	V72R206yAOQeNtqJXVEcTn2O/S7oEULrqFgWJFEKsdzjgM5HJjRgZo0s3bksS92O1ud6Hwc+cTv
	FgJyZdXPpwiC/Hokla+HMi4WzCFbQrb6g/E8FOmiJihhblx5o33UGL1rP853rzTVFl20fas7Etr
	1OyH35BpeoSbhx+wKHM8X1bCb+f42dk4UXHT7IYwBNgvPYwHuiJkMi6wWCScCIq/25mbccPUiz6
	bseFgIN6Fc24RwG5ue+rgVkfSoMvWAn+oSiSOLVqINY9nZVRM0ybUYkOD+0UO3qovVNxWk49yMV
	oNgbxMJvJy6C3PNFEC79dOzKJiTpktERQi+KrcrEe0yjDYhgzMruekb7/WvDTDiM+R6y3iRbpj4
	hiXaqVX/CKQpqdU4xiiGdC4UFB+Zl0VbZbFjh6DL1tR5sznsjYqaa7DEssk+k=
X-Received: by 2002:a05:6a00:188e:b0:838:127d:a168 with SMTP id d2e1a72fcca58-838127da456mr5959734b3a.17.1777965620677;
        Tue, 05 May 2026 00:20:20 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a4bffsm1036227b3a.56.2026.05.05.00.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:20:20 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
X-Google-Original-From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
To: "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Willem de Bruijn <willemb@google.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v7 0/2] ipv6: flowlabel: per-netns budget for unprivileged callers
Date: Tue,  5 May 2026 15:20:13 +0800
Message-Id: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 397744C7D41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-243997-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:mid]

This series fixes the cross-tenant DoS in net/ipv6/ip6_flowlabel.c.
v1 through v6 were single-patch postings, each in its own thread.
v6 review pointed out that the existing fl_size read in
mem_check() and the corresponding write in fl_intern() are not in
the same critical section. v7 splits the work into 2 patches.

Patch 1/2 is a prerequisite. It moves spin_lock_bh(&ip6_fl_lock)
and the matching unlock from fl_intern() into its only caller
ipv6_flowlabel_get(), so the mem_check() call runs under the same
critical section as the fl_intern() insert. With all writers and
the read of fl_size under the lock, fl_size is converted from
atomic_t to plain int. This is independent of the per-netns
budget. It also makes 2/2 backportable without conflicts.

Patch 2/2 is the v6 patch, rebased on 1/2.

  - flowlabel_count is plain int rather than atomic_t, since the
    previous patch put all writers and readers under ip6_fl_lock.
  - In ip6_fl_gc(), fl_free() is now placed below the fl_size
    and flowlabel_count decrements, removing the v6 cache of
    fl->fl_net.
  - In ip6_fl_purge(), fl_free() stays in its original position.
    The function argument net is used for flowlabel_count.
  - mem_check() uses spaces around the / operator on all four
    expressions, addressing the checkpatch note in v6 review.

Numeric budget (preserved from v6):

  pre-patch:
    global non-CAP_NET_ADMIN budget = FL_MAX_SIZE - FL_MAX_SIZE/4
                                    = 4096 - 1024 = 3072
    per-actor reach                 = 3072

  post-patch:
    FL_MAX_SIZE doubled to 8192
    global non-CAP_NET_ADMIN budget = 8192 - 2048 = 6144
    per-netns ceiling               = 6144 / 2 = 3072
    per-actor reach                 = 3072 (preserved)

CAP_NET_ADMIN against init_user_ns still bypasses both caps.

Reproducer (KASAN VM, 4 cores, qemu): unprivileged netns A holds
3072 flowlabels via 100 procs. Fresh unprivileged netns B then
allocates 32 flowlabels (the FL_MAX_PER_SOCK ceiling for one
socket), the same as a clean baseline. Without the per-netns
ceiling, netns A could push fl_size past FL_MAX_SIZE - FL_MAX_SIZE
/ 4 and netns B would see allocations denied.

v7:
  - 2-patch series: 1/2 (lock prep) and 2/2 (v6 rebased on 1/2).
  - 2/2: flowlabel_count int, fl_free() reorder removed in
    ip6_fl_purge(), checkpatch / spacing in mem_check() fixed.
v6: rebased onto current net (resolves the conflict on
    include/net/netns/ipv6.h that v5 hit). fl_free() restored
    to its pre-series position, with fl->fl_net cached locally
    in ip6_fl_gc().
v5: replaced the per-netns ceiling FL_MAX_SIZE/8 with the
    computed unpriv_user_limit = (FL_MAX_SIZE - FL_MAX_SIZE/4)/2,
    which evaluates to 3072.
v4: addressed Willem's v3 review on netdev. Dropped the
    flowlabel_has_excl cacheline argument in favour of "fills
    the existing 4-byte hole after ipmr_seq".
v3: addressed Willem's review on the private security@ thread.
    Merged FL_MAX_SIZE doubling, dropped test data, moved
    flowlabel_count near ipmr_seq, inlined fl->fl_net in
    ip6_fl_gc().
v2: per-netns counter + cap, sent to security@ as a 2-patch
    series.
v1: fix-shape sketch in original disclosure.

Maoyi Xie (2):
  ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
  ipv6: flowlabel: enforce per-netns limit for unprivileged callers

 include/net/netns/ipv6.h |  1 +
 net/ipv6/ip6_flowlabel.c | 45 ++++++++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 15 deletions(-)


base-commit: ebb639024ebd47a13a511cce6ae630c15e4b3126
-- 
2.34.1


