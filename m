Return-Path: <stable+bounces-176792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 745CFB3DBD6
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 10:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED083B5BDE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDC52E0410;
	Mon,  1 Sep 2025 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEpwW2/R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3611D8E01;
	Mon,  1 Sep 2025 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713887; cv=none; b=G6rUFG6jP5/s3bxxQz4PEp1PuHV94qb+sWiVY/wDJQyktwUwxE+Q3uwBSdLz82S9+P1LkU7SK1TEAUmIWyYrHZu+cFEShXuEcG34ar9rCu6rw9/5D89HGgTAR+i2Xr44H8AQc4UqrKnjjdoBFf/U31JiwVh7bVH5sf4iAE4cw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713887; c=relaxed/simple;
	bh=i56wBB4rgAtMJDEKaM2MnQaXskJih+VGQ0oSinL3QQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G2c/00pqRHwrpTmWgsf4mF2AM20G5KKCnyV/nn8i6oQeRj8YxI1NBuFr7I1hpUC2l/2SiZAowLZVuLBfPbrZ2ghjJntEvKpq50/iCNJcczbZfb2uo2PZ98MWnhKuWI21F6raCvNmxb2pe+BdL0La/KIP+Iae1l6oUe9Qg5ucO8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEpwW2/R; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7724df82cabso1050859b3a.2;
        Mon, 01 Sep 2025 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756713885; x=1757318685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANYnP0mnn2BNW6DSdQB01HVrQ7wQ6DtZcdXbGpJTFao=;
        b=jEpwW2/RX4AmSMnvo+byJmFiBhC/XRTovXR8GcpZ2TESJpcglFWQ4/NTf1kFbPkT7O
         y8miSc65oOA5U0ZhoyTcXjrdNRqjsbDIS0IHfMZll3iH1xdWBipom5yqONm6mos2ymFY
         cE6emd8pgsAmiYKy6mXFpI6aMoz1UmohP7A/u/b9SVAPoLLJ9NQYc5stbpryJmWGAfSk
         qR/ZI0jzmBqY8O5eyhAK2A25akdmM1XT4Sq30730FzOCZnxhXb+Jw9CYOiOkhCfd94XJ
         MskllSwsv6fJlafma5PuH159PpHylZP2zwCq7FpcqRlE/W1mC1r8XganIDel4cxeowr9
         QqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713885; x=1757318685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANYnP0mnn2BNW6DSdQB01HVrQ7wQ6DtZcdXbGpJTFao=;
        b=k8stDtzyMyuSTkkWKpOVeYYj4mJfoLIaq6Oe/Rf9ii0DG7/IacFiUx9eGiN27DD4Cz
         Y4/Z/rQRFgLD67wBEUELZwQG7Ua8BcnSB5boSoVAR3V66Vo45F8DqsQi3h+FtpNKPQkX
         I9PGNvaOYpz36ROMaKseZTSqGznKwc0/WaYv2ToSZBJmYHjzUmR3Qym3s6W1YGn7+CsM
         4EuI4TkiH4ASn1JgyM5gANTNxbzs9legrwGySmT7rFpAk3the7jGgcyxPhItQdazxjXC
         r2PzayJSZuW7oVIyYevjnlU4xTXelg8LmNbx2FSZeGNuExZlll6xW7xQZSLBO5AAVxPI
         wtWg==
X-Forwarded-Encrypted: i=1; AJvYcCUAzmlLzjpFdcY7wANoCamg9Ns4u0gCCre+W63gfTKW/es2YJoHBpREKzxu+t9OXAfhZaCLFvJWwCrp@vger.kernel.org, AJvYcCUPpmZlOwnK9YL2iWXZVlMAh0tzbbKJRc6zf+sJZLaRx5V2AWbWt/8texJGO0IreskdkOm69kHq@vger.kernel.org, AJvYcCXGHCeBTL/KQuBCFep4G2ckHSzS0/zuWhLVp1bgO2M3QMymYzebnQXe9DVOnrJuZDWBYEye5SAw0iUqIb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLi3PFbBSPq8U7fTXr75xlp8LpQoHdcgJlNLK/nhVqe8hFzoK1
	DbF4rIlO/sOOzZeGd8mfy5RpWJDb3CJVP0sFYgE+T7loDN72b19yc96U
X-Gm-Gg: ASbGncvjVwrt0urOZ/l6O7GG0x4t3HT+/i9e3DBzY2hUBRXpvQcKVyJgxdmhG4Bu1BT
	fGUDRdgPaYjt9ztGac0g62TfRi3epyXvjjgd3Lc4SdpSOeaHVB12P7ZadOVMRDlJ+FSAnLLW+L1
	kq5YIXs7GDE+OiNOHwilptRbN6X3kXLBQQsJV57RR5l8H/rfUWh6YBoYTtXIrM22p6Sd12VNHbx
	rumsED3uskQ0eBfjTgA1akpKj4H7Jwfr4NNf0ALUtDTCCQYCTcBqISvVX1+uMYMj5ZBkyt5RBKS
	v35mEf9pBGTEI7oeGGiPqWRUEbBRRQXxtkaiDfQcmFWjBg0sfFK1Q8NPLwGLy8rsFx/xKhgtWTt
	WIK3RISFN/w0fZAcbu2SWq/hA6ACPWXGNKL3cHFgzndis5PnxiBXN2hn/XVzeXAfNec31giCxZc
	YRQKau8TlBLFBhHMPvgblGXS9sHkSm7RsE4u8BNiT8uSQ7PgVraK1WFhM=
X-Google-Smtp-Source: AGHT+IHV+Phuoer5B5gaEp0gOshZXDInSBHq9pKfZrei8iCCGDhU3xkC66HC8hO8CvJ4QSG2GfcDhw==
X-Received: by 2002:a05:6a21:999a:b0:243:d63b:d264 with SMTP id adf61e73a8af0-243d6f37e4fmr8403209637.47.1756713885340;
        Mon, 01 Sep 2025 01:04:45 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.164])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-77241f08b45sm5982326b3a.22.2025.09.01.01.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 01:04:44 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] thunderbolt: debugfs: Fix dentry reference leaks in margining_port_init
Date: Mon,  1 Sep 2025 16:04:37 +0800
Message-Id: <20250901080438.2278730-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugfs_lookup() function returns a dentry with an increased
reference count that must be released by calling dput().

Fixes: d0f1e0c2a699 ("thunderbolt: Add support for receiver lane margining")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/thunderbolt/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/debugfs.c b/drivers/thunderbolt/debugfs.c
index f8328ca7e22e..2aadbec9a3e5 100644
--- a/drivers/thunderbolt/debugfs.c
+++ b/drivers/thunderbolt/debugfs.c
@@ -1770,6 +1770,7 @@ static void margining_port_init(struct tb_port *port)
 	port->usb4->margining = margining_alloc(port, &port->usb4->dev,
 						USB4_SB_TARGET_ROUTER, 0,
 						parent);
+	dput(parent);
 }
 
 static void margining_port_remove(struct tb_port *port)
-- 
2.35.1


