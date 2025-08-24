Return-Path: <stable+bounces-172766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE8EB3326B
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 21:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D59481550
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFACC220F49;
	Sun, 24 Aug 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4pSv8XM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83231F55FA;
	Sun, 24 Aug 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756065117; cv=none; b=HyU1RGYw90OOYCuUBH9HxM1FJL9EBqIrOVa/t7ONj8CCiaaPlrf+drz9pP+96xj8rMX8+5OEBDOJx3lniHIzdwchYLBlyeXRB0LMXEsEq4ogntXJ1SuPGiGZcnMP6+0nBSGDKmHB9wOI/GCi7d3dYPKiKT4yatdi+9+065ZdCWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756065117; c=relaxed/simple;
	bh=Ft9l8l10jORa4WuKEcaC/HKKB/xD8WoDWmlXGjmBC80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsmzZ1O4RMjZkp5m7zvDEFcVlz5mSzgDTKfOSnSzovFgtrA/QqN71+QWysrmS3bLFx0xGjuZ0ZXc6aRH/haOH+x//CUgiYtlfNJd4qNLzGMBnJ41Jl6rLkmQoIubJVyURgiDPiptTnI6YEtVg+qHJxgFOXzDuZkj44qQVbOkZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4pSv8XM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-246c9de68c8so991815ad.0;
        Sun, 24 Aug 2025 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756065115; x=1756669915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSbYgwO5vOfThgNVPQ8HsTTBNrKnajiyyQJkVZTe+3o=;
        b=O4pSv8XM/9XgrHPFsXvTs8lC7rWIqS3psk/uSDzlkAuK5AavY+r1zCZzBEI+VPKvgA
         y1ZnZWTaMRSE1OHxX9cxOTOLUZHiQhkcFAzmcgzJ2408Db5n8cUJExD+7nJ6LNMpuzuw
         61m7x4/ZIrQyw9vLWUjIHIZahRhFEHGK+DB456lPOYzwpK39zzu/Hnwe8AFJKZOAnqMy
         /4E+r/nU0MwkaRK/WYaoq8QZ9Uxkj5N1DX3IcRe+8kyWzjynPDkVBkl2cIp70b2EfQGI
         SIk7XgzavgGBp0ngQ+JAYEqHpt9uJiB32JFEFITnHQQ2jvvUo4tJaVTT2kDTeMH5WOVk
         JZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756065115; x=1756669915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSbYgwO5vOfThgNVPQ8HsTTBNrKnajiyyQJkVZTe+3o=;
        b=gnDJ5nY/SAqs5eNXeH0X9IBGmJmJoTyYb/iQjIzwH/Y9IaIklDco+HsbB7DjVU1qTn
         y454eS8WgT4vCsPghfGngIPaPGQhUh58x2mkAmMdwufbD4ySqi9zLbYQGMYzhlqe/veQ
         8CdXLq3pLq5ph/SAEcDc0M6ySJzYKEGxk8psIa7wz5uy91iqn6mzWhDKqtc2NYSrHALj
         Az+jpm0KI8US1kDTVZINLkl6W5jE07wTGlAg88oSjSZmkXqt+KuhfXFDl4Nf1/OZkRtU
         AlvioJQJounev2MgTN4lej/FOVZR87BH64M9nqJTbOlLBk58wqKT7+8GaS1rca8fyO9O
         w39A==
X-Forwarded-Encrypted: i=1; AJvYcCUThaw9XKDzgs77dp0sKwc1k3K62hcDHWR3xDZczPEH0y1oLuM3xR+8LnPpoaWkPISN/7wCTBkC@vger.kernel.org, AJvYcCWq4cNozJMDa8ncZC2VJOZKSgl+i2W0rq7PGnQ4O5Q9fdlSlqRh+qRUVH1o7UqPyLlv2OqENBLI+JfyU44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGG/r9oenrD/ugOPM5D/YVY4wpq4SrksUyrmGHaatl6pLu4WyI
	swsSYVABP4y2RFkl/UxkupxZDe0Ak5qJdw6O55orov5WjTU8M1m3pvUR
X-Gm-Gg: ASbGncsBHOVNOccK3WYPBPkpBxZuT9+kLc1+5WRhP6upUU5rgK8lc0BwXH54ROhcjRi
	sEM5yZUmsl5gbv2jDULjUf9L1IdAA0wWuxKb2DYd9f4G7VxD+uXh9wceB/xQc8MvAw9NBE9Y1RT
	pzliw3el73Q7SNn5nSMUg75l8sXACnLcH0/xaltqHFT2OZZfncHQe0Eq2GJrkvs84DLJgR98R6U
	z71PUX7u9lxtZ4Y9AGX234qgUWLDPHaCWgQlBvifDUy7kPE4GOSp4zTIroAPM4mMq06UrdI+2qy
	UraUWhlTCJ4/oVV7jf8nbJHVy+9VYnFw9jwR9rJZJlhCMiiGcsLU+eMUewaAqFCn+NS3H/yg9zj
	b197I4nVIdZlNzMShNWh/XfqRQMJKkgkfJ8rdmRk77iP/b2J2qaRMlEXX0YeW5bPABG1mxuId
X-Google-Smtp-Source: AGHT+IEJktoEvbAHqn4BxZJ+owjEzadDJBE4EA2ON3FRwiZukspyyJ9an/9Wg9TP89jwjCHdivi2CQ==
X-Received: by 2002:a17:902:d48b:b0:246:5253:6dfc with SMTP id d9443c01a7336-24652537015mr60315495ad.7.1756065114744;
        Sun, 24 Aug 2025 12:51:54 -0700 (PDT)
Received: from [172.28.221.105] (S0106a85e45f3df00.vc.shawcable.net. [174.7.235.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ae8a2d9sm5049405a91.8.2025.08.24.12.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 12:51:54 -0700 (PDT)
Message-ID: <d93d798e-bb24-4481-8049-17cbdf2f6172@gmail.com>
Date: Sun, 24 Aug 2025 12:51:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] - BROKEN NETWORKING Re: Linux 6.16.3
To: Calvin Owens <calvin@wbinvd.org>, Willy Tarreau <w@1wt.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
 jslaby@suse.cz
References: <2025082354-halogen-retaliate-a8ba@gregkh>
 <cfd4d3bd-cd0e-45dc-af9b-b478a56f8942@gmail.com>
 <20250824185526.GA958@1wt.eu> <aKtoHev5AogCje9R@mozart.vkv.me>
Content-Language: en-CA
From: Kyle Sanderson <kyle.leet@gmail.com>
In-Reply-To: <aKtoHev5AogCje9R@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/24/2025 12:29 PM, Calvin Owens wrote:
> On Sunday 08/24 at 20:55 +0200, Willy Tarreau wrote:
>> Hello,
>>
>> Based on your links and descriptions above I suspect that instead it's a
>> 6.15 to 6.16 regression that was brought by a0285236ab93 and that commit
>> e67a0bc3ed4fd above fixed it in 6.17-rc2, is that it ? If so, can you
>> apply that patch to confirm that it works and is desired in 6.16.x ?
> 
> Yeah. 6.16-stable needs c5ec7f49b480 and e67a0bc3ed4f, I was going to
> bring this up next but Kyle beat me to it :)
> 
> Kyle, do you want to send them to stable@, or should I do it?
> 
> Thanks,
> Calvin

If you are able to Calvin that would be appreciated.

Thank you Willy for providing tighter information - I was trying to 
indicate this was still a present problem as opposed to a "reporting the 
news" for something that had already been resolved.

Finally, the fact on a quad interface I have a eno4np1 and a eno3np0 
just seems bizarre (note the first number incrementing and not having a 
eno{1,2}np{0,1}).

lspci at the end.

Hopefully no one else hits this post 6.16.4.
Kyle.


 >06:00.0 Ethernet controller: Intel Corporation Ethernet Connection 
X553 1GbE (rev 11)
 >        DeviceName: Intel Ethernet X553 SGMII #1
 >        Subsystem: Intel Corporation Ethernet Connection X553 1GbE
 >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
 >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
 >        Latency: 0, Cache Line Size: 64 bytes
 >        Interrupt: pin A routed to IRQ 16
 >        IOMMU group: 19
 >        Region 0: Memory at ddc00000 (64-bit, prefetchable) [size=2M]
 >        Region 4: Memory at dde04000 (64-bit, prefetchable) [size=16K]
 >        Expansion ROM at df680000 [disabled] [size=512K]
 >        Capabilities: [40] Power Management version 3
 >                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
 >                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 >        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
 >                Address: 0000000000000000  Data: 0000
 >                Masking: 00000000  Pending: 00000000
 >        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
 >                Vector table: BAR=4 offset=00000000
 >                PBA: BAR=4 offset=00002000
 >        Capabilities: [a0] Express (v2) Endpoint, MSI 00
 >                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
 >                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ 
FLReset+ SlotPowerLimit 0W
 >                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 >                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- 
FLReset-
 >                        MaxPayload 128 bytes, MaxReadReq 512 bytes
 >                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ 
AuxPwr+ TransPend-
 >                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s <64ns, L1 <1us
 >                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 >                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 >                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 >                LnkSta: Speed 2.5GT/s, Width x1
 >                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 >                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
NROPrPrP- LTR-
 >                         10BitTagComp- 10BitTagReq- OBFF Not 
Supported, ExtFmt- EETLPPrefix-
 >                         EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
 >                         FRS- TPHComp- ExtTPHComp-
 >                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 >                DevCtl2: Completion Timeout: 260ms to 900ms, 
TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
 >                         AtomicOpsCtl: ReqEn-
 >                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-
 >                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
 >                         Compliance Preset/De-emphasis: -6dB 
de-emphasis, 0dB preshoot
 >                LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete- EqualizationPhase1-
 >                         EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
 >                         Retimer- 2Retimers- CrosslinkRes: unsupported
 >        Capabilities: [100 v2] Advanced Error Reporting
 >                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 >                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 >                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 >                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
 >                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
 >                AERCap: First Error Pointer: 00, ECRCGenCap+ 
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 >                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- 
HdrLogCap-
 >                HeaderLog: 00000000 00000000 00000000 00000000
 >        Capabilities: [140 v1] Device Serial Number 
00-00-c9-ff-ff-00-00-00
 >        Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
 >                ARICap: MFVC- ACS-, Next Function: 1
 >                ARICtl: MFVC- ACS-, Function Group: 0
 >        Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
 >                IOVCap: Migration- 10BitTagReq- Interrupt Message 
Number: 000
 >                IOVCtl: Enable- Migration- Interrupt- MSE- 
ARIHierarchy+ 10BitTagReq-
 >                IOVSta: Migration-
 >                Initial VFs: 64, Total VFs: 64, Number of VFs: 0, 
Function Dependency Link: 00
 >                VF offset: 128, stride: 2, Device ID: 15c5
 >                Supported Page Size: 00000553, System Page Size: 00000001
 >                Region 0: Memory at 00000000dfa00000 (64-bit, 
non-prefetchable)
 >                Region 3: Memory at 00000000df900000 (64-bit, 
non-prefetchable)
 >                VF Migration: offset: 00000000, BIR: 0
 >        Capabilities: [1b0 v1] Access Control Services
 >                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
 >                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
 >        Kernel driver in use: ixgbe
 >        Kernel modules: ixgbe
 >
 >06:00.1 Ethernet controller: Intel Corporation Ethernet Connection 
X553 1GbE (rev 11)
 >        DeviceName: Intel Ethernet X553 SGMII #2
 >        Subsystem: Intel Corporation Ethernet Connection X553 1GbE
 >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
 >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
 >        Latency: 0, Cache Line Size: 64 bytes
 >        Interrupt: pin B routed to IRQ 17
 >        IOMMU group: 20
 >        Region 0: Memory at dda00000 (64-bit, prefetchable) [size=2M]
 >        Region 4: Memory at dde00000 (64-bit, prefetchable) [size=16K]
 >        Expansion ROM at df600000 [disabled] [size=512K]
 >        Capabilities: [40] Power Management version 3
 >                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
 >                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 >        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
 >                Address: 0000000000000000  Data: 0000
 >                Masking: 00000000  Pending: 00000000
 >        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
 >                Vector table: BAR=4 offset=00000000
 >                PBA: BAR=4 offset=00002000
 >        Capabilities: [a0] Express (v2) Endpoint, MSI 00
 >                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
 >                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ 
FLReset+ SlotPowerLimit 0W
 >                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 >                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- 
FLReset-
 >                        MaxPayload 128 bytes, MaxReadReq 512 bytes
 >                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ 
AuxPwr+ TransPend-
 >                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s <64ns, L1 <1us
 >                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 >                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 >                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 >                LnkSta: Speed 2.5GT/s, Width x1
 >                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 >                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
NROPrPrP- LTR-
 >                         10BitTagComp- 10BitTagReq- OBFF Not 
Supported, ExtFmt- EETLPPrefix-
 >                         EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
 >                         FRS- TPHComp- ExtTPHComp-
 >                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 >                DevCtl2: Completion Timeout: 260ms to 900ms, 
TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
 >                         AtomicOpsCtl: ReqEn-
 >                LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete- EqualizationPhase1-
 >                         EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
 >                         Retimer- 2Retimers- CrosslinkRes: unsupported
 >        Capabilities: [100 v2] Advanced Error Reporting
 >                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 >                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 >                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 >                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
 >                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
 >                AERCap: First Error Pointer: 00, ECRCGenCap+ 
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 >                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- 
HdrLogCap-
 >                HeaderLog: 00000000 00000000 00000000 00000000
 >        Capabilities: [140 v1] Device Serial Number 
00-00-c9-ff-ff-00-00-00
 >        Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
 >                ARICap: MFVC- ACS-, Next Function: 0
 >                ARICtl: MFVC- ACS-, Function Group: 0
 >        Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
 >                IOVCap: Migration- 10BitTagReq- Interrupt Message 
Number: 000
 >                IOVCtl: Enable- Migration- Interrupt- MSE- 
ARIHierarchy- 10BitTagReq-
 >                IOVSta: Migration-
 >                Initial VFs: 64, Total VFs: 64, Number of VFs: 0, 
Function Dependency Link: 01
 >                VF offset: 128, stride: 2, Device ID: 15c5
 >                Supported Page Size: 00000553, System Page Size: 00000001
 >                Region 0: Memory at 00000000df800000 (64-bit, 
non-prefetchable)
 >                Region 3: Memory at 00000000df700000 (64-bit, 
non-prefetchable)
 >                VF Migration: offset: 00000000, BIR: 0
 >        Capabilities: [1b0 v1] Access Control Services
 >                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
 >                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
 >        Kernel driver in use: ixgbe
 >        Kernel modules: ixgbe
 >
 >08:00.0 Ethernet controller: Intel Corporation Ethernet Connection 
X553 1GbE (rev 11)
 >        DeviceName: Intel Ethernet X553 SGMII #3
 >        Subsystem: Intel Corporation Ethernet Connection X553 1GbE
 >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
 >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
 >        Latency: 0, Cache Line Size: 64 bytes
 >        Interrupt: pin A routed to IRQ 17
 >        IOMMU group: 21
 >        Region 0: Memory at dd600000 (64-bit, prefetchable) [size=2M]
 >        Region 4: Memory at dd804000 (64-bit, prefetchable) [size=16K]
 >        Expansion ROM at df180000 [disabled] [size=512K]
 >        Capabilities: [40] Power Management version 3
 >                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
 >                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 >        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
 >                Address: 0000000000000000  Data: 0000
 >                Masking: 00000000  Pending: 00000000
 >        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
 >                Vector table: BAR=4 offset=00000000
 >                PBA: BAR=4 offset=00002000
 >        Capabilities: [a0] Express (v2) Endpoint, MSI 00
 >                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
 >                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ 
FLReset+ SlotPowerLimit 0W
 >                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 >                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- 
FLReset-
 >                        MaxPayload 128 bytes, MaxReadReq 512 bytes
 >                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ 
AuxPwr+ TransPend-
 >                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s <64ns, L1 <1us
 >                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 >                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 >                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 >                LnkSta: Speed 2.5GT/s, Width x1
 >                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 >                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
NROPrPrP- LTR-
 >                         10BitTagComp- 10BitTagReq- OBFF Not 
Supported, ExtFmt- EETLPPrefix-
 >                         EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
 >                         FRS- TPHComp- ExtTPHComp-
 >                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 >                DevCtl2: Completion Timeout: 260ms to 900ms, 
TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
 >                         AtomicOpsCtl: ReqEn-
 >                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-
 >                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
 >                         Compliance Preset/De-emphasis: -6dB 
de-emphasis, 0dB preshoot
 >                LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete- EqualizationPhase1-
 >                         EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
 >                         Retimer- 2Retimers- CrosslinkRes: unsupported
 >        Capabilities: [100 v2] Advanced Error Reporting
 >                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 >                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 >                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 >                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
 >                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
 >                AERCap: First Error Pointer: 00, ECRCGenCap+ 
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 >                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- 
HdrLogCap-
 >                HeaderLog: 00000000 00000000 00000000 00000000
 >        Capabilities: [140 v1] Device Serial Number 
01-00-c9-ff-ff-00-00-00
 >        Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
 >                ARICap: MFVC- ACS-, Next Function: 1
 >                ARICtl: MFVC- ACS-, Function Group: 0
 >        Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
 >                IOVCap: Migration- 10BitTagReq- Interrupt Message 
Number: 000
 >                IOVCtl: Enable- Migration- Interrupt- MSE- 
ARIHierarchy+ 10BitTagReq-
 >                IOVSta: Migration-
 >                Initial VFs: 64, Total VFs: 64, Number of VFs: 0, 
Function Dependency Link: 00
 >                VF offset: 128, stride: 2, Device ID: 15c5
 >                Supported Page Size: 00000553, System Page Size: 00000001
 >                Region 0: Memory at 00000000df500000 (64-bit, 
non-prefetchable)
 >                Region 3: Memory at 00000000df400000 (64-bit, 
non-prefetchable)
 >                VF Migration: offset: 00000000, BIR: 0
 >        Capabilities: [1b0 v1] Access Control Services
 >                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
 >                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
 >        Kernel driver in use: ixgbe
 >        Kernel modules: ixgbe
 >
 >08:00.1 Ethernet controller: Intel Corporation Ethernet Connection 
X553 1GbE (rev 11)
 >        DeviceName: Intel Ethernet X553 SGMII #4
 >        Subsystem: Intel Corporation Ethernet Connection X553 1GbE
 >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR+ FastB2B- DisINTx+
 >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
 >        Latency: 0, Cache Line Size: 64 bytes
 >        Interrupt: pin B routed to IRQ 18
 >        IOMMU group: 22
 >        Region 0: Memory at dd400000 (64-bit, prefetchable) [size=2M]
 >        Region 4: Memory at dd800000 (64-bit, prefetchable) [size=16K]
 >        Expansion ROM at df100000 [disabled] [size=512K]
 >        Capabilities: [40] Power Management version 3
 >                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
 >                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
 >        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
 >                Address: 0000000000000000  Data: 0000
 >                Masking: 00000000  Pending: 00000000
 >        Capabilities: [70] MSI-X: Enable+ Count=64 Masked-
 >                Vector table: BAR=4 offset=00000000
 >                PBA: BAR=4 offset=00002000
 >        Capabilities: [a0] Express (v2) Endpoint, MSI 00
 >                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
 >                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ 
FLReset+ SlotPowerLimit 0W
 >                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
 >                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- 
FLReset-
 >                        MaxPayload 128 bytes, MaxReadReq 512 bytes
 >                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ 
AuxPwr+ TransPend-
 >                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s <64ns, L1 <1us
 >                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
 >                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
 >                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
 >                LnkSta: Speed 2.5GT/s, Width x1
 >                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
 >                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
NROPrPrP- LTR-
 >                         10BitTagComp- 10BitTagReq- OBFF Not 
Supported, ExtFmt- EETLPPrefix-
 >                         EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
 >                         FRS- TPHComp- ExtTPHComp-
 >                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
 >                DevCtl2: Completion Timeout: 260ms to 900ms, 
TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
 >                         AtomicOpsCtl: ReqEn-
 >                LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete- EqualizationPhase1-
 >                         EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
 >                         Retimer- 2Retimers- CrosslinkRes: unsupported
 >        Capabilities: [100 v2] Advanced Error Reporting
 >                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 >                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
 >                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
 >                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
 >                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
 >                AERCap: First Error Pointer: 00, ECRCGenCap+ 
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
 >                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- 
HdrLogCap-
 >                HeaderLog: 00000000 00000000 00000000 00000000
 >        Capabilities: [140 v1] Device Serial Number 
01-00-c9-ff-ff-00-00-00
 >        Capabilities: [150 v1] Alternative Routing-ID Interpretation (ARI)
 >                ARICap: MFVC- ACS-, Next Function: 0
 >                ARICtl: MFVC- ACS-, Function Group: 0
 >        Capabilities: [160 v1] Single Root I/O Virtualization (SR-IOV)
 >                IOVCap: Migration- 10BitTagReq- Interrupt Message 
Number: 000
 >                IOVCtl: Enable- Migration- Interrupt- MSE- 
ARIHierarchy- 10BitTagReq-
 >                IOVSta: Migration-
 >                Initial VFs: 64, Total VFs: 64, Number of VFs: 0, 
Function Dependency Link: 01
 >                VF offset: 128, stride: 2, Device ID: 15c5
 >                Supported Page Size: 00000553, System Page Size: 00000001
 >                Region 0: Memory at 00000000df300000 (64-bit, 
non-prefetchable)
 >                Region 3: Memory at 00000000df200000 (64-bit, 
non-prefetchable)
 >                VF Migration: offset: 00000000, BIR: 0
 >        Capabilities: [1b0 v1] Access Control Services
 >                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
 >                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
 >        Kernel driver in use: ixgbe
 >        Kernel modules: ixgbe
 >
 >

