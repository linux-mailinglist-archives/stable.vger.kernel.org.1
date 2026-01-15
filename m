Return-Path: <stable+bounces-209947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5AD281DD
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B493B3007502
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB58314A84;
	Thu, 15 Jan 2026 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUNgSXjb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F4313E20
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505556; cv=none; b=aUEoP+kMamrZBU2S0W8QXhGxkRxhvApiF6jxTcaQMSxmrOtxvUySlWGQR3AIWwf8pCC+rgBv6F2VsDMzu8suYetFR5AYq2A3pM8ZDhyFNul+IZwkYBxF0tBtBhUdbK0cojiFh5EBUwHlpQa0tqhcIzAI7aGt4ICNrnWE51ljMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505556; c=relaxed/simple;
	bh=iN7tBzRxop9caKRj4q8iirBLtlGNWSDlzUiagfnuICE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRi9qNywhdkB9L6bdDV7/2l8l7FpjRLIrLqq3RGVOO0GEWSIkpqeHOMvg1EpebvG2NyzVmCBNcAW2N310+lA1gJPuCSKdp615a4c67PFnwdoriZSlOT8pfJiI8Z6BTMNpAkHd5VBuDN2A672Nto3j5f2AVMJiLtR0+ABp5nwEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUNgSXjb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768505553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voZQ7iSa47pr6K3TPQGa9aAJaocOGLGtnDD3AQrs/as=;
	b=hUNgSXjbigIiq7UbFdC+/ywqk4zGuKG8z9g906a70Ptbqlsb14fplREupy5iuz/zUhEDL+
	28miEont/iqGxgOPNd/lC/zDlPOX12giRNqpQtUL9x1NwQDSO2exuLEnX3KLh8jYVMtt2T
	gsUYpl4BvlwcwPI6H3d+80jjPd758f0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-doPz6xgIN5ab0tDHAz5ngQ-1; Thu,
 15 Jan 2026 14:32:28 -0500
X-MC-Unique: doPz6xgIN5ab0tDHAz5ngQ-1
X-Mimecast-MFC-AGG-ID: doPz6xgIN5ab0tDHAz5ngQ_1768505546
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 083E218003FD;
	Thu, 15 Jan 2026 19:32:26 +0000 (UTC)
Received: from [10.22.88.141] (unknown [10.22.88.141])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E92A3180049F;
	Thu, 15 Jan 2026 19:32:21 +0000 (UTC)
Message-ID: <4300e404-39ab-4b76-82a6-2d583a9386c2@redhat.com>
Date: Thu, 15 Jan 2026 14:32:21 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix PCIe subsystem reset controller state
 transition
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: wagi@kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, james.smart@broadcom.com, hare@suse.de,
 shinichiro.kawasaki@wdc.com, wenxiong@linux.ibm.com, nnmlinux@linux.ibm.com,
 emilne@redhat.com, mlombard@redhat.com, gjoyce@ibm.com,
 stable@vger.kernel.org, maddy@linux.ibm.com
References: <20260114072416.1901394-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20260114072416.1901394-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Tested-by: John Menehgini <jmeneghi@redhat.com>

I've tested this patch with 6.19.0-rc5+ on both x86_64 and ppc64le platforms.

Note that, on the PowerPC platform the following additional patch was needed:

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=815a8d2feb5615ae7f0b5befd206af0b0160614c

/John

[root@rdma-cert-03-lp10 ~]# uname -a
Linux rdma-cert-03-lp10.rdma.lab.eng.rdu2.redhat.com 6.19.0-rc5+ #1 SMP Thu Jan 15 14:14:45 EST 2026 ppc64le GNU/Linux
[root@rdma-cert-03-lp10 ~]# dmesg -C
[root@rdma-cert-03-lp10 ~]# dmesg -Tw&
[1] 15696
[root@rdma-cert-03-lp10 ~]# nvme list-subsys
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:HHHL:S4WANA0R400032
                hostnqn=nqn.2014-08.org.nvmexpress:uuid:1654a627-93b6-4650-ba90-f4dc7a2fd3ee
                iopolicy=numa
\
  +- nvme0 pcie 0018:01:00.0 live
[root@rdma-cert-03-lp10 ~]# [Thu Jan 15 14:24:11 2026] block nvme0n1: No UUID available providing old NGUID

[root@rdma-cert-03-lp10 ~]# nvme subsystem-reset /dev/nvme0
[root@rdma-cert-03-lp10 ~]# nvme list-subsys /dev/nvme0n1
[Thu Jan 15 14:25:29 2026] EEH: Recovering PHB#18-PE#10000
[Thu Jan 15 14:25:29 2026] EEH: PE location: N/A, PHB location: N/A
[Thu Jan 15 14:25:29 2026] EEH: Frozen PHB#18-PE#10000 detected
[Thu Jan 15 14:25:29 2026] EEH: Call Trace:
[Thu Jan 15 14:25:29 2026] EEH: [00000000d71b2d94] __eeh_send_failure_event+0x78/0x160
[Thu Jan 15 14:25:29 2026] EEH: [00000000465f9a5f] eeh_dev_check_failure+0x2c0/0x700
[Thu Jan 15 14:25:29 2026] EEH: [0000000015f9541b] nvme_timeout+0x274/0x690 [nvme]
[Thu Jan 15 14:25:29 2026] EEH: [00000000231862b5] blk_mq_handle_expired+0xb0/0x130
[Thu Jan 15 14:25:29 2026] EEH: [0000000080ea6b3b] bt_iter+0xf8/0x140
[Thu Jan 15 14:25:29 2026] EEH: [00000000b79a498f] blk_mq_queue_tag_busy_iter+0x35c/0x700
[Thu Jan 15 14:25:29 2026] EEH: [0000000077a6dbdc] blk_mq_timeout_work+0x1a8/0x240
[Thu Jan 15 14:25:29 2026] EEH: [000000000ef3edde] process_one_work+0x1f4/0x500
[Thu Jan 15 14:25:29 2026] EEH: [0000000039a4e1cd] worker_thread+0x33c/0x510
[Thu Jan 15 14:25:29 2026] EEH: [000000005a866bd1] kthread+0x154/0x170
[Thu Jan 15 14:25:29 2026] EEH: [0000000077e75258] start_kernel_thread+0x14/0x18
[Thu Jan 15 14:25:29 2026] EEH: This PCI device has failed 1 times in the last hour and will be permanently disabled after 5 failures.
[Thu Jan 15 14:25:29 2026] EEH: Notify device drivers to shutdown
[Thu Jan 15 14:25:29 2026] EEH: Beginning: 'error_detected(IO frozen)'
[Thu Jan 15 14:25:29 2026] PCI 0018:01:00.0#10000: EEH: Invoking nvme->error_detected(IO frozen)
[Thu Jan 15 14:25:29 2026] nvme nvme0: frozen state error detected, reset controller
[Thu Jan 15 14:25:29 2026] block nvme0n1: no usable path - requeuing I/O
[Thu Jan 15 14:25:29 2026] block nvme0n1: no usable path - requeuing I/O
[Thu Jan 15 14:25:29 2026] block nvme0n1: no usable path - requeuing I/O
[Thu Jan 15 14:25:29 2026] block nvme0n1: no usable path - requeuing I/O
[Thu Jan 15 14:25:29 2026] nvme nvme0: Identify namespace failed (-4)
[Thu Jan 15 14:25:29 2026] PCI 0018:01:00.0#10000: EEH: nvme driver reports: 'need reset'
[Thu Jan 15 14:25:29 2026] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'need reset'
[Thu Jan 15 14:25:29 2026] EEH: Collect temporary log
[Thu Jan 15 14:25:29 2026] EEH: of node=0018:01:00.0
[Thu Jan 15 14:25:29 2026] EEH: PCI device/vendor: a824144d
[Thu Jan 15 14:25:29 2026] EEH: PCI cmd/status register: 00100140
[Thu Jan 15 14:25:29 2026] EEH: PCI-E capabilities and status follow:
[Thu Jan 15 14:25:29 2026] EEH: PCI-E 00: 0002b010 10008fe2 00002910 00437084
[Thu Jan 15 14:25:29 2026] EEH: PCI-E 10: 10840000 00000000 00000000 00000000
[Thu Jan 15 14:25:29 2026] EEH: PCI-E 20: 00000000
[Thu Jan 15 14:25:29 2026] EEH: PCI-E AER capability register set follows:
[Thu Jan 15 14:25:29 2026] EEH: PCI-E AER 00: 14820001 00000000 00400000 00462030
[Thu Jan 15 14:25:29 2026] EEH: PCI-E AER 10: 00000000 0000e000 000002a0 00000000
[Thu Jan 15 14:25:29 2026] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000
[Thu Jan 15 14:25:29 2026] EEH: PCI-E AER 30: 00000000 00000000
[Thu Jan 15 14:25:29 2026] RTAS: event: 3, Type: Platform Error (224), Severity: 2
[Thu Jan 15 14:25:29 2026] EEH: Reset without hotplug activity
[Thu Jan 15 14:25:29 2026] block nvme0n1: no usable path - requeuing I/O
[Thu Jan 15 14:25:29 2026] block nvme0n1: no usable path - requeuing I/O
[Thu Jan 15 14:25:31 2026] EEH: Beginning: 'slot_reset'
[Thu Jan 15 14:25:31 2026] PCI 0018:01:00.0#10000: EEH: Invoking nvme->slot_reset()
[Thu Jan 15 14:25:31 2026] nvme nvme0: restart after slot reset
[Thu Jan 15 14:25:31 2026] PCI 0018:01:00.0#10000: EEH: nvme driver reports: 'recovered'
[Thu Jan 15 14:25:31 2026] EEH: Finished:'slot_reset' with aggregate recovery state:'recovered'
[Thu Jan 15 14:25:31 2026] EEH: Notify device driver to resume
[Thu Jan 15 14:25:31 2026] EEH: Beginning: 'resume'
[Thu Jan 15 14:25:31 2026] PCI 0018:01:00.0#10000: EEH: Invoking nvme->resume()
[Thu Jan 15 14:25:31 2026] nvme nvme0: D3 entry latency set to 10 seconds
[Thu Jan 15 14:25:31 2026] nvme nvme0: 16/0/0 default/read/poll queues
[Thu Jan 15 14:25:31 2026] PCI 0018:01:00.0#10000: EEH: nvme driver reports: 'none'
[Thu Jan 15 14:25:31 2026] EEH: Finished:'resume'
[Thu Jan 15 14:25:31 2026] EEH: Recovery successful.

[root@rdma-cert-03-lp10 ~]# nvme list-subsys /dev/nvme0n1
nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:HHHL:S4WANA0R400032
                hostnqn=nqn.2014-08.org.nvmexpress:uuid:1654a627-93b6-4650-ba90-f4dc7a2fd3ee
                iopolicy=numa
\
  +- nvme0 pcie 0018:01:00.0 live optimized

On 1/14/26 2:24 AM, Nilay Shroff wrote:
> The commit d2fe192348f9 (“nvme: only allow entering LIVE from CONNECTING
> state”) disallows controller state transitions directly from RESETTING
> to LIVE. However, the NVMe PCIe subsystem reset path relies on this
> transition to recover the controller on PowerPC (PPC) systems.
> 
> On PPC systems, issuing a subsystem reset causes a temporary loss of
> communication with the NVMe adapter. A subsequent PCIe MMIO read then
> triggers EEH recovery, which restores the PCIe link and brings the
> controller back online. For EEH recovery to proceed correctly, the
> controller must transition back to the LIVE state.
> 
> Due to the changes introduced by commit d2fe192348f9 (“nvme: only allow
> entering LIVE from CONNECTING state”), the controller can no longer
> transition directly from RESETTING to LIVE. As a result, EEH recovery
> exits prematurely, leaving the controller stuck in the RESETTING state.
> 
> Fix this by explicitly transitioning the controller state from RESETTING
> to CONNECTING and then to LIVE. This satisfies the updated state
> transition rules and allows the controller to be successfully recovered
> on PPC systems following a PCIe subsystem reset.
> 
> Cc: stable@vger.kernel.org
> Fixes: d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING state")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/pci.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0e4caeab739c..3027bba232de 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1532,7 +1532,10 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
>   	}
>   
>   	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
> -	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
> +
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
> +	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> +		goto unlock;
>   
>   	/*
>   	 * Read controller status to flush the previous write and trigger a


