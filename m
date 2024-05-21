Return-Path: <stable+bounces-45493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049718CAC26
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BEE1C219B2
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E37EF08;
	Tue, 21 May 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QKrHGL7h"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142DE6CDD5
	for <stable@vger.kernel.org>; Tue, 21 May 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716286748; cv=none; b=TY3YoODQfGw9bzX/WDjISCBEXv+OyRX+7GPQwqIzUNFRxWWDDhy9rqEOi2OzTnBoBHhaH86rz+VySnySUfyx/Hly4Sx0PR3QsAKdhXYgJSIuMxNWAO+aj+pU8hSvfP1NvKMg0oKzQbMqXXnJulENaNV5FT4NuxNoeFT4P7zywxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716286748; c=relaxed/simple;
	bh=aTLAfJ7NTAq195IS6FqbKzM3Y760wbMl85VWvhcZgbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lDNHzC+prOj7uI8TeK8zdQo1jG6DJEk0NKdX3LVm1uSFgDtey8KQUlitNGgkwdb37BLZy/mvpz9atTOL91rVqeZ4bcL5k+JjuKvg+FRkp0hSRMC6WKfmFvOVyfA1DwQC83e1gySnk+L69zYbb094PExUL3aQJw3xW7gT+9siTnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QKrHGL7h; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52388d9ca98so7121505e87.0
        for <stable@vger.kernel.org>; Tue, 21 May 2024 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716286745; x=1716891545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RVE6+ZCNpzwGUe1XsnJn7ueU+NKyXAImX94cXiq0K+c=;
        b=QKrHGL7hpwz/uI3zNsDl72G93KBtnl+z4XG+5T8OcIhPVRxm0n1KBQQD27xOKbAd4B
         42Ks534ejYQ8O0n3675IaGEMnfLTcyydEuyVRGgn3e4+neAeUE3oVcVIFB+veCl4IeXN
         +IZFT0SK3tGrrRyjCcdrBdlCDYwBTX3QPlCkpSY7ncqu6BXCsuH4VH3A3vCOaiGkuYgC
         qmzg/FBR5LFaSeTYeWIFC9qTkJtNLI6sh/RmFzkpvXtRzgvrbID/tRhJvqkyP9DxLSwv
         NL+T0nCUpJJPtRmzBZjT8tLOwvJll6tEQyPyZzgXfH/L5UGGz6wKRnmV7tc2JQ7uXxl7
         ZLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286745; x=1716891545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVE6+ZCNpzwGUe1XsnJn7ueU+NKyXAImX94cXiq0K+c=;
        b=Q79RkAwUlQmBKzhScLqvjc+P8o778qFaRVOg/G2kIljBkGmx6vPPDlwtsf44pctyVu
         qebF/MvcLojYAX6q1dkLOQXMOV3nazv+630bVN3tcFdxVng94QHStoah98rpv5xIHhfJ
         v/OMoOSoUtjhPu17FVKDqnE5oY1HvGYpexp2nz+QbfMlBS+aH2tuCMrMS8ZeJMxSdfxH
         FCChxvETvHfYoDLSrwHNI/NA0xWJNYZTTTyJfJa8d0jZTtGFzPwn5OszDwlGnWzahkac
         qpA+NVwJM/w6sCnIxnbAjZmXFSNs/Cm6n0u1+03WbzdLSM/yOAxam6pyq2DG+udjjgVI
         LoKA==
X-Gm-Message-State: AOJu0YyqICN6g/nE2X3NhoVS0OXoWSAwXDtPXNy7ROw/kh3O1SN4J7ev
	9a8FNQvZBGbR1DKNJn3WDcE3hkGTVvEkjVvYibb5hmitWIaDsyF1LVzFrO9AAAtwKI+zsLbvcNq
	N
X-Google-Smtp-Source: AGHT+IHkv0xLQlJx9nmGqPzFCA5HSn/x5Ym5Kxlwi2kfYV/zoIdIVyZNAL9J7SEi3/cktsuxGCgFKQ==
X-Received: by 2002:ac2:592f:0:b0:51f:4d57:6812 with SMTP id 2adb3069b0e04-5220fd7c8dcmr23637379e87.19.1716286744270;
        Tue, 21 May 2024 03:19:04 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7fcfsm1577106566b.119.2024.05.21.03.19.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 03:19:03 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: stable@vger.kernel.org,
	bpf@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.6.y] bpf: Add missing BPF_LINK_TYPE invocations
Date: Tue, 21 May 2024 11:18:26 +0100
Message-Id: <20240521101826.95373-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

commit 117211aa739a926e6555cfea883be84bee6f1695 upstream.

Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdinfo.

The reason is missing BPF_LINK_TYPE invocation for uprobe multi
link and for several other links, adding that.

[1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Acked-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/bpf/20231215230502.2769743-1-jolsa@kernel.org
Cc: stable@vger.kernel.org # 6.6
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
Hi,

We have experienced a KASAN warning in production on a 6.6 kernel, similar to
[1]. This backported patch was adjusted to apply onto 6.6 stable branch: the
only change is dropping the BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)
definition from the header as netkit was only introduced in 6.7 and 6.7 has the
backport already.

I was not able to run the syzkaller reproducer from [1], but we have not seen
the KASAN warning in production since applying this patch internally.

Regards,
Ignat 

 include/linux/bpf_types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..dfaae3e3ec15 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -142,9 +142,12 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_ITER, iter)
 #ifdef CONFIG_NET
 BPF_LINK_TYPE(BPF_LINK_TYPE_NETNS, netns)
 BPF_LINK_TYPE(BPF_LINK_TYPE_XDP, xdp)
+BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
+BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
 #endif
 #ifdef CONFIG_PERF_EVENTS
 BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
 #endif
 BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
 BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
+BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
-- 
2.39.2


