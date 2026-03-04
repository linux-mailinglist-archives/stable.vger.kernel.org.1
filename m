Return-Path: <stable+bounces-223004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NZcH7ngp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-223004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:35:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FBE1FBA80
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38E373029645
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217EF36DA09;
	Wed,  4 Mar 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxDqn5/s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D034B1BE;
	Wed,  4 Mar 2026 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609711; cv=none; b=ZgruDFK5SZ5manwdAuIFeGlGXOetiYaLIR1byHfDlCgesKFyUUu/dTaDNtBYIDvJFknev3OVxOHHhc/Ig/QmMv45GIC8OVpxsPDSGJO9jiaZABFMhFbA/I1Bpi3PgiHx+h2MJNXfpN2SA2m0oEsoLUmChPjxJvS/RJ6jJXtDwW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609711; c=relaxed/simple;
	bh=ck8j5e5cRPglodxtFZ61BbVXb4ziI3Wl4Gdb1FBkwXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdsE3hxU/UIwdFeQwRvShXImB/xGky8S83aaBDIt6+mIdOgZZ/SLUp03Ibtz9PXY1rRVjIkX4f58bkM6JGPPnW4Z57ARsrCVn9yooZ2UyeQZ/9WjX1r93xddapudiyll2Osjb4t6uRRG8T/RzdhmAPqzhNx0tuXfFUm7WfbZEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxDqn5/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2DAC19423;
	Wed,  4 Mar 2026 07:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609711;
	bh=ck8j5e5cRPglodxtFZ61BbVXb4ziI3Wl4Gdb1FBkwXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxDqn5/sBd8jixNlkmxbXt6dqY5FFRhEsECF6I09Re0CRP4U6JgeR4cGXiwaRGofb
	 QHQqEaLFJwpqABKvvBr4PPYJQEm5EUeYEi44u3YsZTlDE8R6sDyLiIEtkfDGstqrzg
	 qQjvexW0PAli3wbXTDDOKFdRj9TkdAJiAywiVQvKPt1BQ1Ep2y9cJt94LmOXINm970
	 cSmGTcouKNrtqnM4ZMdiwUzGQIRO5t0qQ7V1FhKY/iztLFWJZHr0qHc76doy09Li2M
	 5HQ4BsDzyPxa8FPH3E7GL9BU6ePU3pKRbxXEgzc5XuOJk3MgbFS8B+cVTQPOc6K3De
	 W/4I+nN8vUVZg==
Date: Wed, 4 Mar 2026 08:35:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Abel Vesa <abelvesa@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: display: msm: Fix reg ranges and clocks
 on Glymur
Message-ID: <20260304-aloof-aboriginal-panda-00dbdb@quoll>
References: <20260303-glymur-fix-dp-bindings-reg-clocks-v4-1-1ebd9c7c2cee@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303-glymur-fix-dp-bindings-reg-clocks-v4-1-1ebd9c7c2cee@oss.qualcomm.com>
X-Rspamd-Queue-Id: 87FBE1FBA80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223004-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,linux.intel.com,suse.de,ffwll.ch,quicinc.com,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:03:11AM +0200, Abel Vesa wrote:
> The Glymur platform has four DisplayPort controllers. The hardware
> supports four streams (MST) per controller. However, on Glymur the first
> three controllers only have two streams wired to the display subsystem,
> while the fourth controller operates in single-stream mode.
> 
> Add a dedicated clause for the Glymur compatible to require the register
> ranges for all four stream blocks, while allowing either one pixel clock
> (for the single-stream controller) or two pixel clocks (for the remaining
> controllers).
> 
> Update the Glymur MDSS schema example by adding the missing p2, p3,
> mst2link and mst3link register blocks. Without these, the bindings
> validation fails. Also replace the made-up register addresses with the
> actual addresses from the first controller to match the SoC devicetree
> description.
> 
> Cc: stable@vger.kernel.org # v6.19
> Fixes: 8f63bf908213 ("dt-bindings: display: msm: Document the Glymur DiplayPort controller")
> Fixes: 1aee577bbc60 ("dt-bindings: display: msm: Document the Glymur Mobile Display SubSystem")
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Did not pick up Dmitry's R-b tag as patches have been squashed
> and commit message re-worded.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


