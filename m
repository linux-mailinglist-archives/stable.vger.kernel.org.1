Return-Path: <stable+bounces-127852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA87A7AC78
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B41744A5
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB32777E9;
	Thu,  3 Apr 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJUzGJYT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D627701E;
	Thu,  3 Apr 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707240; cv=none; b=g6E6caz245Ti/DOsEgEfTizl2gD//itQLQcYv/G9WcPafg3rxodPb4OFQqj3MAqONXEKjiZVA26Ob3ET+z6PjiC0MQvJq4snB4VGvaARy4l6Cug2WmlniF91Ws8bXpHgsLiz88AqsVEAF9+r+5d2IxNBiR/N2eiWCCJp2+e1Leg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707240; c=relaxed/simple;
	bh=Ew3XPZ2QZfomNXYGl+8NX7xTXBfA4ZH8Eh+wY9CBdmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rakfDsR9SaSgnMPA7QPfThr8SY5WucFXsRlr/+buInWbS/S+I/5Evc1Dn7LzurkgihcjArgD04lgxzjQ9IScCI0jy2SFIiAB3x4s61x2bsHxoyOOdYj9O27nnqv0wV2LXjpzpGzLKLTDYOuFlkVrRpWOki4UsIPV1aV4cpcgBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJUzGJYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C79C4CEE8;
	Thu,  3 Apr 2025 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707240;
	bh=Ew3XPZ2QZfomNXYGl+8NX7xTXBfA4ZH8Eh+wY9CBdmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJUzGJYTSfY4oYWYvB45c2nNxtI6VAusVlKoXXAYHo+DDyOWDNhGDpAFtpL4+jrJC
	 mKn/LC3co4Ipj3wNgjEb5oGVYJc1W83K4kRkSfkxoOtnM5JqSb4t4v9X6l5BchG1JQ
	 iW3q4A3MSd+L0y9QiVugG6jCvIJ2fyO/QtB67uet5iXYJPIETutgL1tdQbEV1IjX7u
	 b7T1eBJRAaLoCZeN1E4JEA0faX8rSup97z5lNmbt8452xVvHJ5hwIAxenzw7unadFF
	 inyRis8LuEVhkzju+V7VqnyOWNu9/t2i04o+ypEvUJFpVAL9CGRBFLxtRAiM7py2I2
	 n4pfSqNIMIoLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 34/47] scsi: st: Fix array overflow in st_setup()
Date: Thu,  3 Apr 2025 15:05:42 -0400
Message-Id: <20250403190555.2677001-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Kai Mäkisara <Kai.Makisara@kolumbus.fi>

[ Upstream commit a018d1cf990d0c339fe0e29b762ea5dc10567d67 ]

Change the array size to follow parms size instead of a fixed value.

Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Closes: https://lore.kernel.org/linux-scsi/CALGdzuoubbra4xKOJcsyThdk5Y1BrAmZs==wbqjbkAgmKS39Aw@mail.gmail.com/
Signed-off-by: Kai Mäkisara <Kai.Makisara@kolumbus.fi>
Link: https://lore.kernel.org/r/20250311112516.5548-2-Kai.Makisara@kolumbus.fi
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 0dc37fc6f2367..a17441635ff3a 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4119,7 +4119,7 @@ static void validate_options(void)
  */
 static int __init st_setup(char *str)
 {
-	int i, len, ints[5];
+	int i, len, ints[ARRAY_SIZE(parms) + 1];
 	char *stp;
 
 	stp = get_options(str, ARRAY_SIZE(ints), ints);
-- 
2.39.5


