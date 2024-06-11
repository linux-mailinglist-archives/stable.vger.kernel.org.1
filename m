Return-Path: <stable+bounces-50138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A43B903388
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E4E1C2413C
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 07:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228B15AAC6;
	Tue, 11 Jun 2024 07:27:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E051E52F
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090842; cv=none; b=QDpO9dInjzY1mbfrLmMpdpBrFDtGvrxlsbIhKdrnDwERT8NCSQZ/NBtKaDHTU/ajGBmtfhuuICMYzu833fNpV1EWL6gfPEIV0M3rsUF+6CYpBWRJoRVnVLAS/+kk04N0Xa17iViF3R/zw8EUTQ4M0bbKVPHhQm2q1WEWt2PpPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090842; c=relaxed/simple;
	bh=5bxCG3+gotls8eatZ7xZptSxfOj7FP4AQyfvwzRIafk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gVfTOLnOFkZFeqRBH/C7fngRx5wzqH/p4v7IhWsl02RDN7ldd+JMNdsKX/9Jnef9TWF9028WpcIHE34sXAaligtwGPjV4+hrWmZdt0ewqZhJ6+8JZmc29j8+QiPneVYsdaJ6K9+9YfgToD+HGrAvrn9RjHnINwebEPICefgiVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id BB8E7ECDAE5;
	Tue, 11 Jun 2024 09:20:35 +0200 (CEST)
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id 976C0ECDAE2;
	Tue, 11 Jun 2024 09:20:35 +0200 (CEST)
Date: Tue, 11 Jun 2024 09:20:33 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: stable@vger.kernel.org, David Howells <dhowells@redhat.com>, 
    Steve French <stfrench@microsoft.com>
Subject: 6.6.y: cifs broken since 6.6.23 writing big files with vers=1.0 and
 2.0
Message-ID: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.103.11/27302/Mon Jun 10 10:25:43 2024


Hello,

a machine booted with Linux 6.6.23 up to 6.6.32:

writing /dev/zero with dd on a mounted cifs share with vers=1.0 or
vers=2.0 slows down drastically in my setup after writing approx. 46GB of
data.

The whole machine gets unresponsive as it was under very high IO load. It 
pings but opening a new ssh session needs too much time. I can stop the dd 
(ctrl-c) and after a few minutes the machine is fine again.

cifs with vers=3.1.1 seems to be fine with 6.6.32.
Linux 6.10-rc3 is fine with vers=1.0 and vers=2.0.

Bisected down to:

cifs-fix-writeback-data-corruption.patch
which is:
Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
and
linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240

Reverting this patch on 6.6.32 fixes the problem for me.


       Thomas



