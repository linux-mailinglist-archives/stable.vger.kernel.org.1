Return-Path: <stable+bounces-225254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Br/J+Oqs2lWZgAAu9opvQ
	(envelope-from <stable+bounces-225254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 07:12:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A753927DA86
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 07:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D36A303596A
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52927A10F;
	Fri, 13 Mar 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Rq7SYnhd"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719A1D90DD
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382229; cv=none; b=tfPcfFuxh5d54RoiJTlMkxlgG3EDg32KxNKWxjxlPQmLywIOrv38rp7H26xt6e4j/IalvsFMBlpC13mqSmDYmARr5YYOrOhyo04CHP9BmuXznJfRpd0WjDg6MIXuETXSEve7oz896Qy3PrPZs4WXBl30GJR3NVkPBjyJnFwbbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382229; c=relaxed/simple;
	bh=1lEFnpBPqKWQR4LHsFSByF8b7prrQ8U8VsDt9Y8jk+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8uFSsjS8UNbK48rEwUGN/8pvU4of8XJsmy7wKGfuf9AfC7PzkL3LusOHsreHv3kGRJnKAugcpBIdZeCxNP9Ya5TNWPQt7VJOv1DFM3oX2lO21nDb6KMQBrAnw8XGB5tOlWHU70qKPV5VyUTShlm18Osf3ILhWNYJl3efst095A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Rq7SYnhd; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id 0v82wE4AMJ9SZ0vj9wwB9q; Fri, 13 Mar 2026 06:10:27 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 0vj8wKlqxcu110vj9wcgx8; Fri, 13 Mar 2026 06:10:27 +0000
X-Authority-Analysis: v=2.4 cv=bKYWIO+Z c=1 sm=1 tr=0 ts=69b3aa53
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=VC-DKBg3BtZOrUgv6XgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CFP+oW1QZ0kQj3EY3lD+xL9YveNcxrLFvY4y35nvTNs=; b=Rq7SYnhdiqj/YRaF6S979Iyiqy
	vLCW2moSubB51CZGxcYmXQ4orWXAUM/AzbQJc6VfRD3/H5svbXVXITeotivRjaCPgrMD+cW/To1YU
	Dy0ON9p+lke+TIrXkazvfOhjWMNXZ96DpnYOtUO3OKNMCuHOtgAQ9OWc1dUDRi3mlcpHBZnS/OITs
	wd49nGOVVY3nEnFldkD5E9HvOwiRWX2+cDxtBncpolm5A1/6BXqVOq6VGMih4+WPFdlMWnpXBkzyV
	S8i+T8tB8i8Cf4RCZyskLxyUNvQae9os6FfpgsGK7IixKiOvNJ7Bq3xbdu5lkoOIbKvUjEsv9J8rK
	7PCcMekw==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:55360 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1w0vj8-00000003X7o-2PGZ;
	Fri, 13 Mar 2026 00:10:26 -0600
Message-ID: <2a313336-ccfc-42b7-a14d-c116733ef64a@w6rz.net>
Date: Thu, 12 Mar 2026 23:10:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: freeze during boot regression Re: [PATCH 6.12 000/265]
 6.12.77-rc1 review
To: "Barry K. Nathan" <barryn@pobox.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260312201018.128816016@linuxfoundation.org>
 <b4f58774-18d4-4a32-9c85-603f9e2c98fc@pobox.com>
 <ee851013-fec8-47f8-9863-392f17e54474@pobox.com>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <ee851013-fec8-47f8-9863-392f17e54474@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1w0vj8-00000003X7o-2PGZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:55360
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMAR1AiJuzfgzBvmRaXoC48LetHGOPzAX2ZkNG3IXy+Zx4lpDWLnbZZCHLTCjv4IOpBZtpa92+yA/sV2jku4iIW1Ql/aJ4qHDNVNoXnC9TN1EfAC1BlD
 /FsWGUG01xe/VfTN23euaHzWjy1COqP73E/VUddJsBXwhk/qZuEkl5XoTFDPig+rqeCviC391CuC1Q==
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[w6rz.net:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225254-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[w6rz.net];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_SOURCE(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[re@w6rz.net,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[w6rz.net:-];
	NEURAL_HAM(-0.00)[-0.565];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,w6rz.net:mid]
X-Rspamd-Queue-Id: A753927DA86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 22:55, Barry K. Nathan wrote:
> On 3/12/26 22:32, Barry K. Nathan wrote:
>> On 3/12/26 13:06, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.12.77 release.
>>> There are 265 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 13 Mar 2026 20:09:29 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.77-rc1.gz
>>> or in the git tree and branch at:
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Intermittently, but significantly greater than 50% of the time,
>> 6.12.77-rc1 fails to boot on my Lenovo ThinkPad T14 Gen 1 running Debian
>> 12 bookworm. When boot fails, the last couple lines of console output
>> (retyped from a photo) are:
>>
>> Loading, please wait...
>> Starting systemd-udevd version 252.39-1~deb12u1
>>
>> I will begin bisection shortly. I happen to have also previously
>> compiled 6.12.76 + stable-queue as of
>> commit 4b2b2b5cf3cd78f4de4646687a4efecbd21643af, and that shows the same
>> boot failures. That means the following patches are *not* to blame for
>> the problem:
> [snip]
>
> I also happen to have previously compiled 6.12.76 + stable-queue as of
> commit 8d45879cc803965facf8d8257f13d130508b5986, and that also shows
> the same boot failures, so that narrows the cause down to the
> following 40 patches:
>
> drm-vmwgfx-fix-invalid-kref_put-callback-in-vmw_bo_d.patch
> drm-vmwgfx-return-the-correct-value-in-vmw_translate.patch
> drm-logicvc-fix-device-node-reference-leak-in-logicv.patch
> kvm-arm64-advertise-support-for-feat_sctlr2.patch
> kvm-arm64-hide-s1poe-from-guests-when-not-supported-.patch
> irqchip-sifive-plic-fix-frozen-interrupt-due-to-affi.patch
> scsi-lpfc-properly-set-wc-for-dpp-mapping.patch
> scsi-pm8001-fix-use-after-free-in-pm8001_queue_comma.patch
> alsa-scarlett2-fix-redeclaration-of-loop-variable.patch
> alsa-scarlett2-fix-dsp-filter-control-array-handling.patch
> alsa-usb-audio-remove-validate_rates-quirk-for-focus.patch
> x86-fred-correct-speculative-safety-in-fred_extint.patch
> sched-fair-fix-eevdf-entity-placement-bug-causing-sc.patch
> sched-fair-fix-lag-clamp.patch
> rseq-clarify-rseq-registration-rseq_size-bound-check.patch
> cgroup-cpuset-fix-incorrect-use-of-cpuset_update_tas.patch
> scsi-ufs-core-move-link-recovery-for-hibern8-exit-fa.patch
> alsa-usb-audio-cap-the-packet-size-pre-calculations.patch
> alsa-usb-audio-use-inclusive-terms.patch
> perf-fix-__perf_event_overflow-vs-perf_remove_from_c.patch
> s390-idle-fix-cpu-idle-exit-cpu-time-accounting.patch
> s390-vtime-fix-virtual-timer-forwarding.patch
> pci-endpoint-introduce-pci_epc_function_is_valid.patch
> pci-endpoint-introduce-pci_epc_mem_map-unmap.patch
> pci-dwc-endpoint-implement-the-pci_epc_ops-align_add.patch
> pci-dwc-ep-use-align-addr-function-for-dw_pcie_ep_ra.patch
> pci-dwc-ep-flush-msi-x-write-before-unmapping-its-at.patch
> drm-amdgpu-unlock-a-mutex-before-destroying-it.patch
> drm-amdgpu-replace-kzalloc-copy_from_user-with-memdu.patch
> drm-amdgpu-fix-locking-bugs-in-error-paths.patch
> alsa-pci-hda-use-snd_kcontrol_chip.patch
> alsa-hda-cs35l56-fix-signedness-error-in-cs35l56_hda.patch
> btrfs-fix-incorrect-key-offset-in-error-message-in-c.patch
> btrfs-fix-objectid-value-in-error-message-in-check_e.patch
> btrfs-fix-warning-in-scrub_verify_one_metadata.patch
> btrfs-print-correct-subvol-num-if-active-swapfile-pr.patch
> btrfs-fix-compat-mask-in-error-messages-in-btrfs_che.patch
> bpf-arm64-force-8-byte-alignment-for-jit-buffer-to-p.patch
> bpf-fix-stack-out-of-bounds-write-in-devmap.patch
> pci-correct-pci_cap_exp_endpoint_sizeof_v2-value.patch
>
> I expect my next followup to be once I finish bisection. 

I'm seeing this WARN on RISC-V in the same place.

Starting systemd-udevd version 255.4-1ubuntu8.12
[    5.417957] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    5.765956] ------------[ cut here ]------------
[    5.765976] WARNING: CPU: 0 PID: 17 at kernel/sched/fair.c:5266 place_entity+0x130/0x138
[    5.766013] Modules linked in:
[    5.766028] CPU: 0 UID: 0 PID: 17 Comm: rcu_preempt Not tainted 6.12.77-rc1 #2
[    5.766038] Hardware name: SiFive HiFive Unmatched A00 (DT)
[    5.766043] epc : place_entity+0x130/0x138
[    5.766052]  ra : place_entity+0x9c/0x138
[    5.766061] epc : ffffffff800721c8 ra : ffffffff80072134 sp : ffffffc6000a3af0
[    5.766067]  gp : ffffffff823a8a70 tp : ffffffd6808c1d80 t0 : 0000000000000000
[    5.766072]  t1 : 0000000000000000 t2 : 0000000000000000 s0 : ffffffc6000a3b30
[    5.766078]  s1 : ffffffd9fed138c0 a0 : 0000000000577fff a1 : ffffffd681175400
[    5.766084]  a2 : 0000000000000000 a3 : 0000000000000177 a4 : 0000000000000000
[    5.766089]  a5 : 0000000026fdb4a5 a6 : 0000000000000000 a7 : 0000000000000002
[    5.766095]  s2 : 0000000000000000 s3 : ffffffd9fed137c0 s4 : ffffffd682b1d880
[    5.766100]  s5 : 0000000000000200 s6 : 0000000000000003 s7 : 0000000000000001
[    5.766106]  s8 : ffffffd9fed138c0 s9 : 0000000000200b20 s10: ffffffd681175400
[    5.766112]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 0000000000000000
[    5.766117]  t5 : 0000000000000000 t6 : 0000000000000000
[    5.766121] status: 0000000200000100 badaddr: 0000000000000177 cause: 0000000000000003
[    5.766130] [<ffffffff800721c8>] place_entity+0x130/0x138
[    5.766141] [<ffffffff80072780>] reweight_entity+0x178/0x1a0
[    5.766151] [<ffffffff8007285e>] update_cfs_group+0x76/0xa8
[    5.766161] [<ffffffff80073340>] dequeue_entities+0x120/0x550
[    5.766171] [<ffffffff800738c4>] pick_task_fair+0x84/0x108
[    5.766179] [<ffffffff8007b954>] pick_next_task_fair+0x1c/0x1b0
[    5.766192] [<ffffffff80e2fe72>] __schedule+0x172/0xc10
[    5.766204] [<ffffffff80e30932>] schedule+0x22/0x140
[    5.766212] [<ffffffff80e36df0>] schedule_timeout+0x80/0x180
[    5.766226] [<ffffffff800d3586>] rcu_gp_fqs_loop+0xfe/0x4d0
[    5.766243] [<ffffffff800d6a12>] rcu_gp_kthread+0x122/0x158
[    5.766255] [<ffffffff80050280>] kthread+0xc8/0xe8
[    5.766268] [<ffffffff80e39cce>] ret_from_fork+0xe/0x18
[    5.766282] ---[ end trace 0000000000000000 ]---
[    5.992429] usb 1-2: New USB device found, idVendor=174c, idProduct=2074, bcdDevice= 0.01
[    5.999916] usb 1-2: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[    6.007028] usb 1-2: Product: AS2107

Probably those sched/fair patches.


