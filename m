Return-Path: <stable+bounces-176944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BED8B3F827
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB43B188BFEE
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F32DEA7E;
	Tue,  2 Sep 2025 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WitJJlvb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B42E718E;
	Tue,  2 Sep 2025 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801180; cv=none; b=l9KqbHEe+Wvi3HkkPwMTMLsYlmoB4aRzP/pCR7e4TEtkxgdEd2hlQ7QoolJLhd+ifNNFVNC6uDLLUYsWxIT1wSqYcuOQNlsOP2O1vTcjbqPoFEBRFBtmKl6kFdwXtY8Z7WiA1tEYRNBS7+jMVBIBkh5EFnM4NxwS7tMLbMefACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801180; c=relaxed/simple;
	bh=yCmgzYi8sdjyZvAEQPWw4LrdqTw3EaZ52PuJmV/5otg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mupYz9ZGmXgfN/TnsTCYt+trwgZuwp9DM9SNB1WxQKul7qLHi9+lFYOE61bqv85LJreKlFsh9qogKHMSlOmp6PmXX+9fQD0M8dxaFTfxl/8RAFF7gCJgZ9QUo0cAudkc53jKGKQglk7glH7YQz62gPWlLLOWb2cXKpqgbUTa6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WitJJlvb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77252278757so1338987b3a.3;
        Tue, 02 Sep 2025 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756801177; x=1757405977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpTL+8UAJAvc2e731Ib5tRm4izD0s+sqQLOdVQdO65Q=;
        b=WitJJlvblODKrjNs0THoejWgcXab/n9043Jnp1Z0+11xJFFQKdg6ivtY84qBtMIEIZ
         67gPttESOzl/GL+XOShecUp64N4giZYQrYwyffL2zmHPQSQQY1vfRjd1t/O1ZXxU/Vyy
         3lRGnl6/w2lh+wS4zk0fzvpn2O6/yzxXjTFk5te/uEvmwc+6NXhtgjI9sPbqspahTT3a
         Sq64jC2yhDKijNzKug8Te45yzOER/zTUwAG6MRALKElfR4FKZlxJ0WEFSPEVB6Gr5hsw
         OEcKLYMNVK2NxhFVKmT3zoDdgtQ8t4sa3AIGsEAFGT7eZMKeKJshUdXuNeQ0JAIbfzcl
         GQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801177; x=1757405977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpTL+8UAJAvc2e731Ib5tRm4izD0s+sqQLOdVQdO65Q=;
        b=JFNc2cSEjfj9rYJFC4VagBJ7SdHMCbLKCPGkhTtqLfE12bCudH5zuRwJObzvNJ05Eq
         +LnHEiyNnyBUB6G1BAlc5VmOmVyRcdc1cZ6oupRl3ijQYiXZrGZ0NitKqhifp1Wc4oGl
         kLMiVUTlRIux1y0QXnSZrEW9K8CFAMP24I+d57pxxcGLWpXPZL0Brqi3pAqXAdI25hZ1
         k7gHRYfLHxrJAEJ+gqKs1ZXDN0Uch3uC6aYk7imJ+RbmYGKiIv/4BNz+fsMDXD7Kl7fo
         A/TG1g/lRspdRrkfn4RDQEC8tE08kpRiiPG+Z1Wx/Wikich/msGHAZQnSDL3JzgjXxqo
         TyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM7XjqQ9PH3/HkiJcFkjf2JlgVrqmw4uKvm+tEB0GBpyTx/JWcryxEdjfDoY9jNPXgZJUfasV8E8W1E9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCY+iMhFl7kCVr5yUUiRr54uISZ6sHS72OQgKkWW9j2fE1m6h
	RllCSfM1JcJoL1txD/RwSVKnRt3wF0fnX+pKkU/LHdKBEyIu+HKfApjn
X-Gm-Gg: ASbGnctU8mlQ33jfaxb+s+k1iVU0EJ7MruGbYZG/HAd/qX6P+zqr3sdEZHNzzflVXRd
	mHirLVo2y4fOPHiXnDxLQ8cvJEPJSWB+sGkIZz3GrPHI0058CqLfbOVuWjFoDemh5aHNGWFPRaq
	hNI2gvIBzAl0z69OMSjqeQj7DHVmgHGTKvFdEVnu2SGb43MB4jxDvP2aZGIX3owT/y/ts3hmi8e
	/pBHQLfJ5SJM6gZQydT2CK7/y45wAy8lKvCNtkR7q3He3a1FY2p9veRFjGpOriVBHAIy1hwg0rB
	sI2gdBHYGvRdp0YG102FKJijpmJ3aUQqE3Wm0vhIrB1ww+fbzVtZH79Om9QcVq8tNTdrDYJhxnd
	0RlCsPoMp2SgZfRPqqk9oKx10cN3iRwBxb7qMnJr+R07mIbzyQHKtZ2AthJlI74fhhp9EHN5AY4
	Lt/PC8B7PAPHYK+VJoz8GqRZY3fidriDFIkOKZ1RZIxnkNcL9D9PfWNj4l
X-Google-Smtp-Source: AGHT+IHMn0mX5CJ0vwSNBKSDg7gEeatnObxmLvDcjQ8QncO3GhezbOnpScCrxUanP00/q7WT9RoRCQ==
X-Received: by 2002:a05:6a00:1828:b0:772:499e:99c4 with SMTP id d2e1a72fcca58-772499e9e23mr13221266b3a.18.1756801177271;
        Tue, 02 Sep 2025 01:19:37 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.34])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-77236d7eb7fsm10930193b3a.54.2025.09.02.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:19:36 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Miaoqian Lin <linmq006@gmail.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] bus: vexpress-config: fix device node reference leak in vexpress_syscfg_probe
Date: Tue,  2 Sep 2025 16:19:27 +0800
Message-Id: <20250902081929.2411971-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing of_node_put() call to release
the device node reference obtained via of_parse_phandle().

Since we don't actually use the node, decrement the
reference count immediately after obtaining it.

Fixes: a5a38765ac79 ("bus: vexpress-config: simplify config bus probing")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/bus/vexpress-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index 64ee920721ee..aa17f819dfc9 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -393,6 +393,7 @@ static int vexpress_syscfg_probe(struct platform_device *pdev)
 		struct device_node *bridge_np;
 
 		bridge_np = of_parse_phandle(node, "arm,vexpress,config-bridge", 0);
+		of_node_put(bridge_np);
 		if (bridge_np != pdev->dev.parent->of_node)
 			continue;
 
-- 
2.35.1


