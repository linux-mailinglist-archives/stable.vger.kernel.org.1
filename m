Return-Path: <stable+bounces-92781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633879C5737
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282AA2815FE
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980501CD1EC;
	Tue, 12 Nov 2024 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QaO0Sutu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF223098E;
	Tue, 12 Nov 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412997; cv=none; b=H9ijnl+n6xSGpv2uTt/TAXRh0FQTnDh+mX+Y710bT9y6c6/eg6Rtf03w7AdUeaGz1Y5M0/zLhQZqq83WUJKbCNvLcq+WTJvPbxUohCiD/VQMQfW30oI+h/diLfZCVyNLwIJ7lrdwQ7/R5joUHwsym9Ji2M3ohXoGOKSHBsxwekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412997; c=relaxed/simple;
	bh=0HdCnmsiKmvN7Fr40LWt83vljcLwgTx7JrtEyHPRVWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKlKlhhMkFAnlvglA+cryJSGKpAYW5jmDsgRLXyamOFh1mGoy/2DxaHN+AKvkL3/I2ma898ZEqU8QM7A8LF2tRvlB8LK6VF6qsxN6tgKb9OHyfjaYSj0dG0c1VuA2cTjKYBfK4Ed4g1hTeetaeUF8x7c06RWPFiet0+Hj7Sth64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QaO0Sutu; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost (82-65-169-98.subs.proxad.net [82.65.169.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4E3883FB26;
	Tue, 12 Nov 2024 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731412992;
	bh=6+E/jurf8tnIjaJ8h27Uw+m5Nu2SikIm9MhX4XgNaDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=QaO0SutuLREETYhxgEro1itGK0QM9S5WH1j8KI1tSUoQaj6WFWCKK3A64CBxWlt7G
	 fAWBF+nD4+c3V1/KhrdH3ICSsvdFba0AFFuY+kFtnjMiB/VhD2PsH89tFc6tsbqz8V
	 c06pKsZFW7CTNXD4gTXVrqxqZ872/TX3jHp2ZZ2n+Y8XLDBGV/E2B8UtwZABwGzOUN
	 /B3ufsxirB8vwi6HTLqNrakyOkQOiLbtxSts8nWt8Z+5LXFKctLqO9WtJrRi4DhW9O
	 PC4RLvz9cgLS/B/97Z65BL1yu4pYXk4YQPadp6dLIRdqjavx+hjoq5Pq1gmmSH9Rao
	 MUr6lUbH9u3+g==
From: Agathe Porte <agathe.porte@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Agathe Porte <agathe.porte@canonical.com>
Subject: [PATCH v2 0/1] ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields
Date: Tue, 12 Nov 2024 13:01:53 +0100
Message-ID: <20241112120304.32452-1-agathe.porte@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: add Cc stable because the UBSAN might be triggered of previous
    stable kernels as well.

Agathe Porte (1):
  ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields

 fs/ufs/super.c  | 4 ----
 fs/ufs/ufs_fs.h | 4 ----
 2 files changed, 8 deletions(-)

-- 
2.43.0


