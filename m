Return-Path: <stable+bounces-272037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yto+DLcuSmqW/AAAu9opvQ
	(envelope-from <stable+bounces-272037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 12:15:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E2B709B85
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 12:15:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=f0EDdWfL;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272037-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272037-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 709A33006B03
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929E392C39;
	Sun,  5 Jul 2026 10:15:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5F3905FD;
	Sun,  5 Jul 2026 10:15:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783246516; cv=none; b=iOQMFDk7Mr/837C331V1Ns8EVKpK8o9i8i8AxVmwXAp+HMSijd/HH19p6Dkzi3fHuKOYF2ALbtCHRdDTpLLC3Lj6y0u2mZBaw9yHDEewQR6+lfMaTiPvh62Jni63mamesGJ4BJbyfd272JHhNht5IzL3j+VmL3rut06Ejcbkvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783246516; c=relaxed/simple;
	bh=uwbCRyKNHOwTQ8pO8Ag7cp6ZgrPzd124YiFDRC6jWM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU/u8jz4qyFQ0DPKmvnS+Jm620Xm0LqdMeZmTP7BFTKY7wGAXPDu0Vi60MBCQpjZLdQymqcbGTop1DCKVl0KiwXoMP5X/XlYrWvzmITwcedRXQfHCpBGqpgDaQVx6BksLfQzHc3YfETuimSEaesJTc+rDraYMqz1F0KuXSScga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f0EDdWfL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0E31F000E9;
	Sun,  5 Jul 2026 10:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783246515;
	bh=BDpndPJPpVslAjSF1jnldqZFfjHHIw5RjpONxZo0aQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f0EDdWfLcPjptybPh1gc5KyPrKdBEMWeQ2NIaSnJu+kCmThUfhmTs01ngyvv5VPzT
	 kmwHEfkva0JCndMDfoNtG8JQk2aHsQw4CZs4lgXvfBpeLV8TNyLx79JK0M6ADEP3e8
	 HaL4Qj6xgcLy3dB2y9ua8PKqpjo2Esi1Sy4O0/bc=
Date: Sun, 5 Jul 2026 12:13:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix hole runlist memory leak in insert range error
 path
Message-ID: <2026070550-certainly-ladle-dc6f@gregkh>
References: <5A2D944D5FE68879+20260705100554.3797781-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A2D944D5FE68879+20260705100554.3797781-1-peiyang_he@smail.nju.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272037-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:peiyang_he@smail.nju.edu.cn,m:linkinjeon@kernel.org,m:hyc.lee@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nju.edu.cn:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67E2B709B85

On Sun, Jul 05, 2026 at 06:05:54PM +0800, Peiyang He wrote:
> ntfs_non_resident_attr_insert_range() allocates hole_rl before mapping the
> whole runlist. If ntfs_attr_map_whole_runlist() fails, the error path drops
> ni->runlist.lock and returns without freeing hole_rl. This causes memory leak
> of sizeof(*hole_rl) * 2 bytes.
> 
> Fix this memory leak by freeing hole_rl before returning from that error path,
> matching the later error paths in the same function.
> 
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  fs/ntfs/attrib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index dd8828098511..55603df0a2ed 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -5325,6 +5325,7 @@ int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s6
>  	ret = ntfs_attr_map_whole_runlist(ni);
>  	if (ret) {
>  		up_write(&ni->runlist.lock);
> +		kfree(hole_rl);
>  		return ret;
>  	}
>  
> 
> base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
> -- 
> 2.43.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

