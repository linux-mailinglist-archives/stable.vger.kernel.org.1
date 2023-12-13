Return-Path: <stable+bounces-6577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A28810DBD
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 10:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07131F211D4
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349121A05;
	Wed, 13 Dec 2023 09:55:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5BCA4
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 01:55:19 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C321746E6A;
	Wed, 13 Dec 2023 10:47:34 +0100 (CET)
Message-ID: <af67425d-8127-42d7-b874-099fa27f02a7@proxmox.com>
Date: Wed, 13 Dec 2023 10:47:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, mst@redhat.com, rafael@kernel.org,
 lenb@kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com,
 boris.ostrovsky@oracle.com, joe.jin@oracle.com, stable@vger.kernel.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-3-imammedo@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231213003614.1648343-3-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 13.12.23 um 01:36 schrieb Igor Mammedov:
> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> bridge reconfiguration in case of single HBA hotplug.
> However in virt environment it's possible to pause machine hotplug several
> HBAs and let machine run. That can hit the same race when 2nd hotplugged
> HBA will start re-configuring bridge.
> Do the same thing as SHPC and throttle down hotplug of 2nd and up
> devices within single hotplug event.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

With only the first patch applied, I could reproduce the issue described
here, i.e. pausing the vCPUs while doing multiple hotplugs and this
patch makes that scenario work too:

Tested-by: Fiona Ebner <f.ebner@proxmox.com>


