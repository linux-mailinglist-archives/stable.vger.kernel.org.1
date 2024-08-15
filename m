Return-Path: <stable+bounces-67730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B72C952754
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 02:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189C4283419
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 00:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2171186A;
	Thu, 15 Aug 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JiE/HO2e"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FB23776
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683438; cv=none; b=QWX5X8M73ktcjDeuIvWTmRZeLO6vSWZPFzWZGEj7hyiF3zhRy0ZqwxWlMVEbVWSOc6lMCBqC+F8fJaFqNaqNEkNaMTxtATawiU3lgf8NdClAXhhWwav/3pgiRxdd/BglxVj/Ouyxr91mbVq/zpExKuvJHiV+VMDtsIWwHEnYKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683438; c=relaxed/simple;
	bh=YuoZT1Le8rW8iRGj7CdMFiXVxmYJSRwzEyp4dHt7o5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ew39/fZK2XK1kMkYF3UnkJqQjwn6almEIYqYx6Da3SvG4TFFUIypv70t/f9MTW5QMUXyYYZJOKjIAGzIfE7AbEEuSlJq409JfSwamFuV/YjibuGh7r+VFYbhZWNCHJebsFPhJX/mlrTpmuILlEf8/hfnmkqGjmLyL8QSbTiFZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JiE/HO2e; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26927819823so368294fac.2
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 17:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723683436; x=1724288236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWDwobnkCHc49Gr0pve6ji7mHLerdNm6SIfbLUzFN+s=;
        b=JiE/HO2enxoqD4ijyA1ZHLlkcGRa4ZG56kQidfLsnhtgzkTdE0lKSANDGvb8HZqlhT
         VdL3ggNnU1w/uaU8s82zHeiTwjj3Xdn5lxgA9ohcBL4pPqK3sVEbgB7M6tsd9suA/vCn
         oT8ux7/lV/OGmGjejNnlcF9BOEZwTEWPFWL8/3jwHJFrEEeNlIEiSw3iyf53ODrAsBCi
         vbnFAEfzhDayzgywQ5xkKyhsJF8jjNfSXduMHijxqHTRq4h+h5VBENHYd3jfl1+W9nvx
         HfHjnQpUwvvUiWz4cx+qFrbwuSEZkM7nAnxFzhQQwdrgFh7jHwUcx40ixmDRxMx92uMt
         +bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723683436; x=1724288236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWDwobnkCHc49Gr0pve6ji7mHLerdNm6SIfbLUzFN+s=;
        b=OoNiUcm9l70i9HgXX8YP0DBBTg/sabnmygkVilEYZIR8kGnpMEMyPW/RtUVqk6Iaj3
         pcOuu12YPQpO/WCE35sdNVW5AX+uI951LfPed3fDGbjy+tFpAiGePm4x+mgswClQBuHh
         dy1ILfGdKpUmGxwVwIkqq0dx1Khcjjcn+U0N4hKbh3Pu9km9PHH6WA6X+vUXSS9zlJ1r
         ld3zCzfNHSIeqMIycn+9uq7I1uVAO04GiWWRP2VptnK3gRdJ1jlaugdQ/kKquOGg9vCe
         C0cq0JpdpFuLBZ2AhfSJALRRF8macuNOFfnkBORQvr9tVDBHlTFHaKZBUHvW3g17ZSl1
         RFvg==
X-Forwarded-Encrypted: i=1; AJvYcCXrHeS5X5ObSvQpwHLKz3Rj6Dx5bcLraEo/olocQ3KQBbPSgSzi2XlagENx4VURvUaacjcgnE64b2Xhxcul0Q4JCgTfypDt
X-Gm-Message-State: AOJu0YyTP9XkiQQJhWUi1GBC73RDnr/IMxnIpocbsjdEagDPJyqwy6w/
	JMQ2iBdHI+iGP1d111WHkxri6aJPBfEvX6NH2YzqGrqpLgC1P+TN9N3DLDhr26M=
X-Google-Smtp-Source: AGHT+IHC66VEYQdljRuTuSO2x/zOwIVJbZPl2UlJTONTu2DLilQDdVvPTmdGUvtQ7FJ0ndbu7er3LA==
X-Received: by 2002:a05:6871:328c:b0:261:d43:3eeb with SMTP id 586e51a60fabf-26fe5c082a6mr5371911fac.32.1723683436253;
        Wed, 14 Aug 2024 17:57:16 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b63570a9sm164518a12.60.2024.08.14.17.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:57:15 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: misaligned: Restrict user access to kernel memory
Date: Wed, 14 Aug 2024 17:57:03 -0700
Message-ID: <20240815005714.1163136-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

raw_copy_{to,from}_user() do not call access_ok(), so this code allowed
userspace to access any virtual memory address.

Cc: stable@vger.kernel.org
Fixes: 7c83232161f6 ("riscv: add support for misaligned trap handling in S-mode")
Fixes: 441381506ba7 ("riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/traps_misaligned.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b62d5a2f4541..1a76f99ff185 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -417,7 +417,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	val.data_u64 = 0;
 	if (user_mode(regs)) {
-		if (raw_copy_from_user(&val, (u8 __user *)addr, len))
+		if (copy_from_user(&val, (u8 __user *)addr, len))
 			return -1;
 	} else {
 		memcpy(&val, (u8 *)addr, len);
@@ -515,7 +515,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 		return -EOPNOTSUPP;
 
 	if (user_mode(regs)) {
-		if (raw_copy_to_user((u8 __user *)addr, &val, len))
+		if (copy_to_user((u8 __user *)addr, &val, len))
 			return -1;
 	} else {
 		memcpy((u8 *)addr, &val, len);
-- 
2.45.1


