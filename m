Return-Path: <stable+bounces-216687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJWjK3fykmlA0QEAu9opvQ
	(envelope-from <stable+bounces-216687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:33:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A8F14260A
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE6743010BA0
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE662EA171;
	Mon, 16 Feb 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CTX/0nrD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408A26AA91
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771238004; cv=none; b=MzC4V0JtCBUjHPUNj9vFdlIuyRYx0eFi3aht0gty1nhkDEinbqlm2/ysNOUfm+SMy2n+cWflF07ymynZU7tVS7v3c1lZzAdLzKO7CnqdVhege79zjXS8Mbc6Iy5Rf7PJBXWFWpgxY8Ut9/VXcJwQXwMiM7+Q5qdO1W+jE08kPTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771238004; c=relaxed/simple;
	bh=wEea2a57fmMrVtXKzRP7FIt5G42cLGQ/H2iWwmffM2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QthMlCJo523ohof8/7eSdcWxP5qHRNC0zLHFi0tkQCT/kfW+CfGqb/yf/VL5YgabhkVupXJfZY7M0LMuLJk4e5uExExME+XigxjU+13dKOix/T3wMCBpDOfTiZNUmhwPQEa02fH06N2rxPn6EneuPFv49H77Uw4dipCIZKDnOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CTX/0nrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3958EC116C6;
	Mon, 16 Feb 2026 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771238004;
	bh=wEea2a57fmMrVtXKzRP7FIt5G42cLGQ/H2iWwmffM2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTX/0nrDEVJY7Me4kDE4zuOlMRJzx6ARGszd15y5hLeAdVUUBqig5oGUG3f0oLCTh
	 Gt9K3XPM+Bg7T2aWAeB/XZgPjPkjJ2WSb7kmVKzMDUSGVuoRZKEhJkGqUB3XZv4WkK
	 CT8ICCR8tlTqRu48xvwF64fAwSXJaL659aGJis60=
Date: Mon, 16 Feb 2026 11:33:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rajani Kantha <681739313@139.com>
Cc: bvanassche@acm.org, adrian.hunter@intel.com, martin.petersen@oracle.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1] scsi: ufs: core: Fix handling of lrbp->cmd
Message-ID: <2026021601-justify-reusable-0fdd@gregkh>
References: <20260213030257.1688-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213030257.1688-1-681739313@139.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216687-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:email]
X-Rspamd-Queue-Id: 13A8F14260A
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 11:02:57AM +0800, Rajani Kantha wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> ufshcd_queuecommand() may be called two times in a row for a SCSI command
> before it is completed. Hence make the following changes:
> 
>  - In the functions that submit a command, do not check the old value of
>    lrbp->cmd nor clear lrbp->cmd in error paths.
> 
>  - In ufshcd_release_scsi_cmd(), do not clear lrbp->cmd.
> 
> See also scsi_send_eh_cmnd().
> 
> This commit prevents that the following appears if a command times out:
> 
> WARNING: at drivers/ufs/core/ufshcd.c:2965 ufshcd_queuecommand+0x6f8/0x9a8
> Call trace:
>  ufshcd_queuecommand+0x6f8/0x9a8
>  scsi_send_eh_cmnd+0x2c0/0x960
>  scsi_eh_test_devices+0x100/0x314
>  scsi_eh_ready_devs+0xd90/0x114c
>  scsi_error_handler+0x2b4/0xb70
>  kthread+0x16c/0x1e0
> 
> Fixes: 5a0b0cb9bee7 ("[SCSI] ufs: Add support for sending NOP OUT UPIU")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Link: https://lore.kernel.org/r/20230524203659.1394307-3-bvanassche@acm.org
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> [ Removed the change in ufshcd_advanced_rpmb_req_handler() due to missing
> commit:6ff265fc5ef6("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg") ]
> Signed-off-by: Rajani Kantha <681739313@139.com>
> ---
>  drivers/ufs/core/ufshcd.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

No hint as to what the upstream git commit id this is?  :(


