Return-Path: <stable+bounces-95501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC279D9259
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 08:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C171667AB
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E81898FC;
	Tue, 26 Nov 2024 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C2QeGqbw"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE9187876
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732605738; cv=none; b=qreV4N4o2J2AexbGRqdOv/VoyrJ/bpzrk291enrOTnCUiF+xRsqiKpPlz5JgWeQ+2uTPK9duPbWS+qBSb2HaazEooqDJXh+TEpsDvONY2nDtSmEMhZejeHgRJJx6ox1ZZgaRku+qR1ZBHDeoez3naXWIUqiu36SJTkOxBNxTNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732605738; c=relaxed/simple;
	bh=cWKGyjJI2Z7xBkDStZmP9WnSrQcPK8TNVQQ7nbH8Tfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZEFQtFEi5v0NWj4CuLgizrmAPmw/wyr8ZaUVc9DmVpWeheSgo3flgeO7tWfH1XuU0qP08azPSDZ3DU9b4ZEvvRlvJYltsH1NIrRyCrlkQEFtR39nr5NhtQXZ40pBrNPd4loiScXatDETLUSysSYzBToQVyGSDiiaKdKkuo1QgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C2QeGqbw; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-53dded7be84so2963677e87.1
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 23:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732605734; x=1733210534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkluEuNfhuJBZGAtGl0FEVeQvzec4f4Xn0zbgwVgHb8=;
        b=C2QeGqbw0qYnAa4EFy38+Xh2CaGpzXsk5vM8VdEA55K/eUopuZlx8jZB57mpxIT4ZC
         M8HNGgWT83xYjMI+TA8uPvXbBuTCIjLMMX0Q2yh+GX2jWGzSYWXv7SM4gC0UV0+6KV7C
         hDe2yUOjanwZPuakihSqj9a1b9PeEon5gwsQJqR/fttf4PM7PrL39440ELtfrAUXDwgX
         2D1SkzMF1820QkioMfPhI8iDoycvrbNCnMXfn944K1gGZXlxkN4NnTEYRqTij0NeQFN/
         s+0CMX9otQ0tkf3rXO/IFXVJllfiyiOPc/QEbj3v0hv5fyvLCJG89tnwiUYjdzDJUfb+
         o+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732605734; x=1733210534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkluEuNfhuJBZGAtGl0FEVeQvzec4f4Xn0zbgwVgHb8=;
        b=mg8zH8t5nvMiTfyRC5RIekXYjnMKS7jJgxlSzE6W8oSywo4e9rMg02AHAbStdM1YBE
         JT0jdos/gHawgGMzHm96MPMmTX3jxxOpzccldIX3p6pBgQY9KjP+mD8gRaWcmNJq7pW6
         TlD36BLASEd+zzXBNy5Bdn1TGoaTjnDc3dJxgwh6IItrOrGqjr+hDVzN0iNEno3WgJx2
         i+/s7pdKUSE1AE6F/fYT1iA6Zd3wotACikh60SgiHmTJypEy24mUUi/b4+fLbbE4Ks1/
         ubiUisTLr/cc6J6AwK24powy/9eX2BzAudflccVlxBYHBxD4wGTlK6l+d/Dx/FJuOgbD
         fA+Q==
X-Gm-Message-State: AOJu0Yz3D3GPaZnDTAWaTrF19NDK+rFdxVet96luNs2jh+HgFS5JxKR3
	WzpSu47nZCTPq+TS03tcfVYs0k3Ns2P2XFswoTjivV2LzIYU7RXGLANQJ3oZWWtNRRjG/qeGqTs
	PY2wCTM0eLyk=
X-Gm-Gg: ASbGncuYBv5+loowg9FiPUUadtvkpp7+aUVRDmO6nhJ8Hsc67oo/b56E86wNRC/KJRM
	35y7jPTJF7MWh1E0RJyes+IXB2981zK+3Oe0WJLjHoli0eSN/Q7eEDhL2uS7T7QCER8yfBYF9tW
	6mU+hBzNcpjDRzZP77RG4UYjkncE0i8OiD6QXJpOL9DDp1XgnEIBJpYlqPp6hGLDf+gMGXTGM76
	8dzAXBoHRlpVeJQcPCQ4u3mhWXAhF/YyoKkNisFeXk27ZCdtv8=
X-Google-Smtp-Source: AGHT+IExd4wjKdMgJ3DJsJ6rqid8OquGoQk6r9/Sd2nO3Iox4lTjvqM7dTtiW0RL+4INMH610Kwl2A==
X-Received: by 2002:a05:6512:224d:b0:53d:a2cb:349e with SMTP id 2adb3069b0e04-53dd35a1d46mr8240821e87.4.1732605734452;
        Mon, 25 Nov 2024 23:22:14 -0800 (PST)
Received: from localhost ([2401:e180:8891:cc8b:6df8:da33:1f62:8cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212a3025942sm73916645ad.63.2024.11.25.23.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 23:22:14 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hao Luo <haoluo@google.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hou Tao <houtao1@huawei.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH stable 6.6 5/8] selftests/bpf: print correct offset for pseudo calls in disasm_insn()
Date: Tue, 26 Nov 2024 15:21:27 +0800
Message-ID: <20241126072137.823699-6-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126072137.823699-1-shung-hsi.yu@suse.com>
References: <20241126072137.823699-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit 203e6aba7692bca18fd97251b1354da0f5e2ba30 ]

Adjust disasm_helpers.c:disasm_insn() to account for the following
part of the verifier.c:jit_subprogs:

  for (i = 0, insn = prog->insnsi; i < prog->len; i++, insn++) {
        /* ... */
        if (!bpf_pseudo_call(insn))
                continue;
        insn->off = env->insn_aux_data[i].call_imm;
        subprog = find_subprog(env, i + insn->off + 1);
        insn->imm = subprog;
  }

Where verifier moves offset of the subprogram to the insn->off field.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20240722233844.1406874-6-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/disasm_helpers.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/disasm_helpers.c b/tools/testing/selftests/bpf/disasm_helpers.c
index 96b1f2ffe438..f529f1c8c171 100644
--- a/tools/testing/selftests/bpf/disasm_helpers.c
+++ b/tools/testing/selftests/bpf/disasm_helpers.c
@@ -4,6 +4,7 @@
 #include "disasm.h"
 
 struct print_insn_context {
+	char scratch[16];
 	char *buf;
 	size_t sz;
 };
@@ -18,6 +19,22 @@ static void print_insn_cb(void *private_data, const char *fmt, ...)
 	va_end(args);
 }
 
+static const char *print_call_cb(void *private_data, const struct bpf_insn *insn)
+{
+	struct print_insn_context *ctx = private_data;
+
+	/* For pseudo calls verifier.c:jit_subprogs() hides original
+	 * imm to insn->off and changes insn->imm to be an index of
+	 * the subprog instead.
+	 */
+	if (insn->src_reg == BPF_PSEUDO_CALL) {
+		snprintf(ctx->scratch, sizeof(ctx->scratch), "%+d", insn->off);
+		return ctx->scratch;
+	}
+
+	return NULL;
+}
+
 struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
 {
 	struct print_insn_context ctx = {
@@ -26,6 +43,7 @@ struct bpf_insn *disasm_insn(struct bpf_insn *insn, char *buf, size_t buf_sz)
 	};
 	struct bpf_insn_cbs cbs = {
 		.cb_print	= print_insn_cb,
+		.cb_call	= print_call_cb,
 		.private_data	= &ctx,
 	};
 	char *tmp, *pfx_end, *sfx_start;
-- 
2.47.0


