Return-Path: <stable+bounces-192459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC8C3379A
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 01:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3590B3B3983
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 00:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421401FC8;
	Wed,  5 Nov 2025 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b="OYOXHDI6"
X-Original-To: stable@vger.kernel.org
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60834D383
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302635; cv=none; b=O/8dJrS1UL12ktnS8BFmEf4d/D05ylgPLf1t55MQSkXzhXtwlgJ7ZtmSWAZc9iz52ycYDAqfnU4lFwMLZ2I56+dJ6Es0mSxFH9hKXBlyrRzNPK5pGCMfG0vIkb9db9LR/pKOcGc1AAR6SmNpGdHLgMY+ZBSU5xXiIgcja0v2hGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302635; c=relaxed/simple;
	bh=B0acGPKnNqDzaTFtlEoHMHQPjXzHmldwvQ7cJkyLUWg=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=BKMFU8rsrmXIutmWi2+nE1Km7EWn1/4WIJ9yX4/QqT/dKN7lrZ6fcqGxlQhbp4CcpzzAZJrd02Mhrs5PWnHMGoc/Z5x3gOYcIKNGCWAae+p+0Wc9IypMEGQBzXkosMY/ZFEKi/eNEP59soqbqSeLYvP0OSYznRzoPG6BKegzigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msa.hinet.net; spf=pass smtp.mailfrom=msa.hinet.net; dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b=OYOXHDI6; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msa.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msa.hinet.net
Received: from cmsr4.hinet.net ([10.199.216.83])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 5A50UURv834173
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Wed, 5 Nov 2025 08:30:30 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=msa.hinet.net;
	s=default; t=1762302630; bh=pLzjectVXlZDvW9zPNDSEw39gRo=;
	h=From:To:Subject:Date;
	b=OYOXHDI6BA9nLtiDgppVeRM1sgUniUeQMCyI31BPuiDIP8RaFXGCxG+Bpxr6U4TE/
	 t8fOjDogx7GrzYiLV+iosEOBab2n4DVn6Lxbwx5EmClUAW6+g8Irq3jvLHVhz6UIW4
	 1AWmx5lECTP6FOIFOeSybRObrNuvWEkR4OZtnBjU=
Received: from [127.0.0.1] (36-227-114-250.dynamic-ip.hinet.net [36.227.114.250])
	by cmsr4.hinet.net (8.15.2/8.15.2) with ESMTPS id 5A50O6Wb142956
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <stable@vger.kernel.org>; Wed, 5 Nov 2025 08:26:05 +0800
From: Procurement 34870 <Stable@msa.hinet.net>
To: stable@vger.kernel.org
Reply-To: Procurement <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TkVXIFBPIDMzNDQzIFdlZG5lc2RheSwgTm92ZW1iZXIgNSwgMjAyNSBhdCAwMToyNjowMyBBTQ==?=
Message-ID: <d9b00255-bb96-6e13-2379-3b57f4e74dd3@msa.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Nov 2025 00:26:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=e6elSrp/ c=1 sm=1 tr=0 ts=690a999e
	a=fSW3JAhHYbmisyO+z2KVpg==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=751GVyYgdrAhH6-ziKsA:9 a=QEXdDO2ut3YA:10

Hi Stable,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: October

Thanks!

Danny Peddinti

Noble alliance trade

