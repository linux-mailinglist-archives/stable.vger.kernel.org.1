Return-Path: <stable+bounces-205065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD794CF7BE8
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 11:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1FA2302A95A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B083C322B92;
	Tue,  6 Jan 2026 10:16:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEF2D7DE2
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694611; cv=none; b=UE/cWoGF7pmgjTWL6MISFaTDCyPPEBIAQmryqWL9RMqFie56gGwHTkx9tmSB0ccsIp6lY6pst5Rg8QtgovuB2AeQ31pNhDutT4jZA9A5esNWSTBtAqjO+2bm/zpYA3yTm48f0NJu0yAP5YDR9MSXif443Hx8sVnEcmIjNLjnvPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694611; c=relaxed/simple;
	bh=R0brKy11lWk9rG1Hszq3cr5excGuzAybyASfH2xcz9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H5H1/Gb7FcJoYmEQM2zuI93eI11abITLjkS2CguzZc+tJPUp9J7EboCpbOz3QE1nq8OZ86kibB8xYX/xtLCPkEX68MYUuJLcvA95JGxEZDl6e1bXqpvNguOA4+VXi70QKFabLssFHbHdqG0c0CTZcNQxSIVtaYuAZ487akuX1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7c76d855ddbso265121a34.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 02:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767694608; x=1768299408;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNNcUB7lgyIwf3R57Px+ObUOuuqMHsgwS/LskqhZlIo=;
        b=AQxkm9HTiHvaa33pv5I4qW/MsrtSAxFCGpVI50+dKXjc8+6vIIrt0B1QmzoTsu37p0
         TYLCRrF4uKnqRg21uNRB7OzG+6WRZGa4TVQK4hQm0X4Iv34c5wj38aek4eVPdV2TFXmj
         YAGiGsnMqZsH6iu7pSrtc145Wi3jpxSwc4srcJT10P2VsAJsLFt6c9QBPTKwQSnHCyww
         61LoA/UD6U5Juy+vARPjlB6ENUelEWQjIEYAGLERb7Nbi90kkDu8wEsvjkzxCstZy5sA
         m97ogmUWYEml03GZ2CZfdsceSbeiz+3g00A5PWa/+o8xzrc7dQUXwzLhFBfqGIA0lgKc
         ac8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo7Gh6AZ4TaBEotoQVwa6G8SprXV9g94KreoVkjXC3fiq+J4wbjp1HA/rCzOYcz8ys1XbEPEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwin5xlfwk7KsT5BhlI00cPjEYf+2RclPdwW24cEU4hwrIONxb
	7lRKdSjtCkLQxSn/0L5bCNVyv/UjNoZzStSjsUIR+wz5yBzXS/O4edTm
X-Gm-Gg: AY/fxX4Jd9I0t4Z5rDdv2TfZ1tswxMvpEYoliFaSjTUgJjFDGoeB8rsFkrpjIFXJIqp
	M+5yULoUg2O9B9CNCPUphPYGsqurbmniel2Bj8A2ZJa60EdSNFfbk92l4xvCb0gcgazGovGTb0v
	kAPOZFuBLPg+t01TiAtbHrjKVa+Xmg242dBENsAL+z7YBCAowDwkfA5TOrL9d410XfwSfL5lMbN
	X+TmmotMaW3A6nR5qQ7iyt6z2Xxk9kmMu+U0zlCoO1scvpM9XXbLJCa+Qtv83guaVDewmgH6J3L
	NafgSV2nauhXJc3YCMphBKRSNdjqwzB4y3zuWbMZRuCf0kNo1wTYZ/Mwn7aZ2PkCaQSo/czYtmv
	HY4tDs9TdL3m0Y61PTjwhzfT20c4gVppBvuNR3G67S17fX42Qi7bAANbgAg7tPx3MFpeHoNDQ5s
	AuOD/MB3+kodhFSQ==
X-Google-Smtp-Source: AGHT+IHpik8hWyPXo+y5CoXoGZNP7a5BRxyJotM7yoa4j2oD5Z6LvXpzD97F1AyaKuGImA/76c6nUQ==
X-Received: by 2002:a05:6830:314e:b0:7c7:b28:227c with SMTP id 46e09a7af769-7ce4663ba8dmr1405642a34.4.1767694607636;
        Tue, 06 Jan 2026 02:16:47 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm1149346a34.12.2026.01.06.02.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:16:47 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 06 Jan 2026 02:16:35 -0800
Subject: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
X-B4-Tracking: v=1; b=H4sIAAPhXGkC/yXMwQqFIBAF0F8Z7jqhlAj8lWhhOtW0sFCLB9G/P
 6rl2ZwLmZNwhqULiU/JskVY0hXBLy7OrCTAEnSt20abRrkYt+IKB9W1gc1kjA/diIqwJ57k917
 98Dkf48q+PAHu+w/4tl4nbQAAAA==
X-Change-ID: 20251231-annotated-75de3f33cd7b
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Laura Abbott <labbott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, 
 puranjay@kernel.org, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=leitao@debian.org;
 h=from:subject:message-id; bh=R0brKy11lWk9rG1Hszq3cr5excGuzAybyASfH2xcz9g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpXOEOE3XW9TBI5+gt0t62QrPhBcRn/qigH4pDn
 4gtfXOidi6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVzhDgAKCRA1o5Of/Hh3
 bUDDD/9rIz9FUmTyftcZ2SiYxTdKVB+boYTZiBL/TZMurMwpO/5crdYad5bRGL5PnmNRnAeXZjf
 4bJExaoMmBMiuWAyvQvis+Kgdu+xYgXT0mYC9e+ofnCp05M+Yv5GS5f5vATolKFIjKTnu/Xl6cG
 DPkerSX2xPxChN78jd88Nf/ckcBu3vOkDA4cAtYIRrpN/m3yM6qoukboZHnxNKVOoLV1FQHepcu
 K5wMSl7Tl/DNZwbD/rvR1VKmO39xdu64RTE9kWrmZ9CQRY6OdsEsNhFeCrTTRO8ELUkVvKf1bVY
 ImufebVYkB7WsBLoG8pQ9Nvnw1QknNczA8BbYtGKz0EboKTFJauoROuLtb3QLUaycljbGbK8y/W
 tJUssGjN9WA24lPTVxmN3vmb9gv0/OqmVsrHwt0wF7UvJbUKTr0SqCSZrbXchU8kVyiGUw7K0Y4
 oLR1uNKGJYHlOxO0fAJZH3QEW3JLiJ3kuN/pbIw5aKZi+WLDgZ37YiRQS66jDV26TfYKdP40ply
 ERVMouE96PDsf9EjIYu4xRE1dyOhITnjRaPhNThdNXkgm54dBgEkQSx7LGlbeV7Us9pbVThNkV3
 /9sSDLDoLxAVm6uTFXtDXG/F6GHzX11cLaNJCkS9QIXeLC4NLaACGOLvz2bDIEohjUxyUGPc0jr
 Pp5K+kknoJuxX8Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The arm64 kernel doesn't boot with annotated branches
(PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.

Bisecting it, I found that disabling branch profiling in arch/arm64/mm
solved the problem. Narrowing down a bit further, I found that
physaddr.c is the file that needs to have branch profiling disabled to
get the machine to boot.

I suspect that it might invoke some ftrace helper very early in the boot
process and ftrace is still not enabled(!?).

Rather than playing whack-a-mole with individual files, disable branch
profiling for the entire arch/arm64 tree, similar to what x86 already
does in arch/x86/Kbuild.

Cc: stable@vger.kernel.org
Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Expand the scope to arch/arm64 instead of just physaddr.c
- Link to v1: https://lore.kernel.org/all/20251231-annotated-v1-1-9db1c0d03062@debian.org/
---
 arch/arm64/Kbuild | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 5bfbf7d79c99..d876bc0e5421 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# Branch profiling isn't noinstr-safe
+subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-y			+= kernel/ mm/ net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/

---
base-commit: c8ebd433459bcbf068682b09544e830acd7ed222
change-id: 20251231-annotated-75de3f33cd7b

Best regards,
--  
Breno Leitao <leitao@debian.org>


