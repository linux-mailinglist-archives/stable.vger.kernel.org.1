Return-Path: <stable+bounces-7767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A233F81762D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5841A1F2536C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA073D568;
	Mon, 18 Dec 2023 15:42:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6673D540
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b0c586c51so1363616a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914165; x=1703518965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ppfOdwAQXFnIjGhX8inOaQUCaKg1H33wO912cGr2Vs=;
        b=g1WOJIJT38Yku1aO1ui5/mxg+hVrELAMEWCFGi3Uc6Mh9vku7P+OBuDZbdrHPQhaet
         YUscQpzJnaG2WPK97F5VFKs3fZTqBBLKdRVtwosZLDfQ5s3uHPVTqZtcQdDkL/BTVQXf
         JOalIbq3iGAB1EZ75FY+axEaR7Waqzqc677YWKTNnaBrwRNyteyYb8YF0aqLVR/SH+aT
         L5bgmw7hSHVwKVylomshGHdDTuH1FgTCX/l4w//k88igEm6lXz4Ui754FIhOYqu1d/UY
         tpgIE0UHRY8fppXQ8Th7OptC2r5MoLU7z0wxDay45MKtwdrQMhkHmEZKKTOcKTP0yynE
         5E4g==
X-Gm-Message-State: AOJu0YwsTifRVhcOrL3Px5G1sZqauyFMiMhb0yZUT9H+Pmf07tS9gwAo
	uxMxl9Vhg+LG8hy1i1BLIVI=
X-Google-Smtp-Source: AGHT+IFt5pscBqRAPkS57KHyI5XNEBHJ/yscYh+g3B+f2USoGQ4borw+ZR50CLN6NnuUtwIz5WH9Hg==
X-Received: by 2002:a17:90b:3689:b0:28b:88fe:1466 with SMTP id mj9-20020a17090b368900b0028b88fe1466mr713219pjb.64.1702914165314;
        Mon, 18 Dec 2023 07:42:45 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:44 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 138/154] ksmbd: fix potential double free on smb2_read_pipe() error path
Date: Tue, 19 Dec 2023 00:34:38 +0900
Message-Id: <20231218153454.8090-139-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 1903e6d0578118e9aab1ee23f4a9de55737d1d05 ]

Fix new smatch warnings:
fs/smb/server/smb2pdu.c:6131 smb2_read_pipe() error: double free of 'rpc_resp'

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 19cee16bb3eb..8dad33251925 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6154,12 +6154,12 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		memcpy(aux_payload_buf, rpc_resp->payload, rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
-		kvfree(rpc_resp);
 		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
 					     offsetof(struct smb2_read_rsp, Buffer),
 					     aux_payload_buf, nbytes);
 		if (err)
 			goto out;
+		kvfree(rpc_resp);
 	} else {
 		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
 					offsetof(struct smb2_read_rsp, Buffer));
-- 
2.25.1


