Return-Path: <stable+bounces-249688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHrHF/jADGqJlgUAu9opvQ
	(envelope-from <stable+bounces-249688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:58:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2120858462E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05BB230508D1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC553B636C;
	Tue, 19 May 2026 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntfySxbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61C3B3899;
	Tue, 19 May 2026 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220725; cv=none; b=cPFgLcF/kl/22DJoygLhrI07ZlaTqWOjvzjQWFb/CMjbmOxIlziAv+7qETYZxfiAFI0p94FGrMgGeGx09rIotZaBgdkXQ1LxWlMnHwcXrvp18Wl5j30f1y9iVA/h2XPH/0y9xThpQYC6sOwIAQk7Rkh6ZrJGRrecBmPCdribVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220725; c=relaxed/simple;
	bh=xLRhOQYymh8slWkWWmbY0IPRRJhNuIxzj+gQXUK+/DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UU8IsrnCPFP+KXUpEI/beH/v+DJzfcrCgHCT2aJXArfjLb0P1nBAe9Nv9p1Njhx11qFkO2Tnvx/egwW2NQGsM+PDS1Pil/rgWXVHk+JlVH2anzkkMFE2EeGZrHxswS1mC38PbyTz17ejkS3NXvlGizN8OMI619x+3cUsGjPL+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntfySxbp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90B71F000E9;
	Tue, 19 May 2026 19:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779220724;
	bh=5akoCTZztmBRRico1B1UJxTBZQxHDAVsHtATqtnVgJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ntfySxbpJnvE3ptiwcsEh4kQid5dCi4+3r7kDcRZj2CGEWaHWW6MZc9df2LXps/N/
	 fAhUl9cx5fLV2gUWnvaoEKJ3g2eJDD3y1hiuYxuIBzMlR79YmUOdm5y1DYkYSR+plS
	 43asYLUT4mruH2FzdUzs/ockKtnctF4TAtX4tdPl1RlcNzkMcO9UOqupL48RI3nyul
	 UCkOKL/OmAEWFh0tF9sOdwmK56R02MMiOlEYpJyY7+s09GKMtfesRLKcPxOpqIKixL
	 8dU2jIX2ZM8/89s2+z8ehEeBV2LfK3vxlAxBCSlzIKp3FjKJ7bC+8KDzpfiMJ9ZF0S
	 5xHgnbNa50H8A==
From: Simon Horman <horms@kernel.org>
To: devnexen@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] idpf: handle NULL adev in idpf_idc_vdev_mtu_event
Date: Tue, 19 May 2026 20:57:34 +0100
Message-ID: <20260519195734.982404-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514183019.49527-1-devnexen@gmail.com>
References: <20260514183019.49527-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-249688-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 2120858462E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
idpf: handle NULL adev in idpf_idc_vdev_mtu_event

This commit attempts to fix a NULL pointer dereference in the MTU event
handler by caching the auxiliary device pointer using READ_ONCE(). It avoids
dereferencing a NULL pointer if the device is cleared concurrently by
idpf_idc_vport_dev_ctrl().

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index b7d6b08fc89e8..9f764135507c2 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info *vdev_info,
>  
>  	set_bit(event_type, event.type);
>  
> -	device_lock(&vdev_info->adev->dev);
> -	adev = vdev_info->adev;
> -	if (!adev || !adev->dev.driver)
> +	adev = READ_ONCE(vdev_info->adev);
> +	if (!adev)
> +		return;
> +
> +	device_lock(&adev->dev);

The commit message indicates that idpf_idc_vport_dev_ctrl() and MTU changes
can run concurrently. Does caching the adev pointer with READ_ONCE() provide
enough protection against the device memory being freed?

If idpf_idc_vport_dev_ctrl() unregisters and frees the auxiliary device
immediately after READ_ONCE() reads a non-NULL pointer, could
device_lock(&adev->dev) then operate on a freed device?

Would it be necessary to increment the device's reference count, perhaps
using get_device() or holding a broader lock, before accessing adev->dev to
prevent a use-after-free regression?

