Return-Path: <stable+bounces-124747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D236A66133
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 23:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC8817D77A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11631FDA97;
	Mon, 17 Mar 2025 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="digeJQvr"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB33E1EB5D6
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249179; cv=none; b=SweSXhR3UmUGCFiu45TzfzHvWrmk6z5/U5Vnt7oss+u7s2Cu/fK21Fpj6ZFlkUjgFt4EEjI+dsOYVe7X3FiyGtG+nL3P6FBoB3TjzTrSU9uA31cUKOVH+l1X9TCA0ursSn2EGgGWt0p7Iaw9qLLaWDguGkSXbGZIt0B5puQCwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249179; c=relaxed/simple;
	bh=xtmNQAmiddO9PfxnK/vdLxIDc9tf8hJV8/EuKq1TCm0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tStjUa2kSmoT+qQivRChRHJUFpVCuK6XJBqQxE5WMiontDMHHsFRfPLNbajTL8ZRxINp7KwSEwD0pseEkZcMun/kZZmISk846xo2M9QOIJwpvY3Hn8b9fg17ey0i8VQxdRGznim6iR4XMNkRbBtHYK6Xf6LxP1u9w62QeBOoyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=digeJQvr; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c12b7af278so3468604fac.0
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742249176; x=1742853976; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8dAYBGS5lFqHpqqLaiZQj84sBiG0WpKfeLOq4SIiUc=;
        b=digeJQvrZM6XaT+cIa7PNlxs10nlv2zfz8W+OVUVflh7+MmxGfVKaUzTJZVy0Urf3B
         m4NFM+vHYX/b7GcZ5nuem1ctWsRW4UXPvs0HH0N92enll/ym6FlVz42e5E40FEIvFsbf
         geiIsPgI/BmrsKNXYUCKASMIpi//Sbp1/yld8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742249176; x=1742853976;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8dAYBGS5lFqHpqqLaiZQj84sBiG0WpKfeLOq4SIiUc=;
        b=wmtAvIc/sY19i7rZeoP44/eoDuddd01f70xZQO6slw/KjYi7AI0X9kJpzsba+BWcIp
         hWEvzYKOCvUaaWuEZio0uDuNfSk9aE2w0OUvo53KiBA7bVIHMu9YbVYbVxu3GPbqUOV3
         Jjc4CwJVwdyG5+g8aa8JXDbmYHRSaX/a4lpsVbhJBmCWt9DgdrH10X+1ktRN2uuvHPq+
         yhOPh0lp/8dP0DI2/CHyuNRb24RscwUbHdzgsVVFdhJb68SxltQEMlE2qLZsieFdGatg
         MkXtJFPyZVb1S8TWn/OAkggCkv+yerLUPIq/4Bo30X/jJMmdnSPu+t0Ybvpn8SHCA7Lq
         Na4w==
X-Forwarded-Encrypted: i=1; AJvYcCViPqnqtsyUHX57ytYK5mvtsQJFOrYFs8O2Tw6XyAm54fKjYKw5DmPc8juP8jHcPHufdLNHZg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUHFTRbXjsabk98+hrJoOFd7qvmkteO9wBpWp8jc07wgYqiqs
	BUYrShSw0LVM6H2gddQwL+2zg5lq6QWgWdoLQTaFbPdoKnaB3EV+mS3Rhx5KKw==
X-Gm-Gg: ASbGncuHI1qG3+Dqg+6+k9jH0dhj8IiHDdSjqCNUq2jHSTTNWeZIdwoiz8AjOFkdOA8
	wSVRrh4ySEtMHEWrtZAs3HMfXNcm6BC9ynrV9mlmnB5m0MKRYrwjOGfdq2AUTc66a7X4TSy9xSW
	eRXTnXPmbQ29OkEdsupdtxYZijKhWrXUG4A88Ev0BSLEiPXrcs3I68L+VSp5yqn8WbzZcHzhFzF
	KDB6UipTLoySyhXLgUymJQLH930srY61kdXXMPfkUIu5ZZpLJUCggiT8GNCa5tV2KUtuxNdOV3A
	rkJQ2mQlsPORC2ORiprkUDXhseA2AORNn15QTuXfzcPCtpys/uQVBSYx3Uv0c8ayeXlA5jELLWl
	2PtN/FMAIR0UdDBE=
X-Google-Smtp-Source: AGHT+IHnaexVn+wNtEptwMdzRuUiiapR8scruXC+PY3z3bzwyGdHYiE4KcGEWLneAJxno4ExoIYhaA==
X-Received: by 2002:a05:6871:6011:b0:2b8:b76f:1196 with SMTP id 586e51a60fabf-2c71a1ce256mr601829fac.19.1742249176621;
        Mon, 17 Mar 2025 15:06:16 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c6712e5774sm2311980fac.31.2025.03.17.15.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:06:15 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Subhash Jadavani <subhashj@codeaurora.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Seunghwan Baek <sh8267.baek@samsung.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH stable 5.4] mmc: cqhci: Fix checking of CQHCI_HALT state
Date: Mon, 17 Mar 2025 18:00:45 -0400
Message-Id: <20250317220306.44646-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Seunghwan Baek <sh8267.baek@samsung.com>

commit aea62c744a9ae2a8247c54ec42138405216414da upstream

To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
bit. At this time, we need to check with &, not &&.

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")
Cc: stable@vger.kernel.org
Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240829061823.3718-2-sh8267.baek@samsung.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 10b36b156562..ae9c184ed898 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -580,7 +580,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
-- 
2.43.0


