Return-Path: <stable+bounces-120403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 228EEA4F826
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 08:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE6D16F5EF
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 07:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17361F4635;
	Wed,  5 Mar 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tzPrXbtm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JiF5hV26";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tzPrXbtm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JiF5hV26"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63081F153A
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160524; cv=none; b=p5N1HaeaGAxxNwoUVVyqXSMpBvoGWxWXU1MipN3j1s0vGK49V5oDTqGeyWfDQfGju8HKPxMr8kpLPM19Y1Oc3fIKiZ7yz7M2mopF7WX43swY9IIPxlbXxnrPD+JfwWbzQJwWXgq7EGn7Y06MXBG4btlv1rrwmgHLseDN4iFe4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160524; c=relaxed/simple;
	bh=valG8SuOJFe4rhSpEP+fdUZtyiQA2qXNgSKlm5SEjl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvTkhv/BIdHckgkUr5qmTPdGJD2pNeHNWqRx07eS+F1OPfyAqxYotaIXEpSbrC+uLVXAemwk/rgMsOkEC/+enyEByJ0V8um/uea1YAOscYCz2slq27PYkwTGW2b8LeBsjoTMSEyZAbhvbXfdmKfdzWQY+B0yVbU4HBBZt1e+ndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tzPrXbtm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JiF5hV26; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tzPrXbtm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JiF5hV26; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10D2A1F38A;
	Wed,  5 Mar 2025 07:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741160518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=adnyt9CWxSwzs4Be7pAFdLIXiVLWF5YXALCHwTY9Njs=;
	b=tzPrXbtmFvJja+Tsfq8rE8v8ek27TwQgcL9uHVWEE1MQKFnZAn3B42OkAEbLOqQ9dxHGMq
	uJ+GchJzbojXvVxBd9VLf727HstoPSSFAAoS91XHt7uMx4sr6l+zJRqvhSEh3NsUKSN7ei
	dvUHCYc+7rY7VEaKcoVHvIMxTcaXZPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741160518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=adnyt9CWxSwzs4Be7pAFdLIXiVLWF5YXALCHwTY9Njs=;
	b=JiF5hV26a+n9IFkcwrxyHLBVwHDMQlsAdYQq8dmJ58Klwmw8whpqY6iYtYm37cLJBbCFV6
	B7xq7O5x3FUP+8Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tzPrXbtm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JiF5hV26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741160518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=adnyt9CWxSwzs4Be7pAFdLIXiVLWF5YXALCHwTY9Njs=;
	b=tzPrXbtmFvJja+Tsfq8rE8v8ek27TwQgcL9uHVWEE1MQKFnZAn3B42OkAEbLOqQ9dxHGMq
	uJ+GchJzbojXvVxBd9VLf727HstoPSSFAAoS91XHt7uMx4sr6l+zJRqvhSEh3NsUKSN7ei
	dvUHCYc+7rY7VEaKcoVHvIMxTcaXZPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741160518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=adnyt9CWxSwzs4Be7pAFdLIXiVLWF5YXALCHwTY9Njs=;
	b=JiF5hV26a+n9IFkcwrxyHLBVwHDMQlsAdYQq8dmJ58Klwmw8whpqY6iYtYm37cLJBbCFV6
	B7xq7O5x3FUP+8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4A501366F;
	Wed,  5 Mar 2025 07:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vIcqLkUAyGdtSwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 05 Mar 2025 07:41:57 +0000
Message-ID: <d44d4aba-4abe-4dc8-8b09-1237567ffc41@suse.de>
Date: Wed, 5 Mar 2025 08:41:57 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Select DRM_KMS_HELPER from
 DRM_DEBUG_DP_MST_TOPOLOGY_REFS
To: j@jannau.net, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250304-drm_debug_dp_mst_topo_kconfig-v1-1-e16fd152f258@jannau.net>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20250304-drm_debug_dp_mst_topo_kconfig-v1-1-e16fd152f258@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 10D2A1F38A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[jannau.net,linux.intel.com,kernel.org,gmail.com,ffwll.ch,redhat.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO



Am 04.03.25 um 20:12 schrieb Janne Grunau via B4 Relay:
> From: Janne Grunau <j@jannau.net>
>
> Using "depends on" and "select" for the same Kconfig symbol is known to
> cause circular dependencies (cmp. "Kconfig recursive dependency
> limitations" in Documentation/kbuild/kconfig-language.rst.
> DRM drivers are selecting drm helpers so do the same for
> DRM_DEBUG_DP_MST_TOPOLOGY_REFS.
> Fixes following circular dependency reported on x86 for the downstream
> Asahi Linux tree:
>
> error: recursive dependency detected!
>    symbol DRM_KMS_HELPER is selected by DRM_GEM_SHMEM_HELPER
>    symbol DRM_GEM_SHMEM_HELPER is selected by RUST_DRM_GEM_SHMEM_HELPER
>    symbol RUST_DRM_GEM_SHMEM_HELPER is selected by DRM_ASAHI
>    symbol DRM_ASAHI depends on RUST
>    symbol RUST depends on CALL_PADDING
>    symbol CALL_PADDING depends on OBJTOOL
>    symbol OBJTOOL is selected by STACK_VALIDATION
>    symbol STACK_VALIDATION depends on UNWINDER_FRAME_POINTER
>    symbol UNWINDER_FRAME_POINTER is part of choice block at arch/x86/Kconfig.debug:224
>    symbol <choice> unknown is visible depending on UNWINDER_GUESS
>    symbol UNWINDER_GUESS prompt is visible depending on STACKDEPOT
>    symbol STACKDEPOT is selected by DRM_DEBUG_DP_MST_TOPOLOGY_REFS
>    symbol DRM_DEBUG_DP_MST_TOPOLOGY_REFS depends on DRM_KMS_HELPER
>
> Fixes: 12a280c72868 ("drm/dp_mst: Add topology ref history tracking for debugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index fbef3f471bd0e5101699cf576542f7350bea3982..bd228dc77e99b4356b09de02d9001237eb2423e2 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -188,7 +188,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
>           bool "Enable refcount backtrace history in the DP MST helpers"
>   	depends on STACKTRACE_SUPPORT
>           select STACKDEPOT
> -        depends on DRM_KMS_HELPER
> +        select DRM_KMS_HELPER
>           depends on DEBUG_KERNEL
>           depends on EXPERT
>           help
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250304-drm_debug_dp_mst_topo_kconfig-a112904ba611
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


