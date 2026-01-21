Return-Path: <stable+bounces-210686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBa8FaxYcGlvXQAAu9opvQ
	(envelope-from <stable+bounces-210686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:40:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7D511DF
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54CD04E6114
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EC03C009A;
	Wed, 21 Jan 2026 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ebsAaKM7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E13C199D
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970399; cv=none; b=T+G15KyjkQjTd/+JQtXCQP4/TQPhdEbtLdw/JeC+sb5fL2nDNR8DXU34sb0iFXvXhDbHeFgr2wopnDCA0mRhHdYbzhRTAiZEdf/E0dTyon4LFs0nCVvvG+kBGVMlbLGAVsqu9KlwdKNb1YF2R7kV9yFoKh5v23BV9xB6oZEA6wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970399; c=relaxed/simple;
	bh=SAMvuZgJ+A3iZYHk3mMsAnp6XN8VJ72rWxqUVH1nZgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqLjHwho6AVxEGjTQ7TF0TL77vWWob9q3KmJVZMktIguxYktVm9QQcbZm2ucDOys56j1XJAz5SwfJUhBWgN6YcA/S+nPOTJb0HFY3PQvf01Tdfk11wxVg2x/CWDPULL05JQmJPoZ8VgsNnNF0oUyqq/nr8qDnTDrFzyTB0WHwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ebsAaKM7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-655afbca977so8251688a12.2
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 20:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768970395; x=1769575195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OneY5qFV/lPv8ZoTT+jyYqYTk8IIuOHSQs25TgqXbko=;
        b=ebsAaKM7RSiwg71e81m5YOoou4zam4g6GU615svkFfj2hQgkLZ5Wf4mdiASOvAnqrQ
         Bn/vpuvGdFWbXr71aT7HmDPQ9bLwTLkKHaHV9Ni0LxvPZ6BootiMW6/V/Mv3+CLrneUW
         XWsx5hTVjDRA+d7z5eo2eNZfmntMxjknIgK7xmsEjPoXuKeMNjJrQ8jOBMsCwE/LtcFn
         JVSqKZ0wy3/019oo1wSFfGgu0uTt/h0zfvmvpL5+I4bGrOsUP9U/hkeAmMw6SRbxQFf0
         forgJz2oolaYRHWUiGKWIe5aNE/VDSIEBwfYX0SPr3OeCy5dteYyFjQZLukapkvA/3Ep
         mcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970395; x=1769575195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OneY5qFV/lPv8ZoTT+jyYqYTk8IIuOHSQs25TgqXbko=;
        b=rE1JIMLLbLvs08WW60XxrrFKoSZi6PACOblsGbBrgCELuDslLSHI8gb9iZgW63UkHO
         q20nOUDHiaeNLypoVZidyb0pFft5ImahqfaIxmn/ZjsSzHMPdeLzS6vrz1VcbLQdFwjE
         xryPeTzgEigyqSUPUMyjB4AicRAhg5ir9sLW2Kmp33MJOqXHhaQ/A2aN3wqXq0NzAFQM
         t1KlXMXSNKx1K8nj+SNdhrqvXZpvNkejt12mlK1a4ThtBYbeXDhThadMUddqVW5xAP4c
         DgdSFHZ6VJ9CE1+ZtBk3IkjEf82/szZcQYiGom1KVj+0LM5Gjlzfq52FBklPHYy2cTWa
         C1mQ==
X-Gm-Message-State: AOJu0Yy88TsqM5q3l+a1uscn8uQzoJ1/FavQJ+PtC+Xkp+CUG/kc9i1e
	WcbyS22usAvIbhlcVu3aBlxzzRIYcVqLaUMlt4l907I5e6BpDbOVE4YExyZN9aoKUTpl4fWGx9R
	01pkv
X-Gm-Gg: AZuq6aKbs74uxbqD3RFne9q0NLfftp+3x7fWXqZ97rBHs9HWQLSATkvr6VMaoemkl4B
	sbvsvvixwQ30gCuMkrdRNLxnnM7zzjPhiWcuQ3snv9zch9hnpneQ4bdwgZcBhADAo+ZbVvUXYNL
	dP07FpDUKF2b+oEOr/hi2HwQswm0ukApA+szdJWImtBjidHR9SLhmwcMKJ9fIGIW9Kbtb6h0pSe
	xGrOnYQw0TEMYeEChsUoWhQbXrVQq/ZCY61nCH/ET7AhinibelzgI+yFvVv7BQRTzDFuGkJtEax
	ke02tlQdAvxEeWf2yLEV+OUngVqTG8qJrAFL5Avycsm7IDTVVP7pahoXlKWGAKaQ9Qg3voC6naN
	+hSianBD8VoF7v09c8S1AddfigE66PVDsAqg+ld4vFLDKUZwIX8iHI1u9yoP/wCdouZAxi1b+Sb
	5AVejO+YYqJwdAXg==
X-Received: by 2002:a17:907:d23:b0:b76:d734:d459 with SMTP id a640c23a62f3a-b8800392265mr374764666b.57.1768970395318;
        Tue, 20 Jan 2026 20:39:55 -0800 (PST)
Received: from localhost ([2401:e180:8d80:2a2e:c146:9b66:e2fa:21e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ec702sm6082704a91.5.2026.01.20.20.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 20:39:54 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.12 6.6 2/2] selftests/bpf: Test invalid narrower ctx load
Date: Wed, 21 Jan 2026 12:39:16 +0800
Message-ID: <20260121043939.22629-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121043939.22629-1-shung-hsi.yu@suse.com>
References: <20260121043939.22629-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210686-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.com:email,suse.com:dkim,suse.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: DCE7D511DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Chaignon <paul.chaignon@gmail.com>

commit ba578b87fe2beef95b37264f8a98c0b505b93de9 upstream.

This patch adds selftests to cover invalid narrower loads on the
context. These used to cause kernel warnings before the previous patch.
To trigger the warning, the load had to be aligned, to read an affected
context field (ex., skb->sk), and not starting at the beginning of the
field.

The nine new cases all fail without the previous patch.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://patch.msgid.link/44cd83ea9c6868079943f0a436c6efa850528cc1.1753194596.git.paul.chaignon@gmail.com
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index a83809a1dbbf..0450840c92d9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -218,4 +218,29 @@ __naked void null_check_8_null_bind(void)
 	: __clobber_all);
 }
 
+#define narrow_load(type, ctx, field)					\
+	SEC(type)							\
+	__description("narrow load on field " #field " of " #ctx)	\
+	__failure __msg("invalid bpf_context access")			\
+	__naked void invalid_narrow_load##ctx##field(void)		\
+	{								\
+		asm volatile ("						\
+		r1 = *(u32 *)(r1 + %[off]);				\
+		r0 = 0;							\
+		exit;"							\
+		:							\
+		: __imm_const(off, offsetof(struct ctx, field) + 4)	\
+		: __clobber_all);					\
+	}
+
+narrow_load("cgroup/getsockopt", bpf_sockopt, sk);
+narrow_load("cgroup/getsockopt", bpf_sockopt, optval);
+narrow_load("cgroup/getsockopt", bpf_sockopt, optval_end);
+narrow_load("tc", __sk_buff, sk);
+narrow_load("cgroup/bind4", bpf_sock_addr, sk);
+narrow_load("sockops", bpf_sock_ops, sk);
+narrow_load("sockops", bpf_sock_ops, skb_data);
+narrow_load("sockops", bpf_sock_ops, skb_data_end);
+narrow_load("sockops", bpf_sock_ops, skb_hwtstamp);
+
 char _license[] SEC("license") = "GPL";
-- 
2.52.0


