Return-Path: <stable+bounces-127369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF013A78570
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 02:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D93AD78E
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A966C802;
	Wed,  2 Apr 2025 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOVG6Y9J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193D4367
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743552667; cv=none; b=kg0Yx1P7s14x1iSIGWUkIU/eLRmb8opONHyU4WpLHfT/gWslwq93LF9wrdrUgDipl25JXa5nvAWtg/W4v7R5GXPWzbgeA0zrn+Oe4ycxD9RQq1RQZzyucDouIQxTeSj4SsOe1HeitiItj6FJFfXxb6Lzx9AzOKToOcIdM6rzC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743552667; c=relaxed/simple;
	bh=EgdNDcLC7k0XtZIn+43y/w98YuMTuo72Sb3LaUG8pW0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oWqq9bBYaAMxTcyFmcbtj1s+0TLdryeSIzkxlXsIX7aWmpMISgoJbgdUYI0nQFAQhntkYIAO9IpTK2KeJ25ymQHF73hdMHE565vYNG8HC53DdbLBPo+ECX6v9DjNvJ0ttHRrFQECFLi7B/8a+EkwyOMUdaULO4WreMZhHLmpmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOVG6Y9J; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so1528395a91.3
        for <stable@vger.kernel.org>; Tue, 01 Apr 2025 17:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743552665; x=1744157465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=49XuAK5ARMEMF8yVcphCoCsW7MPVXvhnFi+JlgEVMBM=;
        b=tOVG6Y9JuSsxQXvsNxGzRZ4CA8H5ZsHTPqU7SSJBsX8Uo1Vg16+Q5CbWMSZPGJVTg1
         yaVqpxUOXPSVVmS1QrjHEKSt+tm4qcFfvDZuk+mNGMvTYxXIPCmtHFFenwN0HNNGv0mo
         3vDLEq2C+RRFC9gcl5zQnYrkUoz7jbXpcS1kYXGn3YIttFFVZvoRTuH8/enLxRZ2kuvy
         hgKjB27EPC26q5QGam1b5UKrmcdLVv2tfuRfASv9hS8QQ8hC6Ec1LjbwvXAuwum3gmxQ
         Fu5twXGZumDggePA+QAWYCWEE/TWmCUfnMvYdMnz+janlOn9zulgzOmHZAwc2ulJm35d
         D3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743552665; x=1744157465;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49XuAK5ARMEMF8yVcphCoCsW7MPVXvhnFi+JlgEVMBM=;
        b=BQ5Kg2SCWSwKQA7KyWU83bJTBU69AMlS2XJ0dAkmZG3MvxvVuPZOp8oGOt93RQP9LO
         OibEZ3GF8U9j01D/n137t7glHDwvjHC4AHPcJVhG+oTZ2rPlO2vP7uiZk47emPm4S+6b
         Ba/TwhhUY9aXlM16uhK5Y1fa4F02j2cZR6iGAKogULLaPw9FgeNEnYJmqv7N2GyCLJdQ
         KQc4k1tjUx8MQdMlHoa9PigX/HKHKP5QnYG0Lhj10XEGn22utkCthMYHTZL0Py7isCkD
         UD6wr/e6OxaXkm7llkVUj7dYC0cF54RcTmDpSc2Qxt2A3Hx6ebAQhpLyeucBW7179tE5
         WmWg==
X-Forwarded-Encrypted: i=1; AJvYcCVVwrb3FJ26ffkqzr730Wi1VzFXCMlaZbAK8JzkXYxuvmMo0KdKLJDvgozBc7I+Yped5yqBTlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqL9rTSPPAneKgr00POh2P1VPS/dfwOLlV251XPgsJs1wkPb1/
	sESaCQt6OfEiYevHFJEFvp9KOJSaJSOX2vN+0fJ/g3ksXRbctY+5opuijUtIkdwKpVSPiB0US5+
	3UKx9L18aF01xDEksDEoKsA==
X-Google-Smtp-Source: AGHT+IEPa9CGIWZyBDpQA9aD0ohqR/Lj8uxc0Ay1S+0+Hqoqc8rpo7eYcxBsaRxplF7qihOZcOaCavYFMyXEGhP6HQ==
X-Received: from pjbqn7.prod.google.com ([2002:a17:90b:3d47:b0:2ff:5f6a:835c])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d88d:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-30531f964d1mr23237272a91.8.1743552665424;
 Tue, 01 Apr 2025 17:11:05 -0700 (PDT)
Date: Wed,  2 Apr 2025 00:10:37 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250402001037.2717315-1-hramamurthy@google.com>
Subject: [PATCH net] gve: handle overflow when reporting TX consumed descriptors
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pkaligineedi@google.com, willemb@google.com, joshwash@google.com, 
	horms@kernel.org, shailend@google.com, jrkim@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

When the tx tail is less than the head (in cases of wraparound), the TX
consumed descriptor statistic in DQ will be reported as
UINT32_MAX - head + tail, which is incorrect. Mask the difference of
head and tail according to the ring size when reporting the statistic.

Cc: stable@vger.kernel.org
Fixes: 2c9198356d56 ("gve: Add consumed counts to ethtool stats")
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 31a21ccf4863..4dea1fdce748 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -392,7 +392,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				 */
 				data[i++] = 0;
 				data[i++] = 0;
-				data[i++] = tx->dqo_tx.tail - tx->dqo_tx.head;
+				data[i++] =
+					(tx->dqo_tx.tail - tx->dqo_tx.head) &
+					tx->mask;
 			}
 			do {
 				start =
-- 
2.49.0.472.ge94155a9ec-goog


