Return-Path: <stable+bounces-144335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD5AB64E7
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 09:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0862E1B63EEC
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F7202C48;
	Wed, 14 May 2025 07:53:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86E283A14
	for <stable@vger.kernel.org>; Wed, 14 May 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209217; cv=none; b=mE88tBhn/MKfO8/bmkBclMna/Npz+8gsrzSDlCN/T+/zJOJY77E44jHXyekb/YZ5bCfPW6bJSUNPOxUqVZYWmNrhNNLv6EHPQo2TUOOuuUIce4FgBOVy0Azn/zy0DbsJj+ONVdfpdpWTDBE+6AbbvyRMS8VFr4gU5MRAlNcbwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209217; c=relaxed/simple;
	bh=ePQj12+kP/fSUrskD3vYrwmQ5+N5TwtKil6qGYmKzq0=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=JMmqE73eEwfFnosErj72dcpElu1Js8MpvRIwbG+X+JcCbPVUvj4DfO2ExxJIjAlAQMhVSF69WiKAbPr28Arryoe1/KudxZ5vDT+rUH8iV/Pc1loNbSm1LkvCdMnoo4NMV6bfvmMtLlHqkLE3kiCzC2PY8UCGfs4VorM/s1PoM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b07e9b7.dip0.t-ipconnect.de [91.7.233.183])
	by mail.itouring.de (Postfix) with ESMTPSA id 2EF6F12500D;
	Wed, 14 May 2025 09:45:41 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 00F7B6018BE80;
	Wed, 14 May 2025 09:45:40 +0200 (CEST)
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: 6.14.7-rc1: undefined reference to `__x86_indirect_its_thunk_array'
 when CONFIG_CPU_MITIGATIONS is off
Organization: Applied Asynchrony, Inc.
Message-ID: <0fd6d544-c045-4cf5-e5ab-86345121b76a@applied-asynchrony.com>
Date: Wed, 14 May 2025 09:45:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

While trying to build 6.14.7-rc1 with CONFIG_CPU_MITIGATIONS unset:

   LD      .tmp_vmlinux1
ld: arch/x86/net/bpf_jit_comp.o: in function `emit_indirect_jump':
/tmp/linux-6.14.7/arch/x86/net/bpf_jit_comp.c:660:(.text+0x97e): undefined reference to `__x86_indirect_its_thunk_array'
make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
make[1]: *** [/tmp/linux-6.14.7/Makefile:1234: vmlinux] Error 2
make: *** [Makefile:251: __sub-make] Error 2

- applying 9f35e33144ae aka "x86/its: Fix build errors when CONFIG_MODULES=n"
did not help

- mainline at 9f35e33144ae does not have this problem (same config)

Are we missing a commit in stable?

I temporarily threw "if (IS_ENABLED(CONFIG_MITIGATION_ITS))" around
the problematic feature check and that made it work, but I get the
feeling that cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS) is
implemented differently than the other feature checks and/or is
missing something.

thanks
Holger

