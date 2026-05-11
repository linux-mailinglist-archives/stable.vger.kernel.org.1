Return-Path: <stable+bounces-245122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCRZAIOJAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66450980F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 871ED3030284
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E52386C15;
	Mon, 11 May 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avSn0ceJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C538734E
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485017; cv=none; b=jdjJfeqmUAyyQHifHTy4Ru4+IYNqxVPdNal9bk9Ll1SIQ8Lz7if1lEEEApflngvz/lv45Qow2G3yNxBgOHgJvt1b3lNgclj444WZ5cqM9/kWXwctvLnkuFtvy+r59wVde6Gzwlns8WmYu7Gfm7CySh+A+fl63AZLb3cYQ46Hg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485017; c=relaxed/simple;
	bh=Vfzg4F/VTpAiAt8PtUMou0bPeakOUhsHdF9Vll6mVO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ICmlHi90o4K/ViyhKYkRsw7TxBPBj5xx6qgkPJdTIqLJYYUWo7WELp21P/f0OvOZ1CZpSGmjtGjjD5s32HoDl+xPtb2IXtF0zxUH3iaDjCe2ppoTlMIhlWsIMXOjcy/WkCbqWKP7bznnznlJupf9+0HPB4hhs5rOsHnvG62sWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avSn0ceJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90b2fcf90a0so80145785a.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485012; x=1779089812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJS3mOMokYEIrkWEjsQ9A8YCyXvOfONHDPVxEODAEFY=;
        b=avSn0ceJgAh+d/Ogc3kR8P9VH6weVtTgjAA87gHnB11ohahQ8ood1QeCZCYNkvI+Yh
         4TYJNpGGoltuj90h3CAAo/Wett2LULEWo2mPMCrbSxgiXxUESfbjfS8G4AQno7CauMai
         fwZCitOK3tnfOd9ojbzFLdJ/sgD7MmDklIAq54irqGXL7SeDLcgTrkTaImjVOQecG7j7
         Lx9NbdKWwSoPhCInt90dVTVqsGKUqBjznD6ykCGIfgJ0YR0DS4ZmXvyEXvZ6qbuzXErz
         Gy2Q+2bhnEIcbC6jzt1ZE/joRv/AMAZjH2igHtnDwnoTpFq+SR/Cz6iPKQOSaz/iJyaY
         eyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485012; x=1779089812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJS3mOMokYEIrkWEjsQ9A8YCyXvOfONHDPVxEODAEFY=;
        b=sbrc6sqgk/Cz+JyTtVmqbwN/8HhWZSN8D4LP4sFTq6nZH2db/YreFhu9qmyRdzVEXu
         GXItqnk8bR4vNX9bS93XJZBlSJWWYtO4+thPO3m+YRUHtUo1bAArDppELQYXYntgsvRp
         9fW55AEJYZYBUPWClJ9rz8cGIwDiuuTZs9mvDe7uF39Ac1Df8ZfTUxSbj5j05fxHAtfT
         roU8v6Z4FQQA3/Ch+iTO/VbrK/WWsIz2aAtYP4xTSMAigYFbiGQ5tfFVSTXn7CE+m08R
         50kRVhxlZhfM/JDCn5SV912wjEJU+NvORyE9B8GxIa3oMR4oesFmY5Kq6yHz0Tko3MLc
         0eog==
X-Forwarded-Encrypted: i=1; AFNElJ9GFD0+dk+3+feIDrfYa2C4FbdmhBGqLu5ozNjgF1EYzCpNWTgyMgBdnwc8cUNTyR4NTOAruRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3I+jYBA2M9yfpx8O+jkQUOR8H7N+5Zx3kMDiOQvuPgCMqWy3
	B9K/oLbAJWHm/82WUxV6kkagJJfV3fEZA1CWOpYIDXx1oNVN+I+25Pmf
X-Gm-Gg: Acq92OE9ggGBcFZw94ptjqVGingrAx4RjU1vO+URbA2Jd7JYlpngS/141r4Y2EFbLaS
	71PwctmPdCbp98ls1cS0HFoDngrZpHhJLz9bfQx1NvKZf9vFQC9LOMAqIcxFUCxkrm6kIPZGMQt
	o+Optc2GOhGs4KuMLYqgDHLG0upZUcdEA7VPpn/CcqHV4sSE/fxnbP2W+Kd6BNCH5Nm+XRp3714
	Cf0+VNVSsqCX1+rtpUMXUnqRYS/X6mAEVH/xhelt4kAqd/E7NugxBuXxLKfT2sas1psIGxEGCSu
	8aXxRkrIB354CwQwCisxi2Lk69O/ljiEwwiZzbxdnCWhcryMaKl41s4V5qqQgxn/Cza0ps94TIb
	cGbZ2BEICv0ZDttZNchzcRFwJ5XN3hjSJNtOof5yU48HOy5E4nqbu5Ay6BFsfyEQfMKX+PK8I5c
	Y4PsaQtA1xjnBcujZorCUJQqfh+0SS0OW4eLnBNQWZrQVL6/kIviMMg1MRVxibY4OyUkt82NMT
X-Received: by 2002:a05:620a:4554:b0:8c7:110e:9cd5 with SMTP id af79cd13be357-90653729c2bmr2152568685a.45.1778485011948;
        Mon, 11 May 2026 00:36:51 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:36:51 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y v2 00/18] Backport fixes for -Wdiscarded-qualifiers and -Wnonnull with newer glibc
Date: Mon, 11 May 2026 12:40:33 +0530
Message-ID: <20260511071051.537859-1-yesshedi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E66450980F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245122-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi all,

This patch series backports a number of patches from master to 6.1.y
to fix `-Wdiscarded-qualifiers` and `-Wnonnull` build issues with
newer glibc versions.

I will port these changes to other stable trees once this gets reviewed.

Arnaldo Carvalho de Melo (12):
  perf diff: Constify strchr() return variables
  perf test bpf: Address error about non-null argument for epoll_pwait
    2nd arg
  perf trace: Deal with compiler const checks
  perf tools: Use const for variables receiving str{str,r?chr}() returns
  perf strlist: Don't write to const memory
  perf metricgroup: Constify variables storing the result of strchr() on
    const tables
  perf session: Don't write to memory pointed to a const pointer
  perf trace-event: Constify variables storing the result of strchr() on
    const tables
  perf units: Constify variables storing the result of strchr() on const
    tables
  perf time-utils: Constify variables storing the result of strchr() on
    const tables
  perf demangle-java: Constify variables storing the result of strchr()
    on const tables
  perf bpf-event: Constify variables storing the result of strchr() on
    const tables

Dr. David Alan Gilbert (1):
  perf tools: Remove unused color_fwrite_lines

Mikhail Gavrilov (1):
  libbpf: Fix -Wdiscarded-qualifiers under C23

The following patches by me are branch specific. Upstream code is
refactored and the troubling piece of code is not there anymore.

Shreenidhi Shedi (4):
  perf list: Fix -Wdiscarded-qualifiers under C23
  perf parse-events: Fix -Wdiscarded-qualifiers under C23
  perf bpf: Fix -Wdiscarded-qualifiers under C23
  perf parse-events:: Fix -Wdiscarded-qualifiers under C23

 tools/lib/bpf/libbpf.c             |  2 +-
 tools/perf/builtin-diff.c          | 12 +++++-------
 tools/perf/builtin-list.c          |  3 ++-
 tools/perf/builtin-trace.c         |  2 +-
 tools/perf/jvmti/libjvmti.c        |  2 +-
 tools/perf/tests/bpf.c             |  3 ++-
 tools/perf/util/bpf-event.c        |  3 ++-
 tools/perf/util/bpf-loader.c       |  2 +-
 tools/perf/util/color.c            | 28 ----------------------------
 tools/perf/util/color.h            |  1 -
 tools/perf/util/demangle-java.c    |  2 +-
 tools/perf/util/evlist.c           |  3 ++-
 tools/perf/util/metricgroup.c      |  3 +--
 tools/perf/util/parse-events.c     |  2 +-
 tools/perf/util/print-events.c     |  4 ++--
 tools/perf/util/session.c          |  6 +++---
 tools/perf/util/strlist.c          | 12 ++++++++----
 tools/perf/util/time-utils.c       |  4 ++--
 tools/perf/util/trace-event-info.c |  2 +-
 tools/perf/util/units.c            |  2 +-
 20 files changed, 37 insertions(+), 61 deletions(-)

v1:
https://lore.kernel.org/all/20260509173559.10999-1-yesshedi@gmail.com/

v2:
Address comment from Greg
https://lore.kernel.org/all/2026051001-jacket-reliance-3ec6@gregkh/

-- 
2.54.0


