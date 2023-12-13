Return-Path: <stable+bounces-6578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B2D810DBC
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 10:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CDD281A62
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2261219FA;
	Wed, 13 Dec 2023 09:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 01:55:19 PST
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFBB83
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 01:55:19 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9247B46E68;
	Wed, 13 Dec 2023 10:47:32 +0100 (CET)
Message-ID: <501c1078-ef45-4469-87f8-32525d6f2608@proxmox.com>
Date: Wed, 13 Dec 2023 10:47:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been
 enabled already
To: Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, mst@redhat.com, rafael@kernel.org,
 lenb@kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com,
 boris.ostrovsky@oracle.com, joe.jin@oracle.com, stable@vger.kernel.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-2-imammedo@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231213003614.1648343-2-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.12.23 um 01:36 schrieb Igor Mammedov:
> When SCSI_SCAN_ASYNC is enabled (either via config or via cmd line),
> adding device to bus and enabling it will kick in async host scan
> 
>  scsi_scan_host+0x21/0x1f0
>  virtscsi_probe+0x2dd/0x350
>  ..
>  driver_probe_device+0x19/0x80
>  ...
>  driver_probe_device+0x19/0x80
>  pci_bus_add_device+0x53/0x80
>  pci_bus_add_devices+0x2b/0x70
>  ...
> 
> which will schedule a job for async scan. That however breaks
> if there are more than one SCSI host behind bridge, since
> acpiphp_check_bridge() will walk over all slots and try to
> enable each of them regardless of whether they were already
> enabled.
> As result the bridge might be reconfigured several times
> and trigger following sequence:
> 
>   [cpu 0] acpiphp_check_bridge()
>   [cpu 0]   enable_slot(a)
>   [cpu 0]     configure bridge
>   [cpu 0]     pci_bus_add_devices() -> scsi_scan_host(a1)
>   [cpu 0]   enable_slot(b)
>   ...
>   [cpu 1] do_scsi_scan_host(a1) <- async jib scheduled for slot a
>   ...
>   [cpu 0]     configure bridge <- temporaly disables bridge
> 
> and cause do_scsi_scan_host() failure.
> The same race affects SHPC (but it manages to avoid hitting the race due to
> 1sec delay when enabling slot).
> To cover case of single device hotplug (at a time) do not attempt to
> enable slot that have already been enabled.
> 
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reported-by: iona Ebner <f.ebner@proxmox.com>

Missing an F here ;)

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Thank you! Works for me:

Tested-by: Fiona Ebner <f.ebner@proxmox.com>


