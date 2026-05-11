Return-Path: <stable+bounces-245125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKMZLY6JAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339150981D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB3BE30330A9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9A38C2D1;
	Mon, 11 May 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX6GXYkc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D7386C2C
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485021; cv=none; b=Kx+P9NpR+C3SSo336B8BZZ1iWWOXMymQvZwACfT4KvVY4zsEWqSlvT/zGDyIye8O8wf1CEGGKnLE181ha9MOnzmeWsirhork8qqkD1krfWrRjLMhzeXHYAccWlSdiku8sQ/+ICNmuPf1LiYmeK6/0VYee4oIliMqLwVuUE5sWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485021; c=relaxed/simple;
	bh=U79g1fMHFWxFqgg5EMKtG0uZ6/sP/SNoqUC4zgV6tU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBEZmD+a8We6RDPQ/XVaCCSzlUThUVf9k1GFvH6RQfQtYEP3ktLRY1pIz5mNnOIXYyXt1cHENupvoih3lxTts7nRBVMaVSEWSYo40AEqBWvZ7MKsj7iRdOyqhzjfSACX4EbXwXLVSYuKC95TzE3g2/r8+3dx2aTWaPd4MObmpls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX6GXYkc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ef45a6d9dfso436611085a.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485017; x=1779089817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvdHWVxPZaPcGIqjHsjQLEIDVm5Q7oKlNarSAAQjQ9A=;
        b=dX6GXYkcbGnQ/pKiOJxwfw3mAfSbShdMUrY15JbdsqNvnGntt17I7Mw/5ay6qKNLC0
         epx34jFuCSvP+L+EH8CCdzA8lxZziS2i0GiFbehl72rU7Oo8jK6G2bpChH8UvLpZR5YI
         1rIcO4MlCJtzNRjDpABZayJsnbIc/WI1mL2ZbMhIzLBYg40ifqMRogBVHgSjJk5e5cK+
         C93fFpuN0WHRTrPPkI7AyfUNSUKnbHtIV1zp6fESHKbCrQKrwTCC2c7rLfmXit3OjuuS
         z79YhClzuR3F9WQeDoJtzNQhuICGWHYdziKeawix1pxJQ/7wO2CR/QASHzt+Fmlo+5cq
         WZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485017; x=1779089817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvdHWVxPZaPcGIqjHsjQLEIDVm5Q7oKlNarSAAQjQ9A=;
        b=q30tC7gmLU9Qvqujh6n9OhFSXHCiojcBuBe1jCcMdCHLIZKM+9oZeUTzWKqCol9E6C
         WOaKpKaypjoHEB5Mdy2wzBpDf9/5JJXUhxGgz0A3MTK+7D/2u6EmlOJpGlbG0qPrqqv6
         upTIE194V/iT6YOiYW0UFueO8ki23+SXf+ldsJs4BVW4hB6+p++8SJN+oIJDh0jaW0sd
         oMvIwRK1szS6PaxACK3xW0M+kWOR/t5BkrNVufNm2PFGq/Ih4i5SjHlK/NIjTwzSUbwo
         J0Wjg4yz5/lRR8V9R1LzyTjfAsrpyHwqrj98xIozCG+Nw3NcXGvGY142hdL0B8933arD
         A9xA==
X-Forwarded-Encrypted: i=1; AFNElJ8+TgvYC/7tw9NR9/BnMLP41Em1O7R1ff7ezV3k+f+Zm7SRrfH3y88whfepVRpnEtr+CZmgKO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAw6u4/MAHDzELoaoLvAQwEve5kwru00+zOD7yiT2s0H0WHP5i
	61Rt9ha7soCv5Eas1VPYsoxSt+zZb+//DbQj6fNBz1lD1a+/jRsvjIT2
X-Gm-Gg: Acq92OHgwrcXrgD5yqIsOlZbs4vs5U1olVqhB5lNXvWNwI7plYUDq7dTouRihK3g8PJ
	gYvLUNoNBu0uNy51rKxK5XPSClF0NX1e9Q4BZycyjZrB4rL4Yu+t/hcBDykFSuDTB133zT8rNtP
	zGeI0VmL+jAb0Mg1S0+hkE/nD5293etUmRrKPXyqR3WxRPbhGEtVIS8VFVO5X42cCLFqGlyld0L
	6MqQnPqISofQvHF4vWC+VcxAp3ZMD4Yi8fwujdQxjXAadgkxZzMmbGDpDf+hFd1g/a/IFODlywF
	ONz1XCC6qa3yAtlDT4okMxDgrOeMmzkTEZg9wqXIMU/oTIANfBltov7NrNVlpslriK1tIZwUwCY
	aP6WJXMa8xqJ0uo+tU0zVzpFJucpaW8iQ3xvNx4IdqZo6pDu6OqdEhozdnszoqlXT62BfgRkHxy
	ydNe1kX9yVhi6JlmMoUBqH2+FLpVafaWAqrrIxT6I3hChCgj5LA+jUbaDER4nvhw==
X-Received: by 2002:a05:620a:1a13:b0:8cf:d804:456a with SMTP id af79cd13be357-904d4c54265mr3325056285a.20.1778485017145;
        Mon, 11 May 2026 00:36:57 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:36:56 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 6.1.y v2 03/18] perf test bpf: Address error about non-null argument for epoll_pwait 2nd arg
Date: Mon, 11 May 2026 12:40:36 +0530
Message-ID: <20260511071051.537859-4-yesshedi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511071051.537859-1-yesshedi@gmail.com>
References: <20260511071051.537859-1-yesshedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3339150981D
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,intel.com,google.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245125-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit ed847e30f001b207013b6136c264454d7560557f upstream

First noticed on Fedora Rawhide:

  tests/bpf.c: In function ‘epoll_pwait_loop’:
  tests/bpf.c:36:17: error: argument 2 null where non-null expected [-Werror=nonnull]
     36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
        |                 ^~~~~~~~~~~
  In file included from tests/bpf.c:5:
  /usr/include/sys/epoll.h:134:12: note: in a call to function ‘epoll_pwait’ declared ‘nonnull’
    134 | extern int epoll_pwait (int __epfd, struct epoll_event *__events,
        |            ^~~~~~~~~~~

  [perfbuilder@27cfe44d67ed perf-6.5.0-rc2]$ gcc -v
  Using built-in specs.
  COLLECT_GCC=gcc
  COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/13/lto-wrapper
  OFFLOAD_TARGET_NAMES=nvptx-none
  OFFLOAD_TARGET_DEFAULT=1
  Target: x86_64-redhat-linux
  Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,m2,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libstdcxx-zoneinfo=/usr/share/zoneinfo --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl=/builddir/build/BUILD/gcc-13.2.1-20230728/obj-x86_64-redhat-linux/isl-install --enable-offload-targets=nvptx-none --without-cuda-driver --enable-offload-defaulted --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux --with-build-config=bootstrap-lto --enable-link-serialization=1
  Thread model: posix
  Supported LTO compression algorithms: zlib zstd
  gcc version 13.2.1 20230728 (Red Hat 13.2.1-1) (GCC)
  [perfbuilder@27cfe44d67ed perf-6.5.0-rc2]$

Just add that argument to address this compiler warning.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/ZMj8+bvN86D0ZKiB@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/tests/bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 6a4235a9cf57..d5bf0e47a48a 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -29,11 +29,12 @@
 
 static int epoll_pwait_loop(void)
 {
+	struct epoll_event events;
 	int i;
 
 	/* Should fail NR_ITERS times */
 	for (i = 0; i < NR_ITERS; i++)
-		epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
+		epoll_pwait(-(i + 1), &events, 0, 0, NULL);
 	return 0;
 }
 
-- 
2.54.0


