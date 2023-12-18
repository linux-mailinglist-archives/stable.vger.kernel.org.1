Return-Path: <stable+bounces-7671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530828175B4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96A7B24665
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE45B4FF6D;
	Mon, 18 Dec 2023 15:37:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86059498B7
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ca0b968d8dso1010696a12.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913858; x=1703518658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a64S9vmnlQ4g22DZcGTd4xN4rxPntc7PKcLfF+UHHn4=;
        b=hOhPImLlacYIjJrNd39s07l0b3oLsI1W/K8SKpm5YUWkXLk0tkLHk7Nwz20SiG9N94
         wWAvTwifVmvQ5d5FUHESveRtQD/gL9cpKF3yfVyjm6ubwSGD6ek2EY3nnXlxfZZoKlpr
         3nW3Mxup4LIMADS93Jz2R52xRF0PxEhx0vTAm8VptpMguLCXBzFKnqZ3i80fuXKZXfDX
         0gWjODu68j3JVeb06+AKTOeonQWGLAowM3GQT6FgaLGkJA+fryofEZTt/f5/0QbXGB/1
         zKEL/HRIFrtSFDRA7UzCW212z1G4NfqDnjzd/nR2GpObLl8ttnl7ci74iM3HlPXncu57
         P2tQ==
X-Gm-Message-State: AOJu0YwEQoT5qRDIw5AeunB1GTtBbilAS9hzmnsuWdn+j0J680xUu5+4
	DVDde2e+L+B53NCT1Vox1cs=
X-Google-Smtp-Source: AGHT+IGD+vTCMCSyp+Ta9W+4B+7pQqF6Vz/vBXRCYQWQfLTJlj4FxTMHqlWh8YEm2AIl2pU5PHxRaA==
X-Received: by 2002:a17:90a:de17:b0:28b:9660:459b with SMTP id m23-20020a17090ade1700b0028b9660459bmr525682pjv.87.1702913857258;
        Mon, 18 Dec 2023 07:37:37 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:36 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 042/154] ksmbd: smbd: Remove useless license text when SPDX-License-Identifier is already used
Date: Tue, 19 Dec 2023 00:33:02 +0900
Message-Id: <20231218153454.8090-43-linkinjeon@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 06ee1c0aebd5dfdf6bf237165b22415f64f38b7c ]

An SPDX-License-Identifier is already in place. There is no need to
duplicate part of the corresponding license.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index ab12ec537015..7bac4b09c844 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -5,16 +5,6 @@
  *
  *   Author(s): Long Li <longli@microsoft.com>,
  *		Hyunchul Lee <hyc.lee@gmail.com>
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
  */
 
 #define SUBMOD_NAME	"smb_direct"
-- 
2.25.1


