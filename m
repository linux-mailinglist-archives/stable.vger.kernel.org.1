Return-Path: <stable+bounces-217840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NMtGg3xnGkaMQQAu9opvQ
	(envelope-from <stable+bounces-217840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 01:30:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B654B1803BF
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 01:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0141F30A1558
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F2F21CC71;
	Tue, 24 Feb 2026 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjKLQwPD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2E57C9F
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771893001; cv=none; b=exPAWe4H1w8NWvQX4jGeP34a7Gmhb8RXLTcvKt7KZlrZ5CLcmOJdkcLIfNK2iwCE60bemAs237Tpfo1jdUi/4Oq00meuwsVNsyk+myB9Mz4UXbc2BB8luic6OPUr8KSzg6BKBBqR6aK7vpej5cp4BB5VtBCgJlMbsFOUaoUDH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771893001; c=relaxed/simple;
	bh=Ss6ZTxrHbYOCDB4mcE0GCmvCSZZwZI9YPzMMbU+BLKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqEunXDkeZVosM+3hq+KcI3owQRk/l3y8uCZf4qJ6z5c0i+0ICjypgRr+XvfJYH1f03/Mo/JlNPqi2CriprpVHpAGjUR2/VHIRzzrZOZV+5bARGwaOfzTiFDhq8BaR8Bq8RjDB9HWL2GpeNmJCB/3o9kwEiKSXYgaugJ3Th2SIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjKLQwPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0008C116C6;
	Tue, 24 Feb 2026 00:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771893000;
	bh=Ss6ZTxrHbYOCDB4mcE0GCmvCSZZwZI9YPzMMbU+BLKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xjKLQwPD29T+tGQuSvtYtD+2OkHxMLdWau/HCWIw0KxPR3sI1sOMOQWjztNAPl3lP
	 zO/pzEEXRjeUdh+zu2Zu17s4kcPy2Wiu93Me1ThRua1/MA1mNtw0gms6cWrdc+QZ7Q
	 TOVszwv7As++xBqZWA/B9FpPPMHgLfjlgKUNQMoE=
Date: Tue, 24 Feb 2026 01:29:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Khemissi Mohammed el Amine <aminekhemissi61@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] scsi: Fix NULL pointer dereference in
 scsi_setup_scsi_cmnd()
Message-ID: <2026022446-grape-harpist-90c5@gregkh>
References: <20260223231403.14069-1-aminekhemissi61@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223231403.14069-1-aminekhemissi61@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-217840-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: B654B1803BF
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 03:14:03PM -0800, Khemissi Mohammed el Amine wrote:
> A NULL pointer dereference can occur in scsi_setup_scsi_cmnd() when handling
> BSG ioctls with zero-length requests. The function calls scsi_command_size()
> before cmd->cmnd is initialized, leading to a kernel oops when the pointer
> is dereferenced.
> 
> The crash occurs in the following sequence:
> 1. BSG ioctl issued with sg_io_v4.request = NULL, request_len = 0
> 2. scsi_setup_scsi_cmnd() invoked via scsi_queue_rq()
> 3. If scsi_req(req)->cmd_len == 0, code calls scsi_command_size(cmd->cmnd)
> 4. cmd->cmnd has not been set yet (still NULL or uninitialized)
> 5. scsi_command_size() dereferences the NULL pointer without checking
> 6. Kernel NULL pointer dereference oops
> 
> This issue affects Linux 5.10 LTS . Local users with access to
> /dev/bsg/* device nodes can trigger this crash.
> 
> Fix this by:
> 1. Adding a NULL check in scsi_command_size() to handle NULL input gracefully
> 2. Adding a NULL check in scsi_setup_scsi_cmnd() before calling
>    scsi_command_size()
> 
> Signed-off-by: Khemissi Mohammed el Amine <aminekhemissi61@gmail.com>
> ---
>  drivers/scsi/scsi_lib.c    | 6 ++++++
>  include/scsi/scsi_common.h | 2 ++
>  2 files changed, 8 insertions(+)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

