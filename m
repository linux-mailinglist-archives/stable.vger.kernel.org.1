Return-Path: <stable+bounces-240405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGZwCLOb6Wm3ewIAu9opvQ
	(envelope-from <stable+bounces-240405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:10:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9780944CC09
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56D7E30E91D3
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 04:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F38349AF3;
	Thu, 23 Apr 2026 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ldtlb.com header.i=@ldtlb.com header.b="cCrgQD6Z"
X-Original-To: stable@vger.kernel.org
Received: from ldtlb.com (ldtlb.com [52.11.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACA2853EE
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.11.21.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916824; cv=none; b=atUQUXZn9SPw4uS36mH5uoQEe7WJ+JdpdINRX060pAvsbr0gaoooQfgbxo4zlc9EM6xrAqtzoljcFq8mY7VEofTTO0zoEXlYUs7HyQhm9NGqcOXtTqO/rlKJWLb3rTfFIdBmSnAWzB3/D5EfG+JYsX8KQfH3WpCBJypCVhcRAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916824; c=relaxed/simple;
	bh=kpGbs1Qsb8Hzn0bN67bd7NVcaGwp16Z3//0zSoUc+iM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lY6vm3sw6bVsQjTpf+qMNBtC2K75PgZiFYUaYp9sWMtmoD4UQiaxox35g+PMimk1ZhiA74ASOZBxpb2kCv4K+GkDWqoa6HhrkiFziw5uCGQtd9d5aWSxJsVJ9diMatkZClnH+58sLtSVoBhAASwXhX+7vDFJ9i9ffXTHIT71Qkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ldtlb.com; spf=pass smtp.mailfrom=ldtlb.com; dkim=pass (1024-bit key) header.d=ldtlb.com header.i=@ldtlb.com header.b=cCrgQD6Z; arc=none smtp.client-ip=52.11.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ldtlb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ldtlb.com
Date: Wed, 22 Apr 2026 19:53:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ldtlb.com; s=mail;
	t=1776916403; bh=FYQs0UMR7IfJH4eMJZSVIg4o0YenrsVE4l9Rv0CYlyQ=;
	h=Date:From:To:Subject;
	b=cCrgQD6Z/O6V5ENNXLKGw8QecRWUdOzzIDNEEvquIJwoElAscqUSFIzS9KKn3FbXF
	 HjK8Pood+3QN+7FqNAwDcJNDQuxasrSY1vLfaBCI5GBegEydtfdP5TJO/GKtp6xXv+
	 B3swYOxMYCeaWPx2tSbNfIYMRXi9dL10i5PcEUUg=
From: Thomas Sowell <tom@ldtlb.com>
To: stable@vger.kernel.org
Subject: Please backport 3c863ff920b4 ("drm/amdgpu: replace PASID IDR with
 XArray")
Message-ID: <gh5bqoabelvwdkmuvgb2ue7j3g2xw6i6w7upqsh3uefy7uxbym@3zuucinf7pqq>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ldtlb.com,none];
	R_DKIM_ALLOW(-0.20)[ldtlb.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240405-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ldtlb.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@ldtlb.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ldtlb.com:dkim]
X-Rspamd-Queue-Id: 9780944CC09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Please consider backporting mainline commit 3c863ff920b4 ("drm/amdgpu: replace
PASID IDR with XArray") to 6.18.y and 7.0.y. It fixes a regression introduced
in 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case").

Using the reproduction steps below I've confirmed that both 6.18 and 7.0 are
affected by the regression and that 3c863ff920b4 resolves it in both.

On my system I frequently see symptoms with sway and physlock. Locking the
screen with physlock and then unlocking it sometimes leaves sway unable to
display any output, recoverable only by killing sway. Sometimes unlocking
instead hangs the entire machine, requiring a hard reboot. In normal usage
these problems occur intermittently, but I also have a procedure (outlined
below) that reliably triggers lockups.

I've observed this hard lockup:

  watchdog: CPU8: Watchdog detected hard LOCKUP on cpu 8
  CPU: 8 UID: 0 PID: 24349 Comm: drmdevice
  Call Trace:
   <IRQ>
   _raw_spin_lock+0x29/0x30
   amdgpu_pasid_free+0x1a/0x80 [amdgpu]
   amdgpu_pasid_free_cb+0x19/0x60 [amdgpu]
   dma_fence_signal_timestamp_locked+0x8e/0x110
   dma_fence_signal+0x30/0x60
   drm_sched_job_done.isra.0+0x58/0x160 [gpu_sched]
   dma_fence_signal_timestamp_locked+0x8e/0x110
   dma_fence_signal+0x30/0x60
   amdgpu_fence_process+0xe1/0x160 [amdgpu]
   sdma_v5_2_process_trap_irq+0x8d/0x130 [amdgpu]
   amdgpu_irq_dispatch+0x176/0x240 [amdgpu]
   amdgpu_ih_process+0x66/0x190 [amdgpu]
   amdgpu_irq_handler+0x23/0x60 [amdgpu]
   __handle_irq_event_percpu+0x58/0x210
   handle_irq_event+0x3e/0x90
   handle_edge_irq+0xe3/0x1e0
   __common_interrupt+0x47/0xe0
   common_interrupt+0x82/0xa0
   </IRQ>
   <TASK>
   asm_common_interrupt+0x26/0x40
   idr_alloc_u32+0xb9/0x100
   idr_alloc_cyclic+0x55/0xc0
   amdgpu_pasid_alloc+0x44/0xb0 [amdgpu]
   amdgpu_driver_open_kms+0xc5/0x300 [amdgpu]
   drm_file_alloc+0x238/0x370
   drm_open_helper+0x8d/0x160
   drm_open+0x72/0x100

The following steps reproduce it reliably:

1. Start sway
2. Find out which core amdgpu IRQs fire on:
   awk 'NR==1 || /amdgpu/' /proc/interrupts
3. Run libdrm's drmdevice test program
   (https://cgit.freedesktop.org/drm/libdrm/tree/tests/drmdevice.c) in a tight
   loop on the same core:
   while true; do taskset -c $AMDGPU_CORE drmdevice; done
4. If that hasn't triggered it yet, lock and unlock screen with physlock

Thanks!
-- 
Thomas Sowell

