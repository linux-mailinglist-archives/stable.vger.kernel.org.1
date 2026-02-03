Return-Path: <stable+bounces-213175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ARWEQOqgWn0IQMAu9opvQ
	(envelope-from <stable+bounces-213175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 08:55:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A13D5E24
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 08:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A4393004D1B
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 07:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CBC392C3A;
	Tue,  3 Feb 2026 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgrHo8ef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8762F5328;
	Tue,  3 Feb 2026 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105338; cv=none; b=MUmDJDB1Vf5egHmFFFuFW1viWh0/WyOZ14pPcrK7wzeHp6y1Cnh1W8lhMnpEqPIBpQE0kjj7cT2O0prdTScGlyM70NHOWlkEDTr+ybhjbHjnCOlZeIdVZebyOCESLnEZT7RmFUMeEsvQcT07nfEbgiKQJS/dJOcZ7JRWIGZywds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105338; c=relaxed/simple;
	bh=4Vq5HT9GMbuZxPxsT9MI3F5lUAEFdnnd3SV89HgtbiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDPNRM+N2DNlVJ6Ec+/Y8iGHHiz5odQ6CLW86RxZ/oPUY83rRjvCOigfCVzhQQMwCS+EBpn2iCR9ymUCS6P8IgzfxvdQHj1fhA2m6MTixpZZWGgENXQPZWlLyVjYvFx+IRnkwNcG1gwfXpF4Q09q+JWSnw9iDaJt3k/FN/RJtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgrHo8ef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E94C116D0;
	Tue,  3 Feb 2026 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770105338;
	bh=4Vq5HT9GMbuZxPxsT9MI3F5lUAEFdnnd3SV89HgtbiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgrHo8efwWhKG72A/lo1uIpJEsxbnmB/+X4lxJ1ROODvZ7p/Um6aznZHdBfWooFEj
	 vLjRO79jepU/n+6Ls4isDYUW1zpcPed4CEUeDDk6iIz9gUlw3UmT/pMPQC9gXYAzjL
	 KsDavt5Wjby1NsZgD9GTkXSJbNj56etLNZj1l8ewMWXcDImInn0lLkbvhkL4dxlHH5
	 5/H3446d2K1NERiVeR5hAveV1iUVLKRUeWQ3Sbsg/ve++lnksJ3NLQb/yU8E3gEfu3
	 OfbRhveeTSAzsy8G4kE18sWYTT9oVndeNLptmGzbk7IGqKWuwbzx2HS4IkkLgruy8W
	 ZriSncHdyX6ww==
Date: Tue, 3 Feb 2026 15:55:33 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
Cc: Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	theo.lebrun@bootlin.com, Frank Li <frank.li@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	richard.genoud@bootlin.com, Udit Kumar <u-kumar1@ti.com>,
	Prasanth Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: fix role switching during resume
Message-ID: <20260203075533.GA326240@nchen-desktop>
References: <20260130-usb-cdns3-fix-role-switching-during-resume-v1-1-44c456852b52@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130-usb-cdns3-fix-role-switching-during-resume-v1-1-44c456852b52@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213175-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email]
X-Rspamd-Queue-Id: B9A13D5E24
X-Rspamd-Action: no action

On 26-01-30 11:05:45, Thomas Richard (TI) wrote:
> If the role change while we are suspended, the cdns3 driver switches to the
> new mode during resume. However, switching to host mode in this context
> causes a NULL pointer dereference.
> 
> The host role's start() operation registers a xhci-hcd device, but its
> probe is deferred while we are in the resume path. The host role's resume()
> operation assumes the xhci-hcd device is already probed, which is not the
> case, leading to the dereference. Since the start() operation of the new
> role is already called, the resume operation can be skipped.
> 
> So skip the resume operation for the new role if a role switch occurs
> during resume. Once the resume sequence is complete, the xhci-hcd device
> can be probed in case of host mode.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000208
> Mem abort info:
> ...
> Data abort info:
> ...
> [0000000000000208] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1]  SMP
> Modules linked in:
> CPU: 0 UID: 0 PID: 146 Comm: sh Not tainted
> 6.19.0-rc7-00013-g6e64f4aabfae-dirty #135 PREEMPT
> Hardware name: Texas Instruments J7200 EVM (DT)
> pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : usb_hcd_is_primary_hcd+0x0/0x1c
> lr : cdns_host_resume+0x24/0x5c
> ...
> Call trace:
>  usb_hcd_is_primary_hcd+0x0/0x1c (P)
>  cdns_resume+0x6c/0xbc
>  cdns3_controller_resume.isra.0+0xe8/0x17c
>  cdns3_plat_resume+0x18/0x24
>  platform_pm_resume+0x2c/0x68
>  dpm_run_callback+0x90/0x248
>  device_resume+0x100/0x24c
>  dpm_resume+0x190/0x2ec
>  dpm_resume_end+0x18/0x34
>  suspend_devices_and_enter+0x2b0/0xa44
>  pm_suspend+0x16c/0x5fc
>  state_store+0x80/0xec
>  kobj_attr_store+0x18/0x2c
>  sysfs_kf_write+0x7c/0x94
>  kernfs_fop_write_iter+0x130/0x1dc
>  vfs_write+0x240/0x370
>  ksys_write+0x70/0x108
>  __arm64_sys_write+0x1c/0x28
>  invoke_syscall+0x48/0x10c
>  el0_svc_common.constprop.0+0x40/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x34/0x108
>  el0t_64_sync_handler+0xa0/0xe4
>  el0t_64_sync+0x198/0x19c
> Code: 52800003 f9407ca5 d63f00a0 17ffffe4 (f9410401)
> ---[ end trace 0000000000000000 ]---
> 
> Cc: stable@vger.kernel.org
> Fixes: 2cf2581cd229 ("usb: cdns3: add power lost support for system resume")
> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
> This patch is related to the following discussion:
> https://lore.kernel.org/all/8743fec1-301d-46e1-89bf-7952c73faa86@bootlin.com/
> ---
>  drivers/usb/cdns3/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 1243a5cea91b..f0e32227c0b7 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -551,7 +551,7 @@ int cdns_resume(struct cdns *cdns)
>  		}
>  	}
>  
> -	if (cdns->roles[cdns->role]->resume)
> +	if (!role_changed && cdns->roles[cdns->role]->resume)
>  		cdns->roles[cdns->role]->resume(cdns, power_lost);
>  
>  	return 0;
> 

-- 

Best regards,
Peter

