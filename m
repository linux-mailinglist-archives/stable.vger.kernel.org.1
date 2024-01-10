Return-Path: <stable+bounces-10437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48511829A41
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 13:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB40B20943
	for <lists+stable@lfdr.de>; Wed, 10 Jan 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19104481A8;
	Wed, 10 Jan 2024 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ntlworld.com header.i=@ntlworld.com header.b="NMTgxFaQ"
X-Original-To: stable@vger.kernel.org
Received: from dsmtpq2-prd-nl1-vmo.edge.unified.services (dsmtpq2-prd-nl1-vmo.edge.unified.services [84.116.6.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50B47F7B
	for <stable@vger.kernel.org>; Wed, 10 Jan 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntlworld.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntlworld.com
Received: from csmtpq2-prd-nl1-vmo.edge.unified.services ([84.116.50.37])
	by dsmtpq2-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <shaky.start@ntlworld.com>)
	id 1rNXCS-00G8wx-3a
	for stable@vger.kernel.org; Wed, 10 Jan 2024 12:56:48 +0100
Received: from csmtp2-prd-nl1-vmo.nl1.unified.services ([100.107.82.134] helo=csmtp2-prd-nl1-vmo.edge.unified.services)
	by csmtpq2-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <shaky.start@ntlworld.com>)
	id 1rNXCJ-000mwJ-Rz
	for stable@vger.kernel.org; Wed, 10 Jan 2024 12:56:39 +0100
Received: from [192.168.0.37] ([82.26.39.196])
	by csmtp2-prd-nl1-vmo.edge.unified.services with ESMTPA
	id NXCJrfPss6YCcNXCJr9qZr; Wed, 10 Jan 2024 12:56:39 +0100
X-SourceIP: 82.26.39.196
X-Authenticated-Sender: shaky.start@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=auO0CzZV c=1 sm=1 tr=0 ts=659e85f7 cx=a_exe
 a=PQm/cASMPoKUPy80G5uqbg==:117 a=PQm/cASMPoKUPy80G5uqbg==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=z-n8faunNKXTG8fyN2AA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
	s=meg.feb2017; t=1704887799;
	bh=A2i7qTM5U2xEfvOQmcs9KDcoXLgiS9N+Az2nzguhkGI=;
	h=Date:To:Cc:From:Subject;
	b=NMTgxFaQbaFIVPb0N4D496JrZ/+p5SXOzlbWsltGA45fn4v2zAwgN7PmpflWwOyTE
	 qASc7KNG10LMJGJvdnYoJfxwfo8lkqKLw1LH3O5W/RMPYBATTxd5HorZZBx3mvbX4f
	 CA1GyV5Bl+BMkSaRbs/XRWcFk/ZN4vtrbXovV+2zwPqcrCtaW1NIKHa3MqK9AmWa9P
	 ubWv5JwX0dMyc2NPFfRsCH+IaZZnuJJv1V84NqTMwib3bmoU8XLJ1O6Da8U3IStIDv
	 XYkbezj+t/OaOHUp7ICcxxQ0r9B561BnYnfgUo+v1EPSVNVMkj71p8GZHkQWIN36C+
	 bI+HQfFxMzdrA==
Message-ID: <7fb16281-e94f-46d0-808b-81f892c287ec@ntlworld.com>
Date: Wed, 10 Jan 2024 11:56:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
From: tony Hamilton <shaky.start@ntlworld.com>
Subject: Advice on where to seek advice
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGLkDK3qeY1rVF/EZuuPqXg9Bh4MidOHnexp8wwq1Qnhrp38334PWzYkAr/y1ENs3nNE75C27RSlx2ATTpbZ0fdq2jy4/q75uSBemGxnYwfe5QnfvVJp
 UeOD7EVGBxM2k312fNkCtEjAPtEdbEjDh/X9888DIwV7tMrnyB1kz8cQ24qoEUWmcHFktxk8BPbaEOxUEpDQb2/+hiZiKdW7IzBpxxPITOgQkjnpfrLCXXMD
 togJBMeo/NMhEEgABXU6pw==

This is a request for guidance on where is the most appropriate I should ask
for advice on how to do problem source identification on a problem with a
Linux PC which looks like it might be kernel-related. I an providing the
minimal amount of problem symptom information here that will help responders.

Simple problem statement: My PC (Gigabyte GA-H81M-S2H based) will not start
the OS (Linux MX 23.2, Debian 12, Kernel 6.2) if my PCIE GPU card (ZOTAC
nVidia GTX-1050) is installed. The start-up process hangs after Grub is
processed but before the Login screen is presented. Start-up completes
normally when the PCIE card is not installed.

Further detail:
The ZOTAC card works without issue in another PC with a different brand
motherboard.

This PC works without issue, with the ZOTAC card installed, with a different
kernel/distribution (e.g. Mint 21.2, Ubuntu 22.04, Kernel 5.15/5.19 or Windows
10).

With any Linux version installed in this PC, which uses a Via chip, operation
is subject to the issue which prevents USB 3 operation on back plane ports,
unless ‘iommu=off’ is set in grub. This might be an entirely different problem
to that associated with the presence of the PCIE card.

Who should I be seeking help/advice problem resolution from ?

