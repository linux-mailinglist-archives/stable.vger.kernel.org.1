Return-Path: <stable+bounces-212823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPurJSvve2keJgIAu9opvQ
	(envelope-from <stable+bounces-212823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 00:37:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC5B5B8A
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 00:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB131300615E
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBC5376BD9;
	Thu, 29 Jan 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrYMvPdm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDA136AB5F
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729833; cv=none; b=NHud0HgOPGRcpcTeIvN0K0eplvYUtxUaKPqPtxCH3bzdJapJQh9j3yAQRjO4jGvBHRnDYFUT6x/ujlCUiQBvrzCYei2HHtuPC27ddS3ZLe+IzIVHSCV1aVy+GdVON9r4KCX2NLlr/l0MbJ71VgovRavBvU4jqLE7cKgFJCu8VTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729833; c=relaxed/simple;
	bh=n57vfxcyYsqejyOw8je+0D5WTFziz1fnLyQKVj/lanM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNBBYatT7aBA4CHUE5gxpWUv9VOQDQ6CE7AkTG3vyWb7NL4IW+P6R+0UsT+5t+w0RWdH8smOKqh6QmIHkSOXUZVG1IjPJqiiDNQjx72rXmVYkS7t6xF9PlW7MX0FTxWrUuYJaqMTgi/iTucv3N1upUQ9BzrvQZj2/2pTxTa+czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrYMvPdm; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so768297b3a.1
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 15:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769729830; x=1770334630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HFIOgnH6m/Tp8biSOxBgIzwBRfAedBPa4QLS4k9B36A=;
        b=ZrYMvPdmrtG14eU8IQPHlMH5z8pFom9XEEq6aKScBNUi3X3RWYHoKltOdPvjFfWlkm
         sJQelBBvKsrSJpcoCQzAVBIxFE0qFNXZedFxj1tp/6sUSwKMX0oC2g+z+FWtyYmbeEZU
         qewvKaWTSiWJMqowB1XuK6Z3HXyfCoaxjDEwvmR3p6tFRFLvBqAzPJLF4dhBXyHExKMn
         FfkI1DY5W6nqKRssFzx+vDT8Px/bBm3QHA9dnVrx2cjV2IWKNsSBiXKAga2d12S55w91
         iHyNaUj6VbYWipDqqd4RExHG6IcNMLZhDj3Gpryvkce4Jc9tTMiLD+t+xAjC/Wi0FjNs
         OpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769729830; x=1770334630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFIOgnH6m/Tp8biSOxBgIzwBRfAedBPa4QLS4k9B36A=;
        b=lJkCJFNd3LpMR4a2ocG3zBFYdZnKf9f7lNUl1QGHg2nbgoOwv5N3pC31bTeYrhaJHb
         lh+85evum5fE/Yyhr378rIzSargY8RZKC7BHnkTW7ioiYScGR7JoBrbbAE+ip5yw9CUI
         dSD7uJgWnNyJcoOZi8AjgZu6z+jfmzefXYuyiEWH48wYZHe1gTvpZozf3Gu+uU01XxGA
         pqPEWo12oCfaPVevi4iZ6nk9SR95ab/K6lEhlmdRL16aA5zGdjuYqwaJJr8rchVqZJFC
         poM7grDiefw1D83VGRNyB4imSmBqa7xQf8M46wONgyho3PD1NLwY/fMl8g3y18t0wJAv
         FwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW77p5IzBfjcmIWYDWUGQiM+AXtIagCzySN/FXXrYOGL0XFarjaByEfykmxituHLiZz8Ya54rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeu9UkvmXIKMejVuASzbF3SKj71m8uo8J7gDPLacAUvoEb2Ji
	70+k5CEe6E1/4zpMpk7DxkIopaY9D9JwWH0JWy6X16mffJidUOrWHQiJ
X-Gm-Gg: AZuq6aJ+9xZyByKSleVJmQ7ywQCfjPkKf+4dWuQnWzl5y91ddRCwoEMGbSHdgm6Acst
	6Qta9dDzwM8AkujElWhbF+SY3YxPL/FkUzXw0HXZBAPOnqZ3IXpkc1I/9cOBdcgg6aG655lcO6H
	BEeEYNyuWzhQhYnqZoJaiZSJLDDgyGtA6t6gmwahB5iro75OEr+NrXRVgFBd8dguQHMzV6zs9VF
	SGE0/s5nXHC2st9FcEqPyEqvJKOPwjExQ7aMKSS9pwb1oJu9M4wCYDE/QkDGM4N2WyWN2Oqxi2/
	61sCWHr4hTRhr8fIT+8zb6fhkTTJ6Mi72vxaHbID5VeTOdlu6GjqZBijNggGAh6cYDeDi4KP6Wd
	iESeAxLU6atJsiHqo6i8uiEqr889G5GiX1LA1VDTwI99NUOEEWo6lDriZWITuReICDVn1ltUIts
	Tp8ABVEBfSPgMshj85tx83
X-Received: by 2002:a05:6a00:8d87:b0:81f:4346:6870 with SMTP id d2e1a72fcca58-823ab695dd1mr915423b3a.28.1769729830385;
        Thu, 29 Jan 2026 15:37:10 -0800 (PST)
Received: from localhost.localdomain ([1.203.169.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c5293dsm6256794b3a.61.2026.01.29.15.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:37:09 -0800 (PST)
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
Subject: [PATCH v7] misc: fastrpc: check qcom_scm_assign_mem() return in rpmsg_probe
Date: Fri, 30 Jan 2026 07:37:03 +0800
Message-Id: <20260129233703.407404-1-xjdeng@buaa.edu.cn>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212823-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[micro6947@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 40CC5B5B8A
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
 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ee652ef01534..8bac2216cb20 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2337,8 +2337,11 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		if (!err) {
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-			qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
+			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
 				    data->vmperms, data->vmcount);
+			if (err) {
+				goto err_free_data;
+			}
 		}
 
 	}
-- 
2.25.1


