Return-Path: <stable+bounces-7754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87A581761D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EB6281AA2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5301B498B8;
	Mon, 18 Dec 2023 15:42:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAE74E0B
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cd870422c8so443893a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914123; x=1703518923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CM98fRmYCuzoiQA2zFotS21sK3JgajVByra9JR9020=;
        b=wMnBH5NYfuJXg+GyGkEOoowxk9AywCkTzJtBKjtzJNtbu7DT0Rs+IXmUAT5BbOt+ho
         WSYNAp5raMM/RraEkbl3Ve1O5uCb/5/98ZhDnftcwo0kA5TBubij5UGMfLF5RUvFzGDP
         Y1WZdmuBWDY3m3eQ2JY3dbFsvHmoTO6udeFDiCpUGaFPiMixQxJa0YBNFYYTqn28/El/
         n0noZ6YNe/UxZ5qHto9MLQVPz1CsbPTPg898cpYhmNen8y/PKTUMnlx5HnqBquSAJln8
         81onV43SCKpez9qJzbaJ0O58y+SHpjEBNH1XlQwNRUS8O3PUwKx/1BDDnWvSForPR/Vw
         Tc0g==
X-Gm-Message-State: AOJu0Yx7G2ADQqbpvizAFBNN0V7uWWoESNdFUvvFWzXkg4e9s/rz8ZmC
	rx1K8Eiuo2rJU2WTTdk4ePk=
X-Google-Smtp-Source: AGHT+IFjWomlAP8MLWzqnO5yw+2wjlulddgz/YS0WmSszj7Y8KNQQ79CzlXvlC6b6qkAyIEENjEVjA==
X-Received: by 2002:a17:90b:1d83:b0:28b:8034:8a98 with SMTP id pf3-20020a17090b1d8300b0028b80348a98mr694057pjb.3.1702914123011;
        Mon, 18 Dec 2023 07:42:03 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:42:02 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 125/154] ksmbd: add missing calling smb2_set_err_rsp() on error
Date: Tue, 19 Dec 2023 00:34:25 +0900
Message-Id: <20231218153454.8090-126-linkinjeon@kernel.org>
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

[ Upstream commit 0e2378eaa2b3a663726cf740d4aaa8a801e2cb31 ]

If some error happen on smb2_sess_setup(), Need to call
smb2_set_err_rsp() to set error response.
This patch add missing calling smb2_set_err_rsp() on error.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 67eb41255903..ef3878bb313b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1904,6 +1904,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				ksmbd_conn_set_need_negotiate(conn);
 			}
 		}
+		smb2_set_err_rsp(work);
 	} else {
 		unsigned int iov_len;
 
-- 
2.25.1


