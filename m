Return-Path: <stable+bounces-190019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A650C0EE5A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FDD46149C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657FD2EDD76;
	Mon, 27 Oct 2025 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAzgYODE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B714C611E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577773; cv=none; b=J8luLAY0MfkYbhOY9mCexsvI67b7/OCQn0oYqsiwOZ1dOTWkOcgtd9IVnjuO3If/kkK8vfAzM/qhlrnJBTq+mtKyizm0NBI6OrKqi4RXjlEtWKRqGvtOwX9+ZwUXOLUjqweP5Ok9zgbt1Cwg2Z1mjwYt9iXzcz6toD1f92wNxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577773; c=relaxed/simple;
	bh=eIQuMzndX2IaXQQgsZY7X9rDiT2WkLqj/57iQwR1pfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrjVCujMiDMH5hwGk6bvK535pXO8fb35lxaoAFboJHI+CK5/48dZr7FnQEDYHHZ8cyEYQDyfitSTiEOGc8EbvbWNdzACTvyvyLAF5vU3Hohbf5E7Ao2gu8n8lxunQ8Xc1gEN3QUkRcwlnWioKvibuHm2dSz9OBYvUpfmUw2SMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAzgYODE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so2904178b3a.0
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577771; x=1762182571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=du5oJpRBhJlPxSiwoBeavUKOwQ5aDhNDZOqlYr8mmsc=;
        b=ZAzgYODEEsVcYhLKjQrvV+DCv995CnSx7BzeDU552u5LZtpXxRnB0cmT3d+N9EmvAc
         IYGDKITFlrCwxBHAppQL0SWpZHv5zi14fsEa1XiPHtBcxuUw1Szq6CBSdesnWlPZO9gh
         ZgLsCY4UZvnRlscVp+aBmmY6xOZLoI1YPNzqIuN10HmgjDKdpWecc7Ki23iGxcsRvp5U
         /JbLSdu9IRsztd8K1bne3+WM0n9Q7k20Q7mxecZqS8WJ4n5msdGbb2pM0pSQsHHwBw1j
         Ep68pWKqdS3tFnsTEy5gCPYndNSfIHsljQ0H/mnlNWhZARHnQ5+PTPBpSQoxfIFyzQXp
         qN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577771; x=1762182571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du5oJpRBhJlPxSiwoBeavUKOwQ5aDhNDZOqlYr8mmsc=;
        b=MDbLtvuzakYV81WMQWf3Rm0i1DFYQKKTNMmZInqPdQC4xFITl29/E7WJdpnKXEpIyh
         ADRWO01+hAcOA1uCcT3cGEw/HM58pRN7U+mNJCN+IEtm8ZprAhUjnIGCjGb/XoxtL6M3
         oDEZ/2EIZMfee+0Qbp1LC2mPkx8LQDrWPEbkaEJyHD53QLb8PTsKaDEUvQvd/w+RgVhB
         /XFfJp2ka4jceo/BpaR0vmuJS2BZyIH0QazdeWuJ8d0YRLJk0iO96oWI5tEERPSwSMFj
         IPjbPVdpmHf8mYC1BuXEyTHzyGKDoet12bkWmtU4IKdSKalBecLaXn2xyOonw7040mF4
         aNjA==
X-Forwarded-Encrypted: i=1; AJvYcCV0828vtTLYoaCFYB2e0Bf5HTpg9AFO77JgSNHSALVbu8l7cUgcsh+J4Jv+ULVO93b6okH2dcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxir1i/HDwAfcTv9naiFM6V/LS0AUltFYoFwMUuLTyUbeq5rl1T
	4Q+gXgosrLSa+fCxjS6XIqN4cciUqThaHrgXlCyvRiWpvlBpdFvlONX+
X-Gm-Gg: ASbGncttcWRlPzgoV64JzGm/n74Ir0qedkFWbH/8Qtb3ChAZWiGxWbXF3umbQy73xfp
	MQukzw2Dq+VVQQyQkieypJYJlXzJbOfQCXty01RITes+c5SQ85Q5V4+XksNwcQ6Dy+jwWTsoLTD
	IrFgiYEzkrNNwpbCoJGqj5feY0OcAppCPBklbtD6FeuTOoeJuIAep7p0UnhjqSm7x2/03cp9Rrf
	IXEXgq9smZP1nwfE8Vl22wefGOqYZYwfn3Kf+oP5P7O3Sivi6vm1L2lgr76oYl6QpuwBc7inweR
	FTd6a7SNJzfiB0MRB++kC/t1xMrrsEyZryLLeU0VPDjUlsHtEK7ay+SAjD8oq2FRIXenxZ29yDv
	7q2UPeJ+BGU2fEbpE4uC8kwt8ZJqXnG8W1LOk6WKrsMGTOobhX+4QwnfYq4fqHrDBE9UCwLl4E7
	mdEGg3N/m81QwAIi8CUDtE+Q==
X-Google-Smtp-Source: AGHT+IFScmYX6R3rthmA7m7QRURybKZunKqeR6Hr6fFU6rVxiKPR6zlKhkOB5h4TP+qYA1pWCaz3NA==
X-Received: by 2002:a05:6a00:390b:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7a441a6b2d6mr397621b3a.0.1761577770926;
        Mon, 27 Oct 2025 08:09:30 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41c70ea64sm6929565b3a.3.2025.10.27.08.09.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:09:29 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Albert Herranz <albert_herranz@yahoo.es>,
	Grant Likely <grant.likely@secretlab.ca>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/flipper-pic: Fix device node reference leak in flipper_pic_init
Date: Mon, 27 Oct 2025 23:09:11 +0800
Message-Id: <20251027150914.59811-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flipper_pic_init() function calls of_get_parent() which increases
the device node reference count, but fails to call of_node_put() to
balance the reference count.

Add calls to of_node_put() in all paths to fix the leak.

Found via static analysis.

Fixes: 028ee972f032 ("powerpc: gamecube/wii: flipper interrupt controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 91a8f0a7086e..cf6f795c8d76 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -135,13 +135,13 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 	}
 	if (!of_device_is_compatible(pi, "nintendo,flipper-pi")) {
 		pr_err("unexpected parent compatible\n");
-		goto out;
+		goto out_put_node;
 	}
 
 	retval = of_address_to_resource(pi, 0, &res);
 	if (retval) {
 		pr_err("no io memory range found\n");
-		goto out;
+		goto out_put_node;
 	}
 	io_base = ioremap(res.start, resource_size(&res));
 
@@ -154,9 +154,12 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 					      &flipper_irq_domain_ops, io_base);
 	if (!irq_domain) {
 		pr_err("failed to allocate irq_domain\n");
+		of_node_put(pi);
 		return NULL;
 	}
 
+out_put_node:
+	of_node_put(pi);
 out:
 	return irq_domain;
 }
-- 
2.39.5 (Apple Git-154)


