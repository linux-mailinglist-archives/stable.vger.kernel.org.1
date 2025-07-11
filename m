Return-Path: <stable+bounces-161627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C7B011AD
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 05:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0FA7B2F22
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 03:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D516F265;
	Fri, 11 Jul 2025 03:39:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F5199237
	for <stable@vger.kernel.org>; Fri, 11 Jul 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752205146; cv=none; b=FJmZ4o4cn21bKlKbKP+cDqyZrlVPa1tAtAX6bWq/RFDXHu4l4mqL3kzq7TuhBn+hpnkHPd5rsx0EacMHLZm9q8M6RaObpe952I49EB/gMTMVaqB8E466FglcyhtdQRIf8yl+QmMsuJObbDs6R9tRtybmu3qVk7f5Lg+M+C7GUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752205146; c=relaxed/simple;
	bh=L76v7Kysqy8u3SVSXDnGKO/KuqcyNLMG7VJnQ6v8Xz4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WkW6jeFjBmi7PuDm8yGTB3LeRJZYMdrN7UA6EjGlIn/lKBVatPgVZyWSshFKlztZOyz+jwhppQpvyG5d+zsR5bdzaTU/W9PJQ0SQMfilbaOGITK1/TjWkuKCiKkCLgJlPJhkOH049eXDb0hRDvLqDJiZnnc/XPAb3I3VFN2VMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.44])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id a4f59366 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Jul 2025 13:32:19 +1000 (AEST)
Received: from localhost (largo.jsg.id.au [local])
	by largo.jsg.id.au (OpenSMTPD) with ESMTPA id 2faa08d5;
	Fri, 11 Jul 2025 13:32:18 +1000 (AEST)
Date: Fri, 11 Jul 2025 13:32:18 +1000
From: Jonathan Gray <jsg@jsg.id.au>
To: stable@vger.kernel.org
Cc: flora.cui@amd.com, alexander.deucher@amd.com
Subject: 6.12 drm/amdgpu ip discovery for legacy asics
Message-ID: <aHCFws53G5vjFheh@largo.jsg.id.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After 6.12.36, amdgpu on a picasso apu prints an error:
"get invalid ip discovery binary signature".

Both with and without picasso_ip_discovery.bin from
linux-firmware 20250708.

The error is avoided by backporting more ip discovery patches.

25f602fbbcc8 drm/amdgpu/discovery: use specific ip_discovery.bin for legacy asics
2f6dd741cdcd drm/amdgpu/ip_discovery: add missing ip_discovery fw

second is a fix for the first

