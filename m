Return-Path: <stable+bounces-238316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IMdHwrr4GnWnQAAu9opvQ
	(envelope-from <stable+bounces-238316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:58:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D140040F494
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B5B43014C3E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0543CD8D8;
	Thu, 16 Apr 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7sXTEzu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5F37F01D;
	Thu, 16 Apr 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347743; cv=none; b=Qu8mooB/LIhkb/kUE9QdpYwgfwIejPq8zz+DHIncVTylHxZGVCH/Ar75wy4itHcHMzZ31F7vbzBNO7yIjYFsAdg74l+3czPUkVJmiHdojdjtscBOVR5893hXDtOYBq3GZUrJChKMwZaIg6QvxIkNevya3FrmJbpkwcqCn+okmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347743; c=relaxed/simple;
	bh=fFpcxlUO8GkQVJnT624RqhJ8wfJGsPEiug5f2tM8N84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVLQHgZDQwBtQfO89Lg5W9H+Mruy1o7w3R2KenY2shIPd9tf35tZbSHeN8XOzVVdNXia788fIGsbM1vwJX2Du8HpQfnCqLWuc0M25yosbIdEwAAtKkqzKOmMb6VGmpThhv5GJDGzdpGLOvry4UDVtPAnRlK2uijGE/t96bTYKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7sXTEzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5522C2BCAF;
	Thu, 16 Apr 2026 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776347743;
	bh=fFpcxlUO8GkQVJnT624RqhJ8wfJGsPEiug5f2tM8N84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7sXTEzuoc1itLxf7/1AMhRehGXWxIVJQm8eE1TG2fJank9owGVyz4xmOmxZ9ZiCM
	 4x2ZcCaTlUzBj/i/Zfyx7MZuymnhZiapvaOo5aLIZvhS7pmnkUp322/Eo62DBaEZ8x
	 RK6gkQSwUxF0Ax9K3WTLzndK2InSyheFkmqvBNEkmpXMukkv7lrIGPkoB2AEUZj3Ms
	 dUyMeaLK5KqOdrfzcns8rfE2ErtLRicYS4C2OM+zYzJdMBL31BxAtHWBT1KNmoH48y
	 tYF3ZWIlVm82JUkr8+lw9qtv0OA8pYOzjpAJBRTWcQDiZ+IOBjEc6z/Cgy+V8ap2gR
	 ki5VKDDJDD1+w==
From: Simon Horman <horms@kernel.org>
To: jtornosm@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	davem@davemloft.net,
	jesse.brandeburg@intel.com,
	edumazet@google.com,
	przemyslaw.kitszel@intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org
Subject: Re: [PATCH net v3 4/5] ice: skip unnecessary VF reset when setting trust
Date: Thu, 16 Apr 2026 14:55:19 +0100
Message-ID: <20260416135519.873936-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414110006.124286-5-jtornosm@redhat.com>
References: <20260414110006.124286-5-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238316-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D140040F494
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: skip unnecessary VF reset when setting trust

Similar to the i40e fix, ice_set_vf_trust() unconditionally calls
ice_reset_vf() when the trust setting changes. The ice driver already
has logic to clean up MAC LLDP filters when removing trust, which is
the only operation that requires filter synchronization. After this
cleanup, the VF reset is only necessary if there were actually filters
to remove.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1399,14 +1399,19 @@ int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted)
>
>  	mutex_lock(&vf->cfg_lock);
>
> -	while (!trusted && vf->num_mac_lldp)
> -		ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> -
>  	vf->trusted = trusted;
> -	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
>  	dev_info(ice_pf_to_dev(pf), "VF %u is now %strusted\n",
>  		 vf_id, trusted ? "" : "un");
>
> +	/* Only reset VF if removing trust and there are MAC LLDP filters
> +	 * to clean up. Reset is needed to ensure filter removal completes.
> +	 */
> +	if (!trusted && vf->num_mac_lldp) {
> +		while (vf->num_mac_lldp)
> +			ice_vf_update_mac_lldp_num(vf, ice_get_vf_vsi(vf), false);
> +		ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	}
> +

Does setting vf->trusted before the cleanup loop break the filter
removal? Looking at the cleanup mechanism, ice_vf_update_mac_lldp_num()
calls ice_vf_is_lldp_ena() which checks both num_mac_lldp AND
vf->trusted:

ice_vf_lib.h:ice_vf_is_lldp_ena():
    return vf->num_mac_lldp && vf->trusted;

With the new ordering where vf->trusted is set to false before the loop:

ice_vf_update_mac_lldp_num() logic:
    was_ena = ice_vf_is_lldp_ena(vf);  // evaluates to (num > 0 && FALSE) = FALSE
    vf->num_mac_lldp--;
    is_ena = ice_vf_is_lldp_ena(vf);   // evaluates to FALSE

    if (was_ena != is_ena)              // FALSE != FALSE is FALSE
        ice_vsi_cfg_sw_lldp(vsi, false, false);  // NEVER called

But in the old code, vf->trusted was still TRUE during the loop:

    was_ena = (num > 0 && TRUE) = TRUE
    vf->num_mac_lldp--;
    is_ena = (0 && TRUE) = FALSE      // when last filter removed

    if (was_ena != is_ena)            // TRUE != FALSE is TRUE
        ice_vsi_cfg_sw_lldp(...)      // called to remove LLDP filters

So the ETH_P_LLDP packet filters are not removed from the hardware
switch, leaving stale filter rules. Should vf->trusted be set after the
cleanup loop instead?

>  	mutex_unlock(&vf->cfg_lock);
>
>  out_put_vf:

