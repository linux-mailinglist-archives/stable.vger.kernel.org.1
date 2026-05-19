Return-Path: <stable+bounces-249464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPreCXz7C2r2SwUAu9opvQ
	(envelope-from <stable+bounces-249464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:56:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC4577A56
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE32630661A1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562734D910;
	Tue, 19 May 2026 05:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="SFLUP3ym"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232234F497
	for <stable@vger.kernel.org>; Tue, 19 May 2026 05:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169837; cv=none; b=iuehzudB2sNta7yemUJnWJ/znUNrgfruCW9iypXW9Wufi95dhPKhKqg97Py2hFaB/MoIMwaKb+JsMaKtRIRn8ltn9GaXhEZNEvLhEpXAAD0hpYqV/RxKlAVe+oRLL0Rf9pahAq1DiUpQGREojdsrYaXeJ5HRGKSV5OcUax1zXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169837; c=relaxed/simple;
	bh=fdE73B+2YhgOK4WP6xc0MqGEBiTChQklgG2pvC74mI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byzI8xOu3/a4wKSWYM8uTEMB4hmf1MGlKCMk50dTytrXnSfEFNV6P5uPxopTRJnLUIp5yPZZCDcfZnIxE2IqFXDPihl2/1SALw/OfvB+t2IJerta9KiIeAbbbKe+9VyxdMpSdCXHbxSqqqybL5e7VXvsY6LNccPaevWl/KXfUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=SFLUP3ym; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-834f1075805so2406417b3a.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779169834; x=1779774634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBYQ1uikIhLCyfxlPUgX6NngwrO0Hp4sxqZIGIzdtpc=;
        b=SFLUP3ym1FDV/2beeP/zTppJlp7/OFcF4kpjJbG+n9jNi3KbBwhxjTgyD3hUtTEYWv
         4zLl+KZoy9pt/lLl2Qlb1qvPWJC6WQw+iQhC0LeDY/XubZWDmMDO2v6WF880qOo8QBlY
         rfR1KkuCb8ZQVUXW2HZv5B2ENQ/4by4h6bKllr7+OjLWet3N/T6Fj8ZoGaCHq5Ddu294
         AqnL0wkjJGWUw6kpIf72NvzmYz1VFDfkRilqx14ruv9zW/py0YQAyY7jZknjJXKtQEpA
         wTKmY2kB5+7KPtjYLCcVSLdGkeUUxNQ5LLNRAz+bmiYwBWXcW03ithsYuEhJpRgnJSpK
         ToVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779169834; x=1779774634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LBYQ1uikIhLCyfxlPUgX6NngwrO0Hp4sxqZIGIzdtpc=;
        b=KhuJfQsPBiGMGztiQGXRtaK8HwsqPj/ySL/MjhQSP1Qr43PB/CvCX8pjKnbtJuCqt0
         nqIb+LVx17Z+Mo16ya/6BAm8Lr/5F5E0ub+fEZ3seeQayd0ZTz58eSB4q4+MncXHK40T
         p/ItZYheknBy5Y6oNy4+5tdD8zE5OFrBm8pMbs5QDNLSoLAVn7O8grbj6MKCBGe1ANSQ
         nDKV383mkCCsE669sdSD5v/LJ772VIwxQ7rpDrhDwtJZOOCp0uYBlmW5A29nQhj3pxxX
         FJqZdS9rdAqobhfhCNfIcfsehv3lIw6J7iPGDyrZHai1j3mA6/rVuOAkp8eh6mVRTmNS
         l8uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yFuGeayPfVVkVQAM+9rQWeJN24ylvEqFx2bLC8wcXVSfY4j126DBHXQADSgQNDBlN6SHStkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9CNXJvKIskJZp7SyT6fn/LpF8XoNrqj/5bR1r3LssUBVIaQx
	ROCnULs02ldXTVT6VLRxK53ckF3dqD+GpRn/Bre6k8q0fST8U7EbIBlWZHogpAUsJ6A=
X-Gm-Gg: Acq92OHaNyAcuymPLu+k+D1wYbZC3vPvyXSly8FyxcxK2KCmg9CxWIWDdvhCK38aVH2
	CUXcgcK/m4VigQ4SZSRutoZQYypOKnOlOm5hYJqKLrJucMjfIRNnjxvjNkCYo5iu+5DCth/zlHY
	McSUbT9FR2qVsg8Qc856W/sFjMGax+F2fxRksd2J0r/4I7NWonm4wW+J3gngDEn5pJRZV32SBmf
	vPEV7AaxcYmNHkqLFgTFHgcex2Qyo8G1j8mTFeYQeb1V4EMzl94XU/a7whlYE4wP/L4SN/QZOUB
	a2Mo82C1LBbjtpF9ZUqXVWr/6eOy0Z3FtyQbhpYWbJVb1qyjaOFkZVctXxUNRCxC5LyGoUx4c37
	6Ey+HC1CYHvddqGmDdjC+IZdlixAWYt7p9+F5hm05HQIIQJ8ujduAQ3SWklB3Mns9gyYSKHf/f+
	ZbIgl0BkFyvDOyYPnk5pG+5zOI5C2Cz3gHwK7vqeRrLtVliH+ycxfxP6upveUwlugUTxSKSvSDz
	wT26yRgXIgARPlkNb3KNX095RZ4FW45b338AY1LBtM2AKjx0wvmk8o=
X-Received: by 2002:a05:6a00:8088:b0:82f:6858:3f6 with SMTP id d2e1a72fcca58-83f33a2f288mr18205430b3a.0.1779169833930;
        Mon, 18 May 2026 22:50:33 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83f19664a59sm16818807b3a.1.2026.05.18.22.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:50:33 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Tue, 19 May 2026 11:20:12 +0530
Subject: [PATCH 1/2] nvdimm/btt: fix potential memory leak in
 discover_arenas()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-nvdimmleaks-v1-1-592300fb7a43@cse.iitm.ac.in>
References: <20260519-nvdimmleaks-v1-0-592300fb7a43@cse.iitm.ac.in>
In-Reply-To: <20260519-nvdimmleaks-v1-0-592300fb7a43@cse.iitm.ac.in>
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-249464-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iitm.ac.in:email,cse.iitm.ac.in:mid]
X-Rspamd-Queue-Id: 74DC4577A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Memory allocated in btt_freelist_init(), btt_rtt_init() and
btt_maplocks_init() which are called in discover_arenas() is not freed
in some error paths. Fix that by adding kfree() calls to error path.

Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/nvdimm/btt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index fdcb080a4314..e0b6a85a8124 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -919,6 +919,9 @@ static int discover_arenas(struct btt *btt)
 	return ret;
 
  out:
+	kfree(arena->freelist);
+	kfree(arena->rtt);
+	kfree(arena->map_locks);
 	kfree(arena);
 	free_arenas(btt);
 	return ret;

-- 
2.43.0


