Return-Path: <stable+bounces-7738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977A681760B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541D01C2520B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00097144D;
	Mon, 18 Dec 2023 15:41:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9149890
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1196406a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914071; x=1703518871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihgdW/gDJcrHuevicGNvqmLm4tqkWrdx4iM8NZldVlo=;
        b=r4zUgkq4LbYBjnXUpoW6CvC2EEbtnbxREjt3CAUKQCTnMuj6+dQAcw9qqsbwF9WxtI
         fCpocyyAWx6U2ZZxPaRbjqZ5KCMGLzpDpuwdaLefj2fejs54BGD9mM2q0OpneD/ruTZD
         1qjYfBReswfbDM8uxWudEcY6exFXOfSAifoUwEkP4r/VvHkzHiy48BKg6yf4FR0/dawQ
         IsoGMkpE2L8jQk5t3VDDtQ2/9tjAYWIcsDpgt9AfrGcH0hnJ4iUc8wn2gt6xpLX6noib
         uJdnWCOif5WKwzVjbofeTH7ZhrrT55D2ZrfTixghlxYJ4UiWiBduWZkvYbb/f4Et/a1n
         i68A==
X-Gm-Message-State: AOJu0YyqRudTIhCTloo9U1TjmkmZiapRCK2iAopSZy5zGlBak5OQFN7V
	pyjTEW6w5R1ysKNU7jqBt7Y=
X-Google-Smtp-Source: AGHT+IEJuOqEKu0W8gG1nctuRFk/1WjkePQqwLRmoJCl0kCoQK2Inkdq5tRvvZJSjwABd9NPRIiSew==
X-Received: by 2002:a17:90a:c7c3:b0:28b:7ee0:4ef0 with SMTP id gf3-20020a17090ac7c300b0028b7ee04ef0mr704405pjb.39.1702914070745;
        Mon, 18 Dec 2023 07:41:10 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:10 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Lu Hongfei <luhongfei@vivo.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 109/154] ksmbd: Replace the ternary conditional operator with min()
Date: Tue, 19 Dec 2023 00:34:09 +0900
Message-Id: <20231218153454.8090-110-linkinjeon@kernel.org>
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

From: Lu Hongfei <luhongfei@vivo.com>

[ Upstream commit f65fadb0422537d73f9a6472861852dc2f7a6a5b ]

It would be better to replace the traditional ternary conditional
operator with min() in compare_sids.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smbacl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 8fbcc6a8cef0..a8b450e62825 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -97,7 +97,7 @@ int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid)
 	/* compare all of the subauth values if any */
 	num_sat = ctsid->num_subauth;
 	num_saw = cwsid->num_subauth;
-	num_subauth = num_sat < num_saw ? num_sat : num_saw;
+	num_subauth = min(num_sat, num_saw);
 	if (num_subauth) {
 		for (i = 0; i < num_subauth; ++i) {
 			if (ctsid->sub_auth[i] != cwsid->sub_auth[i]) {
-- 
2.25.1


