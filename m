Return-Path: <stable+bounces-208041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A74D10B81
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 07:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04F02302C9ED
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34C311C37;
	Mon, 12 Jan 2026 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gb2a2pki"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121C8311966
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199935; cv=none; b=SUABd1OYpRnlKSL2RuzkX8ddawCa7m5MYLygrozB97wW/tmvb8iBSmzZ1JUt/zt2vxPRaZVVOJqJ4oa3jMjMIf2VF/4kFiWxUdjdMhFhHC2o+tsq8AI3w8uJv6VCZDl18wRACjKrBzuoNgvRYy4oQzXg7VAsGcUh7bbWEPtagPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199935; c=relaxed/simple;
	bh=uSEkHsH1REtKl3xcr1eJo/cD8PSr1EaGnbXhvaEtR94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzPx3XodVk25k3z4wS5fHYQZpoFDNKKpMZv/y0A9GeCOJJf3hGi5YJjgZqAmXFzzAXrqJlUReo0RyOQblszJWMfE5S+7+HqkqW2XcewIkRiCA2gochXeH+cu3Emmntm5UwWUTGUTjM4YqVZ3zmIXGdsy3kB23q8pALKcbkzM5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gb2a2pki; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-65f65551cdcso67021eaf.1
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199933; x=1768804733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=obtvoE7OhNcc6857zIHTmecWln1o2AWNhzXHTlRzVcmor4P+8+rYhdlAgdl+WLWrRC
         gYrHmddImozWTuah8W8ijPPcDTIguWApbZpSGWQo+siW+ULkD9i3uNL6MOkAZ3KLpGQV
         fFejovzRHRrLDtLX3+GaoNAuV2OBMVGYSKbhpa6XbTtY/jY8UoeQJg2Cqc4K0rdCfTOr
         /GD9kKEo7XOJBfkCOXlfqb4+tZlSwIm1u3EisH2BcE0lBNVl0ZL8PWOM9Ef1oYfzgvgP
         l4pOZRhez69blj1C8zyL11yaxb00s2HyAxmOUgG7xlAmu6Y2h/dZENG6oodBqQ/njtdG
         qKZA==
X-Gm-Message-State: AOJu0Yzcu7fWqHCQzkrvMlz4QpNpyayj9KVIr3jovIrt532Bx4US0soJ
	dT4gnHYxTdo93vvIfhOAQLWmjb0Xw0MNxosYNqBSuPNL3QQDM2FlZ/uMkf0rmkOuS8dRYY/QUC/
	lbpTPQp5ewNt2eE1AXMpJcsYrPB6+z7O8HVeS3XGcM8WFDdyBd6Vsc1s2TmOFAGnolsKf3kvnJe
	Hsrr2ZKgCji4JcZDET4cKSenSbXyazsTYP5Ie1TVoHiBDAHUKgrOtUtotgjskBwFvhCmVYgUiPV
	2ns5IUv9APQkqRgQarduKq0eVDlfYE=
X-Gm-Gg: AY/fxX6Nsa3QsYX5VtPl3svyMejajJsEiM7EPwJFhbIt/lTvId/LjsOpMM+3xyTcnib
	6ALWxxxNrUlxum31Lg1Q6mltRpEHXehFJfnY8hSFcuCBRPN4eD13MZSCjnWDY0PlptHCZ5PlCAT
	nJObO493jwfPpJCnmUHpU1mPFNhDATxeMRqo1Pc5Ads+p+V8E+52ubkrad4QOoCIemJ8JxD4XxH
	ZP+ogyXajFqnF1LpdJ8Meuc0IOSWcJ9NXV8nQW4ATlrKwrNvOR6UAoXgLrc4+ctpGbqcrSmPiLk
	KCdTxXqdNe3P6qlus2clvSU8mDlmZFyIh0djwhDT/xxCuG6g8t/ca5perZ6i9aq7pFC1QkG63Ri
	iSoCRcWYNr9A/rAejUi2nCmr7dy6JBdQE2yC7xCTIYSSw4/u+4HN+hGHcgFD9U7y4YHV4cAld/n
	K7+2KvyxHv1RdXsrSxxqlHWY5O49W1k6Ea87dAc8s89h4Anny8rjBGTA/vQdA=
X-Google-Smtp-Source: AGHT+IGq88/ZbTi3vzIozpxIZ2NUB4+oits5odSm04WBySX1KlaKtGWEwLNyrOPo+WE/A+PVfTOh1R9TechG
X-Received: by 2002:a4a:d084:0:b0:65e:f615:d7da with SMTP id 006d021491bc7-65f54e20940mr5017187eaf.0.1768199932890;
        Sun, 11 Jan 2026 22:38:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-65f71ec5c29sm74117eaf.4.2026.01.11.22.38.51
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:38:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-890072346c2so16331836d6.3
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199931; x=1768804731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=gb2a2pki34x+HgwGiSJbwnZmVI+HTCnbTXbVsbA5dP4oiX6Br7n8Baixg03VeblW4P
         Um/UeUIb9ee3gPNlnpIcy7wzaMKOGipCWxcj0MpoaWsH9lQzJnWVQ+gTGncVz8jzLTAw
         +qCmIsG03zJyTPKSxHECqb/i+2nCK613G5anw=
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr189421081cf.11.1768199930716;
        Sun, 11 Jan 2026 22:38:50 -0800 (PST)
X-Received: by 2002:a05:622a:4cd:b0:4ee:1063:d0f3 with SMTP id d75a77b69052e-4ffb4a8df70mr189420811cf.11.1768199929671;
        Sun, 11 Jan 2026 22:38:49 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm126594216d6.18.2026.01.11.22.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:38:49 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:35:44 +0000
Message-ID: <20260112063546.2969089-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.43.7


