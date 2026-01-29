Return-Path: <stable+bounces-212824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDiwD0Pwe2keJgIAu9opvQ
	(envelope-from <stable+bounces-212824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 00:41:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ADCB5C0D
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 00:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62C5300F9CD
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 23:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE0377545;
	Thu, 29 Jan 2026 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu73z/HU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1B376BE2
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769730108; cv=none; b=jXu3keO/a6i3jXvKNhXyc0QGp/w3Q1GLwmAP6+zsecuAg2iAvjOaMfbogt+UIfwVGVHz7TN15iNnwmt6xUjcj/ri6RKnNTVOV45uqHblPtTOxZW9t1fKZ2POa24gCgNVkIEE637AQtNXComHAPw8fqrFUpLT8FX6PVlGUgdLC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769730108; c=relaxed/simple;
	bh=QH1FbRZ5O40aoaT0YcL+3+LXNJuDKiXP0TiGLPkfKQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lkk0s/TIj+eMbbvUKaZF5XLUVfTKDpUYQAPNtoJaQ08hL3Z/2JNyMD32h57w/eNcofpDJPigsHrDlvRXq5zqwExwz39fF/Fml+T8KukzCOo9mG5ZmlIoCs+Y0flhycioHAgq9e4oUlZoewjbxuUJZxl9kSKe3znFLubSkl0Cs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu73z/HU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso898327b3a.1
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 15:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769730107; x=1770334907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=98ySn8T1ILY+Jx5xtFPY1cgInaA1UDWQE/WcppunKN0=;
        b=Fu73z/HUjFtufY/zpO5/SDK3R/kR9P8KYRnukmpUAVUOhkkgw25Dtk0f9Ljzg6mxw+
         lvcnKiusWj38dPiCoyGfXLC/WKNY/ofjBKK2+eoF8gU5MArPPjJi1SaNrtxHFzh3AYWz
         XnSMQnELgLUylsC97gtFCfUXBOUMnivZ9bfKbVLMMau3TRRJtwE9QaJa+CeMHdX8wiSg
         iwyg7DVrXQhiQKTIbeMn31fK2WemwFsLqYpX3M7GbKxZXsK/ORxDoCywjQ0Xd/pgnFMz
         n1fuA7uLXry3KMi61un8qEl3px76fQ/VKO3+Q1SLa3CE1xFMDUgtpbS+raghZipceoOq
         NhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769730107; x=1770334907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98ySn8T1ILY+Jx5xtFPY1cgInaA1UDWQE/WcppunKN0=;
        b=OFYd6CuxJuy/qZ1JUN5O+3wPw5gDgVGka2DdiOFzgQihZ+o6DMMJm8dBfHQ/iY9XkS
         hQCj5kPuKA0aiOjK73guA25s5+K4d48t7YcT77VBvugkgcXY1+8e7gvPGvdBHomWdjxm
         pOD4bVRslaV9hvCrsDE3wQOauxCkUxO4xG3h+YRu1MebTaFOqtLSgfc7g+YZqdTz9FY/
         3DnF883K5otVF0CMfM6RPYUBr3hXZKNxoMqoWh4SMJ7TkJ22XkmAMN+jQdRDnN9MFfBU
         j9RYf4UCQTNYYGZcoNR1TuFxrLHS/3GIIsbwT9gkj/NxaFZmZdPmvCmHzKutwhtfmr5T
         oA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWNAshGSXn3ifziPXrwXaurZ9b/hrkJvruAmNAsExz9Nk+lZUpUoG1mFPhemQlBrS2Azdj3Og8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxslj6cI8w9C57AiQbC+Y7VDSIRjmQOa/vTU9ZtTBMDxpeAi7B9
	yPPaiLGOViy/0OVK7D0IGoOXqfAh3LwVRx6mUGpL7h7TzvczsxtJuybD
X-Gm-Gg: AZuq6aLL+Cmsu2bOWPSPhiSjQQ6PCvq5xw0igjymOdaiST1z1i2Xlwy89VYV+B04uJW
	qTnvcE40iSkhk6jBc0pt5c7ku+bz4Qx0Eo/+NGIEJZ0fJLipNS2VFRud23e+CTORQTz1yY6dCBA
	QDWmjeKyg/KLnmAno81NkZIvdCmsRxbu0hK6/GqH//QI85Q/ySnGyrVDBTR/izOgq7IpLwV75e/
	YvuxrbYGw9kckTk5p89Q2NxjSaL3ZCAwN8ORKj/+xqSlJSahEMS/MT4VFdEvlwNP3BIomph4uzQ
	dsVFycQJEQM9q/ecGrNiHrJyvafeYhPU8CbCLUx7PRkwUrhWEPIFT8teHh+BvGZRLyiEVEspYcM
	Vls30Qhs/hHGSV1nUxovQNg9+C2B0QBTNs6m8n8DHoYPRHhL23vTW6nDnbTIDpXBnNb895DMGxO
	aXqkyfcJlFGiIU3Q7EVsbITagzy8e1cyU=
X-Received: by 2002:a05:6a00:39a9:b0:81f:be3c:37e4 with SMTP id d2e1a72fcca58-823ab67bc4cmr780481b3a.27.1769730106458;
        Thu, 29 Jan 2026 15:41:46 -0800 (PST)
Received: from localhost.localdomain ([1.203.169.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c54d4dsm7397903b3a.67.2026.01.29.15.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:41:46 -0800 (PST)
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
Subject: [PATCH v5] misc: fastrpc: possible double-free of cctx->remote_heap
Date: Fri, 30 Jan 2026 07:41:40 +0800
Message-Id: <20260129234140.410983-1-xjdeng@buaa.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212824-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[micro6947@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,buaa.edu.cn:mid,buaa.edu.cn:email]
X-Rspamd-Queue-Id: 99ADCB5C0D
X-Rspamd-Action: no action

fastrpc_init_create_static_process() may free cctx->remote_heap on the
err_map path but does not clear the pointer. Later, fastrpc_rpmsg_remove()
frees cctx->remote_heap again if it is non-NULL, which can lead to a
double-free if the INIT_CREATE_STATIC ioctl hits the error path and the rpmsg
device is subsequently removed/unbound.
Clear cctx->remote_heap after freeing it in the error path to prevent the
later cleanup from freeing it again.

This issue was found by an in-house analysis workflow that extracts AST-based
information and runs static checks, with LLM assistance for triage, and was
confirmed by manual code review.
No hardware testing was performed.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
---
v5: 
- Add the detail description of how the tool detect.
- Link to v4: https://lore.kernel.org/linux-arm-msm/20260128042600.2641857-1-xjdeng@buaa.edu.cn/

v4:
- Add description of the detection tool.
- Link to v3: https://lore.kernel.org/linux-arm-msm/20260117140959.879035-1-xjdeng@buaa.edu.cn/T/#u

v3:
- Adjust the email format.
- Link to v2: https://lore.kernel.org/linux-arm-msm/2026011650-gravitate-happily-5d0c@gregkh/T/#t

v2:
- Add Fixes: and Cc: stable@vger.kernel.org.
- Link to v1: https://lore.kernel.org/linux-arm-msm/2026011227-casualty-rephrase-9381@gregkh/T/#t
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index ee652ef01534..fb3b54e05928 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1370,6 +1370,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	}
 err_map:
 	fastrpc_buf_free(fl->cctx->remote_heap);
+	fl->cctx->remote_heap = NULL;
 err_name:
 	kfree(name);
 err:
-- 
2.25.1


