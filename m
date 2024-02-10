Return-Path: <stable+bounces-19410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511D4850630
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1791C2848A3
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8DA5F849;
	Sat, 10 Feb 2024 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="awd/Oy3u"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6C5F544
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707595595; cv=none; b=THU2453ea3UQIVI13rXxOHXzP74NqOKPJkE4YzcokUJSsg/FHQ5kQXPbAX6IFwRv5CNGN+wOPWl+R+qxcWlPs1ngD1xPp87mdMGplMoxBgMDRY9+Vt8QHJZ+/ZnchvX90GhLO95yhB/OZyIHAAd1N7pSA4doRHl0TtvbOo50y2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707595595; c=relaxed/simple;
	bh=2vUiRIb0piGHmtgmNdeIDbJoqmjblGsP+40d7rVeKAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fo9xc7e3PfeAdJIWisqxUU7IQeoUBZMKMyd6La+S/NnWtQL8HzEkzyIfRqe7jrXHktJdll4tVYIgHzAstA2dSa+wp5FIUnBCPU/k/KFqoWqiqCUurTUJdJbGohua8mxEk5yd29tLlfvK68l29Y/RaNi7I65R2b2DKuBnron/cH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=awd/Oy3u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d8da50bffaso10724385ad.2
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707595592; x=1708200392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlhmrKiKAGalJdATQ/6ckbPR+oMjRjyiB7OwL3wZQqM=;
        b=awd/Oy3ui8GaPC3c0oV/2fFz36pUN0SBz+zw+SMECOhBej+7YWjQgjiAdxOMorQRjx
         SZqxKtb/Tu/Hgz1Xqas0j0k5iYGJJsMbJ4kvzYO/AQMnOcPfdTNMijil+ZaTjnbCD7RE
         Gsa+uJsDI+jMuNbxSJ54A3D++7BWqyj46zG1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707595592; x=1708200392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlhmrKiKAGalJdATQ/6ckbPR+oMjRjyiB7OwL3wZQqM=;
        b=d7BeoLbk9N8Js6yDS8v0cxiLzHAjPX3QJ2xCb1LjOGUPBpQJ3qTx5fduDFU7JaM/7U
         vIvgYU6vzXWSWn1npXTVj9PpCcOETF7DcmH4mkObCXUag5869tCyQYA+IwprlPZbBTRc
         aBrnzksP8ujX6mTrxoH5ypshN7BJ/VNESd4lZWwTYj5ahGweywdQHuc8TNKd/S+5goe7
         sgRYN0W42tdQAVILoOrYvu0vMaOteqxs+BxexaOuFzLcw2SuzhGmFV0fWtQ233wk23kY
         2epZs8YFVghRbHDlvk/ZlKK81R+wF6AgrHNh9uxA/yQ+0E71jh8f5CW3d2cHlvdkjm3P
         AsOQ==
X-Gm-Message-State: AOJu0YxEe2UW1gti5VBE1iV0ZoNSrLQ/2ovHiFSQopXJmIAafAv3Fntb
	mbbJzIn06f84C7rQDnYwAurEyp+E8L/67vyT0YalrjDYGPLUCX8CE2oElKhLpqWP9i3iFSxTwNl
	5YYTTq+CdErnJmElrBNNwCrIMaWmhbsQSolA97VjrTW6a6vPdLIoufgd/KmHR+13zFP9LVd3WvP
	OPCbI2AkzNXwWqyqtN2YszrkX/kMZtspqbybUZWWTJvwuyOg9bVQBfcM4=
X-Google-Smtp-Source: AGHT+IG8+JeFt7Dr1shGOAUFN9w5VwjSv6ocw6OSh2d8Dtr7fUiZni/H5p+9fHrGbmGs6jdFtb1nXQ==
X-Received: by 2002:a17:902:9a04:b0:1d9:4ebd:b94d with SMTP id v4-20020a1709029a0400b001d94ebdb94dmr2646830plp.55.1707595592477;
        Sat, 10 Feb 2024 12:06:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPJCk5vB827QrbnoqPhphVwPGccMGE2j9U5dPW1B5sH/1C1YrDYSUqb8XfhwZmJfz38Qs6/8Nlcbdk5K63Q4qOVWWus+upk2ZZ+9hyLzkM0xrAzKgSHBSW7rVQ1gNw8qXfTWQCSvQciqAy3XNoE5Ihm7U5fqjm6z+tjOiqvsqfKKR1xRZ5PI0Uufyi5ol+Bjx4XeV4NGrwPTZtYqVQ3OvUmWwIo0h3GohyFQN5cezgyg==
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm3373392plb.58.2024.02.10.12.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:06:32 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 2/2] smb: client: fix parsing of SMB3.1.1 POSIX create context
Date: Sun, 11 Feb 2024 01:36:06 +0530
Message-Id: <20240210200607.3089190-2-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240210200607.3089190-1-guruswamy.basavaiah@broadcom.com>
References: <20240210200607.3089190-1-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 76025cc2285d9ede3d717fe4305d66f8be2d9346 ]

The data offset for the SMB3.1.1 POSIX create context will always be
8-byte aligned so having the check 'noff + nlen >= doff' in
smb2_parse_contexts() is wrong as it will lead to -EINVAL because noff
+ nlen == doff.

Fix the sanity check to correctly handle aligned create context data.

Fixes: af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
---
 fs/smb/client/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index d610862ac6a0..c1fc1651d8b6 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2184,7 +2184,7 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 
 		noff = le16_to_cpu(cc->NameOffset);
 		nlen = le16_to_cpu(cc->NameLength);
-		if (noff + nlen >= doff)
+		if (noff + nlen > doff)
 			return -EINVAL;
 
 		name = (char *)cc + noff;
-- 
2.25.1


