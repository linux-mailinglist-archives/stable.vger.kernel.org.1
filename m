Return-Path: <stable+bounces-9072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE0820A18
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8031C21739
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828B317C3;
	Sun, 31 Dec 2023 07:15:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6A186C
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so760430a12.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006957; x=1704611757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtkWeD7Zfh22BNnMwbzruMgQ/X4TraLdfwixc1/JK70=;
        b=T0Li6WCNM/CqcTydfuapJTV8SKitgj6x35Vv65wDidVXyCwmcTnAX14wqpheF4n432
         wDJR6ulJAqj9A3KYF2IyvnWvCbngjuyEdwG7AnS+fzShVcryuNuYA4pOmgoWaJGPmnML
         XlKbuhySEqfmz1SiSbNNNXzdDTOHGMjXgjYqyUzjPRTTk05lcmnk32fX1kSbcJGm0xJ1
         ijXHYm+b8PYvKw3xg9qd87u9u9CuaBSoOgRsO2DjF9uipbNFtYAvcEi9LFrpG9mbbh62
         18moGEsOfLOIwwk9QFmBRlfnftrYpMpa8i/8+IazE45aKfS6NCKIjTj6DpmVcgEmwvrq
         c6uQ==
X-Gm-Message-State: AOJu0YxHo9W/vszmBdi/AmoAU2whkVAUnXz2Veof9AykAJktOjo0fnPe
	fPcNe2/6ZmCjw/ckMgaLXI/PSBrlEPU=
X-Google-Smtp-Source: AGHT+IHlWXLvdDoYvOxULCE3/Xf9RZ03d3Jwr5tLQ9hY82bdGTG33Y3QlSf6agr2vl84pfzN30//pg==
X-Received: by 2002:a05:6a20:1f11:b0:190:199:ba05 with SMTP id dn17-20020a056a201f1100b001900199ba05mr14067220pzb.60.1704006957571;
        Sat, 30 Dec 2023 23:15:57 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:57 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Yang Li <yang.lee@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 38/73] ksmbd: Fix one kernel-doc comment
Date: Sun, 31 Dec 2023 16:12:57 +0900
Message-Id: <20231231071332.31724-39-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit bf26f1b4e0918f017775edfeacf6d867204b680b ]

Fix one kernel-doc comment to silence the warning:
fs/smb/server/smb2pdu.c:4160: warning: Excess function parameter 'infoclass_size' description in 'buffer_check_err'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c942c30c4427..21e3cbd65911 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4156,7 +4156,6 @@ int smb2_query_dir(struct ksmbd_work *work)
  * @reqOutputBufferLength:	max buffer length expected in command response
  * @rsp:		query info response buffer contains output buffer length
  * @rsp_org:		base response buffer pointer in case of chained response
- * @infoclass_size:	query info class response buffer size
  *
  * Return:	0 on success, otherwise error
  */
-- 
2.25.1


