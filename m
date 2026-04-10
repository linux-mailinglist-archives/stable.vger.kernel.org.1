Return-Path: <stable+bounces-235655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAStIZ0+2WkHnwgAu9opvQ
	(envelope-from <stable+bounces-235655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:17:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 952B23DB65F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 20:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A320B300B29A
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964EF383C82;
	Fri, 10 Apr 2026 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Xeo2HQbu"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6E330641
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845014; cv=none; b=d6D3LAbjs2elh2sByrmlYqheLnK7QefnU8VVZVQUYdDg/Tj3E7Ekek+uekYEV4baCBOa1J6gcRDqULzZzM65nbootr7RFOBOHQhdEq88ra9qR/ELB6YqlPwAVHAY/xPiTdGDgiSW1/J52NKn9uR6B91NYyOEGbsy/i5aNnYi5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845014; c=relaxed/simple;
	bh=wmFkU0tFnb+sa2UDDOhFTX4qu/Lmp+KH3hnP3FI5Hh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pySkEH4DsRkWnmgcm2HS5Sj5ddhlL7nspRGWvOO5JqVHs+u2CXq/6+mtjAvJJQXupZM502Wgzg6TfqJrDD1r7hSgr5MOeRELt3yuDvE49NgBKEoNOoAMgOUaf6vuFSYoXq9y+dNJeaEp8/cm/hXUo3lzX48K43V9HAY9VcuhMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Xeo2HQbu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SFdb53Cnvj6j4DYQ+vrH9HHnFQo1EfWh+VuVDrHJojM=; b=Xeo2HQbuXkKxpi8jCryl0VZuxE
	ZDQjamLyl5QpP48Zuui53q2ry23x2KCG/bW1tx8RrSBRIuTviQBkKVzwcCziy6bAT+hqDKZmavqTp
	jWXRQagc0TKFcqC2jfdM24hiscrKa040MkGiGGiaN4vKWpdkgSPNTYw210l9S3gcvURV+GkImPwtz
	YUZ5ZIxwALPmxygSmJitWyHjPmPv8jjBFNf8uVR64UCglA4hHjN/QZ143Dzoqyqkt1zF0ulJKGaIM
	a8w/7zz9yxIyFDbZHmc/2jHTWUPK63hqXw7t61uQBEhVN+eD7pUQYe1pE2t+dOHAWxAKABTqmWOEq
	gUOUC5vg==;
Received: from [189.7.87.169] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wBGPN-00EVbw-7Z; Fri, 10 Apr 2026 20:16:45 +0200
Message-ID: <cbcb794f-0d82-40b4-a9a5-6aca99e8c434@igalia.com>
Date: Fri, 10 Apr 2026 15:16:38 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Limit ioctl extension chain depth to prevent
 infinite loop
To: Ashutosh Desai <ashutoshdesai993@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: itoral@igalia.com, stable@vger.kernel.org
References: <20260410013907.2404175-1-ashutoshdesai993@gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <20260410013907.2404175-1-ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235655-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.573];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 952B23DB65F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ashutosh,

On 09/04/26 22:39, Ashutosh Desai wrote:
> v3d_get_extensions() walks a userspace-provided singly-linked list of
> ioctl extensions without any bound on the chain length.  A local user
> can craft a self-referential extension (ext->next == &ext) with zero
> in_sync_count and out_sync_count, which bypasses the existing duplicate-
> extension guard:
> 
>      if (se->in_sync_count || se->out_sync_count)
>              return -EINVAL;
> 
> The guard never fires because v3d_get_multisync_post_deps() returns
> immediately when count is zero, leaving both fields at zero on every
> iteration.  The result is an infinite loop in kernel context, blocking
> the calling thread and pegging a CPU core indefinitely.
> 
> Both i915 (stackdepth = 512) and xe (MAX_USER_EXTENSIONS = 16) impose
> an explicit depth limit on the same pattern.  Apply the same defence to
> V3D by capping the walk at 16 extensions.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>

As Jani mentioned in a previous e-mail, if this is AI-generated, please
add an AI coding assistant attribution.

That said, I believe this makes a lot of sense. Some comments below.

> ---
>   drivers/gpu/drm/v3d/v3d_submit.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index 18f2bf1fe..491eeb6b3 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -802,12 +802,18 @@ v3d_get_extensions(struct drm_file *file_priv,
>   	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
>   	struct v3d_dev *v3d = v3d_priv->v3d;
>   	struct drm_v3d_extension __user *user_ext;
> +	unsigned int ext_count = 0;
>   	int ret;
>   
>   	user_ext = u64_to_user_ptr(ext_handles);
>   	while (user_ext) {
>   		struct drm_v3d_extension ext;
>   
> +		if (ext_count++ >= 16) {

I believe we could limit it to 7, which is the number of existing V3D
extensions. Also, we could add this number as a #define, to make things
more clear.

Best regards,
- Maíra

> +			drm_dbg(&v3d->drm, "Too many V3D ioctl extensions\n");
> +			return -E2BIG;
> +		}
> +
>   		if (copy_from_user(&ext, user_ext, sizeof(ext))) {
>   			drm_dbg(&v3d->drm, "Failed to copy submit extension\n");
>   			return -EFAULT;


