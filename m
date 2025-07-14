Return-Path: <stable+bounces-161881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A5B047EF
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 21:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF41A1A65D45
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 19:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23612CDBE;
	Mon, 14 Jul 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WR+S32ty"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BE0A41
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521624; cv=none; b=r4D/ifef3W/UBHTuWQdyc4ueqCwLkM0AVJiaCXd0ndJHkSiJkPMeQpwYgR8X0YT+TBKXpPyaf0gMizWAwIDM71EpZ8s0++9Um1stUoJFqpXjElTqLtin2Re+lAxf5uMBcM/ye7N8w7E0lmJBg1Ob8KtP8FeMB5c9e9MR+MsEqxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521624; c=relaxed/simple;
	bh=oy9SZonsxNZaHAJ05RS5gyoRi7+3YDML18pCJhMcmvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+n2GqDIoVJhVO6qm2Q+j75qyuyAwqad+703XOXyJrP/1UzwF/5vBBPplnZHyCwQicA0yTkhdz+bsMkeltnHQnaf2XjvufBMOc+7atZlsYr0m43U6y7tuLdxGYv3Vw8hBAj+2fqLLbyCOtqtcQyrfFbquo6SXo7HIWtxUoVVPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WR+S32ty; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a577ab8c34so460803f8f.3
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752521620; x=1753126420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBvJ8tHIPoi3DzIH6/rlmWfpJy9rLa6+wZGpU4LPGLM=;
        b=WR+S32tyLWLB0LlNgSbrH1No/XvvTax6JgkF+isRyXy/MvpLp6dqQpcZKLKV101DLi
         6sFdGT+w3lRxJ8lovmaF7IiX5U2/yI3y1zyA/q1oBkWk3AZs2z5J2tAkJYVwqOoV180x
         te+rPiA3dw/sZhPRggB+sDuc+ovL/BmhOPRRXlnMWk8LsMNG4dJCZgYpF9ZsHIPUvtCC
         Gyle56sdqvL5CYBablru/zzLjKwbKT+1xfpIY1WVPrkhgxfgjoi2/Pb7kvnaFXn0ERJf
         eO+6X02t6WdVQFXvSyXkpUeKIkvpC8Ebd0F7CTrLdNq/SEZqwkZgIS95ifKm7gKADcdh
         pVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521620; x=1753126420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBvJ8tHIPoi3DzIH6/rlmWfpJy9rLa6+wZGpU4LPGLM=;
        b=oC7COQUmTLc+AsyLThYJskMcl/BySeNZChFtS9t27nWH5Sr1WFbwVXAPO7iiI3pxVf
         RCp0kVkvtVUJQPHZcQXoEEhw20R0PF+skmgwRP2epJwvbp0Hkh9rwFTI8aVgmkRBF/bp
         UtE5WqVOPzvy14fUtm/LJuLnAEvmRVr62RwHntDViIdRUW2aeQ4M/sBUsGbibrrTO7Ss
         2j3vs18CickfCPOgxssHqSnbT539hgWWppt8saRjM6S1i6VtxNmi4hpYr81kU5BHfbJp
         HcJzELZW11aadCJFS9S6ogqVfMIbH8nZTueO1jAME8Eyvs5srJUKl89MxSXDPmk0sBh6
         pYbA==
X-Forwarded-Encrypted: i=1; AJvYcCVFZ02GTEPgNWNEJVgnlXdaMpX5lfUKfxyHyEoTdcrDYN5zOe3mHL53UsNfnDyNkc6gAV2Ru/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz02EtDH84g8BxvpbhFcyy5QpeMOmVVFRIdApyT/nSjOPXmpDQs
	P3FbeT8VWr3nEa+YUmWkX4BzEDtq2IWf8HZT6mqGyZSjdrHmXI193BERbHzn3FXkauY=
X-Gm-Gg: ASbGnculjDQeLJv6i2d6NH/a1sajeY7AmuXlukuD73fXqWuEkkZFXa99hTeaXhp5BDD
	EXFyWhplTnzjrG2CARxnbR/GOcMjVpkf+ma5EbW1zM2kdcBl/xKzLJnecxuaR1/wwv7y3OmfnUb
	gwWYjIIRmTvS00om9iHwgl8aUEYxh1L+RS73JEfYTwpKPzLVw3zzSmjP7IBWKbSY7I8izSIscPF
	RFAPa0JQ+SuNR+3+DIQ4T8ycHBIHY9C/cwbhJKtkLVFajIe3K/CJ8T6AajuHodqxA5nnZmtUNTb
	1U0JESfS2K68iOtiYJgO6VwVpV2byDDuBx+tjJR3VX1F3E6rZbdJgqll63f8t1CP4SBoNT313iq
	u4g5c4hugsYIYAnotFlJbFpKPPu+el/2JLwmFyCRSqBzg5A==
X-Google-Smtp-Source: AGHT+IHttbUcM5LVpQoa8rvnMzejxBaXyCp7PxjILpyjf7qudTE6gVk3/1TLBuSzQd/n3nx7l2XgMw==
X-Received: by 2002:a05:600c:4695:b0:451:df07:f41e with SMTP id 5b1f17b1804b1-454ec16486fmr44397845e9.1.1752521620249;
        Mon, 14 Jul 2025 12:33:40 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:1466:dc00:11d5:2c1:dc02:c7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560bdcce9dsm79228885e9.20.2025.07.14.12.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:33:39 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Subject: [stable-6.1] x86: Fix X86_FEATURE_VERW_CLEAR definition
Date: Mon, 14 Jul 2025 21:33:39 +0200
Message-ID: <20250714193339.6954-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a mistake during backport.
VERW_CLEAR is on bit 5, not bit 10.

Fixes: d12145e8454f ("x86/bugs: Add a Transient Scheduler Attacks mitigation")

Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1c71f947b426..6f6ea3b9a95e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -429,8 +429,8 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* "" The memory form of VERW mitigates TSA */
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
-#define X86_FEATURE_VERW_CLEAR		(20*32+ 10) /* "" The memory form of VERW mitigates TSA */
 #define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
-- 
2.43.0


