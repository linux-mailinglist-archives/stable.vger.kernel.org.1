Return-Path: <stable+bounces-139114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF051AA451A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2154417937E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF691EFF92;
	Wed, 30 Apr 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b9gAqH3F"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15481C5489
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001234; cv=none; b=oE603kIK+Gk+RwXXbbIuvf16yGKSBk29JHFcxvcRjT+YhJD+yPRQDKU2Mjmw2dMiQQoOaAVAr3PpCUWkl8nv6AlNeVoT9+FLeSo3ug/VP6ncn9JNT0GidEn3DUkdTYNZyaSiwya0F4HCkTnIsukOlSb3cf3OKvQON3CmTu/XgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001234; c=relaxed/simple;
	bh=ij9abXwMDZlncX53fdQwzdsIkg0X9aEsOS38tmFwZ6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLhg70cvpV9P2ig02HEPbawsrhGfflwaqP+cC51gE9FrttdX0HKc+QA6TelJFl3VlRmLfI3Bbc9+sUoOtG1NNKKlF8L0I8Y5w6nzbzaFd8DcV63vOZ4er1eIguNv+YiWAGNvThiDxx29MwqFlklCmOrxAHNnjxiw1c75JvAgogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b9gAqH3F; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so1327582a12.0
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746001231; x=1746606031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Oy2tGormNh7Df/A85hz6eNUdSOXueFXNBsR7gTNqR8=;
        b=b9gAqH3FhTJLbL2VsTOD8jxlehRN5hnzGSOX6wwfDy2jPPYW2VCPxSfCQyPlVS/R+p
         8mrfCvjuogD0RGhdF0Kw9kfOzeOKaIhrbnxVUtY1lohCzlwIKbern0rUD3XLKfVivqnJ
         G+1l2BT+ytRAhxKsbKrrHtjUsKxLUwHLpNAbKxk0+LPo41I4ABB+Wsrh7RDiPzV5orMO
         VKevkBjqRsAIHY7chlvcW1WsJxtnzKD+oIgvufUqnun08SFxT+qyiBMsUypcKw6ivnAF
         PoiPbjDW17daE8q1NEB4VlUbS0p1de8ZT7rVA7/3uNL33qadsEcI6JWcdV2MbEQiM3lT
         j7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746001231; x=1746606031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Oy2tGormNh7Df/A85hz6eNUdSOXueFXNBsR7gTNqR8=;
        b=GQv5upUGR0j7VcVr/6NXzVKGHeDGT2UatLSSYzQbVrb2x3AXbvUm48tVvZgvo04T6u
         MbY8U5B86LfT3RJWvFLus9mtXKB1hDU6MIqdZQkxFMeba6BwnkpEs3O+0onh+8+Jho8c
         usnxLgV89JHKG5tQhM53g3jgj4TjW1S5e0MVRswIwZzfjsYaCJOUbhBj9nsQDKSd3bke
         jwZRvdQnL9d1SyniXpGR1PCtBpii1Tu0VTzxyYuXMYCn8UyKVafRYK1ykejdefvLKAZb
         xt6jlSYjeW7ephYuf2ejsmwsNImQDP1/o/Zivq3fe5pQLTbYlEs+RrTIENqzQSkgR5kO
         OONw==
X-Gm-Message-State: AOJu0YxchGT+RtYwxptl/fDpKAoScy253+lNe6clBNy3bw1bcbq8iyLd
	iXiCCYaB0mpEgIbeXavqlDWY9vVF7Ao/rjEN3hqp3KrvrZa+p3Poj4wzojyC8tPr6qO8x030F2L
	emLA2ag==
X-Gm-Gg: ASbGncvDo4NoumVNuBYhAI2f4suxfiBfYjNJCiu/3lklYeDRbNto77J0zsx0dwFutEi
	TLQp/1zQRT27ekm2fYD9gtIwuGUsw0jtxzerZpc4Qjd8X99SdRLkRyycHgJfdOrIxKxxkEmSXvz
	+RaQeWnowi2xEQCUljHQdDL7iCbphNkpZCF9Ix20ofAkvlMibXWZmcJRaNXZ4E6e45vuPHb3JCH
	dfeFoVAlV5U1PlDzbc0FBOlwR7ghU/57dZF0AnuCnDvGswW2niZVzcwuvbbWkETD9EP73q0NCZb
	3RZ2IRFBUuliCBiVikh/bu4T7SrTRJLRno5OP8oQKOo=
X-Google-Smtp-Source: AGHT+IEXJTrqolHvmUYsRQiLtpgoTLJuInpfwodL47ox0GT8jFAWZOuEG5p7jwA9Woooos/g7sMPSA==
X-Received: by 2002:a17:906:c14e:b0:acb:1165:9a93 with SMTP id a640c23a62f3a-acedf65bab9mr163459466b.3.1746001230742;
        Wed, 30 Apr 2025 01:20:30 -0700 (PDT)
Received: from localhost ([2401:e180:8d24:65b3:be00:91e5:d591:161f])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30a34a1113csm971490a91.22.2025.04.30.01.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:20:30 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 07/10] bpf: consider that tail calls invalidate packet pointers
Date: Wed, 30 Apr 2025 16:19:49 +0800
Message-ID: <20250430081955.49927-8-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430081955.49927-1-shung-hsi.yu@suse.com>
References: <20250430081955.49927-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit 1a4607ffba35bf2a630aab299e34dd3f6e658d70 upstream.

Tail-called programs could execute any of the helpers that invalidate
packet pointers. Hence, conservatively assume that each tail call
invalidates packet pointers.

Making the change in bpf_helper_changes_pkt_data() automatically makes
use of check_cfg() logic that computes 'changes_pkt_data' effect for
global sub-programs, such that the following program could be
rejected:

    int tail_call(struct __sk_buff *sk)
    {
    	bpf_tail_call_static(sk, &jmp_table, 0);
    	return 0;
    }

    SEC("tc")
    int not_safe(struct __sk_buff *sk)
    {
    	int *p = (void *)(long)sk->data;
    	... make p valid ...
    	tail_call(sk);
    	*p = 42; /* this is unsafe */
    	...
    }

The tc_bpf2bpf.c:subprog_tc() needs change: mark it as a function that
can invalidate packet pointers. Otherwise, it can't be freplaced with
tailcall_freplace.c:entry_freplace() that does a tail call.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-8-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[ shung-hsi.yu: drop changes to tools/testing/selftests/bpf/progs/tc_bpf2bpf.c
because it is not present. ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index c44754ff4abe..40fc6ed49dcd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7885,6 +7885,8 @@ bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 	case BPF_FUNC_xdp_adjust_head:
 	case BPF_FUNC_xdp_adjust_meta:
 	case BPF_FUNC_xdp_adjust_tail:
+	/* tail-called program could call any of the above */
+	case BPF_FUNC_tail_call:
 		return true;
 	default:
 		return false;
-- 
2.49.0


