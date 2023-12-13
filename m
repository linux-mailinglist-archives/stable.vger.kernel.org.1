Return-Path: <stable+bounces-6540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E07FA8106AA
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 01:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72742B21079
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 00:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A617C8;
	Wed, 13 Dec 2023 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jok+/0PS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E623CD
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 16:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702427788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RJN1x0PpbDfzaXjRksok/XhqhYBzo5gWu/iFT+Gwn1A=;
	b=Jok+/0PSXJCzqyfOFTLnQE82MrZtzYpPcJFZVKdKE6Zn08+tMKFeVj4zq0NmlnxCk+fUu3
	cOY2qGBiY4p1R8pMIUjYOLkA6ldiSwdU9i9sRZljD8quc25IMaC8qxGn9DWaJJtD8Kg3ip
	gxywIrTMG37wWVSXuvwHu5rgdRr+zcQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Beyvy5vgNBWaG3HruKRyLg-1; Tue, 12 Dec 2023 19:36:21 -0500
X-MC-Unique: Beyvy5vgNBWaG3HruKRyLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A17D0185A782;
	Wed, 13 Dec 2023 00:36:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7BBFE1121306;
	Wed, 13 Dec 2023 00:36:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	imammedo@redhat.com,
	mst@redhat.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	mika.westerberg@linux.intel.com,
	boris.ostrovsky@oracle.com,
	joe.jin@oracle.com,
	stable@vger.kernel.org,
	Fiona Ebner <f.ebner@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: [RFC 0/2] PCI: acpiphp: workaround race between hotplug and SCSI_SCAN_ASYNC job
Date: Wed, 13 Dec 2023 01:36:12 +0100
Message-Id: <20231213003614.1648343-1-imammedo@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hacks to mask a race between HBA scan job and bridge re-configuration(s)
during hotplug. 

I don't like it a bit but it something that could be done quickly
and solves problems that were reported.

Other options to discuss/possibly more invasive:
 1: make sure pci_assign_unassigned_bridge_resources() doesn't reconfigure
    bridge if it's not necessary.
 2. make SCSI_SCAN_ASYNC job wait till hotplug is finished for all slots on
    the bridge or somehow restart the job if it fails
 3. any other ideas?


1st reported: https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com

CC: Dongli Zhang <dongli.zhang@oracle.com>
CC: linux-acpi@vger.kernel.org
CC: linux-pci@vger.kernel.org
CC: imammedo@redhat.com
CC: mst@redhat.com
CC: rafael@kernel.org
CC: lenb@kernel.org
CC: bhelgaas@google.com
CC: mika.westerberg@linux.intel.com
CC: boris.ostrovsky@oracle.com
CC: joe.jin@oracle.com
CC: stable@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Fiona Ebner <f.ebner@proxmox.com>
CC: Thomas Lamprecht <t.lamprecht@proxmox.com>

Igor Mammedov (2):
  PCI: acpiphp: enable slot only if it hasn't been enabled already
  PCI: acpiphp: slowdown hotplug if hotplugging multiple devices at a
    time

 drivers/pci/hotplug/acpiphp_glue.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.39.3


