Return-Path: <stable+bounces-172773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C990B3347F
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 05:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF3017C008
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66961F2BB8;
	Mon, 25 Aug 2025 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="X2eGKC8I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81228E7
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756092658; cv=none; b=sxP8w9J/XWPAuxaWU5ljxfxhSATzfYd3RsxP4CNYPeoKh3Hbk+o2TlZ0QnZJ5GMsoZqjeJC1C0XysHFBgT3Myu91q3rFZ5bl69R1snlEt7Ad8h+RNW+zV+Z82YFtDPZcyxR9seCaWz8x/7xv+x8TFwtVbiwqwr6fa25/cCiJC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756092658; c=relaxed/simple;
	bh=KvLr6SyIw7xWcJFozvT9idFznnJlWoos4HFd4VRS4E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQ4yNpCWCpVCD3uB2xwko6sQxCP0Xxcv9zoc8V11Ze3raTOGmHYFDUgVU+wuKApnXzmCa2MVQKJmLAfcAPCw0+aGfonEtAVKPEdj0a7pdIdywxRXF3HcC292/kSk33A/vkWpug0KzaXdwT+okPOoNb9y4EbKbazjVKJ8rmxh/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=X2eGKC8I; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323267b98a4so3128991a91.1
        for <stable@vger.kernel.org>; Sun, 24 Aug 2025 20:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756092656; x=1756697456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va5JTW85XJBn4Q7SWndBzAhOMuHsSHXhqk+r6dmLRJA=;
        b=X2eGKC8I7J4Nldv+ifDHCc0eJIIMzQikqfib64/xEdAA3zouB1EFq748+pZs21ly/3
         dBzW8/U84QNUfIdIcsCSNT+Hhu7M+X6YkFCA+ht0muPZtZ9W9s/OELHwVSYy7j51k/OH
         /PgnUl5h+EhYWXyqtoBd+8+RVqCgZPFNmCkBMJxvypKNphS00mbmossxlrDLcnfkQCu1
         2F1zIWe5+jKBK43raesIZWdJml26YiR5xlVELxvCiq1DrJjqxAGWl5GyK/3Fl3GmL0vp
         P2oIfgmVSR2FJruMvQhvFZYBCLPtI8CABbl/5btaccjSE9NY97ysYYlTikaV9dgMQrUF
         SOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756092656; x=1756697456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va5JTW85XJBn4Q7SWndBzAhOMuHsSHXhqk+r6dmLRJA=;
        b=oijq9E0SMBbQtJIx2mDZ5Be6MfLXA3OTQzPWvs9GLcZSNW4GdUw4tvFo0OXIyefrcg
         JoVmLcuPtc/mnq+jhVcOGkdDJUeiwJFC8CzxNObL6nx8bc+cP6v6CsZG18fEquDYdLIl
         rDa7q5vRvY8twzGUSUinJvA7OylJgTFLzMZTD9w87tUvlSwGzRcW732uUyZ7l5NF+Skf
         4VOQn8/bcv7b1qwtVFZABgYPruNxyJV8Gnoqa5qEBvQvHCto4op5Z98tuvJMNqaG9hOm
         1RWmhduJHHVt5UXwc8KS9yZVbgPhk0NzWsIv3cpmKt70Z3iKZQZLFWAl4WZpBNvr1XZT
         wIig==
X-Gm-Message-State: AOJu0YxG1CHyJNDuNq+MA0hOhx62Iwy9gSgzBpkvTATw1OD3WMLvBKZk
	kCO9Oo6rLJEyxHAVY9YuHxjgENZqyqp8Pr8ynbhF5uLuMitXRCMVzB6Rw7/gCOlrjKRLYQItwIG
	Idz0+d8Q=
X-Gm-Gg: ASbGnctTaZVoZoG+EU8o3r/OY+WRCWs9V5LgOVn8w/AcBHfsNOtLW/M3iX0xWBlOJEG
	2GwcO21wpPv8kA0CAuys472WU0f2/pBUMG2Nnadb8h4eK8yOakTrvUxXApNJZV47sekLQzed299
	TCOgpW1XqDe5K6eZDJqPdMomNPODI4EA3Zg7T8s5+3++Rq8MKBjMWiL1tPLlLKRV8tWI10UU1bi
	Q63omMC20yb8WCIrTeuX5/X8tdnthv3Jjc0rPB76ANgd26235oez7GFDT3KEvifQo1Qf24USseI
	4oF9R3sBOVLPDA1tMk9ZdddYDnLP4EfPg3gbnV+n3eek4Jlf2GZTh1WnhuHVG9IQU+NnBe9ygfB
	ZMEnZo7J8bp5Ug0pGGKIvFAKm
X-Google-Smtp-Source: AGHT+IGjVDBVN7kbTQZXat9hjOEVw6P48/DymDTgoeYm6kGCR/kOvnbd4hOwBUwx7ZTzt2ErjkiWDA==
X-Received: by 2002:a17:90b:1d92:b0:323:7bb1:1048 with SMTP id 98e67ed59e1d1-32515ec1404mr12159211a91.2.1756092656079;
        Sun, 24 Aug 2025 20:30:56 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49d2f0206dsm4214150a12.48.2025.08.24.20.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 20:30:55 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: stable@vger.kernel.org
Cc: jedrzej.jagielski@intel.com,
	anthony.l.nguyen@intel.com,
	David.Kaplan@amd.com,
	dhowells@redhat.com,
	kyle.leet@gmail.com
Subject: [PATCH 6.16.y 2/2] ixgbe: prevent from unwanted interface name changes
Date: Sun, 24 Aug 2025 20:30:14 -0700
Message-ID: <00196d6ecf9781d8bf5526cb0d992d3a0653167c.1756088250.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20597f81c1439569e34d026542365aef1cedfb00.1756088250.git.calvin@wbinvd.org>
References: <20597f81c1439569e34d026542365aef1cedfb00.1756088250.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

[ upstream commit e67a0bc3ed4fd8ee1697cb6d937e2b294ec13b5e ]

Users of the ixgbe driver report that after adding devlink support by
the commit a0285236ab93 ("ixgbe: add initial devlink support") their
configs got broken due to unwanted changes of interface names. It's
caused by automatic phys_port_name generation during devlink port
initialization flow.

To prevent from that set no_phys_port_name flag for ixgbe devlink ports.

Reported-by: David Howells <dhowells@redhat.com>
Closes: https://lore.kernel.org/netdev/3452224.1745518016@warthog.procyon.org.uk/
Reported-by: David Kaplan <David.Kaplan@amd.com>
Closes: https://lore.kernel.org/netdev/LV3PR12MB92658474624CCF60220157199470A@LV3PR12MB9265.namprd12.prod.outlook.com/
Fixes: a0285236ab93 ("ixgbe: add initial devlink support")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: stable@vger.kernel.org # 6.16
Tested-By: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 54f1b83dfe42..d227f4d2a2d1 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -543,6 +543,7 @@ int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter)
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = adapter->hw.bus.func;
+	attrs.no_phys_port_name = 1;
 	ixgbe_devlink_set_switch_id(adapter, &attrs.switch_id);
 
 	devlink_port_attrs_set(devlink_port, &attrs);
-- 
2.47.2


