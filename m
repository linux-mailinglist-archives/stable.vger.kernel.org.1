Return-Path: <stable+bounces-212932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCFkCYmnfWk0TAIAu9opvQ
	(envelope-from <stable+bounces-212932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 07:56:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85234C1053
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 07:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B50033017044
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 06:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937A32D435;
	Sat, 31 Jan 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLHnadnT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75EC313E15
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769842553; cv=none; b=LBuRqi1t0S1Pb0JDubetWFxMzL3ag5UcyMIP4jkH7iLAFlJP73PPr96C54AVPK2kF4Fg75GdikCnF0uduxZAJzd62QG3ncpj7g/Ps6Lv/Fr9NKMLHgX6GEg7H1Dsn40yJ5taaiugmklgeGDfE0cXtEmyXieHvz3aqw3j05WEDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769842553; c=relaxed/simple;
	bh=5BmH12YbHKMwJRnWZOYAXW3Pk9yR76BehzdsGZW/grE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SththUWMpvPK7+n5A14pQ7gXwgogFZujPqsA7iM9V+ITMA04AOAh3ydfcu6ij1BuNwZUprEMsRjjE2F332SUJbUtv2eKQ8T8W43qM520ktXgAAhDauP1eE7SqA1/2peMnXu21XONWDABAtuWJB5GBVjaFuGxwf1tJ+wY9QVFqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLHnadnT; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so27988055ad.2
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 22:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769842550; x=1770447350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDLJXl3kO9WYLHYaAYOE8EZpw5zllMbrwjKTsjUtSuU=;
        b=QLHnadnTnLxIX7gRLWW4pI+261VDu9j+czXO4MmuQiXFnXFLuLlZBqnzgkOy2TNJRJ
         jr+nSXC5oWd00y5jCdabX9RF/4bQXpoSe40wf1FcIUEQ8GvP/wVvMklJVpGRKlfAPPzM
         IN39zS1vSeUqTc1O2vJmYrM8bhpPZnNWZfIKxZLsmrMtvYL93kJEt41Xh7dHTNJbmU7S
         MGCeSk19nKkEatiIibmBQhiZHDoG3DAw6tN2DY1FCtnLMOWbxYxoUAW8Gaf4sTU0nZOe
         tkYN0Ca+jVLHQ5QbvHVxROAz+HbTEn0NHAJ6JM4cKf6QdiwaClJ2PiUaXiT751c8JI1W
         9Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769842550; x=1770447350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDLJXl3kO9WYLHYaAYOE8EZpw5zllMbrwjKTsjUtSuU=;
        b=LgbzvyWPhIxWcsAhpSJbRE0QX9r/PgOGNOJF94OzytNV3Iv3lni3x4S62s/mL3fPbP
         INYjn4gvU0mxIe6qUUHPex/T3qNc6kEYKvzTQA1pox/CifNjhgHQxQhTq5UzNE4zwtrP
         Yjg/ZQ9/c+7VDRT9XkzwuXIaSwjp3igpA4NAj/ChOlJZusO911jfdUzPOUHx4kcv8ejD
         TVnWn9gbo41UM+AgeLZMvFqdIe2NwxD/qSBYbcPDHi8EtfQ90rhL/ZuI8Zs3HXYHfE/q
         pGVU9OZV9tRGYEXuTtfuDflHVIYPM5MTN+qjVq9FZAinmenW5Rf3dvOQ6h0tTYdR2hHT
         umSg==
X-Forwarded-Encrypted: i=1; AJvYcCW65DM4mYrRyasrH3u6f1LUXi4h83IEIS9fSQBJMwxhCkmzeaTuOQhLPTT2JAowhvReHK+pWb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+RIyLNd6TL/nLjJswRwrqo6aMLHZIjIi+UMb9Sef8gMxeZ30
	X6mgJR3OaLCNTi4sDxYbipnhnmKjvxoj2Y76o8yPw6PZG9BwV5UFHeqq
X-Gm-Gg: AZuq6aLjGBBHs6ISeLks6Qi+ePJxM1m6Kj4awrOFAlaaNsDg17lvu7s+DYfQQq+gZpL
	C7VvJSO35uv3rOb/GEFYtVxihm97mAzQTQeN/T2lWVgR+tqkUEknqs+glCK7dHQKBu2KIYJY/v7
	5VULWUY2pEhwGGzj7OLay+onrbbGXypEWLNSeBQj16lVnnpujj+1mWdm2YU51cKPRDxbOX7EM6C
	k86j0ZAs76KRsiNgbpsholdJSXRK1izneN7IeqjYOSm7Z9t7y/irnoEoAnESF4LfBeRxDRFwBsv
	BGvqGji++LQs0w/Nkv8cnOonwcvSh2wDAseTurrumJYF+30PvTIop5V+U8a2LbXhKdP90Xfcbw3
	adJdFNnh4KmqoaJGhwUrG95SuWX/dkGcuk1vDqUQY7mIlwbrUeoe3Opsc6JNuJP38L98YYLGg8P
	0eZL/aB5xwj+00vmcOwxvJPaOFWZJkUpfFeA==
X-Received: by 2002:a17:902:ea11:b0:2a8:3707:d79f with SMTP id d9443c01a7336-2a8d96e3bfamr54830685ad.26.1769842550031;
        Fri, 30 Jan 2026 22:55:50 -0800 (PST)
Received: from localhost.localdomain ([111.202.170.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d9a7bsm92571725ad.79.2026.01.30.22.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 22:55:49 -0800 (PST)
From: Xingjing Deng <micro6947@gmail.com>
X-Google-Original-From: Xingjing Deng <xjdeng@buaa.edu.cn>
To: srini@kernel.org,
	amahesh@qti.qualcomm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xingjing Deng <xjdeng@buaa.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v8] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
Date: Sat, 31 Jan 2026 14:55:39 +0800
Message-Id: <20260131065539.2124047-1-xjdeng@buaa.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212932-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[micro6947@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,buaa.edu.cn:mid,buaa.edu.cn:email]
X-Rspamd-Queue-Id: 85234C1053
X-Rspamd-Action: no action

In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
reserved memory to the configured VMIDs, but its return value was not checked.

Fail the probe if the SCM call fails to avoid continuing with an
unexpected/incorrect memory permission configuration.

This issue was found by an in-house analysis workflow that extracts AST-based
information and runs static checks, with LLM assistance for triage, and was
confirmed by manual code review.
No hardware testing was performed.

Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool access to the DSP")
Cc: stable@vger.kernel.org # 6.11-rc1
Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
---
v8:
- Remove the redundant brace.
- Link to v7: https://lore.kernel.org/linux-arm-msm/20260129233703.407404-1-xjdeng@buaa.edu.cn/

v7:
- Add the detail description of how the tool detect.
- Link to v6: https://lore.kernel.org/linux-arm-msm/20260128033454.2614886-1-xjdeng@buaa.edu.cn/

v6:
- Add description of the detection tool.
- Link to v5: https://lore.kernel.org/linux-arm-msm/20260117140351.875511-1-xjdeng@buaa.edu.cn/T/#u

v5:
- Squash the functional change and indentation fix into a single patch.
- Link to v4: https://lore.kernel.org/linux-arm-msm/2026011637-statute-showy-2c3f@gregkh/T/#t

v4:
- Format the indentation
- Link to v3: https://lore.kernel.org/linux-arm-msm/20260113084352.72itrloj5w7qb5o3@hu-mojha-hyd.qualcomm.com/T/#t

v3:
- Add missing linux-kernel@vger.kernel.org to cc list.
- Standarlize changelog placement/format.
- Link to v2: https://lore.kernel.org/linux-arm-msm/20260113063618.e2ke47gy3hnfi67e@hu-mojha-hyd.qualcomm.com/T/#t

v2:
- Add Fixes: and Cc: stable tags.
- Link to v1: https://lore.kernel.org/linux-arm-msm/20260113022550.4029635-1-xjdeng@buaa.edu.cn/T/#u
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ee652ef01534..a669e4b2bb35 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2337,8 +2337,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		if (!err) {
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-			qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
+			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
 				    data->vmperms, data->vmcount);
+			if (err)
+				goto err_free_data;
 		}
 
 	}
-- 
2.25.1


