Return-Path: <stable+bounces-208211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B244D16567
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 03:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12003029E96
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 02:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470E027E06C;
	Tue, 13 Jan 2026 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzJSVUGv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EFB1D5CEA
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271930; cv=none; b=V+15O1KpYlTWb8utHmX8KPaCRdlg5KaKL5pxqpQmLfuXN50MaYtRmNVBtE6nBOxtF4VUkSKtQrdl+8zeVrEak2rhP3vDwX9T7QZMl6v7Q4KqQ6Iv3ps2SJGxFhJeY/eycaGuMU4Me/dM4eLnAd7RwMkSBkTU9TBVKWuPff/A1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271930; c=relaxed/simple;
	bh=Dx0pr7PBlvHCrcUw3Vab+kZTW+IOFxvrhGBGPEy92ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s6mzvJ/ZEZtbwUvHnsiaMhoHB5POm/TwzzPO1MMHXZ6E7Ch1x45yYvnv/p0cEaMIGZcF0PGyrwcuUSP/6Sw6vebK88ZPv30Dto347NBHuwaU8nnGBbCYwNJ/VTO0gGXyNwIHX+lU3Be8AF4zvDswHmRjprD6l6MJNfZ6kK9NPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzJSVUGv; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso4286442a12.2
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 18:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768271928; x=1768876728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyucI0YH7MG3WfHl/qzA6deXC4xj1ffZFIfXjqoMq40=;
        b=HzJSVUGvixbrj8Z6RYzmzjKX2uUE60mhnU08jrIGUwl/5jXGzGttHKFCJg1rh/2AtM
         EdL/BI/Povc7ybfGP88tRvi4F5sD91pv4rw9FhW8l38ZmyIrpYGff/vhOdptd+CmCSga
         knmgqu9fgVNC3NJk2rzb7FRrssBTYdO1aPLvtcLEQVsfoF53OF7RDfSpG0doBhU7iyb/
         TN8qHL+vuUqP71bEQgqpjkwIsxQZG75m/xJghBbwdB/FMWbEk94LP5OMWRmXimiWk3zh
         B55uju3CwgKZGO/kt86c+wDRGCLfzxXUrFFATm855Si/H1iyzdA+775dkTgwsM66xat6
         guXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768271928; x=1768876728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyucI0YH7MG3WfHl/qzA6deXC4xj1ffZFIfXjqoMq40=;
        b=rlFQg/oZ5qrVHamn5nu07a0y8vngC6Bqyj5JkUZXAAWO72t72Jwi6H0hk1lznPsR/1
         1CZahuOiPW5u3IBeWq6TaENRUFSPn3fHeHi+cJevqhX5O+XwY1uUK025qMfpDWsgjGz4
         w95Lm66y10mxr43V4eK7e1rJsbIdnNnPuHvBWEhHWX7eTwlMzdDXjtVJlMFAK5ulcNol
         0IytBpzflL4TzCnDNGSLntXAro0EAmHAz5qPRnV4nuQzgq6Snh+3KrWA3BDgfHMURBAP
         7LD6+8iqfssnhZKzA4jSpip82sUjWTnZtq+bLF7EHNDSefTA846YNBNaz1zO2zIMZCVC
         MkgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwu+PmTlKgFMInPy+v6CiamlV2LyrAGoy4g6UE1muULozR9BkBR+4n6vBRzmHSrVlAKNomA88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hk6/tdMIhC5KcOOtB9DJA/mDsQZbBRKnMAB6VOWFZvLse4cK
	//yx/zvspeqGrExSDwrYVtBx3J9iLwAK3DZPvziwwxi5seQt6lvoSp8t
X-Gm-Gg: AY/fxX5DEboZCaTHjHSk+DsMdBBwRXWmZcpSaLCIeor4mn96uv+EQeL46GDFuvWEWYt
	degiLpM7UxWLInB/G5H0MJluNySuzHIRaJIZT/+GX2gmxpDARdRZW26KOycbWYUKJqxIz/UuDYr
	ZAOgLtV9IIxHWWCcH238lgJYWdrIMl3nbtCwL4LmdwLuXbrF1uaIb+IgTNeJr/nzmNTTDOiXxgU
	0eB2uE+WBIAv3otYKu9B0yuNH3HiuZMmAInEQJgGJyL6Ya1ER2rT/RRuRP6n6HaWCvjAQBeMWA3
	EgjaJuadPqi3y4gIokJgBjL8Q+Lsr7mEdLA5xUo9Ivc6wkexNaO64Z+V/91qBWolPXkDzPLqKMy
	NvhzBho05rXGanuxBTx7fECJJhHhdt4w3gjG+dbLHik53b9cPYR+XvFAVJi5+SLoV/gpQFkMNsa
	acXCz1a/Mbn8BLsxhTAWhAT48=
X-Google-Smtp-Source: AGHT+IHRJPGz8XR3WjiNhMWGuhhCzTmijR2cafO3T+hWG74VDUwGnsCFbiMo83oXcnyoYAY+ItE+Zg==
X-Received: by 2002:a05:6a20:6a21:b0:35e:824a:dc57 with SMTP id adf61e73a8af0-3898f9915b4mr19710567637.37.1768271927906;
        Mon, 12 Jan 2026 18:38:47 -0800 (PST)
Received: from localhost.localdomain ([111.202.170.108])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c57a50da1a7sm7819559a12.36.2026.01.12.18.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 18:38:47 -0800 (PST)
From: Xingjing Deng <micro6947@gmail.com>
X-Google-Original-From: Xingjing Deng <xjdeng@buaa.edu.cn>
To: srini@kernel.org,
	amahesh@qti.qualcomm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Xingjing Deng <xjdeng@buaa.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
Date: Tue, 13 Jan 2026 10:38:39 +0800
Message-Id: <20260113023839.4037104-1-xjdeng@buaa.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
reserved memory to the configured VMIDs, but its return value was not
checked.

Fail the probe if the SCM call fails to avoid continuing with an
unexpected/incorrect memory permission configuration

Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool access to the DSP")
Cc: stable@vger.kernel.org # 6.11-rc1
Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>

v2 changes:
Add Fixes: and Cc: stable@vger.kernel.org.
---
 drivers/misc/fastrpc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index fb3b54e05928..cbb12db110b3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2338,8 +2338,13 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		if (!err) {
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-			qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
+			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
 				    data->vmperms, data->vmcount);
+			if (err) {
+				dev_err(rdev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+					res.start, resource_size(&res), err);
+				goto err_free_data;
+			}
 		}
 
 	}
-- 
2.25.1


