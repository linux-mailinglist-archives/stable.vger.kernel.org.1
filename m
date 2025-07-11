Return-Path: <stable+bounces-161648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A788B01B8A
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0223766142
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 12:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D2128C2D2;
	Fri, 11 Jul 2025 12:10:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBBC28F50F
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235816; cv=none; b=Kc6BYidSLAZ1dkfxYLF6faaq4tjxZx0XteiueskCliOLySD7mohDc49LwoF04EXjKS5FYB+s5sp2mZlQ9Xi7gxx48guSpsTp51UiHkdLiFfZ/xlmULLhgTf0hVHspnv8OkGvHiZmIRlcfolIxcPrmaC0Zb+Ct0nWyh6amuX/r1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235816; c=relaxed/simple;
	bh=EgKl6wtfFarD3ilHKVdr/k9LaXsNwEFR7ts13Lp2H+o=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=gb7waZvxwOd7ZSLDpJymL4YTp5lofmr+9TgclvTMmlyJj7stNI/E9mOoWj65UF8Z0U+fhLg1JVva2XCyEdVYecs4uEIjwkY2vX54fsu0tFqMCyfc6DtUhqBXsPfAJuNDIEsxreDhtfikcHSEtQRe/OguudS+oTEDzAKIffY1Keg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id 578C4EC0059;
	Fri, 11 Jul 2025 14:03:33 +0200 (CEST)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id 07B6DEC0056;
	Fri, 11 Jul 2025 14:03:33 +0200 (CEST)
Date: Fri, 11 Jul 2025 14:03:31 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: stable@vger.kernel.org
cc: kim.phillips@amd.com, bp@alien8.de
Subject: TSA mitigation doesn't work on 6.6.y
Message-ID: <04ea0a8e-edb0-c59e-ce21-5f3d5d167af3@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 1.4.3/27696/Fri Jul 11 11:27:41 2025


Hello,

with kernel v6.16-rc5-121-gbc9ff192a6c9 I see this:

cat /sys/devices/system/cpu/vulnerabilities/tsa
Mitigation: Clear CPU buffers

dmesg | grep micro
[    1.479203] microcode: Current revision: 0x0a20102e
[    1.479206] microcode: Updated early from: 0x0a201016

So, this works.

but same machine with 6.6.97:
dmesg | grep micro
[    0.451496] Transient Scheduler Attacks: Vulnerable: Clear CPU buffers
attempted, no microcode
[    1.077149] microcode: Current revision: 0x0a20102e
[    1.077152] microcode: Updated early from: 0x0a201016

so:
cat /sys/devices/system/cpu/vulnerabilities/tsa
Vulnerable: Clear CPU buffers attempted, no microcode

but it is switched on:
zcat /proc/config.gz | grep TSA
CONFIG_MITIGATION_TSA=y

And other stuff which need microcode works:
cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
Mitigation: Safe RET

without microcode you wwould see:
Vulnerable: Safe RET, no microcode


6.12.37 broken too
6.15.6 works
v6.16-rc5-121-gbc9ff192a6c9 works


This is a:
processor       : 11
vendor_id       : AuthenticAMD
cpu family      : 25
model           : 33
model name      : AMD Ryzen 5 5600X 6-Core Processor
stepping        : 0
microcode       : 0xa20102e


Is something missing in 6.6.y and 6.12.y?


     Thomas


