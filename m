Return-Path: <stable+bounces-225253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AGLM+Kms2nOZQAAu9opvQ
	(envelope-from <stable+bounces-225253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:55:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D597627D809
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 06:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E388B3025F2D
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 05:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA031E84C;
	Fri, 13 Mar 2026 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hq6VWUSC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gdzxk7sL"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA582989B5;
	Fri, 13 Mar 2026 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381341; cv=none; b=HP9yXK2ukoHCFoyQWNlatqMOozn4SWDtEYEmqUtKTy+4MtKM8L14xu68xMCLZkJPed+kr8sHSr7bvRDOuWuFfr3P0Q/AxRNQCUPfQt3+DuxfkY3HSKU7Twg/jsBsuv6tHk4pRzZdSWzQqHrirdk/8+DQRgNfHhAKfECyZKs1PgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381341; c=relaxed/simple;
	bh=Avbe9rIf836P2M1iOvlPH5r/tTKOaVt9K8v3wnomeSU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iaReXjE5TeGB8rlXDAD7LHE4M7jsorl/+r6cuIZp3rLaoGUPriZdMOp1EN/x7c3jiJn4ucsCztsWfFTK40rQVPjW2bhFNswuO5gdSz5YigL1VOB4zj28c2NBU1z3DKj/zGP6hJiXtBR/ggpTeWdDtbznk7fnduC7iKlGLY0Klqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hq6VWUSC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gdzxk7sL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BC2977A0182;
	Fri, 13 Mar 2026 01:55:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 13 Mar 2026 01:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773381337;
	 x=1773467737; bh=MS55tKW7uo75BZ/nH+lBMDr/C3AWgJO1u77ZX1rY+tE=; b=
	hq6VWUSCKmIfDCJFfVWARtgyDGb2D0g8sidT6cz0syNuWJkdbniH1ZezLYbZZq2x
	PvBhtiyQD40GN7De0UU7Gnc7hgOHL9YE76Bcg4lOytCgE2bixlMEjgBhD5lnYZc7
	QUS6/6VPITT+JyZXzh11ysDI9SbOBKN9iVnGzqB0YpO8pMZlX0jVvnW74ZBibL19
	tD9ZlGFQXFBc6LKD3dhaCBWIQTt8DGGpUvWle9L5AtKNyefMgPdxtvUQ5ufGv/aJ
	wmbO8uiyEgVCzI7mSLVP7VJLwNCJoOidxuChLGTo82i2yRxhN+7IdfjWIJi58u4e
	b7567DNEQ9yettGjBCf87Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773381337; x=
	1773467737; bh=MS55tKW7uo75BZ/nH+lBMDr/C3AWgJO1u77ZX1rY+tE=; b=G
	dzxk7sLxQB9M9NO+/tqpVNvcYYnvMLpiZVcLjVvRIkqvMxsM+MPAP3dfZii6YJ5P
	Xok8/LxQ+0bngvUOdvTFuyhYm9da7K6TjeneWhf6q+VmeLZ6qcvS9Rji0+C+ZMNE
	tlLXYbS+icC0gYSbaUfofyVJbCoh9lvUpIglClOk8l5QmjPHcqIFkpnQ5rIf+q77
	8As4tSAfe0yzzYzJab5TXsSPwdpi8vHnPlLUZFyRt+b7yg+5J+Uwd3Y7MKHFEnmc
	joKKPXIKRLDwd+CwxpZx8yqLub/BRmbt/9gfzdkohkjj6bNzUU6GD9TdBUBCvtS7
	jZBexfl7ogtfzSEt1HQEA==
X-ME-Sender: <xms:2KazaX_dboI7rf4XdyWEkXWF5j3tk1AfIFWrlNgAqd8BWcyohvJmQQ>
    <xme:2Kazafm3S1NEFzIQS9ClCiZRykhpYE6jHqFSEz4nK6_kCtusWKpW-mZw8kwnFXtK4
    ugkMTkRGO_PWz7B9A-cvHfHeh9H_IMbFPJfpiJ1l6_Boz5kLZtnN-0>
X-ME-Received: <xmr:2KazaQjyJg8KK0cVhQkm5ScPMZs7SZbDNT2o1irbRwxghiNUCPkLO6RPrZ2ISLP31uihEWDtS5T1gERczih6thPZ_F0FRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeegfeejkedvfedutedvgfekfffgtdetieefueeileeuvdduvdeugeel
    iefhgeehveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrthgthh
    gvsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehroh
    gvtghkqdhushdrnhgvthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehprghttghhvghssehkvghrnhgvlhgtihdrohhrgh
X-ME-Proxy: <xmx:2KazaXYn29PTeTtFhuLijSYqUTwaMhF4Rf5HQGq80EVa9GGLaaiYww>
    <xmx:2KazaUGK90n-KStbmKhVQfo26XFFNV61VIzbcffMa_RcAqOCE11bLg>
    <xmx:2KazaUba43Y8kwW-1-jIl2PsaUDK86BeF4x9NMGWyLBWFeKsDNzS6Q>
    <xmx:2KazaV31cEuWErtBNNkj8g7dHcwR1AJwdXRvt9Ymu7XCiPNA-qTkGg>
    <xmx:2aazaWQb_OjPrtNH8A_YJFhw7JKOp_NjYyZXDPaW_4DnMgQ7euSiGtmM>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 01:55:34 -0400 (EDT)
Message-ID: <ee851013-fec8-47f8-9863-392f17e54474@pobox.com>
Date: Thu, 12 Mar 2026 22:55:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: freeze during boot regression Re: [PATCH 6.12 000/265]
 6.12.77-rc1 review
From: "Barry K. Nathan" <barryn@pobox.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260312201018.128816016@linuxfoundation.org>
 <b4f58774-18d4-4a32-9c85-603f9e2c98fc@pobox.com>
Content-Language: en-US
In-Reply-To: <b4f58774-18d4-4a32-9c85-603f9e2c98fc@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-225253-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pobox.com:dkim,pobox.com:email,pobox.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: D597627D809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 22:32, Barry K. Nathan wrote:
> On 3/12/26 13:06, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.12.77 release.
>> There are 265 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 13 Mar 2026 20:09:29 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.77-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Intermittently, but significantly greater than 50% of the time,
> 6.12.77-rc1 fails to boot on my Lenovo ThinkPad T14 Gen 1 running Debian
> 12 bookworm. When boot fails, the last couple lines of console output
> (retyped from a photo) are:
> 
> Loading, please wait...
> Starting systemd-udevd version 252.39-1~deb12u1
> 
> I will begin bisection shortly. I happen to have also previously
> compiled 6.12.76 + stable-queue as of
> commit 4b2b2b5cf3cd78f4de4646687a4efecbd21643af, and that shows the same
> boot failures. That means the following patches are *not* to blame for
> the problem:
[snip]

I also happen to have previously compiled 6.12.76 + stable-queue as of
commit 8d45879cc803965facf8d8257f13d130508b5986, and that also shows
the same boot failures, so that narrows the cause down to the
following 40 patches:

drm-vmwgfx-fix-invalid-kref_put-callback-in-vmw_bo_d.patch
drm-vmwgfx-return-the-correct-value-in-vmw_translate.patch
drm-logicvc-fix-device-node-reference-leak-in-logicv.patch
kvm-arm64-advertise-support-for-feat_sctlr2.patch
kvm-arm64-hide-s1poe-from-guests-when-not-supported-.patch
irqchip-sifive-plic-fix-frozen-interrupt-due-to-affi.patch
scsi-lpfc-properly-set-wc-for-dpp-mapping.patch
scsi-pm8001-fix-use-after-free-in-pm8001_queue_comma.patch
alsa-scarlett2-fix-redeclaration-of-loop-variable.patch
alsa-scarlett2-fix-dsp-filter-control-array-handling.patch
alsa-usb-audio-remove-validate_rates-quirk-for-focus.patch
x86-fred-correct-speculative-safety-in-fred_extint.patch
sched-fair-fix-eevdf-entity-placement-bug-causing-sc.patch
sched-fair-fix-lag-clamp.patch
rseq-clarify-rseq-registration-rseq_size-bound-check.patch
cgroup-cpuset-fix-incorrect-use-of-cpuset_update_tas.patch
scsi-ufs-core-move-link-recovery-for-hibern8-exit-fa.patch
alsa-usb-audio-cap-the-packet-size-pre-calculations.patch
alsa-usb-audio-use-inclusive-terms.patch
perf-fix-__perf_event_overflow-vs-perf_remove_from_c.patch
s390-idle-fix-cpu-idle-exit-cpu-time-accounting.patch
s390-vtime-fix-virtual-timer-forwarding.patch
pci-endpoint-introduce-pci_epc_function_is_valid.patch
pci-endpoint-introduce-pci_epc_mem_map-unmap.patch
pci-dwc-endpoint-implement-the-pci_epc_ops-align_add.patch
pci-dwc-ep-use-align-addr-function-for-dw_pcie_ep_ra.patch
pci-dwc-ep-flush-msi-x-write-before-unmapping-its-at.patch
drm-amdgpu-unlock-a-mutex-before-destroying-it.patch
drm-amdgpu-replace-kzalloc-copy_from_user-with-memdu.patch
drm-amdgpu-fix-locking-bugs-in-error-paths.patch
alsa-pci-hda-use-snd_kcontrol_chip.patch
alsa-hda-cs35l56-fix-signedness-error-in-cs35l56_hda.patch
btrfs-fix-incorrect-key-offset-in-error-message-in-c.patch
btrfs-fix-objectid-value-in-error-message-in-check_e.patch
btrfs-fix-warning-in-scrub_verify_one_metadata.patch
btrfs-print-correct-subvol-num-if-active-swapfile-pr.patch
btrfs-fix-compat-mask-in-error-messages-in-btrfs_che.patch
bpf-arm64-force-8-byte-alignment-for-jit-buffer-to-p.patch
bpf-fix-stack-out-of-bounds-write-in-devmap.patch
pci-correct-pci_cap_exp_endpoint_sizeof_v2-value.patch

I expect my next followup to be once I finish bisection.

-- 
-Barry K. Nathan  <barryn@pobox.com>


