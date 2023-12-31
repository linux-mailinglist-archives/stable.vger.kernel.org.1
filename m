Return-Path: <stable+bounces-9044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8D8209FD
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9398D1F22096
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622C17C2;
	Sun, 31 Dec 2023 07:14:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F117F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so6275155a12.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006859; x=1704611659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YS0B25yvCqXJwWDBK8oFm99uQ90yGySPfFixtqgAcFM=;
        b=nc8FQ1MBOhhmbFMWpkH887i6qDJ/J2t75OEAR1DbM2BHBP0cCSChv9RgMsKw0C3mi6
         IJ2QM6N2yLOotRw0hzpfjMpnD6sRFSQ+Lh1HIpEqqL0TUa8Aq6pQGMfeW/Zlau8ed4kx
         rddswQK6Qhs6oP/EZMKi9vlL1hRVv+1CjGWHwvo8KXPjCWBWj105nudLwB3IDeVYidbT
         l7JdJS+C5bD78Q6Bgr8p5TgWQoDxBNmB/PAt4q1xrjMNpC6sUgheEmgFJ+AEU7XW4n7k
         DZhIkIiVVF8SJm3I0OGSAsn3CmxIm8S/c5x99btROUEM2Xi4fVPgU2y5Ci6zH7n90Ibq
         1p8Q==
X-Gm-Message-State: AOJu0YyHu/ZwFg5wcZmgh1Sk4UmCjfYzVCZGo3o8I0WzHH/fGnKKngBE
	11K5u3r3ED+VTGNjFhAYpQ0=
X-Google-Smtp-Source: AGHT+IEMy7hJABCQuWFsaTlNECCpP5s5UeyRAFMeE7KjPmNg/d7LZKfD/n0DW5k1WIiDZn13orcmaQ==
X-Received: by 2002:a05:6a21:8185:b0:195:573:ce4f with SMTP id pd5-20020a056a21818500b001950573ce4fmr17831174pzb.20.1704006859079;
        Sat, 30 Dec 2023 23:14:19 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:18 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 10/73] ksmbd: Fix spelling mistake "excceed" -> "exceeded"
Date: Sun, 31 Dec 2023 16:12:29 +0900
Message-Id: <20231231071332.31724-11-linkinjeon@kernel.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 7a17c61ee3b2683c40090179c273f4701fca9677 ]

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index e885e0eb0dc3..ffbf14d02419 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -345,7 +345,7 @@ int ksmbd_conn_handler_loop(void *p)
 			max_allowed_pdu_size = SMB3_MAX_MSGSIZE;
 
 		if (pdu_size > max_allowed_pdu_size) {
-			pr_err_ratelimited("PDU length(%u) excceed maximum allowed pdu size(%u) on connection(%d)\n",
+			pr_err_ratelimited("PDU length(%u) exceeded maximum allowed pdu size(%u) on connection(%d)\n",
 					pdu_size, max_allowed_pdu_size,
 					READ_ONCE(conn->status));
 			break;
-- 
2.25.1


