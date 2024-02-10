Return-Path: <stable+bounces-19418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215F85063A
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961ABB2323D
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1EB5F562;
	Sat, 10 Feb 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EMQhKQvN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E5A364BA
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707596109; cv=none; b=GyVtql+4L3FQgde5dOYut0LQr2rAHOI3hSnZDY2u881mUwCv7QNv8YWWsL+g0KF7aReqc4FL2k2exqRtOrmN1h1cNx7WiCBVL5EgTAYI/f3bj9V83PZHmBEfK/gQ+UtlZrWPj64Z1zM2KNjoF0IdRxyFXndyiXpCzEkeHZ7nMgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707596109; c=relaxed/simple;
	bh=sDKX/ZoksEgxhu1g8MGNR9uAFBXZhSCAea1BG3MsrEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lF7vdfXWJ2sU4OGACWumpN6FeLnISPX23n9idjBvlS9dRqETkUfsyA8nhUo9vSAkDhKUdhcqp/A0KMjZmHAOmmAYaVOFf/JMobN5wc/5qdHaEo7LsJee9Qt313PZMk40Qa1i/FUkbb/9/3kiBLk3vVEyGbmwc1/i3jgAbF31JVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EMQhKQvN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93ddd76adso15831415ad.2
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707596106; x=1708200906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/vTLOdHNLZWi3BglK90aBfaZ0elqtlMQQeMO9Hjwdc=;
        b=EMQhKQvN9kec4regTAzCQbUxpWqEA4+40PSUvRH2WiJ/B5HX2B8lskuZ+kRwFchbCU
         VKxtcQoO7sx+P3xJT9OcuKc6INxEM0VYQ0LEM3PwP0AJtSStnSxOD4gPmpQAcr1l5ivY
         /z4I+q3mCZ0qm0bh2ekE06YpnwGKpkZVFQMkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707596106; x=1708200906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/vTLOdHNLZWi3BglK90aBfaZ0elqtlMQQeMO9Hjwdc=;
        b=pUdp/O8PhPElXhY234+7qDRI+FaIdncme7AVIy0X8AVVk4V8U5/EcNhJoEhGnkCjy8
         OMbiH92+X6oHCSkO+jj1R35REbYcFoKQNGnEKHEEoueSRg74fpavfqRE3UEtA1/gykDs
         RecqOymqoCsqT2GLUQG2Nj6bNWInjNPevc8h7QFVk7Nz3kxFN1NTsacOpGh2tsgcs16b
         2iDhOyuMQPGkEyX2JjCpEv+Jxq0oEtew7lNt8F5s9NWsSsPH4PWTFf+m1gHpc1suLyOD
         VM54NV2q0wUPn/y259BZ7Pu+o48lfcd3xpIu+rKoYzgbLlFIXXsxD+Mif/OkIOSSVRHa
         2GRg==
X-Gm-Message-State: AOJu0Yw4Qh8XuQVlmpAWm9IGA3yP2SQUOlGVAblidJEchvoZ0ePKPYuj
	q6e9/oxzrPQpEqJHrRKehWbxL6y0stNaS6UXnbbPb17S6pYwYHAXno5BxACHmyTY74Jjsv5Vy9a
	6kJAsQW3l5akJBa1MLf+IyfAk8nrYQdUmONe+bR4qw9s1Qg8oPns3eedtyd+4HygSniR2xJnKhW
	VuvDpMHRilCGfd3mrq+qYq7CbJU9ANUYDddFsR2ckW/dO3tkFEUyFLaJY=
X-Google-Smtp-Source: AGHT+IFd1BciB8ZwzKtfFlMkVTHb8tFqqdq+EX3BQSZ+ktBd9w//CWdpr0b38Honjwj3YrkKc6QvZw==
X-Received: by 2002:a17:902:d48b:b0:1d9:bff2:67d3 with SMTP id c11-20020a170902d48b00b001d9bff267d3mr3285578plg.0.1707596106510;
        Sat, 10 Feb 2024 12:15:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFMg7lA5q6QN1tukZU3ZoM1tNnQkBG3gC6a1S8ocOJpUeOHE3tj2V9t9XOgN0fWF9sDGPy22F/SBnfkB2EyV2yY8oHapyqv82ZJdknx+Q6l+wkxeL5BoqYqCgDsZJzkjf2L6DKjyarpLXztzNSvfnu4LYSCqksue8AYyT8++6LgPNY1nMw5uncdVHKd3LkXBquk9Le235egwKaN4V1mwXF6EKaCcUGJrIG4pYUL+XCBg==
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id kd5-20020a17090313c500b001d944e8f0fdsm3424767plb.32.2024.02.10.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:15:06 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.10.y 3/3] smb: client: fix parsing of SMB3.1.1 POSIX create context
Date: Sun, 11 Feb 2024 01:44:44 +0530
Message-Id: <20240210201445.3089482-3-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240210201445.3089482-1-guruswamy.basavaiah@broadcom.com>
References: <20240210201445.3089482-1-guruswamy.basavaiah@broadcom.com>
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
[Guru:smb2_parse_contexts()  is present in file smb2ops.c,
smb2ops.c file location is changed, modified patch accordingly.]
Signed-off-by: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 71df2357c64f..5b49c36bd00d 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2031,7 +2031,7 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 
 		noff = le16_to_cpu(cc->NameOffset);
 		nlen = le16_to_cpu(cc->NameLength);
-		if (noff + nlen >= doff)
+		if (noff + nlen > doff)
 			return -EINVAL;
 
 		name = (char *)cc + noff;
-- 
2.25.1


