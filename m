Return-Path: <stable+bounces-237779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJWWApsX3mlBmwkAu9opvQ
	(envelope-from <stable+bounces-237779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:31:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43F3F8B8B
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54B78309EEC5
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19749291864;
	Tue, 14 Apr 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwwKUyli"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEEC3D5228
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162360; cv=none; b=RCSEHmURwPjSR+LGMVHyw3nvbdLMCoy1goxFjwpVQ45g+dQnZpVk0VOHuMBW/IttJTSudmrGm/kj24xg4M6y+PLYw7LI9YOZhgsCHp8iFG5f36NXezuJ44Y00uCutgoJd4fTFRKDiF9yRtyBakNsFUuht4KK+lOj3B1wQ4x3ym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162360; c=relaxed/simple;
	bh=zfUclQwCQMcTFGwQkm93CYEfEeaHT9/PFou3kTysz/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ1M5SJnSlPtKlhFbJlHA+MOKnsSouAjSbMgMu/kEa/z54dA+q0ZvDrlFJ1SAVqsyTifLO0H0gMNaCc32YHsUEymzxS+6s+KurkZKVBgFsldPQRp6qZE9LAJrq5ksJyeMqBgV+EZl8FddvANY1zL3rm/f62DTnJVWcCvLvKm/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwwKUyli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AEFC2BCB4;
	Tue, 14 Apr 2026 10:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776162359;
	bh=zfUclQwCQMcTFGwQkm93CYEfEeaHT9/PFou3kTysz/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwwKUyli5Bxcv0Pi2b0TO4voxXpqtT3KK6ow3OuHL6E/U7RnTU3uVfTkv2tEE8Dq6
	 i0RjPv6JZK+e+P1W9nDADj8qQ7Qu0z7ojmjZYCaID5lVi0J8IEFm/KQfLurCXx/wFr
	 gFA0GDS2PhE9nEJO4gDYNhAkndZRQCek6mN0g7PXFc+afEy7MsbDLDJqha+1ToZplX
	 hzNQh9yumII0Sz/8fXQjA+1Bn1eKCFVmRIW7cjKBz/vHcBB6HY2NgATCAxy4/obXTE
	 ZZGCD1ovcRhZ0LSWYL9S2lSdgT+0g4tfofbZ2ShyOObFYdNRLMiZXV+nChdc+o4zwj
	 kmuBtBA70Ufnw==
Date: Tue, 14 Apr 2026 12:25:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jia Yao <jia.yao@intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
	Shuicheng Lin <shuicheng.lin@intel.com>, Matt Roper <matthew.d.roper@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Maciej Plewka <maciej.plewka@intel.com>
Subject: Re: [PATCH v2] drm/i915/dg2: Add per-context control for
 Wa_22013059131
Message-ID: <ad4V09-JiU4kH2BW@zenone.zhora.eu>
References: <20260410140619.736008-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410140619.736008-1-jia.yao@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237779-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zenone.zhora.eu:mid]
X-Rspamd-Queue-Id: AC43F3F8B8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jia,

...

> +	case I915_CONTEXT_PARAM_WA_22013059131:
> +		if (args->size)
> +			ret = -EINVAL;
> +		else if (args->value)
> +			pc->user_flags |= BIT(UCONTEXT_WA_22013059131);
> +		else
> +			pc->user_flags &= ~BIT(UCONTEXT_WA_22013059131);
> +		break;

Should we check here for the platform type?

Andi

> +
>  	case I915_CONTEXT_PARAM_RECOVERABLE:
>  		if (args->size)
>  			ret = -EINVAL;

